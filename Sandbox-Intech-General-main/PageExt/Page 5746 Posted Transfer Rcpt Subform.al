pageextension 75024 Pstd_Transf_Rcpt_Subform_75024 extends "Posted Transfer Rcpt. Subform"
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
        clear(INTTransferStastistics);
        INTTransferStastistics.GetStatisticsAmountTransferReceiptLine(Rec, GSTAmount_gDec);
    end;



    var
        GSTAmount_gDec: Decimal;
        INTTransferStastistics: Codeunit "INT2 Transfer Stastistics";

}