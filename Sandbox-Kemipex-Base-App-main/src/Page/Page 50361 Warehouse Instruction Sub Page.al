page 50361 "Warehouse Instruction Sub Page"//T12370-Full Comment
{
    Caption = 'Warehouse Instruction Line';
    PageType = ListPart;
    SourceTable = "Sales Shipment Line";
    UsageCategory = Administration;
    Permissions = tabledata 111 = rm;
    // ApplicationArea = all;
    Editable = true;
    InsertAllowed = false;
    DeleteAllowed = true;
    // ModifyAllowed = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                //PackingListExtChange
                field("Base UOM"; Rec."Base UOM 2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Stencil; rec.Stencil)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Relabel; Rec.Relabel)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("3P Inspection"; Rec."Inspection")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
            }
        }
    }
}
