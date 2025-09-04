pageextension 75021 Pstd_Transf_Shpt_Subform_75021 extends "Posted Transfer Shpt. Subform"
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
        }
    }
    trigger OnAfterGetRecord()
    begin
        Clear(INTTransferStastistics);
        INTTransferStastistics.GetStatisticsAmountTransferShipmentLine(Rec, GSTAmount_gDec);
    end;

    var
        GSTAmount_gDec: Decimal;
        INTTransferStastistics: Codeunit "INT2 Transfer Stastistics";
}