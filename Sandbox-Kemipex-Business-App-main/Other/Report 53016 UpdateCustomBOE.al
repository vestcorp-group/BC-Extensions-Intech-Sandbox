report 53016 UpdateCustomBOE  //T50890-Support Ticket-Anoop
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
                    if (ItemLedgerRec.CustomBOENumber = '') then begin //53497-N

                        //53497-OS
                        /* if (ItemLedgerRec."Entry Type" = ItemLedgerRec."Entry Type"::Output) and
                        (ItemLedgerRec."Remaining Quantity" = ItemLedgerRec.Quantity) then begin */
                        //53497-OE
                        ItemLedgerRec.CustomBOENumber := GetValueCell(RowNo, 2);
                        //Hypercare-21-02-2025
                        if (ItemLedgerRec."Lot No." <> (ItemLedgerRec.CustomLotNumber + '@' + ItemLedgerRec.CustomBOENumber)) and (ItemLedgerRec.CustomBOENumber > '') and (ItemLedgerRec.CustomLotNumber > '') THEN BEGIN
                            ItemLedgerRec."Lot No." := (ItemLedgerRec.CustomLotNumber + '@' + ItemLedgerRec.CustomBOENumber);
                        END;
                        ///Hypercare-21-02-2025
                        if GetValueCell(RowNo, 3) <> '' then
                            ItemLedgerRec."Supplier Batch No. 2" := GetValueCell(RowNo, 3);
                        ItemLedgerRec.Modify();
                    end;
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