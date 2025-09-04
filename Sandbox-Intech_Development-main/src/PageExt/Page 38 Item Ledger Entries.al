pageextension 50124 "Item Ledger Entries Ext" extends "Item Ledger Entries"
{
    layout
    {
        // addafter("Cost Amount (Actual)")
        // {
        //     field("Cost Amount (Expected)"; Rec."Cost Amount (Expected)")
        //     {
        //         ApplicationArea = All;
        //         Description = 'T50324';
        //     }
        // }
        addafter("Remaining Quantity")
        {

            field("Inbound Quantity"; Rec."Inbound Quantity")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Inbound Quantity field.', Comment = '%';
            }
            field("FPO No."; Rec."FPO No.")
            {
                ApplicationArea = All;
                Description = 'T51982';
                ToolTip = 'Specifies the value of the FPO No. field.', Comment = '%';
            }
        }
    }
    actions
    {
        addlast("F&unctions")
        {
            action("Export ILE")
            {
                ApplicationArea = All;
                Description = 'T50324';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Export;
                trigger OnAction()
                var
                    ExpData_lRpt: Report "Item Ledger Export to Excel";
                begin
                    Clear(ExpData_lRpt);
                    ExpData_lRpt.Run();
                end;
            }
        }
    }
}
