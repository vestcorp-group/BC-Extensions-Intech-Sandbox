codeunit 50369 WarehouseInstructionMail//T12370-Full Comment
{
    trigger OnRun()
    begin

    end;

    procedure SendWDIMail(var WDIHeader: Record "Warehouse Delivery Inst Header"; CCAddress: text)
    var
        //SMTP: Codeunit "SMTP Mail";//30-04-2022
        InS: InStream;
        OutS: OutStream;
        AttInS: InStream;
        AttOutS: OutStream;
        tempBlob: Codeunit "Temp Blob";
        AttTempBlob: Codeunit "Temp Blob";
        Body: Text;
        recipient: List of [Text];
        RecRef: RecordRef;
        FRef: FieldRef;
        FRef2: FieldRef;
        WarehouseInstuctionSetup: Record "Warehouse Instruction Setup";
        CCmailaddress: list of [Text];
        //SMTPSetup: Record "SMTP Mail Setup";//30-04-2022
        //30-04-2022
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        BCCmailaddress: list of [Text];
    begin
        WarehouseInstuctionSetup.Get();
        //SMTPSetup.Get();//30-04-2022
        CCmailaddress.Add(CCAddress);
        AttTempBlob.CreateOutStream(AttOutS);
        tempBlob.CreateOutStream(OutS);
        RecRef.Open(Database::"Warehouse Delivery Inst Header");
        FRef := RecRef.Field(1);
        FRef.SetRange(WDIHeader."WDI No");
        Report.SaveAs(58360, '', ReportFormat::Pdf, AttOutS, RecRef);
        Report.SaveAs(58370, '', ReportFormat::Html, OutS, RecRef);
        AttTempBlob.CreateInStream(AttInS);
        tempBlob.CreateInStream(InS);
        InS.ReadText(Body);
        recipient.Add(WDIHeader."Location E-Mail Address");

        // 30-04-2022-commented below as SMTP has been removed
        //SMTP.CreateMessage(UserId, SMTPSetup."User ID", recipient, 'WDI No. ' + WDIHeader."WDI No" + ' for ' + WDIHeader."Order No.", Body, true);
        // SMTP.AddAttachmentStream(AttInS,WDIHeader."WDI No" + '.PDF');
        // SMTP.AddCC(CCmailaddress);
        // SMTP.Send()
        //30-04-2022-start
        EmailMessage.Create(recipient, 'WDI No. ' + WDIHeader."WDI No" + ' for ' + WDIHeader."Order No.", Body, true, CCmailaddress, BCCmailaddress);
        EmailMessage.AddAttachment(WDIHeader."WDI No" + '.PDF', 'application/pdf', AttInS);
        Email.Send(EmailMessage);
        //30-04-2022-end
    end;






    // procedure SendWDIMail(var WDIHeader: Record "Warehouse Delivery Inst Header"; CCAddress: text)
    // var
    //     SMTP: Codeunit "SMTP Mail";
    //     InS: InStream;
    //     OutS: OutStream;
    //     AttInS: InStream;
    //     AttOutS: OutStream;
    //     tempBlob: Codeunit "Temp Blob";
    //     AttTempBlob: Codeunit "Temp Blob";
    //     Body: Text;
    //     // recipient: List of [Text];
    //     recipient: Text;
    //     RecRef: RecordRef;
    //     FRef: FieldRef;
    //     FRef2: FieldRef;
    //     WarehouseInstuctionSetup: Record "Warehouse Instruction Setup";
    //     CCmailaddress: list of [Text];
    //     SMTPSetup: Record "SMTP Mail Setup";

    //     EmailAccounts: Record "Email Account";
    //     EmailMessage: Codeunit "Email Message";
    //     Base64Convert: Codeunit "Base64 Convert";
    //     Email: Codeunit Email;

    // begin
    //     WarehouseInstuctionSetup.Get();
    //     SMTPSetup.Get();
    //     CCmailaddress.Add(CCAddress);
    //     AttTempBlob.CreateOutStream(AttOutS);
    //     tempBlob.CreateOutStream(OutS);
    //     RecRef.Open(Database::"Warehouse Delivery Inst Header");
    //     FRef := RecRef.Field(1);
    //     FRef.SetRange(WDIHeader."WDI No");
    //     Report.SaveAs(58360, '', ReportFormat::Pdf, AttOutS, RecRef);
    //     Report.SaveAs(58370, '', ReportFormat::Html, OutS, RecRef);
    //     AttTempBlob.CreateInStream(AttInS);
    //     tempBlob.CreateInStream(InS);
    //     InS.ReadText(Body);
    //     // recipient.Add(WDIHeader."Location E-Mail Address");
    //     //SMTP.CreateMessage(UserId, SMTPSetup."User ID", recipient, 'WDI No. ' + WDIHeader."WDI No" + ' for ' + WDIHeader."Order No.", Body, true);
    //     // SMTP.AddAttachmentStream(AttInS, WDIHeader."WDI No" + '.PDF');
    //     // SMTP.AddCC(CCmailaddress);
    //     // SMTP.Send();

    //     recipient := WDIHeader."Location E-Mail Address";
    //     EmailMessage.Create(recipient, 'WDI No. ' + WDIHeader."WDI No" + ' for ' + WDIHeader."Order No.", Body);
    //     EmailMessage.AddAttachment(WDIHeader."WDI No" + '.PDF', 'WDI/PDF', Base64Convert.ToBase64(AttInS));
    //     EmailMessage.IsBodyHTMLFormatted();
    //     Email.Send(EmailMessage);
    // end;
}
