//T36936-NS
Page 74988 "Vendor TDS Files Card"
{
    Caption = 'Vendor Form16 TDS Files Card';
    PageType = Card;
    SourceTable = "Vendor TDS File Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
            part("Lines"; "Vendor TDS Files Subform")
            {
                ApplicationArea = All;
                Caption = 'Lines';
                SubPageLink = "Document No." = field("No.");
            }
        }
        area(factboxes)

        {

            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(74983),
                              "No." = FIELD("No.");
            }

            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
            }

        }
    }
    actions
    {
        area(Processing)
        {
            group(Import)
            {
                action(ImportZipFile)
                {
                    Caption = 'Import Zip File (Attachment)';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Import;
                    ToolTip = 'Import Attachments from Zip';

                    trigger OnAction()
                    begin
                        ImportAttachmentsFromZip();
                    end;
                }
            }
            separator(Action140)
            {
            }
            group("Send Mail")
            {
                action(SendMail)
                {
                    Caption = 'Send E-Mail';
                    ApplicationArea = All;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = SendEmailPDF;
                    ToolTip = 'Send E-Mail with Attachments';

                    trigger OnAction()
                    var
                        SendVendorEmail_Report: Report "Send Vendor TDS File Email";
                    begin
                        clear(SendVendorEmail_Report);
                        Rec.SetRecFilter();
                        SendVendorEmail_Report.SetTableView(Rec);
                        SendVendorEmail_Report.Run();
                    end;
                }
            }

        }
    }

    local procedure ImportAttachmentsFromZip()
    var
        FileMgt: Codeunit "File Management";
        DataCompression: Codeunit "Data Compression";
        TempBlob: Codeunit "Temp Blob";
        EntryList: List of [Text];
        EntryListKey: Text;
        ZipFileName: Text;
        Window: Dialog;
        FileName: Text;
        FileExtension: Text;
        InStream: InStream;
        EntryOutStream: OutStream;
        EntryInStream: InStream;
        Length: Integer;
        SelectZIPFileMsg: Label 'Select ZIP File';
        FileCount: Integer;
        Cust: Record Customer;
        DocAttach: Record "Document Attachment";
        NoCustError: Label 'Customer %1 does not exist.';
        ImportedMsg: Label '%1 attachments Imported successfully.';
        Cnt_lInt: Integer;
        VendorTdsFilesLines_lRec: Record "Vendor TDS Files Lines";
        Vendor_lRec: Record Vendor;
    begin
        //Upload zip file
        if not UploadIntoStream(SelectZIPFileMsg, '', 'Zip Files|*.zip', ZipFileName, InStream) then
            Error('');

        //Extract zip file and store files to list type
        DataCompression.OpenZipArchive(InStream, false);
        DataCompression.GetEntryList(EntryList);

        FileCount := 0;
        Window.Open('#1##############################');
        //Loop files from the list type

        foreach EntryListKey in EntryList do begin
            Cnt_lInt += 1;
            Window.Update(1, Cnt_lInt);

            FileName := CopyStr(FileMgt.GetFileNameWithoutExtension(EntryListKey), 1, MaxStrLen(FileName));

            FileExtension := CopyStr(FileMgt.GetExtension(EntryListKey), 1, MaxStrLen(FileExtension));
            TempBlob.CreateOutStream(EntryOutStream);
            Length := DataCompression.ExtractEntry(EntryListKey, EntryOutStream);
            TempBlob.CreateInStream(EntryInStream);

            DocAttach.Init();
            DocAttach.Validate("Table ID", Database::"Vendor TDS File Header");
            DocAttach.Validate("No.", Rec."No.");
            DocAttach.Validate("File Name", FileName);
            DocAttach.Validate("Line No.", Cnt_lInt * 10000);
            DocAttach.Validate("File Extension", FileExtension);
            DocAttach."Document Reference ID".ImportStream(EntryInStream, FileName);
            DocAttach.Insert(true);

            VendorTdsFilesLines_lRec.Reset();
            VendorTdsFilesLines_lRec.Init();
            VendorTdsFilesLines_lRec."Document No." := Rec."No.";
            VendorTdsFilesLines_lRec."File Name" := FileName;
            Vendor_lRec.Reset();
            Vendor_lRec.SetRange("P.A.N. No.", CopyStr(FileName, 1, 10));
            if Vendor_lRec.FindFirst() then begin
                VendorTdsFilesLines_lRec."Vendor No." := Vendor_lRec."No.";
                VendorTdsFilesLines_lRec."Vendor Name" := Vendor_lRec.Name;
            end;
            VendorTdsFilesLines_lRec.Insert(true);

            FileCount += 1;

        end;
        //Close the zip file
        DataCompression.CloseZipArchive();
        Window.Close;

        if FileCount > 0 then
            Message(ImportedMsg, FileCount);
    end;
}
//T36936-NE
