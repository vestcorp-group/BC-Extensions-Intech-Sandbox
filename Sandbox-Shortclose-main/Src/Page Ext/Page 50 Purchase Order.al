pageextension 79648 PurchaseOrderExt_50007 extends "Purchase Order"
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
            field("Completely Received"; Rec."Completely Received")
            {
                ApplicationArea = All;
                // Visible = SalesFieldVisibility_gBln;
            }
            //T12084-NE
            //T50306-NS-NB
            field("ShortClose Approval"; rec."ShortClose Approval")
            {
                ApplicationArea = all;
                Caption = 'Short Close Approval';
                Editable = false;
            }
        }
    }
    actions
    {
        addlast("F&unctions")
        {
            //T12084-NS
            action("ShortClose Purchase Order")
            {
                ApplicationArea = All;
                Caption = 'Short Close Purchase Order';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Short Close Purchase Order action.';
                // Visible = SalesFieldVisibility_gBln;
                trigger OnAction()
                var
                    ShortCloseFunctionality_lCdu: Codeunit "Short Close Functionality";
                    
                begin
                  //  rec."ShortClose Approval" := true;//T50306
                    //rec.Modify();
                    //   ShortCloseFunctionality_lCdu.ForeCLosePurchaseDocument(Rec);
                end;
            }
            //T12084-NE
        }
    }
}
