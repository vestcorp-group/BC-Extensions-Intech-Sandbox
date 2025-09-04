Codeunit 75005 Subscribe_Table_38_IntGen
{


    trigger OnRun()
    begin
    end;

    //InvCalStatistics-NS 221222
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeOpenDocumentStatistics', '', false, false)]
    local procedure OnBeforeOpenPurchDocumentStatistics(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean);
    var
        FilterPL_lRec: Record "Purchase Line";
    begin
        FilterPL_lRec.Reset();
        FilterPL_lRec.Setrange("Document No.", PurchaseHeader."No.");
        FilterPL_lRec.Setrange("Document Type", PurchaseHeader."Document Type");
        IF FilterPL_lRec.FindLast() Then
            CODEUNIT.Run(CODEUNIT::"Purch.-Calc.Discount", FilterPL_lRec);
    end;
    //InvCalStatistics-NE 221222
}

