pageextension 85202 "Finished Prod Order" extends "Finished Production Order"
{
    actions
    {
        addafter("E&ntries")
        {
            action("Re-Open Production Order")
            {
                ApplicationArea = Basic;
                Caption = 'Re-Open Production Order';
                Image = ReopenPeriod;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = ReOpenProdOrderVisible_gBln;

                trigger OnAction()
                var
                    userSetup_lRec: Record "User Setup";
                    ProdOrder_lRec: Record "Production Order";
                    ReOpenProdOrder_lCdu: Codeunit "Re-Open Production Order";
                begin
                    //ReOpenPrOrd-NS
                    userSetup_lRec.Get(UserId);
                    userSetup_lRec.TestField(userSetup_lRec."Allow to Re-Open Prod Order.", true);

                    CurrPage.SetSelectionFilter(ProdOrder_lRec);
                    Clear(ReOpenProdOrder_lCdu);
                    ReOpenProdOrder_lCdu.LoopProdOrder_gFnc(Rec);
                    CurrPage.Update;
                    //ReOpenPrOrd-NE
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        UserSetup_lRec: Record 91;
    begin
        //ReOpenPrOrd-NS
        UserSetup_lRec.GET(USERID);
        ReOpenProdOrderVisible_gBln := UserSetup_lRec."Allow to Re-Open Prod Order."
        //ReOpenPrOrd-NE
    end;

    var
        UserSetup_lRec: Record "User Setup";
        ReOpenProdOrderVisible_gBln: Boolean;
}
