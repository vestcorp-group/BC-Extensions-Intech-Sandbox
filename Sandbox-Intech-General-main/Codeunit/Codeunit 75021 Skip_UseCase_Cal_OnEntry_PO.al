Codeunit 75021 "Skip_UseCase_Cal_OnEntry_PO"
{    //TaxEngine-Optimization


    //Quantity
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeValidateEvent', 'Quantity', true, true)]
    local procedure "Sales Line_OnBeforeValidateEvent_Quantity"
(
    var Rec: Record "Purchase Line";
    var xRec: Record "Purchase Line";
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



    [EventSubscriber(ObjectType::Page, Page::"Purchase Order Subform", 'OnAfterValidateEvent', 'Quantity', true, true)]
    local procedure "Sales Order Subform_OnAfterValidateEvent_[content / Control1] - No."(var Rec: Record "Purchase Line")
    begin
        Skip_UseCase_Calculation_SI_gCdu.SetSkipCal_gFnc(false);
    end;




    //Unit Price
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeValidateEvent', 'Direct Unit Cost', true, true)]
    local procedure "Sales Line_OnBeforeValidateEvent_UnitPrice"
(
   var Rec: Record "Purchase Line";
   var xRec: Record "Purchase Line";
   CurrFieldNo: Integer
)
    begin
        IF Rec.IsTemporary then
            Exit;

        IF CurrFieldNo = 0 then
            Exit;

        IF CurrFieldNo = Rec.FieldNo("Direct Unit Cost") Then
            Skip_UseCase_Calculation_SI_gCdu.SetSkipCal_gFnc(TRUE);
    end;



    [EventSubscriber(ObjectType::Page, Page::"Purchase Order Subform", 'OnAfterValidateEvent', 'Direct Unit Cost', true, true)]
    local procedure "Sales Order Subform_OnAfterValidateEvent_[content / Control1] - Unit Price"(var Rec: Record "Purchase Line")
    begin
        Skip_UseCase_Calculation_SI_gCdu.SetSkipCal_gFnc(false);
    end;

    //Line Discount %s
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeValidateEvent', 'Line Discount %', true, true)]
    local procedure "Sales Line_OnBeforeValidateEvent_LineDiscount%"
(
   var Rec: Record "Purchase Line";
   var xRec: Record "Purchase Line";
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



    [EventSubscriber(ObjectType::Page, Page::"Purchase Order Subform", 'OnAfterValidateEvent', 'Line Discount %', true, true)]
    local procedure "Sales Order Subform_OnAfterValidateEvent_[content / Control1Line Discount %"(var Rec: Record "Purchase Line")
    begin
        Skip_UseCase_Calculation_SI_gCdu.SetSkipCal_gFnc(false);
    end;


    //Line Amount
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeValidateEvent', 'Line Amount', true, true)]
    local procedure "Sales Line_OnBeforeValidateEvent_LineAmount"
(
   var Rec: Record "Purchase Line";
   var xRec: Record "Purchase Line";
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



    [EventSubscriber(ObjectType::Page, Page::"Purchase Order Subform", 'OnAfterValidateEvent', 'Line Amount', true, true)]
    local procedure "Sales Order Subform_OnAfterValidateEvent_[content / Control1Line Amount"(var Rec: Record "Purchase Line")
    begin
        Skip_UseCase_Calculation_SI_gCdu.SetSkipCal_gFnc(false);
    end;


    var
        Skip_UseCase_Calculation_SI_gCdu: Codeunit Purchase_SKip_TaxEngine_SI;

    //T35424-NE
}

