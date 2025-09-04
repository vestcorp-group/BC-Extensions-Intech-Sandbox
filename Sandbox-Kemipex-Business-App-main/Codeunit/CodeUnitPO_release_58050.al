// codeunit 58050 PurchaseCodeunit//T12370-Full Comment
// {
//     EventSubscriberInstance = StaticAutomatic;
//     trigger OnRun()
//     begin
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforeManualReleasePurchaseDoc', '', true, true)]
//     local procedure ETDValidation(var PurchaseHeader: Record "Purchase Header")
//     var
//         Purch_line: Record "Purchase Line";
//     begin
//         Purch_line.SetRange("Document No.", PurchaseHeader."No.");
//         Purch_line.SetRange("Document Type", PurchaseHeader."Document Type");

//         if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
//             if Purch_line.FindSet() then
//                 repeat
//                     if (Purch_line.CustomETA = 0D) or (Purch_line.CustomETD = 0D) then Error('ETD and ETA must have values in purchase line');
//                 until Purch_line.Next() = 0;
//         end
//         else
//             exit;
//     end;
//     //Drop Shipment only released sales order control 
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Get Drop Shpt.", 'OnCodeOnBeforeSelectSalesHeader', '', true, true)]
//     local procedure SetreleasedSo(var SalesHeader: Record "Sales Header")
//     begin
//         SalesHeader.SetRange(Status, SalesHeader.Status::Released);
//     end;

//     [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAssignLotNoOnAfterInsert', '', true, true)]
//     local procedure MyProcedure(var TrackingSpecification: Record "Tracking Specification")
//     var
//         dvar: Text;
//         Curr_Month: Integer;

//     begin

//         //  Curr_Month := Date2DMY(WorkDate(), 2);
//         //   TrackingSpecification."Lot No." := Format(Curr_Month) + Format(TrackingSpecification."Lot No.");
//         //   if TrackingSpecification.Modify() then;

//     end;

//     [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterInsertEvent', '', true, true)]
//     local procedure ValidateManufacturingDate(var Rec: Record "Tracking Specification")
//     begin
//         Rec.Validate("Manufacturing Date 2");
//         Rec.Modify();
//     end;


//     [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnBeforeValidateEvent', 'New Custom Lot No.', true, true)]
//     local procedure ValidateModify(var Rec: Record "Reservation Entry")
//     begin
//         //  if Rec.FindSet() then;
//     end;

//     [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnBeforeClosePage', '', true, true)]
//     local procedure Debug(var TrackingSpecification: Record "Tracking Specification")
//     begin
//         // if TrackingSpecification.FindSet() then;
//     end;

// }