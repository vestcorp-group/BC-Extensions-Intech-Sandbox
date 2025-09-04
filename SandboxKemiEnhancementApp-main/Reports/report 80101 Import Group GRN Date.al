report 80101 "Import Group GRN Date"//T12370-Full Comment T12946-Code Uncommented
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = tabledata "Item Ledger Entry" = rm;

    dataset
    {
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
                }
            }
        }

    }
    trigger OnInitReport()
    var
    Begin

    End;

    trigger OnPreReport()
    var
    Begin
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
                    Evaluate(ItemLedgerRec."Group GRN Date", GetValueCell(RowNo, 2));
                    ItemLedgerRec.Modify();
                end;
                // ItemLedgerRec.SetRange("Document No.", GetValueCell(RowNo, 1));
                // if ItemLedgerRec.FindSet() then
                //     repeat
                //     begin
                //         Evaluate(ItemLedgerRec."Group GRN Date", GetValueCell(RowNo, 2));
                //         ItemLedgerRec.Modify();
                //     end;
                //     until ItemLedgerRec.Next() = 0;
            End;
        End;
    end;

    trigger OnPostReport()
    Begin

    End;

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