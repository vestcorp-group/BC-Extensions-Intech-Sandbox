pageextension 79654 "User Setup Ext" extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field("Allow to Update Short Close PO"; Rec."Allow to Update Short Close PO")
            {
                ApplicationArea = All;
            }
            field("Allow to Update Short Close SO"; Rec."Allow to Update Short Close SO")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow to Insert/Delete Short Close Sales Order field.', Comment = '%';
            }
            field("Allow to Update Short Close TO"; Rec."Allow to Update Short Close TO")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow to Insert/Delete Short Close Transfer Order field.', Comment = '%';
            }

        }

    }
}
