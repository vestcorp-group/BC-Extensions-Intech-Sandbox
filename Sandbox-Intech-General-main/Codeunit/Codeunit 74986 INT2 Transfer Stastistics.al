codeunit 74986 "INT2 Transfer Stastistics"
{
    procedure GetStatisticsAmountTransferShipmentHeader(TransferShipmentHeader: Record "Transfer Shipment Header"; var GSTAmount: Decimal)
    var
        DetailedGSTLedgerEntry_lRec: Record "Detailed GST Ledger Entry";
    begin
        Clear(GSTAmount);

        DetailedGSTLedgerEntry_lRec.SetRange("Transaction Type", DetailedGSTLedgerEntry_lRec."Transaction Type"::Transfer);
        DetailedGSTLedgerEntry_lRec.SetRange("Document Type", DetailedGSTLedgerEntry_lRec."Document Type"::Invoice);
        DetailedGSTLedgerEntry_lRec.SetRange("Document No.", TransferShipmentHeader."No.");
        if DetailedGSTLedgerEntry_lRec.FindSet() then
            repeat
                GSTAmount += DetailedGSTLedgerEntry_lRec."GST Amount" * -1;
            until DetailedGSTLedgerEntry_lRec.Next() = 0;
    end;

    procedure GetStatisticsAmountTransferReceiptHeader(TransferReceiptHeader: Record "Transfer Receipt Header"; var GSTAmount: Decimal)
    var
        DetailedGSTLedgerEntry_lRec: Record "Detailed GST Ledger Entry";
    begin
        Clear(GSTAmount);

        DetailedGSTLedgerEntry_lRec.SetRange("Transaction Type", DetailedGSTLedgerEntry_lRec."Transaction Type"::Transfer);
        DetailedGSTLedgerEntry_lRec.SetRange("Document Type", DetailedGSTLedgerEntry_lRec."Document Type"::Invoice);
        DetailedGSTLedgerEntry_lRec.SetRange("Document No.", TransferReceiptHeader."No.");
        If DetailedGSTLedgerEntry_lRec.FindSet() then
            repeat
                GSTAmount += DetailedGSTLedgerEntry_lRec."GST Amount" * -1;
            until DetailedGSTLedgerEntry_lRec.Next() = 0;
    end;

    procedure GetStatisticsAmountTransferReceiptLine(TransferReceiptLine: Record "Transfer Receipt Line"; Var GSTAmount: Decimal)
    var
        DetailedGSTLedgerEntry_lRec: Record "Detailed GST Ledger Entry";
    begin
        Clear(GSTAmount);

        DetailedGSTLedgerEntry_lRec.SetRange("Transaction Type", DetailedGSTLedgerEntry_lRec."Transaction Type"::Transfer);
        DetailedGSTLedgerEntry_lRec.SetRange("Document Type", DetailedGSTLedgerEntry_lRec."Document Type"::Invoice);
        DetailedGSTLedgerEntry_lRec.SetRange("Document No.", TransferReceiptLine."Document No.");
        DetailedGSTLedgerEntry_lRec.SetRange("Entry No.", TransferReceiptLine."Line No.");
        if DetailedGSTLedgerEntry_lRec.FindSet() then
            repeat
                GSTAmount := DetailedGSTLedgerEntry_lRec."GST Amount" * -1;
            until DetailedGSTLedgerEntry_lRec.Next() = 0;
    end;

    procedure GetStatisticsAmountTransferShipmentLine(TransferShipmentLine: Record "Transfer Shipment Line"; var GSTAmount: Decimal)
    var
        DetailedGSTLedgerEntry_lRec: Record "Detailed GST Ledger Entry";
    begin
        DetailedGSTLedgerEntry_lRec.SetRange("Transaction Type", DetailedGSTLedgerEntry_lRec."Transaction Type"::Transfer);
        DetailedGSTLedgerEntry_lRec.SetRange("Document Type", DetailedGSTLedgerEntry_lRec."Document Type"::Invoice);
        DetailedGSTLedgerEntry_lRec.SetRange("Document No.", TransferShipmentLine."Document No.");
        DetailedGSTLedgerEntry_lRec.SetRange("Entry No.", TransferShipmentLine."Line No.");
        if DetailedGSTLedgerEntry_lRec.FindSet() then
            repeat
                GSTAmount := DetailedGSTLedgerEntry_lRec."GST Amount" * -1;
            until DetailedGSTLedgerEntry_lRec.Next() = 0;
    end;
}