page 50367 "Warehouse Delivery Inst List"//T12370-Full Comment
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = History;
    Caption = 'Warehouse Delivery Instruction List';
    SourceTable = "Warehouse Delivery Inst Header";
    Editable = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    CardPageId = "Warehouse Delivery Instruction";
    DataCaptionFields = "WDI No", "Location Code";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("WDI No"; rec."WDI No")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                }
                field("WDI Date"; rec."WDI Date")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Blanket Order No."; rec."Blanket Order No.")
                {
                    ApplicationArea = all;
                }
                field("Order No."; rec."Order No.")
                {
                    ApplicationArea = all;
                }
                field("Sales Shipment No."; rec."Sales Shipment No.")
                {
                    ApplicationArea = all;
                }
                field("Bill to Customer Code"; rec."Bill-to Customer Code")
                {
                    ApplicationArea = all;
                }
                field("Customer Name"; rec."Bill-to Customer Name")
                {
                    ApplicationArea = all;
                }
                field("Ship to Customer Code"; rec."Ship-to Customer Code")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}