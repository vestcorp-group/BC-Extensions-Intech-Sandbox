pageextension 85210 OutputJnlExt extends "Output Journal"
{
    layout
    {
        addafter(Description)
        {
            field("FPO No."; Rec."FPO No.")
            {
                ApplicationArea = All;
                Description = 'T51982';
                ToolTip = 'Specifies the value of the FPO No. field.', Comment = '%';
            }
        }

    }

}