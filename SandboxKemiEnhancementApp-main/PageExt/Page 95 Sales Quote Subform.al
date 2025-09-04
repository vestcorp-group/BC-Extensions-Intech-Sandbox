pageextension 70002 SalesQuoteSubform_PageExt extends "Sales Quote Subform"
{
    layout
    {
        addafter(Description)
        {
            field("Line Generic Name"; rec."Line Generic Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Item Generic Name"; Rec."Item Generic Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Item Generic Name field.', Comment = '%';
            }
            field(LineCountryOfOrigin; rec.LineCountryOfOrigin)
            {
                Caption = 'Line Country Of Origin';
                ApplicationArea = All;
            }
        }
        //T13395-NS
        addafter("Unit Price")
        {
            field("Customer Requested Unit Price"; rec."Customer Requested Unit Price")
            {
                ApplicationArea = All;
            }
        }
        //T13395-NE
    }
}