pageextension 50430 SOArchivedSubform extends "Sales Order Archive Subform"//T12370-Full Comment //T-12855 Page uncommented
{
    layout
    {
        addafter(Description)
        {
            field(HSNCode; rec.HSNCode)
            {
                ApplicationArea = all; //T-12855
            }
            field(LineHSNCode; rec.LineHSNCode)
            {
                ApplicationArea = all;
            }
            field(CountryOfOrigin; rec.CountryOfOrigin)
            {
                ApplicationArea = all;
            }
            field(LineCountryOfOrigin; rec.LineCountryOfOrigin)
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



        // Add changes to page layout here
        addafter(Quantity)
        {
            field("Base UOM 2"; rec."Base UOM 2")
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'Base UOM';
            }
            field("Unit Price Base UOM 2"; rec."Unit Price Base UOM 2")
            {
                ApplicationArea = All;
                Caption = 'Unit Price Base UOM';
            }
        }
        addafter("Quantity Invoiced")
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
    }

    //     actions
    //     {
    //         // Add changes to page actions here
    //     }

    //     var
    //         myInt: Integer;
}