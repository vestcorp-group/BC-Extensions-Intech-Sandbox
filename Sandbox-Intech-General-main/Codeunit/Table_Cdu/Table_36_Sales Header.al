Codeunit 75006 Subscribe_Table_36_IntGen
{


    trigger OnRun()
    begin
    end;

    //InvCalStatistics-NS 221222

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeOpenDocumentStatistics', '', false, false)]
    local procedure OnBeforeOpenSalesDocumentStatistics(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean);
    var
        FilterSL_lRec: Record "Sales Line";
    begin
        FilterSL_lRec.Reset();
        FilterSL_lRec.Setrange("Document No.", SalesHeader."No.");
        FilterSL_lRec.Setrange("Document Type", SalesHeader."Document Type");
        IF FilterSL_lRec.FindLast() Then
            CODEUNIT.Run(CODEUNIT::"Sales-Calc. Discount", FilterSL_lRec);
    end;
    //InvCalStatistics-NE 221222


}

