pageextension 75016 Purchase_Order_Subform_75016 extends "Purchase Order Subform"
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
            field(TDSAmount_gDec; TDSAmount_gDec)
            {
                ApplicationArea = All;
                Caption = 'TDS Amount';
                Editable = false;
            }
        }
        addafter(ShortcutDimCode8)
        {
            field("GST Import Duty Code"; Rec."GST Import Duty Code")
            {
                ApplicationArea = Basic;
            }
            field("Landing Cost Amount"; Rec."Landing Cost Amount")
            {
                ApplicationArea = Basic;
                Visible = false;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Clear(GSTStatistics_gCdu);
        GSTAmount_gDec := GSTStatistics_gCdu.GetGSTAmount(Rec.RecordId);

        Clear(INTTDSStatistics_gCdu);
        TDSAmount_gDec := INTTDSStatistics_gCdu.GetTDSAmount(Rec.RecordId);
    end;

    var
        GSTAmount_gDec: Decimal;
        GSTStatistics_gCdu: Codeunit "INT2 GST Statistics";
        TDSAmount_gDec: Decimal;

        INTTDSStatistics_gCdu: Codeunit "INT2 TDS Statistics";
}