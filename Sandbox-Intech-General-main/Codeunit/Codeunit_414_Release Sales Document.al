codeunit 75379 Subscribe_Codeunit_414_INT
{

    //ApprovedEmail-NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterManualReleaseSalesDoc', '', false, false)]
    local procedure OnAfterManualReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean)
    var
        RecRef_lRef: RecordRef;
        ApprovalEntry_lRec: Record "Approval Entry";
    Begin
        ApprovalEntry_lRec.Reset();
        ApprovalEntry_lRec.SetCurrentkey("Entry No.");
        ApprovalEntry_lRec.SetRange("Table ID", 36);
        ApprovalEntry_lRec.SetRange("Document No.", SalesHeader."No.");
        if ApprovalEntry_lRec.FindLast() then begin
            UserName := ApprovalEntry_lRec."Approver ID";
            if ApprovalEntry_lRec.Status = ApprovalEntry_lRec.Status::Approved then
                SendMail(SalesHeader);
        end
    End;

    procedure SendMail(Rec: Record "Sales Header")
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

        Subject := 'Sales Order - ' + Rec."No.";
        EmailMessage.Create(Recipients, Subject, Body, true);
        EmailMessage.AppendToBody('<br><br>');
        EmailMessage.AppendToBody('Please Check! ');
        if Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
            Message('email sent successfully');
    end;
    //ApprovedEmail-NE

    var
        EmailMessage: Codeunit "Email Message";
        HTMLBodyText: Text;
        SentEmailCnt_gInt: Integer;
        UserName: Code[50];
}