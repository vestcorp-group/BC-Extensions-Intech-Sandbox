codeunit 74983 "INT2 GST Statistics"
{
    procedure GetPurchaseStatisticsAmount(
        PurchaseHeader: Record "Purchase Header";
        var GSTAmount: Decimal)
    var
        PurchaseLine: Record "Purchase Line";
    begin
        Clear(GSTAmount);

        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document no.", PurchaseHeader."No.");
        if PurchaseLine.FindSet() then
            repeat
                GSTAmount += GetGSTAmount(PurchaseLine.RecordId());
            until PurchaseLine.Next() = 0;
    end;

    procedure GetStatisticsPostedPurchInvAmount(
        PurchInvHeader: Record "Purch. Inv. Header";
        var GSTAmount: Decimal)
    var
        PurchInvLine: Record "Purch. Inv. Line";
    begin
        Clear(GSTAmount);

        PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
        if PurchInvLine.FindSet() then
            repeat
                GSTAmount += GetGSTAmount(PurchInvLine.RecordId());
            until PurchInvLine.Next() = 0;
    end;

    procedure GetStatisticsPostedPurchCrMemoAmount(
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        var GSTAmount: Decimal)
    var
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
    begin
        Clear(GSTAmount);

        PurchCrMemoLine.SetRange("Document No.", PurchCrMemoHeader."No.");
        if PurchCrMemoLine.FindSet() then
            repeat
                GSTAmount += GetGSTAmount(PurchCrMemoLine.RecordId());
            until PurchCrMemoLine.Next() = 0;
    end;

    procedure GetGSTAmount(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then
            TaxTransactionValue.CalcSums(Amount);

        exit(TaxTransactionValue.Amount);
    end;

    procedure GetSalesStatisticsAmount(
        SalesHeader: Record "Sales Header";
        var GSTAmount: Decimal)
    var
        SalesLine: Record "Sales Line";
    begin
        Clear(GSTAmount);

        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document no.", SalesHeader."No.");
        if SalesLine.FindSet() then
            repeat
                GSTAmount += GetGSTAmount(SalesLine.RecordId());
            until SalesLine.Next() = 0;
    end;

    procedure GetStatisticsPostedSalesInvAmount(
        SalesInvHeader: Record "Sales Invoice Header";
        var GSTAmount: Decimal)
    var
        SalesInvLine: Record "Sales Invoice Line";
    begin
        Clear(GSTAmount);

        SalesInvLine.SetRange("Document No.", SalesInvHeader."No.");
        if SalesInvLine.FindSet() then
            repeat
                GSTAmount += GetGSTAmount(SalesInvLine.RecordId());
            until SalesInvLine.Next() = 0;
    end;

    procedure GetStatisticsPostedSalesCrMemoAmount(
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        var GSTAmount: Decimal)
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
    begin
        Clear(GSTAmount);

        SalesCrMemoLine.SetRange("Document No.", SalesCrMemoHeader."No.");
        if SalesCrMemoLine.FindSet() then
            repeat
                GSTAmount += GetGSTAmount(SalesCrMemoLine.RecordId());
            until SalesCrMemoLine.Next() = 0;
    end;

    local procedure GetPurchaseStatisticsAmountExcludingChargeItem(
        PurchaseHeader: Record "Purchase Header";
        var GSTAmount: Decimal)
    var
        PurchaseLine: Record "Purchase Line";
    begin
        Clear(GSTAmount);

        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document no.", PurchaseHeader."No.");
        if PurchaseLine.FindSet() then
            repeat
                if (not PurchaseLine."GST Reverse Charge") then
                    GSTAmount += GetGSTAmount(PurchaseLine.RecordId());
            until PurchaseLine.Next() = 0;
    end;

    local procedure GetStatisticsPostedPurchInvAmountExcludingChargeItem(
        PurchInvHeader: Record "Purch. Inv. Header";
        var GSTAmount: Decimal)
    var
        PurchInvLine: Record "Purch. Inv. Line";
    begin
        Clear(GSTAmount);

        PurchInvLine.SetRange("Document No.", PurchInvHeader."No.");
        if PurchInvLine.FindSet() then
            repeat
                if (not PurchInvLine."GST Reverse Charge") then
                    GSTAmount += GetGSTAmount(PurchInvLine.RecordId);
            until PurchInvLine.Next() = 0;
    end;

    //DG-06-02-2023-NS
    procedure GetGSTPercentage(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then
            TaxTransactionValue.CalcSums(Percent);

        exit(TaxTransactionValue.Percent);
    end;

    procedure GetSalesLineStatisticsAmount(
            SalesLine: Record "Sales Line";
            var GSTAmount: Decimal)
    begin
        Clear(GSTAmount);
        GSTAmount := GetGSTAmount(SalesLine.RecordId());
    end;

    procedure GetSalesLineStatisticsPercentage(
            SalesLine: Record "Sales Line";
            var GSTPercent: Decimal)
    begin
        Clear(GSTPercent);
        GSTPercent := GetGSTPercentage(SalesLine.RecordId());
    end;

    procedure GetStatisticsSalesInvLineAmount(
        SalesInvLine: Record "Sales Invoice Line";
        var GSTAmount: Decimal)
    begin
        Clear(GSTAmount);
        GSTAmount := GetGSTAmount(SalesInvLine.RecordId());
    end;

    procedure GetStatisticsSalesInvLinePercentage(
        SalesInvLine: Record "Sales Invoice Line";
        var GSTPercent: Decimal)
    begin
        Clear(GSTPercent);
        GSTPercent := GetGSTPercentage(SalesInvLine.RecordId());
    end;

    procedure GetStatisticsSalesCrMemoLineAmount(
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        var GSTAmount: Decimal)
    begin
        Clear(GSTAmount);
        GSTAmount := GetGSTAmount(SalesCrMemoLine.RecordId());
    end;

    procedure GetStatisticsSalesCrMemoLinePercentage(
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
        var GSTPercent: Decimal)
    begin
        Clear(GSTPercent);
        GSTPercent := GetGSTPercentage(SalesCrMemoLine.RecordId());
    end;

    procedure GetStatisticsSalesShptLineAmount(
        SalesShptLine: Record "Sales Shipment Line";
        var GSTAmount: Decimal)
    begin
        Clear(GSTAmount);
        GSTAmount := GetGSTAmount(SalesShptLine.RecordId());
    end;

    procedure GetStatisticsSalesShptLinePercentage(
        SalesShptLine: Record "Sales Shipment Line";
        var GSTPercent: Decimal)
    begin
        Clear(GSTPercent);
        GSTPercent := GetGSTPercentage(SalesShptLine.RecordId());
    end;

    procedure GetPurchaseLineStatisticsAmount(
            PurchaseLine: Record "Purchase Line";
            var GSTAmount: Decimal)
    begin
        Clear(GSTAmount);
        GSTAmount := GetGSTAmount(PurchaseLine.RecordId());
    end;

    procedure GetStatisticsPurchInvLineAmount(
      PurchInvLine: Record "Purch. Inv. Line";
       var GSTAmount: Decimal)
    begin
        Clear(GSTAmount);
        GSTAmount := GetGSTAmount(PurchInvLine.RecordId());
    end;

    procedure GetStatisticsPurchInvLinePercentage(
        PurchInvLine: Record "Purch. Inv. Line";
        var GSTPercent: Decimal)
    begin
        Clear(GSTPercent);
        GSTPercent := GetGSTPercentage(PurchInvLine.RecordId());
    end;

    procedure GetStatisticsPurchCrMemoAmount(
      PurchCrMemoLine: Record "Purch. Cr. Memo Line";
       var GSTAmount: Decimal)
    begin
        Clear(GSTAmount);
        GSTAmount := GetGSTAmount(PurchCrMemoLine.RecordId());
    end;

    procedure GetStatisticsPurchCrMemoLinePercentage(
      PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        var GSTPercent: Decimal)
    begin
        Clear(GSTPercent);
        GSTPercent := GetGSTPercentage(PurchCrMemoLine.RecordId());
    end;

    procedure GetStatisticsTransferLineAmount(
     TransLine: Record "Transfer Line";
       var GSTAmount: Decimal)
    begin
        Clear(GSTAmount);
        GSTAmount := GetGSTAmount(TransLine.RecordId());
    end;

    procedure GetStatisticsTransferLinePercentage(
      TransLine: Record "Transfer Line";
        var GSTPercent: Decimal)
    begin
        Clear(GSTPercent);
        GSTPercent := GetGSTPercentage(TransLine.RecordId());
    end;

    procedure GetStatisticsTransferShptLineAmount(
     TransShptLine: Record "Transfer Shipment Line";
       var GSTAmount: Decimal)
    begin
        Clear(GSTAmount);
        GSTAmount := GetGSTAmount(TransShptLine.RecordId());
    end;

    procedure GetStatisticsTransferShptLinePercentage(
      TransShptLine: Record "Transfer Shipment Line";
        var GSTPercent: Decimal)
    begin
        Clear(GSTPercent);
        GSTPercent := GetGSTPercentage(TransShptLine.RecordId());
    end;

    procedure GetStatisticsTransferRcptLineAmount(
    TransRcptLine: Record "Transfer Receipt Line";
      var GSTAmount: Decimal)
    begin
        Clear(GSTAmount);
        GSTAmount := GetGSTAmount(TransRcptLine.RecordId());
    end;

    procedure GetStatisticsTransferRcptLinePercentage(
      TransRcptLine: Record "Transfer Receipt Line";
        var GSTPercent: Decimal)
    begin
        Clear(GSTPercent);
        GSTPercent := GetGSTPercentage(TransRcptLine.RecordId());
    end;

    procedure GetStatisticsSerInvLineAmount(
      SerInvLine: Record "Service Invoice Line";
      var GSTAmount: Decimal)
    begin
        Clear(GSTAmount);
        GSTAmount := GetGSTAmount(SerInvLine.RecordId());
    end;

    procedure GetStatisticsSerInvLinePercentage(
       SerInvLine: Record "Service Invoice Line";
        var GSTPercent: Decimal)
    begin
        Clear(GSTPercent);
        GSTPercent := GetGSTPercentage(SerInvLine.RecordId());
    end;

    procedure GetStatisticsSerCrMemoLineAmount(
     SerCrMemoLine: Record "Service Cr.Memo Line";
     var GSTAmount: Decimal)
    begin
        Clear(GSTAmount);
        GSTAmount := GetGSTAmount(SerCrMemoLine.RecordId());
    end;

    procedure GetStatisticsSerCrMemoLinePercentage(
       SerCrMemoLine: Record "Service Cr.Memo Line";
        var GSTPercent: Decimal)
    begin
        Clear(GSTPercent);
        GSTPercent := GetGSTPercentage(SerCrMemoLine.RecordId());
    end;

    procedure GetStatisticsRetShptLineAmount(
     RetShptLine: Record "Return Shipment Line";
     var GSTAmount: Decimal)
    begin
        Clear(GSTAmount);
        GSTAmount := GetGSTAmount(RetShptLine.RecordId());
    end;

    procedure GetStatisticsRetShptLinePercentage(
       RetShptLine: Record "Return Shipment Line";
        var GSTPercent: Decimal)
    begin
        Clear(GSTPercent);
        GSTPercent := GetGSTPercentage(RetShptLine.RecordId());
    end;

    procedure GetStatisticsRetRcptLineAmount(
    RetRcptLine: Record "Return Receipt Line";
    var GSTAmount: Decimal)
    begin
        Clear(GSTAmount);
        GSTAmount := GetGSTAmount(RetRcptLine.RecordId());
    end;

    procedure GetStatisticsRetRcptLinePercentage(
       RetRcptLine: Record "Return Receipt Line";
        var GSTPercent: Decimal)
    begin
        Clear(GSTPercent);
        GSTPercent := GetGSTPercentage(RetRcptLine.RecordId());
    end;
    //DG-06-02-2023-NE
}