codeunit 53001 "Approval Notifications"//T12370-Full Comment
{
    //[EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterDelegateApprovalRequest', '', true, true)]
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', true, true)]
    local procedure fnOnBeforeDelegateApprovalRequests(var ApprovalEntry: Record "Approval Entry")
    var
        ApprovalEntry2: Record "Approval Entry";
    begin
        Clear(ApprovalEntry2);
        ApprovalEntry2.SetRange("Entry No.", ApprovalEntry."Entry No.");
        if ApprovalEntry2.FindFirst() then begin

            fnSendNotificationToSender(ApprovalEntry2);
            fnSendNotificationToApproverDelegate(ApprovalEntry2);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', true, true)]
    local procedure fnOnApproveApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    begin
        fnSendApprovedNotificationToSender(ApprovalEntry);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterRejectSelectedApprovalRequest', '', true, true)]
    local procedure OnAfterRejectSelectedApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    begin
        fnSendRejectedNotificationToSender(ApprovalEntry);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Approval Entry", 'OnAfterValidateEvent', 'Status', true, true)]
    //local procedure fnOnBeforeApprovalEntryInsert(var ApprovalEntry: Record "Approval Entry"; ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepArgument: Record "Workflow Step Argument"; ApproverId: Code[50]; var IsHandled: Boolean)
    local procedure fnOnBeforeApprovalEntryInsert(VAR Rec: Record "Approval Entry"; VAR xRec: Record "Approval Entry"; CurrFieldNo: Integer)
    begin
        IF (xRec.Status = xRec.Status::Created) AND (Rec.Status = Rec.Status::Open) THEN begin
            fnSendNotificationToApprover(Rec);
            fnSendNotificationToSender(Rec);
        end;
        //SendApprovalRequestFromRecord
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelApprovalRequestsForRecordOnAfterSetApprovalEntryFilters', '', true, true)]
    local procedure OnCancelApprovalRequestsForRecordOnAfterSetApprovalEntryFilters(var ApprovalEntry: Record "Approval Entry"; RecRef: RecordRef);
    begin
        if ApprovalEntry.FindFirst() then begin
            fnSendCancelledNotificationToApprover(ApprovalEntry);
            fnSendCancelledNotificationToSender(ApprovalEntry);
        end;
    end;

    local procedure fnSendNotificationToApproverDelegate(ApprovalEntry: Record "Approval Entry")
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        SalesPostedTitle: Label 'ERP Approval Request - %1 - Sales %2 - %3 - %4 - Delegated';
        SalesPostedMsg: Label 'Hello %1,<br><br>You are registered to receive notifications related to Kemipex FZE.<br><br>This is a message to notify you that:<br><br>%2 %3 requires your approval.<br>Customer %4 %5.<br>Amount: %6<br><a href="%7">Open Document %8</a><br><br>Date-Time Sent for Approval - %9.<br>Approval Due Date - %10.<br>Approval Sent by %11.';
        SenderUserSetup: Record "User Setup";
        ReceiverSetup: Record "User Setup";
        SalesHeader: Record "Sales Header";
        SendUser: Record User;
        ReceiverUser: Record User;
        PageId: Integer;
        RecCustomer: Record Customer;
        CustomerShortName: Text;
        ShortName: Record "Company Short Name";
    begin
        Clear(CustomerShortName);
        ShortName.GET(CompanyName);
        if not SalesHeader.get(ApprovalEntry."Document Type", ApprovalEntry."Document No.") then
            exit;
        if SenderUserSetup.Get(ApprovalEntry."Sender ID") then;
        SendUser.Reset();
        SendUser.SetRange("User Name", SenderUserSetup."User ID");
        if SendUser.FindFirst() then;
        if ReceiverSetup.Get(ApprovalEntry."Approver ID") then;
        ReceiverUser.Reset();
        ReceiverUser.SetRange("User Name", ReceiverSetup."User ID");
        if ReceiverUser.FindFirst() then;
        Recipients.Add(ReceiverSetup."E-Mail");

        RecCustomer.GET(SalesHeader."Sell-to Customer No.");
        if RecCustomer.AltCustomerName <> '' then begin
            CustomerShortName := RecCustomer.AltCustomerName;
        end else begin
            CustomerShortName := RecCustomer."Search Name";
        end;

        Subject := StrSubstNo(SalesPostedTitle, ShortName."Short Name", ApprovalEntry."Document Type", ApprovalEntry."Document No.", CustomerShortName);
        SalesHeader.CalcFields("Amount Including VAT");
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
            PageId := Page::"Sales Order"
        else
            if SalesHeader."Document Type" = SalesHeader."Document Type"::"Blanket Order" then
                PageId := Page::"Blanket Sales Order"
            else
                if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then
                    PageId := Page::"Sales Invoice"
                else
                    if SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" then
                        PageId := Page::"Sales Credit Memo"
                    else
                        if SalesHeader."Document Type" = SalesHeader."Document Type"::Quote then
                            PageId := Page::"Sales Quote"
                        else
                            if SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" then
                                PageId := Page::"Sales Return Order";
        // Body := StrSubstNo(SalesPostedMsg, ReceiverUser."Full Name", SalesHeader."Document Type", SalesHeader."No.", SalesHeader."Bill-to Customer No.", SalesHeader."Bill-to Name", SalesHeader."Amount Including VAT", GetUrl(ClientType::Web, CompanyName, ObjectType::Page, PageId, SalesHeader, False), SalesHeader."No.", CurrentDateTime, ApprovalEntry."Due Date", SendUser."Full Name");
        Body := CreateEmailBody(SalesHeader, ReceiverUser, SendUser, ApprovalEntry, 'APPROVER', 'requires your approval.');
        EmailMessage.Create(Recipients, Subject, Body, true);
        // Email.Send(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022
        Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022
    end;

    local procedure fnSendNotificationToApprover(ApprovalEntry: Record "Approval Entry")
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        SalesPostedTitle: Label 'ERP Approval Request - %1 - Sales %2 - %3 - %4';
        SalesPostedMsg: Label 'Hello %1,<br><br>You are registered to receive notifications related to Kemipex FZE.<br><br>This is a message to notify you that:<br><br>%2 %3 requires your approval.<br>Customer %4 %5.<br>Amount: %6<br><a href="%7">Open Document %8</a><br><br>Date-Time Sent for Approval - %9.<br>Approval Due Date - %10.<br>Approval Sent by %11.';
        SenderUserSetup: Record "User Setup";
        ReceiverSetup: Record "User Setup";
        SalesHeader: Record "Sales Header";
        SendUser: Record User;
        ReceiverUser: Record User;
        PageId: Integer;
        RecCustomer: Record Customer;
        CustomerShortName: Text;
        ShortName: Record "Company Short Name";
    begin
        Clear(CustomerShortName);
        ShortName.GET(CompanyName);
        if not SalesHeader.get(ApprovalEntry."Document Type", ApprovalEntry."Document No.") then
            exit;
        if SenderUserSetup.Get(ApprovalEntry."Sender ID") then;
        SendUser.Reset();
        SendUser.SetRange("User Name", SenderUserSetup."User ID");
        if SendUser.FindFirst() then;
        if ReceiverSetup.Get(ApprovalEntry."Approver ID") then;
        ReceiverUser.Reset();
        ReceiverUser.SetRange("User Name", ReceiverSetup."User ID");
        if ReceiverUser.FindFirst() then;
        Recipients.Add(ReceiverSetup."E-Mail");

        RecCustomer.GET(SalesHeader."Sell-to Customer No.");
        if RecCustomer.AltCustomerName <> '' then begin
            CustomerShortName := RecCustomer.AltCustomerName;
        end else begin
            CustomerShortName := RecCustomer."Search Name";
        end;

        Subject := StrSubstNo(SalesPostedTitle, ShortName."Short Name", ApprovalEntry."Document Type", ApprovalEntry."Document No.", CustomerShortName);
        SalesHeader.CalcFields("Amount Including VAT");
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
            PageId := Page::"Sales Order"
        else
            if SalesHeader."Document Type" = SalesHeader."Document Type"::"Blanket Order" then
                PageId := Page::"Blanket Sales Order"
            else
                if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then
                    PageId := Page::"Sales Invoice"
                else
                    if SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" then
                        PageId := Page::"Sales Credit Memo"
                    else
                        if SalesHeader."Document Type" = SalesHeader."Document Type"::Quote then
                            PageId := Page::"Sales Quote"
                        else
                            if SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" then
                                PageId := Page::"Sales Return Order";

        // Body := StrSubstNo(SalesPostedMsg, ReceiverUser."Full Name", SalesHeader."Document Type", SalesHeader."No.", SalesHeader."Bill-to Customer No.", SalesHeader."Bill-to Name", SalesHeader."Amount Including VAT", GetUrl(ClientType::Web, CompanyName, ObjectType::Page, PageId, SalesHeader, False), SalesHeader."No.", CurrentDateTime, ApprovalEntry."Due Date", SendUser."Full Name");
        Body := CreateEmailBody(SalesHeader, ReceiverUser, SendUser, ApprovalEntry, 'APPROVER', 'requires your approval.');
        EmailMessage.Create(Recipients, Subject, Body, true);
        // Email.Send(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022
        Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022
    end;

    local procedure fnSendNotificationToSender(ApprovalEntry: Record "Approval Entry")
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        //SalesPostedTitle: Label 'Notification Email - %1 No. %2';
        SalesPostedTitle: Label 'ERP Approval Request - %1 - Sales %2 - %3 - %4';
        SalesPostedMsg: Label 'Hello %1,<br><br>You are registered to receive notifications related to Kemipex FZE.<br><br>This is a message to notify you that:<br><br>%2 %3 requires %4 approval.<br>Customer %5 %6.<br>Order Status - %7.<br>Amount: %8<br><a href="%9">Open Document %10</a><br><br>Date-Time Sent for Approval - %11.<br>Last Date-Time Modified - %12.<br>Last Modified by %13.<br>Approval Due Date - %14.<br>Approval Sent by %15';
        SenderUserSetup: Record "User Setup";
        ReceiverSetup: Record "User Setup";
        SalesHeader: Record "Sales Header";
        SendUser: Record User;
        ReceiverUser: Record User;
        PageId: Integer;
        RecCustomer: Record Customer;
        CustomerShortName: Text;
        ShortName: Record "Company Short Name";
    begin
        Clear(CustomerShortName);
        ShortName.GET(CompanyName);
        if not SalesHeader.get(ApprovalEntry."Document Type", ApprovalEntry."Document No.") then
            exit;
        if SenderUserSetup.Get(ApprovalEntry."Sender ID") then;
        SendUser.Reset();
        SendUser.SetRange("User Name", SenderUserSetup."User ID");
        if SendUser.FindFirst() then;
        if ReceiverSetup.Get(ApprovalEntry."Approver ID") then;
        ReceiverUser.Reset();
        ReceiverUser.SetRange("User Name", ReceiverSetup."User ID");
        if ReceiverUser.FindFirst() then;
        Recipients.Add(SenderUserSetup."E-Mail");

        RecCustomer.GET(SalesHeader."Sell-to Customer No.");
        if RecCustomer.AltCustomerName <> '' then begin
            CustomerShortName := RecCustomer.AltCustomerName;
        end else begin
            CustomerShortName := RecCustomer."Search Name";
        end;

        //Subject := StrSubstNo(SalesPostedTitle, ApprovalEntry."Document Type", ApprovalEntry."Document No.");
        Subject := StrSubstNo(SalesPostedTitle, ShortName."Short Name", ApprovalEntry."Document Type", ApprovalEntry."Document No.", CustomerShortName);
        SalesHeader.CalcFields("Amount Including VAT");
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
            PageId := Page::"Sales Order"
        else
            if SalesHeader."Document Type" = SalesHeader."Document Type"::"Blanket Order" then
                PageId := Page::"Blanket Sales Order"
            else
                if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then
                    PageId := Page::"Sales Invoice"
                else
                    if SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" then
                        PageId := Page::"Sales Credit Memo"
                    else
                        if SalesHeader."Document Type" = SalesHeader."Document Type"::Quote then
                            PageId := Page::"Sales Quote"
                        else
                            if SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" then
                                PageId := Page::"Sales Return Order";

        //  Body := StrSubstNo(SalesPostedMsg, SendUser."User Name", SalesHeader."Document Type", SalesHeader."No.", ReceiverUser."Full Name", SalesHeader."Bill-to Customer No.", SalesHeader."Bill-to Name", SalesHeader.Status, SalesHeader."Amount Including VAT", GetUrl(ClientType::Web, CompanyName, ObjectType::Page, PageId, SalesHeader, False), SalesHeader."No.", CurrentDateTime, CurrentDateTime, ApprovalEntry."Sender ID", ApprovalEntry."Due Date", SendUser."Full Name");
        Body := CreateEmailBody(SalesHeader, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('requires %1 approval.', ReceiverUser."Full Name"));

        EmailMessage.Create(Recipients, Subject, Body, true);
        //Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
        Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022
    end;

    local procedure fnSendApprovedNotificationToSender(ApprovalEntry: Record "Approval Entry")
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        //SalesPostedTitle: Label 'Notification Email - %1 No. %2';
        SalesPostedTitle: Label 'ERP Approval Request - %1 - Sales %2 - %3 - %4';
        SalesPostedMsg: Label 'Hello %1,<br><br>You are registered to receive notifications related to Kemipex FZE.<br><br>This is a message to notify you that:<br><br>%2 %3 is approved by %4.<br>Customer %5 %6.<br>Order Status - %7.<br>Amount: %8<br><a href="%9">Open Document %10</a><br><br>Date-Time Sent for Approval - %11.<br>Last Date-Time Modified - %12.<br>Last Modified by %13.<br>Approval Due Date - %14.<br>Approval Sent by %15';
        SenderUserSetup: Record "User Setup";
        ReceiverSetup: Record "User Setup";
        SalesHeader: Record "Sales Header";
        SendUser: Record User;
        ReceiverUser: Record User;
        PageId: Integer;
        RecCustomer: Record Customer;
        CustomerShortName: Text;
        ShortName: Record "Company Short Name";
    begin
        Clear(CustomerShortName);
        ShortName.GET(CompanyName);
        if not SalesHeader.get(ApprovalEntry."Document Type", ApprovalEntry."Document No.") then
            exit;
        if SenderUserSetup.Get(ApprovalEntry."Sender ID") then;
        SendUser.Reset();
        SendUser.SetRange("User Name", SenderUserSetup."User ID");
        if SendUser.FindFirst() then;
        if ReceiverSetup.Get(ApprovalEntry."Approver ID") then;
        ReceiverUser.Reset();
        ReceiverUser.SetRange("User Name", ReceiverSetup."User ID");
        if ReceiverUser.FindFirst() then;
        Recipients.Add(SenderUserSetup."E-Mail");

        RecCustomer.GET(SalesHeader."Sell-to Customer No.");
        if RecCustomer.AltCustomerName <> '' then begin
            CustomerShortName := RecCustomer.AltCustomerName;
        end else begin
            CustomerShortName := RecCustomer."Search Name";
        end;

        //Subject := StrSubstNo(SalesPostedTitle, ApprovalEntry."Document Type", ApprovalEntry."Document No.");
        Subject := StrSubstNo(SalesPostedTitle, ShortName."Short Name", ApprovalEntry."Document Type", ApprovalEntry."Document No.", CustomerShortName);
        SalesHeader.CalcFields("Amount Including VAT");
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
            PageId := Page::"Sales Order"
        else
            if SalesHeader."Document Type" = SalesHeader."Document Type"::"Blanket Order" then
                PageId := Page::"Blanket Sales Order"
            else
                if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then
                    PageId := Page::"Sales Invoice"
                else
                    if SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" then
                        PageId := Page::"Sales Credit Memo"
                    else
                        if SalesHeader."Document Type" = SalesHeader."Document Type"::Quote then
                            PageId := Page::"Sales Quote"
                        else
                            if SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" then
                                PageId := Page::"Sales Return Order";
        //Body := StrSubstNo(SalesPostedMsg, SendUser."User Name", SalesHeader."Document Type", SalesHeader."No.", ReceiverUser."Full Name", SalesHeader."Bill-to Customer No.", SalesHeader."Bill-to Name", SalesHeader.Status, SalesHeader."Amount Including VAT", GetUrl(ClientType::Web, CompanyName, ObjectType::Page, PageId, SalesHeader, False), SalesHeader."No.", CurrentDateTime, CurrentDateTime, UserId, ApprovalEntry."Due Date", SendUser."Full Name");
        Body := CreateEmailBody(SalesHeader, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('is approved by %1.', ReceiverUser."Full Name"));

        EmailMessage.Create(Recipients, Subject, Body, true);
        //Email.Send(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022
        Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022
    end;

    local procedure fnSendRejectedNotificationToSender(ApprovalEntry: Record "Approval Entry")
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        //SalesPostedTitle: Label 'Notification Email - %1 No. %2';
        SalesPostedTitle: Label 'ERP Approval Rejected - %1 - Sales %2 - %3 - %4';
        SalesPostedMsg: Label 'Hello %1,<br><br>You are registered to receive notifications related to Kemipex FZE.<br><br>This is a message to notify you that:<br><br>%2 %3 is rejected by %4.<br>Customer %5 %6.<br>Order Status - %7.<br>Amount: %8<br><a href="%9">Open Document %10</a><br><br>Date-Time Sent for Approval - %11.<br>Last Date-Time Modified - %12.<br>Last Modified by %13.<br>Approval Due Date - %14.<br>Approval Sent by %15';
        SenderUserSetup: Record "User Setup";
        ReceiverSetup: Record "User Setup";
        SalesHeader: Record "Sales Header";
        SendUser: Record User;
        ReceiverUser: Record User;
        PageId: Integer;
        RecCustomer: Record Customer;
        CustomerShortName: Text;
        ShortName: Record "Company Short Name";
    begin
        Clear(CustomerShortName);
        ShortName.GET(CompanyName);
        if not SalesHeader.get(ApprovalEntry."Document Type", ApprovalEntry."Document No.") then
            exit;
        if SenderUserSetup.Get(ApprovalEntry."Sender ID") then;
        SendUser.Reset();
        SendUser.SetRange("User Name", SenderUserSetup."User ID");
        if SendUser.FindFirst() then;
        if ReceiverSetup.Get(ApprovalEntry."Approver ID") then;
        ReceiverUser.Reset();
        ReceiverUser.SetRange("User Name", ReceiverSetup."User ID");
        if ReceiverUser.FindFirst() then;
        Recipients.Add(SenderUserSetup."E-Mail");

        RecCustomer.GET(SalesHeader."Sell-to Customer No.");
        if RecCustomer.AltCustomerName <> '' then begin
            CustomerShortName := RecCustomer.AltCustomerName;
        end else begin
            CustomerShortName := RecCustomer."Search Name";
        end;

        //Subject := StrSubstNo(SalesPostedTitle, ApprovalEntry."Document Type", ApprovalEntry."Document No.");
        Subject := StrSubstNo(SalesPostedTitle, ShortName."Short Name", ApprovalEntry."Document Type", ApprovalEntry."Document No.", CustomerShortName);
        SalesHeader.CalcFields("Amount Including VAT");
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
            PageId := Page::"Sales Order"
        else
            if SalesHeader."Document Type" = SalesHeader."Document Type"::"Blanket Order" then
                PageId := Page::"Blanket Sales Order"
            else
                if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then
                    PageId := Page::"Sales Invoice"
                else
                    if SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" then
                        PageId := Page::"Sales Credit Memo"
                    else
                        if SalesHeader."Document Type" = SalesHeader."Document Type"::Quote then
                            PageId := Page::"Sales Quote"
                        else
                            if SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" then
                                PageId := Page::"Sales Return Order";
        // Body := StrSubstNo(SalesPostedMsg, SendUser."User Name", SalesHeader."Document Type", SalesHeader."No.", ReceiverUser."Full Name", SalesHeader."Bill-to Customer No.", SalesHeader."Bill-to Name", SalesHeader.Status, SalesHeader."Amount Including VAT", GetUrl(ClientType::Web, CompanyName, ObjectType::Page, PageId, SalesHeader, False), SalesHeader."No.", CurrentDateTime, CurrentDateTime, UserId, ApprovalEntry."Due Date", SendUser."Full Name");
        Body := CreateEmailBody(SalesHeader, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('is rejected by %1.', ReceiverUser."Full Name"));

        EmailMessage.Create(Recipients, Subject, Body, true);
        //Email.Send(EmailMessage, Enum::"Email Scenario"::Default);27-06-2022
        Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022
    end;

    local procedure fnSendCancelledNotificationToSender(ApprovalEntry: Record "Approval Entry")
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        //SalesPostedTitle: Label 'Notification Email - %1 No. %2';
        SalesPostedTitle: Label 'ERP Approval Cancelled - %1 - Sales %2 - %3 - %4';
        SalesPostedMsg: Label 'Hello %1,<br><br>You are registered to receive notifications related to Kemipex FZE.<br><br>This is a message to notify you that:<br><br>%2 %3 is cancelled by %4.<br>Customer %5 %6.<br>Order Status - %7.<br>Amount: %8<br><a href="%9">Open Document %10</a><br><br>Date-Time Sent for Approval - %11.<br>Last Date-Time Modified - %12.<br>Last Modified by %13.<br>Approval Due Date - %14.<br>Approval Sent by %15';
        SenderUserSetup: Record "User Setup";
        ReceiverSetup: Record "User Setup";
        SalesHeader: Record "Sales Header";
        SendUser: Record User;
        ReceiverUser: Record User;
        PageId: Integer;
        RecCustomer: Record Customer;
        CustomerShortName: Text;
        ShortName: Record "Company Short Name";
    begin
        Clear(CustomerShortName);
        ShortName.GET(CompanyName);
        if not SalesHeader.get(ApprovalEntry."Document Type", ApprovalEntry."Document No.") then
            exit;
        if SenderUserSetup.Get(ApprovalEntry."Sender ID") then;
        SendUser.Reset();
        SendUser.SetRange("User Name", SenderUserSetup."User ID");
        if SendUser.FindFirst() then;
        if ReceiverSetup.Get(ApprovalEntry."Approver ID") then;
        ReceiverUser.Reset();
        ReceiverUser.SetRange("User Name", ReceiverSetup."User ID");
        if ReceiverUser.FindFirst() then;
        Recipients.Add(SenderUserSetup."E-Mail");

        RecCustomer.GET(SalesHeader."Sell-to Customer No.");
        if RecCustomer.AltCustomerName <> '' then begin
            CustomerShortName := RecCustomer.AltCustomerName;
        end else begin
            CustomerShortName := RecCustomer."Search Name";
        end;

        //Subject := StrSubstNo(SalesPostedTitle, ApprovalEntry."Document Type", ApprovalEntry."Document No.");
        Subject := StrSubstNo(SalesPostedTitle, ShortName."Short Name", ApprovalEntry."Document Type", ApprovalEntry."Document No.", CustomerShortName);
        SalesHeader.CalcFields("Amount Including VAT");
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
            PageId := Page::"Sales Order"
        else
            if SalesHeader."Document Type" = SalesHeader."Document Type"::"Blanket Order" then
                PageId := Page::"Blanket Sales Order"
            else
                if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then
                    PageId := Page::"Sales Invoice"
                else
                    if SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" then
                        PageId := Page::"Sales Credit Memo"
                    else
                        if SalesHeader."Document Type" = SalesHeader."Document Type"::Quote then
                            PageId := Page::"Sales Quote"
                        else
                            if SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" then
                                PageId := Page::"Sales Return Order";
        //  Body := StrSubstNo(SalesPostedMsg, SendUser."User Name", SalesHeader."Document Type", SalesHeader."No.", SendUser."Full Name", SalesHeader."Bill-to Customer No.", SalesHeader."Bill-to Name", 'Cancelled', SalesHeader."Amount Including VAT", GetUrl(ClientType::Web, CompanyName, ObjectType::Page, PageId, SalesHeader, False), SalesHeader."No.", CurrentDateTime, CurrentDateTime, UserId, ApprovalEntry."Due Date", SendUser."Full Name");
        Body := CreateEmailBody(SalesHeader, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('is cancelled by %1.', SendUser."Full Name"));

        EmailMessage.Create(Recipients, Subject, Body, true);
        // Email.Send(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022
        Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022
    end;

    local procedure fnSendCancelledNotificationToApprover(ApprovalEntry: Record "Approval Entry")
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        //SalesPostedTitle: Label 'Notification Email - %1 No. %2';
        SalesPostedTitle: Label 'ERP Approval Cancelled - %1 - Sales %2 - %3 - %4';
        SalesPostedMsg: Label 'Hello %1,<br><br>You are registered to receive notifications related to Kemipex FZE.<br><br>This is a message to notify you that:<br><br>%2 %3 is cancelled by %4.<br>Customer %5 %6.<br>Order Status - %7.<br>Amount: %8<br><a href="%9">Open Document %10</a><br><br>Date-Time Sent for Approval - %11.<br>Last Date-Time Modified - %12.<br>Last Modified by %13.<br>Approval Due Date - %14.<br>Approval Sent by %15';
        SenderUserSetup: Record "User Setup";
        ReceiverSetup: Record "User Setup";
        SalesHeader: Record "Sales Header";
        SendUser: Record User;
        ReceiverUser: Record User;
        PageId: Integer;
        RecCustomer: Record Customer;
        CustomerShortName: Text;
        ShortName: Record "Company Short Name";
    begin
        Clear(CustomerShortName);
        ShortName.GET(CompanyName);
        if not SalesHeader.get(ApprovalEntry."Document Type", ApprovalEntry."Document No.") then
            exit;
        if SenderUserSetup.Get(ApprovalEntry."Sender ID") then;
        SendUser.Reset();
        SendUser.SetRange("User Name", SenderUserSetup."User ID");
        if SendUser.FindFirst() then;
        if ReceiverSetup.Get(ApprovalEntry."Approver ID") then;
        ReceiverUser.Reset();
        ReceiverUser.SetRange("User Name", ReceiverSetup."User ID");
        if ReceiverUser.FindFirst() then;
        Recipients.Add(ReceiverSetup."E-Mail");

        RecCustomer.GET(SalesHeader."Sell-to Customer No.");
        if RecCustomer.AltCustomerName <> '' then begin
            CustomerShortName := RecCustomer.AltCustomerName;
        end else begin
            CustomerShortName := RecCustomer."Search Name";
        end;

        //Subject := StrSubstNo(SalesPostedTitle, ApprovalEntry."Document Type", ApprovalEntry."Document No.");
        Subject := StrSubstNo(SalesPostedTitle, ShortName."Short Name", ApprovalEntry."Document Type", ApprovalEntry."Document No.", CustomerShortName);
        SalesHeader.CalcFields("Amount Including VAT");
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
            PageId := Page::"Sales Order"
        else
            if SalesHeader."Document Type" = SalesHeader."Document Type"::"Blanket Order" then
                PageId := Page::"Blanket Sales Order"
            else
                if SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice then
                    PageId := Page::"Sales Invoice"
                else
                    if SalesHeader."Document Type" = SalesHeader."Document Type"::"Credit Memo" then
                        PageId := Page::"Sales Credit Memo"
                    else
                        if SalesHeader."Document Type" = SalesHeader."Document Type"::Quote then
                            PageId := Page::"Sales Quote"
                        else
                            if SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" then
                                PageId := Page::"Sales Return Order";
        //Body := StrSubstNo(SalesPostedMsg, ReceiverUser."User Name", SalesHeader."Document Type", SalesHeader."No.", SendUser."Full Name", SalesHeader."Bill-to Customer No.", SalesHeader."Bill-to Name", 'Cancelled', SalesHeader."Amount Including VAT", GetUrl(ClientType::Web, CompanyName, ObjectType::Page, PageId, SalesHeader, False), SalesHeader."No.", CurrentDateTime, CurrentDateTime, UserId, ApprovalEntry."Due Date", SendUser."Full Name");
        Body := CreateEmailBody(SalesHeader, ReceiverUser, SendUser, ApprovalEntry, 'APPROVER', StrSubstNo('is cancelled by %1', SendUser."Full Name"));

        EmailMessage.Create(Recipients, Subject, Body, true);
        //Email.Send(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022
        Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022
    end;


    //27-06-2022- to stop standard notification
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeCreateApprovalEntryNotification', '', false, false)]
    local procedure OnBeforeCreateApprovalEntryNotification(ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean);
    var
        SalesHeader: Record "Sales Header";
    begin
        if SalesHeader.get(ApprovalEntry."Document Type", ApprovalEntry."Document No.") then
            IsHandled := true;
    end;

    local procedure CreateEmailBody(Var SHeader: Record "Sales Header"; Var Receiver: Record User; Var Sender: Record User; Var RecAppEntry: Record "Approval Entry"; ToUser: Code[10]; ActionText: Text): Text
    var

        RecLines: Record "Sales Line";
        RecCustomer: Record Customer;
        RecApprovalEntry: Record "Approval Entry";
        GLSetup: Record "General Ledger Setup";
        RecPaymentTerms: Record "Payment Terms";
        RecPaymentTermsCustomer: Record "Payment Terms";
        Recteams: Record Team;
        RecteamSalesPerson: Record "Team Salesperson";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        RecItem: Record Item;
        RecCLE: record "Cust. Ledger Entry";
        ShortName: Record "Company Short Name";
        Utility: Codeunit Events;
        RecLines2: Record "Sales Line";
        BodyText: TextBuilder;
        UOMCheck: List of [Text];
        TestText: Text;
        PaymentTermsText, ColorText, ColorText1, ColorTextDes, ColorTextHS, ColorTextCOO : Text;
        SystemPaymentTermsText: Text;
        PageId, J : Integer;
        TotalAmt, TotalQty, AvailableLimit, UsedLimit, OverDueHistory : Decimal;
        UnitPriceColor: Label 'style="color:%1"; font-weight: %2';
        ColorText1C: Label 'style="color:%1"; font-weight: %2';
        ColorTextDesC: Label 'style="color:%1"; font-weight: %2';
        ColorTextHSC: Label 'style="color:%1"; font-weight: %2';
        ColorTextCOOC: Label 'style="color:%1"; font-weight: %2';
        RecTransactionSpecification: Record "Transaction Specification";
        RecArea: Record "Area";
        RecExit: Record "Entry/Exit Point";
        RecCustomerFinalDestination: Record "Area";
        RecTransactionType: Record "Transaction Type";
        Incoterm: Text;
        IncotermStyle: Text;                   //ISPL-RV-N
        Portofloading: Text;
        Portofdischarge: Text;
        CustomerFinalDestination: Text;
        CustomerShippingAdress: Text;          //ISPL-RV-N
        CustomerShippingAdressStyle: Text;          //ISPL-RV-N
        TransactionTypeDescription: Text;
        SequenceNumber: Text;
        ApproverName: Text;
        SenderName: Text;
        RecLocation: Record Location;
        PackingDesc: Text;
        ItemVariant: Record "Item Variant";
        UOMCount: integer;
        VariantCode: Text;
        ItemDesc: Text;
        Country_lRec: Record "Country/Region";
    begin
        GLSetup.GET;
        ShortName.GET(CompanyName);
        Clear(RecCustomer);
        RecCustomer.GET(SHeader."Sell-to Customer No.");

        if SHeader."Document Type" = SHeader."Document Type"::Order then
            PageId := Page::"Sales Order"
        else
            if SHeader."Document Type" = SHeader."Document Type"::"Blanket Order" then
                PageId := Page::"Blanket Sales Order"
            else
                if SHeader."Document Type" = SHeader."Document Type"::Invoice then
                    PageId := Page::"Sales Invoice"
                else
                    if SHeader."Document Type" = SHeader."Document Type"::"Credit Memo" then
                        PageId := Page::"Sales Credit Memo"
                    else
                        if SHeader."Document Type" = SHeader."Document Type"::Quote then
                            PageId := Page::"Sales Quote"
                        else
                            if SHeader."Document Type" = SHeader."Document Type"::"Return Order" then
                                PageId := Page::"Sales Return Order";


        Clear(BodyText);
        if GLSetup."LCY Code" <> 'INR' then
            BodyText.Append('<style>table, th, td { border-collapse: collapse; border: 1px solid black;} table.a { table-layout: auto;  width: 560px; } table.b { table-layout: auto;  width: 1100px; } table.c { table-layout: auto;  width: 670px; }table.d { table-layout: auto;  width: 420px; } </style>')
        else
            BodyText.Append('<style>table, th, td { border-collapse: collapse; border: 1px solid black;} table.a { table-layout: auto;  width: 560px; } table.b { table-layout: auto;  width: 1100px; } table.c { table-layout: auto;  width: 670px; }table.d { table-layout: auto;  width: 420px; } </style>');

        if ToUser = 'SENDER' then
            BodyText.Append('Hello ' + Sender."Full Name" + '<br><br>You are registered to receive notifications related to ' + CompanyName + '.')
        else
            BodyText.Append('Hello ' + Receiver."Full Name" + '<br><br>You are registered to receive notifications related to ' + CompanyName + '.');


        // if ActionText = 'cancelled' then
        BodyText.Append('<br><br>This is a message to notify you that Sales ');
        // BodyText.Append('<br><br>');
        BodyText.Append(StrSubstNo('<a style="text-decoration:none;color:black;cursor:auto" href="#">%1 %2</a> %3', FORMAT(SHeader."Document Type"), FORMAT(SHeader."No."), ActionText));

        BodyText.Append('<br><br>');
        If SHeader."Short Close Approval Required" then begin//Yh
            BodyText.Append('<p style="color:red;"> Please Note - Approval Required for short closing the Document.</p>');
            BodyText.Append('<br><br>');
            BodyText.Append('<p style="color:red;"> Short Close Reason - ' + SHeader."Short Close Reason" + '</p>');
        end;
        BodyText.Append('<br><br>');
        TestText := StrSubstNo('<p><a href="%1">' + SHeader."No." + '</a>', GetUrl(ClientType::Web, CompanyName, ObjectType::Page, PageId, SHeader, False)) + ' - ' + ShortName."Short Name" + '</p>';
        // TestText := SHeader."No." + ' - ' + ShortName."Short Name";
        //<table   -removed border
        BodyText.Append('<table class="a">');
        BodyText.Append('<tr style="background-color:#B4C6E7"><td colspan="2" align="left"><b>SO Summary</b></td></tr>');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#D9E1F2"> <font> <b> Sales ' + FORMAT(SHeader."Document Type") + ' No. </b> </font></td>');
        BodyText.Append('<td align="left"> <font> ' + TestText + '</font></td>');
        BodyText.Append('</tr>');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#D9E1F2"> <font> <b> Customer Purchase Order No. </b> </font></td>');
        BodyText.Append('<td align="left"> <font> ' + SHeader."External Document No." + '</font></td>');
        BodyText.Append('</tr>');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#D9E1F2"> <font> <b> Customer No.<br> Customer Name </b></font></td>');
        if RecCustomer.AltCustomerName <> '' then
            BodyText.Append('<td align="left"> <font> ' + SHeader."Sell-to Customer No." + '<br>' + RecCustomer.AltCustomerName + '</font></td>')
        else
            BodyText.Append('<td align="left"> <font> ' + SHeader."Sell-to Customer No." + '<br>' + RecCustomer.Name + ' </font ></td>');

        BodyText.Append('</tr>');
        BodyText.Append('<tr>');

        BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#D9E1F2"> <font> <b> Sales Amount: </b></font></td>');
        SHeader.CalcFields("Amount Including VAT", "Salesperson Name");

        if GLSetup."LCY Code" = 'AED' then begin
            if SHeader."Currency Factor" <> 0 then
                BodyText.Append('<td align="left"> <font> ' + SHeader."Currency Code" + ' ' + FORMAT(SHeader."Amount Including VAT", 0, '<Precision,2:2><Standard Format,0>') + ' (' + GLSetup."LCY Code" + ' ' + FORMAT(SHeader."Amount Including VAT" / SHeader."Currency Factor", 0, '<Precision,2:2><Standard Format,0>') + ') </font></td>')
            else
                BodyText.Append('<td align="left"> <font> ' + GLSetup."LCY Code" + ' ' + FORMAT(SHeader."Amount Including VAT", 0, '<Precision,2:2><Standard Format,0>') + '</font></td>');
        end else begin
            if SHeader."Currency Code" <> '' then
                BodyText.Append('<td align="left"> <font> ' + SHeader."Currency Code" + ' ' + FORMAT(SHeader."Amount Including VAT", 0, '<Precision,2:2><Standard Format,0>') + ' (AED ' + FORMAT(CurrencyExchangeRate.ExchangeAmount(SHeader."Amount Including VAT", SHeader."Currency Code", 'AED', SHeader."Posting Date"), 0, '<Precision,2:2><Standard Format,0>') + ') </font></td>')
            else
                // BodyText.Append('<td align="left"> <font> ' + GLSetup."LCY Code" + ' ' + FORMAT(SHeader."Amount Including VAT", 0, '<Precision,2:2><Standard Format,0>') + ' (AED ' + FORMAT(CurrencyExchangeRate.ExchangeAmount(SHeader."Amount Including VAT", GLSetup."LCY Code", 'AED', SHeader."Posting Date"), 0, '<Precision,2:2><Standard Format,0>') + ') </font></td>');
                BodyText.Append('<td align="left"> <font> ' + GLSetup."LCY Code" + ' ' + FORMAT(SHeader."Amount Including VAT", 0, '<Precision,2:2><Standard Format,0>') + ' (AED ' + FORMAT(CurrencyExchangeRate.ExchangeAmount(SHeader."Amount Including VAT", '', 'AED', SHeader."Posting Date"), 0, '<Precision,2:2><Standard Format,0>') + ') </font></td>'); //Finding amount in LCY and then in AED.
        end;
        BodyText.Append('</tr>');

        if SHeader."Payment Terms Code" <> '' then begin
            RecPaymentTerms.GET(SHeader."Payment Terms Code");
            if RecPaymentTermsCustomer.Get(RecCustomer."Payment Terms Code") then;
            BodyText.Append('<tr>');
            BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#D9E1F2"> <font> <b> SO Payment Terms <br> System Payment Terms</b> </font></td>');
            PaymentTermsText := RecPaymentTerms.Description;
            SystemPaymentTermsText := RecPaymentTermsCustomer.Description;


            if (PaymentTermsText <> SystemPaymentTermsText) then
                ColorText1 := StrSubstNo(ColorText1C, 'Red', 'bold')
            else
                ColorText1 := StrSubstNo(ColorText1C, 'Black', 'normal');

            BodyText.Append('<td align="left"> <font ' + ColorText1 + '> ' + PaymentTermsText + '</font><br><font>' + SystemPaymentTermsText + ' </font></td>');

            BodyText.Append('</tr>');
        end;

        Incoterm := '';
        Portofloading := '';
        Portofdischarge := '';
        CustomerFinalDestination := '';
        CustomerShippingAdress := '';            //ISPl-RV-N
        CustomerShippingAdressStyle := '';            //ISPl-RV-N
        TransactionTypeDescription := '';

        // if SHeader."Transaction Specification" <> '' then begin
        //     RecTransactionSpecification.get(SHeader."Transaction Specification");
        //     Incoterm := RecTransactionSpecification.Text;
        // end;

        if SHeader."Shipment Method Code" <> '' then begin
            Incoterm := SHeader."Shipment Method Code";
            If SHeader."Shipment Method Approval" then
                IncotermStyle := StrSubstNo(ColorText1C, 'Red', 'bold') else
                IncotermStyle := StrSubstNo(ColorText1C, 'Black', 'normal');

        end;
        if SHeader."Exit Point" <> '' then begin
            RecExit.Get(SHeader."Exit Point");
            Portofloading := RecExit.Description;
        end;
        if SHeader."Area" <> '' then begin
            RecArea.get(SHeader."Area");
            Portofdischarge := RecArea.Text;
        end;

        GetFinalDestinationApproval(SHeader, CustomerFinalDestination);
        // if SHeader."Customer Final Destination" <> '' then begin
        //     RecCustomerFinalDestination.Get(SHeader."Customer Final Destination");
        //     CustomerFinalDestination := RecCustomerFinalDestination.Text;
        // end;
        if Country_lRec.Get(SHeader."Ship-to Country/Region Code") then;
        if SHeader."Ship-to Name" <> '' then
            CustomerShippingAdress := '<B>' + SHeader."Ship-to Name" + '</B><Br/>';
        If SHeader."Ship-to Address" <> '' then
            CustomerShippingAdress += SHeader."Ship-to Address" + '<Br/>';
        If SHeader."Ship-to Address 2" <> '' then
            CustomerShippingAdress += Sheader."Ship-to Address 2" + ',<Br/>';
        if SHeader."Ship-to City" <> '' then
            CustomerShippingAdress += SHeader."Ship-to City" + ',<Br/>';
        If SHeader."Ship-to Country/Region Code" <> '' then
            CustomerShippingAdress += Country_lRec.Name;
        if SHeader."Ship-to Post Code" <> '' then
            CustomerShippingAdress += ', ' + SHeader."Ship-to Post Code" + '<Br/>';
        // If SHeader."Ship-to Phone No." <> '' then
        //     CustomerShippingAdress += '<B>Phone No.: </B>' + SHeader."Ship-to Phone No.";

        IF SHeader."Custom Ship to Option" then begin
            CustomerShippingAdressStyle := StrSubstNo(ColorText1C, 'Red', 'bold')
        end else
            CustomerShippingAdressStyle := StrSubstNo(ColorText1C, 'Black', 'normal');

        if SHeader."Transaction Type" <> '' then begin
            RecTransactionType.get(SHeader."Transaction Type");
            TransactionTypeDescription := RecTransactionType.Description;
        end;

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#D9E1F2"> <font> <b> Incoterms </b> </font></td>');
        BodyText.Append('<td align="left"> <font ' + IncotermStyle + '> ' + Incoterm + '</font></td>');
        BodyText.Append('</tr>');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#D9E1F2"> <font> <b> Port of Loading </b> </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Portofloading + '</font></td>');
        BodyText.Append('</tr>');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#D9E1F2"> <font> <b> Port of Discharge </b> </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Portofdischarge + '</font></td>');
        BodyText.Append('</tr>');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#D9E1F2"> <font> <b> Customer Shipping Address </b> </font></td>');
        BodyText.Append('<td align="left"> <font ' + CustomerShippingAdressStyle + '> ' + CustomerShippingAdress + '</font></td>');
        BodyText.Append('</tr>');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#D9E1F2"> <font> <b> Customer Final Destination </b> </font></td>');
        BodyText.Append('<td align="left"> <font>  ' + CustomerFinalDestination + '</font></td>');
        BodyText.Append('</tr>');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#D9E1F2"> <font> <b> Order Type </b> </font></td>');
        BodyText.Append('<td align="left"> <font> ' + TransactionTypeDescription + '</font></td>');
        BodyText.Append('</tr>');

        if SHeader."Salesperson Code" <> '' then begin
            BodyText.Append('<tr>');
            BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#D9E1F2"> <font> <b> Salesperson <br> Sales Team </b> </font></td>');
            Clear(RecteamSalesPerson);
            RecteamSalesPerson.SetRange("Salesperson Code", SHeader."Salesperson Code");
            if RecteamSalesPerson.FindFirst() then begin
                Clear(Recteams);
                if Recteams.GET(RecteamSalesPerson."Team Code") then
                    BodyText.Append('<td align="left" > <font> ' + SHeader."Salesperson Name" + ' <br> ' + Recteams.Name + ' </font></td>')
                else
                    BodyText.Append('<td align="left"> <font> ' + SHeader."Salesperson Name" + ' </font></td>');
            end else
                BodyText.Append('<td align="left"> <font> ' + SHeader."Salesperson Name" + ' </font></td>');
            BodyText.Append('</tr>');
        end;
        BodyText.Append('</table>');
        BodyText.Append('<br>');

        Clear(RecLines);
        RecLines.SetCurrentKey("Line No.");
        RecLines.SetAscending("Line No.", true);
        RecLines.SetRange("Document Type", SHeader."Document Type");
        RecLines.SetRange("Document No.", SHeader."No.");
        RecLines.SetRange(Type, RecLines.Type::Item);
        if RecLines.FindSet() then begin
            BodyText.Append('<table class="b">');
            Clear(TotalAmt);
            Clear(TotalQty);

            BodyText.Append('<tr style="background-color:#B4C6E7"><td colspan="8" align="left"><b>Product Info.</b></td></tr>');
            BodyText.Append('<tr>');
            BodyText.Append('<td align="left" Style="width:185px;padding-left:5px;background-color:#D9E1F2">  <font> <b>Product Details <br><span style="font-size:11px;">(Item Code, Variant Code, HS Code & COO)</span></b> </font></td>');
            BodyText.Append('<td align="left" Style="width:185px;padding-left:5px;background-color:#D9E1F2"> <font><b> Customer Requested </b></font></td>');
            BodyText.Append('<td align="left" Style="width:100px;padding-left:5px;background-color:#D9E1F2"> <font><b> Quantity </b></font></td>');
            BodyText.Append('<td align="right" Style="width:100px;padding-right:5px;background-color:#D9E1F2"> <font><b> Unit Price </b></font></td>');
            BodyText.Append('<td align="right" Style="width:100px;padding-right:5px;background-color:#D9E1F2"> <font><b> System Price </b></font></td>');
            BodyText.Append('<td align="right" Style="width:110px;padding-right:5px;background-color:#D9E1F2"> <font><b> Total </b></font></td>');
            BodyText.Append('<td align="left" Style="width:110px;padding-left:5px;background-color:#D9E1F2"> <font><b> Packing </b></font></td>');
            BodyText.Append('<td align="left" Style="width:120px; padding-left:5px;background-color:#D9E1F2"> <font><b> Warehouse <br> City </b></font></td>');
            BodyText.Append('</tr>');
            repeat
                RecItem.GET(RecLines."No.");
                //10-10-2022 removed above code and added below as per new changes


                ItemDesc := RecItem.Description;
                PackingDesc := RecItem."Description 2";
                if RecLines."Variant Code" <> '' then begin
                    ItemVariant.Get(RecItem."No.", RecLines."Variant Code");
                    if ItemVariant."Packing Description" <> '' then begin
                        PackingDesc := ItemVariant."Packing Description";
                    end else begin
                        PackingDesc := RecItem."Description 2";
                    end;
                    if ItemVariant.Description <> '' then begin
                        ItemDesc := ItemVariant.Description;
                    end else begin
                        ItemDesc := RecItem.Description;
                    end;
                end;

                //if (RecLines."Price Change %" < 0) then
                if (RecLines."Unit Price Base UOM 2" < RecLines."Selling Price") then
                    ColorText := StrSubstNo(UnitPriceColor, 'Red', 'bold')
                else
                    ColorText := StrSubstNo(UnitPriceColor, 'Black', 'normal');

                if (ItemDesc <> RecLines.Description) then
                    ColorTextDes := StrSubstNo(ColorTextDesC, 'Red', 'bold')
                else
                    ColorTextDes := StrSubstNo(ColorTextDesC, 'Black', 'normal');

                if (RecLines.HSNCode <> RecLines.LineHSNCode) then
                    ColorTextHS := StrSubstNo(ColorTextHSC, 'Red', 'bold')
                else
                    ColorTextHS := StrSubstNo(ColorTextHSC, 'Black', 'normal');

                if (RecLines.CountryOfOrigin <> RecLines.LineCountryOfOrigin) then
                    ColorTextCOO := StrSubstNo(ColorTextCOOC, 'Red', 'bold')
                else
                    ColorTextCOO := StrSubstNo(ColorTextCOOC, 'Black', 'normal');

                BodyText.Append('<tr>');
                VariantCode := '';
                if RecLines."Variant Code" <> '' then
                    VariantCode := ' / ' + RecLines."Variant Code";

                BodyText.Append('<td align="left" Style="padding-left:5px"> <font> ' + RecLines."No." + VariantCode + '<br>' + ItemDesc + '<br>' + RecLines.HSNCode + '<br>' + RecLines.CountryOfOrigin + '</font></td>');
                BodyText.Append('<td align="left" Style="padding-left:5px"> ' + RecLines."No." + VariantCode + '<br><font ' + ColorTextDes + '> ' + RecLines.Description + '</font><br><font ' + ColorTextHS + '> ' + RecLines.LineHSNCode + '</font><br><font ' + ColorTextCOO + '> ' + RecLines.LineCountryOfOrigin + ' </font></td>');
                BodyText.Append('<td align="left" Style="padding-left:5px"> <font> ' + FORMAT(RecLines."Quantity (Base)") + ' ' + RecLines."Base UOM 2" + '  </font></td>');

                if SHeader."Currency Code" <> '' then
                    BodyText.Append('<td align="right" Style="padding-right:5px"> <font ' + ColorText + '> ' + SHeader."Currency Code" + ' <br/> ' + FORMAT(RecLines."Unit Price Base UOM 2", 0, '<Precision,2:2><Standard Format,0>') + '  </font></td>')
                else
                    BodyText.Append('<td align="right" Style="padding-right:5px"> <font  ' + ColorText + '> ' + GLSetup."LCY Code" + '<br/> ' + FORMAT(RecLines."Unit Price Base UOM 2", 0, '<Precision,2:2><Standard Format,0>') + '  </font></td>');


                if SHeader."Currency Code" <> '' then
                    BodyText.Append('<td align="right" Style="padding-right:5px"> <font> ' + SHeader."Currency Code" + ' <br/> ' + FORMAT(RecLines."Selling Price", 0, '<Precision,2:2><Standard Format,0>') + '  </font></td>')
                else
                    BodyText.Append('<td align="right" Style="padding-right:5px"> <font>' + GLSetup."LCY Code" + '<br/>  ' + FORMAT(RecLines."Selling Price", 0, '<Precision,2:2><Standard Format,0>') + '  </font></td>');

                if SHeader."Currency Code" <> '' then
                    BodyText.Append('<td align="right" Style="padding-right:5px"> <font> ' + SHeader."Currency Code" + '<br/> ' + FORMAT(RecLines."Unit Price Base UOM 2" * RecLines."Quantity (Base)", 0, '<Precision,2:2><Standard Format,0>') + '  </font></td>')
                else
                    BodyText.Append('<td align="right" Style="padding-right:5px"> <font> ' + GLSetup."LCY Code" + ' <br/> ' + FORMAT(RecLines."Unit Price Base UOM 2" * RecLines."Quantity (Base)", 0, '<Precision,2:2><Standard Format,0>') + '  </font></td>');


                TotalAmt += RecLines."Unit Price Base UOM 2" * RecLines."Quantity (Base)";
                TotalQty += RecLines."Quantity (Base)";


                BodyText.Append('<td align="left" Style="padding-left:5px"> <font>   ' + PackingDesc + ' </font></td>');

                if RecLines."Location Code" <> '' then
                    RecLocation.Get(RecLines."Location Code");
                BodyText.Append('<td align="left" Style="padding-left:5px"> <font>   ' + RecLines."Location Code" + '<br>' + RecLocation.City + ' </font></td>');
                BodyText.Append('</tr>');
            until RecLines.Next() = 0;


            //added to show total for each UOM -start
            J := 1;
            Clear(UOMCheck);
            Clear(RecLines);
            RecLines.SetCurrentKey("Line No.");
            RecLines.SetAscending("Line No.", true);
            RecLines.SetRange("Document Type", SHeader."Document Type");
            RecLines.SetRange("Document No.", SHeader."No.");
            RecLines.SetRange(Type, RecLines.Type::Item);
            if RecLines.FindSet() then begin
                UOMCount := GetNumberUOMOnOrder(RecLines);
                repeat
                    if not UOMCheck.Contains(RecLines."Base UOM 2") then begin
                        UOMCheck.Add(RecLines."Base UOM 2");

                        Clear(RecLines2);
                        RecLines2.SetCurrentKey("Line No.");
                        RecLines2.SetAscending("Line No.", true);
                        RecLines2.SetRange("Document Type", SHeader."Document Type");
                        RecLines2.SetRange("Document No.", SHeader."No.");
                        RecLines2.SetRange(Type, RecLines2.Type::Item);
                        RecLines2.SetRange("Base UOM 2", RecLines."Base UOM 2");
                        if RecLines2.FindSet() then begin
                            // RecLines2.CalcSums("Quantity (Base)");
                            Clear(TotalAmt);
                            Clear(TotalQty);
                            repeat
                                TotalAmt += RecLines2."Unit Price Base UOM 2" * RecLines2."Quantity (Base)";
                                TotalQty += RecLines2."Quantity (Base)";
                            until RecLines2.Next() = 0;

                            BodyText.Append('<tr style="border:none;">');
                            if J = 1 then begin
                                if UOMCount = J then
                                    BodyText.Append('<td align="left" Style="padding-left:5px;border:none;border-bottom: double"> <font> <b>TOTAL</b> </font></td>')
                                else
                                    BodyText.Append('<td align="left" Style="width:120px;padding-left:5px; border:none"> <font> <b>TOTAL</b> </font></td>')
                            end else begin
                                if UOMCount = J then
                                    BodyText.Append('<td align="left" Style="padding-left:5px;border:none;border-bottom: double"></td>')
                                else
                                    BodyText.Append('<td align="left"></td>')
                            end;

                            if UOMCount = J then begin
                                BodyText.Append('<td align="left" Style="padding-left:5px;border:none;border-bottom: double"></td>');
                                BodyText.Append('<td align="left" Style="padding-left:5px;border:none;border-bottom: double"> <font> <b>' + FORMAT(TotalQty) + ' ' + RecLines."Base UOM 2" + '</b> </font></td>');
                                BodyText.Append('<td align="left" Style="padding-left:5px;border:none;border-bottom: double"></td>');
                                BodyText.Append('<td align="left" Style="padding-left:5px;border:none;border-bottom: double"></td>');
                                if SHeader."Currency Code" <> '' then
                                    BodyText.Append('<td align="right" Style="padding-right:5px;border:none;border-bottom: double"> <font> <b>' + SHeader."Currency Code" + ' <br/> ' + FORMAT(TotalAmt, 0, '<Precision,2:2><Standard Format,0>') + '</b> </font></td>')
                                else
                                    BodyText.Append('<td align="right" Style="padding-right:5px;border:none;border-bottom: double"> <font> <b>' + GLSetup."LCY Code" + ' <br/> ' + FORMAT(TotalAmt, 0, '<Precision,2:2><Standard Format,0>') + '</b> </font></td>');
                            end else begin
                                BodyText.Append('<td align="left" Style="padding-left:5px;border:none;"></td>');
                                BodyText.Append('<td align="left" Style="padding-left:5px;border:none;"> <font> <b>' + FORMAT(TotalQty) + ' ' + RecLines."Base UOM 2" + '</b> </font></td>');
                                BodyText.Append('<td align="left" Style="padding-left:5px;border:none;"></td>');
                                BodyText.Append('<td align="left" Style="padding-left:5px;border:none;"></td>');
                                if SHeader."Currency Code" <> '' then
                                    BodyText.Append('<td align="right" Style="padding-right:5px;border:none;"> <font> <b>' + SHeader."Currency Code" + ' <br/> ' + FORMAT(TotalAmt, 0, '<Precision,2:2><Standard Format,0>') + '</b> </font></td>')
                                else
                                    BodyText.Append('<td align="right" Style="padding-right:5px;border:none;"> <font> <b>' + GLSetup."LCY Code" + ' <br/> ' + FORMAT(TotalAmt, 0, '<Precision,2:2><Standard Format,0>') + '</b> </font></td>');
                            end;

                            BodyText.Append('<td align="left" Style="padding-left:5px;border:none;"></td>');
                            BodyText.Append('<td align="left" Style="padding-left:5px;border:none;"></td>');
                            J += 1;
                            BodyText.Append('</tr>');
                        end;
                    end;
                Until RecLines.Next() = 0;
            end;

            //-end

            BodyText.Append('</table>');
            BodyText.Append('<br>');
        end;


        if SHeader."Document Type" = SHeader."Document Type"::Order then begin
            if GLSetup."LCY Code" <> 'INR' then begin
                BodyText.Append('<table class="d">');

                BodyText.Append('<tr style="background-color:#B4C6E7"><td colspan="3" align="left"><b>Credit Info.</b></td></tr>');
                BodyText.Append('<tr>');
                BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#D9E1F2"> <font> <b>Credit Insurance:</b> </font></td>');//, 0, '<Precision,2:2><Standard Format,0>'
                BodyText.Append('<td align="right" colspan="2" Style="padding-left:5px;padding-right:5px"> <font> ' + GLSetup."LCY Code" + ' ' + FORMAT(RecCustomer."Insurance Limit (LCY) 2", 0, '<Precision,0:0><Standard Format,0>') + ' </font></td>');
                BodyText.Append('</tr>');

                BodyText.Append('<tr>');
                BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#D9E1F2"> <font> <b>Credit Limit:</b> </font></td>');//, 0, '<Precision,2:2><Standard Format,0>'
                BodyText.Append('<td align="right" colspan="2" Style="padding-left:5px;padding-right:5px"> <font> ' + GLSetup."LCY Code" + ' ' + FORMAT(RecCustomer."Credit Limit (LCY)", 0, '<Precision,0:0><Standard Format,0>') + ' </font></td>');
                BodyText.Append('</tr>');
                SHeader.CalcFields("Amount Including VAT");
                RecCustomer.CalcFields("Balance (LCY)", "Orders (LCY)-InProcess", "Shipped Not Invoiced (LCY)");

                AvailableLimit := RecCustomer."Credit Limit (LCY)" - RecCustomer."Balance (LCY)" - RecCustomer."Orders (LCY)-InProcess" - RecCustomer."Shipped Not Invoiced (LCY)";// - SHeader."Amount Including VAT";
                UsedLimit := RecCustomer."Balance (LCY)" + RecCustomer."Orders (LCY)-InProcess" + RecCustomer."Shipped Not Invoiced (LCY)";// + SHeader."Amount Including VAT";

                BodyText.Append('<tr>');
                BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#D9E1F2"> <font> <b>Credit used (inclusive):</b> </font></td>');//, 0, '<Precision,2:2><Standard Format,0>'
                if UsedLimit > RecCustomer."Credit Limit (LCY)" then
                    BodyText.Append('<td align="right" colspan="2" Style="padding-right:5px"> <font style="color:Red"; font-weight: bold> ' + GLSetup."LCY Code" + ' ' + FORMAT(UsedLimit, 0, '<Precision,0:0><Standard Format,0>') + ' </font></td>')
                else
                    BodyText.Append('<td align="right" colspan="2" Style="padding-right:5px"> <font> ' + GLSetup."LCY Code" + ' ' + FORMAT(UsedLimit, 0, '<Precision,0:0><Standard Format,0>') + ' </font></td>');

                BodyText.Append('</tr>');

                BodyText.Append('<tr>');
                BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#D9E1F2"> <font> <b>Credit Utilization:</b> </font></td>');

                if UsedLimit > RecCustomer."Credit Limit (LCY)" then
                    BodyText.Append('<td align="right" colspan="2" Style="padding-right:5px"> <font style="color:Red"; font-weight: bold> ' + FORMAT((UsedLimit / RecCustomer."Credit Limit (LCY)") * 100, 0, '<Precision,0:0><Standard Format,0>') + '% </font></td>')
                else
                    BodyText.Append('<td align="right" colspan="2" Style="padding-right:5px"> <font> ' + FORMAT((UsedLimit / RecCustomer."Credit Limit (LCY)") * 100, 0, '<Precision,0:0><Standard Format,0>') + '% </font></td>');

                BodyText.Append('</tr>');

                BodyText.Append('<tr>');
                BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#D9E1F2"> <font> <b>Overlimit Amount:</b> </font></td>');//, 0, '<Precision,2:2><Standard Format,0>'
                if AvailableLimit < 0 then
                    BodyText.Append('<td align="right" colspan="2" Style="padding-right:5px"> <font style="color:Red"; font-weight: bold> ' + GLSetup."LCY Code" + ' ' + FORMAT(AvailableLimit, 0, '<Precision,0:0><Standard Format,0>') + ' </font></td>')
                else
                    BodyText.Append('<td align="right" colspan="2" Style="padding-right:5px"> <font> ' + GLSetup."LCY Code" + ' ' + FORMAT(0.00, 0, '<Precision,0:0><Standard Format,0>') + ' </font></td>');

                BodyText.Append('</tr>');


                BodyText.Append('<tr>');
                BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#D9E1F2"> <font> <b>Overdue Amount:</b> </font></td>');
                BodyText.Append('<td align="right" colspan="2" Style="padding-right:5px"> <font> ' + GLSetup."LCY Code" + ' ' + FORMAT(RecCustomer.CalcOverdueBalance(), 0, '<Precision,0:0><Standard Format,0>') + ' </font></td>');
                BodyText.Append('</tr>');


                Clear(RecCLE);
                RecCLE.SetRange("Customer No.", RecCustomer."No.");
                //RecCLE.SetFilter("Due Date", '<%1', WorkDate());
                RecCLE.SetRange(Open, true);
                if RecCLE.FindSet() then begin
                    repeat
                        if RecCLE."Closed at Date" > RecCLE."Due Date" then begin
                            if (RecCLE."Closed at Date" - RecCLE."Due Date") > 30 then begin
                                RecCLE.CalcFields("Remaining Amt. (LCY)");
                                BodyText.Append('<tr>');
                                BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Overdue History (>30d): </font></td>');
                                BodyText.Append('<td align="right" Style="padding-right:5px"> <font>' + FORMAT(RecCLE."Due Date", 0, '<Day,2>/<Month,3>/<Year4>') + ' </font></td>');
                                BodyText.Append('<td align="right" Style="padding-right:5px"> <font> ' + GLSetup."LCY Code" + ' ' + FORMAT(RecCLE."Remaining Amt. (LCY)", 0, '<Precision,0:0><Standard Format,0>') + ' </font></td>');
                                BodyText.Append('</tr>');
                            end;
                        end;
                    until RecCLE.Next() = 0;
                end;///////////@@@@@@@@@@@@

                BodyText.Append('</table><br>');
            end else begin
                BodyText.Append('<table class="d">');
                BodyText.Append('<tr style="background-color:#B4C6E7"><td colspan="3" align="left"><b>Credit Info.</b></td></tr>');
                BodyText.Append('<tr>');
                BodyText.Append('<td align="left" Style="padding-left:5pxbackground-color:#D9E1F2"> <font> <b>Credit Insurance:</b> </font></td>');//, 0, '<Precision,2:2><Standard Format,0>'
                BodyText.Append('<td align="right" colspan="2" Style="padding-left:5px;padding-right:5px"> <font> INR ' + FORMAT(RecCustomer."Insurance Limit (LCY) 2", 0, '<Precision,0:0><Standard Format,0>') + ' (AED ' + FORMAT(CurrencyExchangeRate.ExchangeAmount(RecCustomer."Insurance Limit (LCY) 2", '', 'AED', SHeader."Posting Date"), 0, '<Precision,0:0><Standard Format,0>') + ') </font></td>');
                BodyText.Append('</tr>');

                BodyText.Append('<tr>');
                BodyText.Append('<td align="left" Style="padding-left:5pxbackground-color:#D9E1F2"> <font> <b>Credit Limit:</b> </font></td>');//, 0, '<Precision,2:2><Standard Format,0>'
                BodyText.Append('<td align="right" colspan="2" Style="padding-left:5px;padding-right:5px"> <font> INR ' + FORMAT(RecCustomer."Credit Limit (LCY)", 0, '<Precision,0:0><Standard Format,0>') + ' (AED ' + FORMAT(CurrencyExchangeRate.ExchangeAmount(RecCustomer."Credit Limit (LCY)", '', 'AED', SHeader."Posting Date"), 0, '<Precision,0:0><Standard Format,0>') + ') </font></td>');
                BodyText.Append('</tr>');
                SHeader.CalcFields("Amount Including VAT");
                RecCustomer.CalcFields("Balance (LCY)", "Orders (LCY)-InProcess", "Shipped Not Invoiced (LCY)");

                AvailableLimit := RecCustomer."Credit Limit (LCY)" - RecCustomer."Balance (LCY)" - RecCustomer."Orders (LCY)-InProcess" - RecCustomer."Shipped Not Invoiced (LCY)";// - SHeader."Amount Including VAT";
                UsedLimit := RecCustomer."Balance (LCY)" + RecCustomer."Orders (LCY)-InProcess" + RecCustomer."Shipped Not Invoiced (LCY)";// + SHeader."Amount Including VAT";

                BodyText.Append('<tr>');
                BodyText.Append('<td align="left" Style="padding-left:5pxbackground-color:#D9E1F2"> <font> <b>Credit used (inclusive):</b> </font></td>');//, 0, '<Precision,2:2><Standard Format,0>'
                if UsedLimit > RecCustomer."Credit Limit (LCY)" then
                    BodyText.Append('<td align="right" colspan="2" Style="padding-right:5px"> <font style="color:Red"; font-weight: bold> INR ' + FORMAT(UsedLimit, 0, '<Precision,0:0><Standard Format,0>') + ' (AED ' + FORMAT(CurrencyExchangeRate.ExchangeAmount(UsedLimit, '', 'AED', SHeader."Posting Date"), 0, '<Precision,0:0><Standard Format,0>') + ') </font></td>')
                else
                    BodyText.Append('<td align="right" colspan="2" Style="padding-right:5px"> <font> INR ' + FORMAT(UsedLimit, 0, '<Precision,0:0><Standard Format,0>') + ' (AED ' + FORMAT(CurrencyExchangeRate.ExchangeAmount(UsedLimit, '', 'AED', SHeader."Posting Date"), 0, '<Precision,0:0><Standard Format,0>') + ') </font></td>');

                BodyText.Append('</tr>');

                BodyText.Append('<tr>');
                BodyText.Append('<td align="left" Style="padding-left:5pxbackground-color:#D9E1F2"> <font> <b>Credit Utilization:</b> </font></td>');

                if UsedLimit > RecCustomer."Credit Limit (LCY)" then
                    BodyText.Append('<td align="right" colspan="2" Style="padding-right:5px"> <font style="color:Red"; font-weight: bold> ' + FORMAT((UsedLimit / RecCustomer."Credit Limit (LCY)") * 100, 0, '<Precision,0:0><Standard Format,0>') + '% </font></td>')
                else
                    BodyText.Append('<td align="right" colspan="2" Style="padding-right:5px"> <font> ' + FORMAT((UsedLimit / RecCustomer."Credit Limit (LCY)") * 100, 0, '<Precision,0:0><Standard Format,0>') + '% </font></td>');

                BodyText.Append('</tr>');

                BodyText.Append('<tr>');
                BodyText.Append('<td align="left" Style="padding-left:5pxbackground-color:#D9E1F2"> <font><b> Overlimit Amount: </b></font></td>');//, 0, '<Precision,2:2><Standard Format,0>'
                if AvailableLimit < 0 then
                    BodyText.Append('<td align="right" colspan="2" Style="padding-right:5px"> <font style="color:Red"; font-weight: bold> INR ' + FORMAT(AvailableLimit, 0, '<Precision,0:0><Standard Format,0>') + ' (AED ' + FORMAT(CurrencyExchangeRate.ExchangeAmount(AvailableLimit, '', 'AED', SHeader."Posting Date"), 0, '<Precision,0:0><Standard Format,0>') + ') </font></td>')
                else
                    BodyText.Append('<td align="right" colspan="2" Style="padding-right:5px"> <font> INR ' + FORMAT(0.00, 0, '<Precision,0:0><Standard Format,0>') + ' (AED' + FORMAT(0.00, 0, '<Precision,0:0><Standard Format,0>') + ') </font></td>');

                BodyText.Append('</tr>');


                BodyText.Append('<tr>');
                BodyText.Append('<td align="left" Style="padding-left:5pxbackground-color:#D9E1F2"> <font> <b>Overdue Amount: </b></font></td>');
                BodyText.Append('<td align="right" colspan="2" Style="padding-right:5px"> <font> INR ' + FORMAT(RecCustomer.CalcOverdueBalance(), 0, '<Precision,0:0><Standard Format,0>') + ' (AED ' + FORMAT(CurrencyExchangeRate.ExchangeAmount(RecCustomer.CalcOverdueBalance(), '', 'AED', SHeader."Posting Date"), 0, '<Precision,0:0><Standard Format,0>') + ') </font></td>');
                BodyText.Append('</tr>');


                Clear(RecCLE);
                RecCLE.SetRange("Customer No.", RecCustomer."No.");
                //RecCLE.SetFilter("Due Date", '<%1', WorkDate());
                RecCLE.SetRange(Open, true);
                if RecCLE.FindSet() then begin
                    repeat
                        if RecCLE."Closed at Date" > RecCLE."Due Date" then begin
                            if (RecCLE."Closed at Date" - RecCLE."Due Date") > 30 then begin
                                RecCLE.CalcFields("Remaining Amt. (LCY)");
                                BodyText.Append('<tr>');
                                BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Overdue History (>30d): </font></td>');
                                BodyText.Append('<td align="right" Style="padding-right:5px"> <font>' + FORMAT(RecCLE."Due Date", 0, '<Day,2>/<Month,3>/<Year4>') + ' </font></td>');
                                BodyText.Append('<td align="right" Style="padding-right:5px"> <font> INR ' + FORMAT(RecCLE."Remaining Amt. (LCY)", 0, '<Precision,0:0><Standard Format,0>') + ' (AED ' + FORMAT(CurrencyExchangeRate.ExchangeAmount(RecCLE."Remaining Amt. (LCY)", '', 'AED', SHeader."Posting Date"), 0, '<Precision,0:0><Standard Format,0>') + ') </font></td>');
                                BodyText.Append('</tr>');
                            end;
                        end;
                    until RecCLE.Next() = 0;
                end;///////////@@@@@@@@@@@@

                BodyText.Append('</table><br>');
            end;
        end;


        BodyText.Append('<table class="c">');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="background-color:#B4C6E7"> <font> <b> Approval Process </b></font></td>');
        BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#B4C6E7"> <font> <b> Approvers </b></font></td>');
        BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#B4C6E7"> <font> <b> Date & Time </b></font></td>');
        BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#B4C6E7"> <font> <b> Remarks </b></font></td>');
        BodyText.Append('</tr>');




        Clear(RecApprovalEntry);
        RecApprovalEntry.SetCurrentKey("Sequence No.");
        RecApprovalEntry.SetAscending("Sequence No.", true);
        RecApprovalEntry.SetRange("Workflow Step Instance ID", RecAppEntry."Workflow Step Instance ID");
        RecApprovalEntry.SetRange("Table ID", RecAppEntry."Table ID");
        RecApprovalEntry.SetRange("Document Type", RecAppEntry."Document Type");
        RecApprovalEntry.SetRange("Document No.", RecAppEntry."Document No.");
        if RecApprovalEntry.FindSet() then begin
            repeat
                if RecApprovalEntry."Sequence No." = 1 then begin
                    Sender.Reset();
                    Sender.SetRange("User Name", RecApprovalEntry."Sender ID");
                    if Sender.FindFirst() then;
                    SenderName := Sender."Full Name";
                    BodyText.Append('<tr>');
                    BodyText.Append('<td align="left" Style="width:180px;padding-left:5px;vertical-align:top;text-align:left;background-color:#D9E1F2"> <font><b> Creator:</b> </font></td>');
                    BodyText.Append('<td align="left" Style="width:180px;padding-left:5px;vertical-align:top;text-align:left"> <font>' + SenderName + ' </font></td>');
                    BodyText.Append('<td align="left" Style="width:180px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry.SystemCreatedAt) + ' </font></td>');
                    BodyText.Append('<td align="left" Style="width:180px;padding-right:5px;vertical-align:top;text-align:left"> <font> </font></td>');
                    BodyText.Append('</tr>');
                end;

                if RecApprovalEntry."Sequence No." = 1 then begin
                    SequenceNumber := '1st Approver:';
                end else
                    if RecApprovalEntry."Sequence No." = 2 then begin
                        SequenceNumber := '2nd Approver:';
                    end else
                        if RecApprovalEntry."Sequence No." = 3 then begin
                            SequenceNumber := '3rd Approver:';
                        end else
                            if RecApprovalEntry."Sequence No." = 4 then begin
                                SequenceNumber := '4th Approver:';
                            end else
                                if RecApprovalEntry."Sequence No." = 5 then begin
                                    SequenceNumber := '5th Approver:';
                                end else
                                    if RecApprovalEntry."Sequence No." = 6 then begin
                                        SequenceNumber := '6th Approver:';
                                    end else
                                        if RecApprovalEntry."Sequence No." = 7 then begin
                                            SequenceNumber := '7th Approver:';
                                        end else
                                            if RecApprovalEntry."Sequence No." = 8 then begin
                                                SequenceNumber := '8th Approver:';
                                            end else
                                                if RecApprovalEntry."Sequence No." = 9 then begin
                                                    SequenceNumber := '9th Approver:'
                                                end else
                                                    if RecApprovalEntry."Sequence No." = 10 then begin
                                                        SequenceNumber := '10th Approver:';
                                                    end;

                Receiver.Reset();
                Receiver.SetRange("User Name", RecApprovalEntry."Approver ID");
                if Receiver.FindFirst() then;
                ApproverName := Receiver."Full Name";

                BodyText.Append('<tr>');
                BodyText.Append('<td align="left" Style="width:180px;padding-left:5px;vertical-align:top;text-align:left;background-color:#D9E1F2"> <font><b>' + SequenceNumber + '</b></font></td>');
                BodyText.Append('<td align="left" Style="width:180px;padding-left:5px;vertical-align:top;text-align:left"> <font>' + ApproverName + '</font></td>');


                if RecApprovalEntry.Status = RecApprovalEntry.Status::Approved then
                    BodyText.Append('<td align="left" Style="width:180px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry."Last Date-Time Modified") + ' </font></td>')
                else
                    if RecApprovalEntry.Status = RecApprovalEntry.Status::Open then
                        BodyText.Append('<td align="left" Style="width:180px;padding-right:5px;vertical-align:top;text-align:left"> <font> Pending Approval </font></td>')
                    else
                        if RecApprovalEntry.Status = RecApprovalEntry.Status::Canceled then
                            BodyText.Append('<td align="left" Style="width:180px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry."Last Date-Time Modified") + ' </font></td>')
                        else
                            if RecApprovalEntry.Status = RecApprovalEntry.Status::Created then
                                BodyText.Append('<td align="left" Style="width:180px;padding-right:5px;vertical-align:top;text-align:left"> <font>  Pending Approval  </font></td>')
                            else
                                if RecApprovalEntry.Status = RecApprovalEntry.Status::Rejected then
                                    BodyText.Append('<td align="left" Style="width:150px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry."Last Date-Time Modified") + ' </font></td>');



                BodyText.Append('<td align="left" Style="width:310px;padding-right:5px"> <font> ' + Format(RecApprovalEntry."Approver Remarks") + ' </font></td>');
                BodyText.Append('</tr>');
            until RecApprovalEntry.Next() = 0;
        end;

        BodyText.Append('</table>');
        BodyText.Append('<br>');
        BodyText.Append('<table class="d"><tr><td Style="width:150px;padding-left:5px;padding-right:5px;background-color:#B4C6E7"><b>Link to SO:</b></td> <td style="padding-left:5px;padding-right:5px;">' + StrSubstNo('<p> <a href="%1">Open document in Business Central</a> </p>', GetUrl(ClientType::Web, CompanyName, ObjectType::Page, PageId, SHeader, False)) + '</td></tr></table>');

        exit(BodyText.ToText());
    end;

    procedure GetNumberUOMOnOrder(RecLinesP: Record "Sales Line"): Integer
    var
        RecLinesL: Record "Sales Line";
        UOMCheck: List of [Text];
    begin
        RecLinesL.SetCurrentKey("Line No.");
        RecLinesL.SetAscending("Line No.", true);
        RecLinesL.SetRange("Document Type", RecLinesP."Document Type");
        RecLinesL.SetRange("Document No.", RecLinesP."Document No.");
        RecLinesL.SetRange(Type, RecLinesL.Type::Item);
        if RecLinesL.FindSet() then begin
            repeat
                if not UOMCheck.Contains(RecLinesL."Base UOM 2") then
                    UOMCheck.Add(RecLinesL."Base UOM 2");
            until RecLinesL.Next() = 0;
            exit(UOMCheck.Count);
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure GetFinalDestinationApproval(Var SalesHeader: Record "Sales Header"; Var FinaLDestination: Text)
    begin
    end;

}