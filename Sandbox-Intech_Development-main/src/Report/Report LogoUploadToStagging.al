report 85210 LogoInsert//T12370-Full Comment T13358-N
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = TableData "Staging Company Information" = rm;

    trigger OnPreReport()
    var
    begin

        Rec_ExcelBuffer.DeleteAll();
        RowNo := 0;
        ColomnNo := 0;
        DialogCaption := 'Select File To Upload';
        UploadResult := UploadIntoStream(DialogCaption, '', '', Name, NVinStream);
        Commit();
        if Name <> '' then
            SheetName := Rec_ExcelBuffer.SelectSheetsNameStream(NVinStream)
        else
            exit;
        if SheetName <> '' then begin
            Rec_ExcelBuffer.Reset();
            Rec_ExcelBuffer.OpenBookStream(NVinStream, SheetName);
            Rec_ExcelBuffer.ReadSheet();
            Commit();
            Rec_ExcelBuffer.Reset();
            Rec_ExcelBuffer.SetRange("Column No.", 1);
            if Rec_ExcelBuffer.FindFirst() then
                repeat
                    Rows += 1;
                until Rec_ExcelBuffer.Next() = 0;
            Rec_ExcelBuffer.Reset();
            Rec_ExcelBuffer.SetRange("Row No.", 1);
            if Rec_ExcelBuffer.FindFirst() then
                repeat
                    Colomns += 1;
                until Rec_ExcelBuffer.Next() = 0;
            for RowNo := 2 to Rows do begin
                if not StaggingCompanyRec.Get(GetValueCell(RowNo, 1)) then begin
                    StaggingCompanyRec.init;
                    StaggingCompanyRec.Code := GetValueCell(RowNo, 1);
                    TempBlob.CreateOutStream(OutStr);
                    LogoBase64 := GetValueCell(RowNo, 2);
                    LogoBase64 := DelChr(LogoBase64, '=', ' ');
                    LogoBase64 := LogoBase64.Replace('"', '');
                    LogoBase64 := LogoBase64.Replace('''', '');
                    LogoBase64 := LogoBase64.Replace('\', '');
                    LogoBase64 := LogoBase64.Replace('%', '');
                    Base64Convert.FromBase64(LogoBase64, OutStr);
                    TempBlob.CreateInStream(InStr);
                    RecRef.GetTable(StaggingCompanyRec);
                    SetLogoBlob(RecRef, 58030, InStr);
                    RecRef.SetTable(StaggingCompanyRec);
                    StaggingCompanyRec.Insert(True);
                end else begin
                    TempBlob.CreateOutStream(OutStr);
                    LogoBase64 := GetValueCell(RowNo, 2);
                    LogoBase64 := DelChr(LogoBase64, '=', ' ');
                    LogoBase64 := LogoBase64.Replace('"', '');
                    LogoBase64 := LogoBase64.Replace('''', '');
                    LogoBase64 := LogoBase64.Replace('\', '');
                    LogoBase64 := LogoBase64.Replace('%', '');
                    Base64Convert.FromBase64(LogoBase64, OutStr);
                    TempBlob.CreateInStream(InStr);
                    RecRef.GetTable(StaggingCompanyRec);
                    SetLogoBlob(RecRef, 58030, InStr);
                    RecRef.SetTable(StaggingCompanyRec);
                    StaggingCompanyRec.Modify();
                end;


            End;
        End;
    end;

    procedure SetLogoBlob(var RecRef: RecordRef; FieldNo: Integer; InStr: InStream)
    var
        FieldRef: FieldRef;
        OutStr: OutStream;
    begin
        TempBlob.CreateOutStream(OutStr);
        CopyStream(OutStr, InStr);
        FieldRef := RecRef.Field(FieldNo);
        TempBlob.CreateInStream(InStr);
        FieldRef := RecRef.Field(FieldNo);
        FieldRef.Value := InStr;

    end;

    procedure GetValueCell(RowNo: Integer; ColNo: Integer): Text
    Var
    Begin
        Rec_ExcelBuffer.Reset();
        if Rec_ExcelBuffer.get(RowNo, ColNo) then
            exit(Rec_ExcelBuffer."Cell Value as Text");
    End;





    var
        Rows: Integer;
        Colomns: Integer;
        RowNo: Integer;
        ColomnNo: Integer;
        FileUpload: Boolean;
        UploadResult: Boolean;
        uploadintoStram: InStream;
        FileName: Text;
        SheetName: Text;
        DialogCaption: Text;
        Name: Text;
        NVinStream: InStream;
        Rec_ExcelBuffer: Record "Excel Buffer";
        StaggingCompanyRec: Record "Staging Company Information";
        TxtDate: Text;
        LineNo: Integer;
        Filemgt: codeunit "File Management";
        ItemNo: Code[100];
        ImageBase64: text;
        Item: Record Item;
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        OutStr: OutStream;
        Base64Convert: Codeunit "Base64 Convert";
        RecRef: RecordRef;
        LogoBase64: Text;



}