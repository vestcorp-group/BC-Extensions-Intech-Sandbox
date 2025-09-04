codeunit 79654 ReleasePurchaseDocument
{
    //T50306-NS-NB
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterReleasePurchaseDoc', '', false, false)]
    local procedure "Release Sales Document_OnCodeOnBeforeSetStatusReleased"(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; var LinesWereModified: Boolean; SkipWhseRequestOperations: Boolean)
    var
        PurchaseLine_lRec: Record "Purchase Line";
        ShortCloseFun_lCdu: Codeunit "Short Close Functionality";
        ShortCloseSetup: Record "Short Close Setup";
    begin
        if PurchaseHeader.IsTemporary then
            exit;
        //Anoop Hypercare-29-01-2025 NS   
        if not (PurchaseHeader."Document Type" in
        [PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::"Blanket Order", PurchaseHeader."Document Type"::"Return Order"]) then
            exit;
        //Anoop Hypercare-29-01-2025 NE
        If not PurchaseHeader."ShortClose Approval" then
            exit;
        ShortCloseSetup.GET();
        if not ShortCloseSetup."Allow Purchase Short Close" then begin
            Clear(PurchaseLine_lRec);
            PurchaseLine_lRec.SetRange("Document No.", PurchaseHeader."No.");
            PurchaseLine_lRec.SetRange("Document Type", PurchaseHeader."Document Type");
            PurchaseLine_lRec.SetFilter("Outstanding Quantity", '<>%1', 0); //Hypercare 27022025
                                                                            //Hypercare 27022025
            PurchaseLine_lRec.SetRange("Short Close Approval Required", true);
            PurchaseLine_lRec.SetFilter("Short Close Reason", '<>%1', '');//Hypercare Anoop 29-01-2025
            //Hypercare 27022025
            // PurchaseLine_lRec.SetRange(Type, PurchaseLine_lRec.Type::Item);//Hypercare 27022025
            PurchaseLine_lRec.SETFILTER(Type, '<>%1', PurchaseLine_lRec.Type::" "); //Hypercare 27022025
            if PurchaseLine_lRec.FindFirst() then
                ShortCloseSetup.TestField("Allow Purchase Short Close", true);
        end;

        Clear(PurchaseLine_lRec);
        PurchaseLine_lRec.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine_lRec.SetRange("Document Type", PurchaseHeader."Document Type");
        // PurchaseLine_lRec.SetRange("Short Close Approval Required", true);
        //PurchaseLine_lRec.SetFilter("Short Close Reason", '<>%1', '');//Hypercare Anoop 29-01-2025
        PurchaseLine_lRec.SetFilter("Outstanding Quantity", '<>%1', 0);
        // PurchaseLine_lRec.SetRange(Type, PurchaseLine_lRec.Type::Item);//Hypercare 27022025
        PurchaseLine_lRec.SETFILTER(Type, '<>%1', PurchaseLine_lRec.Type::" "); //Hypercare 27022025
        if PurchaseLine_lRec.FindSet() then begin
            repeat
                ShortCloseFun_lCdu.InsertPurchaeForeCloseLine_gFnc(PurchaseLine_lRec);
            until PurchaseLine_lRec.Next() = 0;
        end;
    end;
    //T50306-NE-NB
}