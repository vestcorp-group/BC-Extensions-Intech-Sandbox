codeunit 85658 Codeunit_97_Sub
{
    //T53498-NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Purch. Order to Order", OnAfterRun, '', false, false)]
    local procedure "Blanket Purch. Order to Order_OnAfterRun"(var PurchaseHeader: Record "Purchase Header"; var PurchOrderHeader: Record "Purchase Header")
    begin
        PurchOrderHeader.Status := PurchOrderHeader.Status::Released;
        PurchOrderHeader.Modify(true);
    end;


    //T53498-NE
}