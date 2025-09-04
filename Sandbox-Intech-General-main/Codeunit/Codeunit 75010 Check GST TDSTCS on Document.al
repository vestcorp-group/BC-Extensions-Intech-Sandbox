codeunit 75010 "Check GST TDSTCS on Document"
{
    //CheckGST- CReate new Codeunit

    //OnPost Action - Sales
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', true, true)]
    local procedure "Sales-Post_OnBeforePostSalesDoc"
    (
        var SalesHeader: Record "Sales Header";
        CommitIsSuppressed: Boolean;
        PreviewMode: Boolean;
        var HideProgressWindow: Boolean;
        var IsHandled: Boolean
    )
    begin
        CheckSalesDoc(SalesHeader);
    end;

    //Send for approval Action - Sales
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeCheckSalesApprovalPossible', '', false, false)]
    local procedure OnBeforeCheckSalesApprovalPossible(var SalesHeader: Record "Sales Header"; var Result: Boolean; var IsHandled: Boolean);
    begin
        CheckSalesDoc(SalesHeader);
    end;

    //Release Sales Document 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', true, true)]
    local procedure "Release Sales Document_OnBeforeReleaseSalesDoc"
    (
        var SalesHeader: Record "Sales Header";
        PreviewMode: Boolean;
        var IsHandled: Boolean;
        SkipCheckReleaseRestrictions: Boolean
    )
    begin
        CheckSalesDoc(SalesHeader);
    end;

    //ManualRelease Sales Document
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeManualReleaseSalesDoc', '', true, true)]
    local procedure "Release Sales Document_OnBeforeManualReleaseSalesDoc"
    (
        var SalesHeader: Record "Sales Header";
        PreviewMode: Boolean
    )
    begin
        CheckSalesDoc(SalesHeader);
    end;

    //OnPost Action - Purchase
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', true, true)]
    local procedure "Purch.-Post_OnBeforePostPurchaseDoc"
    (
        var PurchaseHeader: Record "Purchase Header";
        PreviewMode: Boolean;
        CommitIsSupressed: Boolean;
        var HideProgressWindow: Boolean;
        var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
        var IsHandled: Boolean
    )
    begin
        CheckPurchDoc(PurchaseHeader);
    end;

    //Send for approval Action - Purchase
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeCheckPurchaseApprovalPossible', '', false, false)]
    local procedure OnBeforeCheckPurchaseApprovalPossible(var PurchaseHeader: Record "Purchase Header"; var Result: Boolean; var IsHandled: Boolean);
    begin
        CheckPurchDoc(PurchaseHeader);
    end;


    //Release Purchase Document 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforeReleasePurchaseDoc', '', true, true)]
    local procedure "Release Purchase Document_OnBeforeReleasePurchaseDoc"
   (
       var PurchaseHeader: Record "Purchase Header";
       PreviewMode: Boolean;
       var SkipCheckReleaseRestrictions: Boolean;
       var IsHandled: Boolean
   )
    begin
        CheckPurchDoc(PurchaseHeader);
    end;

    //ManualRelease Purchase Document
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnBeforeManualReleasePurchaseDoc', '', true, true)]
    local procedure "Release Purchase Document_OnBeforeManualReleasePurchaseDoc"
    (
        var PurchaseHeader: Record "Purchase Header";
        PreviewMode: Boolean
    )
    begin
        CheckPurchDoc(PurchaseHeader);
    end;



    procedure CheckSalesDoc(SH_iRec: Record "Sales Header")
    var
        SL_lRec: Record "Sales Line";
        SalesSetup_lRec: Record "Sales & Receivables Setup";
        AllowedNOC_lRec: Record "Allowed NOC";
        AllowedNOCFound_lBln: Boolean;
    begin
        SalesSetup_lRec.GET;
        IF NOT SalesSetup_lRec."Check GST TCS on Sales Record" then
            Exit;

        AllowedNOC_lRec.Reset();
        AllowedNOC_lRec.Setrange("Customer No.", SH_iRec."Sell-to Customer No.");
        AllowedNOC_lRec.Setfilter("TCS Nature of Collection", '<>%1', '');
        IF AllowedNOC_lRec.FindFirst() then
            AllowedNOCFound_lBln := true;

        SL_lRec.Reset();
        SL_lRec.Setrange("Document Type", SH_iRec."Document Type");
        SL_lRec.Setrange("Document No.", SH_iRec."No.");
        SL_lRec.Setfilter("Line Amount", '<>%1', 0);
        IF SL_lRec.FindSet() Then begin
            repeat
                IF SL_lRec."Total GST Amount"() = 0 ThEn begin
                    IF NOT CONfirm('GST is not calculated in Line No. %1 and No. %2, Do you want to proceed?', false, SL_lRec."Line No.", SL_lRec."No.") then
                        Error('');
                end;

                IF AllowedNOCFound_lBln Then begin
                    IF SL_lRec."TDS/TCS Amount"() = 0 Then begin
                        IF NOT CONfirm('TCS is not calculated in Line No. %1 and No. %2, Do you want to proceed?', false, SL_lRec."Line No.", SL_lRec."No.") then
                            Error('');
                    end;
                end;
            until SL_lRec.Next() = 0;
        end;
    end;

    procedure CheckPurchDoc(PH_iRec: Record "Purchase Header")
    var
        PL_lRec: Record "Purchase Line";
        PurchPayablesSetup_lRec: Record "Purchases & Payables Setup";
        AllowedSections_lRec: Record "Allowed Sections";
        AllowedSectionsFound_lBln: Boolean;
    begin
        PurchPayablesSetup_lRec.Get();
        If Not PurchPayablesSetup_lRec."Check GST TDS on Purch Record" then
            Exit;

        AllowedSections_lRec.Reset();
        AllowedSections_lRec.SetRange("Vendor No", PH_iRec."Buy-from Vendor No.");
        AllowedSections_lRec.SetFilter("TDS Section", '<>%1', '');
        If AllowedSections_lRec.FindFirst() then
            AllowedSectionsFound_lBln := true;

        PL_lRec.Reset();
        PL_lRec.SetRange("Document Type", PH_iRec."Document Type");
        PL_lRec.SetRange("No.", PH_iRec."No.");
        PL_lRec.SetFilter("Line Amount", '<>%1', 0);
        If PL_lRec.FindSet() then
            repeat
                If PL_lRec."Total GST Amount"() = 0 then begin
                    If Not Confirm('GST is not calculated in Line No. %1 and No. %2, Do you want to proceed?', false, PL_lRec."Line No.", PL_lRec."No.") then
                        Error('');

                    If AllowedSectionsFound_lBln then begin
                        If PL_lRec."TDS Amount"() = 0 then
                            If Not Confirm('TDS is not calculated in Line No. %1 and No. %2, Do you want to proceed?', false, PL_lRec."Line No.", PL_lRec."No.") then
                                Error('');
                    end;
                end;
            until PL_lRec.Next() = 0;
    end;
}