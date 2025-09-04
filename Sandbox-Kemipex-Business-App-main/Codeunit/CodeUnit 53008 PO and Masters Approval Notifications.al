codeunit 53008 "PO and Masters Approval Notify"//T12370-Full Comment
{
    //T52160-O
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
    local procedure fnOnBeforeApprovalEntryInsert(VAR Rec: Record "Approval Entry"; VAR xRec: Record "Approval Entry"; CurrFieldNo: Integer)
    begin
        IF (xRec.Status = xRec.Status::Created) AND (Rec.Status = Rec.Status::Open) THEN begin
            fnSendNotificationToApprover(Rec);
            fnSendNotificationToSender(Rec);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelApprovalRequestsForRecordOnAfterSetApprovalEntryFilters', '', true, true)]
    local procedure OnCancelApprovalRequestsForRecordOnAfterSetApprovalEntryFilters(var ApprovalEntry: Record "Approval Entry"; RecRef: RecordRef);
    begin
        if ApprovalEntry.FindFirst() then begin
            fnSendCancelledNotificationToApprover(ApprovalEntry);
            fnSendCancelledNotificationToSender(ApprovalEntry);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeCreateApprovalEntryNotification', '', false, false)]
    local procedure OnBeforeCreateApprovalEntryNotification(ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean);
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        if PurchaseHeader.get(ApprovalEntry."Document Type", ApprovalEntry."Document No.") or
        (ApprovalEntry."Table ID" = Database::Vendor) or
        (ApprovalEntry."Table ID" = Database::Customer) or
        (ApprovalEntry."Table ID" = Database::Item) then
            IsHandled := true;

    end;

    //T52160-OS
    procedure fnSendNotificationToSender(ApprovalEntry: Record "Approval Entry")
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        PurchasePostedTitle: Label 'ERP Approval Request - %1 - Purchase %2 - %3 - %4';
        CustomerTitle: Label 'ERP Approval Request - %1 - Customer - %2 - %3';
        VendorTitle: Label 'ERP Approval Request - %1 - Vendor - %2 - %3';
        ItemTitle: Label 'ERP Approval Request - %1 - Item - %2 - %3';
        SenderUserSetup: Record "User Setup";
        ReceiverSetup: Record "User Setup";
        PurchaseHeader: Record "Purchase Header";
        SendUser: Record User;
        ReceiverUser: Record User;
        PageId: Integer;
        Vendor: Record Vendor;
        CustomerShortName: Text;
        ShortName: Record "Company Short Name";
        RecrefL: RecordRef;
        Customer: record Customer;
        Item: Record Item;
    begin
        Clear(CustomerShortName);
        ShortName.GET(CompanyName);
        if SenderUserSetup.Get(ApprovalEntry."Sender ID") then;
        SendUser.Reset();
        SendUser.SetRange("User Name", SenderUserSetup."User ID");
        if SendUser.FindFirst() then;
        if ReceiverSetup.Get(ApprovalEntry."Approver ID") then;
        ReceiverUser.Reset();
        ReceiverUser.SetRange("User Name", ReceiverSetup."User ID");
        if ReceiverUser.FindFirst() then;
        Recipients.Add(SenderUserSetup."E-Mail");

        if PurchaseHeader.get(ApprovalEntry."Document Type", ApprovalEntry."Document No.") then begin
            Vendor.GET(PurchaseHeader."Buy-from Vendor No.");
            CustomerShortName := Vendor."Search Name";
            Subject := StrSubstNo(PurchasePostedTitle, ShortName."Short Name", ApprovalEntry."Document Type", ApprovalEntry."Document No.", CustomerShortName);
            PurchaseHeader.CalcFields("Amount Including VAT");
            if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then
                PageId := Page::"Purchase Order"
            else
                if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Blanket Order" then
                    PageId := Page::"Blanket Purchase Order"
                else
                    if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice then
                        PageId := Page::"Purchase Invoice"
                    else
                        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo" then
                            PageId := Page::"Purchase Credit Memo";
            Body := CreateEmailBodyPurchase(PurchaseHeader, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('requires %1 approval.', ReceiverUser."Full Name"));
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;

        if ApprovalEntry."Table ID" = Database::Customer then begin
            RecrefL.Get(ApprovalEntry."Record ID to Approve");
            RecrefL.SetTable(Customer);
            Subject := StrSubstNo(CustomerTitle, ShortName."Short Name", Customer."No.", Customer.Name);
            Body := CreateEmailBodyCustomer(Customer, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('requires %1 approval.', ReceiverUser."Full Name"));
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;

        if ApprovalEntry."Table ID" = Database::Vendor then begin
            RecrefL.Get(ApprovalEntry."Record ID to Approve");
            RecrefL.SetTable(Vendor);
            Subject := StrSubstNo(VendorTitle, ShortName."Short Name", Vendor."No.", Vendor.Name);
            Body := CreateEmailBodyVendor(Vendor, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('requires %1 approval.', ReceiverUser."Full Name"));
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;

        if ApprovalEntry."Table ID" = Database::Item then begin
            RecrefL.Get(ApprovalEntry."Record ID to Approve");
            RecrefL.SetTable(Item);
            Subject := StrSubstNo(ItemTitle, ShortName."Short Name", Item."No.", Item.Description);
            Body := CreateEmailBodyItem(Item, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('requires %1 approval.', ReceiverUser."Full Name"));
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;
    end;

    local procedure fnSendNotificationToApproverDelegate(ApprovalEntry: Record "Approval Entry")
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        PurchasePostedTitle: Label 'ERP Approval Request - %1 - Purchase %2 - %3 - %4 - Delegated';
        CustomerTitle: Label 'ERP Approval Request - %1 - Customer - %2 - %3 - Delegated';
        VendorTitle: Label 'ERP Approval Request - %1 - Vendor - %2 - %3 - Delegated';
        ItemTitle: Label 'ERP Approval Request - %1 - Item - %2 - %3 - Delegated';
        SenderUserSetup: Record "User Setup";
        ReceiverSetup: Record "User Setup";
        PurchaseHeader: Record "Purchase Header";
        SendUser: Record User;
        ReceiverUser: Record User;
        PageId: Integer;
        Vendor: Record Vendor;
        CustomerShortName: Text;
        ShortName: Record "Company Short Name";
        RecrefL: RecordRef;
        Customer: record Customer;
        Item: Record Item;
    begin
        Clear(CustomerShortName);
        ShortName.GET(CompanyName);
        if SenderUserSetup.Get(ApprovalEntry."Sender ID") then;
        SendUser.Reset();
        SendUser.SetRange("User Name", SenderUserSetup."User ID");
        if SendUser.FindFirst() then;
        if ReceiverSetup.Get(ApprovalEntry."Approver ID") then;
        ReceiverUser.Reset();
        ReceiverUser.SetRange("User Name", ReceiverSetup."User ID");
        if ReceiverUser.FindFirst() then;
        Recipients.Add(ReceiverSetup."E-Mail");

        if PurchaseHeader.get(ApprovalEntry."Document Type", ApprovalEntry."Document No.") then begin
            Vendor.GET(PurchaseHeader."Buy-from Vendor No.");
            CustomerShortName := Vendor."Search Name";
            Subject := StrSubstNo(PurchasePostedTitle, ShortName."Short Name", ApprovalEntry."Document Type", ApprovalEntry."Document No.", CustomerShortName);
            PurchaseHeader.CalcFields("Amount Including VAT");
            if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then
                PageId := Page::"Purchase Order"
            else
                if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Blanket Order" then
                    PageId := Page::"Blanket Purchase Order"
                else
                    if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice then
                        PageId := Page::"Purchase Invoice"
                    else
                        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo" then
                            PageId := Page::"Purchase Credit Memo";
            Body := CreateEmailBodyPurchase(PurchaseHeader, ReceiverUser, SendUser, ApprovalEntry, 'APPROVER', 'requires your approval.');
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;

        if ApprovalEntry."Table ID" = Database::Customer then begin
            RecrefL.Get(ApprovalEntry."Record ID to Approve");
            RecrefL.SetTable(Customer);
            Subject := StrSubstNo(CustomerTitle, ShortName."Short Name", Customer."No.", Customer.Name);
            Body := CreateEmailBodyCustomer(Customer, ReceiverUser, SendUser, ApprovalEntry, 'APPROVER', 'requires your approval.');
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;

        if ApprovalEntry."Table ID" = Database::Vendor then begin
            RecrefL.Get(ApprovalEntry."Record ID to Approve");
            RecrefL.SetTable(Vendor);
            Subject := StrSubstNo(VendorTitle, ShortName."Short Name", Vendor."No.", Vendor.Name);
            Body := CreateEmailBodyVendor(Vendor, ReceiverUser, SendUser, ApprovalEntry, 'APPROVER', 'requires your approval.');
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;

        if ApprovalEntry."Table ID" = Database::Item then begin
            RecrefL.Get(ApprovalEntry."Record ID to Approve");
            RecrefL.SetTable(Item);
            Subject := StrSubstNo(ItemTitle, ShortName."Short Name", Item."No.", Item.Description);
            Body := CreateEmailBodyItem(Item, ReceiverUser, SendUser, ApprovalEntry, 'APPROVER', 'requires your approval.');
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;
    end;

    procedure fnSendApprovedNotificationToSender(ApprovalEntry: Record "Approval Entry")
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        PurchasePostedTitle: Label 'ERP Approval Request - %1 - Purchase %2 - %3 - %4';
        CustomerTitle: Label 'ERP Approval Request - %1 - Customer - %2 - %3';
        VendorTitle: Label 'ERP Approval Request - %1 - Vendor - %2 - %3';
        ItemTitle: Label 'ERP Approval Request - %1 - Item - %2 - %3';
        SenderUserSetup: Record "User Setup";
        ReceiverSetup: Record "User Setup";
        PurchaseHeader: Record "Purchase Header";
        SendUser: Record User;
        ReceiverUser: Record User;
        PageId: Integer;
        Vendor: Record Vendor;
        CustomerShortName: Text;
        ShortName: Record "Company Short Name";
        RecrefL: RecordRef;
        Customer: record Customer;
        Item: Record Item;
    begin
        Clear(CustomerShortName);
        ShortName.GET(CompanyName);
        if SenderUserSetup.Get(ApprovalEntry."Sender ID") then;
        SendUser.Reset();
        SendUser.SetRange("User Name", SenderUserSetup."User ID");
        if SendUser.FindFirst() then;
        if ReceiverSetup.Get(ApprovalEntry."Approver ID") then;
        ReceiverUser.Reset();
        ReceiverUser.SetRange("User Name", ReceiverSetup."User ID");
        if ReceiverUser.FindFirst() then;
        Recipients.Add(SenderUserSetup."E-Mail");

        if PurchaseHeader.get(ApprovalEntry."Document Type", ApprovalEntry."Document No.") then begin
            Vendor.GET(PurchaseHeader."Buy-from Vendor No.");
            CustomerShortName := Vendor."Search Name";
            Subject := StrSubstNo(PurchasePostedTitle, ShortName."Short Name", ApprovalEntry."Document Type", ApprovalEntry."Document No.", CustomerShortName);
            PurchaseHeader.CalcFields("Amount Including VAT");
            if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then
                PageId := Page::"Purchase Order"
            else
                if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Blanket Order" then
                    PageId := Page::"Blanket Purchase Order"
                else
                    if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice then
                        PageId := Page::"Purchase Invoice"
                    else
                        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo" then
                            PageId := Page::"Purchase Credit Memo";
            Body := CreateEmailBodyPurchase(PurchaseHeader, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('is approved by %1.', ReceiverUser."Full Name"));
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;

        if ApprovalEntry."Table ID" = Database::Customer then begin
            RecrefL.Get(ApprovalEntry."Record ID to Approve");
            RecrefL.SetTable(Customer);
            Subject := StrSubstNo(CustomerTitle, ShortName."Short Name", Customer."No.", Customer.Name);
            Body := CreateEmailBodyCustomer(Customer, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('is approved by %1.', ReceiverUser."Full Name"));
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;

        if ApprovalEntry."Table ID" = Database::Vendor then begin
            RecrefL.Get(ApprovalEntry."Record ID to Approve");
            RecrefL.SetTable(Vendor);
            Subject := StrSubstNo(VendorTitle, ShortName."Short Name", Vendor."No.", Vendor.Name);
            Body := CreateEmailBodyVendor(Vendor, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('is approved by %1.', ReceiverUser."Full Name"));
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;

        if ApprovalEntry."Table ID" = Database::Item then begin
            RecrefL.Get(ApprovalEntry."Record ID to Approve");
            RecrefL.SetTable(Item);
            Subject := StrSubstNo(ItemTitle, ShortName."Short Name", Item."No.", Item.Description);
            Body := CreateEmailBodyItem(Item, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('is approved by %1.', ReceiverUser."Full Name"));
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;
    end;

    procedure fnSendRejectedNotificationToSender(ApprovalEntry: Record "Approval Entry")
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        PurchasePostedTitle: Label 'ERP Approval Rejected - %1 - Purchase %2 - %3 - %4';
        CustomerTitle: Label 'ERP Approval Rejected - %1 - Customer - %2 - %3';
        VendorTitle: Label 'ERP Approval Rejected - %1 - Vendor - %2 - %3';
        ItemTitle: Label 'ERP Approval Rejected - %1 - Item - %2 - %3';
        SenderUserSetup: Record "User Setup";
        ReceiverSetup: Record "User Setup";
        PurchaseHeader: Record "Purchase Header";
        SendUser: Record User;
        ReceiverUser: Record User;
        PageId: Integer;
        Vendor: Record Vendor;
        CustomerShortName: Text;
        ShortName: Record "Company Short Name";
        RecrefL: RecordRef;
        Customer: record Customer;
        Item: Record Item;
    begin
        Clear(CustomerShortName);
        ShortName.GET(CompanyName);
        if SenderUserSetup.Get(ApprovalEntry."Sender ID") then;
        SendUser.Reset();
        SendUser.SetRange("User Name", SenderUserSetup."User ID");
        if SendUser.FindFirst() then;
        if ReceiverSetup.Get(ApprovalEntry."Approver ID") then;
        ReceiverUser.Reset();
        ReceiverUser.SetRange("User Name", ReceiverSetup."User ID");
        if ReceiverUser.FindFirst() then;
        Recipients.Add(SenderUserSetup."E-Mail");

        if PurchaseHeader.get(ApprovalEntry."Document Type", ApprovalEntry."Document No.") then begin
            Vendor.GET(PurchaseHeader."Buy-from Vendor No.");
            CustomerShortName := Vendor."Search Name";
            Subject := StrSubstNo(PurchasePostedTitle, ShortName."Short Name", ApprovalEntry."Document Type", ApprovalEntry."Document No.", CustomerShortName);
            PurchaseHeader.CalcFields("Amount Including VAT");
            if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then
                PageId := Page::"Purchase Order"
            else
                if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Blanket Order" then
                    PageId := Page::"Blanket Purchase Order"
                else
                    if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice then
                        PageId := Page::"Purchase Invoice"
                    else
                        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo" then
                            PageId := Page::"Purchase Credit Memo";
            Body := CreateEmailBodyPurchase(PurchaseHeader, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('is rejected by %1.', ReceiverUser."Full Name"));
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;

        if ApprovalEntry."Table ID" = Database::Customer then begin
            RecrefL.Get(ApprovalEntry."Record ID to Approve");
            RecrefL.SetTable(Customer);
            Subject := StrSubstNo(CustomerTitle, ShortName."Short Name", Customer."No.", Customer.Name);
            Body := CreateEmailBodyCustomer(Customer, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('is rejected by %1.', ReceiverUser."Full Name"));
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;

        if ApprovalEntry."Table ID" = Database::Vendor then begin
            RecrefL.Get(ApprovalEntry."Record ID to Approve");
            RecrefL.SetTable(Vendor);
            Subject := StrSubstNo(VendorTitle, ShortName."Short Name", Vendor."No.", Vendor.Name);
            Body := CreateEmailBodyVendor(Vendor, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('is rejected by %1.', ReceiverUser."Full Name"));
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;

        if ApprovalEntry."Table ID" = Database::Item then begin
            RecrefL.Get(ApprovalEntry."Record ID to Approve");
            RecrefL.SetTable(Item);
            Subject := StrSubstNo(ItemTitle, ShortName."Short Name", Item."No.", Item.Description);
            Body := CreateEmailBodyItem(Item, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('is rejected by %1.', ReceiverUser."Full Name"));
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;
    end;

    procedure fnSendNotificationToApprover(ApprovalEntry: Record "Approval Entry")
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        PurchasePostedTitle: Label 'ERP Approval Request - %1 - Purchase %2 - %3 - %4';
        CustomerTitle: Label 'ERP Approval Request - %1 - Customer - %2 - %3';
        VendorTitle: Label 'ERP Approval Request - %1 - Vendor - %2 - %3';
        ItemTitle: Label 'ERP Approval Request - %1 - Item - %2 - %3';
        SenderUserSetup: Record "User Setup";
        ReceiverSetup: Record "User Setup";
        PurchaseHeader: Record "Purchase Header";
        SendUser: Record User;
        ReceiverUser: Record User;
        PageId: Integer;
        Vendor: Record Vendor;
        CustomerShortName: Text;
        ShortName: Record "Company Short Name";
        RecrefL: RecordRef;
        Customer: record Customer;
        Item: Record Item;
    begin
        Clear(CustomerShortName);
        ShortName.GET(CompanyName);
        if SenderUserSetup.Get(ApprovalEntry."Sender ID") then;
        SendUser.Reset();
        SendUser.SetRange("User Name", SenderUserSetup."User ID");
        if SendUser.FindFirst() then;
        if ReceiverSetup.Get(ApprovalEntry."Approver ID") then;
        ReceiverUser.Reset();
        ReceiverUser.SetRange("User Name", ReceiverSetup."User ID");
        if ReceiverUser.FindFirst() then;
        Recipients.Add(ReceiverSetup."E-Mail");

        if PurchaseHeader.get(ApprovalEntry."Document Type", ApprovalEntry."Document No.") then begin
            Vendor.GET(PurchaseHeader."Buy-from Vendor No.");
            CustomerShortName := Vendor."Search Name";
            Subject := StrSubstNo(PurchasePostedTitle, ShortName."Short Name", ApprovalEntry."Document Type", ApprovalEntry."Document No.", CustomerShortName);
            PurchaseHeader.CalcFields("Amount Including VAT");
            if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then
                PageId := Page::"Purchase Order"
            else
                if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Blanket Order" then
                    PageId := Page::"Blanket Purchase Order"
                else
                    if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice then
                        PageId := Page::"Purchase Invoice"
                    else
                        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo" then
                            PageId := Page::"Purchase Credit Memo";
            Body := CreateEmailBodyPurchase(PurchaseHeader, ReceiverUser, SendUser, ApprovalEntry, 'APPROVER', 'requires your approval.');
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;

        if ApprovalEntry."Table ID" = Database::Customer then begin
            RecrefL.Get(ApprovalEntry."Record ID to Approve");
            RecrefL.SetTable(Customer);
            Subject := StrSubstNo(CustomerTitle, ShortName."Short Name", Customer."No.", Customer.Name);
            Body := CreateEmailBodyCustomer(Customer, ReceiverUser, SendUser, ApprovalEntry, 'APPROVER', 'requires your approval.');
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;

        if ApprovalEntry."Table ID" = Database::Vendor then begin
            RecrefL.Get(ApprovalEntry."Record ID to Approve");
            RecrefL.SetTable(Vendor);
            Subject := StrSubstNo(VendorTitle, ShortName."Short Name", Vendor."No.", Vendor.Name);
            Body := CreateEmailBodyVendor(Vendor, ReceiverUser, SendUser, ApprovalEntry, 'APPROVER', 'requires your approval.');
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;

        if ApprovalEntry."Table ID" = Database::Item then begin
            RecrefL.Get(ApprovalEntry."Record ID to Approve");
            RecrefL.SetTable(Item);
            Subject := StrSubstNo(ItemTitle, ShortName."Short Name", Item."No.", Item.Description);
            Body := CreateEmailBodyItem(Item, ReceiverUser, SendUser, ApprovalEntry, 'APPROVER', 'requires your approval.');
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;
    end;

    procedure fnSendCancelledNotificationToApprover(ApprovalEntry: Record "Approval Entry")
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        PurchasePostedTitle: Label 'ERP Approval Cancelled - %1 - Purchase %2 - %3 - %4';
        CustomerTitle: Label 'ERP Approval Cancelled - %1 - Customer - %2 - %3';
        VendorTitle: Label 'ERP Approval Cancelled - %1 - Vendor - %2 - %3';
        ItemTitle: Label 'ERP Approval Cancelled - %1 - Item - %2 - %3';
        SenderUserSetup: Record "User Setup";
        ReceiverSetup: Record "User Setup";
        PurchaseHeader: Record "Purchase Header";
        SendUser: Record User;
        ReceiverUser: Record User;
        PageId: Integer;
        Vendor: Record Vendor;
        CustomerShortName: Text;
        ShortName: Record "Company Short Name";
        RecrefL: RecordRef;
        Customer: record Customer;
        Item: Record Item;
    begin
        Clear(CustomerShortName);
        ShortName.GET(CompanyName);
        if SenderUserSetup.Get(ApprovalEntry."Sender ID") then;
        SendUser.Reset();
        SendUser.SetRange("User Name", SenderUserSetup."User ID");
        if SendUser.FindFirst() then;
        if ReceiverSetup.Get(ApprovalEntry."Approver ID") then;
        ReceiverUser.Reset();
        ReceiverUser.SetRange("User Name", ReceiverSetup."User ID");
        if ReceiverUser.FindFirst() then;
        Recipients.Add(ReceiverSetup."E-Mail");

        if PurchaseHeader.get(ApprovalEntry."Document Type", ApprovalEntry."Document No.") then begin
            Vendor.GET(PurchaseHeader."Buy-from Vendor No.");
            CustomerShortName := Vendor."Search Name";
            Subject := StrSubstNo(PurchasePostedTitle, ShortName."Short Name", ApprovalEntry."Document Type", ApprovalEntry."Document No.", CustomerShortName);
            PurchaseHeader.CalcFields("Amount Including VAT");
            if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then
                PageId := Page::"Purchase Order"
            else
                if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Blanket Order" then
                    PageId := Page::"Blanket Purchase Order"
                else
                    if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice then
                        PageId := Page::"Purchase Invoice"
                    else
                        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo" then
                            PageId := Page::"Purchase Credit Memo";
            Body := CreateEmailBodyPurchase(PurchaseHeader, ReceiverUser, SendUser, ApprovalEntry, 'APPROVER', StrSubstNo('is cancelled by %1', SendUser."Full Name"));
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;

        if ApprovalEntry."Table ID" = Database::Customer then begin
            RecrefL.Get(ApprovalEntry."Record ID to Approve");
            RecrefL.SetTable(Customer);
            Subject := StrSubstNo(CustomerTitle, ShortName."Short Name", Customer."No.", Customer.Name);
            Body := CreateEmailBodyCustomer(Customer, ReceiverUser, SendUser, ApprovalEntry, 'APPROVER', StrSubstNo('is cancelled by %1', SendUser."Full Name"));
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;

        if ApprovalEntry."Table ID" = Database::Vendor then begin
            RecrefL.Get(ApprovalEntry."Record ID to Approve");
            RecrefL.SetTable(Vendor);
            Subject := StrSubstNo(VendorTitle, ShortName."Short Name", Vendor."No.", Vendor.Name);
            Body := CreateEmailBodyVendor(Vendor, ReceiverUser, SendUser, ApprovalEntry, 'APPROVER', StrSubstNo('is cancelled by %1', SendUser."Full Name"));
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;

        if ApprovalEntry."Table ID" = Database::Item then begin
            RecrefL.Get(ApprovalEntry."Record ID to Approve");
            RecrefL.SetTable(Item);
            Subject := StrSubstNo(ItemTitle, ShortName."Short Name", Item."No.", Item.Description);
            Body := CreateEmailBodyItem(Item, ReceiverUser, SendUser, ApprovalEntry, 'APPROVER', StrSubstNo('is cancelled by %1', SendUser."Full Name"));
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;
    end;

    procedure fnSendCancelledNotificationToSender(ApprovalEntry: Record "Approval Entry")
    var
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        PurchasePostedTitle: Label 'ERP Approval Cancelled - %1 - Purchase %2 - %3 - %4';
        CustomerTitle: Label 'ERP Approval Cancelled - %1 - Customer - %2 - %3';
        VendorTitle: Label 'ERP Approval Cancelled - %1 - Vendor - %2 - %3';
        ItemTitle: Label 'ERP Approval Cancelled - %1 - Item - %2 - %3';
        SenderUserSetup: Record "User Setup";
        ReceiverSetup: Record "User Setup";
        PurchaseHeader: Record "Purchase Header";
        SendUser: Record User;
        ReceiverUser: Record User;
        PageId: Integer;
        Vendor: Record Vendor;
        CustomerShortName: Text;
        ShortName: Record "Company Short Name";
        RecrefL: RecordRef;
        Customer: record Customer;
        Item: Record Item;
    begin
        Clear(CustomerShortName);
        ShortName.GET(CompanyName);
        if SenderUserSetup.Get(ApprovalEntry."Sender ID") then;
        SendUser.Reset();
        SendUser.SetRange("User Name", SenderUserSetup."User ID");
        if SendUser.FindFirst() then;
        if ReceiverSetup.Get(ApprovalEntry."Approver ID") then;
        ReceiverUser.Reset();
        ReceiverUser.SetRange("User Name", ReceiverSetup."User ID");
        if ReceiverUser.FindFirst() then;
        Recipients.Add(SenderUserSetup."E-Mail");

        if PurchaseHeader.get(ApprovalEntry."Document Type", ApprovalEntry."Document No.") then begin
            Vendor.GET(PurchaseHeader."Buy-from Vendor No.");
            CustomerShortName := Vendor."Search Name";
            Subject := StrSubstNo(PurchasePostedTitle, ShortName."Short Name", ApprovalEntry."Document Type", ApprovalEntry."Document No.", CustomerShortName);
            PurchaseHeader.CalcFields("Amount Including VAT");
            if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then
                PageId := Page::"Purchase Order"
            else
                if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Blanket Order" then
                    PageId := Page::"Blanket Purchase Order"
                else
                    if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Invoice then
                        PageId := Page::"Purchase Invoice"
                    else
                        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::"Credit Memo" then
                            PageId := Page::"Purchase Credit Memo";
            Body := CreateEmailBodyPurchase(PurchaseHeader, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('is cancelled by %1.', SendUser."Full Name"));
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;

        if ApprovalEntry."Table ID" = Database::Customer then begin
            RecrefL.Get(ApprovalEntry."Record ID to Approve");
            RecrefL.SetTable(Customer);
            Subject := StrSubstNo(CustomerTitle, ShortName."Short Name", Customer."No.", Customer.Name);
            Body := CreateEmailBodyCustomer(Customer, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('is cancelled by %1.', SendUser."Full Name"));
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;

        if ApprovalEntry."Table ID" = Database::Vendor then begin
            RecrefL.Get(ApprovalEntry."Record ID to Approve");
            RecrefL.SetTable(Vendor);
            Subject := StrSubstNo(VendorTitle, ShortName."Short Name", Vendor."No.", Vendor.Name);
            Body := CreateEmailBodyVendor(Vendor, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('is cancelled by %1.', SendUser."Full Name"));
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;

        if ApprovalEntry."Table ID" = Database::Item then begin
            RecrefL.Get(ApprovalEntry."Record ID to Approve");
            RecrefL.SetTable(Item);
            Subject := StrSubstNo(ItemTitle, ShortName."Short Name", Item."No.", Item.Description);
            Body := CreateEmailBodyItem(Item, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('is cancelled by %1.', SendUser."Full Name"));
            EmailMessage.Create(Recipients, Subject, Body, true);
            Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);
        end;
    end;
    //T52160-OE

    local procedure CreateEmailBodyPurchase(Var PHeader: Record "Purchase Header"; Var Receiver: Record User; Var Sender: Record User; Var RecAppEntry: Record "Approval Entry"; ToUser: Code[10]; ActionText: Text): Text
    var
        RecLines: Record "Purchase Line";
        Vendor: Record Vendor;
        RecApprovalEntry: Record "Approval Entry";
        GLSetup: Record "General Ledger Setup";
        RecPaymentTerms: Record "Payment Terms";
        Recteams: Record Team;
        RecteamSalesPerson: Record "Team Salesperson";
        SalesPerson: Record "Salesperson/Purchaser";
        EntryExitPoint: Record "Entry/Exit Point";
        AreaL: Record "Area";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        RecItem: Record Item;
        RecCLE: record "Cust. Ledger Entry";
        ShortName: Record "Company Short Name";
        Utility: Codeunit Events;
        RecLines2: Record "Purchase Line";
        ItemVariant: Record "Item Variant";
        ItemVariantDetails: Record "Item Variant Details";
        CommentLine: Record "Purch. Comment Line";
        Location: Record Location;
        BodyText: TextBuilder;
        UOMCheck: List of [Text];
        TestText: Text;
        PaymentTermsText, ColorText : Text;
        PageId, J : Integer;
        TotalAmt, TotalQty, AvailableLimit, UsedLimit, OverDueHistory : Decimal;
        UnitPriceColor: Label 'style="color:%1"; font-weight: %2';
        CommentLinePrinted: Boolean;
        VendorProductName: Text;
        ItemCOO: Text;
        VendorCOO: Text;
        PackingDesc: Text;
        SalesPersonName: Text;
        SequenceNumber: Text;
        ApproverName: Text;
        SenderName: Text;
        Transaction_Type: Text;
        LastBuyingPrice: Decimal;
        PostedPurchaseHeader: Record "Purch. Inv. Header";
        PostedPurchaseLine: Record "Purch. Inv. Line";
        Docno: Text;
        UOMCount: integer;
        ItemDescription: Text;
        POlink: Text;
        RecFixedAsset: Record "Fixed Asset";
        PointofDelivery: Text;
        CompanyInformation: Record "Company Information";
    begin
        GLSetup.GET;
        ShortName.GET(CompanyName);
        CompanyInformation.Get();
        Clear(Vendor);
        Vendor.GET(PHeader."Buy-from Vendor No.");
        //Clear(LastBuyingPrice);
        //Clear(PostedPurchaseLine);
        //PostedPurchaseHeader.Get(PostedPurchaseLine."Document No.");

        if PHeader."Document Type" = PHeader."Document Type"::Order then
            PageId := Page::"Purchase Order"
        else
            if PHeader."Document Type" = PHeader."Document Type"::"Blanket Order" then
                PageId := Page::"Blanket Purchase Order"
            else
                if PHeader."Document Type" = PHeader."Document Type"::Invoice then
                    PageId := Page::"Purchase Invoice"
                else
                    if PHeader."Document Type" = PHeader."Document Type"::"Credit Memo" then
                        PageId := Page::"Purchase Credit Memo";


        Clear(BodyText);
        BodyText.Append('<style>table, th, td { border-collapse: collapse; border: 1px solid black;} table.a { table-layout: auto;  width: 560px; } table.b { table-layout: auto;  width: 1300px; } table.c { table-layout: auto;  width: 420px; }table.d { table-layout: auto;  width: 420px; } </style>');

        if ToUser = 'SENDER' then
            BodyText.Append('Hello ' + Sender."Full Name" + ',<br><br>You are registered to receive notifications related to ' + ShortName.Name + '.')
        else
            BodyText.Append('Hello ' + Receiver."Full Name" + ',<br><br>You are registered to receive notifications related to ' + ShortName.Name + '.');

        BodyText.Append('<br><br>This message is to notify you that Purchase Order ');
        // BodyText.Append('<br><br>');
        BodyText.Append(StrSubstNo('<a style="text-decoration:none;color:black;cursor:auto" href="#">%1</a> %2', FORMAT(PHeader."No."), ActionText));

        BodyText.Append('<br><br>');
        TestText := StrSubstNo('<p><a href="%1">' + PHeader."No." + '</a>', GetUrl(ClientType::Web, CompanyName, ObjectType::Page, PageId, PHeader, false)) + ' - ' + ShortName."Short Name" + '</p>';

        //<table   -removed border
        BodyText.Append('<table class="a">');
        BodyText.Append('<tr style="background-color:#F8CBAD"><td colspan="2" align="center"><b>PO Summary</b></td></tr>');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#FCE4D6"> <font> <b>Purchase Order No.:</b> </font></td>');
        BodyText.Append('<td align="left" Style="padding-left:5px;"> <font> ' + TestText + '</font></td>');
        BodyText.Append('</tr>');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#FCE4D6"> <font> <b>Vendor Name/No.</b> </font></td>');
        BodyText.Append('<td align="left" Style="padding-left:5px;"> <font>' + PHeader."Buy-from Vendor Name" + ' - ' + PHeader."Buy-from Vendor No." + '</font></td>');

        BodyText.Append('</tr>');
        BodyText.Append('<tr>');

        BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#FCE4D6"> <font> <b>Purchase Amount (Incl. VAT):</b> </font></td>');
        PHeader.CalcFields("Amount Including VAT");

        if GLSetup."LCY Code" <> 'INR' then begin
            if PHeader."Currency Factor" <> 0 then
                BodyText.Append('<td align="left" Style="padding-left:5px;"> <font>' + PHeader."Currency Code" + ' ' + FORMAT(PHeader."Amount Including VAT", 0, '<Precision,2:2><Standard Format,0>') + ' (' + GLSetup."LCY Code" + ' ' + FORMAT(PHeader."Amount Including VAT" / PHeader."Currency Factor", 0, '<Precision,2:2><Standard Format,0>') + ') </font></td>')
            else
                BodyText.Append('<td align="left" Style="padding-left:5px;"> <font>' + GLSetup."LCY Code" + ' ' + FORMAT(PHeader."Amount Including VAT", 0, '<Precision,2:2><Standard Format,0>') + ' </font></td>');
        end else begin
            if PHeader."Currency Code" <> '' then
                BodyText.Append('<td align="left" Style="padding-left:5px;"> <font>' + PHeader."Currency Code" + ' ' + FORMAT(PHeader."Amount Including VAT", 0, '<Precision,2:2><Standard Format,0>') + ' (AED ' + FORMAT(CurrencyExchangeRate.ExchangeAmount(PHeader."Amount Including VAT", PHeader."Currency Code", 'AED', PHeader."Posting Date"), 0, '<Precision,2:2><Standard Format,0>') + ') </font></td>')
            else
                BodyText.Append('<td align="left" Style="padding-left:5px;"> <font>' + GLSetup."LCY Code" + ' ' + FORMAT(PHeader."Amount Including VAT", 0, '<Precision,2:2><Standard Format,0>') + ' (AED ' + FORMAT(CurrencyExchangeRate.ExchangeAmount(PHeader."Amount Including VAT", 'INR', 'AED', PHeader."Posting Date"), 0, '<Precision,2:2><Standard Format,0>') + ') </font></td>');
        end;
        BodyText.Append('</tr>');

        if PHeader."Payment Terms Code" <> '' then begin
            RecPaymentTerms.GET(PHeader."Payment Terms Code");
            BodyText.Append('<tr>');
            BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#FCE4D6"> <font> <b>Payment Terms:</b> </font></td>');
            PaymentTermsText := RecPaymentTerms.Description;
            BodyText.Append('<td align="left" Style="padding-left:5px;"> <font> ' + PaymentTermsText + '</font></td>');
            BodyText.Append('</tr>');
        end;

        if PHeader."Transaction Type" = 'DIRECTSHIP' then begin
            Transaction_Type := PHeader."Transaction Type" + ' - ' + PHeader."Ship-to Name";
        end else
            if PHeader."Transaction Type" = 'PRODUCTION' then begin
                Transaction_Type := 'Raw Material for Production';
            end else begin
                Transaction_Type := PHeader."Transaction Type";
            end;

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#FCE4D6"> <font> <b>Order Type:</b> </font></td>');
        BodyText.Append('<td align="left" Style="padding-left:5px;"> <font> ' + Transaction_Type + ' </font></td>');
        BodyText.Append('</tr>');

        if PHeader."Purchaser Code" <> '' then begin
            BodyText.Append('<tr>');
            BodyText.Append('<td align="left" Style="padding-left:5px;background-color:#FCE4D6"> <font> <b>Purchaser Name:</b> </font></td>');
            if SalesPerson.Get(PHeader."Purchaser Code") then
                BodyText.Append('<td align="left" Style="padding-left:5px;"> <font> ' + SalesPerson.Name + ' </font></td>');
            BodyText.Append('</tr>');
        end;
        BodyText.Append('</table>');

        BodyText.Append('<br><br>');

        //Clear(LastBuyingPrice);
        Clear(RecLines);
        RecLines.SetCurrentKey("Line No.");
        RecLines.SetAscending("Line No.", true);
        RecLines.SetRange("Document Type", PHeader."Document Type");
        RecLines.SetRange("Document No.", PHeader."No.");
        //RecLines.SetRange(Type, RecLines.Type::Item);
        if RecLines.FindSet() then begin
            BodyText.Append('<table class="b">');
            Clear(TotalAmt);
            Clear(TotalQty);
            BodyText.Append('<tr style="background-color:#F8CBAD"><td colspan="11" align="left"><b>Product Info.</b></td></tr>');
            BodyText.Append('<tr>');
            BodyText.Append('<td align="left" Style="width:120px;padding-left:5px;padding-right:5px;background-color:#FCE4D6"> <font> <b>Item Code <br/>Description </b> </font></td>');
            BodyText.Append('<td align="left" Style="width:50px;padding-left:5px;padding-right:5px;background-color:#FCE4D6"> <font> <b>Variant Code</b></font></td>');
            BodyText.Append('<td align="left" Style="width:70px;padding-left:5px;padding-right:5px;background-color:#FCE4D6"> <b>Quantity</b></font></td>');
            BodyText.Append('<td align="left" Style="width:80px;padding-left:5px;padding-right:5px;background-color:#FCE4D6"> <b>Unit Price</b></font></td>');
            BodyText.Append('<td align="left" Style="width:80px;padding-left:5px;padding-right:5px;background-color:#FCE4D6"> <b>Last Buying Price</b></font></td>');
            BodyText.Append('<td align="left" Style="width:90px;padding-left:5px;padding-right:5px;background-color:#FCE4D6">   <b>Total</b></font></td>');
            // BodyText.Append('<td align="left" Style="width:100px;padding-left:5px;padding-right:5px"> <font> Vendor Product Name </font></td>');
            BodyText.Append('<td align="left" Style="width:100px;padding-left:5px;padding-right:5px;background-color:#FCE4D6"> <b>Packing<b></font></td>');
            BodyText.Append('<td align="left" Style="width:50px;padding-left:5px;padding-right:5px;background-color:#FCE4D6"> <b>COO<br/>COO-D<b></font></td>');
            BodyText.Append('<td align="left" Style="width:80px;padding-left:5px;padding-right:5px;background-color:#FCE4D6">   <b>Warehouse</br>City</b></font></td>');
            BodyText.Append('<td align="left" Style="width:60px;padding-left:5px;padding-right:5px;background-color:#FCE4D6"> <b>ETD<br>ETA</b> </font></td>');
            //BodyText.Append('<td align="left" Style="width:100px;padding-left:5px;padding-right:5px"> Prepayment % </font></td>');
            BodyText.Append('<td align="left" Style="width:70px;padding-left:5px;padding-right:5px;background-color:#FCE4D6"> <b>Salesperson</b> </font></td>');
            BodyText.Append('</tr>');

            repeat
                if RecLines.Type <> RecLines.Type::" " then begin
                    Clear(LastBuyingPrice);
                    Clear(Docno);
                    Clear(PostedPurchaseLine);
                    Clear(ColorText);

                    if RecLines.Type = RecLines.Type::Item then
                        RecItem.GET(RecLines."No.");
                    PostedPurchaseLine.SetCurrentKey(Type, "No.");
                    //PostedPurchaseLine.SetRange("Buy-from Vendor No.", PHeader."Buy-from Vendor No.");
                    PostedPurchaseLine.SetRange(Type, PostedPurchaseLine.Type::Item);
                    PostedPurchaseLine.SetRange("No.", RecLines."No.");
                    PostedPurchaseLine.SetRange("Variant Code", RecLines."Variant Code"); //Supriya
                    If PostedPurchaseLine.FindLast then begin
                        LastBuyingPrice := PostedPurchaseLine."Unit Price Base UOM";
                        Docno := PostedPurchaseLine."Document No.";
                        PostedPurchaseHeader.Get(PostedPurchaseLine."Document No.");
                        if PostedPurchaseHeader."Currency Code" <> PHeader."Currency Code" then
                            LastBuyingPrice := CurrencyExchangeRate.ExchangeAmount(LastBuyingPrice, PostedPurchaseHeader."Currency Code", PHeader."Currency Code", PHeader."Posting Date");
                        if RecLines."Unit Price Base UOM" > LastBuyingPrice then
                            ColorText := 'Red';
                    end;

                    if RecLines.Type = RecLines.Type::"Fixed Asset" then
                        RecFixedAsset.GET(RecLines."No.");
                    PostedPurchaseLine.SetCurrentKey(Type, "No.");
                    //PostedPurchaseLine.SetRange("Buy-from Vendor No.", PHeader."Buy-from Vendor No.");
                    PostedPurchaseLine.SetRange(Type, PostedPurchaseLine.Type::"Fixed Asset");
                    PostedPurchaseLine.SetRange("No.", RecLines."No.");
                    If PostedPurchaseLine.FindLast then begin
                        LastBuyingPrice := PostedPurchaseLine."Unit Price Base UOM";
                        Docno := PostedPurchaseLine."Document No.";
                        PostedPurchaseHeader.Get(PostedPurchaseLine."Document No.");
                        if PostedPurchaseHeader."Currency Code" <> PHeader."Currency Code" then
                            LastBuyingPrice := CurrencyExchangeRate.ExchangeAmount(LastBuyingPrice, PostedPurchaseHeader."Currency Code", PHeader."Currency Code", PHeader."Posting Date");
                        if RecLines."Unit Price Base UOM" > LastBuyingPrice then
                            ColorText := 'Red';
                    end;

                    if RecLines."Location Code" <> '' then begin
                        Location.Get(RecLines."Location Code");
                    end else begin
                        Location.City := ''
                    end;

                    VendorProductName := '';
                    ItemCOO := '';
                    VendorCOO := '';
                    PackingDesc := '';
                    ItemDescription := '';
                    if RecLines.Type <> RecLines.Type::Item then begin
                        ItemDescription := RecLines.Description;
                    end else begin
                        VendorProductName := RecItem.Vendor_item_description;
                        ItemCOO := RecItem."Country/Region of Origin Code";
                        VendorCOO := RecItem."Vendor Country of Origin";
                        PackingDesc := RecItem."Description 2";
                        ItemDescription := RecItem."Search Description";
                    end;

                    if RecLines."Variant Code" <> '' then begin
                        ItemVariant.Get(RecItem."No.", RecLines."Variant Code");
                        ItemVariantDetails.Get(RecItem."No.", RecLines."Variant Code");
                        if ItemVariantDetails."Vendor Item Description" <> '' then
                            VendorProductName := ItemVariantDetails."Vendor Item Description";
                        if ItemVariant.CountryOfOrigin <> '' then
                            ItemCOO := ItemVariant.CountryOfOrigin;
                        if ItemVariantDetails."Vendor Country of Origin" <> '' then
                            VendorCOO := ItemVariantDetails."Vendor Country of Origin";
                        if ItemVariant."Packing Description" <> '' then
                            PackingDesc := ItemVariant."Packing Description";
                        if ItemVariant."Description 2" <> '' then begin
                            ItemDescription := ItemVariant."Description 2";
                        end else begin
                            ItemDescription := ItemVariant.Description;
                        end;
                    end;


                    BodyText.Append('<tr>');
                    BodyText.Append('<td align="left" Style="width:120px;padding-left:5px;padding-right:5px"> <font> ' + RecLines."No." + ' <br/>' + ItemDescription + ' </font></td>');
                    BodyText.Append('<td align="left" Style="width:50px;padding-left:5px;padding-right:5px"> <font> ' + RecLines."Variant Code" + ' </font></td>');


                    BodyText.Append('<td align="left" Style="width:70px;padding-left:5px;padding-right:5px"> ' + FORMAT(RecLines."Quantity (Base)") + ' ' + RecLines."Base UOM" + ' </font></td>');

                    if PHeader."Currency Code" <> '' then begin
                        BodyText.Append('<td align="left" Style="width:80px;padding-left:5px;padding-right:5px;color:' + ColorText + '"> ' + PHeader."Currency Code" + '<br/>' + FORMAT(RecLines."Unit Price Base UOM", 0, '<Precision,2:2><Standard Format,0>') + ' </font></td>');
                        BodyText.Append('<td align="left" Style="width:80px;padding-left:5px;padding-right:5px"> <font> ' + PHeader."Currency Code" + '<br/>' + FORMAT(LastBuyingPrice, 0, '<Precision,2:2><Standard Format,0>') + ' </font></td>');
                    end else begin
                        BodyText.Append('<td align="left" Style="width:80px;padding-left:5px;padding-right:5px;color:' + ColorText + '"> ' + GLSetup."LCY Code" + '<br/>' + FORMAT(RecLines."Unit Price Base UOM", 0, '<Precision,2:2><Standard Format,0>') + ' </font></td>');
                        BodyText.Append('<td align="left" Style="width:80px;padding-left:5px;padding-right:5px"> <font> ' + GLSetup."LCY Code" + '<br/>' + FORMAT(LastBuyingPrice, 0, '<Precision,2:2><Standard Format,0>') + ' </font></td>');
                    end;

                    if PHeader."Currency Code" <> '' then
                        BodyText.Append('<td align="left" Style="width:90px;padding-left:5px;padding-right:5px"> <font> ' + PHeader."Currency Code" + '<br/>' + FORMAT(RecLines."Unit Price Base UOM" * RecLines."Quantity (Base)", 0, '<Precision,2:2><Standard Format,0>') + ' </font></td>')
                    else
                        BodyText.Append('<td align="left" Style="width:90px;padding-left:5px;padding-right:5px"> <font> ' + GLSetup."LCY Code" + '<br/>' + FORMAT(RecLines."Unit Price Base UOM" * RecLines."Quantity (Base)", 0, '<Precision,2:2><Standard Format,0>') + ' </font></td>');


                    //BodyText.Append('<td align="left" Style="width:100px;padding-left:5px;padding-right:5px"> <font> ' + VendorProductName + ' </font></td>');
                    BodyText.Append('<td align="left" Style="width:100px;padding-left:5px;padding-right:5px"> ' + PackingDesc + ' </font></td>');
                    BodyText.Append('<td align="left" Style="width:50px;padding-left:5px;padding-right:5px"> ' + VendorCOO + ' </br> ' + ItemCOO + ' </font></td>');
                    BodyText.Append('<td align="left" Style="width:80px;padding-left:5px;padding-right:5px">   ' + RecLines."Location Code" + '</br>' + Location.City + '</font></td>');
                    BodyText.Append('<td align="left" Style="width:60px"> ' + Format(RecLines.CustomETD, 10, '<Day,2>-<Month,2>-<Year4>') + '<br/>' + Format(RecLines.CustomETA, 10, '<Day,2>-<Month,2>-<Year4>') + ' </font></td>');
                    //  BodyText.Append('<td align="center" Style="width:100px;padding-left:5px;padding-right:5px"> ' + Format(RecLines."Prepayment %") + ' </font></td>');

                    SalesPersonName := '';
                    if RecLines."Salesperson Code" <> '' then begin
                        SalesPerson.Get(RecLines."Salesperson Code");
                        SalesPersonName := SalesPerson.Name;
                    end;
                    BodyText.Append('<td align="left" Style="width:70px;padding-left:5px;padding-right:5px"> ' + SalesPersonName + ' </font></td>');

                    BodyText.Append('</tr>');
                end;
            until RecLines.Next() = 0;

            //added to show total for each UOM -start
            J := 1;
            Clear(UOMCheck);
            Clear(RecLines);
            RecLines.SetCurrentKey("Line No.");
            RecLines.SetAscending("Line No.", true);
            RecLines.SetRange("Document Type", PHeader."Document Type");
            RecLines.SetRange("Document No.", PHeader."No.");
            RecLines.SetRange(Type, RecLines.Type::Item);
            if RecLines.FindSet() then begin
                UOMCount := GetNumberUOMOnOrder(RecLines);
                repeat
                    if not UOMCheck.Contains(RecLines."Base UOM") then begin
                        UOMCheck.Add(RecLines."Base UOM");

                        Clear(RecLines2);
                        RecLines2.SetCurrentKey("Line No.");
                        RecLines2.SetAscending("Line No.", true);
                        RecLines2.SetRange("Document Type", PHeader."Document Type");
                        RecLines2.SetRange("Document No.", PHeader."No.");
                        RecLines2.SetRange(Type, RecLines2.Type::Item);
                        RecLines2.SetRange("Base UOM", RecLines."Base UOM");
                        if RecLines2.FindSet() then begin
                            //RecLines2.CalcSums("Quantity (Base)", "Unit Price Base UOM");
                            Clear(TotalAmt);
                            Clear(TotalQty);
                            repeat
                                TotalAmt += RecLines2."Unit Price Base UOM" * RecLines2."Quantity (Base)";
                                TotalQty += RecLines2."Quantity (Base)";
                            until RecLines2.Next() = 0;
                            BodyText.Append('<tr style="border:none;">');
                            if J = 1 then begin
                                if UOMCount = J then
                                    BodyText.Append('<td align="left" Style="width:120px;padding-left:5px; border:none;border-bottom: double"> <font> <b>TOTAL</b> </font></td>')
                                else
                                    BodyText.Append('<td align="left" Style="width:120px;padding-left:5px; border:none"> <font> <b>TOTAL</b> </font></td>')
                            end else begin
                                if UOMCount = J then
                                    BodyText.Append('<td align="left" Style="width:120px;padding-left:5px; border:none;border-bottom: double"></td>')
                                else
                                    BodyText.Append('<td align="left"></td>');
                            end;

                            if UOMCount = J then begin
                                BodyText.Append('<td align="left" Style="width:50px; border:none;border-bottom: double"></td>');
                                BodyText.Append('<td align="left" Style="width:70px; border:none;border-bottom: double"> <font> <b>' + FORMAT(TotalQty) + ' ' + RecLines."Base UOM" + '</b> </font></td>');
                                BodyText.Append('<td align="left" Style="width:80px; border:none;border-bottom: double"></td>');
                                BodyText.Append('<td align="left" Style="width:80px; border:none;border-bottom: double"></td>');
                                if PHeader."Currency Code" <> '' then
                                    BodyText.Append('<td align="left" Style="width:90px;padding-left:5px;padding-right:5px; border:none;border-bottom: double"> <font> <b>' + PHeader."Currency Code" + '<br/>' + FORMAT(TotalAmt, 0, '<Precision,2:2><Standard Format,0>') + '</b> </font></td>')
                                else
                                    BodyText.Append('<td align="left" Style="width:90px;padding-left:5px;padding-right:5px; border:none;border-bottom: double"> <font> <b>' + GLSetup."LCY Code" + '<br/>' + FORMAT(TotalAmt, 0, '<Precision,2:2><Standard Format,0>') + '</b> </font></td>');
                            end else begin
                                BodyText.Append('<td align="left" Style="width:50px; border:none"></td>');
                                BodyText.Append('<td align="left" Style="width:70px; border:none"> <font> <b>' + FORMAT(TotalQty) + ' ' + RecLines."Base UOM" + '</b> </font></td>');
                                BodyText.Append('<td align="left" Style="width:80px; border:none"></td>');
                                BodyText.Append('<td align="left" Style="width:80px; border:none"></td>');
                                if PHeader."Currency Code" <> '' then
                                    BodyText.Append('<td align="left" Style="width:90px;padding-left:5px;padding-right:5px; border:none"> <font> <b>' + PHeader."Currency Code" + '<br/>' + FORMAT(TotalAmt, 0, '<Precision,2:2><Standard Format,0>') + '</b> </font></td>')
                                else
                                    BodyText.Append('<td align="left" Style="width:90px;padding-left:5px;padding-right:5px; border:none"> <font> <b>' + GLSetup."LCY Code" + '<br/>' + FORMAT(TotalAmt, 0, '<Precision,2:2><Standard Format,0>') + '</b> </font></td>');
                            end;

                            BodyText.Append('<td align="left" Style="width:100px; border:none;"></td>');
                            BodyText.Append('<td align="left" Style="width:50px; border:none;"></td>');
                            BodyText.Append('<td align="left" Style="width:80px; border:none;"></td>');
                            BodyText.Append('<td align="left" Style="width:60px; border:none;"></td>');
                            BodyText.Append('<td align="left" Style="width:70px; border:none;"></td>');
                            J += 1;
                            BodyText.Append('</tr>');
                        end;
                    end;
                Until RecLines.Next() = 0;
            end;

            BodyText.Append('</table>');
            BodyText.Append('<br><br>');
        end;

        PointofDelivery := '';
        if PHeader."Ship-to Name" <> '' then begin
            PointofDelivery := PHeader."Ship-to Name" + '<br>' + PHeader."Ship-to Address" + '<br>' + PHeader."Ship-to City" + ', ' + PHeader."Ship-to Country/Region Code";
        end else begin
            PointofDelivery := CompanyInformation.Name + '<br>' + CompanyInformation.Address + '<br>' + CompanyInformation.City + ', ' + CompanyInformation."Country/Region Code";
        end;

        BodyText.Append('<table class="c">');
        BodyText.Append('<tr style="background-color:#F8CBAD"><td colspan="2" align="left"><b>Delivery Terms</b></td></tr>');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="width:100px;padding-left:5px;background-color:#FCE4D6"> <font> Incoterm: </font></td>');
        BodyText.Append('<td align="left" Style="width:200px;padding-left:5px;padding-right:5px"> <font>' + PHeader."Transaction Specification" + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="width:100px;padding-left:5px;background-color:#FCE4D6"> <font> Port of Loading: </font></td>');
        if EntryExitPoint.Get(PHeader."Entry Point") then
            BodyText.Append('<td align="left" Style="width:200px;padding-left:5px;padding-right:5px"> <font>' + EntryExitPoint.Description + ' </font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="width:100px;padding-left:5px;background-color:#FCE4D6"> <font> Port of Discharge: </font></td>');
        if AreaL.Get(PHeader."Area") then
            BodyText.Append('<td align="left" Style="width:200px;padding-left:5px;padding-right:5px"> <font> ' + AreaL.Text + ' </font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="width:100px;padding-left:5px;background-color:#FCE4D6"> <font> Point of Delivery: </font></td>');
        if AreaL.Get(PHeader."Area") then
            BodyText.Append('<td align="left" Style="width:200px;padding-left:5px;padding-right:5px"> <font> ' + PointofDelivery + ' </font></td>');
        BodyText.Append('</tr>');

        /*  CommentLine.SetRange("Document Type", CommentLine."Document Type"::Order);
         CommentLine.SetRange("No.", PHeader."No.");
         if CommentLine.FindSet() then
             repeat
                 BodyText.Append('<tr>');
                 if not CommentLinePrinted then begin
                     BodyText.Append('<td align="left" Style="width:250px;padding-left:5px"> <font> Delivery Schedule: </font></td>');
                     CommentLinePrinted := true;
                 end else
                     BodyText.Append('<td align="left" Style="padding-left:5px"></td>');
                 BodyText.Append('<td align="left" colspan="2" Style="padding-left:5px;padding-right:5px">' + CommentLine.Comment + '</td>');
                 BodyText.Append('</tr>');
             until CommentLine.Next() = 0; 

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"></td>');
        BodyText.Append('<td align="left" colspan="2" Style="padding-left:5px;padding-right:5px"></td>');
        BodyText.Append('</tr>');*/
        BodyText.Append('</table><br><br>');


        BodyText.Append('<table class="d">');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" colspan="3" Style="padding-left:5px;background-color:#F8CBAD"> <font> <b>Approval Process</b> </font></td>');
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
                    BodyText.Append('<td align="left" Style="width:300px;padding-left:5px;vertical-align:top;text-align:left;background-color:#FCE4D6"> <font> Creater: </font></td>');
                    BodyText.Append('<td align="left" Style="width:300px;padding-left:5px;vertical-align:top;text-align:left"> <font>' + SenderName + '</font></td>');
                    BodyText.Append('<td align="left" Style="width:300px;padding-right:5px;vertical-align:top;text-align:left;"> <font> ' + FORMAT(RecApprovalEntry.SystemCreatedAt) + ' </font></td>');
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
                BodyText.Append('<td align="left" Style="width:300px;padding-left:5px;vertical-align:top;text-align:left;background-color:#FCE4D6"> <font>' + SequenceNumber + '</font></td>');
                BodyText.Append('<td align="left" Style="width:300px;padding-left:5px;vertical-align:top;text-align:left"> <font>' + ApproverName + '</font></td>');

                if RecApprovalEntry.Status = RecApprovalEntry.Status::Approved then
                    BodyText.Append('<td align="left" Style="width:310px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry."Last Date-Time Modified") + ' </font></td>')
                else
                    if RecApprovalEntry.Status = RecApprovalEntry.Status::Open then
                        BodyText.Append('<td align="left" Style="width:310px;padding-right:5px;vertical-align:top;text-align:left"> <font> Pending Approval </font></td>')
                    else
                        if RecApprovalEntry.Status = RecApprovalEntry.Status::Canceled then
                            BodyText.Append('<td align="left" Style="width:310px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry."Last Date-Time Modified") + ' </font></td>')
                        else
                            if RecApprovalEntry.Status = RecApprovalEntry.Status::Created then
                                BodyText.Append('<td align="left" Style="width:310px;padding-right:5px;vertical-align:top;text-align:left"> <font> Pending Approval </font></td>')
                            else
                                if RecApprovalEntry.Status = RecApprovalEntry.Status::Rejected then
                                    BodyText.Append('<td align="left" Style="width:310px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry."Last Date-Time Modified") + ' </font></td>');


                //BodyText.Append('<td align="left" Style="width:310px;padding-right:5px"> <font> ' + Format(RecApprovalEntry."Approver Remarks") + ' </font></td>');
                BodyText.Append('</tr>');
            until RecApprovalEntry.Next() = 0;
        end;



        BodyText.Append('</table>');
        BodyText.Append('<br>');
        BodyText.Append('<table class="c"><tr><td Style="width:130px;padding-left:5px;padding-right:5px;background-color:#F8CBAD"><b>Link to PO:</b></td> <td style="padding-left:5px;padding-right:5px;">' + StrSubstNo('<p> <a href="%1">Open document in Business Central</a> </p>', GetUrl(ClientType::Web, CompanyName, ObjectType::Page, PageId, PHeader, false)) + '</td></tr></table>');

        exit(BodyText.ToText());
    end;

    local procedure CreateEmailBodyCustomer(Var Customer: Record Customer; Var Receiver: Record User; Var Sender: Record User; Var RecAppEntry: Record "Approval Entry"; ToUser: Code[10]; ActionText: Text): Text
    var
        RecLines: Record "Purchase Line";
        Vendor: Record Vendor;
        RecApprovalEntry: Record "Approval Entry";
        GLSetup: Record "General Ledger Setup";
        RecPaymentTerms: Record "Payment Terms";
        Recteams: Record Team;
        RecteamSalesPerson: Record "Team Salesperson";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        CustomerGroup: Record "Customer Group";
        SalesPerson: Record "Salesperson/Purchaser";
        RecItem: Record Item;
        RecCLE: record "Cust. Ledger Entry";
        ShortName: Record "Company Short Name";
        Utility: Codeunit Events;
        RecLines2: Record "Sales Line";
        BodyText: TextBuilder;
        UOMCheck: List of [Text];
        TestText: Text;
        PaymentTermsText, ColorText : Text;
        PageId, J : Integer;
        TotalAmt, TotalQty, AvailableLimit, UsedLimit, OverDueHistory : Decimal;
        UnitPriceColor: Label 'style="color:%1"; font-weight: %2';
    begin
        GLSetup.Get();
        BodyText.Append('<style>table { border-collapse: collapse; border: 1px solid black;} table.a { table-layout: auto;  width: 650px; } table.b { table-layout: auto;  width: 500px; } table.c { table-layout: auto;  width: 500px; }table.d { table-layout: auto;  width: 420px; } </style>');

        // BodyText.Append('<style>table { border-collapse: collapse; border: 1px solid black;} table.a { table-layout: auto;  width: 560px; } table.b { table-layout: auto;  width: 1400px; } table.c { table-layout: auto;  width: 670px; }table.d { table-layout: auto;  width: 420px; } </style>');

        ShortName.GET(CompanyName);
        if ToUser = 'SENDER' then
            BodyText.Append('Hello ' + Sender."User Name" + '<br><br>You are registered to receive notifications related to ' + ShortName."Short Name" + '.')
        else
            BodyText.Append('Hello ' + Receiver."User Name" + '<br><br>You are registered to receive notifications related to ' + ShortName."Short Name" + '.');

        BodyText.Append('<br><br>This is a message to notify you that:');
        BodyText.Append('<br><br>');
        BodyText.Append(StrSubstNo('%1 %2 %3', Customer."No.", Customer.Name, ActionText));

        BodyText.Append('<br><br>');
        BodyText.Append('<table class="a">');
        BodyText.Append('<tr>');//YH++
        BodyText.Append('<td align="left" Style="padding-left:5px; color:red;"> <font> New Credit Limit (' + GLSetup."LCY Code" + ')</font></td>');
        BodyText.Append('<td align="left"> <font> <b>' + Format(RecAppEntry.RecordDetails) + '</b></font></td>');
        BodyText.Append('</tr>');//YH--

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Customer No.: </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Customer."No." + '</font></td>');
        BodyText.Append('</tr>');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Customer Name </font></td>');
        BodyText.Append('<td align="left"> <font> <b>' + Customer.Name + '</b> </font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Customer Short Name: </font></td>');
        BodyText.Append('<td align="left"> <font> <b>' + Customer."Search Name" + '</b> </font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Tier Ranking </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Customer."Customer Disc. Group" + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Payment Term: </font></td>');
        if RecPaymentTerms.GET(Customer."Payment Terms Code") then
            BodyText.Append('<td align="left"> <font> ' + RecPaymentTerms.Description + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Credit Limit (' + GLSetup."LCY Code" + ')</font></td>');
        BodyText.Append('<td align="left"> <font> ' + Format(Customer."Credit Limit (LCY)") + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Insurance Limit (' + GLSetup."LCY Code" + ')</font></td>');
        BodyText.Append('<td align="left"> <font> ' + Format(Customer."Insurance Limit (LCY) 2") + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Salesperson Name: </font></td>');
        if SalesPerson.Get(Customer."Salesperson Code") then
            BodyText.Append('<td align="left"> <font> ' + SalesPerson.Name + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Customer Group Name: </font></td>');
        if CustomerGroup.Get(Customer."Customer Group Code 2") then
            BodyText.Append('<td align="left"> <font> ' + CustomerGroup."Description/Name" + '</font></td>');
        BodyText.Append('</tr>');

        //T52160-OS
        // BodyText.Append('<tr>');
        // BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Market Industry: </font></td>');
        // BodyText.Append('<td align="left"> <font> ' + Customer."Market Industry Description" + '</font></td>');
        // BodyText.Append('</tr>');
        //T52160-OE

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Address </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Customer.Address + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Address 2 </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Customer."Address 2" + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> City </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Customer.City + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Country </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Customer."Country/Region Code" + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Phone Number </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Customer."Phone No." + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Email </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Customer."E-Mail" + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('</table>');

        //Table2
        BodyText.Append('<br><br>');
        BodyText.Append('<table class="b">');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Gen. Bus. Posting Group: </font></td>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> ' + Customer."Gen. Bus. Posting Group" + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> VAT Bus. Posting Group: </font></td>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> ' + Customer."VAT Bus. Posting Group" + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Customer Posting Group: </font></td>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> ' + Customer."Customer Posting Group" + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left"> <font> </font></td>');
        BodyText.Append('<td align="left"> <font> </font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('</table>');

        //Table3
        BodyText.Append('<br><br>');
        BodyText.Append('<table class="c">');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" colspan="3" Style="padding-left:5px"> <font> Approval Process </font></td>');
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
                    BodyText.Append('<tr>');
                    BodyText.Append('<td align="left "colspan="1" Style="width:300px;padding-left:5px;vertical-align:top;text-align:left"> <font>' + RecApprovalEntry."Sender ID" + ' (Creator) </font></td>');
                    BodyText.Append('<td align="left" colspan="2" Style="width:180px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry.SystemCreatedAt) + ' </font></td>');
                    BodyText.Append('</tr>');
                end;

                BodyText.Append('<tr>');
                BodyText.Append('<td align="left" Style="width:300px;padding-left:5px;vertical-align:top;text-align:left"> <font>' + RecApprovalEntry."Approver ID" + '</font></td>');


                if RecApprovalEntry.Status = RecApprovalEntry.Status::Approved then
                    BodyText.Append('<td align="left" Style="width:310px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry."Last Date-Time Modified") + ' </font></td>')
                else
                    if RecApprovalEntry.Status = RecApprovalEntry.Status::Open then
                        BodyText.Append('<td align="left" Style="width:310px;padding-right:5px;vertical-align:top;text-align:left"> <font> Pending Approval </font></td>')
                    else
                        if RecApprovalEntry.Status = RecApprovalEntry.Status::Canceled then
                            BodyText.Append('<td align="left" Style="width:310px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry."Last Date-Time Modified") + ' </font></td>')
                        else
                            if RecApprovalEntry.Status = RecApprovalEntry.Status::Created then
                                BodyText.Append('<td align="left" Style="width:310px;padding-right:5px;vertical-align:top;text-align:left"> <font> Pending Approval </font></td>')
                            else
                                if RecApprovalEntry.Status = RecApprovalEntry.Status::Rejected then
                                    BodyText.Append('<td align="left" Style="width:310px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry."Last Date-Time Modified") + ' </font></td>');


                BodyText.Append('<td align="left" Style="width:310px;padding-right:5px"> <font> ' + Format(RecApprovalEntry."Approver Remarks") + ' </font></td>');
                BodyText.Append('</tr>');
            until RecApprovalEntry.Next() = 0;
        end;
        BodyText.Append('</table>');
        BodyText.Append('<br><br>');

        BodyText.Append(StrSubstNo('<p> <a href="%1">Open document in Business Central</a> </p>', GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Customer Card", Customer, False)));

        exit(BodyText.ToText());
    end;

    local procedure CreateEmailBodyVendor(Var Vendor: Record Vendor; Var Receiver: Record User; Var Sender: Record User; Var RecAppEntry: Record "Approval Entry"; ToUser: Code[10]; ActionText: Text): Text
    var
        RecLines: Record "Purchase Line";
        RecApprovalEntry: Record "Approval Entry";
        GLSetup: Record "General Ledger Setup";
        RecPaymentTerms: Record "Payment Terms";
        Recteams: Record Team;
        RecteamSalesPerson: Record "Team Salesperson";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        CustomerGroup: Record "Customer Group";
        SalesPerson: Record "Salesperson/Purchaser";
        RecItem: Record Item;
        RecCLE: record "Cust. Ledger Entry";
        ShortName: Record "Company Short Name";
        Utility: Codeunit Events;
        RecLines2: Record "Sales Line";
        BodyText: TextBuilder;
        UOMCheck: List of [Text];
        TestText: Text;
        PaymentTermsText, ColorText : Text;
        PageId, J : Integer;
        TotalAmt, TotalQty, AvailableLimit, UsedLimit, OverDueHistory : Decimal;
        UnitPriceColor: Label 'style="color:%1"; font-weight: %2';
    begin
        BodyText.Append('<style>table { border-collapse: collapse; border: 1px solid black;} table.a { table-layout: auto;  width: 650px; } table.b { table-layout: auto;  width: 500px; } table.c { table-layout: auto;  width: 500px; }table.d { table-layout: auto;  width: 420px; } </style>');

        //BodyText.Append('<style>table { border-collapse: collapse; border: 1px solid black;} table.a { table-layout: auto;  width: 560px; } table.b { table-layout: auto;  width: 1400px; } table.c { table-layout: auto;  width: 670px; }table.d { table-layout: auto;  width: 420px; } </style>');

        ShortName.GET(CompanyName);
        if ToUser = 'SENDER' then
            BodyText.Append('Hello ' + Sender."User Name" + '<br><br>You are registered to receive notifications related to ' + ShortName."Short Name" + '.')
        else
            BodyText.Append('Hello ' + Receiver."User Name" + '<br><br>You are registered to receive notifications related to ' + ShortName."Short Name" + '.');

        BodyText.Append('<br><br>This is a message to notify you that:');
        BodyText.Append('<br><br>');
        BodyText.Append(StrSubstNo('%1 %2 %3', Vendor."No.", Vendor.Name, ActionText));

        BodyText.Append('<br><br>');
        BodyText.Append('<table class="a">');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Vendor No.: </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Vendor."No." + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Vendor Name: </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Vendor.Name + '</font></td>');
        BodyText.Append('</tr>');

        if RecPaymentTerms.GET(Vendor."Payment Terms Code") then begin
            BodyText.Append('<tr>');
            BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Payment Term: </font></td>');
            BodyText.Append('<td align="left"> <font> ' + RecPaymentTerms.Description + '</font></td>');
            BodyText.Append('</tr>');
        end;

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Address </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Vendor.Address + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Address 2 </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Vendor."Address 2" + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> City </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Vendor.City + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Country </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Vendor.County + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Phone Number </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Vendor."Phone No." + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Email </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Vendor."E-Mail" + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('</table>');

        //Table2
        BodyText.Append('<br><br>');
        BodyText.Append('<table class="b">');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Gen. Bus. Posting Group: </font></td>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> ' + Vendor."Gen. Bus. Posting Group" + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> VAT Bus. Posting Group: </font></td>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> ' + Vendor."VAT Bus. Posting Group" + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Vendor Posting Group: </font></td>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> ' + Vendor."Vendor Posting Group" + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left"> <font> </font></td>');
        BodyText.Append('<td align="left"> <font> </font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('</table>');

        //Table3
        BodyText.Append('<br><br>');
        BodyText.Append('<table class="c">');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" colspan="3" Style="padding-left:5px"> <font> Approval Process </font></td>');
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
                    BodyText.Append('<tr>');
                    BodyText.Append('<td align="left "colspan="1" Style="width:300px;padding-left:5px;vertical-align:top;text-align:left"> <font>' + RecApprovalEntry."Sender ID" + ' (Creator) </font></td>');
                    BodyText.Append('<td align="left" colspan="2" Style="width:180px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry.SystemCreatedAt) + ' </font></td>');
                    BodyText.Append('</tr>');
                end;

                BodyText.Append('<tr>');
                BodyText.Append('<td align="left" Style="width:300px;padding-left:5px;vertical-align:top;text-align:left"> <font>' + RecApprovalEntry."Approver ID" + '</font></td>');


                if RecApprovalEntry.Status = RecApprovalEntry.Status::Approved then
                    BodyText.Append('<td align="left" Style="width:310px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry."Last Date-Time Modified") + ' </font></td>')
                else
                    if RecApprovalEntry.Status = RecApprovalEntry.Status::Open then
                        BodyText.Append('<td align="left" Style="width:310px;padding-right:5px;vertical-align:top;text-align:left"> <font> Pending Approval </font></td>')
                    else
                        if RecApprovalEntry.Status = RecApprovalEntry.Status::Canceled then
                            BodyText.Append('<td align="left" Style="width:310px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry."Last Date-Time Modified") + ' </font></td>')
                        else
                            if RecApprovalEntry.Status = RecApprovalEntry.Status::Created then
                                BodyText.Append('<td align="left" Style="width:310px;padding-right:5px;vertical-align:top;text-align:left"> <font> Pending Approval </font></td>')
                            else
                                if RecApprovalEntry.Status = RecApprovalEntry.Status::Rejected then
                                    BodyText.Append('<td align="left" Style="width:310px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry."Last Date-Time Modified") + ' </font></td>');


                BodyText.Append('<td align="left" Style="width:310px;padding-right:5px"> <font> ' + Format(RecApprovalEntry."Approver Remarks") + ' </font></td>');
                BodyText.Append('</tr>');
            until RecApprovalEntry.Next() = 0;
        end;
        BodyText.Append('</table>');
        BodyText.Append('<br><br>');

        BodyText.Append(StrSubstNo('<p> <a href="%1">Open document in Business Central</a> </p>', GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Vendor Card", Vendor, False)));

        exit(BodyText.ToText());
    end;

    local procedure CreateEmailBodyItem(Var Item: Record Item; Var Receiver: Record User; Var Sender: Record User; Var RecAppEntry: Record "Approval Entry"; ToUser: Code[10]; ActionText: Text): Text
    var
        RecLines: Record "Purchase Line";
        Vendor: Record Vendor;
        RecApprovalEntry: Record "Approval Entry";
        GLSetup: Record "General Ledger Setup";
        RecPaymentTerms: Record "Payment Terms";
        Recteams: Record Team;
        RecteamSalesPerson: Record "Team Salesperson";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
        CustomerGroup: Record "Customer Group";
        SalesPerson: Record "Salesperson/Purchaser";
        RecItem: Record Item;
        RecCLE: record "Cust. Ledger Entry";
        ShortName: Record "Company Short Name";
        Utility: Codeunit Events;
        RecLines2: Record "Sales Line";
        ItemUnitofMeasure: Record "Item Unit of Measure";
        BodyText: TextBuilder;
        UOMCheck: List of [Text];
        TestText: Text;
        PaymentTermsText, ColorText : Text;
        PageId, J : Integer;
        TotalAmt, TotalQty, AvailableLimit, UsedLimit, OverDueHistory : Decimal;
        UnitPriceColor: Label 'style="color:%1"; font-weight: %2';
    begin
        BodyText.Append('<style>table { border-collapse: collapse; border: 1px solid black;} table.a { table-layout: auto;  width: 650px; } table.b { table-layout: auto;  width: 500px; } table.c { table-layout: auto;  width: 700px; }table.d { table-layout: auto;  width: 420px; } </style>');

        //BodyText.Append('<style>table { border-collapse: collapse; border: 1px solid black;} table.a { table-layout: auto;  width: 560px; } table.b { table-layout: auto;  width: 1400px; } table.c { table-layout: auto;  width: 670px; }table.d { table-layout: auto;  width: 420px; } </style>');

        ShortName.GET(CompanyName);
        if ToUser = 'SENDER' then
            BodyText.Append('Hello ' + Sender."User Name" + '<br><br>You are registered to receive notifications related to ' + ShortName."Short Name" + '.')
        else
            BodyText.Append('Hello ' + Receiver."User Name" + '<br><br>You are registered to receive notifications related to ' + ShortName."Short Name" + '.');

        BodyText.Append('<br><br>This is a message to notify you that:');
        BodyText.Append('<br><br>');
        BodyText.Append(StrSubstNo('%1 %2 %3', Item."No.", Item.Description, ActionText));

        BodyText.Append('<br><br>');
        BodyText.Append('<table class="a">');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Item No.: </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Item."No." + '</font></td>');
        BodyText.Append('</tr>');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Item Description: </font></td>');
        BodyText.Append('<td align="left"> <font> <b>' + Item.Description + '</b> </font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Item Short Name: </font></td>');
        BodyText.Append('<td align="left"> <font> <b>' + Item."Search Description" + '</b> </font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Packing Description: </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Item."Description 2" + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Base UOM: </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Item."Base Unit of Measure" + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Product Family: </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Item."Product Family" + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Item Category: </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Item."Item Category Desc." + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Market Industry: </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Item.MarketIndustry + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Generic Name: </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Item.GenericName + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> UN Number </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Item."IMCO Class" + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> HS Code: </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Item."Tariff No." + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Legal COO: </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Item."Country/Region of Origin Code" + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Vendor COO: </font></td>');
        BodyText.Append('<td align="left"> <font> ' + Item."Vendor Country of Origin" + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left"> <font> </font></td>');
        BodyText.Append('<td align="left"> <font> </font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('</table>');

        //Table2
        BodyText.Append('<br><br>');
        BodyText.Append('<table class="b">');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Gen. Prod. Posting Group: </font></td>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> ' + Item."Gen. Prod. Posting Group" + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> VAT Prod. Posting Group: </font></td>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> ' + Item."VAT Prod. Posting Group" + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Inventory Posting Group: </font></td>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> ' + Item."Inventory Posting Group" + '</font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left"> <font> </font></td>');
        BodyText.Append('<td align="left"> <font> </font></td>');
        BodyText.Append('</tr>');

        BodyText.Append('</table>');

        //Table3
        BodyText.Append('<br><br>');
        BodyText.Append('<table class="c">');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Code </font></td>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Qty. per Unit of Measure </font></td>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Net Weight (kg) </font></td>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Packing Weight (kg) </font></td>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Variant Code </font></td>');
        BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Default Selection </font></td>');
        BodyText.Append('</tr>');

        ItemUnitofMeasure.SetRange("Item No.", Item."No.");
        if ItemUnitofMeasure.FindSet() then
            repeat
                BodyText.Append('<tr>');
                BodyText.Append('<td align="left" Style="padding-left:5px">' + ItemUnitofMeasure.Code + '</td>');
                BodyText.Append('<td align="left" Style="padding-left:5px">' + Format(ItemUnitofMeasure."Qty. per Unit of Measure") + '</td>');
                BodyText.Append('<td align="left" Style="padding-left:5px">' + Format(ItemUnitofMeasure."Net Weight") + '</td>');
                BodyText.Append('<td align="left" Style="padding-left:5px">' + Format(ItemUnitofMeasure."Packing Weight") + '</td>');
                BodyText.Append('<td align="left" Style="padding-left:5px">' + ItemUnitofMeasure."Variant Code" + '</td>');
                BodyText.Append('<td align="left" Style="padding-left:5px">' + Format(ItemUnitofMeasure.Default) + '</td>');
                BodyText.Append('</tr>');
            until ItemUnitofMeasure.Next() = 0;

        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" Style="padding-left:5px"></td>');
        BodyText.Append('</tr>');
        BodyText.Append('</table>');

        //Table4
        BodyText.Append('<br><br>');
        BodyText.Append('<table class="d">');
        BodyText.Append('<tr>');
        BodyText.Append('<td align="left" colspan="3" Style="padding-left:5px"> <font> Approval Process </font></td>');
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
                    BodyText.Append('<tr>');
                    BodyText.Append('<td align="left "colspan="1" Style="width:300px;padding-left:5px;vertical-align:top;text-align:left"> <font>' + RecApprovalEntry."Sender ID" + ' (Creator) </font></td>');
                    BodyText.Append('<td align="left" colspan="2" Style="width:180px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry.SystemCreatedAt) + ' </font></td>');
                    BodyText.Append('</tr>');
                end;

                BodyText.Append('<tr>');
                BodyText.Append('<td align="left" Style="width:300px;padding-left:5px;vertical-align:top;text-align:left"> <font>' + RecApprovalEntry."Approver ID" + '</font></td>');


                if RecApprovalEntry.Status = RecApprovalEntry.Status::Approved then
                    BodyText.Append('<td align="left" Style="width:310px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry."Last Date-Time Modified") + ' </font></td>')
                else
                    if RecApprovalEntry.Status = RecApprovalEntry.Status::Open then
                        BodyText.Append('<td align="left" Style="width:310px;padding-right:5px;vertical-align:top;text-align:left"> <font> Pending Approval </font></td>')
                    else
                        if RecApprovalEntry.Status = RecApprovalEntry.Status::Canceled then
                            BodyText.Append('<td align="left" Style="width:310px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry."Last Date-Time Modified") + ' </font></td>')
                        else
                            if RecApprovalEntry.Status = RecApprovalEntry.Status::Created then
                                BodyText.Append('<td align="left" Style="width:310px;padding-right:5px;vertical-align:top;text-align:left"> <font> Pending Approval </font></td>')
                            else
                                if RecApprovalEntry.Status = RecApprovalEntry.Status::Rejected then
                                    BodyText.Append('<td align="left" Style="width:310px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry."Last Date-Time Modified") + ' </font></td>');


                BodyText.Append('<td align="left" Style="width:310px;padding-right:5px"> <font> ' + Format(RecApprovalEntry."Approver Remarks") + ' </font></td>');
                BodyText.Append('</tr>');
            until RecApprovalEntry.Next() = 0;
        end;
        BodyText.Append('</table>');
        BodyText.Append('<br><br>');

        BodyText.Append(StrSubstNo('<p> <a href="%1">Open document in Business Central</a> </p>', GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Item Card", Item, False)));

        exit(BodyText.ToText());
    end;

    procedure GetNumberUOMOnOrder(RecLinesP: Record "Purchase Line"): Integer
    var
        RecLinesL: Record "Purchase Line";
        UOMCheck: List of [Text];
    begin
        RecLinesL.SetCurrentKey("Line No.");
        RecLinesL.SetAscending("Line No.", true);
        RecLinesL.SetRange("Document Type", RecLinesP."Document Type");
        RecLinesL.SetRange("Document No.", RecLinesP."Document No.");
        RecLinesL.SetRange(Type, RecLinesL.Type::Item);
        if RecLinesL.FindSet() then begin
            repeat
                if not UOMCheck.Contains(RecLinesL."Base UOM") then
                    UOMCheck.Add(RecLinesL."Base UOM");
            until RecLinesL.Next() = 0;
            exit(UOMCheck.Count);
        end;
    end;
}