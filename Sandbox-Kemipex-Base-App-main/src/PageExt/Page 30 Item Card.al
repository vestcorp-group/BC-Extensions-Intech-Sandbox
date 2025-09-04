pageextension 50279 KMP_PageExtItem extends "Item Card"//T12370-Full Comment
{
    layout
    {
        addafter("Item Category Code")
        {
            field("IMCO Code"; rec."IMCO Class")
            {
                ApplicationArea = all;
                Caption = 'UN Number';
            }
            field("Product Family"; Rec."Product Family")
            {
                ApplicationArea = All;
            }
            field("Product Family Name"; Rec."Product Family Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        //         addfirst(factboxes)
        //         {
        //             part(ConsolInv; "Item Company Wise Inventory")
        //             {
        //                 ApplicationArea = all;
        //                 SubPageLink = "Item No." = field("No.");
        //                 Visible = false;
        //             }
        //         }
        //         modify("Sales Blocked")
        //         {
        //             trigger OnAfterValidate()
        //             var
        //                 myInt: Integer;
        //             begin
        //                 CurrPage.Update();
        //             end;
        //         }
        //         modify("Purchasing Blocked")
        //         {
        //             trigger OnAfterValidate()
        //             var
        //                 myInt: Integer;
        //             begin
        //                 CurrPage.Update();
        //             end;

        //         }
        //         modify(Blocked)
        //         {
        //             trigger OnAfterValidate()
        //             var
        //                 myInt: Integer;
        //             begin
        //                 CurrPage.Update();
        //             end;
        //         }

        //         addlast(content)
        //         {
        //             part(ItemCompanyBlock; "Item Company Block")
        //             {
        //                 ApplicationArea = all;
        //                 Caption = 'Item Company Block';
        //                 SubPageLink = "Item No." = field("No.");
        //             }
        //         }

        //         // Add changes to page layout here
        addafter("Common Item No.")
        {
            //             field(MarketIndustry; rec.MarketIndustry)
            //             {
            //                 ApplicationArea = All;
            //                 Caption = 'Market Industry';
            //                 Visible = false;
            //             }
            field(GenericName; rec.GenericName)
            {
                ApplicationArea = All;
                Caption = 'Generic Code';
                Visible = false;
            }
            //             field("Item Category Desc."; rec."Item Category Desc.")
            //             {
            //                 ApplicationArea = all;
            //             }
            //             field("Market Industry Desc."; rec."Market Industry Desc.")
            //             {
            //                 ApplicationArea = all;
            //             }
            //T12724 NS 07112024
            field("Generic Description"; rec."Generic Description")
            {
                ApplicationArea = all;
                Caption = 'Generic Name';
            }
            //T12724 NE 07112024
            //             // field(CountryOfOrigin; CountryOfOrigin)
            //             // {
            //             //     ApplicationArea = All;
            //             //     Caption = 'Country Of Origin';
            //             // }
            //             field(ManufacturerName; rec.ManufacturerName)
            //             {
            //                 ApplicationArea = All;
            //                 Caption = 'Manufacturer Name';
            //                 Visible = false;
            //             }
            //             field("Manufacturer Description"; rec."Manufacturer Description")
            //             {
            //                 ApplicationArea = all;
            //             }
            //             field("Allow Loose Qty."; rec."Allow Loose Qty.")
            //             {
            //                 ApplicationArea = all;
            //             }
            field("Item Incentive Ratio (IIR)"; rec."Item Incentive Ratio (IIR)")//Hypercare 07-03-2025
            {
                Caption = 'Item Incentive Point (IIP)';
                ApplicationArea = all;
                Editable = false;
            }

            //             field("COA Distribution"; rec."COA Distribution")
            //             {
            //                 Caption = 'COA Distribution';
            //                 ApplicationArea = all;
            //             }
            //             field("CAS No."; rec."CAS No.")
            //             {
            //                 ApplicationArea = all;
            //                 ToolTip = 'This will be print on Posted Sales Invoice. Only for IND Customers';
            //             }
            //             field("IUPAC Name"; rec."IUPAC Name")
            //             {
            //                 ApplicationArea = all;
            //                 ToolTip = 'This will be print on Posted Sales Invoice. Only for IND Customers';
            //             }
        }
        //         addafter("Country/Region of Origin Code")
        //         {
        //             field("Vendor Country of Origin"; rec."Vendor Country of Origin")
        //             {
        //                 ApplicationArea = all;
        //                 Caption = 'Vendor Country of Origin';
        //             }
        //         }
        //         modify("Item Category Code")
        //         {
        //             Visible = false;
        //         }
        //         modify("Country/Region of Origin Code")
        //         {
        //             Caption = 'Legal Country of origin';
        //         }

        //         addafter(AssemblyBOM)
        //         {
        //             field("Temporary Vendor Name"; rec."Temporary Vendor Name")
        //             {
        //                 ApplicationArea = All; // B Development
        //             }
        //         }

    }



    //     actions
    //     {
    //         // Add changes to page actions here
    //     }

    //     var
    //         myInt: Integer;
}