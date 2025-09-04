pageextension 50149 PurchOrderExt extends "Purchase Order"
{
    layout
    {
        //T48125-NS
        addafter("Buy-from Contact")
        {

            field("Est Payment Date 1"; Rec."Est Payment Date 1")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Est Payment Date 1 field.', Comment = '%';
            }
            field("Est Payment Date 2"; Rec."Est Payment Date 2")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Est Payment Date 2 field.', Comment = '%';
            }
            field("Est Payment Date 3"; Rec."Est Payment Date 3")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Est Payment Date 3 field.', Comment = '%';
            }
        }
        //T48125-NE
        addlast(General)
        {

            field("Consumable Exist"; Rec."Consumable Exist")
            {
                ApplicationArea = All;
                Description = 'T51983';
                Editable = false;
                ToolTip = 'Specifies the value of the Consumable Exist field.', Comment = '%';
            }
        }

    }

    actions
    {
        // Add changes to page actions here
        addlast(Print)
        {
            //Hypercare-06-03-2025-NS
            action("Print Purchase Order Single Location")
            {
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedCategory = Category10;
                trigger OnAction()
                var
                    PH_lRec: Record "Purchase Header";
                    _PurchaseOrderR3UAE_lRpt: Report "6_Purchase Order R3 UAE";
                begin
                    Commit();
                    PH_lRec.Reset();
                    PH_lRec.SetRange("Document Type", PH_lRec."Document Type"::Order);
                    PH_lRec.SetRange("No.", Rec."No.");
                    Clear(_PurchaseOrderR3UAE_lRpt);
                    _PurchaseOrderR3UAE_lRpt.SetTableView(PH_lRec);
                    _PurchaseOrderR3UAE_lRpt.RunModal();
                end;
            }
            //Hypercare-06-03-2025-NE
        }
    }
    //T51983-NS
    trigger OnAfterGetRecord()
    var
        PurchaseLine_lRec: Record "Purchase Line";
        Item_lRec: Record Item;
    begin
        Rec."Consumable Exist" := false;
        PurchaseLine_lRec.Reset();
        PurchaseLine_lRec.SetRange("Document Type", Rec."Document Type");
        PurchaseLine_lRec.SetRange("Document No.", Rec."No.");
        PurchaseLine_lRec.SetRange(Type, PurchaseLine_lRec.Type::Item);
        if PurchaseLine_lRec.FindSet() then
            repeat
                if Item_lRec.Get(PurchaseLine_lRec."No.") then begin
                    if Item_lRec."Inventory Posting Group" = 'CONSUMABLE' then begin
                        Rec."Consumable Exist" := true;
                        Rec.Modify();
                        Commit();
                    end;
                end;
            until PurchaseLine_lRec.Next() = 0;
    end;
    //T51983-NE

    var
        myInt: Integer;
}