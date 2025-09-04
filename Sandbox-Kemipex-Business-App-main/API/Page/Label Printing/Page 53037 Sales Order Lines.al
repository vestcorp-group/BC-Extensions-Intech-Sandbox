page 53037 APISalesOrderLines//T50051 Code Uncommented
{
    ApplicationArea = All;
    Caption = 'LP - API Sales Order Lines';
    PageType = API;
    SourceTable = "Sales Line";
    Permissions = tabledata "Sales Line" = R;
    DataCaptionFields = "No.";
    UsageCategory = History;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;

    // Powerautomate Category
    EntityName = 'SalesOrderLine';
    EntitySetName = 'SalesOrderLines';
    EntityCaption = 'SalesOrderLine';
    EntitySetCaption = 'SalesOrderLines';
    // ODataKeyFields = SystemId;
    Extensible = false;

    APIPublisher = 'Kemipex';
    APIGroup = 'LabelPrinting';
    APIVersion = 'v2.0';


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document_Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Bill_to_Customer_No"; rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Document_No"; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Line_No"; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("No"; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Location_Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Posting_Group"; Rec."Posting Group")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Variant_Code"; rec."Variant Code")
                {
                    ApplicationArea = all;
                }
                field("Unit_of_Measure_Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(HSNCode; rec.HSNCode)
                {
                    ApplicationArea = All;
                }
                field(LineHSNCode; rec.LineHSNCode)
                {
                    ApplicationArea = all;
                }
                field(CountryOfOrigin; rec.CountryOfOrigin)
                {
                    ApplicationArea = All;
                }
                field(LineCountryOfOrigin; rec.LineCountryOfOrigin)
                {
                    ApplicationArea = all;
                }
                field("Item_Generic_Name"; rec."Item Generic Name")
                {
                    ApplicationArea = all;
                }
                field("Line_Generic_Name"; rec."Line Generic Name")
                {
                    ApplicationArea = all;
                }

                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Packing_Description"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Base_UOM"; rec."Base UOM 2")
                {
                    ApplicationArea = All;
                }
                field("Quantity_Base"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("Unit_Price_Base_UOM"; Rec."Unit Price Base UOM 2")
                {
                    ApplicationArea = All;
                }
                field("Line_Amount"; rec."Line Amount")
                {
                    ApplicationArea = all;
                }
                field("Qty_Shipped_Base"; rec."Qty. Shipped (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty_Invoiced_Base"; Rec."Qty. Invoiced (Base)")
                {
                    ApplicationArea = All;
                }
                field("Quantity_Shipped"; rec."Quantity Shipped")
                {
                    ApplicationArea = All;
                }
                field("Quantity_Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Qty_to_Ship"; rec."Qty. to Ship")
                {
                    ApplicationArea = All;
                }
                field("Qty_to_Invoice"; rec."Qty. to Invoice")
                {
                    ApplicationArea = all;
                }


            }

        }
    }
}
