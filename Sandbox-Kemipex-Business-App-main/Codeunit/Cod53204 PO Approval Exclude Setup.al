// codeunit 53204 "PO Approval Exclude Setup"//T12370-Full Comment
// {
//     trigger OnRun()
//     begin

//     end;

//     [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeTestStatusOpen', '', true, true)]
//     local procedure OnBeforeTestStatusOpen(var PurchHeader: Record "Purchase Header"; xPurchHeader: Record "Purchase Header"; CallingFieldNo: Integer)
//     var
//         StatusCheckSuspended: Boolean;
//         WorkFlowAppSetup: Record "PO Approval Field Incl. Setup";
//         CustomUserSetup: Record "Custom User Setup";
//     begin
//         if PurchHeader."Document Type" = PurchHeader."Document Type"::Order then begin
//             if (PurchHeader.Status = PurchHeader.Status::Released) then begin
//                 if CustomUserSetup.Get(UserId) then begin
//                     if CustomUserSetup."Allow PO Modification" then begin
//                         WorkFlowAppSetup.Reset();
//                         //Purchase Order check
//                         WorkFlowAppSetup.SetRange(TableNo, 38);
//                         WorkFlowAppSetup.SetRange("No.", CallingFieldNo);
//                         WorkFlowAppSetup.SetRange("Approval Document Type", WorkFlowAppSetup."Approval Document Type"::Order);
//                         if NOT WorkFlowAppSetup.FindFirst() then
//                             PurchHeader.SuspendStatusCheck(true)
//                         else
//                             PurchHeader.SuspendStatusCheck(false);
//                     end;
//                 end;
//             end;
//         end;
//     end;


//     [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeTestStatusOpen', '', true, true)]
//     local procedure OnBeforeTestStatusOpenLine(var PurchaseLine: Record "Purchase Line"; var PurchaseHeader: Record "Purchase Header"; xPurchaseLine: Record "Purchase Line"; CallingFieldNo: Integer; var IsHandled: Boolean)
//     var
//         StatusCheckSuspended: Boolean;
//         WorkFlowAppSetup: Record "PO Approval Field Incl. Setup";
//         CustomUserSetup: Record "Custom User Setup";
//     begin
//         if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
//             if PurchaseHeader.Status = PurchaseHeader.Status::Released then begin
//                 if CustomUserSetup.Get(UserId) then begin
//                     if CustomUserSetup."Allow PO Modification" then begin
//                         WorkFlowAppSetup.Reset();
//                         //Purchase Order check
//                         WorkFlowAppSetup.SetRange(TableNo, 39);
//                         WorkFlowAppSetup.SetRange("No.", CallingFieldNo);
//                         WorkFlowAppSetup.SetRange("Approval Document Type", WorkFlowAppSetup."Approval Document Type"::Order);
//                         if NOT WorkFlowAppSetup.FindFirst() then
//                             PurchaseLine.SuspendStatusCheck(true)
//                         else
//                             PurchaseLine.SuspendStatusCheck(false);
//                     end;
//                 end;
//             end;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnCodeOnBeforeModifyHeader', '', true, true)]
//     local procedure OnCodeOnBeforeModifyHeader(var PurchaseHeader: Record "Purchase Header"; var PurchaseLine: Record "Purchase Line"; PreviewMode: Boolean; var LinesWereModified: Boolean)
//     var
//         PurchLine: Record "Purchase Line";
//         PurchLineAmt: Decimal;
//     begin
//         if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
//             PurchaseHeader."Last Approved Amount" := 0;
//             PurchLine.SetRange("Document Type", PurchaseLine."Document Type");
//             PurchLine.SetRange("Document No.", PurchaseLine."Document No.");
//             if PurchLine.FindFirst() then
//                 repeat
//                     PurchLineAmt := PurchLineAmt + PurchLine."Line Amount";
//                 until PurchLine.Next() = 0;
//             PurchaseHeader."Last Approved Amount" := PurchLineAmt;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendPurchaseDocForApproval', '', true, true)]

//     procedure OnSendPurchaseDocForApproval(var PurchaseHeader: Record "Purchase Header")
//     var
//         PurchLine: Record "Purchase Line";
//         CurrentAmount: Decimal;
//         AmountwithTolerance: Decimal;
//         PurchPaySetup: Record "Purchases & Payables Setup";
//         AmountErrorLbl: TextConst ENU = 'Current Amount %1 is exceeding previous approved amount %2. Maximum amount availabe for approval including tolerance is %3.';
//     begin
//         if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
//             PurchPaySetup.Get();
//             if PurchaseHeader.Status = PurchaseHeader.Status::Released then begin
//                 if PurchaseHeader."Last Approved Amount" <> 0 then begin
//                     if PurchPaySetup."Purchase Order Tolerance %" <> 0 then begin
//                         PurchLine.SetRange("Document Type", PurchaseHeader."Document Type");
//                         PurchLine.SetRange("Document No.", PurchaseHeader."No.");
//                         if PurchLine.FindFirst() then
//                             repeat
//                                 CurrentAmount += PurchLine."Line Amount";
//                             until PurchLine.Next() = 0;

//                         AmountwithTolerance := (PurchaseHeader."Last Approved Amount" * PurchPaySetup."Purchase Order Tolerance %" / 100);
//                         if CurrentAmount > AmountwithTolerance then
//                             Error(AmountErrorLbl, CurrentAmount, PurchaseHeader."Last Approved Amount", AmountwithTolerance);

//                     end;
//                 end;
//             end;
//         end;
//     end;

//     var
//         myInt: Integer;
// }