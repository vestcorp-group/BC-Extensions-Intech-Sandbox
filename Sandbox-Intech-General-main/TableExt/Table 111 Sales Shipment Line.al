TableExtension 74988 Sales_Shipment_Line_74988 extends "Sales Shipment Line"
{
    local procedure "====FieldFunc======"()
    begin
    end;

    procedure "GST %"(): Decimal
    var
        GstPercentage_lDec: Decimal;
        INT2GSTStatistics: Codeunit "INT2 GST Statistics";
    begin
        //Update Logic Here
        //DG-NS
        INT2GSTStatistics.GetStatisticsSalesShptLinePercentage(Rec, GstPercentage_lDec);
        exit(GstPercentage_lDec);
        //DG-NE
    end;

    procedure "GST Base Amount"(): Decimal
    var
        GSTBaseCal_lDec: Decimal;
        SalesLine_lRec: Record "Sales Line";
        TempSalesInvLine: Record "Sales Invoice Line" temporary;
    begin
        IF SalesLine_lRec.Get(SalesLine_lRec."Document Type"::Order, Rec."Order No.", Rec."Order Line No.") THen begin
            GSTBaseCal_lDec := (Rec.Quantity * SalesLine_lRec."Line Amount") / SalesLine_lRec.Quantity;
        End Else begin
            Rec.GetSalesInvLines(TempSalesInvLine);
            GSTBaseCal_lDec := (Rec.Quantity * TempSalesInvLine."Line Amount") / TempSalesInvLine.Quantity;
        end;
        exit(GSTBaseCal_lDec);
    end;
}