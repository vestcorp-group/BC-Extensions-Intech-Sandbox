pageextension 50398 "Posd Sales Cr.Memo Subform Ext" extends "Posted Sales Cr. Memo Subform"//T12370-Full Comment
{
    // version NAVW113.00

    layout
    {
        addbefore(Quantity)
        {
            field("Base UOM 2"; rec."Base UOM 2")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Base UOM';
            }
            // field("Qty. per Unit of Measure"; rec."Qty. per Unit of Measure")
            // {
            //     Editable = false;
            //     ApplicationArea = All;
            // }
            field("Unit Price Base UOM 2"; rec."Unit Price Base UOM 2")
            {
                ApplicationArea = All;
                Caption = 'Unit Price Base UOM';
                //Editable = false;
            }
        }
        addafter("Line Amount")
        {
            field("Container No. 2"; rec."Container No. 2")
            {
                ApplicationArea = all;
                Caption = 'Container No.';
            }
        }
    }
}

