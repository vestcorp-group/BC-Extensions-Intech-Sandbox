report 58134 UpdateManufacturingdate//T12370-Full Comment T13358-N
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = TableData "Item Ledger Entry" = rm;

    trigger OnPreReport()
    var
    begin
        Rec_ExcelBuffer.DeleteAll();
        RowNo := 0;
        ColomnNo := 0;
        DialogCaption := 'Select File To Upload';
        UploadResult := UploadIntoStream(DialogCaption, '', '', Name, NVinStream);
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
                if ItemLedgerRec.Get(GetValueCell(RowNo, 1)) then begin
                    Evaluate(ItemLedgerRec."Manufacturing Date 2", GetValueCell(RowNo, 2));
                    Evaluate(ItemLedgerRec."Expiry Period 2", GetValueCell(RowNo, 3));
                    ItemLedgerRec."Expiration Date" := CalcDate(ItemLedgerRec."Expiry Period 2", ItemLedgerRec."Manufacturing Date 2");
                    ItemLedgerRec.Modify();
                end;
            End;
        End;
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
        ItemLedgerRec: Record "Item Ledger Entry";
        TxtDate: Text;
        LineNo: Integer;
        Filemgt: codeunit "File Management";
}