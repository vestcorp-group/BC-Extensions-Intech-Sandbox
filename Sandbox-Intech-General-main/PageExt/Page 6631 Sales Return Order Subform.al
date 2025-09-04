pageextension 75080 Sales_TrnOr_Subform_75080 extends "Sales Return Order Subform"
{
    layout
    {
        addlast(Control1)
        {
            field(GSTAmount_gDec; GSTAmount_gDec)
            {
                ApplicationArea = All;
                Caption = 'GST Amount';
                Editable = false;
            }
            field(TCSAmount_gDec; TCSAmount_gDec)
            {
                ApplicationArea = All;
                Caption = 'TCS Amount';
                Editable = false;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        Clear(GSTStatistics_gCdu);
        GSTAmount_gDec := GSTStatistics_gCdu.GetGSTAmount(Rec.RecordId);

        clear(INTTCSSalesManagement_gCdu);
        TCSAmount_gDec := INTTCSSalesManagement_gCdu.GetTCSAmount(rec.RecordId);
    end;

    var
        GSTAmount_gDec: Decimal;
        GSTStatistics_gCdu: Codeunit "INT2 GST Statistics";

        TCSAmount_gDec: Decimal;
        INTTCSSalesManagement_gCdu: Codeunit "INT2 TCS Sales Management";
}