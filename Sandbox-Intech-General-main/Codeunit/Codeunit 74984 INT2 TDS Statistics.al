codeunit 74984 "INT2 TDS Statistics"
{
    procedure GetStatisticsAmount(
        PurchaseHeader: Record "Purchase Header";
        var TDSAmount: Decimal)
    var
        PurchaseLine: Record "Purchase Line";
        TDSEntityManagement: Codeunit "TDS Entity Management";
        i: Integer;
        RecordIDList: List of [RecordID];
    begin
        Clear(TDSAmount);

        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document no.", PurchaseHeader."No.");
        if PurchaseLine.FindSet() then
            repeat
                RecordIDList.Add(PurchaseLine.RecordId());
            until PurchaseLine.Next() = 0;

        for i := 1 to RecordIDList.Count() do
            TDSAmount += GetTDSAmount(RecordIDList.Get(i));

        TDSAmount := TDSEntityManagement.RoundTDSAmount(TDSAmount);
    end;

    procedure GetStatisticsPostedAmount(
        PurchInvHeader: Record "Purch. Inv. Header";
        var TDSAmount: Decimal)
    var
        PurchInvLine: Record "Purch. Inv. Line";
        TDSEntityManagement: Codeunit "TDS Entity Management";
        i: Integer;
        RecordIDList: List of [RecordID];
    begin
        Clear(TDSAmount);

        PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
        if PurchInvLine.FindSet() then
            repeat
                RecordIDList.Add(PurchInvLine.RecordId());
            until PurchInvLine.Next() = 0;

        for i := 1 to RecordIDList.Count() do
            TDSAmount += GetTDSAmount(RecordIDList.Get(i));

        TDSAmount := TDSEntityManagement.RoundTDSAmount(TDSAmount);
    end;

    procedure GetStatisticsPostedPurchCrMemoAmount(
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        var TDSAmount: Decimal)
    var
        PCML_lRec: Record "Purch. Cr. Memo Line";
        TDSEntityManagement: Codeunit "TDS Entity Management";
        i: Integer;
        RecordIDList: List of [RecordID];
    begin
        Clear(TDSAmount);

        PCML_lRec.SetRange("Document No.", PurchCrMemoHeader."No.");
        if PCML_lRec.FindSet() then
            repeat
                RecordIDList.Add(PCML_lRec.RecordId());
            until PCML_lRec.Next() = 0;

        for i := 1 to RecordIDList.Count() do
            TDSAmount += GetTDSAmount(RecordIDList.Get(i));

        TDSAmount := TDSEntityManagement.RoundTDSAmount(TDSAmount);
    end;

    procedure GetTDSAmount(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        TDSSetup: Record "TDS Setup";
    begin
        if not TDSSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then
            TaxTransactionValue.CalcSums(Amount);

        exit(TaxTransactionValue.Amount);
    end;

    //DG-06-02-2023-NS
    procedure GetTDSPercent(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        TDSSetup: Record "TDS Setup";
    begin
        if not TDSSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetRange("Tax Type", TDSSetup."Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then
            TaxTransactionValue.CalcSums(Percent);

        exit(TaxTransactionValue.Percent);
    end;

    procedure GetPurchLineTDSAmount(
                   PurchaseLine: Record "Purchase Line";
                   var TDSAmount: Decimal)
    begin
        Clear(TDSAmount);
        TDSAmount := GetTDSAmount(PurchaseLine.RecordId());
    end;

    procedure GetPurchLineTDSPercentage(
                   PurchaseLine: Record "Purchase Line";
                   var TDSPercent: Decimal)
    begin
        Clear(TDSPercent);
        TDSPercent := GetTDSPercent(PurchaseLine.RecordId());
    end;

    procedure GetPurchInvLineTDSAmount(
                   PurchaseInvLine: Record "Purch. Inv. Line";
                   var TDSAmount: Decimal)
    begin
        Clear(TDSAmount);
        TDSAmount := GetTDSAmount(PurchaseInvLine.RecordId());
    end;

    procedure GetPurchInvLineTDSPercentage(
                   PurchaseInvLine: Record "Purch. Inv. Line";
                   var TDSPercent: Decimal)
    begin
        Clear(TDSPercent);
        TDSPercent := GetTDSPercent(PurchaseInvLine.RecordId());
    end;

    procedure GetPurchCrMemoLineTDSAmount(
                   PurchaseCrMemoLine: Record "Purch. Cr. Memo Line";
                   var TDSAmount: Decimal)
    begin
        Clear(TDSAmount);
        TDSAmount := GetTDSAmount(PurchaseCrMemoLine.RecordId());
    end;

    procedure GetPurchCrMemoLineTDSPercentage(
                   PurchaseCrMemoLine: Record "Purch. Cr. Memo Line";
                   var TDSPercent: Decimal)
    begin
        Clear(TDSPercent);
        TDSPercent := GetTDSPercent(PurchaseCrMemoLine.RecordId());
    end;

    //DG-06-02-2023-NE
}