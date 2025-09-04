codeunit 74990 "Subscribe_DetailGSTLed_Source"
{

    //SS-NS-121022
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDoc(var SalesHeader: Record "Sales Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; SalesShptHdrNo: Code[20]; RetRcpHdrNo: Code[20]; SalesInvHdrNo: Code[20]; SalesCrMemoHdrNo: Code[20]; CommitIsSuppressed: Boolean; InvtPickPutaway: Boolean; var CustLedgerEntry: Record "Cust. Ledger Entry"; WhseShip: Boolean; WhseReceiv: Boolean);
    Var
        DetailGSTLedgerEntry_lRec: Record "Detailed GST Ledger Entry";
        SalesInvoiceHeader_lRec: Record "Sales Invoice Header";
        SalesCrHeaderMemo_lRec: Record "Sales Cr.Memo Header";
    begin
        DetailGSTLedgerEntry_lRec.Reset();
        IF SalesInvHdrNo <> '' Then begin
            SalesInvoiceHeader_lRec.GET(SalesInvHdrNo);
            DetailGSTLedgerEntry_lRec.SetRange("Document Type", DetailGSTLedgerEntry_lRec."Document Type"::Invoice);
            DetailGSTLedgerEntry_lRec.SetRange("Document No.", SalesInvHdrNo);
            DetailGSTLedgerEntry_lRec.SetRange("Posting Date", SalesInvoiceHeader_lRec."Posting Date");
        End;

        IF SalesCrMemoHdrNo <> '' Then begin
            SalesCrHeaderMemo_lRec.GET(SalesCrMemoHdrNo);
            DetailGSTLedgerEntry_lRec.SetRange("Document Type", DetailGSTLedgerEntry_lRec."Document Type"::"Credit Memo");
            DetailGSTLedgerEntry_lRec.SetRange("Document No.", SalesCrMemoHdrNo);
            DetailGSTLedgerEntry_lRec.SetRange("Posting Date", SalesCrHeaderMemo_lRec."Posting Date");
        End;
        DetailGSTLedgerEntry_lRec.SetRange("Entry Type", DetailGSTLedgerEntry_lRec."Entry Type"::"Initial Entry");
        If DetailGSTLedgerEntry_lRec.FindSet then
            repeat
                if SalesInvoiceHeader_lRec."No." <> '' Then begin
                    if DetailGSTLedgerEntry_lRec."Source No." <> SalesInvoiceHeader_lRec."Sell-to Customer No." then begin
                        DetailGSTLedgerEntry_lRec."Source No." := SalesInvoiceHeader_lRec."Sell-to Customer No.";
                        DetailGSTLedgerEntry_lRec.Modify();
                    end;
                end;
                if SalesCrHeaderMemo_lRec."No." <> '' then begin
                    if DetailGSTLedgerEntry_lRec."Source No." <> SalesCrHeaderMemo_lRec."Sell-to Customer No." then begin
                        DetailGSTLedgerEntry_lRec."Source No." := SalesCrHeaderMemo_lRec."Sell-to Customer No.";
                        DetailGSTLedgerEntry_lRec.Modify();
                    end;
                end;
            until DetailGSTLedgerEntry_lRec.Next = 0;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnRunOnBeforeFinalizePosting', '', false, false)]
    local procedure OnRunOnBeforeFinalizePosting(var PurchaseHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchInvHeader: Record "Purch. Inv. Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShipmentHeader: Record "Return Shipment Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; CommitIsSuppressed: Boolean);
    Var
        DetailGSTLedgerEntry_lRec: Record "Detailed GST Ledger Entry";
        PurchInvoiceHeader_lRec: Record "Purch. Inv. Header";
        PurchCrHeaderMemo_lRec: Record "Purch. Cr. Memo Hdr.";
    begin
        DetailGSTLedgerEntry_lRec.Reset();
        IF PurchInvHeader."No." <> '' Then begin
            PurchInvoiceHeader_lRec.GET(PurchInvHeader."No.");
            DetailGSTLedgerEntry_lRec.SetRange("Document Type", DetailGSTLedgerEntry_lRec."Document Type"::Invoice);
            DetailGSTLedgerEntry_lRec.SetRange("Document No.", PurchInvHeader."No.");
            DetailGSTLedgerEntry_lRec.SetRange("Posting Date", PurchInvoiceHeader_lRec."Posting Date");
        End;

        IF PurchCrMemoHdr."No." <> '' Then begin
            PurchCrHeaderMemo_lRec.GET(PurchCrMemoHdr."No.");
            DetailGSTLedgerEntry_lRec.SetRange("Document Type", DetailGSTLedgerEntry_lRec."Document Type"::"Credit Memo");
            DetailGSTLedgerEntry_lRec.SetRange("Document No.", PurchCrMemoHdr."No.");
            DetailGSTLedgerEntry_lRec.SetRange("Posting Date", PurchCrHeaderMemo_lRec."Posting Date");
        End;
        DetailGSTLedgerEntry_lRec.SetRange("Entry Type", DetailGSTLedgerEntry_lRec."Entry Type"::"Initial Entry");
        If DetailGSTLedgerEntry_lRec.FindSet then
            repeat
                if PurchInvoiceHeader_lRec."No." <> '' Then begin
                    if DetailGSTLedgerEntry_lRec."Source No." <> PurchInvoiceHeader_lRec."Pay-to Vendor No." then begin
                        DetailGSTLedgerEntry_lRec."Source No." := PurchInvoiceHeader_lRec."Pay-to Vendor No.";
                        DetailGSTLedgerEntry_lRec.Modify();
                    end;
                end;
                if PurchCrHeaderMemo_lRec."No." <> '' then begin
                    if DetailGSTLedgerEntry_lRec."Source No." <> PurchCrHeaderMemo_lRec."Pay-to Vendor No." then begin
                        DetailGSTLedgerEntry_lRec."Source No." := PurchCrHeaderMemo_lRec."Pay-to Vendor No.";
                        DetailGSTLedgerEntry_lRec.Modify();
                    end;
                end;
            until DetailGSTLedgerEntry_lRec.Next = 0;
    end;

    //SS-NE-121022


}