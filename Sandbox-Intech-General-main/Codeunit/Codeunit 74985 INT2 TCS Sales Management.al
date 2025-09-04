codeunit 74985 "INT2 TCS Sales Management"
{

    procedure GetStatisticsAmount(
        SalesHeader: Record "Sales Header";
        var TCSAmount: Decimal)
    var
        SalesLine: Record "Sales Line";
        TCSManagement: Codeunit "TCS Management";
        i: Integer;
        RecordIDList: List of [RecordID];
    begin
        Clear(TCSAmount);

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document no.", SalesHeader."No.");
        if SalesLine.FindSet() then
            repeat
                RecordIDList.Add(SalesLine.RecordId());
            until SalesLine.Next() = 0;

        for i := 1 to RecordIDList.Count() do
            TCSAmount += GetTCSAmount(RecordIDList.Get(i));

        TCSAmount := TCSManagement.RoundTCSAmount(TCSAmount);
    end;

    procedure GetStatisticsAmountPostedInvoice(
        SalesInvoiceHeader: Record "Sales Invoice Header";
        var TCSAmount: Decimal)
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        TCSManagement: Codeunit "TCS Management";
        i: Integer;
        RecordIDList: List of [RecordID];
    begin
        Clear(TCSAmount);

        SalesInvoiceLine.SetRange("Document no.", SalesInvoiceHeader."No.");
        if SalesInvoiceLine.FindSet() then
            repeat
                RecordIDList.Add(SalesInvoiceLine.RecordId());
            until SalesInvoiceLine.Next() = 0;

        for i := 1 to RecordIDList.Count() do
            TCSAmount += GetTCSAmount(RecordIDList.Get(i));

        TCSAmount := TCSManagement.RoundTCSAmount(TCSAmount);
    end;

    procedure GetStatisticsAmountPostedCreditMemo(
            SalesCrMemoHeader: Record "Sales Cr.Memo Header";
            var TCSAmount: Decimal)
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        TCSManagement: Codeunit "TCS Management";
        i: Integer;
        RecordIDList: List of [RecordID];
    begin
        Clear(TCSAmount);

        SalesCrMemoLine.SetRange("Document no.", SalesCrMemoHeader."No.");
        if SalesCrMemoLine.FindSet() then
            repeat
                RecordIDList.Add(SalesCrMemoLine.RecordId());
            until SalesCrMemoLine.Next() = 0;

        for i := 1 to RecordIDList.Count() do
            TCSAmount += GetTCSAmount(RecordIDList.Get(i));

        TCSAmount := TCSManagement.RoundTCSAmount(TCSAmount);
    end;

    procedure GetTCSAmount(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        TCSSetup: Record "TCS Setup";
    begin
        if not TCSSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetRange("Tax Type", TCSSetup."Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then
            TaxTransactionValue.CalcSums(Amount);

        exit(TaxTransactionValue.Amount);
    end;

    procedure GetTCSPercentage(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        TCSSetup: Record "TCS Setup";
    begin
        if not TCSSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetRange("Tax Type", TCSSetup."Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then
            TaxTransactionValue.CalcSums(Percent);

        exit(TaxTransactionValue.Percent);
    end;

    //DG-06-02-2023-NS
    procedure GetTCSPercent(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        TCSSetup: Record "TCS Setup";
    begin
        if not TCSSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        TaxTransactionValue.SetRange("Tax Type", TCSSetup."Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then
            TaxTransactionValue.CalcSums(Percent);

        exit(TaxTransactionValue.Percent);
    end;

    procedure GetSalesLineTCSAmount(
                   SalesLine: Record "Sales Line";
                   var TCSAmount: Decimal)
    begin
        Clear(TCSAmount);
        TCSAmount := GetTCSAmount(SalesLine.RecordId());
    end;

    procedure GetSalesLineTCSPerc(
                   SalesLine: Record "Sales Line";
                   var TCSPerc: Decimal)
    begin
        Clear(TCSPerc);
        TCSPerc := GetTCSPercentage(SalesLine.RecordId());
    end;

    procedure GetTCSSalesInvLineAmount(
        SalesInvLine: Record "Sales Invoice Line";
        var TCSAmount: Decimal)
    begin
        Clear(TCSAmount);
        TCSAmount := GetTCSAmount(SalesInvLine.RecordId());
    end;

    procedure GetTCSSalesInvLinePercent(
            SalesInvLine: Record "Sales Invoice Line";
            var TCSPercent: Decimal)
    begin
        Clear(TCSPercent);
        TCSPercent := GetTCSPercent(SalesInvLine.RecordId());
    end;

    procedure GetTCSSalesCrMemoLineAmount(
       SalesCrLine: Record "Sales Cr.Memo Line";
        var TCSAmount: Decimal)
    begin
        Clear(TCSAmount);
        TCSAmount := GetTCSAmount(SalesCrLine.RecordId());
    end;

    procedure GetTCSSalesCrMemoLinePercentage(
            SalesCrLine: Record "Sales Cr.Memo Line";
            var TCSPercent: Decimal)
    begin
        Clear(TCSPercent);
        TCSPercent := GetTCSPercent(SalesCrLine.RecordId());
    end;

    procedure GetTCSSalesShptLineAmount(
           SalesShptLine: Record "Sales Shipment Line";
            var TCSAmount: Decimal)
    begin
        Clear(TCSAmount);
        TCSAmount := GetTCSAmount(SalesShptLine.RecordId());
    end;

    procedure GetTCSSalesShptLinePercentage(
            SalesShptLine: Record "Sales Shipment Line";
            var TCSPercent: Decimal)
    begin
        Clear(TCSPercent);
        TCSPercent := GetTCSPercent(SalesShptLine.RecordId());
    end;

    //DG-06-02-2023-NE
}