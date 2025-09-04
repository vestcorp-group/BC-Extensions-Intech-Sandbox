TableExtension 75004 Cust_Ledger_Entry_75004 extends "Cust. Ledger Entry"
{

    local procedure "====FieldFunc======"()
    begin
    end;

    procedure "Total TDS/TCS Incl SHE CESS"(): Decimal
    var
        CalGSTValue_lDec: Decimal;
        TCSEntry_lRec: Record "TCS Entry";
    begin
        //Update Logic Here
        //CalGSTValue_lDec := IN2GSTStatistics.GetGSTAmount(Rec.RecordId); //DG-N

        CalGSTValue_lDec := 0;
        TCSEntry_lRec.Reset();
        TCSEntry_lRec.Setrange("Document No.", Rec."Document No.");
        TCSEntry_lRec.Setrange("Document Type", Rec."Document Type");
        IF TCSEntry_lRec.FindSet() Then begin
            repeat
                CalGSTValue_lDec += TCSEntry_lRec."TCS Amount";
            until TCSEntry_lRec.Next() = 0;
        end;
        Exit(CalGSTValue_lDec);
    end;
}