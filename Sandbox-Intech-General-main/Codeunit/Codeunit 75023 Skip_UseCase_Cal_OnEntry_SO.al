Codeunit 75023 "Skip_UseCase_Cal_OnEntry_SO"
{    //TaxEngine-Optimization


    //Quantity
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateEvent', 'Quantity', true, true)]
    local procedure "Sales Line_OnBeforeValidateEvent_Quantity"
(
    var Rec: Record "Sales Line";
    var xRec: Record "Sales Line";
    CurrFieldNo: Integer
)
    begin
        IF Rec.IsTemporary then
            Exit;

        IF CurrFieldNo = 0 then
            Exit;

        IF CurrFieldNo = Rec.FieldNo(Quantity) Then
            Skip_UseCase_Calculation_SI_gCdu.SetSkipCal_gFnc(TRUE);
    end;



    [EventSubscriber(ObjectType::Page, Page::"Sales Order Subform", 'OnAfterValidateEvent', 'Quantity', true, true)]
    local procedure "Sales Order Subform_OnAfterValidateEvent_[content / Control1] - No."(var Rec: Record "Sales Line")
    begin
        Skip_UseCase_Calculation_SI_gCdu.SetSkipCal_gFnc(false);
    end;




    //Unit Price
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateEvent', 'Unit Price', true, true)]
    local procedure "Sales Line_OnBeforeValidateEvent_UnitPrice"
(
   var Rec: Record "Sales Line";
   var xRec: Record "Sales Line";
   CurrFieldNo: Integer
)
    begin
        IF Rec.IsTemporary then
            Exit;

        IF CurrFieldNo = 0 then
            Exit;

        IF CurrFieldNo = Rec.FieldNo("Unit Price") Then
            Skip_UseCase_Calculation_SI_gCdu.SetSkipCal_gFnc(TRUE);
    end;



    [EventSubscriber(ObjectType::Page, Page::"Sales Order Subform", 'OnAfterValidateEvent', 'Unit Price', true, true)]
    local procedure "Sales Order Subform_OnAfterValidateEvent_[content / Control1] - Unit Price"(var Rec: Record "Sales Line")
    begin
        Skip_UseCase_Calculation_SI_gCdu.SetSkipCal_gFnc(false);
    end;

    //Line Discount %s
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateEvent', 'Line Discount %', true, true)]
    local procedure "Sales Line_OnBeforeValidateEvent_LineDiscount%"
(
   var Rec: Record "Sales Line";
   var xRec: Record "Sales Line";
   CurrFieldNo: Integer
)
    begin
        IF Rec.IsTemporary then
            Exit;

        IF CurrFieldNo = 0 then
            Exit;

        IF CurrFieldNo = Rec.FieldNo("Line Discount %") Then
            Skip_UseCase_Calculation_SI_gCdu.SetSkipCal_gFnc(TRUE);
    end;



    [EventSubscriber(ObjectType::Page, Page::"Sales Order Subform", 'OnAfterValidateEvent', 'Line Discount %', true, true)]
    local procedure "Sales Order Subform_OnAfterValidateEvent_[content / Control1Line Discount %"(var Rec: Record "Sales Line")
    begin
        Skip_UseCase_Calculation_SI_gCdu.SetSkipCal_gFnc(false);
    end;


    //Line Amount
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateEvent', 'Line Amount', true, true)]
    local procedure "Sales Line_OnBeforeValidateEvent_LineAmount"
(
   var Rec: Record "Sales Line";
   var xRec: Record "Sales Line";
   CurrFieldNo: Integer
)
    begin
        IF Rec.IsTemporary then
            Exit;

        IF CurrFieldNo = 0 then
            Exit;

        IF CurrFieldNo = Rec.FieldNo("Line Amount") Then
            Skip_UseCase_Calculation_SI_gCdu.SetSkipCal_gFnc(TRUE);
    end;



    [EventSubscriber(ObjectType::Page, Page::"Sales Order Subform", 'OnAfterValidateEvent', 'Line Amount', true, true)]
    local procedure "Sales Order Subform_OnAfterValidateEvent_[content / Control1Line Amount"(var Rec: Record "Sales Line")
    begin
        Skip_UseCase_Calculation_SI_gCdu.SetSkipCal_gFnc(false);
    end;


    var
        Skip_UseCase_Calculation_SI_gCdu: Codeunit Sales_SKip_TaxEngine_SI;

    //T35424-NE
}

