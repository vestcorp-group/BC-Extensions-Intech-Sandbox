pageextension 50162 KMP_PageExtSalesInvSubForm extends "Sales Invoice Subform"//T12370-Full Comment //T-12855 Code Uncommented
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
                Editable = false; //T-12855
            }
            field(CountryOfOrigin; rec.CountryOfOrigin)
            {
                Caption = 'Item Country Of Origin';
                ApplicationArea = All;
                Editable = false;
            }
            field(LineHSNCode; rec.LineHSNCode)
            {
                Caption = 'Line HSN Code';
                ApplicationArea = All;
            }
            field(LineCountryOfOrigin; rec.LineCountryOfOrigin)
            {
                Caption = 'Line Country Of Origin';
                ApplicationArea = All;
            }
            field(BillOfExit; rec.BillOfExit)
            {
                Caption = 'Bill Of Exit';
                ApplicationArea = All;
            }
        }
        addafter(Quantity)
        {
            field("Quantity (Base)"; Rec."Quantity (Base)")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Base UOM 2"; rec."Base UOM 2")
            {
                ApplicationArea = All;
                Caption = 'Base UOM';
            }
            field("Qty. per Unit of Measure"; rec."Qty. per Unit of Measure")
            {
                Editable = false;
                ApplicationArea = All;
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
            field("IC Related SO"; rec."IC Related SO")
            {
                ApplicationArea = all;
            }
        }
        addbefore(Description)
        {
            field("IMCO Code"; rec."IMCO Class")
            {
                ApplicationArea = all;

            }
        }
        addbefore("Unit Price")
        {
            //PackingListExtChange
            field("Unit Price Base UOM"; rec."Unit Price Base UOM 2")
            {
                ApplicationArea = All;
            }
        }
    }
}
