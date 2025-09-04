codeunit 75002 VendInvNoChk_Mgt_IntGen
{

    //VendInvNoChk-NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeCheckPurchExtDocNoProcedure', '', false, false)]
    local procedure OnBeforeCheckPurchExtDocNoProcedure(var GenJnlLine: Record "Gen. Journal Line"; var IsHandled: Boolean)
    var
        Vendor_lRec: Record "Vendor";
        PurchaseAlreadyExistsErr: Label 'Purchase %1 %2 already exists for this vendor.', Comment = '%1 = Document Type; %2 = Document No.';
        PurchSetup: Record "Purchases & Payables Setup";
        OldVendLedgEntry: Record "Vendor Ledger Entry";
        VendorMgt: Codeunit "Vendor Mgt.";
        FYStartDate_lDte: Date;
        FYSEndDate_lDte: Date;
    begin
        PurchSetup.Get();
        if not (PurchSetup."Ext. Doc. No. Mandatory" or (GenJnlLine."External Document No." <> '')) then
            exit;

        IF NOT PurchSetup."Check Vendor Invoice No. FY Wi" then begin
            IF Vendor_lRec.GET(GenJnlLine."Account No.") THEN BEGIN
                IF NOT Vendor_lRec."Check Vendor Invoice No. FY" Then
                    Exit;
            END Else
                Exit;
        End;

        GenJnlLine.Testfield("Posting Date");
        GetFYDate_gFnc(GenJnlLine."Posting Date", FYStartDate_lDte, FYSEndDate_lDte);

        GenJnlLine.TestField("External Document No.");
        OldVendLedgEntry.Reset();
        VendorMgt.SetFilterForExternalDocNo(
          OldVendLedgEntry, GenJnlLine."Document Type", GenJnlLine."External Document No.",
          GenJnlLine."Account No.", GenJnlLine."Document Date");
        OldVendLedgEntry.Setrange("Posting Date", FYStartDate_lDte, FYSEndDate_lDte);
        if not OldVendLedgEntry.IsEmpty() then
            Error(
              PurchaseAlreadyExistsErr,
              GenJnlLine."Document Type", GenJnlLine."External Document No.");

        IsHandled := TRUE;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnCheckExternalDocumentNumberOnAfterSetFilters', '', false, false)]
    local procedure OnCheckExternalDocumentNumberOnAfterSetFilters(var VendLedgEntry: Record "Vendor Ledger Entry"; PurchaseHeader: Record "Purchase Header");
    var
        FYStartDate_lDte: Date;
        FYSEndDate_lDte: Date;
    begin
        GetFYDate_gFnc(PurchaseHeader."Posting Date", FYStartDate_lDte, FYSEndDate_lDte);
        VendLedgEntry.Setrange("Posting Date", FYStartDate_lDte, FYSEndDate_lDte);
    end;

    procedure GetFYDate_gFnc(Date_iDte: Date; VAR FYStartDate_vDte: Date; VAR FYSEndDate_vDte: Date)
    var
        CurrMonth_lInt: Integer;
    begin
        CurrMonth_lInt := DATE2DMY(Date_iDte, 2);

        IF CurrMonth_lInt IN [1, 2, 3] THEN BEGIN
            FYStartDate_vDte := DMY2DATE(1, 4, DATE2DMY(Date_iDte, 3) - 1);
            FYSEndDate_vDte := DMY2DATE(31, 3, DATE2DMY(Date_iDte, 3));
        END ELSE BEGIN
            FYStartDate_vDte := DMY2DATE(1, 4, DATE2DMY(Date_iDte, 3));
            FYSEndDate_vDte := DMY2DATE(31, 3, DATE2DMY(Date_iDte, 3) + 1)
        END;
    end;
    //VendInvNoChk-NE

}