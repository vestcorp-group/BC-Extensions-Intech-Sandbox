Table 74984 "Vendor TDS Files Lines"
{
    //VendorTDSFormEmail
    Caption = 'Vendor TDS Files Lines';
    DataClassification = ToBeClassified;
    Description = 'T36936';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
            TableRelation = "Vendor TDS File Header";
        }
        field(2; "File Name"; Text[100])
        {
            Caption = 'File Name';
            DataClassification = ToBeClassified;
        }
        field(30; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate()
            var
                Vendor_lRec: Record Vendor;
            begin
                Vendor_lRec.Reset();
                Vendor_lRec.GET("Vendor No.");
                "Vendor Name" := Vendor_lRec.Name;
            end;
        }
        field(40; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            DataClassification = ToBeClassified;
        }
        field(50; "Email Sent"; Boolean)
        {
            Caption = 'Email Sent';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Document No.", "File Name")
        {
            Clustered = true;
        }
    }
    procedure SendVendorTDSFile(var VendorTDSFilesLines: Record "Vendor TDS Files Lines")
    var
        TempBlob_lCud: Codeunit "Temp Blob";
        Rpt_OutStream: OutStream;
        Rpt_InStream: InStream;
        DocAtt_lRec: Record "Document Attachment";
        Subject: Text;
        Recipients: List of [Text];
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        //EmailTemp_lRec: Record "Email Template";
        EmailBody_lTxt: Text;
        P_PSetup_lRec: Record "Purchases & Payables Setup";
        Vendor_lRec: Record Vendor;
        BCC: List of [Text];
        CC: List of [Text];
        VendorTdsfilesLIne_lRec: Record "Vendor TDS Files Lines";
    begin
        P_PSetup_lRec.Reset();
        P_PSetup_lRec.GET();
        //P_PSetup_lRec.TestField("Vendor TDS Files Email Tmplt");

        //EmailTemp_lRec.Reset();
        //EmailTemp_lRec.GET(P_PSetup_lRec."Vendor TDS Files Email Tmplt");

        Vendor_lRec.Reset();
        Vendor_lRec.GET(VendorTDSFilesLines."Vendor No.");

        Subject := 'Vendor TDS File - ' + VendorTDSFilesLines."Vendor No.";
        //if EmailTemp_lRec."Email CC" <> '' then
        //  EmailTemp_lRec.GetListOfEmail_gFnc(EmailTemp_lRec."Email CC", cc);

        RecipientStringToList(Vendor_lRec."E-Mail", Recipients);

        //EmailTemp_lRec.TestField("Body 1");
        //EmailTemp_lRec.TestField("Body 2");

        EmailBody_lTxt := 'Dear  Sir/Madam';
        // EmailBody_lTxt += EmailTemp_lRec."Body 1";
        EmailBody_lTxt += '<BR/>';
        EmailBody_lTxt += '<BR/>';

        EmailBody_lTxt += 'PFA TDS Form';


        // EmailBody_lTxt += EmailTemp_lRec."Body 2";
        // EmailBody_lTxt += '<BR/>';

        // if EmailTemp_lRec."Body 3" <> '' then begin
        //     EmailBody_lTxt += EmailTemp_lRec."Body 3";
        //     EmailBody_lTxt += '<BR/><BR/><BR/>';
        // end;


        // if EmailTemp_lRec."Body 4" <> '' then begin
        //     EmailBody_lTxt += EmailTemp_lRec."Body 4";
        //     EmailBody_lTxt += '<BR/><BR/><BR/>';
        // end;

        // if EmailTemp_lRec."Body 5" <> '' then begin
        //     EmailBody_lTxt += EmailTemp_lRec."Body 5";
        //     EmailBody_lTxt += '<BR/>';
        // end;
        // if EmailTemp_lRec."Body 6" <> '' then begin
        //     EmailBody_lTxt += EmailTemp_lRec."Body 6";
        //     EmailBody_lTxt += '<BR/><BR/><BR/>';
        // end;

        // if EmailTemp_lRec."Body 7" <> '' then begin
        //     EmailBody_lTxt += EmailTemp_lRec."Body 7";
        //     EmailBody_lTxt += '<BR/>';
        // end;

        // if EmailTemp_lRec."Body 8" <> '' then begin
        //     EmailBody_lTxt += EmailTemp_lRec."Body 8";
        //     EmailBody_lTxt += '<BR/>';
        // end;

        EmailBody_lTxt += '<BR/>';

        EmailMessage.Create(Recipients, Subject, EmailBody_lTxt, true, CC, BCC);

        TempBlob_lCud.CreateOutStream(Rpt_OutStream);

        DocAtt_lRec.Reset();
        DocAtt_lRec.SetRange("Table ID", 74983);
        DocAtt_lRec.SetRange("No.", VendorTDSFilesLines."Document No.");
        DocAtt_lRec.SetRange("File Name", VendorTDSFilesLines."File Name");
        DocAtt_lRec.FindFirst();
        DocAtt_lRec."Document Reference ID".ExportStream(Rpt_OutStream);
        TempBlob_lCud.CreateInStream(Rpt_InStream);

        EmailMessage.AddAttachment(VendorTDSFilesLines."File Name" + '.pdf', 'PDF', Rpt_InStream);
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);


        VendorTdsfilesLIne_lRec.Reset();
        VendorTdsfilesLIne_lRec.GET(VendorTDSFilesLines."Document No.", VendorTDSFilesLines."File Name");
        VendorTdsfilesLIne_lRec."Email Sent" := true;
        VendorTdsfilesLIne_lRec.Modify();
    end;

    procedure RecipientStringToList(DelimitedRecipients: Text; var Recipients: List of [Text])
    var
        Seperators: Text;
    begin
        if DelimitedRecipients = '' then
            exit;

        Seperators := '; ,';
        Recipients := DelimitedRecipients.Split(Seperators.Split());
    end;

}
