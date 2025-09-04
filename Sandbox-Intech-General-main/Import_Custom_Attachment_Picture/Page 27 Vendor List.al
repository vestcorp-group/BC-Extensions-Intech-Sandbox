pageextension 74983 Vendor_List_74983 extends "Vendor List"
{
    actions
    {
        addafter("Sent Emails")
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
            action(ImportPictureFile)
            {
                Caption = 'Import Zip File (Picture)';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Import;
                ToolTip = 'Import Picture from Zip';

                trigger OnAction()
                begin
                    LoadZIPPictureFile();
                end;
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
        Vend: Record Vendor;
        DocAttach: Record "Document Attachment";
        NoCustError: Label 'Customer %1 does not exist.';
        ImportedMsg: Label '%1 attachments Imported successfully.';
        Cnt_lInt: Integer;
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

            //Import each file where you want
            if not Vend.Get(FileName) then
                Error(NoCustError, FileName);

            DocAttach.Init();
            DocAttach.Validate("Table ID", Database::item);
            DocAttach.Validate("No.", FileName);
            DocAttach.Validate("File Name", FileName);
            DocAttach.Validate("File Extension", FileExtension);
            DocAttach."Document Reference ID".ImportStream(EntryInStream, FileName);
            DocAttach.Insert(true);
            FileCount += 1;
        end;

        //Close the zip file
        DataCompression.CloseZipArchive();
        Window.Close;

        if FileCount > 0 then
            Message(ImportedMsg, FileCount);
    end;

    procedure LoadZIPPictureFile(): Text
    var
        FileMgt: Codeunit "File Management";
        DataCompression: Codeunit "Data Compression";
        TempBlob: Codeunit "Temp Blob";
        Window: Dialog;
        EntryList: List of [Text];
        EntryListKey: Text;
        InStream: InStream;
        EntryOutStream: OutStream;
        EntryInStream: InStream;
        Length: Integer;
        FileName: Text;
        FileExtension: Text;
        Vend: Record Vendor;
        NoCustError: Label 'Customer %1 does not exist.';
        ImportedMsg: Label '%1 attachments Imported successfully.';
        ZipFileName: Text;
        Cnt_lInt: Integer;
    begin
        if not UploadIntoStream(SelectZIPFileMsg, '', 'Zip Files|*.zip', ZipFileName, InStream) then
            Error('');

        DataCompression.OpenZipArchive(InStream, false);
        DataCompression.GetEntryList(EntryList);

        Window.Open('#1##############################');

        foreach EntryListKey in EntryList do begin
            Cnt_lInt += 1;
            Window.Update(1, Cnt_lInt);

            FileName := CopyStr(FileMgt.GetFileNameWithoutExtension(EntryListKey), 1, MaxStrLen(FileName));
            FileExtension := CopyStr(FileMgt.GetExtension(EntryListKey), 1, MaxStrLen(FileExtension));
            TempBlob.CreateOutStream(EntryOutStream);
            Length := DataCompression.ExtractEntry(EntryListKey, EntryOutStream);
            TempBlob.CreateInStream(EntryInStream);

            //Import each file where you want
            if not Vend.Get(FileName) then
                Error(NoCustError, FileName);

            Vend.Image.ImportStream(EntryInStream, FileMgt.GetFileName(EntryListKey));
            Vend.Modify();
        end;

        DataCompression.CloseZipArchive;
        Window.Close;

        exit(ZipFileName);
    end;

    var
        SelectZIPFileMsg: Label 'Select ZIP File';

}