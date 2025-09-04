TableExtension 75011 Purch_Inv_Header_75011 extends "Purch. Inv. Header"
{
    fields
    {
        field(74334; "Vendor Invoice Date"; Date)
        {
            Caption = 'Vendor Invoice Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    local procedure "====FieldFunc======"()
    begin
    end;

    procedure "Amount To Vendor"(): Decimal
    var
        CalGSTValue_lDec: Decimal;
        CalcStatistics: Codeunit "Calculate Statistics";
    begin
        //Update Logic Here
        //DG-NS
        CalcStatistics.GetPostedPurchInvStatisticsAmount(Rec, CalGSTValue_lDec);
        exit(CalGSTValue_lDec);
        //DG-NE
    end;
}