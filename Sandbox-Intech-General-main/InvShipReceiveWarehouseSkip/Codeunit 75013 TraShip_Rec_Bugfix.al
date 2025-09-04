codeunit 75013 TraShip_Rec_Bugfix_75013
{
    //InvShipRec-NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Invt. Doc.-Post Receipt", 'OnBeforeOnRun', '', false, false)]
    local procedure OnBeforeOnRun_Recpt(var InvtDocumentHeader: Record "Invt. Document Header"; var SuppressCommit: Boolean; var HideProgressWindow: Boolean);
    begin
        SuppressCommit := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Invt. Doc.-Post Shipment", 'OnBeforeOnRun', '', false, false)]
    local procedure OnBeforeOnRun_Ship(var InvtDocumentHeader: Record "Invt. Document Header"; var SuppressCommit: Boolean; var HideProgressWindow: Boolean);
    begin
        SuppressCommit := true;
    end;
    //InvShipRec-NE

}
