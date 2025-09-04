page 53045 APIReservationEntry//T12370-Full Comment//T50051 Code Uncommented
{
    ApplicationArea = All;
    Caption = 'LP - API Reservation Entry';
    PageType = API;
    SourceTable = "Reservation Entry";
    Permissions = tabledata "Reservation Entry" = R;
    DataCaptionFields = "Item No.";
    UsageCategory = History;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;

    // Powerautomate Category
    EntityName = 'ReservationEntry';
    EntitySetName = 'ReservationEntries';
    EntityCaption = 'ReservationEntry';
    EntitySetCaption = 'ReservationEntries';
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
                field("Location_Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Quantity_Base"; rec."Quantity (Base)")
                {
                    ApplicationArea = all;
                }
                field("Creation_Date"; rec."Creation Date")
                {
                    ApplicationArea = all;
                }
                field("Source_Type"; rec."Source Type")
                {
                    ApplicationArea = all;
                }
                field("Source_Subtype"; rec."Source Subtype")
                {
                    ApplicationArea = all;
                }

                field("Source_ID"; rec."Source ID")
                {
                    ApplicationArea = all;
                }
                field("Source_Ref_No"; rec."Source Ref. No.")
                {
                    ApplicationArea = all;
                }
                field("Item_Ledger_Entry_No"; rec."Item Ledger Entry No.")
                {
                    ApplicationArea = all;
                }
                field(Positive; rec.Positive)
                {
                    ApplicationArea = all;
                }
                field("Qty_per_Unit_of_Measure"; rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = all;
                }

                field("Appl_to_Item_Entry"; rec."Appl.-to Item Entry")
                {
                    ApplicationArea = all;
                }
                field("Appl_from_Item_Entry"; rec."Appl.-from Item Entry")
                {
                    ApplicationArea = all;
                }
                field("Expiration_Date"; rec."Expiration Date")
                {
                    ApplicationArea = all;
                }
                field("Qty_to_Handle_Base"; rec."Qty. to Handle (Base)")
                {
                    ApplicationArea = all;
                }
                field("Qty_to_Invoice_Base"; rec."Qty. to Invoice (Base)")
                {
                    ApplicationArea = all;
                }
                field("Quantity_Invoiced_Base"; rec."Quantity Invoiced (Base)")
                {
                    ApplicationArea = all;
                }
                field("Lot_No"; rec."Lot No.")
                {
                    ApplicationArea = all;
                }
                field("Variant_Code"; rec."Variant Code")
                {
                    ApplicationArea = all;
                }
                field(CustomBOENumber; rec.CustomBOENumber)
                {
                    ApplicationArea = all;
                }
                field(CustomLotNumber; rec.CustomLotNumber)
                {
                    ApplicationArea = all;
                }
                field("Off_Spec"; rec."Of Spec")
                {
                    ApplicationArea = all;
                }
                field("Analysis_Date"; rec."Analysis Date")
                {
                    ApplicationArea = all;
                }
                field("Supplier_Batch_No"; rec."Supplier Batch No. 2")
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
                field(SystemCreatedAt; rec.SystemCreatedAt)
                {
                    ApplicationArea = all;
                }
                field(SystemCreatedBy; rec.SystemCreatedBy)
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
