page 53040 APIItemLedgerEntries//T12370-Full Comment
{
    ApplicationArea = All;
    Caption = 'LP - API Item Ledger Entries';
    PageType = API;
    SourceTable = "Item Ledger Entry";
    Permissions = tabledata "Item Ledger Entry" = R;
    DataCaptionFields = "Document No.";
    UsageCategory = History;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;

    // Powerautomate Category
    EntityName = 'ItemLedgerEntry';
    EntitySetName = 'ItemLedgerEntries';
    EntityCaption = 'ItemLedgerEntry';
    EntitySetCaption = 'ItemLedgerEntries';
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
                field("Entry_No"; rec."Entry No.")
                {
                    ApplicationArea = all;
                }
                field("Item_No"; rec."Item No.")
                {
                    ApplicationArea = all;
                }
                field("Posting_Date"; rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Entry_Type"; rec."Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Source_No"; rec."Source No.")
                {
                    ApplicationArea = all;
                }
                field("Document_No"; rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Location_Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Invoiced_Quantity"; rec."Invoiced Quantity")
                {
                    ApplicationArea = all;
                }
                field("Remaining_Quantity"; rec."Remaining Quantity")
                {
                    ApplicationArea = all;
                }
                field("Source_Type"; rec."Source Type")
                {
                    ApplicationArea = all;
                }
                field("Drop_Shipment"; rec."Drop Shipment")
                {
                    ApplicationArea = all;
                }
                field("Document_Type"; rec."Document Type")
                {
                    ApplicationArea = all;
                }
                field("Variant_Code"; rec."Variant Code")
                {
                    ApplicationArea = all;
                }
                field("Qty_per_Unit_of_Measure"; rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = all;
                }
                field("Unit_of_Measure_Code"; rec."Unit of Measure Code")
                {
                    ApplicationArea = all;
                }
                field("Lot_No"; rec."Lot No.")
                {
                    ApplicationArea = all;
                }
                field(CustomLotNumber; rec.CustomLotNumber)
                {
                    ApplicationArea = all;
                }
                field(CustomBOENumber; rec.CustomBOENumber)
                {
                    ApplicationArea = all;
                }
                field("Expiration_Date"; rec."Expiration Date")
                {
                    ApplicationArea = all;
                }
                field("Manufacturing_Date"; rec."Manufacturing Date 2")
                {
                    ApplicationArea = all;
                }
                field("Expiry_Period"; rec."Expiry Period 2")
                {
                    ApplicationArea = all;
                }
                field("Analysis_Date"; rec."Analysis Date")
                {
                    ApplicationArea = all;
                }
                field("Off_Spec"; rec."Of Spec")
                {
                    ApplicationArea = all;
                }
                field("Item_Tracking"; rec."Item Tracking")
                {
                    ApplicationArea = all;
                }
            }

        }
    }
}
