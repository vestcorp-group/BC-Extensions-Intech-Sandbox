Codeunit 74999 Subscribe_Codeunit_18435
{
    //SkipRefNoChk-NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reference Invoice No. Mgt.", 'OnBeforeCheckRefInvoiceNoSalesHeader', '', false, false)]
    local procedure OnBeforeCheckRefInvoiceNoSalesHeader(var SalesHeader: Record "Sales Header"; var IsHandled: Boolean);
    var
        ReferenceInvoiceNo: Record "Reference Invoice No.";
    begin

        IF SalesHeader."Skip Check Invoice Ref" then begin
            IsHandled := true;

            //T32026-OS 281022
            // ReferenceInvoiceNo.Reset();
            // ReferenceInvoiceNo.SetRange("Document Type", ReferenceInvoiceNo."Document Type"::"Credit Memo");
            // ReferenceInvoiceNo.SetRange("Document No.", SalesHeader."No.");
            // ReferenceInvoiceNo.SetRange("Source No.", SalesHeader."Bill-to Customer No.");
            // IF NOT ReferenceInvoiceNo.FindFirst() Then begin
            //     Clear(ReferenceInvoiceNo);
            //     ReferenceInvoiceNo.Init();
            //     ReferenceInvoiceNo."Document Type" := ReferenceInvoiceNo."Document Type"::"Credit Memo";
            //     ReferenceInvoiceNo."Document No." := SalesHeader."No.";
            //     ReferenceInvoiceNo."Source No." := SalesHeader."Bill-to Customer No.";
            //     ReferenceInvoiceNo."Reference Invoice Nos." := SalesHeader."No.";
            //     ReferenceInvoiceNo.Verified := true;
            //     ReferenceInvoiceNo.Insert();
            //     //Message('Entry Created Successfully');
            // end;
            //T32026-OE 281022
        End;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reference Invoice No. Mgt.", 'OnBeforeCheckRefInvNoPurchaseHeader', '', false, false)]
    local procedure OnBeforeCheckRefInvNoPurchaseHeader(var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean);
    var
        ReferenceInvoiceNo: Record "Reference Invoice No.";
    begin
        IF PurchaseHeader."Skip Check Invoice Ref" then begin
            IsHandled := true;

            //T32026-OS 281022
            // ReferenceInvoiceNo.Reset();
            // ReferenceInvoiceNo.SetRange("Document Type", ReferenceInvoiceNo."Document Type"::"Credit Memo");
            // ReferenceInvoiceNo.SetRange("Document No.", PurchaseHeader."No.");
            // ReferenceInvoiceNo.SetRange("Source No.", PurchaseHeader."Pay-to Vendor No.");
            // IF NOT ReferenceInvoiceNo.FindFirst() Then begin
            //     Clear(ReferenceInvoiceNo);
            //     ReferenceInvoiceNo.Init();
            //     ReferenceInvoiceNo."Document Type" := ReferenceInvoiceNo."Document Type"::"Credit Memo";
            //     ReferenceInvoiceNo."Document No." := PurchaseHeader."No.";
            //     ReferenceInvoiceNo."Source No." := PurchaseHeader."Pay-to Vendor No.";
            //     ReferenceInvoiceNo."Reference Invoice Nos." := PurchaseHeader."No.";
            //     ReferenceInvoiceNo.Verified := true;
            //     ReferenceInvoiceNo.Insert();
            //     //Message('Entry Created Successfully');
            // end;
            //T32026-OE 281022
        End;
    end;
    //SkipRefNoChk-NE
}

