pageextension 50261 "Item Units of Measure PagExt" extends "Item Units of Measure"//T12370-Full Comment
{
    layout
    {
        addafter("Qty. per Unit of Measure")
        {
            field("Net Weight"; rec."Net Weight")
            {
                ApplicationArea = all;
            }
            field("Packing Weight"; rec."Packing Weight")
            {

                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Packing Weight field.', Comment = '%';
            }
            field("Gross weight"; Rec."Gross weight")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gross weight field.', Comment = '%';
            }
            field(Default; rec.Default)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}