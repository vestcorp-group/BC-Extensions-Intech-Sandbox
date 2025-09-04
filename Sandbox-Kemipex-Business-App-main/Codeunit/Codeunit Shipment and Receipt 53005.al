// codeunit 53005 "Shipment and Receipt"//T12370-Full Comment
// {
//     [EventSubscriber(ObjectType::Codeunit, 81, 'OnBeforeOnRun', '', true, true)]

//     local procedure OnBeforeOnRunSalesHeader(var SalesHeader: Record "Sales Header")
//     var
//         SalesSetup: Record "Sales & Receivables Setup";
//         Text001: Label 'Only document with released status is allowed for posting.';
//     begin
//         SalesSetup.Get();
//         if SalesSetup."Rel. Mand. for posting orders" then begin
//             if SalesHeader.Status <> SalesHeader.Status::Released then
//                 Error(Text001);
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, 5815, 'OnBeforeOnRun', '', true, true)]
//     Procedure OnBeforeOnRunSalesShipment(var SalesShipmentLine: Record "Sales Shipment Line"; var IsHandled: Boolean; var SkipTypeCheck: Boolean; var HideDialog: Boolean)
//     var
//         CustomUserSetup: Record "Custom User Setup";
//         Text000: Label 'You are not authorised to undo!.';
//     begin
//         if CustomUserSetup.get(UserId) then begin
//             if not CustomUserSetup."Undo Sales Shipment" then
//                 Error(Text000);
//         end else begin
//             Error(Text000);
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, 5813, 'OnBeforeOnRun', '', true, true)]
//     procedure OnBeforeOnRunPurchaseReceipt(var PurchRcptLine: Record "Purch. Rcpt. Line"; var IsHandled: Boolean; var SkipTypeCheck: Boolean; var HideDialog: Boolean)
//     var
//         CustomUserSetup: Record "Custom User Setup";
//         Text000: Label 'You are not authorised to undo!.';
//     begin
//         if CustomUserSetup.get(UserId) then begin
//             if not CustomUserSetup."Undo Purchase Receipt" then
//                 Error(Text000);
//         end else begin
//             Error(Text000);
//         end;
//     end;

// }