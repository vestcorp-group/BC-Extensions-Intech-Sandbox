codeunit 58001 "Sales Approval Events"//T12370-Full Comment //T12574-N
{
    Description = 'T50307';

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforeReopenSalesDoc, '', false, false)]
    local procedure "Release Sales Document_OnBeforeReopenSalesDoc"(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean; SkipWhseRequestOperations: Boolean)

    begin
        SalesHeader."HSN Code Approval" := false;
        SalesHeader."Country Of Origin Approval" := false;
        SalesHeader."Item Description Approval" := false;
        SalesHeader."Payment Terms Approval" := false;
        SalesHeader."Shipping Address Approval" := false;
        SalesHeader."Advance Payment Approval" := false;
        SalesHeader."Shipment Method Approval" := false;
        SalesHeader."Minimum Selling Price Approval" := false;
        SalesHeader."Minimum Initial Price Approval" := false;
        SalesHeader."Shorter Delivery Date Approval" := false;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCreateApprovalRequestsOnElseCase', '', false, false)]
    local procedure OnCreateApprovalRequestsOnElseCase(WorkflowStepArgument: Record "Workflow Step Argument"; var ApprovalEntryArgument: Record "Approval Entry");
    var
        UserSetup: Record "User Setup";
        RecSalesHeader: Record "Sales Header";
        ModSalesHeader: Record "Sales Header";
        SalesApproverUser: Record "Sales Approver User Setup";
        NoWFUserGroupMembersErr: Label 'A workflow user group with at least one member must be set up.';
        WFUserGroupNotInSetupErr: Label 'The workflow user group member with user ID %1 does not exist in the Approval User Setup window.', Comment = 'The workflow user group member with user ID NAVUser does not exist in the Approval User Setup window.';
        UserIdNotInSetupErr: Label 'User ID %1 does not exist in the Approval User Setup window.', Comment = 'User ID NAVUser does not exist in the Approval User Setup window.';
        ApproverId: Code[50];
        ApprovalMgmt: Codeunit "Approvals Mgmt.";
        SequenceNo: Integer;
        ApproverType: array[10] Of Option " ","Sales Credit Limit","Price Limit","Payment Terms","Order Value","Overdue","Price Comparision","Short Close","1st Level","2nd Level","Advance Payment";
        i: Integer;
        AmountLCY: Decimal;
        RecPT: Record "Payment Terms";
        Days: Integer;
        RecApproverSequenceBuffer: Record ApproverSequenceBuffer;
        TotalQty_lDec, ShortClosedQty_lDec, Perc_lDec : Decimal;   //T50307-N
        SL_lRec: Record "Sales Line";   //T50307-N
        FirstLevelApprovalNeeded_lBln: Boolean;
        SecondLevelApprovalNeeded_lBln: Boolean;
        Customer_lRec: Record Customer;
        Item_lRec: Record Item;
        PaymentTerms_lRec: Record "Payment Terms";
        AdvancePaymentApproval_lBln: Boolean;
        Itemvariant_lRec: Record "Item Variant";
    begin
        if not (ApprovalEntryArgument."Document Type" IN [ApprovalEntryArgument."Document Type"::Order, ApprovalEntryArgument."Document Type"::"Blanket Order", ApprovalEntryArgument."Document Type"::Quote, ApprovalEntryArgument."Document Type"::"Return Order"]) then exit;   //T50307-N //Added doc type return order

        if not UserSetup.Get(UserId) then
            Error(UserIdNotInSetupErr, UserId);

        RecApproverSequenceBuffer.DeleteAll();//@@@@@@@@@@Crealing buffer table

        Clear(RecSalesHeader);
        //UAT 16-12-2024 T12937

        //UAT 16-12-2024 T12937
        if ApprovalEntryArgument."Table ID" = 36 then begin  //T50306-NS
            RecSalesHeader.SetRange("No.", ApprovalEntryArgument."Document No.");//T50306-NS
            if not RecSalesHeader.FindFirst() then exit;//T50306-NS
            if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then begin
                RecSalesHeader.SetRange("Document Type", ApprovalEntryArgument."Document Type"::"Blanket Order");
                GetApproverTypeSequence('BSO', ApproverType);
            end
            else
                if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Order then begin
                    RecSalesHeader.SetRange("Document Type", ApprovalEntryArgument."Document Type"::Order);
                    GetApproverTypeSequence('SO', ApproverType);
                end else
                    //T50219-NS
                    if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Quote then begin
                        RecSalesHeader.SetRange("Document Type", ApprovalEntryArgument."Document Type"::Quote);
                        GetApproverTypeSequence('SQ', ApproverType);
                    end else
                        //T50219-NE
                        //T50307-NS
                        if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then begin
                            RecSalesHeader.SetRange("Document Type", ApprovalEntryArgument."Document Type"::"Return Order");
                            GetApproverTypeSequence('SRO', ApproverType);
                        end else
                            //T50307-NE
                            exit;

            RecSalesHeader.SetRange("No.", ApprovalEntryArgument."Document No.");
            if RecSalesHeader.FindFirst() then;
            AmountLCY := 0;
            RecSalesHeader.CalcFields("Amount Including VAT", "Price Change %", "Unit Price Difference");
            CalcPriceTypeInSalesHeader(RecSalesHeader);

            if RecSalesHeader."Currency Factor" <> 0 then
                AmountLCY := RecSalesHeader."Amount Including VAT" / RecSalesHeader."Currency Factor"
            else
                AmountLCY := RecSalesHeader."Amount Including VAT";


            //NG-NS 210125
            ModSalesHeader.Reset();
            ModSalesHeader.GET(RecSalesHeader."Document Type", RecSalesHeader."No.");
            FirstLevelApprovalNeeded_lBln := false;
            SecondLevelApprovalNeeded_lBln := false;
            IF RecSalesHeader."Document Type" IN [RecSalesHeader."Document Type"::Order, RecSalesHeader."Document Type"::"Blanket Order", RecSalesHeader."Document Type"::Quote] Then begin
                //Payment Terms
                Customer_lRec.GET(RecSalesHeader."Sell-to Customer No.");
                IF (Customer_lRec."Payment Terms Code" <> RecSalesHeader."Payment Terms Code") AND (Customer_lRec."Payment Terms Code" <> '') Then begin
                    FirstLevelApprovalNeeded_lBln := true;
                    SecondLevelApprovalNeeded_lBln := true;
                    ModSalesHeader."Payment Terms Approval" := true;
                end;

                //Sales Line Desc
                SL_lRec.Reset();
                SL_lRec.SetRange("Document Type", RecSalesHeader."Document Type");
                SL_lRec.SetRange("Document No.", RecSalesHeader."No.");
                SL_lRec.Setrange(Type, SL_lRec.Type::Item);
                SL_lRec.SetFilter(Quantity, '<>%1', 0);
                IF SL_lRec.FindSet() Then begin
                    repeat
                        Item_lRec.GET(SL_lRec."No.");

                        //Item-Variant HSNCode
                        if SL_lRec."Variant Code" <> '' then begin
                            Itemvariant_lRec.Reset();
                            Itemvariant_lRec.SetRange("Item No.", SL_lRec."No.");
                            Itemvariant_lRec.SetRange(Code, SL_lRec."Variant Code");
                            if Itemvariant_lRec.FindFirst() then begin
                                if Itemvariant_lRec.HSNCode <> SL_lRec.LineHSNCode then begin
                                    ModSalesHeader."HSN Code Approval" := true;
                                    FirstLevelApprovalNeeded_lBln := true;
                                end;

                                If Itemvariant_lRec.CountryOfOrigin <> SL_lRec.LineCountryOfOrigin then begin
                                    FirstLevelApprovalNeeded_lBln := true;
                                    ModSalesHeader."Country Of Origin Approval" := true;
                                end;

                                IF Itemvariant_lRec.Description <> SL_lRec.Description Then begin
                                    FirstLevelApprovalNeeded_lBln := true;
                                    ModSalesHeader."Item Description Approval" := true;
                                end;
                            end;
                        end else begin
                            if Item_lRec."HSN/SAC Code" <> SL_lRec.LineHSNCode then begin
                                ModSalesHeader."HSN Code Approval" := true;
                                FirstLevelApprovalNeeded_lBln := true;
                            end;

                            If Item_lRec."Country/Region of Origin Code" <> SL_lRec.LineCountryOfOrigin then begin
                                FirstLevelApprovalNeeded_lBln := true;
                                ModSalesHeader."Country Of Origin Approval" := true;
                            end;

                            IF Item_lRec.Description <> SL_lRec.Description Then begin
                                FirstLevelApprovalNeeded_lBln := true;
                                ModSalesHeader."Item Description Approval" := true;
                            end;
                        end;


                        //Delivery Date
                        IF (SL_lRec."Promised Delivery Date" <> 0D) AND (SL_lRec."Requested Delivery Date" <> 0D) Then begin
                            IF SL_lRec."Requested Delivery Date" < SL_lRec."Promised Delivery Date" then begin
                                FirstLevelApprovalNeeded_lBln := true;
                                ModSalesHeader."Shorter Delivery Date Approval" := true;
                            end;
                        end;
                        //IF (SL_lRec."Selling Price" <> 0) AND (SL_lRec."Unit Price" < SL_lRec."Selling Price") then begin
                        if (SL_lRec."Selling Price" <> 0) AND (SL_lRec."Unit Price Base UOM 2" < SL_lRec."Selling Price") then begin
                            FirstLevelApprovalNeeded_lBln := true;
                            ModSalesHeader."Minimum Selling Price Approval" := true;
                        end;



                        //IF (SL_lRec."Initial Price" <> 0) AND (SL_lRec."Unit Price" < SL_lRec."Initial Price") then begin
                        IF (SL_lRec."Initial Price" <> 0) AND (SL_lRec."Unit Price Base UOM 2" < SL_lRec."Initial Price") then begin
                            SecondLevelApprovalNeeded_lBln := true;
                            ModSalesHeader."Minimum Initial Price Approval" := true;
                        end;

                    until SL_lRec.Next() = 0;
                end;

                //Ship To Code      
                //T50307-NS RV      
                // IF (Customer_lRec."Ship-to Code" <> RecSalesHeader."Ship-to Code") AND (Customer_lRec."Ship-to Code" <> '') Then begin
                //     FirstLevelApprovalNeeded_lBln := true;
                // end;
                //T50307-NE RV

                //Ship To Code   
                //T50307-NS RV
                if RecSalesHeader."Custom Ship to Option" then begin
                    FirstLevelApprovalNeeded_lBln := true;
                    ModSalesHeader."Shipping Address Approval" := true;
                end;

                //AdvancePayment
                if RecSalesHeader."Payment Terms Code" <> '' then begin
                    PaymentTerms_lRec.Reset();
                    PaymentTerms_lRec.GET(RecSalesHeader."Payment Terms Code");
                    if PaymentTerms_lRec."Advance Payment" then begin
                        AdvancePaymentApproval_lBln := true;
                        ModSalesHeader."Advance Payment Approval" := true;
                    end;
                end;
                //T50307-NE RV

                //Shipment Code
                IF (Customer_lRec."Shipment Method Code" <> RecSalesHeader."Shipment Method Code") AND (Customer_lRec."Shipment Method Code" <> '') Then begin
                    FirstLevelApprovalNeeded_lBln := true;
                    ModSalesHeader."Shipment Method Approval" := true;
                end;
                ModSalesHeader.Modify();
            end;
            //NG-NE 210125

            //T50307-NS
            if RecSalesHeader."Short Close Approval Required" then begin
                FirstLevelApprovalNeeded_lBln := false;
                SecondLevelApprovalNeeded_lBln := false;
            end;
            //T50307-NE

            case WorkflowStepArgument."Approver Type" of
                WorkflowStepArgument."Approver Type"::"Customized Sales Approval":
                    begin
                        //for i := 1 to 6 do begin     //T50307-O
                        for i := 1 to 10 do begin    //T50307-N
                            if ApproverType[i] <> ApproverType[i] ::" " then begin

                                if ApproverType[i] = ApproverType[i] ::"Sales Credit Limit" then begin
                                    if RecSalesHeader."Short Close Approval Required" = false then begin
                                        if RecSalesHeader.CheckAvailableCreditLimit() < 0 then begin
                                            Clear(RecPT);
                                            IF RecPT.GET(RecSalesHeader."Payment Terms Code") THEN;
                                            if NOT (((RecPT."Advance Payment") AND (FORMAT(RecPT."Due Date Calculation") = '0D')) OR (RecPT.DL) OR (RecPT.LC)) then begin
                                                if ApprovalEntryArgument."Document Type" IN [ApprovalEntryArgument."Document Type"::Order, ApprovalEntryArgument."Document Type"::Quote, ApprovalEntryArgument."Document Type"::"Blanket Order"] then begin
                                                    if RecSalesHeader."Credit Limit Percentage" < 0 then begin
                                                        Clear(SalesApproverUser);
                                                        SalesApproverUser.SetCurrentKey("Sequence No.");
                                                        SalesApproverUser.SetAscending("Sequence No.", true);
                                                        if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then
                                                            SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Blanket Sales Order")
                                                        //T50219-NS
                                                        else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Quote then
                                                            SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Quote")
                                                        //T50219-NE
                                                        //T50307-NS
                                                        else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then
                                                            SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Return Order")
                                                        //T50307-NE
                                                        else
                                                            SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Order");



                                                        SalesApproverUser.SetRange(Type, SalesApproverUser.Type::"Sales Credit Limit");
                                                        SalesApproverUser.SetRange("Calculation Type", SalesApproverUser."Calculation Type"::Percentage);
                                                        SalesApproverUser.SetFilter("From Value", '<=%1', ABS(RecSalesHeader."Credit Limit Percentage"));
                                                        SalesApproverUser.SetFilter("To Value", '>=%1', ABS(RecSalesHeader."Credit Limit Percentage"));

                                                        if SalesApproverUser.FindSet() then begin
                                                            repeat
                                                                SalesApproverUser.TestField("Approver Type");
                                                                if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::User then
                                                                    ApproverId := SalesApproverUser."User Id"
                                                                else
                                                                    if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::Salesperson then
                                                                        ApproverId := GetSalesPersonUserId(RecSalesHeader)
                                                                    else
                                                                        ApproverId := GetManagerUserId(RecSalesHeader);

                                                                if not UserSetup.Get(ApproverId) then
                                                                    Error(WFUserGroupNotInSetupErr, ApproverId);

                                                                //SequenceNo := ApprovalMgmt.GetLastSequenceNo(ApprovalEntryArgument);
                                                                // if not IsSameApproverId(ApprovalEntryArgument, ApproverId) then
                                                                //     ApprovalMgmt.MakeApprovalEntry(ApprovalEntryArgument, SequenceNo + 1, ApproverId, WorkflowStepArgument);
                                                                InsertApproverBasedOnSequence(ApproverId, SalesApproverUser."Sequence No.");
                                                            until SalesApproverUser.Next() = 0;
                                                        end;


                                                        Clear(SalesApproverUser);
                                                        SalesApproverUser.SetCurrentKey("Sequence No.");
                                                        SalesApproverUser.SetAscending("Sequence No.", true);
                                                        if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then
                                                            SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Blanket Sales Order")
                                                        //T50219-NS
                                                        else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Quote then
                                                            SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Quote")
                                                        //T50219-NE
                                                        //T50307-NS
                                                        else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then
                                                            SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Return Order")
                                                        //T50307-NE
                                                        else
                                                            SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Order");

                                                        SalesApproverUser.SetRange(Type, SalesApproverUser.Type::"Sales Credit Limit");
                                                        SalesApproverUser.SetRange("Calculation Type", SalesApproverUser."Calculation Type"::Amount);
                                                        SalesApproverUser.SetFilter("From Value", '<=%1', ABS(RecSalesHeader."Available Credit Limit"));
                                                        SalesApproverUser.SetFilter("To Value", '>=%1', ABS(RecSalesHeader."Available Credit Limit"));

                                                        if SalesApproverUser.FindSet() then begin
                                                            repeat
                                                                SalesApproverUser.TestField("Approver Type");
                                                                if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::User then
                                                                    ApproverId := SalesApproverUser."User Id"
                                                                else
                                                                    if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::Salesperson then
                                                                        ApproverId := GetSalesPersonUserId(RecSalesHeader)
                                                                    else
                                                                        ApproverId := GetManagerUserId(RecSalesHeader);

                                                                if not UserSetup.Get(ApproverId) then
                                                                    Error(WFUserGroupNotInSetupErr, ApproverId);

                                                                // SequenceNo := ApprovalMgmt.GetLastSequenceNo(ApprovalEntryArgument);
                                                                // if not IsSameApproverId(ApprovalEntryArgument, ApproverId) then
                                                                //     ApprovalMgmt.MakeApprovalEntry(ApprovalEntryArgument, SequenceNo + 1, ApproverId, WorkflowStepArgument);
                                                                InsertApproverBasedOnSequence(ApproverId, SalesApproverUser."Sequence No.");

                                                            until SalesApproverUser.Next() = 0;
                                                        end;
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                end else
                                    if ApproverType[i] = ApproverType[i] ::"Price Limit" then begin
                                        if RecSalesHeader."Short Close Approval Required" = false then begin
                                            if RecSalesHeader."Price Change %" < 0 then begin
                                                Clear(SalesApproverUser);
                                                SalesApproverUser.SetCurrentKey("Sequence No.");
                                                SalesApproverUser.SetAscending("Sequence No.", true);
                                                if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then
                                                    SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Blanket Sales Order")
                                                //T50219-NS
                                                else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Quote then
                                                    SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Quote")
                                                //T50219-NE
                                                //T50307-NS
                                                else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then
                                                    SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Return Order")
                                                //T50307-NE
                                                else
                                                    SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Order");

                                                SalesApproverUser.SetRange(Type, SalesApproverUser.Type::"Price Limit");
                                                SalesApproverUser.SetRange("Calculation Type", SalesApproverUser."Calculation Type"::Percentage);
                                                SalesApproverUser.SetFilter("From Value", '<=%1', ABS(RecSalesHeader."Price Change %"));
                                                SalesApproverUser.SetFilter("To Value", '>=%1', ABS(RecSalesHeader."Price Change %"));
                                                if SalesApproverUser.FindSet() then begin
                                                    repeat
                                                        SalesApproverUser.TestField("Approver Type");
                                                        if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::User then
                                                            ApproverId := SalesApproverUser."User Id"
                                                        else
                                                            if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::Salesperson then
                                                                ApproverId := GetSalesPersonUserId(RecSalesHeader)
                                                            else
                                                                ApproverId := GetManagerUserId(RecSalesHeader);

                                                        if not UserSetup.Get(ApproverId) then
                                                            Error(WFUserGroupNotInSetupErr, ApproverId);

                                                        // SequenceNo := ApprovalMgmt.GetLastSequenceNo(ApprovalEntryArgument);
                                                        // if not IsSameApproverId(ApprovalEntryArgument, ApproverId) then
                                                        //     ApprovalMgmt.MakeApprovalEntry(ApprovalEntryArgument, SequenceNo + 1, ApproverId, WorkflowStepArgument);
                                                        InsertApproverBasedOnSequence(ApproverId, SalesApproverUser."Sequence No.");

                                                    until SalesApproverUser.Next() = 0;
                                                end else begin
                                                    //RecSalesHeader."Blanket Sales order No."
                                                    if RecSalesHeader."Price < Suggested But > Min." then begin
                                                        Clear(SalesApproverUser);
                                                        SalesApproverUser.SetCurrentKey("Sequence No.");
                                                        SalesApproverUser.SetAscending("Sequence No.", true);
                                                        if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then
                                                            SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Blanket Sales Order")
                                                        //T50219-NS
                                                        else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Quote then
                                                            SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Quote")
                                                        //T50219-NE
                                                        //T50307-NS
                                                        else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then
                                                            SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Return Order")
                                                        //T50307-NE
                                                        else
                                                            SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Order");

                                                        SalesApproverUser.SetRange(Type, SalesApproverUser.Type::"Price Comparision");
                                                        //SalesApproverUser.SetRange("Calculation Type", SalesApproverUser."Calculation Type"::Percentage);
                                                        // SalesApproverUser.SetFilter("From Value", '<%1', ABS(RecSalesHeader."Price Change %"));
                                                        // SalesApproverUser.SetFilter("To Value", '>=%1', ABS(RecSalesHeader."Price Change %"));
                                                        if SalesApproverUser.FindSet() then begin
                                                            repeat
                                                                SalesApproverUser.TestField("Approver Type");
                                                                if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::User then
                                                                    ApproverId := SalesApproverUser."User Id"
                                                                else
                                                                    if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::Salesperson then
                                                                        ApproverId := GetSalesPersonUserId(RecSalesHeader)
                                                                    else
                                                                        ApproverId := GetManagerUserId(RecSalesHeader);

                                                                if not UserSetup.Get(ApproverId) then
                                                                    Error(WFUserGroupNotInSetupErr, ApproverId);

                                                                // SequenceNo := ApprovalMgmt.GetLastSequenceNo(ApprovalEntryArgument);
                                                                // if not IsSameApproverId(ApprovalEntryArgument, ApproverId) then
                                                                //     ApprovalMgmt.MakeApprovalEntry(ApprovalEntryArgument, SequenceNo + 1, ApproverId, WorkflowStepArgument);
                                                                InsertApproverBasedOnSequence(ApproverId, SalesApproverUser."Sequence No.");
                                                            until SalesApproverUser.Next() = 0;
                                                        end;
                                                    end;
                                                end;
                                            end;
                                        end else begin
                                            if RecSalesHeader."Price < Suggested But > Min." then begin
                                                if RecSalesHeader."Short Close Approval Required" = false then begin
                                                    Clear(SalesApproverUser);
                                                    SalesApproverUser.SetCurrentKey("Sequence No.");
                                                    SalesApproverUser.SetAscending("Sequence No.", true);
                                                    if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then
                                                        SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Blanket Sales Order")
                                                    //T50219-NS
                                                    else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Quote then
                                                        SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Quote")
                                                    //T50219-NE
                                                    //T50307-NS
                                                    else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then
                                                        SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Return Order")
                                                    //T50307-NE
                                                    else
                                                        SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Order");

                                                    SalesApproverUser.SetRange(Type, SalesApproverUser.Type::"Price Comparision");
                                                    //SalesApproverUser.SetRange("Calculation Type", SalesApproverUser."Calculation Type"::Percentage);
                                                    // SalesApproverUser.SetFilter("From Value", '<%1', ABS(RecSalesHeader."Price Change %"));
                                                    // SalesApproverUser.SetFilter("To Value", '>=%1', ABS(RecSalesHeader."Price Change %"));
                                                    if SalesApproverUser.FindSet() then begin
                                                        repeat
                                                            SalesApproverUser.TestField("Approver Type");
                                                            if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::User then
                                                                ApproverId := SalesApproverUser."User Id"
                                                            else
                                                                if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::Salesperson then
                                                                    ApproverId := GetSalesPersonUserId(RecSalesHeader)
                                                                else
                                                                    ApproverId := GetManagerUserId(RecSalesHeader);

                                                            if not UserSetup.Get(ApproverId) then
                                                                Error(WFUserGroupNotInSetupErr, ApproverId);

                                                            // SequenceNo := ApprovalMgmt.GetLastSequenceNo(ApprovalEntryArgument);
                                                            // if not IsSameApproverId(ApprovalEntryArgument, ApproverId) then
                                                            //     ApprovalMgmt.MakeApprovalEntry(ApprovalEntryArgument, SequenceNo + 1, ApproverId, WorkflowStepArgument);
                                                            InsertApproverBasedOnSequence(ApproverId, SalesApproverUser."Sequence No.");

                                                        until SalesApproverUser.Next() = 0;
                                                    end;
                                                end;
                                            end;
                                        end;

                                    end else
                                        if ApproverType[i] = ApproverType[i] ::"Payment Terms" then begin
                                            //if (IsBSOAvailableInLine(RecSalesHeader) = false) OR (Format(RecSalesHeader."Excess Payment Terms Days") <> '0D') then begin
                                            if RecSalesHeader."Short Close Approval Required" = false then begin
                                                Clear(RecPT);
                                                IF RecPT.GET(RecSalesHeader."Payment Terms Code") THEN;
                                                Clear(SalesApproverUser);
                                                SalesApproverUser.SetCurrentKey("Sequence No.");
                                                SalesApproverUser.SetAscending("Sequence No.", true);
                                                if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then
                                                    SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Blanket Sales Order")
                                                //T50219-NS
                                                else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Quote then
                                                    SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Quote")
                                                //T50219-NE
                                                //T50307-NS
                                                else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then
                                                    SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Return Order")
                                                //T50307-NE
                                                else
                                                    SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Order");

                                                SalesApproverUser.SetRange(Type, SalesApproverUser.Type::"Payment Terms");
                                                SalesApproverUser.SetRange("Calculation Type", SalesApproverUser."Calculation Type"::Days);
                                                if RecPT."Advance Payment" then begin
                                                    SalesApproverUser.SetFilter("From Value", '=%1', 0);
                                                    SalesApproverUser.SetFilter("To Value", '=%1', 0);

                                                    if SalesApproverUser.FindSet() then begin
                                                        repeat
                                                            SalesApproverUser.TestField("Approver Type");
                                                            if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::User then
                                                                ApproverId := SalesApproverUser."User Id"
                                                            else
                                                                if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::Salesperson then
                                                                    ApproverId := GetSalesPersonUserId(RecSalesHeader)
                                                                else
                                                                    ApproverId := GetManagerUserId(RecSalesHeader);

                                                            if not UserSetup.Get(ApproverId) then
                                                                Error(WFUserGroupNotInSetupErr, ApproverId);

                                                            // SequenceNo := ApprovalMgmt.GetLastSequenceNo(ApprovalEntryArgument);
                                                            // if not IsSameApproverId(ApprovalEntryArgument, ApproverId) then
                                                            //     ApprovalMgmt.MakeApprovalEntry(ApprovalEntryArgument, SequenceNo + 1, ApproverId, WorkflowStepArgument);
                                                            InsertApproverBasedOnSequence(ApproverId, SalesApproverUser."Sequence No.");

                                                        until SalesApproverUser.Next() = 0;
                                                    end;
                                                end;
                                            end else
                                                if RecPT.DL then begin
                                                    if RecSalesHeader."Short Close Approval Required" = false then begin
                                                        SalesApproverUser.SetFilter("From Value", '=%1', -1);
                                                        SalesApproverUser.SetFilter("To Value", '=%1', -1);
                                                        if SalesApproverUser.FindSet() then begin
                                                            repeat
                                                                SalesApproverUser.TestField("Approver Type");
                                                                if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::User then
                                                                    ApproverId := SalesApproverUser."User Id"
                                                                else
                                                                    if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::Salesperson then
                                                                        ApproverId := GetSalesPersonUserId(RecSalesHeader)
                                                                    else
                                                                        ApproverId := GetManagerUserId(RecSalesHeader);

                                                                if not UserSetup.Get(ApproverId) then
                                                                    Error(WFUserGroupNotInSetupErr, ApproverId);

                                                                // SequenceNo := ApprovalMgmt.GetLastSequenceNo(ApprovalEntryArgument);
                                                                // if not IsSameApproverId(ApprovalEntryArgument, ApproverId) then
                                                                //     ApprovalMgmt.MakeApprovalEntry(ApprovalEntryArgument, SequenceNo + 1, ApproverId, WorkflowStepArgument);
                                                                InsertApproverBasedOnSequence(ApproverId, SalesApproverUser."Sequence No.");

                                                            until SalesApproverUser.Next() = 0;
                                                        end;
                                                    end;
                                                end else
                                                    if RecPT.LC then begin
                                                        if RecSalesHeader."Short Close Approval Required" = false then begin
                                                            SalesApproverUser.SetFilter("From Value", '=%1', -2);
                                                            SalesApproverUser.SetFilter("To Value", '=%1', -2);
                                                            if SalesApproverUser.FindSet() then begin
                                                                repeat
                                                                    SalesApproverUser.TestField("Approver Type");
                                                                    if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::User then
                                                                        ApproverId := SalesApproverUser."User Id"
                                                                    else
                                                                        if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::Salesperson then
                                                                            ApproverId := GetSalesPersonUserId(RecSalesHeader)
                                                                        else
                                                                            ApproverId := GetManagerUserId(RecSalesHeader);

                                                                    if not UserSetup.Get(ApproverId) then
                                                                        Error(WFUserGroupNotInSetupErr, ApproverId);

                                                                    // SequenceNo := ApprovalMgmt.GetLastSequenceNo(ApprovalEntryArgument);
                                                                    // if not IsSameApproverId(ApprovalEntryArgument, ApproverId) then
                                                                    //     ApprovalMgmt.MakeApprovalEntry(ApprovalEntryArgument, SequenceNo + 1, ApproverId, WorkflowStepArgument);
                                                                    InsertApproverBasedOnSequence(ApproverId, SalesApproverUser."Sequence No.");

                                                                until SalesApproverUser.Next() = 0;
                                                            end;

                                                        end;

                                                        // else begin
                                                        //if (RecSalesHeader."Document Type" = RecSalesHeader."Document Type"::"Blanket Order") OR (IsBSOAvailableInLine(RecSalesHeader) = false) then begin
                                                        if CalcDate(RecSalesHeader."Excess Payment Terms Days", WorkDate()) - WorkDate() > 0 then begin
                                                            SalesApproverUser.SetFilter("From Value", '<=%1', ABS(CalcDate(RecSalesHeader."Excess Payment Terms Days", WorkDate()) - WorkDate()));
                                                            SalesApproverUser.SetFilter("To Value", '>=%1', ABS(CalcDate(RecSalesHeader."Excess Payment Terms Days", WorkDate()) - WorkDate()));
                                                            if SalesApproverUser.FindSet() then begin
                                                                repeat
                                                                    SalesApproverUser.TestField("Approver Type");
                                                                    if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::User then
                                                                        ApproverId := SalesApproverUser."User Id"
                                                                    else
                                                                        if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::Salesperson then
                                                                            ApproverId := GetSalesPersonUserId(RecSalesHeader)
                                                                        else
                                                                            ApproverId := GetManagerUserId(RecSalesHeader);

                                                                    if not UserSetup.Get(ApproverId) then
                                                                        Error(WFUserGroupNotInSetupErr, ApproverId);

                                                                    // SequenceNo := ApprovalMgmt.GetLastSequenceNo(ApprovalEntryArgument);
                                                                    // if not IsSameApproverId(ApprovalEntryArgument, ApproverId) then
                                                                    //     ApprovalMgmt.MakeApprovalEntry(ApprovalEntryArgument, SequenceNo + 1, ApproverId, WorkflowStepArgument);
                                                                    InsertApproverBasedOnSequence(ApproverId, SalesApproverUser."Sequence No.");

                                                                until SalesApproverUser.Next() = 0;
                                                            end;
                                                        end;
                                                        //end;
                                                        /* else begin
                                                            if IsBSOAvailableInLine(RecSalesHeader) then begin
                                                                Days := BSOAndSODueDateCalculation(RecSalesHeader);
                                                                if Days > 0 then begin
                                                                    SalesApproverUser.SetFilter("From Value", '<=%1', Days);
                                                                    SalesApproverUser.SetFilter("To Value", '>=%1', Days);
                                                                    if SalesApproverUser.FindSet() then begin
                                                                        repeat
                                                                            SalesApproverUser.TestField("Approver Type");
                                                                            if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::User then
                                                                                ApproverId := SalesApproverUser."User Id"
                                                                            else
                                                                                if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::Salesperson then
                                                                                    ApproverId := GetSalesPersonUserId(RecSalesHeader)
                                                                                else
                                                                                    ApproverId := GetManagerUserId(RecSalesHeader);

                                                                            if not UserSetup.Get(ApproverId) then
                                                                                Error(WFUserGroupNotInSetupErr, ApproverId);

                                                                            // SequenceNo := ApprovalMgmt.GetLastSequenceNo(ApprovalEntryArgument);
                                                                            // if not IsSameApproverId(ApprovalEntryArgument, ApproverId) then
                                                                            //     ApprovalMgmt.MakeApprovalEntry(ApprovalEntryArgument, SequenceNo + 1, ApproverId, WorkflowStepArgument);
                                                                            InsertApproverBasedOnSequence(ApproverId, SalesApproverUser."Sequence No.");

                                                                        until SalesApproverUser.Next() = 0;
                                                                    end;
                                                                end;
                                                            end;

                                                        end;*/
                                                        // end;
                                                        //end;
                                                    end;
                                        end else
                                            if ApproverType[i] = ApproverType[i] ::"Order Value" then begin
                                                //if RecSalesHeader.CheckAvailableCreditLimit() < 0 then begin
                                                if RecSalesHeader."Short Close Approval Required" = false then begin
                                                    Clear(SalesApproverUser);
                                                    SalesApproverUser.SetCurrentKey("Sequence No.");
                                                    SalesApproverUser.SetAscending("Sequence No.", true);
                                                    if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then
                                                        SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Blanket Sales Order")
                                                    //T50219-NS
                                                    else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Quote then
                                                        SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Quote")
                                                    //T50219-NE
                                                    //T50307-NS
                                                    else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then
                                                        SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Return Order")
                                                    //T50307-NE
                                                    else
                                                        SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Order");
                                                    SalesApproverUser.SetRange(Type, SalesApproverUser.Type::"Order Value");
                                                    SalesApproverUser.SetRange("Calculation Type", SalesApproverUser."Calculation Type"::Amount);
                                                    SalesApproverUser.SetFilter("From Value", '<=%1', ABS(AmountLCY));
                                                    SalesApproverUser.SetFilter("To Value", '>=%1', ABS(AmountLCY));
                                                    if SalesApproverUser.FindSet() then begin
                                                        repeat
                                                            SalesApproverUser.TestField("Approver Type");
                                                            if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::User then
                                                                ApproverId := SalesApproverUser."User Id"
                                                            else
                                                                if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::Salesperson then
                                                                    ApproverId := GetSalesPersonUserId(RecSalesHeader)
                                                                else
                                                                    ApproverId := GetManagerUserId(RecSalesHeader);

                                                            if not UserSetup.Get(ApproverId) then
                                                                Error(WFUserGroupNotInSetupErr, ApproverId);

                                                            // SequenceNo := ApprovalMgmt.GetLastSequenceNo(ApprovalEntryArgument);
                                                            // if not IsSameApproverId(ApprovalEntryArgument, ApproverId) then
                                                            //     ApprovalMgmt.MakeApprovalEntry(ApprovalEntryArgument, SequenceNo + 1, ApproverId, WorkflowStepArgument);
                                                            InsertApproverBasedOnSequence(ApproverId, SalesApproverUser."Sequence No.");

                                                        until SalesApproverUser.Next() = 0;
                                                    end;
                                                    // end;
                                                end;
                                            end else
                                                if ApproverType[i] = ApproverType[i] ::Overdue then begin
                                                    if RecSalesHeader."Short Close Approval Required" = false then begin
                                                        if NOT (((RecPT."Advance Payment") AND (FORMAT(RecPT."Due Date Calculation") = '0D')) OR (RecPT.LC)) then begin
                                                            if IsOverdue(RecSalesHeader."Sell-to Customer No.") then begin
                                                                Clear(SalesApproverUser);
                                                                SalesApproverUser.SetCurrentKey("Sequence No.");
                                                                SalesApproverUser.SetAscending("Sequence No.", true);
                                                                if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then
                                                                    SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Blanket Sales Order")
                                                                //T50219-NS
                                                                else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Quote then
                                                                    SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Quote")
                                                                //T50219-NE
                                                                //T50307-NS
                                                                else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then
                                                                    SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Return Order")
                                                                //T50307-NE
                                                                else
                                                                    SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Order");
                                                                SalesApproverUser.SetRange(Type, SalesApproverUser.Type::Overdue);
                                                                //SalesApproverUser.SetRange("Calculation Type", SalesApproverUser."Calculation Type"::Days);
                                                                if SalesApproverUser.FindSet() then begin
                                                                    repeat
                                                                        SalesApproverUser.TestField("Approver Type");
                                                                        if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::User then
                                                                            ApproverId := SalesApproverUser."User Id"
                                                                        else
                                                                            if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::Salesperson then
                                                                                ApproverId := GetSalesPersonUserId(RecSalesHeader)
                                                                            else
                                                                                ApproverId := GetManagerUserId(RecSalesHeader);

                                                                        if not UserSetup.Get(ApproverId) then
                                                                            Error(WFUserGroupNotInSetupErr, ApproverId);

                                                                        // SequenceNo := ApprovalMgmt.GetLastSequenceNo(ApprovalEntryArgument);
                                                                        // if not IsSameApproverId(ApprovalEntryArgument, ApproverId) then
                                                                        //     ApprovalMgmt.MakeApprovalEntry(ApprovalEntryArgument, SequenceNo + 1, ApproverId, WorkflowStepArgument);
                                                                        InsertApproverBasedOnSequence(ApproverId, SalesApproverUser."Sequence No.");

                                                                    until SalesApproverUser.Next() = 0;
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                end else if ApproverType[i] = ApproverType[i] ::"Price Comparision" then begin
                                                    //RecSalesHeader."Blanket Sales order No."
                                                    if RecSalesHeader."Short Close Approval Required" = false then begin
                                                        if RecSalesHeader."Price < Suggested But > Min." then begin
                                                            Clear(SalesApproverUser);
                                                            SalesApproverUser.SetCurrentKey("Sequence No.");
                                                            SalesApproverUser.SetAscending("Sequence No.", true);
                                                            if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then
                                                                SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Blanket Sales Order")
                                                            //T50219-NS
                                                            else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Quote then
                                                                SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Quote")
                                                            //T50219-NE
                                                            //T50307-NS
                                                            else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then
                                                                SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Return Order")
                                                            //T50307-NE
                                                            else
                                                                SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Order");

                                                            SalesApproverUser.SetRange(Type, SalesApproverUser.Type::"Price Comparision");
                                                            //SalesApproverUser.SetRange("Calculation Type", SalesApproverUser."Calculation Type"::Percentage);
                                                            // SalesApproverUser.SetFilter("From Value", '<%1', ABS(RecSalesHeader."Price Change %"));
                                                            // SalesApproverUser.SetFilter("To Value", '>=%1', ABS(RecSalesHeader."Price Change %"));
                                                            if SalesApproverUser.FindSet() then begin
                                                                repeat
                                                                    SalesApproverUser.TestField("Approver Type");
                                                                    if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::User then
                                                                        ApproverId := SalesApproverUser."User Id"
                                                                    else
                                                                        if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::Salesperson then
                                                                            ApproverId := GetSalesPersonUserId(RecSalesHeader)
                                                                        else
                                                                            ApproverId := GetManagerUserId(RecSalesHeader);

                                                                    if not UserSetup.Get(ApproverId) then
                                                                        Error(WFUserGroupNotInSetupErr, ApproverId);

                                                                    // SequenceNo := ApprovalMgmt.GetLastSequenceNo(ApprovalEntryArgument);
                                                                    // if not IsSameApproverId(ApprovalEntryArgument, ApproverId) then
                                                                    //     ApprovalMgmt.MakeApprovalEntry(ApprovalEntryArgument, SequenceNo + 1, ApproverId, WorkflowStepArgument);
                                                                    InsertApproverBasedOnSequence(ApproverId, SalesApproverUser."Sequence No.");
                                                                until SalesApproverUser.Next() = 0;
                                                            end;
                                                        end;
                                                    end;
                                                    //T50307-NS
                                                end else if ApproverType[i] = ApproverType[i] ::"Short Close" then begin
                                                    if RecSalesHeader."Short Close Approval Required" then begin
                                                        Clear(Perc_lDec);
                                                        Clear(SL_lRec);
                                                        SL_lRec.SetRange("Document Type", RecSalesHeader."Document Type");
                                                        SL_lRec.SetRange("Document No.", RecSalesHeader."No.");
                                                        if SL_lRec.FindSet() then begin
                                                            SL_lRec.CalcSums(Quantity, "Outstanding Quantity");//YH
                                                            if SL_lRec.Quantity <> 0 then
                                                                Perc_lDec := SL_lRec."Outstanding Quantity" / SL_lRec.Quantity * 100;//YH
                                                        end;
                                                        if Perc_lDec <> 0 then begin
                                                            Clear(SalesApproverUser);
                                                            SalesApproverUser.SetCurrentKey("Sequence No.");
                                                            SalesApproverUser.SetAscending("Sequence No.", true);
                                                            if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then
                                                                SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Blanket Sales Order")
                                                            else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Quote then
                                                                SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Quote")
                                                            else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then
                                                                SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Return Order")
                                                            else
                                                                SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Order");

                                                            SalesApproverUser.SetRange(Type, SalesApproverUser.Type::"Short Close");
                                                            SalesApproverUser.SetRange("Calculation Type", SalesApproverUser."Calculation Type"::Percentage);
                                                            SalesApproverUser.SetFilter("From Value", '<=%1', ABS(Perc_lDec));
                                                            SalesApproverUser.SetFilter("To Value", '>%1', ABS(Perc_lDec));
                                                            if SalesApproverUser.FindSet() then begin
                                                                repeat
                                                                    SalesApproverUser.TestField("Approver Type");
                                                                    if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::User then
                                                                        ApproverId := SalesApproverUser."User Id"
                                                                    else
                                                                        if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::Salesperson then
                                                                            ApproverId := GetSalesPersonUserId(RecSalesHeader)
                                                                        else
                                                                            ApproverId := GetManagerUserId(RecSalesHeader);

                                                                    if not UserSetup.Get(ApproverId) then
                                                                        Error(WFUserGroupNotInSetupErr, ApproverId);

                                                                    InsertApproverBasedOnSequence(ApproverId, SalesApproverUser."Sequence No.");
                                                                until SalesApproverUser.Next() = 0;
                                                            end;
                                                        end;
                                                    end;
                                                    //T50307-NE
                                                end else if ApproverType[i] = ApproverType[i] ::"1st Level" then begin
                                                    if (FirstLevelApprovalNeeded_lBln) then begin
                                                        Clear(SalesApproverUser);
                                                        SalesApproverUser.SetCurrentKey("Sequence No.");
                                                        SalesApproverUser.SetAscending("Sequence No.", true);
                                                        if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then
                                                            SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Blanket Sales Order")
                                                        else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Quote then
                                                            SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Quote")
                                                        else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then
                                                            SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Return Order")
                                                        else
                                                            SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Order");

                                                        SalesApproverUser.SetRange(Type, SalesApproverUser.Type::"1st Level");
                                                        if SalesApproverUser.FindSet() then begin
                                                            repeat
                                                                SalesApproverUser.TestField("Approver Type");
                                                                if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::User then
                                                                    ApproverId := SalesApproverUser."User Id"
                                                                else
                                                                    if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::Salesperson then
                                                                        ApproverId := GetSalesPersonUserId(RecSalesHeader)
                                                                    else
                                                                        ApproverId := GetManagerUserId(RecSalesHeader);

                                                                if not UserSetup.Get(ApproverId) then
                                                                    Error(WFUserGroupNotInSetupErr, ApproverId);

                                                                InsertApproverBasedOnSequence(ApproverId, SalesApproverUser."Sequence No.");
                                                            until SalesApproverUser.Next() = 0;
                                                        end;
                                                    end;
                                                    //T50307-NE
                                                end else if ApproverType[i] = ApproverType[i] ::"2nd Level" then begin
                                                    if SecondLevelApprovalNeeded_lBln then begin
                                                        Clear(SalesApproverUser);
                                                        SalesApproverUser.SetCurrentKey("Sequence No.");
                                                        SalesApproverUser.SetAscending("Sequence No.", true);
                                                        if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then
                                                            SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Blanket Sales Order")
                                                        else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Quote then
                                                            SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Quote")
                                                        else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then
                                                            SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Return Order")
                                                        else
                                                            SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Order");

                                                        SalesApproverUser.SetRange(Type, SalesApproverUser.Type::"2nd Level");
                                                        if SalesApproverUser.FindSet() then begin
                                                            repeat
                                                                SalesApproverUser.TestField("Approver Type");
                                                                if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::User then
                                                                    ApproverId := SalesApproverUser."User Id"
                                                                else
                                                                    if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::Salesperson then
                                                                        ApproverId := GetSalesPersonUserId(RecSalesHeader)
                                                                    else
                                                                        ApproverId := GetManagerUserId(RecSalesHeader);

                                                                if not UserSetup.Get(ApproverId) then
                                                                    Error(WFUserGroupNotInSetupErr, ApproverId);

                                                                InsertApproverBasedOnSequence(ApproverId, SalesApproverUser."Sequence No.");
                                                            until SalesApproverUser.Next() = 0;
                                                        end;
                                                    end;
                                                    //T50307-NE
                                                end else if ApproverType[i] = ApproverType[i] ::"Advance Payment" then begin
                                                    if RecSalesHeader."Short Close Approval Required" = false then begin
                                                        if AdvancePaymentApproval_lBln then begin
                                                            Clear(SalesApproverUser);
                                                            SalesApproverUser.SetCurrentKey("Sequence No.");
                                                            SalesApproverUser.SetAscending("Sequence No.", true);
                                                            if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then
                                                                SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Blanket Sales Order")
                                                            else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Quote then
                                                                SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Quote")
                                                            else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then
                                                                SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Return Order")
                                                            else
                                                                SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Order");

                                                            SalesApproverUser.SetRange(Type, SalesApproverUser.Type::"Advance Payment");
                                                            if SalesApproverUser.FindSet() then begin
                                                                repeat
                                                                    SalesApproverUser.TestField("Approver Type");
                                                                    if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::User then
                                                                        ApproverId := SalesApproverUser."User Id"
                                                                    else
                                                                        if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::Salesperson then
                                                                            ApproverId := GetSalesPersonUserId(RecSalesHeader)
                                                                        else
                                                                            ApproverId := GetManagerUserId(RecSalesHeader);

                                                                    if not UserSetup.Get(ApproverId) then
                                                                        Error(WFUserGroupNotInSetupErr, ApproverId);

                                                                    InsertApproverBasedOnSequence(ApproverId, SalesApproverUser."Sequence No.");
                                                                until SalesApproverUser.Next() = 0;
                                                            end;
                                                        end;
                                                    end;
                                                    //T50307-NE
                                                end;
                                //  else
                                //     if ApproverType[1] = ApproverType[1] ::"Price Comparision" then begin
                                //         if RecSalesHeader."Price < Suggested But > Min." then begin
                                //             SalesApproverUser.SetRange("Calculation Type", SalesApproverUser."Calculation Type"::Days);
                                //         end;
                                //     end;

                            end else begin
                                if (RecSalesHeader."Document Type" = RecSalesHeader."Document Type"::"Return Order") OR (RecSalesHeader."Document Type" = RecSalesHeader."Document Type"::Order) or
                                (RecSalesHeader."Document Type" = RecSalesHeader."Document Type"::"Blanket Order") or (RecSalesHeader."Document Type" = RecSalesHeader."Document Type"::Quote) then begin
                                    if RecSalesHeader."Short Close Approval Required" = false then begin  //T50307-N
                                        Clear(SalesApproverUser);
                                        SalesApproverUser.SetCurrentKey("Sequence No.");
                                        SalesApproverUser.SetAscending("Sequence No.", true);
                                        // if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then
                                        //     SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Blanket Sales Order")
                                        // else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Quote then
                                        //     SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Quote")
                                        // else
                                        // SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Order");
                                        if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then
                                            SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Blanket Sales Order")
                                        else
                                            if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Order" then
                                                SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Order")
                                            else
                                                if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then
                                                    SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Return Order")
                                                else
                                                    if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Quote then
                                                        SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Quote");


                                        SalesApproverUser.SetRange(Type, SalesApproverUser.Type::" ");
                                        if SalesApproverUser.FindSet() then begin
                                            repeat
                                                SalesApproverUser.TestField("Approver Type");
                                                if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::User then
                                                    ApproverId := SalesApproverUser."User Id"
                                                else
                                                    if SalesApproverUser."Approver Type" = SalesApproverUser."Approver Type"::Salesperson then
                                                        ApproverId := GetSalesPersonUserId(RecSalesHeader)
                                                    else
                                                        ApproverId := GetManagerUserId(RecSalesHeader);

                                                if not UserSetup.Get(ApproverId) then
                                                    Error(WFUserGroupNotInSetupErr, ApproverId);

                                                InsertApproverBasedOnSequence(ApproverId, SalesApproverUser."Sequence No.");
                                            until SalesApproverUser.Next() = 0;
                                        end;
                                    end;
                                end;
                            end;
                        end;

                        Clear(RecApproverSequenceBuffer);
                        RecApproverSequenceBuffer.SetCurrentKey(Sequence);
                        RecApproverSequenceBuffer.SetAscending(Sequence, true);
                        if RecApproverSequenceBuffer.FindSet() then begin
                            repeat
                                SequenceNo := ApprovalMgmt.GetLastSequenceNo(ApprovalEntryArgument);
                                if not IsSameApproverId(ApprovalEntryArgument, RecApproverSequenceBuffer."Approver ID") then
                                    ApprovalMgmt.MakeApprovalEntry(ApprovalEntryArgument, SequenceNo + 1, RecApproverSequenceBuffer."Approver ID", WorkflowStepArgument);
                            until RecApproverSequenceBuffer.Next() = 0;
                        end Else begin
                            //Self Approval
                            SequenceNo := ApprovalMgmt.GetLastSequenceNo(ApprovalEntryArgument);
                            if not IsSameApproverId(ApprovalEntryArgument, UserId) then
                                ApprovalMgmt.MakeApprovalEntry(ApprovalEntryArgument, SequenceNo + 1, UserId, WorkflowStepArgument);
                        end;
                    end;
            end;
        end;
    end;

    local procedure InsertApproverBasedOnSequence(ApproverId: code[100]; seq: Integer)
    var
        RecAppSeq: Record ApproverSequenceBuffer;
    begin
        RecAppSeq.Init();
        RecAppSeq."Approver ID" := ApproverId;
        RecAppSeq.Sequence := seq;
        if RecAppSeq.Insert() then;
    end;

    local procedure GetManagerUserId(var RecSalesHeader: Record "Sales Header"): Text
    var
        RecTeams: Record Team;
        RecTeamSalesPerson: Record "Team Salesperson";
        TeamManagerSalesPerson: Record "Team Salesperson";
        UserSetup: Record "User Setup";
    begin
        Clear(RecteamSalesPerson);
        RecteamSalesPerson.SetRange("Salesperson Code", RecSalesHeader."Salesperson Code");
        RecteamSalesPerson.FindFirst();
        Clear(TeamManagerSalesPerson);
        TeamManagerSalesPerson.SetRange("Team Code", RecTeamSalesPerson."Team Code");
        TeamManagerSalesPerson.SetRange(Manager, true);
        TeamManagerSalesPerson.FindFirst();
        Clear(UserSetup);
        UserSetup.SetRange("Salespers./Purch. Code", TeamManagerSalesPerson."Salesperson Code");
        UserSetup.SetFilter("E-Mail", '<>%1', '');
        if UserSetup.FindFirst() then;
        exit(UserSetup."User ID");
    end;

    local procedure GetSalesPersonUserId(var RecSalesHeader: Record "Sales Header"): Text
    var
        RecTeams: Record Team;
        RecTeamSalesPerson: Record "Team Salesperson";
        TeamManagerSalesPerson: Record "Team Salesperson";
        UserSetup: Record "User Setup";
    begin
        RecSalesHeader.TestField("Salesperson Code");
        Clear(UserSetup);
        UserSetup.SetRange("Salespers./Purch. Code", RecSalesHeader."Salesperson Code");
        UserSetup.SetFilter("E-Mail", '<>%1', '');
        if UserSetup.FindFirst() then;
        exit(UserSetup."User ID");
    end;

    local procedure IsBSOAvailableInLine(var RecSalesHeader: Record "Sales Header"): Boolean
    var
        RecLines: Record "Sales Line";
    begin
        Clear(RecLines);
        RecLines.SetRange("Document Type", RecSalesHeader."Document Type");
        RecLines.SetRange("Document No.", RecSalesHeader."No.");
        RecLines.SetFilter("Blanket Order No.", '<>%1', '');
        exit(RecLines.FindFirst());
    end;

    local procedure BSOAndSODueDateCalculation(var RecSalesHeader: Record "Sales Header"): Integer
    var
        RecLines: Record "Sales Line";
        RecHdr: Record "Sales Header";
        RecPT: Record "Payment Terms";
        RecPT2: Record "Payment Terms";
        Days: Integer;
    begin
        Clear(RecLines);
        RecLines.SetRange("Document Type", RecSalesHeader."Document Type");
        RecLines.SetRange("Document No.", RecSalesHeader."No.");
        RecLines.SetFilter("Blanket Order No.", '<>%1', '');
        if RecLines.FindFirst() then begin
            Clear(RecHdr);
            RecHdr.SetRange("Document Type", RecHdr."Document Type"::"Blanket Order");
            RecHdr.SetRange("No.", RecLines."Blanket Order No.");
            if RecHdr.FindFirst() then begin
                Clear(RecPT);
                RecPT.GET(RecHdr."Payment Terms Code");
                Clear(RecPT2);
                RecPT2.GET(RecSalesHeader."Payment Terms Code");
                Days := CalcDate(RecPT2."Due Date Calculation", WorkDate()) - CalcDate(RecPT."Due Date Calculation", WorkDate());
                exit(Days);
            end else
                exit(0);
        end else
            exit(0);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order", OnAfterValidateShippingOptions, '', false, false)]
    local procedure "Sales Order_OnAfterValidateShippingOptions"(var SalesHeader: Record "Sales Header"; ShipToOptions: Option)
    begin
        if ShipToOptions = 2 then
            SalesHeader."Custom Ship to Option" := true
        else
            SalesHeader."Custom Ship to Option" := false;

        SalesHeader.Modify();

    end;


    local procedure GetApproverTypeSequence(WorkflowType: code[20]; var ApproverType: array[10] Of Option " ","Sales Credit Limit","Price Limit","Payment Terms","Order Value","Overdue","Price Comparision")
    var
        SalesApproverUser: Record "Sales Approver User Setup";
        checklist: List of [Text];
        i: Integer;
    begin
        Clear(SalesApproverUser);
        // SalesApproverUser.SetCurrentKey("Sequence No.");
        // SalesApproverUser.SetAscending("Sequence No.", true);
        SalesApproverUser.SetCurrentKey("Workflow Priority");
        SalesApproverUser.SetAscending("Workflow Priority", true);
        if WorkflowType = 'SO' then
            SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Order")
        else if WorkflowType = 'SQ' then
            SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Quote")
        else
            if WorkflowType = 'BSO' then
                SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Blanket Sales Order")
            else if WorkflowType = 'SRO' then   //T50307-NS
                SalesApproverUser.SetRange("Document Type", SalesApproverUser."Document Type"::"Sales Return Order");

        if SalesApproverUser."Document Type" <> SalesApproverUser."Document Type"::"Sales Return Order" then
            //T50307-NE
            SalesApproverUser.SetFilter(Type, '<>%1', SalesApproverUser.Type::" ");
        Clear(checklist);
        i := 1;
        if SalesApproverUser.FindSet() then begin
            repeat
                if not checklist.Contains(Format(SalesApproverUser."Document Type") + Format(SalesApproverUser.Type) + Format(SalesApproverUser."Workflow Priority")) then begin
                    checklist.Add(Format(SalesApproverUser."Document Type") + Format(SalesApproverUser.Type) + Format(SalesApproverUser."Workflow Priority"));
                    ApproverType[i] := SalesApproverUser.Type;
                    i += 1;
                end;
            until SalesApproverUser.Next() = 0;
        end;
    end;


    procedure IsSameApproverId(ApprovalEntryArgument: Record "Approval Entry"; ApproverId: Code[50]) Result: Boolean
    var
        ApprovalEntry: Record "Approval Entry";
    begin
        Result := false;
        ApprovalEntry.SetCurrentKey("Record ID to Approve", "Workflow Step Instance ID", "Sequence No.");
        ApprovalEntry.SetRange("Table ID", ApprovalEntryArgument."Table ID");
        ApprovalEntry.SetRange("Record ID to Approve", ApprovalEntryArgument."Record ID to Approve");
        ApprovalEntry.SetRange("Workflow Step Instance ID", ApprovalEntryArgument."Workflow Step Instance ID");
        ApprovalEntry.SetRange("Approver ID", ApproverId);
        if ApprovalEntry.FindFirst() then
            Result := true;
    end;

    local procedure IsOverdue(CustomerCode: Code[20]): Boolean
    var
        CLE: Record "Cust. Ledger Entry";
    begin
        Clear(CLE);
        CLE.SetRange("Customer No.", CustomerCode);
        CLE.SetRange(Open, true);
        CLE.SetRange("Document Type", CLE."Document Type"::Invoice);
        CLE.SetFilter("Due Date", '..%1', Today());
        exit(CLE.FindFirst())
    end;

    local procedure CalcPriceTypeInSalesHeader(Var Sheader: Record "Sales Header")
    var
        Sline: Record "Sales Line";
    begin
        Sheader."Price < Suggested But > Min." := false;
        Clear(Sline);
        Sline.SetRange("Document Type", Sheader."Document Type");
        Sline.SetRange("Document No.", Sheader."No.");
        Sline.SetRange(Type, Sline.Type::Item);
        if Sline.FindSet() then begin
            repeat
                if (Sline."Unit Price Base UOM 2" < Sline."Selling Price") AND (Sline."Unit Price Base UOM 2" > Sline."Initial Price") then begin
                    Sheader."Price < Suggested But > Min." := true;
                end;
            until Sline.Next() = 0;
        end;
        Sheader.Modify();
    end;

    procedure UpdateWorkflowPriority(var Rec: Record "Sales Approver User Setup"): Integer
    var
        RecSalesApproval: Record "Sales Approver User Setup";
    begin
        if (Rec."Document Type" = Rec."Document Type"::" ") OR (Rec.Type = Rec.Type::" ") then
            exit(0);

        Clear(RecSalesApproval);
        RecSalesApproval.SetRange("Document Type", Rec."Document Type");
        RecSalesApproval.SetRange(Type, Rec.Type);
        RecSalesApproval.SetFilter("Workflow Priority", '<>%1', 0);
        if RecSalesApproval.FindFirst() then
            exit(RecSalesApproval."Workflow Priority")
        else
            exit(0);
    end;


}

