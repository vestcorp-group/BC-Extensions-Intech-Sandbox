// codeunit 53214 AmendmentWorkflowEmail//T12370-Full Comment
// {
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', true, true)]
//     local procedure OnBeforeDelegateAmendmentApprovalRequests(var ApprovalEntry: Record "Approval Entry")
//     var
//         ApprovalEntry2: Record "Approval Entry";
//     begin
//         Clear(ApprovalEntry2);
//         ApprovalEntry2.SetRange("Entry No.", ApprovalEntry."Entry No.");
//         if ApprovalEntry2.FindFirst() then begin

//             AmendmentNotificationToSender(ApprovalEntry2);
//             AmendmentNotificationToApproverDelegate(ApprovalEntry2);
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', true, true)]
//     local procedure OnApproveAmendmentApprovalRequest(var ApprovalEntry: Record "Approval Entry")
//     begin
//         AmendmentApprovedNotificationToSender(ApprovalEntry);
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterRejectSelectedApprovalRequest', '', true, true)]
//     local procedure OnAfterAmendmentRejectApproval(var ApprovalEntry: Record "Approval Entry")
//     begin
//         AmendmentRejectedNotificationToSender(ApprovalEntry);
//     end;

//     //local procedure fnOnBeforeApprovalEntryInsert(var ApprovalEntry: Record "Approval Entry"; ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepArgument: Record "Workflow Step Argument"; ApproverId: Code[50]; var IsHandled: Boolean)
//     [EventSubscriber(ObjectType::Table, Database::"Approval Entry", 'OnAfterValidateEvent', 'Status', true, true)]
//     local procedure OnBeforeAmendmentStatusChange(VAR Rec: Record "Approval Entry"; VAR xRec: Record "Approval Entry"; CurrFieldNo: Integer)
//     begin
//         IF (xRec.Status = xRec.Status::Created) AND (Rec.Status = Rec.Status::Open) THEN begin
//             AmendmentNotificationToApprover(Rec);
//             AmendmentNotificationToSender(Rec);
//         end;
//         //SendApprovalRequestFromRecord
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnCancelApprovalRequestsForRecordOnAfterSetApprovalEntryFilters', '', true, true)]
//     local procedure AmendmentCancelNotification(var ApprovalEntry: Record "Approval Entry"; RecRef: RecordRef);
//     begin
//         if ApprovalEntry.FindFirst() then begin
//             AmendmentCancelledNotificationToApprover(ApprovalEntry);
//             AmendmentCancelledNotificationToSender(ApprovalEntry);
//         end;
//     end;

//     local procedure AmendmentNotificationToApprover(var ApprovalEntry: Record "Approval Entry")
//     var
//         EmailMessage: Codeunit "Email Message";
//         Email: Codeunit Email;
//         Recipients: List of [Text];
//         Subject: Text;
//         Body: Text;
//         SenderUserSetup: Record "User Setup";
//         ReceiverSetup: Record "User Setup";
//         SendUser: Record User;
//         ReceiverUser: Record User;
//         PageId: Integer;
//         AmendmentHeader: Record "Amendment Request";
//         //SubjectLabel: Label 'Document Amendment Request - Invoice No. %1'; //hide by bayas
//         SubjectLabel: Label 'ERP Approval Request - %1 - %2 - %3 - %4'; //added by bayas   
//         ShortName: Record "Company Short Name";
//         CustomerShortName: Text;
//         RecCustomer: Record Customer;
//         SalesHeader: Record "Sales Invoice Header";
//     begin
//         Clear(CustomerShortName);
//         ShortName.GET(CompanyName);
//         if ApprovalEntry."Table ID" <> Database::"Amendment Request" then
//             exit;
//         if SenderUserSetup.Get(ApprovalEntry."Sender ID") then;
//         SendUser.Reset();
//         SendUser.SetRange("User Name", SenderUserSetup."User ID");
//         if SendUser.FindFirst() then;
//         if ReceiverSetup.Get(ApprovalEntry."Approver ID") then;
//         ReceiverUser.Reset();
//         ReceiverUser.SetRange("User Name", ReceiverSetup."User ID");
//         if ReceiverUser.FindFirst() then;
//         Recipients.Add(ReceiverSetup."E-Mail");
//         Clear(AmendmentHeader);
//         AmendmentHeader.SetRange("Amendment No.", ApprovalEntry."Document No.");
//         //AmendmentHeader.GET(ApprovalEntry."Document No.");
//         AmendmentHeader.FindFirst();

//         SalesHeader.GET(AmendmentHeader."Document No.");
//         RecCustomer.GET(SalesHeader."Sell-to Customer No.");
//         if RecCustomer.AltCustomerName <> '' then begin //added by bayas
//             CustomerShortName := RecCustomer.AltCustomerName;
//         end else begin
//             CustomerShortName := RecCustomer."Search Name";
//         end;

//         //Subject := StrSubstNo(SubjectLabel, AmendmentHeader."Document No."); //hide by bayas
//         Subject := StrSubstNo(SubjectLabel, ShortName."Short Name", 'Document Amendment', AmendmentHeader."Document No.", CustomerShortName); //added by bayas
//         PageId := Page::"Amendment Request";
//         Body := CreateEmailBody(AmendmentHeader, ReceiverUser, SendUser, ApprovalEntry, 'APPROVER', 'requires your approval.');
//         EmailMessage.Create(Recipients, Subject, Body, true);
//         Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022
//     end;

//     local procedure AmendmentNotificationToApproverDelegate(var ApprovalEntry: Record "Approval Entry")
//     var
//         EmailMessage: Codeunit "Email Message";
//         Email: Codeunit Email;
//         Recipients: List of [Text];
//         Subject: Text;
//         Body: Text;
//         SenderUserSetup: Record "User Setup";
//         ReceiverSetup: Record "User Setup";
//         SendUser: Record User;
//         ReceiverUser: Record User;
//         PageId: Integer;
//         AmendmentHeader: Record "Amendment Request";
//         //SubjectLabel: Label 'Document Amendment Request - Invoice No. %1'; //hide by bayas
//         SubjectLabel: Label 'ERP Approval Request - %1 - %2 - %3 - %4 - Delegated'; //added by bayas   
//         ShortName: Record "Company Short Name";
//         CustomerShortName: Text;
//         RecCustomer: Record Customer;
//         SalesHeader: Record "Sales Invoice Header";
//     begin
//         Clear(CustomerShortName);
//         ShortName.GET(CompanyName);
//         if ApprovalEntry."Table ID" <> Database::"Amendment Request" then
//             exit;
//         if SenderUserSetup.Get(ApprovalEntry."Sender ID") then;
//         SendUser.Reset();
//         SendUser.SetRange("User Name", SenderUserSetup."User ID");
//         if SendUser.FindFirst() then;
//         if ReceiverSetup.Get(ApprovalEntry."Approver ID") then;
//         ReceiverUser.Reset();
//         ReceiverUser.SetRange("User Name", ReceiverSetup."User ID");
//         if ReceiverUser.FindFirst() then;
//         Recipients.Add(ReceiverSetup."E-Mail");
//         Clear(AmendmentHeader);
//         AmendmentHeader.SetRange("Amendment No.", ApprovalEntry."Document No.");
//         //AmendmentHeader.GET(ApprovalEntry."Document No.");
//         AmendmentHeader.FindFirst();

//         SalesHeader.GET(AmendmentHeader."Document No.");
//         RecCustomer.GET(SalesHeader."Sell-to Customer No.");
//         if RecCustomer.AltCustomerName <> '' then begin //added by bayas
//             CustomerShortName := RecCustomer.AltCustomerName;
//         end else begin
//             CustomerShortName := RecCustomer."Search Name";
//         end;

//         //Subject := StrSubstNo(SubjectLabel, AmendmentHeader."Document No."); //hide by bayas
//         Subject := StrSubstNo(SubjectLabel, ShortName."Short Name", 'Document Amendment', AmendmentHeader."Document No.", CustomerShortName); //added by bayas
//         PageId := Page::"Amendment Request";
//         Body := CreateEmailBody(AmendmentHeader, ReceiverUser, SendUser, ApprovalEntry, 'APPROVER', 'requires your approval.');
//         EmailMessage.Create(Recipients, Subject, Body, true);
//         Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022
//     end;

//     local procedure AmendmentNotificationToSender(var ApprovalEntry: Record "Approval Entry")
//     var
//         EmailMessage: Codeunit "Email Message";
//         Email: Codeunit Email;
//         Recipients: List of [Text];
//         Subject: Text;
//         Body: Text;
//         SenderUserSetup: Record "User Setup";
//         ReceiverSetup: Record "User Setup";
//         SendUser: Record User;
//         ReceiverUser: Record User;
//         PageId: Integer;
//         AmendmentHeader: Record "Amendment Request";
//         //SubjectLabel: Label 'Document Amendment Request - Invoice No. %1';
//         SubjectLabel: Label 'ERP Approval Request - %1 - %2 - %3 - %4'; //added by bayas   
//         ShortName: Record "Company Short Name";
//         CustomerShortName: Text;
//         RecCustomer: Record Customer;
//         SalesHeader: Record "Sales Invoice Header";
//     begin
//         Clear(CustomerShortName);
//         ShortName.GET(CompanyName);
//         if ApprovalEntry."Table ID" <> Database::"Amendment Request" then
//             exit;
//         if SenderUserSetup.Get(ApprovalEntry."Sender ID") then;
//         SendUser.Reset();
//         SendUser.SetRange("User Name", SenderUserSetup."User ID");
//         if SendUser.FindFirst() then;
//         if ReceiverSetup.Get(ApprovalEntry."Approver ID") then;
//         ReceiverUser.Reset();
//         ReceiverUser.SetRange("User Name", ReceiverSetup."User ID");
//         if ReceiverUser.FindFirst() then;
//         Recipients.Add(SenderUserSetup."E-Mail");
//         Clear(AmendmentHeader);
//         AmendmentHeader.SetRange("Amendment No.", ApprovalEntry."Document No.");
//         //AmendmentHeader.GET(ApprovalEntry."Document No.");
//         AmendmentHeader.FindFirst();

//         SalesHeader.GET(AmendmentHeader."Document No.");
//         RecCustomer.GET(SalesHeader."Sell-to Customer No.");
//         if RecCustomer.AltCustomerName <> '' then begin //added by bayas
//             CustomerShortName := RecCustomer.AltCustomerName;
//         end else begin
//             CustomerShortName := RecCustomer."Search Name";
//         end;

//         //Subject := StrSubstNo(SubjectLabel, AmendmentHeader."Document No.");
//         Subject := StrSubstNo(SubjectLabel, ShortName."Short Name", 'Document Amendment', AmendmentHeader."Document No.", CustomerShortName); //added by bayas
//         PageId := Page::"Amendment Request";
//         Body := CreateEmailBody(AmendmentHeader, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('requires %1 approval.', ReceiverUser."Full Name"));
//         EmailMessage.Create(Recipients, Subject, Body, true);
//         Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022
//     end;

//     local procedure AmendmentApprovedNotificationToSender(var ApprovalEntry: Record "Approval Entry")
//     var
//         EmailMessage: Codeunit "Email Message";
//         Email: Codeunit Email;
//         Recipients: List of [Text];
//         Subject: Text;
//         Body: Text;
//         //SubjectLabel: Label 'Document Amendment Request - Invoice No. %1';
//         SenderUserSetup: Record "User Setup";
//         ReceiverSetup: Record "User Setup";
//         SendUser: Record User;
//         ReceiverUser: Record User;
//         PageId: Integer;
//         AmendmentHeader: Record "Amendment Request";
//         SubjectLabel: Label 'ERP Approval Request - %1 - %2 - %3 - %4'; //added by bayas   
//         ShortName: Record "Company Short Name";
//         CustomerShortName: Text;
//         RecCustomer: Record Customer;
//         SalesHeader: Record "Sales Invoice Header";
//     begin
//         Clear(CustomerShortName);
//         ShortName.GET(CompanyName);
//         if ApprovalEntry."Table ID" <> Database::"Amendment Request" then
//             exit;
//         if SenderUserSetup.Get(ApprovalEntry."Sender ID") then;
//         SendUser.Reset();
//         SendUser.SetRange("User Name", SenderUserSetup."User ID");
//         if SendUser.FindFirst() then;
//         if ReceiverSetup.Get(ApprovalEntry."Approver ID") then;
//         ReceiverUser.Reset();
//         ReceiverUser.SetRange("User Name", ReceiverSetup."User ID");
//         if ReceiverUser.FindFirst() then;
//         Recipients.Add(SenderUserSetup."E-Mail");
//         Clear(AmendmentHeader);
//         Clear(AmendmentHeader);
//         AmendmentHeader.SetRange("Amendment No.", ApprovalEntry."Document No.");
//         //AmendmentHeader.GET(ApprovalEntry."Document No.");
//         AmendmentHeader.FindFirst();

//         SalesHeader.GET(AmendmentHeader."Document No.");
//         RecCustomer.GET(SalesHeader."Sell-to Customer No.");
//         if RecCustomer.AltCustomerName <> '' then begin //added by bayas
//             CustomerShortName := RecCustomer.AltCustomerName;
//         end else begin
//             CustomerShortName := RecCustomer."Search Name";
//         end;

//         //Subject := StrSubstNo(SubjectLabel, AmendmentHeader."Document No.");
//         Subject := StrSubstNo(SubjectLabel, ShortName."Short Name", 'Document Amendment', AmendmentHeader."Document No.", CustomerShortName); //added by bayas
//         PageId := Page::"Amendment Request";
//         Body := CreateEmailBody(AmendmentHeader, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('is approved by %1.', ReceiverUser."Full Name"));
//         EmailMessage.Create(Recipients, Subject, Body, true);
//         Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022
//     end;

//     local procedure AmendmentRejectedNotificationToSender(var ApprovalEntry: Record "Approval Entry")
//     var
//         EmailMessage: Codeunit "Email Message";
//         Email: Codeunit Email;
//         Recipients: List of [Text];
//         Subject: Text;
//         Body: Text;
//         //SubjectLabel: Label 'Document Amendment Request - Invoice No. %1';
//         SenderUserSetup: Record "User Setup";
//         ReceiverSetup: Record "User Setup";
//         SendUser: Record User;
//         ReceiverUser: Record User;
//         PageId: Integer;
//         AmendmentHeader: Record "Amendment Request";
//         SubjectLabel: Label 'ERP Approval Rejected - %1 - %2 - %3 - %4'; //added by bayas   
//         ShortName: Record "Company Short Name";
//         CustomerShortName: Text;
//         RecCustomer: Record Customer;
//         SalesHeader: Record "Sales Invoice Header";
//     begin
//         Clear(CustomerShortName);
//         ShortName.GET(CompanyName);
//         if ApprovalEntry."Table ID" <> Database::"Amendment Request" then
//             exit;
//         if SenderUserSetup.Get(ApprovalEntry."Sender ID") then;
//         SendUser.Reset();
//         SendUser.SetRange("User Name", SenderUserSetup."User ID");
//         if SendUser.FindFirst() then;
//         if ReceiverSetup.Get(ApprovalEntry."Approver ID") then;
//         ReceiverUser.Reset();
//         ReceiverUser.SetRange("User Name", ReceiverSetup."User ID");
//         if ReceiverUser.FindFirst() then;
//         Recipients.Add(SenderUserSetup."E-Mail");
//         Clear(AmendmentHeader);
//         AmendmentHeader.SetRange("Amendment No.", ApprovalEntry."Document No.");
//         //AmendmentHeader.GET(ApprovalEntry."Document No.");
//         AmendmentHeader.FindFirst();

//         SalesHeader.GET(AmendmentHeader."Document No.");
//         RecCustomer.GET(SalesHeader."Sell-to Customer No.");
//         if RecCustomer.AltCustomerName <> '' then begin //added by bayas
//             CustomerShortName := RecCustomer.AltCustomerName;
//         end else begin
//             CustomerShortName := RecCustomer."Search Name";
//         end;

//         //Subject := StrSubstNo(SubjectLabel, AmendmentHeader."Document No.");
//         Subject := StrSubstNo(SubjectLabel, ShortName."Short Name", 'Document Amendment', AmendmentHeader."Document No.", CustomerShortName); //added by bayas
//         PageId := Page::"Amendment Request";
//         Body := CreateEmailBody(AmendmentHeader, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('is rejected by %1.', ReceiverUser."Full Name"));
//         EmailMessage.Create(Recipients, Subject, Body, true);
//         Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022
//     end;

//     local procedure AmendmentCancelledNotificationToSender(var ApprovalEntry: Record "Approval Entry")
//     var
//         EmailMessage: Codeunit "Email Message";
//         Email: Codeunit Email;
//         Recipients: List of [Text];
//         Subject: Text;
//         Body: Text;
//         SenderUserSetup: Record "User Setup";
//         ReceiverSetup: Record "User Setup";
//         SendUser: Record User;
//         ReceiverUser: Record User;
//         PageId: Integer;
//         AmendmentHeader: Record "Amendment Request";
//         //SubjectLabel: Label 'Document Amendment Request - Invoice No. %1';
//         SubjectLabel: Label 'ERP Approval Cancelled - %1 - %2 - %3 - %4'; //added by bayas   
//         ShortName: Record "Company Short Name";
//         CustomerShortName: Text;
//         RecCustomer: Record Customer;
//         SalesHeader: Record "Sales Invoice Header";
//     begin
//         Clear(CustomerShortName);
//         ShortName.GET(CompanyName);
//         if ApprovalEntry."Table ID" <> Database::"Amendment Request" then
//             exit;
//         if SenderUserSetup.Get(ApprovalEntry."Sender ID") then;
//         SendUser.Reset();
//         SendUser.SetRange("User Name", SenderUserSetup."User ID");
//         if SendUser.FindFirst() then;
//         if ReceiverSetup.Get(ApprovalEntry."Approver ID") then;
//         ReceiverUser.Reset();
//         ReceiverUser.SetRange("User Name", ReceiverSetup."User ID");
//         if ReceiverUser.FindFirst() then;
//         Recipients.Add(SenderUserSetup."E-Mail");
//         Clear(AmendmentHeader);
//         AmendmentHeader.SetRange("Amendment No.", ApprovalEntry."Document No.");
//         //AmendmentHeader.GET(ApprovalEntry."Document No.");
//         AmendmentHeader.FindFirst();

//         SalesHeader.GET(AmendmentHeader."Document No.");
//         RecCustomer.GET(SalesHeader."Sell-to Customer No.");
//         if RecCustomer.AltCustomerName <> '' then begin //added by bayas
//             CustomerShortName := RecCustomer.AltCustomerName;
//         end else begin
//             CustomerShortName := RecCustomer."Search Name";
//         end;

//         //Subject := StrSubstNo(SubjectLabel, AmendmentHeader."Document No.");
//         Subject := StrSubstNo(SubjectLabel, ShortName."Short Name", 'Document Amendment', AmendmentHeader."Document No.", CustomerShortName); //added by bayas
//         PageId := Page::"Amendment Request";
//         Body := CreateEmailBody(AmendmentHeader, ReceiverUser, SendUser, ApprovalEntry, 'SENDER', StrSubstNo('is cancelled by %1.', SendUser."Full Name"));
//         EmailMessage.Create(Recipients, Subject, Body, true);
//         Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022
//     end;

//     local procedure AmendmentCancelledNotificationToApprover(var ApprovalEntry: Record "Approval Entry")
//     var
//         EmailMessage: Codeunit "Email Message";
//         Email: Codeunit Email;
//         Recipients: List of [Text];
//         Subject: Text;
//         Body: Text;
//         SenderUserSetup: Record "User Setup";
//         ReceiverSetup: Record "User Setup";
//         SendUser: Record User;
//         ReceiverUser: Record User;
//         PageId: Integer;
//         AmendmentHeader: Record "Amendment Request";
//         //SubjectLabel: Label 'Document Amendment Request - Invoice No. %1';
//         SubjectLabel: Label 'ERP Approval Cancelled - %1 - %2 - %3 - %4'; //added by bayas   
//         ShortName: Record "Company Short Name";
//         CustomerShortName: Text;
//         RecCustomer: Record Customer;
//         SalesHeader: Record "Sales Invoice Header";
//     begin
//         Clear(CustomerShortName);
//         ShortName.GET(CompanyName);
//         if ApprovalEntry."Table ID" <> Database::"Amendment Request" then
//             exit;
//         if SenderUserSetup.Get(ApprovalEntry."Sender ID") then;
//         SendUser.Reset();
//         SendUser.SetRange("User Name", SenderUserSetup."User ID");
//         if SendUser.FindFirst() then;
//         if ReceiverSetup.Get(ApprovalEntry."Approver ID") then;
//         ReceiverUser.Reset();
//         ReceiverUser.SetRange("User Name", ReceiverSetup."User ID");
//         if ReceiverUser.FindFirst() then;
//         Recipients.Add(ReceiverSetup."E-Mail");
//         Clear(AmendmentHeader);
//         AmendmentHeader.SetRange("Amendment No.", ApprovalEntry."Document No.");
//         //AmendmentHeader.GET(ApprovalEntry."Document No.");
//         AmendmentHeader.FindFirst();

//         SalesHeader.GET(AmendmentHeader."Document No.");
//         RecCustomer.GET(SalesHeader."Sell-to Customer No.");
//         if RecCustomer.AltCustomerName <> '' then begin //added by bayas
//             CustomerShortName := RecCustomer.AltCustomerName;
//         end else begin
//             CustomerShortName := RecCustomer."Search Name";
//         end;

//         //Subject := StrSubstNo(SubjectLabel, AmendmentHeader."Document No.");
//         Subject := StrSubstNo(SubjectLabel, ShortName."Short Name", 'Document Amendment', AmendmentHeader."Document No.", CustomerShortName); //added by bayas
//         PageId := Page::"Amendment Request";
//         Body := CreateEmailBody(AmendmentHeader, ReceiverUser, SendUser, ApprovalEntry, 'APPROVER', StrSubstNo('is cancelled by %1', SendUser."Full Name"));
//         EmailMessage.Create(Recipients, Subject, Body, true);
//         Email.Enqueue(EmailMessage, Enum::"Email Scenario"::Default);//27-06-2022
//     end;


//     //27-06-2022- to stop standard notification
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeCreateApprovalEntryNotification', '', false, false)]
//     local procedure OnBeforeCreateApprovalEntryNotification(ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean);
//     var
//         SalesHeader: Record "Sales Header";
//     begin
//         if ApprovalEntry."Table ID" = Database::"Amendment Request" then
//             IsHandled := true;
//     end;

//     local procedure CreateEmailBody(Var AmendmentHdr: Record "Amendment Request"; Var Receiver: Record User; Var Sender: Record User; Var RecAppEntry: Record "Approval Entry"; ToUser: Code[10]; ActionText: Text): Text
//     var
//         BodyText: TextBuilder;
//         RecLines: Record "Amendment Request Line";
//         RecCustomer: Record Customer;
//         RecApprovalEntry: Record "Approval Entry";
//         PageId, J : Integer;
//         GLSetup: Record "General Ledger Setup";
//         RecPaymentTerms: Record "Payment Terms";
//         Recteams: Record Team;
//         RecteamSalesPerson: Record "Team Salesperson";
//         RecItem: Record Item;
//         TotalAmt, TotalQty, AvailableLimit, UsedLimit, OverDueHistory : Decimal;
//         RecCLE: record "Cust. Ledger Entry";
//         ShortName: Record "Company Short Name";
//         UnitPriceColor: Label 'style="color:%1"; font-weight: %2';
//         PaymentTermsText, ColorText : Text;
//         Utility: Codeunit Events;
//         UOMCheck: List of [Text];
//         RecLines2: Record "Sales Invoice Line";
//         TestText: Text;
//         SHeader: Record "Sales Invoice Header";
//         UserList: List of [Text];
//     begin
//         //'Hello %1,<br><br>You are registered to receive notifications related to ' + CompanyName.
//         //<br><br>This is a message to notify you that:<br><br>%2 %3 is cancelled by %4.
//         //<br>Customer %5 %6.<br>Order Status - %7.<br>Amount: %8<br><a href="%9">Open Document %10</a><br>
//         //<br>Date-Time Sent for Approval - %11.<br>Last Date-Time Modified - %12.<br>Last Modified by %13.
//         //<br>Approval Due Date - %14.<br>Approval Sent by %15'; 
//         // if SHeader."Document Type" = SHeader."Document Type"::Order then
//         // Utility.UpdateCreditLimitFields(SHeader);
//         ShortName.GET(CompanyName);
//         Clear(SHeader);
//         SHeader.GET(AmendmentHdr."Document No.");
//         Clear(RecCustomer);
//         RecCustomer.GET(SHeader."Sell-to Customer No.");
//         Clear(BodyText);
//         BodyText.Append('<style>table { border-collapse: collapse; border: 1px solid black;} table.a { table-layout: auto;  width: 560px; } table.b { table-layout: auto;  width: 560px; } table.c { table-layout: auto;  width: 670px; }table.d { table-layout: auto;  width: 320px; } </style>');
//         if ToUser = 'SENDER' then
//             BodyText.Append('Hello ' + Sender."User Name" + '<br><br>You are registered to receive notifications related to ' + CompanyName + '.')
//         else
//             BodyText.Append('Hello ' + Receiver."User Name" + '<br><br>You are registered to receive notifications related to ' + CompanyName + '.');


//         // if ActionText = 'cancelled' then
//         BodyText.Append('<br><br>This is a message to notify you that:');
//         BodyText.Append('<br><br>');
//         BodyText.Append(StrSubstNo('Amendment Request for Invoice No. %1 %2', FORMAT(AmendmentHdr."Document No."), ActionText));

//         BodyText.Append('<br><br>');
//         TestText := AmendmentHdr."Document No." + ' - ' + ShortName."Short Name";

//         BodyText.Append('<table class="a">');
//         BodyText.Append('<tr>');
//         BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Invoice No. </font></td>');
//         BodyText.Append('<td align="left"> <font> ' + TestText + '</font></td>');
//         BodyText.Append('</tr>');
//         BodyText.Append('<tr>');
//         BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Amendment No. </font></td>');
//         BodyText.Append('<td align="left"> <font> ' + AmendmentHdr."Amendment No." + '</font></td>');
//         BodyText.Append('</tr>');
//         BodyText.Append('<tr>');
//         BodyText.Append('<td align="left" Style="padding-left:5px"> <font style="color:Red";font-weight:normal> Amendment Type </font></td>');
//         BodyText.Append('<td align="left"> <font style="color:Red";font-weight:normal> ' + FORMAT(AmendmentHdr."Amendment Type") + '</font></td>');
//         BodyText.Append('</tr>');
//         BodyText.Append('<tr>');
//         BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Customer Name/No. </font></td>');
//         if RecCustomer.AltCustomerName <> '' then
//             BodyText.Append('<td align="left"> <font> <b>' + RecCustomer.AltCustomerName + ' - ' + SHeader."Sell-to Customer No." + '</b> </font></td>')
//         else
//             BodyText.Append('<td align="left"> <font> <b>' + RecCustomer."Search Name" + ' - ' + SHeader."Sell-to Customer No." + '</b> </font></td>');

//         BodyText.Append('</tr>');
//         BodyText.Append('<tr>');

//         BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Sales Amount: </font></td>');

//         GLSetup.GET;
//         SHeader.CalcFields("Amount Including VAT", "Salesperson Name");
//         if SHeader."Currency Factor" <> 0 then
//             BodyText.Append('<td align="left"> <font> <b>' + SHeader."Currency Code" + ' ' + FORMAT(SHeader."Amount Including VAT", 0, '<Precision,2:2><Standard Format,0>') + ' (' + GLSetup."LCY Code" + ' ' + FORMAT(SHeader."Amount Including VAT" / SHeader."Currency Factor", 0, '<Precision,2:2><Standard Format,0>') + ')</b> </font></td>')
//         else
//             BodyText.Append('<td align="left"> <font> <b>' + GLSetup."LCY Code" + ' ' + FORMAT(SHeader."Amount Including VAT", 0, '<Precision,2:2><Standard Format,0>') + '</b> </font></td>');

//         BodyText.Append('</tr>');

//         if SHeader."Payment Terms Code" <> '' then begin
//             RecPaymentTerms.GET(SHeader."Payment Terms Code");
//             BodyText.Append('<tr>');
//             BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Payment Terms/System: </font></td>');
//             PaymentTermsText := RecPaymentTerms.Code;

//             BodyText.Append('<td align="left"> <font> ' + PaymentTermsText + ' (' + RecCustomer."Payment Terms Code" + ') </font></td>');
//             BodyText.Append('</tr>');
//         end;

//         if SHeader."Salesperson Code" <> '' then begin
//             BodyText.Append('<tr>');
//             BodyText.Append('<td align="left" Style="padding-left:5px"> <font> Sales Person: </font></td>');
//             Clear(RecteamSalesPerson);
//             RecteamSalesPerson.SetRange("Salesperson Code", SHeader."Salesperson Code");
//             if RecteamSalesPerson.FindFirst() then begin
//                 Clear(Recteams);
//                 if Recteams.GET(RecteamSalesPerson."Team Code") then
//                     BodyText.Append('<td align="left" > <font> ' + SHeader."Salesperson Name" + ' / ' + Recteams.Name + ' </font></td>')
//                 else
//                     BodyText.Append('<td align="left"> <font> ' + SHeader."Salesperson Name" + ' </font></td>');
//             end else
//                 BodyText.Append('<td align="left"> <font> ' + SHeader."Salesperson Name" + ' </font></td>');
//             BodyText.Append('</tr>');
//         end;
//         BodyText.Append('</table>');
//         BodyText.Append('<br>');

//         Clear(RecLines);
//         RecLines.SetCurrentKey("Line No.");
//         RecLines.SetAscending("Line No.", true);
//         RecLines.SetRange("Amendment No.", AmendmentHdr."Amendment No.");
//         if RecLines.FindSet() then begin
//             BodyText.Append('<table class="b">');
//             Clear(TotalAmt);
//             Clear(TotalQty);
//             BodyText.Append('<tr>');
//             BodyText.Append('<td align="left" Style="width:180px;padding-left:5px;vertical-align:top;text-align:left"> <font> Field Name </font></td>');
//             BodyText.Append('<td align="left" Style="width:190px;vertical-align:top;text-align:left"> <font> Current Value </font></td>');
//             BodyText.Append('<td align="left" Style="width:190px;padding-right:5px;vertical-align:top;text-align:left"> <font> New value </font></td>');
//             //BodyText.Append('<td align="right" Style="width:110px"> <font> Amendment Type </font></td>');
//             //BodyText.Append('<td align="right" Style="width:130px"> <font> User Comment </font></td>');
//             BodyText.Append('</tr>');
//             repeat
//                 BodyText.Append('<tr>');
//                 BodyText.Append('<td align="left" Style="padding-left:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecLines."Field Name") + ' </font></td>');//, 0, '<Precision,2:2><Standard Format,0>'
//                 BodyText.Append('<td align="left" Style="padding-left:5px;vertical-align:top;text-align:left"> <font> ' + RecLines."Current Value" + ' </font></td>');
//                 BodyText.Append('<td align="left" Style="padding-right:5px;padding-left:5px;vertical-align:top;text-align:left"> <font> ' + RecLines."New Value" + ' </font></td>');
//                 //BodyText.Append('<td align="right"> <font> ' + FORMAT(RecLines."Amendment Type") + ' </font></td>');
//                 //BodyText.Append('<td align="right"> <font> ' + FORMAT(AmendmentHdr.GetAmendmentRemarks()) + ' </font></td>');
//                 BodyText.Append('</tr>');
//             until RecLines.Next() = 0;
//             BodyText.Append('</table>');
//             BodyText.Append('<br>');
//         end;


//         BodyText.Append('<table class="c">');
//         BodyText.Append('<tr>');
//         BodyText.Append('<td align="left" colspan="3" Style="padding-left:5px"> <font> Approval Process </font></td>');
//         BodyText.Append('</tr>');

//         /*Clear(UserList);
//         Clear(RecApprovalEntry);
//         RecApprovalEntry.SetCurrentKey("Sequence No.");
//         RecApprovalEntry.SetAscending("Sequence No.", true);
//         RecApprovalEntry.SetRange("Workflow Step Instance ID", RecAppEntry."Workflow Step Instance ID");
//         RecApprovalEntry.SetRange("Table ID", RecAppEntry."Table ID");
//         RecApprovalEntry.SetRange("Document Type", RecAppEntry."Document Type");
//         RecApprovalEntry.SetRange("Document No.", RecAppEntry."Document No.");
//         RecApprovalEntry.SetRange("Sequence No.", 1);
//         if RecApprovalEntry.FindFirst() then begin
//             UserList.Add(RecApprovalEntry."Sender ID");
//             BodyText.Append('<tr>');
//             BodyText.Append('<td align="left" Style="width:180px;padding-left:5px;vertical-align:top;text-align:left"> <font> ' + RecApprovalEntry."Sender ID" + ' (Creator) </font></td>');
//             BodyText.Append('<td align="left" Style="width:180px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry.SystemCreatedAt) + ' </font></td>');
//             BodyText.Append('<td align="left" Style="width:310px;padding-right:5px"> <font> ' + AmendmentHdr.GetAmendmentRemarks() + '</font></td>');
//             BodyText.Append('</tr>');
//         end;

//         Clear(RecApprovalEntry);
//         RecApprovalEntry.SetCurrentKey("Sequence No.");
//         RecApprovalEntry.SetAscending("Sequence No.", true);
//         RecApprovalEntry.SetRange("Workflow Step Instance ID", RecAppEntry."Workflow Step Instance ID");
//         RecApprovalEntry.SetRange("Table ID", RecAppEntry."Table ID");
//         RecApprovalEntry.SetRange("Document Type", RecAppEntry."Document Type");
//         RecApprovalEntry.SetRange("Document No.", RecAppEntry."Document No.");
//         RecApprovalEntry.SetRange(Status, RecApprovalEntry.Status::Approved);
//         RecApprovalEntry.SetFilter("Approver ID", '<>%1', RecAppEntry."Sender ID");
//         if RecApprovalEntry.FindSet() then begin
//             repeat
//                 if not UserList.Contains(RecApprovalEntry."Approver ID") then begin
//                     UserList.Add(RecApprovalEntry."Approver ID");
//                     BodyText.Append('<tr>');
//                     BodyText.Append('<td align="left" Style="width:180px;padding-left:5px;vertical-align:top;text-align:left"> <font> ' + RecApprovalEntry."Approver ID" + '</font></td>');
//                     BodyText.Append('<td align="left" Style="width:180px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry."Last Date-Time Modified") + '</font></td>');
//                     BodyText.Append('<td align="left" Style="width:310px;padding-right:5px"> <font> ' + Format(RecApprovalEntry."Approver Remarks") + ' </font></td>');
//                     BodyText.Append('</tr>');
//                 end;
//             until RecApprovalEntry.Next() = 0;
//         end;

//          if RecAppEntry."Sender ID" <> RecAppEntry."Approver ID" then begin
//              BodyText.Append('<tr>');
//              BodyText.Append('<td align="left" Style="width:180px;padding-left:5px;vertical-align:top;text-align:left"> <font> ' + RecAppEntry."Approver ID" + '</font></td>');
//              BodyText.Append('<td align="left" Style="width:180px;padding-right:5px;vertical-align:top;text-align:left"> <font> Pending Approval </font></td>');
//              BodyText.Append('<td align="left" Style="width:310px;padding-right:5px"> <font> ' + Format(RecAppEntry."Approver Remarks") + ' </font></td>');
//              BodyText.Append('</tr>');
//          end;


//         Clear(RecApprovalEntry);
//         RecApprovalEntry.SetCurrentKey("Sequence No.");
//         RecApprovalEntry.SetAscending("Sequence No.", true);
//         RecApprovalEntry.SetRange("Workflow Step Instance ID", RecAppEntry."Workflow Step Instance ID");
//         RecApprovalEntry.SetRange("Table ID", RecAppEntry."Table ID");
//         RecApprovalEntry.SetRange("Document Type", RecAppEntry."Document Type");
//         RecApprovalEntry.SetRange("Document No.", RecAppEntry."Document No.");
//         RecApprovalEntry.SetRange(Status, RecApprovalEntry.Status::Open);
//         //RecApprovalEntry.SetFilter("Approver ID", '<>%1', RecAppEntry."Approver ID");
//         if RecApprovalEntry.FindSet() then begin
//             repeat
//                 if not UserList.Contains(RecApprovalEntry."Approver ID") then begin
//                     UserList.Add(RecApprovalEntry."Approver ID");
//                     BodyText.Append('<tr>');
//                     BodyText.Append('<td align="left" Style="width:180px;padding-left:5px;vertical-align:top;text-align:left"> <font> ' + RecApprovalEntry."Approver ID" + '</font></td>');
//                     BodyText.Append('<td align="left" Style="width:180px;padding-right:5px;vertical-align:top;text-align:left"> <font> Pending Approval </font></td>');
//                     BodyText.Append('<td align="left" Style="width:310px;padding-right:5px"> <font> ' + Format(RecApprovalEntry."Approver Remarks") + ' </font></td>');
//                     BodyText.Append('</tr>');
//                 end;
//             until RecApprovalEntry.Next() = 0;
//         end;

//         Clear(RecApprovalEntry);
//         RecApprovalEntry.SetCurrentKey("Sequence No.");
//         RecApprovalEntry.SetAscending("Sequence No.", true);
//         RecApprovalEntry.SetRange("Workflow Step Instance ID", RecAppEntry."Workflow Step Instance ID");
//         RecApprovalEntry.SetRange("Table ID", RecAppEntry."Table ID");
//         RecApprovalEntry.SetRange("Document Type", RecAppEntry."Document Type");
//         RecApprovalEntry.SetRange("Document No.", RecAppEntry."Document No.");
//         RecApprovalEntry.SetRange(Status, RecApprovalEntry.Status::Created);
//         //RecApprovalEntry.SetFilter("Approver ID", '<>%1', RecAppEntry."Approver ID");
//         if RecApprovalEntry.FindSet() then begin
//             repeat
//                 if not UserList.Contains(RecApprovalEntry."Approver ID") then begin
//                     UserList.Add(RecApprovalEntry."Approver ID");
//                     BodyText.Append('<tr>');
//                     BodyText.Append('<td align="left" Style="width:180px;padding-left:5px;vertical-align:top;text-align:left"> <font>' + RecApprovalEntry."Approver ID" + '</font></td>');
//                     BodyText.Append('<td align="left" Style="width:180px;padding-right:5px;vertical-align:top;text-align:left"> <font> Open </font></td>');
//                     BodyText.Append('<td align="left" Style="width:310px;padding-right:5px"> <font> ' + Format(RecApprovalEntry."Approver Remarks") + ' </font></td>');
//                     BodyText.Append('</tr>');
//                 end;
//             until RecApprovalEntry.Next() = 0;
//         end;*/

//         Clear(RecApprovalEntry);
//         RecApprovalEntry.SetCurrentKey("Sequence No.");
//         RecApprovalEntry.SetAscending("Sequence No.", true);
//         RecApprovalEntry.SetRange("Workflow Step Instance ID", RecAppEntry."Workflow Step Instance ID");
//         RecApprovalEntry.SetRange("Table ID", RecAppEntry."Table ID");
//         RecApprovalEntry.SetRange("Document Type", RecAppEntry."Document Type");
//         RecApprovalEntry.SetRange("Document No.", RecAppEntry."Document No.");
//         //RecApprovalEntry.SetRange(Status, RecApprovalEntry.Status::Created);
//         //RecApprovalEntry.SetFilter("Approver ID", '<>%1', RecAppEntry."Approver ID");
//         if RecApprovalEntry.FindSet() then begin
//             repeat
//                 if RecApprovalEntry."Sequence No." = 1 then begin
//                     BodyText.Append('<tr>');
//                     BodyText.Append('<td align="left" Style="width:180px;padding-left:5px;vertical-align:top;text-align:left"> <font>' + RecApprovalEntry."Sender ID" + ' (Creator) </font></td>');
//                     BodyText.Append('<td align="left" Style="width:180px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry.SystemCreatedAt) + ' </font></td>');
//                     BodyText.Append('<td align="left" Style="width:310px;padding-right:5px"> <font> ' + AmendmentHdr.GetAmendmentRemarks() + ' </font></td>');
//                     BodyText.Append('</tr>');
//                 end;

//                 BodyText.Append('<tr>');
//                 BodyText.Append('<td align="left" Style="width:180px;padding-left:5px;vertical-align:top;text-align:left"> <font>' + RecApprovalEntry."Approver ID" + '</font></td>');


//                 if RecApprovalEntry.Status = RecApprovalEntry.Status::Approved then
//                     BodyText.Append('<td align="left" Style="width:180px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry."Last Date-Time Modified") + ' </font></td>')
//                 else
//                     if RecApprovalEntry.Status = RecApprovalEntry.Status::Open then
//                         BodyText.Append('<td align="left" Style="width:180px;padding-right:5px;vertical-align:top;text-align:left"> <font> Pending Approval </font></td>')
//                     else
//                         if RecApprovalEntry.Status = RecApprovalEntry.Status::Canceled then
//                             BodyText.Append('<td align="left" Style="width:180px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry."Last Date-Time Modified") + ' </font></td>')
//                         else
//                             if RecApprovalEntry.Status = RecApprovalEntry.Status::Created then
//                                 BodyText.Append('<td align="left" Style="width:180px;padding-right:5px;vertical-align:top;text-align:left"> <font>  Pending Approval  </font></td>')
//                             else
//                                 if RecApprovalEntry.Status = RecApprovalEntry.Status::Rejected then
//                                     BodyText.Append('<td align="left" Style="width:180px;padding-right:5px;vertical-align:top;text-align:left"> <font> ' + FORMAT(RecApprovalEntry."Last Date-Time Modified") + ' </font></td>');



//                 BodyText.Append('<td align="left" Style="width:310px;padding-right:5px"> <font> ' + Format(RecApprovalEntry."Approver Remarks") + ' </font></td>');
//                 BodyText.Append('</tr>');
//             until RecApprovalEntry.Next() = 0;
//         end;
//         BodyText.Append('</table>');

//         BodyText.Append('<br>');
//         PageId := Page::"Amendment Request";
//         BodyText.Append(StrSubstNo('<p> <a href="%1">Open document in Business Central</a> </p>', GetUrl(ClientType::Web, CompanyName, ObjectType::Page, PageId, AmendmentHdr, False)));

//         exit(BodyText.ToText());
//     end;
// }
