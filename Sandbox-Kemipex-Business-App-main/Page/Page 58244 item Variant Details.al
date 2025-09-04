
page 58244 "Item Variant Details"//T12370-N
{
    Caption = 'Item Variant Details';
    DataCaptionFields = "Item No.", "Variant Code";
    PageType = List;
    SourceTable = "Item Variant Details";
    PopulateAllFields = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = all;
                }
                field("Manufacturer Name"; rec."Manufacturer Name")
                {
                    ApplicationArea = all;
                }
                field("Vendor No."; rec."Vendor No.")
                {
                    ApplicationArea = all;
                }
                field("Vendor Item Description"; rec."Vendor Item Description")
                {
                    ApplicationArea = all;
                }
                field("Vendor Country of Origin"; rec."Vendor Country of Origin")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
