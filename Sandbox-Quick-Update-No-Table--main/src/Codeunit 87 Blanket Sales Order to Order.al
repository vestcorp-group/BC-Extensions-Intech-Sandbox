codeunit 85657 Codeunit_87_Sub
{
    //T53498-NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", OnAfterRun, '', false, false)]
    local procedure "Blanket Sales Order to Order_OnAfterRun"(var SalesHeader: Record "Sales Header"; var SalesOrderHeader: Record "Sales Header")
    begin
        SalesOrderHeader.Status := SalesOrderHeader.Status::Released;
        SalesOrderHeader.Modify(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", OnBeforeRun, '', false, false)]
    local procedure "Blanket Sales Order to Order_OnBeforeRun"(var SalesHeader: Record "Sales Header"; var HideValidationDialog: Boolean; var SuppressCommit: Boolean)
    begin
        if SalesHeader."Document Type" = salesHeader."Document Type"::"Blanket Order" then
            SalesHeader.TestField(Status, SalesHeader.Status::Released);
    end;

    //T53498-NE
}