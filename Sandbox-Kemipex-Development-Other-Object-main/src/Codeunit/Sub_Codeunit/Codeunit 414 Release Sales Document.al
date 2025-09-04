codeunit 50046 "Subscribe Codeunit 414"
{
    //T12539-NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnAfterManualReOpenSalesDoc, '', false, false)]
    local procedure "Release Sales Document_OnAfterManualReOpenSalesDoc"(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean)
    var
        MultiplePmtTerms_lRec: Record "Multiple Payment Terms";
    begin
        If SalesHeader."Document Type" = SalesHeader."Document Type"::Quote then
            exit;

        If SalesHeader.Status <> SalesHeader.Status::Released then begin
            MultiplePmtTerms_lRec.Reset();
            MultiplePmtTerms_lRec.SetRange(Type, MultiplePmtTerms_lRec.Type::Sales);
            MultiplePmtTerms_lRec.SetRange("Document No.", SalesHeader."No.");
            MultiplePmtTerms_lRec.SetRange("Document Type", SalesHeader."Document Type");
            If MultiplePmtTerms_lRec.FindSet() then
                repeat
                    MultiplePmtTerms_lRec.Released := false;
                    MultiplePmtTerms_lRec.Modify();
                until MultiplePmtTerms_lRec.Next() = 0;
        end;
    end;
    //T12539-NE

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", OnBeforeManualReOpenSalesDoc, '', false, false)]
    local procedure "Release Sales Document_OnBeforeManualReOpenSalesDoc"(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean)
    var
        SalesLine_lRec: Record "Sales Line";
        Allowed_lBol: Boolean;
    begin
        //T53497-NS
        If SalesHeader."Document Type" = SalesHeader."Document Type"::Quote then
            exit;

        If SalesHeader.Status <> SalesHeader.Status::open then begin

            SalesLine_lRec.reset;
            SalesLine_lRec.setRange("Document Type", SalesLine_lRec."Document Type"::Order);
            SalesLine_lRec.setRange("Document No.", SalesHeader."No.");
            SalesLine_lRec.setfilter(Quantity, '<>%1', 0);
            SalesLine_lRec.SetFilter("Quantity Shipped", '<>%1', 0);
            if SalesLine_lRec.findSet then begin
                Clear(Allowed_lBol);
                repeat
                    if SalesLine_lRec."Quantity Shipped" <> SalesLine_lRec."Quantity Invoiced" then
                        Allowed_lBol := true;
                until SalesLine_lRec.next() = 0;
                if Allowed_lBol = false then
                    Error('Not Allowed to change the status of this document. The document has been shipped and invoiced.');
            end;
        end;
        //T53497-NE
    end;

}