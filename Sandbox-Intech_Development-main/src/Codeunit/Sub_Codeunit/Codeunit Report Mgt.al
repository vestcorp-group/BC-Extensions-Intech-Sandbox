codeunit 50102 RepMgt_50102
{
    //T48657-NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure OnSubstituteReport(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = Report::"KMP PostedSalesInv Clearance" then
            NewReportId := Report::KMPPostedSalesInvClearan_ISPL;
    end;
    //T48657-NE

    //T51982-NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeInsertItemLedgEntry, '', false, false)]
    local procedure "Item Jnl.-Post Line_OnBeforeInsertItemLedgEntry"(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; TransferItem: Boolean; OldItemLedgEntry: Record "Item Ledger Entry"; ItemJournalLineOrigin: Record "Item Journal Line")
    begin
        ItemLedgerEntry."FPO No." := ItemJournalLine."FPO No.";
    end;
    //T51982-NE

    //T53282-NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSendPurchaseDocForApproval', '', false, false)]
    local procedure OnSendPurchaseDocForApproval(var PurchaseHeader: Record "Purchase Header");
    var
        PurchaseLine_lRec: Record "Purchase Line";
    begin
        if PurchaseHeader."Document Type" IN [PurchaseHeader."Document Type"::Order, PurchaseHeader."Document Type"::"Blanket Order"] then Begin
            PurchaseLine_lRec.Reset();
            PurchaseLine_lRec.SetRange("Document Type", PurchaseHeader."Document Type");
            PurchaseLine_lRec.SetRange("Document No.", PurchaseHeader."No.");
            PurchaseLine_lRec.SetFilter(Type, '<>%1', PurchaseLine_lRec.Type::" ");
            PurchaseLine_lRec.SetFilter(Quantity, '<>%1', 0);
            if PurchaseLine_lRec.FindSet() then
                repeat
                    PurchaseLine_lRec.TestField("Location Code", PurchaseHeader."Location Code");
                until PurchaseLine_lRec.Next() = 0;
        End;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnSendSalesDocForApproval, '', false, false)]
    local procedure "Approvals Mgmt._OnSendSalesDocForApproval"(var SalesHeader: Record "Sales Header")
    var
        SalesLine_lRec: Record "Sales Line";
    begin
        if SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::"Blanket Order"] then Begin
            SalesLine_lRec.Reset();
            SalesLine_lRec.SetRange("Document Type", SalesHeader."Document Type");
            SalesLine_lRec.SetRange("Document No.", SalesHeader."No.");
            SalesLine_lRec.SetFilter(Type, '<>%1', SalesLine_lRec.Type::" ");
            SalesLine_lRec.SetFilter(Quantity, '<>%1', 0);
            if SalesLine_lRec.FindSet() then
                repeat
                    SalesLine_lRec.TestField("Location Code", SalesHeader."Location Code");
                until SalesLine_lRec.Next() = 0;
        End;
    end;
    //T53282-NE
}
