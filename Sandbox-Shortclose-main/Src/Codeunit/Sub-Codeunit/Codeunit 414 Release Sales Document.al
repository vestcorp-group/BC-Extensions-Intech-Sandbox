codeunit 79653 ReleaseSOSubsc
{

    //T50307-NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnCodeOnBeforeSetStatusReleased', '', false, false)]
    local procedure "Release Sales Document_OnCodeOnBeforeSetStatusReleased"(var SalesHeader: Record "Sales Header")
    var
        SL_lRec: Record "Sales Line";
        ShortCloseFun_lCdu: Codeunit "Short Close Functionality";
        ShortCloseSetup: Record "Short Close Setup";
    begin
        if SalesHeader.IsTemporary then
            exit;

        if SalesHeader."Document Type" in [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::"Blanket Order", SalesHeader."Document Type"::"Return Order"] then begin //Anoop Hypercare-29-01-2025

            ShortCloseSetup.GET();
            if not ShortCloseSetup."Allow Sales Short Close" then begin
                Clear(SL_lRec);
                SL_lRec.SetRange("Document No.", SalesHeader."No.");
                SL_lRec.SetRange("Document Type", SalesHeader."Document Type");
                SL_lRec.SetRange("Short Close Approval Required", true);
                SL_lRec.Setfilter("Short Close Reason", '<>%1', '');//Hypercare-29-01-2025
                                                                    //SL_lRec.SetRange(Type, SL_lRec.Type::Item); ////Hypercare 27022025
                SL_lRec.SETFILTER(Type, '<>%1', SL_lRec.Type::" "); //Hypercare 27022025

                if SL_lRec.FindFirst() then
                    ShortCloseSetup.TestField("Allow Sales Short Close", true);
            end;

            Clear(SL_lRec);
            SL_lRec.SetRange("Document No.", SalesHeader."No.");
            SL_lRec.SetRange("Document Type", SalesHeader."Document Type");
            SL_lRec.SetRange("Short Close Approval Required", true);
            SL_lRec.Setfilter("Short Close Reason", '<>%1', '');//Hypercare-29-01-2025
                                                                // SL_lRec.SetRange(Type, SL_lRec.Type::Item); //Hypercare 27022025
            SL_lRec.SETFILTER(Type, '<>%1', SL_lRec.Type::" "); //Hypercare 27022025
            if SL_lRec.FindSet() then begin
                repeat
                    ShortCloseFun_lCdu.InsertSalesForeCloseLine_gFnc(SL_lRec, SalesHeader, false);
                until SL_lRec.Next() = 0;
            end;
        end;//Anoop Hypercare-29-01-2025
    end;
    //T50307-NE
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeTestStatusOpen', '', false, false)]
    local procedure "Purchase Line_OnBeforeTestStatusOpen"(var PurchaseLine: Record "Purchase Line"; var PurchaseHeader: Record "Purchase Header"; xPurchaseLine: Record "Purchase Line"; CallingFieldNo: Integer; var IsHandled: Boolean)
    begin
        if PurchaseHeader."ShortClose Approval" then
            IsHandled := true;
    end;

}