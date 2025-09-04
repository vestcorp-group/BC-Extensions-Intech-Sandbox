codeunit 50201 KMP_CUEventSubscriber //T12370-Full Comment //T-12855 Codeunit Uncommented
{

    EventSubscriberInstance = StaticAutomatic;
    //     trigger OnRun()
    //     begin

    //     end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'No.', true, true)] //T-12855 Event Uncommented
    local procedure UpdateHSNFromItemMaster(var Rec: Record "Sales Line")
    var
        ItemL: Record Item;
    begin
        if not (Rec.Type = Rec.Type::Item) then
            exit;
        ItemL.Get(Rec."No.");
        Rec.HSNCode := ItemL."Tariff No.";
        Rec.CountryOfOrigin := ItemL."Country/Region of Origin Code";
        REc.LineHSNCode := ItemL."Tariff No.";
    end; 

    //     [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeValidateEvent', 'Posting Date', true, true)]
    //     local procedure DontUpdateDocumentDate(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    //     begin
    //         if Rec."Document Type" <> Rec."Document Type"::Invoice then
    //             exit;
    //         if CurrFieldNo <> Rec.FieldNo("Posting Date") then
    //             exit;
    //         if Rec."Incoming Document Entry No." <> 0 then
    //             exit;
    //         Rec."Incoming Document Entry No." := 1;

    //     end;

    //     [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Posting Date', true, true)]
    //     local procedure UpdateBackDocumentDate(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    //     begin
    //         if Rec."Document Type" <> Rec."Document Type"::Invoice then
    //             exit;
    //         if CurrFieldNo <> Rec.FieldNo("Posting Date") then
    //             exit;
    //         Rec."Incoming Document Entry No." := xRec."Incoming Document Entry No.";

    //     end;

    //     [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeValidateEvent', 'Posting Date', true, true)]
    //     local procedure DontUpdateDocumentDate_OnPO(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    //     begin
    //         if not (Rec."Document Type" IN [Rec."Document Type"::Invoice, Rec."Document Type"::Order]) then
    //             exit;
    //         if CurrFieldNo <> Rec.FieldNo("Posting Date") then
    //             exit;
    //         if Rec."Incoming Document Entry No." <> 0 then
    //             exit;
    //         Rec."Incoming Document Entry No." := 1;

    //     end;

    //     [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateEvent', 'Posting Date', true, true)]
    //     local procedure UpdateBackDocumentDate_OnPO(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    //     begin
    //         if not (Rec."Document Type" IN [Rec."Document Type"::Invoice, Rec."Document Type"::Order]) then
    //             exit;
    //         if CurrFieldNo <> Rec.FieldNo("Posting Date") then
    //             exit;
    //         Rec."Incoming Document Entry No." := xRec."Incoming Document Entry No.";
    //     end;

    //     // Reopen
    //     [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnBeforeActionEvent', 'Reopen', true, true)]
    //     local procedure OnBeforeReopenEvent_CheckPermission(var Rec: Record "Sales Header")
    //     begin
    //         CheckUserPermissionforReopen();
    //     end;

    //     [EventSubscriber(ObjectType::Page, Page::"Purchase Order", 'OnBeforeActionEvent', 'Reopen', true, true)]
    //     local procedure OnBeforeReopenEvent_PurchaseOrder(var Rec: Record "Purchase Header")
    //     begin
    //         CheckUserPermissionforReopen();
    //     end;

    //     local procedure CheckUserPermissionforReopen()
    //     var
    //         UserSetupL: Record "User Setup";
    //     begin
    //         UserSetupL.Get(UserId);
    //         if not UserSetupL."Document Reopen" then
    //             Error(DocumentReopenPermissionErr);
    //     end;
    //     // Reopen

    //     // Start Issue 50
    //     [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateEvent', 'Unit of Measure Code', true, true)]
    //     local procedure SalesLine_OnBeforeValidate_UOM(var Rec: Record "Sales Line")
    //     var
    //         ItemL: Record Item;
    //         UserSetupL: Record "User Setup";
    //         ItemUOMRec: Record "Item Unit of Measure";
    //     begin
    //         if Rec.Type <> Rec.Type::Item then
    //             exit;
    //         ItemL.Get(Rec."No.");
    //         ItemUOMRec.Get(Rec."No.", Rec."Unit of Measure Code");
    //         if ItemL."Allow Loose Qty." and Rec."Allow Loose Qty." then
    //             exit;
    //         //if Rec."Unit of Measure Code" <> ItemL."Sales Unit of Measure" then
    //         ItemUOMRec.SetRange("Item No.", Rec."Unit of Measure Code");
    //         if not ItemUOMRec.Default then
    //             if not rec."IC Copy" then
    //                 if UserSetupL.Get(UserId) and not UserSetupL."Allow Sales Unit of Measure" then
    //                     Error(SalesUnitofMeasureErr, Rec.FieldName("Unit of Measure Code"), ItemL."Sales Unit of Measure");
    //     end;
    //     // Stop Issue 50
    //     // Start Issue 103
    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterDeleteAfterPosting', '', True, true)]
    //     local procedure SalesRemarks(SalesHeader: Record "Sales Header"; SalesInvoiceHeader: Record "Sales Invoice Header")
    //     var
    //         SalesRemarksL: Record "Sales Remark";
    //     begin
    //         If SalesInvoiceHeader."No." = '' then
    //             exit;
    //         SalesRemarksL.CopyRemarksArchieve(SalesRemarksL."Document Type"::Invoice, SalesRemarksL."Document Type"::"Posted Invoice", SalesHeader."No.", SalesInvoiceHeader."No.");
    //         SalesRemarksL.DeleteRemarks(SalesRemarksL."Document Type"::Invoice, SalesHeader."No.");
    //     end;
    //     // Stop Issue 103
    //     //Purchase Remarks Start
    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterDeleteAfterPosting', '', True, true)]
    //     local procedure PurchaseRemarks(PurchHeader: Record "Purchase Header"; PurchInvHeader: Record "Purch. Inv. Header")
    //     var
    //         PurchaseRemarksL: Record "Purchase Remarks";
    //     begin
    //         If PurchInvHeader."No." = '' then
    //             exit;
    //         PurchaseRemarksL.CopyRemarksArchieve(PurchaseRemarksL."Document Type"::Invoice, PurchaseRemarksL."Document Type"::"Posted Invoice", PurchHeader."No.", PurchInvHeader."No.");
    //         PurchaseRemarksL.DeleteRemarks(PurchaseRemarksL."Document Type"::Invoice, PurchHeader."No.");
    //     end;

    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPurchRcptHeaderInsert', '', true, true)]
    //     local procedure PurchaseOrderRemarks(var PurchaseHeader: Record "Purchase Header"; var PurchRcptHeader: Record "Purch. Rcpt. Header")
    //     Var
    //         PurchaseRemarksL: Record "Purchase Remarks";
    //     begin
    //         If PurchRcptHeader."No." = '' then
    //             exit;
    //         PurchaseRemarksL.CopyRemarksArchieve(PurchaseRemarksL."Document Type"::Order, PurchaseRemarksL."Document Type"::Receipt, PurchaseHeader."No.", PurchRcptHeader."No.");
    //         PurchaseRemarksL.DeleteRemarks(PurchaseRemarksL."Document Type"::Order, PurchaseHeader."No.");

    //         //GRN(Supplier Invoice No.) start
    //         If PurchRcptHeader."No." <> '' then begin
    //             PurchRcptHeader."Vendor Invoice No." := PurchaseHeader."Vendor Invoice No.";
    //             PurchRcptHeader.Modify();
    //         end;
    //         //GRN end

    //     end;
    //     //Purchase Remarks end


    //     [EventSubscriber(ObjectType::Table, Database::"Approval Entry", 'OnBeforeDeleteEvent', '', true, true)]

    //     local procedure CopyApprovalEntriesondelete(var Rec: Record "Approval Entry")
    //     var
    //         ApprovalEntry: Record "Approval Entry";
    //         ArchivedApprovalEntry: Record "Archived Approval Entry";
    //     begin
    //         if not Rec.IsEmpty then begin
    //             ArchivedApprovalEntry.Init();
    //             ArchivedApprovalEntry.TransferFields(rec);
    //             ArchivedApprovalEntry.Insert();
    //         end;
    //     end;


    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Charge Assgnt. (Purch.)", 'OnBeforeShowSuggestItemChargeAssignStrMenu', '', true, true)]
    //     local procedure MyProcedure(var SuggestItemChargeMenuTxt: Text; var Selection: Integer)
    //     begin
    //         SuggestItemChargeMenuTxt := 'Equally,By Amount,By Volume';
    //     end;

    //     var
    //         DocumentReopenPermissionErr: Label 'You don''t have permission to Reopen the document. Please contact your system administrator';
    //         SalesUnitofMeasureErr: Label 'The %1 can''t be other than default selection';

}