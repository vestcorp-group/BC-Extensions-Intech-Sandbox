pageextension 50337 KMP_PageExtPostSalesInvSubForm extends "Posted Sales Invoice Subform"//T12370-Full Comment //T-12855 Code Uncommented
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field(HSNCode; rec.HSNCode)
            {
                Caption = 'Item HSN Code';
                ApplicationArea = All;
                Editable = false;
            }
            field(CountryOfOrigin; rec.CountryOfOrigin)
            {
                Caption = 'Item Country Of Origin';
                ApplicationArea = All;
                Editable = false;
            }
            field(BillOfExit; rec.BillOfExit)
            {
                ApplicationArea = all;
                Caption = 'Bill Of Exit';
                Editable = false;
                Visible = false;
            }
        }
        addbefore(Quantity)
        {
            field("Base UOM 2"; rec."Base UOM 2")
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'Base UOM';
            }
            field("Quantity (Base)"; rec."Quantity (Base)")
            {
                ApplicationArea = all;
                Editable = false;
                Visible = true;
            }
            field("Unit Price Base UOM 2"; rec."Unit Price Base UOM 2")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Unit Price Base UOM';
            }
        }
        addafter("Line Amount")
        {
            field("Net Weight1"; rec."Net Weight")
            {
                ApplicationArea = all;
            }
            field("Gross Weight1"; rec."Gross Weight")
            {
                ApplicationArea = all;
            }
            field("Container No. 2"; rec."Container No. 2")
            {
                ApplicationArea = all;
                Caption = 'Container No.';
            }
        }
        addbefore(Description)
        {
            field("IMCO Code"; rec."IMCO Class")
            {
                ApplicationArea = all;

            }
        }



    }
}