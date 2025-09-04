report 50207 KMP_UpdateCustomLotNo//T12370-Full Comment  //Hypercare T13358-N
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Update Custom Lot / BOE No.';
    Permissions = tabledata "Item Ledger Entry" = rm;
    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetCurrentKey("Entry No.");
                if (StartDateG > 0D) and (EndDateG > 0D) then
                    SetRange("Posting Date", StartDateG, EndDateG);
                FindFirst();
            end;

            trigger OnAfterGetRecord()
            var
                PurchaseHeaderL: Record "Purchase Header";
            begin
                if CustomLotNumber = '' then
                    CustomLotNumber := "Lot No.";


                if (CustomBOENumber = '') and (StrLen("Supplier Batch No. 2") <= 20) then
                    CustomBOENumber := PurchaseHeaderL.FormatText("Supplier Batch No. 2");
                Modify();
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Filters")
                {
                    field("From Date"; StartDateG)
                    {
                        ApplicationArea = all;
                    }
                    field("To Date"; EndDateG)
                    {
                        ApplicationArea = all;
                    }
                    field("Import from Excel"; ExcelImportG)
                    {
                        ApplicationArea = all;
                        trigger OnValidate()
                        var
                            myInt: Integer;
                        begin
                            if ExcelImportG then
                                ImportFromExcel();
                            Message('%1 Records updated successfully', RecordCountG);
                            CurrReport.RequestOptionsPage.Close();
                        end;
                    }
                }

            }
        }
    }
    local procedure ImportFromExcel()
    var
        ExcelBuffer: Record "Excel Buffer";
        ExcelBuffer2: Record "Excel Buffer";
        FileMgt: Codeunit "File Management";
        FileName: Text;
        InStreamL: InStream;
        RowCountL: Integer;
        EntryNoL: Integer;
        SupplierBatchNoL: Text[100];
        CustomLotNoL: Code[50];
        CustomBOENoL: Text[20];
        FileExtensionFilterTok: Label 'Excel Files (*.xlsx)|*.xlsx|All Files (*.*)|*.*';
        ExcelFileNameTok: Label '*%1.xlsx';
        ExcelFileExtensionTok: Label '.xlsx';
        ItemLedgerEntryL: Record "Item Ledger Entry";
    begin
        ExcelBuffer.LockTable();
        ExcelBuffer.DeleteAll();
        if not UPLOADINTOSTREAM('Select Excel File', '', FileExtensionFilterTok, FileName, InStreamL) then
            exit;
        ExcelBuffer.OpenBookStream(InStreamL, ExcelBuffer.SelectSheetsNameStream(InStreamL));
        ExcelBuffer.ReadSheet;
        ExcelBuffer.SetFilter("Row No.", '>=%1', 2);
        if ExcelBuffer.FindSet() then
            repeat
                RecordCountG += 1;
                ExcelBuffer2.Reset();
                ExcelBuffer2.SetRange("Row No.", ExcelBuffer."Row No.");
                ExcelBuffer2.FindSet();
                Clear(SupplierBatchNoL);
                Clear(CustomLotNoL);
                Clear(CustomBOENoL);
                for RowCountL := 1 to 4 do begin
                    case ExcelBuffer2."Column No." of
                        1:
                            Evaluate(EntryNoL, ExcelBuffer2."Cell Value as Text");
                        2:
                            SupplierBatchNoL := ExcelBuffer2."Cell Value as Text";
                        3:
                            CustomLotNoL := ExcelBuffer2."Cell Value as Text";
                        4:
                            CustomBOENoL := ExcelBuffer2."Cell Value as Text";
                    end;
                    ExcelBuffer2.Next(1);
                end;
                UpdateILE(EntryNoL, SupplierBatchNoL, CustomLotNoL, CustomBOENoL);
                ExcelBuffer.SetRange("Row No.", ExcelBuffer."Row No." + 1);
            until ExcelBuffer.FindFirst() = false;
    end;

    local procedure UpdateILE(EntryNoP: Integer; SupplierBatchNoP: Text[100]; CustomLotNoP: Code[50]; CustomBOENoP: text[20])
    var
        ItemLedgerEntryL: Record "Item Ledger Entry";
    begin
        if ItemLedgerEntryL.Get(EntryNoP) then begin
            if CustomLotNoP > '' then
                ItemLedgerEntryL.CustomLotNumber := CustomLotNoP;
            if CustomBOENoP > '' then
                ItemLedgerEntryL.CustomBOENumber := CustomBOENoP;
            ItemLedgerEntryL.Modify();
        end;
    end;

    var
        StartDateG: Date;
        EndDateG: Date;
        ExcelImportG: Boolean;
        RecordCountG: Integer;
}