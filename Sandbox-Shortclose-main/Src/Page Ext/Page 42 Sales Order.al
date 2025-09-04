pageextension 79647 SalesOrderExt_50005 extends "Sales Order"
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
            //T12084-NE
            field("Short Close Approval Required"; Rec."Short Close Approval Required")
            {
                ApplicationArea = All;
                Description = 'T50307';
            }
        }
    }
    actions
    {
        addlast("F&unctions")
        {
            //T12084-NS
            action("ShortClose Sales Order")
            {
                ApplicationArea = All;
                Caption = 'Short Close Sales Order';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Short Close Sales Order action.';
                // Visible = SalesFieldVisibility_gBln;
                trigger OnAction()
                var
                    ShortCloseFunctionality_lCdu: Codeunit "Short Close Functionality";
                begin
                    //ShortCloseFunctionality_lCdu.ForeCLoseSalesDocument(Rec);     //T50307-O
                    ShortCloseFunctionality_lCdu.SetApprovalReqSalesDocument_gFnc(Rec);  //T50307-N
                end;
            }
            //T12084-NE         

        }
    }
}
