pageextension 58010 ItemSelection extends "Item List"//T12370-Full Comment //Hypercare 07-03-2025
{
    layout
    {
        // addfirst(factboxes)
        // {
        //     part("Consolidated Inventory"; "Item Company Wise Inventory")
        //     {
        //         ApplicationArea = all;
        //         SubPageLink = "Item No." = field("No.");
        //         Visible = false;
        //     }
        //     part(KFZEConsolidatedInventory; "Item Comp Wise Inventory temp")
        //     {
        //         ApplicationArea = all;
        //         Caption = 'Consolidated Inventory';
        //     }
        // }

        // modify("Vendor Item No.")
        // {
        //     Visible = false;
        //     ApplicationArea = all;
        // }
        // modify("Assembly BOM")
        // {
        //     Visible = false;
        //     ApplicationArea = all;
        // }
        // modify("Substitutes Exist")
        // {
        //     Visible = false;
        //     ApplicationArea = all;
        // }
        addafter("Vendor No.")
        {
            field(vendorName; vendorName)
            {
                ApplicationArea = all;
                Caption = 'Vendor Name';
            }
            // field("Storage Handling Instruction"; Rec."Storage Handling Instruction")
            // {
            //     ApplicationArea = All;
            // }
            field("Item Category Desc."; rec."Item Category Desc.")
            {
                ApplicationArea = all;
            }
            field(MarketIndustry; rec.MarketIndustry)
            {
                ApplicationArea = all;
            }
            field("Market Industry Desc."; rec."Market Industry Desc.")
            {
                ApplicationArea = all;
            }
            field(GenericName; rec.GenericName)
            {
                ApplicationArea = all;
            }
            field("Generic Description"; rec."Generic Description")
            {
                ApplicationArea = all;
            }
            field("Product Family"; rec."Product Family")
            {
                ApplicationArea = all;
            }
            field("Product Family Name"; Rec."Product Family Name")
            {
                ApplicationArea = all;
            }
            field("Item Incentive Ratio (IIR)"; rec."Item Incentive Ratio (IIR)")//Hypercare 07-03-2025
            {
                Caption = 'Item Incentive Point (IIP)';
                ApplicationArea = all;
                Editable = false;
            }
        }
        // addafter(Description)
        // {
        //     field("Search Description2"; rec."Search Description")
        //     {
        //         Caption = 'Item Short Name';
        //         ApplicationArea = all;
        //     }
        //     field(Vendor_item_description; rec.Vendor_item_description)
        //     {
        //         ApplicationArea = all;
        //         Caption = 'Vendor Item Description';
        //     }

        //     field("Description 21"; rec."Description 2")
        //     {
        //         Caption = 'Packing';
        //         ApplicationArea = all;
        //     }

        // }
        // addafter(Blocked)
        // {
        //     field("Block Reason"; rec."Block Reason")
        //     {
        //         ApplicationArea = all;
        //     }
        //     field("Expiration Calculation"; rec."Expiration Calculation")
        //     {
        //         ApplicationArea = all;
        //     }
        // }
        // moveafter(Description; "Search Description")

        // addlast(FactBoxes)
        // {
        //     part("ItemUOM"; "Item UOM Factbox")
        //     {
        //         ApplicationArea = all;
        //         SubPageLink = "Item No." = field("No.");
        //     }
        // }

    }

    // trigger OnDeleteRecord(): Boolean
    // begin
    //     Error('Not allowed to delete the record!');
    // end;

    // trigger OnAfterGetRecord()
    // var
    //     vendor: Record Vendor;
    // begin
    //     Clear(vendorName);
    //     vendor.SetRange("No.", rec."Vendor No.");
    //     if vendor.FindSet() then
    //         vendorName := vendor.Name;


    // end;

    // trigger OnAfterGetCurrRecord()
    // begin
    //     CurrPage.KFZEConsolidatedInventory.Page.LoadConsolidatedInvtData(Rec."No.");
    // end;

    var
        vendorName: Text;
}