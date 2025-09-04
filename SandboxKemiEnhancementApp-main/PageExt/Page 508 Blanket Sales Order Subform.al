pageextension 80025 "BlanketSalesOrderSubform_Ext" extends "Blanket Sales Order Subform"//T12370-Full Comment
{
    layout
    {
        addafter(Description)
        {
            //T12724 NS 07112024
            field("Item Generic Name"; rec."Item Generic Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Line Generic Name"; rec."Line Generic Name")
            {
                ApplicationArea = all;
            }
            //T12724 NE 07112024
        }
        addafter("Unit Price")
        {
            field("Customer Requested Unit Price"; rec."Customer Requested Unit Price")//T13395-N
            {
                ApplicationArea = All;
            }
        }
    }

    //     actions
    //     {
    //         // Add changes to page actions here
    //     }

    //     var
    //         myInt: Integer;
}