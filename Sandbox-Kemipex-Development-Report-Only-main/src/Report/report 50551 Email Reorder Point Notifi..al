report 50551 "Email Reorder Point Notifi."
{
    //T12067
    Caption = 'Email Reorder Point Notifi.';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem(Item; Item)
        {
            trigger OnAfterGetRecord()
            begin
                Curr_gInt += 1;
                Window_gDlg.Update(2, Curr_gInt);
            end;

            trigger OnPostDataItem()
            begin
                Window_gDlg.Close();
                SendMail_gFnc();
                // Message('%1 - Email Send', Send_gInt);
            end;

            trigger OnPreDataItem()
            begin
                if TestEmail_gBln then begin
                    if TestEmailID_gTxt = '' then
                        Error('Enter the Test Email ID');
                end;

                // if GetFilter("Date Filter") = '' then
                //     Error('Please apply date filter');

                Window_gDlg.Open(Text000 + Text001 + Text002 + Text003);
                //03-05-2024
                // EmailTemplateSetup_gRec.Get();
                // EmailTemplateSetup_gRec.TestField("Custmer Ledger Email Email");

                // EmailTemplate_gRec.Get(EmailTemplateSetup_gRec."Custmer Ledger Email Email");
                // EmailTemplate_gRec.TestField(Subject);

                Window_gDlg.Update(1, Count);
                Total_gInt := Count;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group("****** Email Testing *****")
                {
                    Caption = '****** Email Testing *****';
                    field("Test Email"; TestEmail_gBln)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Test Email';
                        ToolTip = 'Specifies the value of the Test Email field.';

                        trigger OnValidate()
                        begin
                            if not TestEmail_gBln then
                                TestEmailID_gTxt := '';
                        end;
                    }
                    field("Test Email ID"; TestEmailID_gTxt)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Test Email ID';
                        Editable = TestEmail_gBln;
                        ExtendedDatatype = EMail;
                        ToolTip = 'Specifies the value of the Test Email ID field.';

                        trigger OnValidate()
                        var
                            ChkEmailAddress_lCdu: Codeunit "Email Account";
                        begin
                            if TestEmailID_gTxt <> '' then begin
                                Clear(ChkEmailAddress_lCdu);
                                ChkEmailAddress_lCdu.ValidateEmailAddresses(TestEmailID_gTxt);
                            end;
                        end;
                    }

                    field(EmailBody; EmailBody_GTxt)
                    {
                        ApplicationArea = All;
                        Caption = 'Body';
                        MultiLine = true;
                        ExtendedDatatype = RichContent;
                    }
                }
            }
        }

        actions
        {
        }


        trigger OnOpenPage()
        var
            myInt: Integer;
        begin
            Clear(EmailBody_GTxt);
            EmailTemplateSetup_gRec.Get();
            EmailTemplateSetup_gRec.TestField("Email Template");

            EmailTemplate_gRec.Get(EmailTemplateSetup_gRec."Email Template");
            EmailTemplate_gRec.TestField(Subject);

            if EmailTemplate_gRec."Body 1" <> '' then
                EmailBody_gTxt += EmailTemplate_gRec."Body 1";

            if EmailTemplate_gRec."Body 2" <> '' then
                EmailBody_gTxt += EmailTemplate_gRec."Body 2";

            if EmailTemplate_gRec."Body 3" <> '' then
                EmailBody_gTxt += EmailTemplate_gRec."Body 3";

            if EmailTemplate_gRec."Body 4" <> '' then
                EmailBody_gTxt += EmailTemplate_gRec."Body 4";

            if EmailTemplate_gRec."Body 5" <> '' then
                EmailBody_gTxt += EmailTemplate_gRec."Body 5";

            if EmailTemplate_gRec."Body 6" <> '' then
                EmailBody_gTxt += EmailTemplate_gRec."Body 6";

            if EmailTemplate_gRec."Body 7" <> '' then
                EmailBody_gTxt += EmailTemplate_gRec."Body 7";

            if EmailTemplate_gRec."Body 8" <> '' then
                EmailBody_gTxt += EmailTemplate_gRec."Body 8";
        end;
    }

    labels
    {
        CurrReport_PAGENOCaptionLbl = 'Page';
        Fax_No_CaptionLbl = 'Fax No.';
        Phone_no_CaptionLbl = 'Phone no.';
        Item_Statment__FLMF_CaptionLbl = 'Item Statment';
        PostingDate_CaptionLbl = 'Posting Date';
        DocumentDate_CaptionLbl = 'Document Date';
        DocumentType_CaptionLbl = 'Document Type';
        InvCNType_Lbl = 'Invoice/CN Type';
        DocumentNo_CaptionLbl = 'Document No.';
        ChequeNo_CaptionLbl = 'Cheque No.';
        ChequeDate_CaptionLbl = 'Cheque Date';
        DebitAmt_CaptionLbl = 'Debit Amount';
        CreditAmt_CaptionLbl = 'Credit Amount';
        RunningBal_CaptionLbl = 'Running Balance';
        CFormNoStatus_CaptionLbl = 'CForm No./ Status Remarks';
        OpeningBal_Lbl = 'Opening Balance . . . . . .';
        ClosingBalance_Lbl = 'Closing Balance';
    }

    var
        EmailTemplate_gRec: Record "Email Template";
        EmailTemplateSetup_gRec: Record "Purchases & Payables Setup";
        TestEmail_gBln: Boolean;
        Window_gDlg: Dialog;
        Curr_gInt: Integer;
        Send_gInt: Integer;
        Total_gInt: Integer;
        Text000: label 'Sending Sales Item Statement Email.....\';
        Text001: label 'Total Recerd #1###################\';
        Text002: label 'Curr Record #2####################\';
        Text003: label 'Skip #3#####################';
        Text029_gTxt: label 'Regards,';
        Text030_gTxt: label '%1 - System Auto E-Mail';
        TestEmailID_gTxt: Text;
        EmailBody_GTxt: Text;
        ReadText_gTxt: Text;

    procedure SendMail_gFnc()
    var
        // ItemLedgEnt_lRec: Record "Cust. Ledger Entry";
        Item_lRec: Record Item;
        SP_lRec: Record "Salesperson/Purchaser";
        Rpt_ReoderNotifiction: Report "Reorder Point Notification";
        Email: Codeunit Email;
        ChkEmailAddress_lCdu: Codeunit "Email Account";
        EmailMessage: Codeunit "Email Message";
        receipent: List of [Text];
        BCC: List of [Text];
        CC: List of [Text];
        EmailBody_lTxt: Text;
        ModBody_lTxt: Text;
        RecRef_Confirmation: RecordRef;
        TempBlob_Confirmation: Codeunit "Temp Blob";
        OStream_Confirmation: OutStream;
        IStream_Confirmation: InStream;
        PDF_Confirmation: Text;
        Subject_lTxt: Text;
        EmailTo_lTxt: Text;
        LF: Char;
    begin
        LF := 10;
        PDF_Confirmation := 'Item Ledger - ' + Item."No." + ' ' + Item.Description + '.pdf';

        // if not TestEmail_gBln then begin
        //     Item_lRec.Get(Item."No.");
        //     if Item_lRec."E-Mail" = '' then
        //         CurrReport.Skip();

        //     Clear(ChkEmailAddress_lCdu);
        //     ChkEmailAddress_lCdu.ValidateEmailAddresses(Item_lRec."E-Mail");
        //     EmailTo_lTxt := Item_lRec."E-Mail"
        // end else
        //     EmailTo_lTxt := TestEmailID_gTxt;
        if TestEmail_gBln then
            EmailTo_lTxt := TestEmailID_gTxt;


        // Clear(Item_lRec);
        // Item_lRec.Reset();
        // Item_lRec.SetRange("No.", Item."No.");
        // Item_lRec.FindFirst();
        // Item_lRec.CalcFields(Balance);
        // IF Round(Item_lRec.Balance, 1, '<') = 0 then
        //     CurrReport.Skip();


        RecRef_Confirmation.GetTable(Item_lRec);
        TempBlob_Confirmation.CreateOutStream(OStream_Confirmation);

        Clear(Rpt_ReoderNotifiction);
        Clear(ReadText_gTxt);
        Rpt_ReoderNotifiction.SetTableview(Item_lRec);
        Rpt_ReoderNotifiction.SaveAs('', ReportFormat::Pdf, OStream_Confirmation, RecRef_Confirmation);
        TempBlob_Confirmation.CreateInStream(IStream_Confirmation);



        //Sales Credit Reject - %1
        Subject_lTxt := StrSubstNo(EmailTemplate_gRec.Subject, Item."No.", Item.Description);

        if TestEmail_gBln then begin
            GetListOfEmail_gFnc(EmailTo_lTxt, receipent);
            If EmailBody_GTxt <> '' then
                ModBody_lTxt := EmailBody_gTxt.Replace(LF, '<BR/>');

            EmailBody_lTxt += ModBody_lTxt;
            EmailBody_lTxt += '<BR/>';
        end else begin
            GetListOfEmail_gFnc(EmailTemplate_gRec."Email To", receipent);
            //  IF NOT TestEmail_gBln Then begin
            GetListOfEmail_gFnc(EmailTemplate_gRec."Email CC", CC);
            GetListOfEmail_gFnc(EmailTemplate_gRec."Email BCC", BCC);
            //  End;

            EmailTemplate_gRec.TestField("Body 1");
            EmailTemplate_gRec.TestField("Body 2");

            //Your sales order (%1) for Item (%2 & %3) is rejected for %4 by %5
            ModBody_lTxt := StrSubstNo(EmailTemplate_gRec."Body 1", Item_lRec."No.", Item.Description);
            EmailBody_lTxt += ModBody_lTxt;
            EmailBody_lTxt += '<BR/>';

            if EmailTemplate_gRec."Body 2" <> '' then begin
                EmailBody_lTxt += EmailTemplate_gRec."Body 2";
                EmailBody_lTxt += '<BR/>';
            end;

            if EmailTemplate_gRec."Body 3" <> '' then begin
                EmailBody_lTxt += EmailTemplate_gRec."Body 3";
                EmailBody_lTxt += '<BR/>';
            end;

            if EmailTemplate_gRec."Body 4" <> '' then begin
                EmailBody_lTxt += EmailTemplate_gRec."Body 4";
                EmailBody_lTxt += '<BR/>';
            end;

            if EmailTemplate_gRec."Body 5" <> '' then begin
                EmailBody_lTxt += EmailTemplate_gRec."Body 5";
                EmailBody_lTxt += '<BR/>';
            end;

            if EmailTemplate_gRec."Body 6" <> '' then begin
                EmailBody_lTxt += EmailTemplate_gRec."Body 6";
                EmailBody_lTxt += '<BR/>';
            end;

            if EmailTemplate_gRec."Body 7" <> '' then begin
                EmailBody_lTxt += EmailTemplate_gRec."Body 7";
                EmailBody_lTxt += '<BR/>';
            end;

            if EmailTemplate_gRec."Body 8" <> '' then begin
                EmailBody_lTxt += EmailTemplate_gRec."Body 8";
                EmailBody_lTxt += '<BR/>';
            end;

            EmailBody_lTxt += '<BR/>';
        end;


        EmailMessage.Create(receipent, Subject_lTxt, EmailBody_lTxt, true, CC, BCC);
        if TempBlob_Confirmation.HasValue() then
            EmailMessage.AddAttachment(PDF_Confirmation, 'PDF', IStream_Confirmation);
        if Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
            Message('Email Sent Successfully..');


    end;

    procedure GetListOfEmail_gFnc(EmailText_iTxt: Text; Var EmailListVar: List of [Text])
    var
        LastChr: Text;
        TmpRecipients: Text;
    begin
        IF EmailText_iTxt = '' then
            Exit;

        IF STRPOS(EmailText_iTxt, ';') <> 0 THEN BEGIN  //System doesn't work if the email address end with semi colon  /ex: xyz@abc.com;
            LastChr := COPYSTR(EmailText_iTxt, STRLEN(EmailText_iTxt));
            IF LastChr = ';' THEN
                EmailText_iTxt := COPYSTR(EmailText_iTxt, 1, STRPOS(EmailText_iTxt, ';') - 1);
        END;

        IF STRPOS(EmailText_iTxt, ',') <> 0 THEN BEGIN  //System doesn't work if the email address end with Comma  /ex: xyz@abc.com,
            LastChr := COPYSTR(EmailText_iTxt, STRLEN(EmailText_iTxt));
            IF LastChr = ',' THEN
                EmailText_iTxt := COPYSTR(EmailText_iTxt, 1, STRPOS(EmailText_iTxt, ',') - 1);
        END;

        TmpRecipients := DELCHR(EmailText_iTxt, '<>', ';');
        WHILE STRPOS(TmpRecipients, ';') > 1 DO BEGIN
            EmailListVar.Add((COPYSTR(TmpRecipients, 1, STRPOS(TmpRecipients, ';') - 1)));
            TmpRecipients := COPYSTR(TmpRecipients, STRPOS(TmpRecipients, ';') + 1);
        END;
        EmailListVar.Add(TmpRecipients);
    end;
}


