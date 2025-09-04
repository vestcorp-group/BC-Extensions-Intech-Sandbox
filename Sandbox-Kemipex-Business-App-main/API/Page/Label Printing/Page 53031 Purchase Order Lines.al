page 53031 APIPurchaseOrderLines//T12370-Full Comment//T50051 Code Uncommented
{
    ApplicationArea = All;
    Caption = 'LP - API Purchase Order Lines';
    PageType = API;
    SourceTable = "Purchase Line";
    Permissions = tabledata "Purchase Line" = R;
    DataCaptionFields = "No.";
    UsageCategory = History;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;

    // Powerautomate Category
    EntityName = 'PurchaseOrderLine';
    EntitySetName = 'PurchaseOrderLines';
    EntityCaption = 'PurchaseOrderLine';
    EntitySetCaption = 'PurchaseOrderLines';
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
                field("Buy_from_Vendor_No"; Rec."Buy-from Vendor No.")
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
                field("Item_HS_Code"; Rec."Item HS Code")
                {
                    ApplicationArea = All;
                }
                field(Item_COO; Rec.Item_COO)
                {
                    ApplicationArea = All;
                }
                field(Item_short_name; Rec.Item_short_name)
                {
                    ApplicationArea = All;
                }
                field("Salesperson_Code"; Rec."Salesperson Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Base_UOM"; Rec."Base UOM")
                {
                    ApplicationArea = All;
                }
                field("Quantity_Base"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field(CustomETD; Rec.CustomETD)
                {
                    ApplicationArea = All;
                }
                field(CustomETA; Rec.CustomETA)
                {
                    ApplicationArea = All;
                }
                field(CustomR_ETD; Rec.CustomR_ETD)
                {
                    ApplicationArea = All;
                }
                field(CustomR_ETA; Rec.CustomR_ETA)
                {
                    ApplicationArea = All;
                }
                field("Quantity_Received"; Rec."Quantity Received")
                {
                    ApplicationArea = All;
                }
                field("Quantity_Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Qty_Received_Base"; Rec."Qty. Received (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty_Invoiced_Base"; Rec."Qty. Invoiced (Base)")
                {
                    ApplicationArea = All;
                }
            }

        }
    }
}
