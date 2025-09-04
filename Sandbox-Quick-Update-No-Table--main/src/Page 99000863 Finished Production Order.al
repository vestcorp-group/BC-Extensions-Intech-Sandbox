pageextension 85654 FinishedProductionOrderExtVJ extends "Finished Production Order"
{
    Description = 'T51931';
    layout
    {

    }

    actions
    {
        addlast("O&rder")
        {
            action("Print Report")
            {
                Promoted = true;
                PromotedCategory = Report;
                ApplicationArea = All;
                Image = Print;
                trigger OnAction()
                var
                    FPOPrint_lRpt: Report "FPO Print";
                    ItemLedEntry_lRec: Record "Item Ledger Entry";
                begin
                    ItemLedEntry_lRec.Reset();
                    ItemLedEntry_lRec.SetRange("Order No.", Rec."No.");
                    FPOPrint_lRpt.SetTableView(ItemLedEntry_lRec);
                    FPOPrint_lRpt.Run();
                end;
            }
        }
    }

    var
        myInt: Integer;
}