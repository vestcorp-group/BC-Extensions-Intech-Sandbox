// codeunit 50600 "Sales Line Subscirbers"//T12370-Full Comment
// {
//     [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnAfterUpdateAmountsDone', '', false, false)]
//     local procedure OnAfterUpdateAmountsDone(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; CurrentFieldNo: Integer)
//     var
//         grossProfit: Decimal;
//     begin
//         //include discounts
//         grossProfit := SalesLine."Unit Price" - SalesLine."Unit Cost";
//         if (grossProfit <> 0) and (SalesLine."Unit Price" <> 0) then
//             SalesLine."Profit % IC" := (grossProfit / SalesLine."Unit Price") * 100
//         else
//             SalesLine."Profit % IC" := 0
//     end;

//     //update this to calculate just before they ship it it might be a problem so if they come back with saying the amount gets updated automaitcly its becuase they asked for it
//     [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post (Yes/No)", 'OnBeforeConfirmSalesPost', '', false, false)]
//     local procedure OnBeforeConfirmSalesPost(var SalesHeader: Record "Sales Header"; var HideDialog: Boolean; var IsHandled: Boolean; var DefaultOption: Integer; var PostAndSend: Boolean)
//     var
//         grossProfit: Decimal;
//         SalesLine: Record "Sales Line";
//     begin
//         //include discounts
//         SalesLine.Reset();
//         SalesLine.SetFilter("Document Type", '%1', SalesHeader."Document Type");
//         SalesLine.SetFilter("Document No.", '%1', SalesHeader."No.");
//         if SalesLine.FindSet(true) then
//             repeat
//                 grossProfit := 0;
//                 grossProfit := SalesLine."Unit Price" - SalesLine."Unit Cost";
//                 if (grossProfit <> 0) and (SalesLine."Unit Price" <> 0) then begin
//                     SalesLine."Profit % IC" := (grossProfit / SalesLine."Unit Price") * 100;
//                     SalesLine.Modify();
//                 end else begin
//                     SalesLine."Profit % IC" := 0;
//                     SalesLine.Modify();
//                 end;

//             // SalesLine."Profit % IC" := 2.92;
//             // SalesLine.Modify();
//             until SalesLine.Next() = 0;
//     end;


//     [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnAfterICInboxPurchLineInsert', '', false, false)]
//     local procedure OnAfterICInboxPurchLineInsert(var ICInboxPurchaseLine: Record "IC Inbox Purchase Line"; ICOutboxSalesLine: Record "IC Outbox Sales Line")
//     begin
//         ICInboxPurchaseLine."Profit % IC" := ICOutboxSalesLine."Profit % IC";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnAfterICInboxSalesLineInsert', '', false, false)]
//     local procedure OnAfterICInboxSalesLineInsert(var ICInboxSalesLine: Record "IC Inbox Sales Line"; ICOutboxPurchaseLine: Record "IC Outbox Purchase Line")
//     begin
//         ICInboxSalesLine."Profit % IC" := ICOutboxPurchaseLine."Profit % IC";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnBeforeICInboxPurchLineInsert', '', false, false)]
//     local procedure OnBeforeICInboxPurchLineInsert(var ICInboxPurchaseLine: Record "IC Inbox Purchase Line"; ICOutboxSalesLine: Record "IC Outbox Sales Line")
//     begin
//         ICInboxPurchaseLine."Profit % IC" := ICOutboxSalesLine."Profit % IC";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnBeforeICInboxSalesLineInsert', '', false, false)]
//     local procedure OnBeforeICInboxSalesLineInsert(var ICInboxSalesLine: Record "IC Inbox Sales Line"; ICOutboxPurchaseLine: Record "IC Outbox Purchase Line")
//     begin
//         ICInboxSalesLine."Profit % IC" := ICOutboxPurchaseLine."Profit % IC";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnBeforeHandledICOutboxSalesLineInsert', '', false, false)]
//     local procedure OnBeforeHandledICOutboxSalesLineInsert(var HandledICOutboxSalesLine: Record "Handled IC Outbox Sales Line"; ICOutboxSalesLine: Record "IC Outbox Sales Line")
//     begin
//         HandledICOutboxSalesLine."Profit % IC" := ICOutboxSalesLine."Profit % IC";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnBeforeHandledICOutboxPurchLineInsert', '', false, false)]
//     local procedure OnBeforeHandledICOutboxPurchLineInsert(var HandledICOutboxPurchLine: Record "Handled IC Outbox Purch. Line"; ICOutboxPurchLine: Record "IC Outbox Purchase Line")
//     begin
//         HandledICOutboxPurchLine."Profit % IC" := ICOutboxPurchLine."Profit % IC";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnBeforeInboxSalesLineInsert', '', false, false)]
//     local procedure OnBeforeInboxSalesLineInsert(var ICInboxSalesLine: Record "IC Inbox Sales Line"; HandledICInboxSalesLine: Record "Handled IC Inbox Sales Line")
//     begin
//         ICInboxSalesLine."Profit % IC" := HandledICInboxSalesLine."Profit % IC";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreateOutboxPurchDocTransOnAfterICOutBoxPurchLineInsert', '', false, false)]
//     local procedure OnCreateOutboxPurchDocTransOnAfterICOutBoxPurchLineInsert(var ICOutboxPurchaseLine: Record "IC Outbox Purchase Line"; PurchaseLine: Record "Purchase Line")
//     begin
//         ICOutboxPurchaseLine."Profit % IC" := PurchaseLine."Profit % IC";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreateOutboxSalesCrMemoTransOnBeforeICOutBoxSalesLineInsert', '', false, false)]
//     local procedure OnCreateOutboxSalesCrMemoTransOnBeforeICOutBoxSalesLineInsert(var ICOutboxSalesLine: Record "IC Outbox Sales Line"; SalesCrMemoLine: Record "Sales Cr.Memo Line")
//     begin
//         ICOutboxSalesLine."Profit % IC" := SalesCrMemoLine."Profit % IC";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreateOutboxSalesDocTransOnAfterICOutBoxSalesLineInsert', '', false, false)]
//     local procedure OnCreateOutboxSalesDocTransOnAfterICOutBoxSalesLineInsert(var ICOutboxSalesLine: Record "IC Outbox Sales Line"; SalesLine: Record "Sales Line")
//     begin
//         ICOutboxSalesLine."Profit % IC" := SalesLine."Profit % IC";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreateOutboxSalesInvTransOnBeforeICOutBoxSalesLineInsert', '', false, false)]
//     local procedure OnCreateOutboxSalesInvTransOnBeforeICOutBoxSalesLineInsert(var ICOutboxSalesLine: Record "IC Outbox Sales Line"; SalesInvLine: Record "Sales Invoice Line"; ICOutBoxSalesHeader: Record "IC Outbox Sales Header")
//     begin
//         ICOutboxSalesLine."Profit % IC" := SalesInvLine."Profit % IC";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreatePurchDocumentOnBeforeHandledICInboxPurchLineInsert', '', false, false)]
//     local procedure OnCreatePurchDocumentOnBeforeHandledICInboxPurchLineInsert(ICInboxPurchLine: Record "IC Inbox Purchase Line"; var HandledICInboxPurchLine: Record "Handled IC Inbox Purch. Line")
//     begin
//         ICInboxPurchLine."Profit % IC" := HandledICInboxPurchLine."Profit % IC";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnForwardToOutBoxOnBeforeHndlInboxPurchLineInsert', '', false, false)]
//     local procedure OnForwardToOutBoxOnBeforeHndlInboxPurchLineInsert(var HandledICInboxPurchLine: Record "Handled IC Inbox Purch. Line"; ICInboxPurchLine: Record "IC Inbox Purchase Line")
//     begin
//         HandledICInboxPurchLine."Profit % IC" := ICInboxPurchLine."Profit % IC";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnForwardToOutBoxOnBeforeHndlInboxSalesLineInsert', '', false, false)]
//     local procedure OnForwardToOutBoxOnBeforeHndlInboxSalesLineInsert(var HandledICInboxSalesLine: Record "Handled IC Inbox Sales Line"; ICInboxSalesLine: Record "IC Inbox Sales Line")
//     begin
//         HandledICInboxSalesLine."Profit % IC" := ICInboxSalesLine."Profit % IC";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnRecreateInboxTransactionOnBeforeInboxPurchLineInsert', '', false, false)]
//     local procedure OnRecreateInboxTransactionOnBeforeInboxPurchLineInsert(var ICInboxPurchaseLine: Record "IC Inbox Purchase Line"; HandledICInboxPurchLine: Record "Handled IC Inbox Purch. Line")
//     begin
//         ICInboxPurchaseLine."Profit % IC" := HandledICInboxPurchLine."Profit % IC";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnRecreateOutboxTransactionOnBeforeOutboxPurchLineInsert', '', false, false)]
//     local procedure OnRecreateOutboxTransactionOnBeforeOutboxPurchLineInsert(var ICOutboxPurchaseLine: Record "IC Outbox Purchase Line"; HandledICOutboxPurchLine: Record "Handled IC Outbox Purch. Line")
//     begin
//         ICOutboxPurchaseLine."Profit % IC" := HandledICOutboxPurchLine."Profit % IC";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnRecreateOutboxTransactionOnBeforeOutboxSalesLineInsert', '', false, false)]
//     local procedure OnRecreateOutboxTransactionOnBeforeOutboxSalesLineInsert(var ICOutboxSalesLine: Record "IC Outbox Sales Line"; HandledICOutboxSalesLine: Record "Handled IC Outbox Sales Line")
//     begin
//         ICOutboxSalesLine."Profit % IC" := HandledICOutboxSalesLine."Profit % IC";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnAfterICOutBoxSalesLineInsert', '', false, false)]
//     local procedure OnAfterICOutBoxSalesLineInsert(var SalesLine: Record "Sales Line"; var ICOutboxSalesLine: Record "IC Outbox Sales Line")
//     begin
//         SalesLine."Profit % IC" := ICOutboxSalesLine."Profit % IC";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnBeforeHandledICInboxSalesLineInsert', '', false, false)]
//     local procedure OnBeforeHandledICInboxSalesLineInsert(var HandledICInboxSalesLine: Record "Handled IC Inbox Sales Line"; ICInboxSalesLine: Record "IC Inbox Sales Line")
//     begin
//         HandledICInboxSalesLine."Profit % IC" := ICInboxSalesLine."Profit % IC";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnOutboxJnlLineToInboxOnBeforeICInboxJnlLineInsert', '', false, false)]
//     local procedure OnOutboxJnlLineToInboxOnBeforeICInboxJnlLineInsert(var ICInboxJnlLine: Record "IC Inbox Jnl. Line"; var ICOutboxJnlLine: Record "IC Outbox Jnl. Line");
//     begin
//         ICInboxJnlLine."Profit % IC" := ICOutboxJnlLine."Profit % IC";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, codeunit::ICInboxOutboxMgt, 'OnCreatePurchLinesOnBeforeModify', '', false, false)]
//     local procedure OnCreatePurchLinesOnBeforeModify(var PurchaseLine: Record "Purchase Line"; ICInboxPurchLine: Record "IC Inbox Purchase Line");
//     begin
//         PurchaseLine."Profit % IC" := ICInboxPurchLine."Profit % IC";
//     end;

//     [EventSubscriber(ObjectType::Table, database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromPurchLine', '', false, false)]
//     local procedure OnAfterCopyItemJnlLineFromPurchLine(var ItemJnlLine: Record "Item Journal Line"; PurchLine: Record "Purchase Line")
//     begin
//         ItemJnlLine."Profit % IC" := PurchLine."Profit % IC";
//     end;

//     [EventSubscriber(ObjectType::Codeunit, codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntry', '', false, false)]
//     local procedure OnBeforeInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; TransferItem: Boolean; OldItemLedgEntry: Record "Item Ledger Entry")
//     begin
//         ItemLedgerEntry."Profit % IC" := ItemJournalLine."Profit % IC";
//     end;
// }