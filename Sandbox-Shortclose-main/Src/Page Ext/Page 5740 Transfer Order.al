pageextension 79650 TransferOrderExt_50009 extends "Transfer Order"
{
    layout
    {
        addlast(General)
        {
            //T12084-NS
            field("Short Close Boolean"; Rec."Short Close Boolean")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Short Close Boolean field.';
                // Visible = SalesFieldVisibility_gBln;
            }
            field("Short Close Reason"; Rec."Short Close Reason")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Short Close Reason field.';
                // Visible = SalesFieldVisibility_gBln;
            }
            field("Completely Shipped"; Rec."Completely Shipped")
            {
                ApplicationArea = All;
                // ToolTip = 'Specifies the value of the Short Close Reason field.';
                // Visible = SalesFieldVisibility_gBln;
            }
            field("Completely Received"; Rec."Completely Received")
            {
                ApplicationArea = All;
                // ToolTip = 'Specifies the value of the Short Close Reason field.';
                // Visible = SalesFieldVisibility_gBln;
            }
            //T12084-NE
        }
    }
    actions
    {
        addlast("F&unctions")
        {
            //T12084-NS
            action("ShortClose Transfer Order")
            {
                ApplicationArea = All;
                Caption = 'Short Close Transfer Order';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Short Close Transfer Order action.';
                // Visible = SalesFieldVisibility_gBln;
                trigger OnAction()
                var
                    ShortCloseFunctionality_lCdu: Codeunit "Short Close Functionality";
                begin
                    ShortCloseFunctionality_lCdu.ForeCLoseTransferDocument(Rec);
                end;
            }
            //T12084-NE
        }
    }
}
