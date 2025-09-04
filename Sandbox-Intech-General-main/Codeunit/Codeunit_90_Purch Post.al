codeunit 75380 Subscribe_Codeunit_90
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure Codeunit_90_OnBeforePostPurchaseDoc(var Sender: Codeunit "Purch.-Post"; var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; CommitIsSupressed: Boolean; var HideProgressWindow: Boolean)
    var
        OrderAdd_lRec: Record "Order Address";
        PL_lRec: Record "Purchase Line";

    begin
        //T32558-NS
        IF PurchaseHeader."Document Type" In [PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::Invoice] Then begin
            IF PurchaseHeader."Order Address Code" <> '' Then begin
                OrderAdd_lRec.GET(PurchaseHeader."Buy-from Vendor No.", PurchaseHeader."Order Address Code");
                OrderAdd_lRec.Testfield(State);

                PurchaseHeader.Testfield(State);
                PurchaseHeader.Testfield("GST Order Address State");

                PurchaseHeader.Testfield(State, OrderAdd_lRec.State);
                PurchaseHeader.Testfield("GST Order Address State", OrderAdd_lRec.State);
            end;

            if PurchaseHeader."GST Vendor Type" = PurchaseHeader."GST Vendor Type"::Registered then begin//21-03-2025
                PL_lRec.Reset();
                PL_lRec.Setrange("Document Type", PurchaseHeader."Document Type");
                PL_lRec.Setrange("Document No.", PurchaseHeader."No.");
                PL_lRec.SetFilter(Quantity, '<>%1', 0);
                IF PL_lRec.FindSet() then begin
                    repeat

                        IF PurchaseHeader.State = PurchaseHeader."Location State Code" then
                            PL_lRec.Testfield("GST Jurisdiction Type", PL_lRec."GST Jurisdiction Type"::Intrastate);

                        IF PurchaseHeader.State <> PurchaseHeader."Location State Code" then
                            PL_lRec.Testfield("GST Jurisdiction Type", PL_lRec."GST Jurisdiction Type"::Interstate);
                    until PL_lRec.NEXT = 0;
                end;
            end;
        end;
        //T32558-NE
    end;


    //ApprovedEmail-NS

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterManualReleasePurchaseDoc', '', false, false)]
    local procedure OnAfterManualReleasePurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean)
    var
        RecRef_lRef: RecordRef;
        ApprovalEntry_lRec: Record "Approval Entry";
    Begin
        ApprovalEntry_lRec.Reset();
        ApprovalEntry_lRec.SetCurrentkey("Entry No.");
        ApprovalEntry_lRec.SetRange("Table ID", 38);
        ApprovalEntry_lRec.SetRange("Document No.", PurchaseHeader."No.");
        if ApprovalEntry_lRec.FindLast() then begin
            UserName := ApprovalEntry_lRec."Approver ID";
            if ApprovalEntry_lRec.Status = ApprovalEntry_lRec.Status::Approved then
                SendMail(PurchaseHeader);
        end

    End;

    procedure SendMail(Rec: Record "Purchase Header")
    var
        Email: Codeunit Email;
        Recipients: List of [Text];
        Subject: Text;
        Body: Text;
        Recipients_lTxt: Text;
        LastChr_lTxt: Text;
        TmpRecipients_lTxt: Text;
        User: Record user;
    begin

        Clear(Recipients);
        User.Reset();
        User.SetRange("User Name", UserName);
        IF User.FindFirst() then
            Recipients_lTxt := DELCHR(User."Authentication Email", '<>', ' ');


        IF STRPOS(Recipients_lTxt, ';') <> 0 THEN BEGIN
            LastChr_lTxt := COPYSTR(Recipients_lTxt, STRLEN(Recipients_lTxt));
            IF LastChr_lTxt = ';' THEN
                Recipients_lTxt := COPYSTR(Recipients_lTxt, 1, STRPOS(Recipients_lTxt, ';') - 1);
        END;

        IF STRPOS(Recipients_lTxt, ',') <> 0 THEN BEGIN
            LastChr_lTxt := COPYSTR(Recipients_lTxt, STRLEN(Recipients_lTxt));
            IF LastChr_lTxt = ',' THEN
                Recipients_lTxt := COPYSTR(Recipients_lTxt, 1, STRPOS(Recipients_lTxt, ',') - 1);
        END;


        TmpRecipients_lTxt := DELCHR(Recipients_lTxt, '<>', ';');
        WHILE STRPOS(TmpRecipients_lTxt, ';') > 1 DO BEGIN
            Recipients.Add((COPYSTR(TmpRecipients_lTxt, 1, STRPOS(TmpRecipients_lTxt, ';') - 1)));
            TmpRecipients_lTxt := COPYSTR(TmpRecipients_lTxt, STRPOS(TmpRecipients_lTxt, ';') + 1);
        END;
        Recipients.Add(TmpRecipients_lTxt);

        Subject := 'Purchase Order - ' + Rec."No.";
        EmailMessage.Create(Recipients, Subject, Body, true);
        EmailMessage.AppendToBody('<br><br>');
        EmailMessage.AppendToBody('Please Check! ');
        if Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
            Message('email sent successfully');
    end;
    //ApprovedEmail-NE

    //T12240-NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterPurchRcptHeaderInsert, '', false, false)]
    local procedure "Purch.-Post_OnAfterPurchRcptHeaderInsert"(var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchaseHeader: Record "Purchase Header"; CommitIsSupressed: Boolean; PreviewMode: Boolean)
    begin
        PurchRcptHeader."LR/RR Date" := PurchaseHeader."LR/RR Date";
        PurchRcptHeader."LR/RR No." := PurchaseHeader."LR/RR No.";
        PurchRcptHeader."Shipping Agent Code" := PurchaseHeader."Shipping Agent Code";
    end;
    //T12240-NE


    var
        EmailMessage: Codeunit "Email Message";
        HTMLBodyText: Text;
        SentEmailCnt_gInt: Integer;
        UserName: Code[50];

}