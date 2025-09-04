PageExtension 75048 Location_Card_75048 extends "Location Card"
{
    layout
    {
        addlast(General)
        {
            //ReturnTO-NS

            field(Returnable; Rec.Returnable)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Returnable field.';
            }
            //ReturnTO-NE
        }

    }
}

