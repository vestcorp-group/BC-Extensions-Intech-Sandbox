pageextension 75026 Purch_Invoice_Subform_75026 extends "Purch. Invoice Subform"
{
    layout
    {
        addlast(PurchDetailLine)
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
        // Add changes to page layout here
        addafter("Line No.")
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

    actions
    {
        // Add changes to page actions here
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