codeunit 58002 "Purchase Approval Events"//T50306
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", OnBeforeReopenPurchaseDoc, '', false, false)]
    local procedure "Release Purchase Document_OnBeforeReopenPurchaseDoc"(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var IsHandled: Boolean; SkipWhseRequestOperations: Boolean)
    begin
        PurchaseHeader."Payment Worsen" := false;
        PurchaseHeader."Price Comparison" := false;
        PurchaseHeader."New Product" := false;
        PurchaseHeader."Limit Payable" := false;
        PurchaseHeader."Short Close Qty < 5" := false;
        PurchaseHeader."Short Close Qty > 5" := false;
        PurchaseHeader.OverDue := false;
        PurchaseHeader."ShortClose Approval" := false;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnCreateApprovalRequestsOnElseCase, '', true, true)]
    local procedure OnCreateApprovalRequestsOnElseCase(WorkflowStepArgument: Record "Workflow Step Argument"; var ApprovalEntryArgument: Record "Approval Entry")
    var
        UserSetup_lRec: Record "User Setup";
        UserIdNotInSetupErr: Label 'User ID %1 does not exist in the Approval User Setup window.', Comment = 'User ID NAVUser does not exist in the Approval User Setup window.';
        RecApproverSequenceBuffer: Record ApproverSequenceBuffer;
        PurchaseHeader_lRec: Record "Purchase Header";
        ApproverType: array[10] Of Text;// " ",PaymentTerms,"Price Comparision","New Product","limit Payable","Shortclose Quantity < 5","ShortClose Quantity > 5",Overdue;
        AmountLCY_lDec: Decimal;
        i: Integer;
        PaymentTerms_lRec: Record "Payment Terms";
        Vendor_lRec: Record Vendor;
        // DueDateCalculationVendor_lDt: Date;
        //DueDatecalculationOrder_lDt: Date;
        PurchaseApprovalUserSetup_lRec: Record "Purchase Approver User Setup";
        PurchaseApprovalUserSetup1_lRec: Record "Purchase Approver User Setup";
        FilterTransacTypr_lBln: Boolean;
        ApproverID_lCod: Code[50];
        WFUserGroupNotInSetupErr: Label 'The workflow user group member with user ID %1 does not exist in the Approval User Setup window.', Comment = 'The workflow user group member with user ID NAVUser does not exist in the Approval User Setup window.';
        PurchaseHdr_lRec: Record "Purchase Header";
        Amount1_lDec: Decimal;
        Amount2_lDec: Decimal;
        HighAmount_lBln: Boolean;
        PurchaseLine_lRec: Record "Purchase Line";
        ItemVendor_lRec: Record "Item Vendor";
        NewProduct_lBln: Boolean;
        Percent_lDec: Decimal;
        SequenceNo_lInt: Integer;
        ApprovalMgmt_lCdu: Codeunit "Approvals Mgmt.";
        PurchApproveUser_lRec: Record "Purchase Approver User Setup";
        PaymentCode1_lCod: Code[20];
        PaymentCode2_lCod: Code[20];
        PurchaseInvoiceHeader_lRec: Record "Purch. Inv. Header";
        PurchaseInvoiceLine_lRec: Record "Purch. Inv. Line";
        CurrencyExchRatePO_lRec: Record "Currency Exchange Rate";
        CurrencyExchRateSET_lRec: Record "Currency Exchange Rate";
        CurrencyExchRatePOAMT_lDec: Decimal;
        CurrencyExchRateSETAMT_lDec: Decimal;
    begin
        if not (ApprovalEntryArgument."Document Type" IN [ApprovalEntryArgument."Document Type"::Order, ApprovalEntryArgument."Document Type"::"Blanket Order", ApprovalEntryArgument."Document Type"::Quote, ApprovalEntryArgument."Document Type"::"Return Order"]) then exit;   //T50307-N //Added doc type return order

        if not UserSetup_lRec.Get(UserId) then
            Error(UserIdNotInSetupErr, UserId);

        RecApproverSequenceBuffer.DeleteAll();//@@@@@@@@@@Crealing buffer table
        if ApprovalEntryArgument."Table ID" = 38 then begin
            Clear(PurchaseHeader_lRec);
            PurchaseHeader_lRec.SetRange("No.", ApprovalEntryArgument."Document No.");
            if not PurchaseHeader_lRec.FindFirst() then
                exit;

            if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then begin
                PurchaseHeader_lRec.SetRange("Document Type", ApprovalEntryArgument."Document Type"::"Blanket Order");
                PurchApproveUser_lRec.SetRange("Document Type", PurchApproveUser_lRec."Document Type"::"Blanket Purchase Order");
                // GetApproverTypeSequence('BPO', ApproverType);
            end
            else
                if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Order then begin
                    PurchaseHeader_lRec.SetRange("Document Type", ApprovalEntryArgument."Document Type"::Order);
                    PurchApproveUser_lRec.SetRange("Document Type", PurchApproveUser_lRec."Document Type"::"Purchase Order");
                    //   GetApproverTypeSequence('PO', ApproverType);
                end else
                    if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then begin
                        PurchaseHeader_lRec.SetRange("Document Type", ApprovalEntryArgument."Document Type"::"Return Order");
                        PurchApproveUser_lRec.SetRange("Document Type", PurchApproveUser_lRec."Document Type"::"Purchase Return Order");
                        //  GetApproverTypeSequence('PRO', ApproverType);
                    end else
                        exit;
            PurchaseHeader_lRec.Reset();
            PurchaseHeader_lRec.SetRange("No.", ApprovalEntryArgument."Document No.");
            if PurchaseHeader_lRec.FindFirst() then;

            AmountLCY_lDec := 0;
            PurchaseHeader_lRec.CalcFields("Amount Including VAT");
            if PurchaseHeader_lRec."Currency Factor" <> 0 then
                AmountLCY_lDec := PurchaseHeader_lRec."Amount Including VAT" / PurchaseHeader_lRec."Currency Factor"
            else
                AmountLCY_lDec := PurchaseHeader_lRec."Amount Including VAT";
            case WorkflowStepArgument."Approver Type" of
                WorkflowStepArgument."Approver Type"::"Customized Sales Approval":
                    begin
                        if PurchApproveUser_lRec.FindSet() then begin
                            repeat
                                //YH NS
                                FilterTransacTypr_lBln := false;
                                PurchaseApprovalUserSetup1_lRec.Reset();
                                if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then
                                    PurchaseApprovalUserSetup1_lRec.SetRange("Document Type", PurchaseApprovalUserSetup1_lRec."Document Type"::"Blanket Purchase Order")
                                else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Order then
                                    PurchaseApprovalUserSetup1_lRec.SetRange("Document Type", PurchaseApprovalUserSetup1_lRec."Document Type"::"Purchase Order")
                                else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then
                                    PurchaseApprovalUserSetup1_lRec.SetRange("Document Type", PurchaseApprovalUserSetup1_lRec."Document Type"::"Purchase Return Order");
                                PurchaseApprovalUserSetup1_lRec.Setfilter("Transaction Type", '<>%1', '');
                                if PurchaseApprovalUserSetup1_lRec.FindFirst() then
                                    FilterTransacTypr_lBln := true;
                                //YH NE - As per requested by SARA
                                //for i := 1 to 7 do begin
                                if PurchApproveUser_lRec."Type" <> PurchApproveUser_lRec.Type::" " then
                                    if not PurchaseHeader_lRec."ShortClose Approval" then begin
                                        if PurchApproveUser_lRec."Type" = PurchApproveUser_lRec.Type::PaymentTerms then begin
                                            if Vendor_lRec.Get(PurchaseHeader_lRec."Buy-from Vendor No.") then begin
                                                if PaymentTerms_lRec.Get(Vendor_lRec."Payment Terms Code") then
                                                    PaymentCode1_lCod := PaymentTerms_lRec.Code;
                                                // DueDateCalculationVendor_lDt := CalcDate(PaymentTerms_lRec."Due Date Calculation", WorkDate());

                                                clear(PaymentTerms_lRec);
                                                if PaymentTerms_lRec.Get(PurchaseHeader_lRec."Payment Terms Code") then
                                                    PaymentCode2_lCod := PaymentTerms_lRec.Code;
                                                // DueDatecalculationOrder_lDt := CalcDate(PaymentTerms_lRec."Due Date Calculation", WorkDate());

                                                if PaymentCode1_lCod <> PaymentCode2_lCod then begin
                                                    clear(PurchaseApprovalUserSetup_lRec);
                                                    PurchaseApprovalUserSetup_lRec.SetCurrentKey("Sequence No.");
                                                    if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then
                                                        PurchaseApprovalUserSetup_lRec.SetRange("Document Type", PurchaseApprovalUserSetup_lRec."Document Type"::"Blanket Purchase Order")
                                                    else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Order then
                                                        PurchaseApprovalUserSetup_lRec.SetRange("Document Type", PurchaseApprovalUserSetup_lRec."Document Type"::"Purchase Order")
                                                    else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then
                                                        PurchaseApprovalUserSetup_lRec.SetRange("Document Type", PurchaseApprovalUserSetup_lRec."Document Type"::"Purchase Return Order");

                                                    PurchaseApprovalUserSetup_lRec.SetRange(Type, PurchaseApprovalUserSetup_lRec.Type::"PaymentTerms");
                                                    if FilterTransacTypr_lBln then
                                                        PurchaseApprovalUserSetup_lRec.SetRange("Transaction Type", PurchaseHeader_lRec."Transaction Type");
                                                    //  PurchaseApprovalUserSetup_lRec.SetRange("Calculation Type", PurchaseApprovalUserSetup_lRec."Calculation Type"::Days);
                                                    if PurchaseApprovalUserSetup_lRec.FindSet() then
                                                        repeat
                                                            PurchaseApprovalUserSetup_lRec.TestField("Approver Type");
                                                            if PurchaseApprovalUserSetup_lRec."Approver Type" = PurchaseApprovalUserSetup_lRec."Approver Type"::User then
                                                                ApproverId_lCod := PurchaseApprovalUserSetup_lRec."User Id"
                                                            else
                                                                if PurchaseApprovalUserSetup_lRec."Approver Type" = PurchaseApprovalUserSetup_lRec."Approver Type"::Salesperson then
                                                                    ApproverId_lCod := GetSalesPersonUserId(PurchaseHeader_lRec)
                                                                else
                                                                    ApproverId_lCod := GetManagerUserId(PurchaseHeader_lRec);

                                                            if not UserSetup_lRec.Get(ApproverID_lCod) then
                                                                Error(WFUserGroupNotInSetupErr, ApproverId_lCod);
                                                            InsertApproverBasedOnSequence(ApproverID_lCod, PurchaseApprovalUserSetup_lRec."Sequence No.");
                                                        until PurchaseApprovalUserSetup_lRec.Next() = 0;
                                                end;
                                            end;

                                        end else
                                            if PurchApproveUser_lRec."Type" = PurchApproveUser_lRec.Type::"Price Comparision" then begin
                                                clear(Amount1_lDec);
                                                PurchaseHeader_lRec.CalcFields("Amount Including VAT");
                                                Amount1_lDec := PurchaseHeader_lRec."Amount Including VAT";
                                                clear(HighAmount_lBln);
                                                PurchaseInvoiceHeader_lRec.Reset();
                                                PurchaseInvoiceHeader_lRec.SetAscending("No.", true);
                                                // PurchaseInvoiceHeader_lRec.SetFilter("No.", '<>%1', ApprovalEntryArgument."Document No.");
                                                PurchaseInvoiceHeader_lRec.SetRange("Buy-from Vendor No.", PurchaseHeader_lRec."Buy-from Vendor No.");
                                                if PurchaseInvoiceHeader_lRec.Findlast() then begin
                                                    PurchaseInvoiceHeader_lRec.CalcFields("Amount Including VAT");
                                                    Amount2_lDec := PurchaseInvoiceHeader_lRec."Amount Including VAT";
                                                    if Amount1_lDec > Amount2_lDec then
                                                        HighAmount_lBln := true
                                                end;
                                                // until (PurchaseInvoiceHeader_lRec.Next() = 0) or (HighAmount_lBln = true);

                                                if HighAmount_lBln then begin
                                                    clear(PurchaseApprovalUserSetup_lRec);
                                                    PurchaseApprovalUserSetup_lRec.SetCurrentKey("Sequence No.");
                                                    if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then
                                                        PurchaseApprovalUserSetup_lRec.SetRange("Document Type", PurchaseApprovalUserSetup_lRec."Document Type"::"Blanket Purchase Order")
                                                    else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Order then
                                                        PurchaseApprovalUserSetup_lRec.SetRange("Document Type", PurchaseApprovalUserSetup_lRec."Document Type"::"Purchase Order")
                                                    else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then
                                                        PurchaseApprovalUserSetup_lRec.SetRange("Document Type", PurchaseApprovalUserSetup_lRec."Document Type"::"Purchase Return Order");

                                                    PurchaseApprovalUserSetup_lRec.SetRange(Type, PurchaseApprovalUserSetup_lRec.Type::"Price Comparision");
                                                    if FilterTransacTypr_lBln then
                                                        PurchaseApprovalUserSetup_lRec.SetRange("Transaction Type", PurchaseHeader_lRec."Transaction Type");
                                                    // PurchaseApprovalUserSetup_lRec.SetRange("Calculation Type", PurchaseApprovalUserSetup_lRec."Calculation Type"::Days);
                                                    if PurchaseApprovalUserSetup_lRec.FindSet() then
                                                        repeat
                                                            PurchaseApprovalUserSetup_lRec.TestField("Approver Type");
                                                            if PurchaseApprovalUserSetup_lRec."Approver Type" = PurchaseApprovalUserSetup_lRec."Approver Type"::User then
                                                                ApproverId_lCod := PurchaseApprovalUserSetup_lRec."User Id"
                                                            else
                                                                if PurchaseApprovalUserSetup_lRec."Approver Type" = PurchaseApprovalUserSetup_lRec."Approver Type"::Salesperson then
                                                                    ApproverId_lCod := GetSalesPersonUserId(PurchaseHeader_lRec)
                                                                else
                                                                    ApproverId_lCod := GetManagerUserId(PurchaseHeader_lRec);

                                                            if not UserSetup_lRec.Get(ApproverID_lCod) then
                                                                Error(WFUserGroupNotInSetupErr, ApproverId_lCod);
                                                            InsertApproverBasedOnSequence(ApproverID_lCod, PurchaseApprovalUserSetup_lRec."Sequence No.");
                                                        until PurchaseApprovalUserSetup_lRec.Next() = 0;
                                                end;
                                            end else
                                                if PurchApproveUser_lRec."Type" = PurchApproveUser_lRec.Type::"New Product" then begin
                                                    PurchaseLine_lRec.Reset();
                                                    PurchaseLine_lRec.SetRange("Document Type", ApprovalEntryArgument."Document Type");
                                                    PurchaseLine_lRec.SetRange("Document No.", ApprovalEntryArgument."Document No.");
                                                    if PurchaseLine_lRec.FindSet() then
                                                        repeat
                                                            PurchaseInvoiceLine_lRec.Reset();
                                                            PurchaseInvoiceLine_lRec.SetRange("No.", PurchaseLine_lRec."No.");
                                                            PurchaseInvoiceLine_lRec.SetRange("Buy-from Vendor No.", PurchaseLine_lRec."Buy-from Vendor No.");
                                                            if not PurchaseInvoiceLine_lRec.FindFirst() then
                                                                NewProduct_lBln := true
                                                            else
                                                                NewProduct_lBln := false;
                                                        until (PurchaseLine_lRec.Next() = 0) or (NewProduct_lBln = true);
                                                    if NewProduct_lBln then begin
                                                        clear(PurchaseApprovalUserSetup_lRec);
                                                        PurchaseApprovalUserSetup_lRec.SetCurrentKey("Sequence No.");
                                                        if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then
                                                            PurchaseApprovalUserSetup_lRec.SetRange("Document Type", PurchaseApprovalUserSetup_lRec."Document Type"::"Blanket Purchase Order")
                                                        else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Order then
                                                            PurchaseApprovalUserSetup_lRec.SetRange("Document Type", PurchaseApprovalUserSetup_lRec."Document Type"::"Purchase Order")
                                                        else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then
                                                            PurchaseApprovalUserSetup_lRec.SetRange("Document Type", PurchaseApprovalUserSetup_lRec."Document Type"::"Purchase Return Order");

                                                        PurchaseApprovalUserSetup_lRec.SetRange(Type, PurchaseApprovalUserSetup_lRec.Type::"New Product");
                                                        if FilterTransacTypr_lBln then
                                                            PurchaseApprovalUserSetup_lRec.SetRange("Transaction Type", PurchaseHeader_lRec."Transaction Type");
                                                        //  PurchaseApprovalUserSetup_lRec.SetRange("Calculation Type", PurchaseApprovalUserSetup_lRec."Calculation Type"::Days);
                                                        if PurchaseApprovalUserSetup_lRec.FindSet() then
                                                            repeat
                                                                PurchaseApprovalUserSetup_lRec.TestField("Approver Type");
                                                                if PurchaseApprovalUserSetup_lRec."Approver Type" = PurchaseApprovalUserSetup_lRec."Approver Type"::User then
                                                                    ApproverId_lCod := PurchaseApprovalUserSetup_lRec."User Id"
                                                                else
                                                                    if PurchaseApprovalUserSetup_lRec."Approver Type" = PurchaseApprovalUserSetup_lRec."Approver Type"::Salesperson then
                                                                        ApproverId_lCod := GetSalesPersonUserId(PurchaseHeader_lRec)
                                                                    else
                                                                        ApproverId_lCod := GetManagerUserId(PurchaseHeader_lRec);

                                                                if not UserSetup_lRec.Get(ApproverID_lCod) then
                                                                    Error(WFUserGroupNotInSetupErr, ApproverId_lCod);
                                                                InsertApproverBasedOnSequence(ApproverID_lCod, PurchaseApprovalUserSetup_lRec."Sequence No.");
                                                            until PurchaseApprovalUserSetup_lRec.Next() = 0;
                                                    end;
                                                end else
                                                    if PurchApproveUser_lRec."Type" = PurchApproveUser_lRec.Type::Overdue then begin
                                                        if IsOverdue(PurchaseHeader_lRec."Buy-from Vendor No.") then begin
                                                            clear(PurchaseApprovalUserSetup_lRec);
                                                            PurchaseApprovalUserSetup_lRec.SetCurrentKey("Sequence No.");
                                                            if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then
                                                                PurchaseApprovalUserSetup_lRec.SetRange("Document Type", PurchaseApprovalUserSetup_lRec."Document Type"::"Blanket Purchase Order")
                                                            else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Order then
                                                                PurchaseApprovalUserSetup_lRec.SetRange("Document Type", PurchaseApprovalUserSetup_lRec."Document Type"::"Purchase Order")
                                                            else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then
                                                                PurchaseApprovalUserSetup_lRec.SetRange("Document Type", PurchaseApprovalUserSetup_lRec."Document Type"::"Purchase Return Order");

                                                            PurchaseApprovalUserSetup_lRec.SetRange(Type, PurchaseApprovalUserSetup_lRec.Type::Overdue);
                                                            if FilterTransacTypr_lBln then
                                                                PurchaseApprovalUserSetup_lRec.SetRange("Transaction Type", PurchaseHeader_lRec."Transaction Type");
                                                            // PurchaseApprovalUserSetup_lRec.SetRange("Calculation Type", PurchaseApprovalUserSetup_lRec."Calculation Type"::Days);
                                                            if PurchaseApprovalUserSetup_lRec.FindSet() then
                                                                repeat
                                                                    PurchaseApprovalUserSetup_lRec.TestField("Approver Type");
                                                                    if PurchaseApprovalUserSetup_lRec."Approver Type" = PurchaseApprovalUserSetup_lRec."Approver Type"::User then
                                                                        ApproverId_lCod := PurchaseApprovalUserSetup_lRec."User Id"
                                                                    else
                                                                        if PurchaseApprovalUserSetup_lRec."Approver Type" = PurchaseApprovalUserSetup_lRec."Approver Type"::Salesperson then
                                                                            ApproverId_lCod := GetSalesPersonUserId(PurchaseHeader_lRec)
                                                                        else
                                                                            ApproverId_lCod := GetManagerUserId(PurchaseHeader_lRec);

                                                                    if not UserSetup_lRec.Get(ApproverID_lCod) then
                                                                        Error(WFUserGroupNotInSetupErr, ApproverId_lCod);
                                                                    InsertApproverBasedOnSequence(ApproverID_lCod, PurchaseApprovalUserSetup_lRec."Sequence No.");
                                                                until PurchaseApprovalUserSetup_lRec.Next() = 0;
                                                        end;
                                                    end else
                                                        if PurchApproveUser_lRec.Type = PurchApproveUser_lRec.Type::Price then begin
                                                            clear(PurchaseApprovalUserSetup_lRec);
                                                            PurchaseApprovalUserSetup_lRec.SetCurrentKey("Sequence No.");
                                                            if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then
                                                                PurchaseApprovalUserSetup_lRec.SetRange("Document Type", PurchaseApprovalUserSetup_lRec."Document Type"::"Blanket Purchase Order")
                                                            else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Order then
                                                                PurchaseApprovalUserSetup_lRec.SetRange("Document Type", PurchaseApprovalUserSetup_lRec."Document Type"::"Purchase Order")
                                                            else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then
                                                                PurchaseApprovalUserSetup_lRec.SetRange("Document Type", PurchaseApprovalUserSetup_lRec."Document Type"::"Purchase Return Order");

                                                            PurchaseApprovalUserSetup_lRec.SetRange(Type, PurchaseApprovalUserSetup_lRec.Type::Price);
                                                            if FilterTransacTypr_lBln then
                                                                PurchaseApprovalUserSetup_lRec.SetRange("Transaction Type", PurchaseHeader_lRec."Transaction Type");
                                                            // PurchaseApprovalUserSetup_lRec.SetRange("Calculation Type", PurchaseApprovalUserSetup_lRec."Calculation Type"::Days);
                                                            if PurchaseApprovalUserSetup_lRec.FindSet() then
                                                                repeat
                                                                    PurchaseHeader_lRec.CalcFields("Amount Including VAT");
                                                                    //YH++
                                                                    CurrencyExchRatePO_lRec.Reset();
                                                                    CurrencyExchRatePO_lRec.SetCurrentKey("Starting Date");
                                                                    CurrencyExchRatePO_lRec.SetRange("Currency Code", PurchaseHeader_lRec."Currency Code");
                                                                    CurrencyExchRatePO_lRec.SetRange("Relational Currency Code", '');
                                                                    if CurrencyExchRatePO_lRec.FindLast() then
                                                                        CurrencyExchRatePOAMT_lDec := CurrencyExchRatePO_lRec."Relational Exch. Rate Amount"
                                                                    else
                                                                        CurrencyExchRatePOAMT_lDec := 1;
                                                                    CurrencyExchRateSET_lRec.Reset();
                                                                    CurrencyExchRateSET_lRec.SetCurrentKey("Starting Date");
                                                                    CurrencyExchRateSET_lRec.SetRange("Currency Code", 'USD');
                                                                    CurrencyExchRateSET_lRec.SetRange("Relational Currency Code", '');
                                                                    if CurrencyExchRateSET_lRec.FindLast() then
                                                                        CurrencyExchRateSETAMT_lDec := CurrencyExchRateSET_lRec."Relational Exch. Rate Amount"
                                                                    else
                                                                        CurrencyExchRateSETAMT_lDec := 1;

                                                                    if (PurchaseApprovalUserSetup_lRec."From Value" * CurrencyExchRateSETAMT_lDec <= PurchaseHeader_lRec."Amount Including VAT" * CurrencyExchRatePOAMT_lDec)
                                                                    AND (PurchaseApprovalUserSetup_lRec."To Value" * CurrencyExchRateSETAMT_lDec >= PurchaseHeader_lRec."Amount Including VAT" * CurrencyExchRatePOAMT_lDec) then begin
                                                                        //YH-- Code added for Currency code
                                                                        PurchaseApprovalUserSetup_lRec.TestField("Approver Type");
                                                                        if PurchaseApprovalUserSetup_lRec."Approver Type" = PurchaseApprovalUserSetup_lRec."Approver Type"::User then
                                                                            ApproverId_lCod := PurchaseApprovalUserSetup_lRec."User Id"
                                                                        else
                                                                            if PurchaseApprovalUserSetup_lRec."Approver Type" = PurchaseApprovalUserSetup_lRec."Approver Type"::Salesperson then
                                                                                ApproverId_lCod := GetSalesPersonUserId(PurchaseHeader_lRec)
                                                                            else
                                                                                ApproverId_lCod := GetManagerUserId(PurchaseHeader_lRec);

                                                                        if not UserSetup_lRec.Get(ApproverID_lCod) then
                                                                            Error(WFUserGroupNotInSetupErr, ApproverId_lCod);
                                                                        InsertApproverBasedOnSequence(ApproverID_lCod, PurchaseApprovalUserSetup_lRec."Sequence No.");
                                                                    end;
                                                                until PurchaseApprovalUserSetup_lRec.Next() = 0;
                                                        end;
                                    end else if PurchaseHeader_lRec."ShortClose Approval" then begin
                                        if PurchApproveUser_lRec."Type" = PurchApproveUser_lRec.Type::"Shortclose Quantity " then begin
                                            PurchaseLine_lRec.Reset();
                                            PurchaseLine_lRec.SetRange("Document Type", ApprovalEntryArgument."Document Type");
                                            PurchaseLine_lRec.SetRange("Document No.", ApprovalEntryArgument."Document No.");
                                            if PurchaseLine_lRec.FindSet() then
                                                PurchaseLine_lRec.CalcSums(Quantity, "Short Closed Qty");

                                            Percent_lDec := (PurchaseLine_lRec."Outstanding Quantity" / PurchaseLine_lRec.Quantity) * 100;
                                            if Percent_lDec > 5 then begin
                                                PurchaseHeader_lRec."Short Close Qty > 5" := true;
                                                PurchaseHeader_lRec.Modify();
                                            end else begin
                                                PurchaseHeader_lRec."Short Close Qty < 5" := true;
                                                PurchaseHeader_lRec.Modify();
                                            end;
                                            // if Percent_lDec <= 5 then begin
                                            clear(PurchaseApprovalUserSetup_lRec);
                                            PurchaseApprovalUserSetup_lRec.SetCurrentKey("Sequence No.");
                                            if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then
                                                PurchaseApprovalUserSetup_lRec.SetRange("Document Type", PurchaseApprovalUserSetup_lRec."Document Type"::"Blanket Purchase Order")
                                            else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Order then
                                                PurchaseApprovalUserSetup_lRec.SetRange("Document Type", PurchaseApprovalUserSetup_lRec."Document Type"::"Purchase Order")
                                            else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then
                                                PurchaseApprovalUserSetup_lRec.SetRange("Document Type", PurchaseApprovalUserSetup_lRec."Document Type"::"Purchase Return Order");

                                            PurchaseApprovalUserSetup_lRec.SetRange(Type, PurchaseApprovalUserSetup_lRec.Type::"Shortclose Quantity ");
                                            if FilterTransacTypr_lBln then
                                                PurchaseApprovalUserSetup_lRec.SetRange("Transaction Type", PurchaseHeader_lRec."Transaction Type");
                                            // PurchaseApprovalUserSetup_lRec.SetRange("Calculation Type", PurchaseApprovalUserSetup_lRec."Calculation Type"::Days);
                                            if PurchaseApprovalUserSetup_lRec.FindSet() then
                                                repeat
                                                    PurchaseApprovalUserSetup_lRec.TestField("Approver Type");
                                                    if (PurchaseApprovalUserSetup_lRec."From Value" <= Percent_lDec) AND (PurchaseApprovalUserSetup_lRec."To Value" >= Percent_lDec) then begin

                                                        if PurchaseApprovalUserSetup_lRec."Approver Type" = PurchaseApprovalUserSetup_lRec."Approver Type"::User then
                                                            ApproverId_lCod := PurchaseApprovalUserSetup_lRec."User Id"
                                                        else
                                                            if PurchaseApprovalUserSetup_lRec."Approver Type" = PurchaseApprovalUserSetup_lRec."Approver Type"::Salesperson then
                                                                ApproverId_lCod := GetSalesPersonUserId(PurchaseHeader_lRec)
                                                            else
                                                                ApproverId_lCod := GetManagerUserId(PurchaseHeader_lRec);

                                                        if not UserSetup_lRec.Get(ApproverID_lCod) then
                                                            Error(WFUserGroupNotInSetupErr, ApproverId_lCod);
                                                        InsertApproverBasedOnSequence(ApproverID_lCod, PurchaseApprovalUserSetup_lRec."Sequence No.");
                                                    end;
                                                until PurchaseApprovalUserSetup_lRec.Next() = 0;
                                            // end;
                                            //  end //else if not PurchaseHeader_lRec."ShortClose Approval" then
                                            // if PurchApproveUser_lRec."Type" = PurchApproveUser_lRec.Type::"ShortClose Quantity > 5" then begin
                                            // PurchaseLine_lRec.Reset();
                                            //  PurchaseLine_lRec.SetRange("Document Type", ApprovalEntryArgument."Document Type");
                                            //PurchaseLine_lRec.SetRange("Document No.", ApprovalEntryArgument."Document No.");
                                            //if PurchaseLine_lRec.FindSet() then
                                            // PurchaseLine_lRec.CalcSums(Quantity, "Short Closed Qty");

                                            //Percent_lDec := (PurchaseLine_lRec."Short Closed Qty" / PurchaseLine_lRec.Quantity) * 100;

                                            //if Percent_lDec > 5 then begin
                                            // clear(PurchaseApprovalUserSetup_lRec);
                                            // PurchaseApprovalUserSetup_lRec.SetCurrentKey("Sequence No.");
                                            // if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Blanket Order" then
                                            //     PurchaseApprovalUserSetup_lRec.SetRange("Document Type", PurchaseApprovalUserSetup_lRec."Document Type"::"Blanket Purchase Order")
                                            // else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::Order then
                                            //     PurchaseApprovalUserSetup_lRec.SetRange("Document Type", PurchaseApprovalUserSetup_lRec."Document Type"::"Purchase Order")
                                            // else if ApprovalEntryArgument."Document Type" = ApprovalEntryArgument."Document Type"::"Return Order" then
                                            //     PurchaseApprovalUserSetup_lRec.SetRange("Document Type", PurchaseApprovalUserSetup_lRec."Document Type"::"Purchase Return Order");

                                            // PurchaseApprovalUserSetup_lRec.SetRange(Type, PurchaseApprovalUserSetup_lRec.Type::"Shortclose Quantity > 5");
                                            // PurchaseApprovalUserSetup_lRec.SetRange("Transaction Type", PurchaseHeader_lRec."Transaction Type");
                                            // PurchaseApprovalUserSetup_lRec.SetRange("Calculation Type", PurchaseApprovalUserSetup_lRec."Calculation Type"::Days);
                                            // if PurchaseApprovalUserSetup_lRec.FindSet() then
                                            //     repeat
                                            //         PurchaseApprovalUserSetup_lRec.TestField("Approver Type");
                                            //         if PurchaseApprovalUserSetup_lRec."Approver Type" = PurchaseApprovalUserSetup_lRec."Approver Type"::User then
                                            //             ApproverId_lCod := PurchaseApprovalUserSetup_lRec."User Id"
                                            //         else
                                            //             if PurchaseApprovalUserSetup_lRec."Approver Type" = PurchaseApprovalUserSetup_lRec."Approver Type"::Salesperson then
                                            //                 ApproverId_lCod := GetSalesPersonUserId(PurchaseHeader_lRec)
                                            //             else
                                            //                 ApproverId_lCod := GetManagerUserId(PurchaseHeader_lRec);

                                            //         if not UserSetup_lRec.Get(ApproverID_lCod) then
                                            //             Error(WFUserGroupNotInSetupErr, ApproverId_lCod);
                                            //         InsertApproverBasedOnSequence(ApproverID_lCod, PurchaseApprovalUserSetup_lRec."Sequence No.");
                                            //     until PurchaseApprovalUserSetup_lRec.Next() = 0;
                                            // end;
                                        end;
                                    end;
                            until PurchApproveUser_lRec.Next() = 0;
                        end;
                        Clear(RecApproverSequenceBuffer);
                        RecApproverSequenceBuffer.SetCurrentKey(Sequence);
                        RecApproverSequenceBuffer.SetAscending(Sequence, true);
                        if RecApproverSequenceBuffer.FindSet() then begin
                            repeat
                                SequenceNo_lInt := ApprovalMgmt_lCdu.GetLastSequenceNo(ApprovalEntryArgument);
                                if not IsSameApproverId(ApprovalEntryArgument, RecApproverSequenceBuffer."Approver ID") then
                                    ApprovalMgmt_lCdu.MakeApprovalEntry(ApprovalEntryArgument, SequenceNo_lInt + 1, RecApproverSequenceBuffer."Approver ID", WorkflowStepArgument);
                            until RecApproverSequenceBuffer.Next() = 0;
                        end;
                    end;
            end;
        end;
    end;

    local procedure GetApproverTypeSequence(WorkflowType: code[20]; var ApproverType: array[10] Of Text)
    var
        PurchaseApproverUserSetup_lRec:
            Record "Purchase Approver User Setup";
        checklist:
                    List of [Text];
        i: Integer;
    begin
        Clear(PurchaseApproverUserSetup_lRec);
        // SalesApproverUser.SetCurrentKey("Sequence No.");
        // SalesApproverUser.SetAscending("Sequence No.", true);
        PurchaseApproverUserSetup_lRec.SetCurrentKey("Workflow Priority");
        PurchaseApproverUserSetup_lRec.SetAscending("Workflow Priority", true);
        if WorkflowType = 'PO' then
            PurchaseApproverUserSetup_lRec.SetRange("Document Type", PurchaseApproverUserSetup_lRec."Document Type"::"Purchase Order")
        else
            if WorkflowType = 'BPO' then
                PurchaseApproverUserSetup_lRec.SetRange("Document Type", PurchaseApproverUserSetup_lRec."Document Type"::"Blanket Purchase Order")
            else if WorkflowType = 'PRO' then
                PurchaseApproverUserSetup_lRec.SetRange("Document Type", PurchaseApproverUserSetup_lRec."Document Type"::"Purchase Return Order");

        if PurchaseApproverUserSetup_lRec."Document Type" <> PurchaseApproverUserSetup_lRec."Document Type"::"Purchase Return Order" then
            //T50307-NE
            PurchaseApproverUserSetup_lRec.SetFilter(Type, '<>%1', PurchaseApproverUserSetup_lRec.Type::" ");
        Clear(checklist);
        i := 1;
        if PurchaseApproverUserSetup_lRec.FindSet() then begin
            repeat
                if not checklist.Contains(Format(PurchaseApproverUserSetup_lRec."Document Type") + Format(PurchaseApproverUserSetup_lRec.Type) + Format(PurchaseApproverUserSetup_lRec."Workflow Priority")) then begin
                    checklist.Add(Format(PurchaseApproverUserSetup_lRec."Document Type") + Format(PurchaseApproverUserSetup_lRec.Type) + Format(PurchaseApproverUserSetup_lRec."Workflow Priority"));
                    ApproverType[i] := format(PurchaseApproverUserSetup_lRec.Type);
                    i += 1;

                end;
            until PurchaseApproverUserSetup_lRec.Next() = 0;
        end;
    end;

    local procedure GetSalesPersonUserId(var PurchaseHeader_lRec: Record "Purchase Header"): Text
    var
        SalespersonPurchaser_lRec: Record "Salesperson/Purchaser";
        UserSetup: Record "User Setup";
    begin
        PurchaseHeader_lRec.TestField("Purchaser Code");
        Clear(UserSetup);
        UserSetup.SetRange("Salespers./Purch. Code", PurchaseHeader_lRec."Purchaser Code");
        UserSetup.SetFilter("E-Mail", '<>%1', '');
        if UserSetup.FindFirst() then;
        exit(UserSetup."User ID");
    end;

    local procedure GetManagerUserId(var PutrchaseHeader: Record "Purchase Header"): Text
    var
        RecTeams: Record Team;
        RecTeamSalesPerson: Record "Team Salesperson";
        TeamManagerSalesPerson: Record "Team Salesperson";
        UserSetup: Record "User Setup";
    begin
        Clear(RecteamSalesPerson);
        RecteamSalesPerson.SetRange("Salesperson Code", PutrchaseHeader."Purchaser Code");
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

    local procedure InsertApproverBasedOnSequence(ApproverId: code[100]; seq: Integer)
    var
        RecAppSeq: Record ApproverSequenceBuffer;
    begin
        RecAppSeq.Init();
        RecAppSeq."Approver ID" := ApproverId;
        RecAppSeq.Sequence := seq;
        if RecAppSeq.Insert() then;
    end;

    local procedure IsOverdue(Vendor_lCod: Code[20]): Boolean
    var
        VendorLedgerEntry_lRec: Record "Vendor Ledger Entry";
    begin
        Clear(VendorLedgerEntry_lRec);
        VendorLedgerEntry_lRec.SetRange("Vendor No.", Vendor_lCod);
        VendorLedgerEntry_lRec.SetRange(Open, true);
        VendorLedgerEntry_lRec.SetRange("Document Type", VendorLedgerEntry_lRec."Document Type"::Invoice);
        VendorLedgerEntry_lRec.SetFilter("Due Date", '..%1', Today());
        exit(VendorLedgerEntry_lRec.FindFirst())
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

}