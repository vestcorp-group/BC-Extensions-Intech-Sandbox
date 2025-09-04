codeunit 85656 InterCompanyField
{
    //T52505 08-04-2025-NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, OnCreateOutboxSalesDocTransOnAfterICOutBoxSalesLineInsert, '', false, false)]
    local procedure ICInboxOutboxMgt_OnCreateOutboxSalesDocTransOnAfterICOutBoxSalesLineInsert(var ICOutboxSalesLine: Record "IC Outbox Sales Line"; SalesLine: Record "Sales Line")
    begin
        ICOutboxSalesLine."IC Unit Price Base UOM" := SalesLine."Unit Price Base UOM 2";
        ICOutboxSalesLine.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, OnCreateOutboxPurchDocTransOnAfterICOutBoxPurchLineInsert, '', false, false)]
    local procedure ICInboxOutboxMgt_OnCreateOutboxPurchDocTransOnAfterICOutBoxPurchLineInsert(var ICOutboxPurchaseLine: Record "IC Outbox Purchase Line"; PurchaseLine: Record "Purchase Line")
    begin
        ICOutboxPurchaseLine."IC Unit Price Base UOM" := PurchaseLine."Unit Price Base UOM";
        ICOutboxPurchaseLine.Modify();
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, OnBeforeICInboxPurchLineInsert, '', false, false)]
    local procedure ICInboxOutboxMgt_OnBeforeICInboxPurchLineInsert(var ICInboxPurchaseLine: Record "IC Inbox Purchase Line"; ICOutboxSalesLine: Record "IC Outbox Sales Line")
    begin
        ICInboxPurchaseLine."IC Unit Price Base UOM" := ICOutboxSalesLine."IC Unit Price Base UOM";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, OnBeforeICInboxSalesLineInsert, '', false, false)]
    local procedure ICInboxOutboxMgt_OnBeforeICInboxSalesLineInsert(var ICInboxSalesLine: Record "IC Inbox Sales Line"; ICOutboxPurchaseLine: Record "IC Outbox Purchase Line")
    begin
        ICInboxSalesLine."IC Unit Price Base UOM" := ICOutboxPurchaseLine."IC Unit Price Base UOM";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, OnCreatePurchLinesOnBeforeModify, '', false, false)]
    local procedure ICInboxOutboxMgt_OnCreatePurchLinesOnBeforeModify(var PurchaseLine: Record "Purchase Line"; ICInboxPurchLine: Record "IC Inbox Purchase Line")
    begin
        Purchaseline."Unit Price Base UOM" := ICInboxPurchLine."IC Unit Price Base UOM";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, OnAfterCreateSalesLines, '', false, false)]
    local procedure ICInboxOutboxMgt_OnAfterCreateSalesLines(ICInboxSalesLine: Record "IC Inbox Sales Line"; var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header")
    begin
        SalesLine."Unit Price Base UOM 2" := ICInboxSalesLine."IC Unit Price Base UOM";
    end;
    //T52505 08-04-2025-NE


    var
        myInt: Integer;
}