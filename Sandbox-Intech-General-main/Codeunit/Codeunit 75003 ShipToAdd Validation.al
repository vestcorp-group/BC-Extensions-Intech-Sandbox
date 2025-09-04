Codeunit 75003 ShipToAdd_Validation
{
    //T32682-New Codeunit

    trigger OnRun()
    begin
    end;

    procedure ValidateShipToAdd_gFnc(ShipToAdd_lRec: Record "Ship-to Address")
    var
        GSTBaseVal_lCdu: Codeunit "GST Base Validation";
    begin
        ShipToAdd_lRec.TestField(State);
        ShipToAdd_lRec.TestField(Address);
        GSTBaseVal_lCdu.CheckGSTRegistrationNo(ShipToAdd_lRec.State, ShipToAdd_lRec."GST Registration No.", '');
    end;

}

