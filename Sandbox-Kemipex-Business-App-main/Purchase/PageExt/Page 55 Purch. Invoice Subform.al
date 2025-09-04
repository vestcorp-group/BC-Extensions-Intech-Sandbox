pageextension 58078 PurchaseInvoiceSubform extends "Purch. Invoice Subform"//T12370-Full Comment
{
    layout
    {
        addafter(Description)
        {
            // field("Item COO"; rec.Item_COO)
            // {
            //     ApplicationArea = all;
            // }
            // field(Item_Manufacturer_Description; rec.Item_Manufacturer_Description)
            // {
            //     ApplicationArea = all;
            // }
            field(Item_short_name; rec.Item_short_name)//T13700
            {
                ApplicationArea = all;
            }
            field("Item HS Code"; rec."Item HS Code")
            {
                ApplicationArea = all;
            }

        }
        addbefore("Line Amount")
        {
            field("Base UOM"; rec."Base UOM")
            {
                ApplicationArea = all;
            }
            field("Quantity (Base)"; rec."Quantity (Base)")
            {
                ApplicationArea = all;
                Caption = 'Base UOM Qty.';
                Editable = false;
            }
            field("Unit Price Base UOM"; rec."Unit Price Base UOM")
            {
                ApplicationArea = all;
                Editable = EditablOnPurch_gBln;//T51000-N
            }
        }
        modify(Quantity)
        {
            Editable = EditablOnPurch_gBln;//T51000-N
        }
        modify("Direct Unit Cost")
        {
            Editable = EditablOnPurch_gBln;//T51000-N
        }
        modify("Line Amount")
        {
            Editable = EditablOnPurch_gBln;//T51000-N
        }
        // moveafter("Unit of Measure Code"; Quantity)
        // //GST
        // modify(AmountBeforeDiscount)
        // {
        //     CaptionClass = SubTotalAmtExcVATCaption;
        // }
        // modify(InvoiceDiscountAmount)
        // {
        //     CaptionClass = InvDiscAmtCaption;
        // }
        // modify("Total Amount Excl. VAT")
        // {
        //     CaptionClass = GetTotalAmtExcVATCaption;
        // }
        // modify("Total VAT Amount")
        // {
        //     Visible = false;
        //     CaptionClass = GetTotalVATCaption();
        // }
        // modify("Total Amount Incl. VAT")
        // {
        //     CaptionClass = GetTotalAmtIncVATCaption;
        // }

        // modify("Line Amount")
        // {
        //     CaptionClass = GetCustomCaptionClass(Rec.FieldCaption("Line Amount"));
        // }
        // modify("Direct Unit Cost")
        // {
        //     Visible = false;
        //     CaptionClass = GetCustomCaptionClass(Rec.FieldCaption("Direct Unit Cost"));
        // }
        // addlast(PurchDetailLine)
        // {
        //     field("Item Incentive Point (IIP)"; Rec."Item Incentive Point (IIP)")
        //     {
        //         ApplicationArea = All;
        //         Editable = false;
        //     }
        //     field("Transaction Type"; rec."Transaction Type")
        //     {
        //         ApplicationArea = all;
        //         Caption = 'Order Type';
        //     }
        //     field("Container Size"; rec."Container Size")
        //     {
        //         ApplicationArea = All;
        //     }
        //     field("Shipping Remarks"; rec."Shipping Remarks")
        //     {
        //         ApplicationArea = All;
        //     }
        //     field("In-Out Instruction"; rec."In-Out Instruction")
        //     {
        //         ApplicationArea = All;
        //     }
        //     field("Shipping Line"; rec."Shipping Line")
        //     {
        //         ApplicationArea = All;
        //     }
        //     field("BL-AWB No."; rec."BL-AWB No.")
        //     {
        //         ApplicationArea = All;
        //     }
        //     field("Vessel-Voyage No."; rec."Vessel-Voyage No.")
        //     {
        //         ApplicationArea = all;
        //     }
        //     field("Freight Forwarder"; rec."Freight Forwarder")
        //     {
        //         ApplicationArea = all;
        //     }
        //     field("Freight Charge"; rec."Freight Charge")
        //     {
        //         ApplicationArea = all;
        //     }
        // }

    }
    local procedure GetTotalVATCaption(): Text
    var
        RecGLSetup: Record "General Ledger Setup";
    begin
        // CompanyInfo.GET;
        // if not CompanyInfo."Enable GST caption" then
        //     exit(DocumentTotals2.GetTotalVATCaption(TotalPurchaseHeader."Currency Code"));
        // RecGLSetup.GET;
        // if Rec."Currency Code" <> '' then
        //exit('GSTORVAT,' + DocumentTotals2.GetTotalVATCaption(Rec."Currency Code"));
        // else
        //   exit('GSTORVAT,' + DocumentTotals2.GetTotalVATCaption(RecGLSetup."LCY Code"));
        CompanyInfo.GET;
        if CompanyInfo."Enable GST caption" then
            exit('GSTORVAT,' + DocumentTotals2.GetTotalVATCaption(TotalPurchaseHeader."Currency Code"))
        else
            exit(DocumentTotals2.GetTotalVATCaption(TotalPurchaseHeader."Currency Code"))


    end;

    local procedure GetTotalAmtExcVATCaption(): Text
    var
        RecGLSetup: Record "General Ledger Setup";
    begin
        // RecGLSetup.GET;
        // if Rec."Currency Code" <> '' then
        // exit('GSTORVAT,' + DocumentTotals2.GetTotalExclVATCaption(TotalPurchaseHeader."Currency Code"))
        // else
        //     exit('GSTORVAT,' + DocumentTotals2.GetTotalExclVATCaption(RecGLSetup."LCY Code"));
        CompanyInfo.GET;
        if CompanyInfo."Enable GST caption" then
            exit('GSTORVAT,' + DocumentTotals2.GetTotalExclVATCaption(TotalPurchaseHeader."Currency Code"))
        else
            exit(DocumentTotals2.GetTotalExclVATCaption(TotalPurchaseHeader."Currency Code"))
    end;

    local procedure GetTotalAmtIncVATCaption(): Text
    var
        RecGLSetup: Record "General Ledger Setup";
    begin
        // RecGLSetup.GET;
        // if Rec."Currency Code" <> '' then
        //exit('GSTORVAT,' + DocumentTotals2.GetTotalInclVATCaption(TotalPurchaseHeader."Currency Code"))
        // else
        //     exit('GSTORVAT,' + DocumentTotals2.GetTotalInclVATCaption(RecGLSetup."LCY Code"));

        CompanyInfo.GET;
        if CompanyInfo."Enable GST caption" then
            exit('GSTORVAT,' + DocumentTotals2.GetTotalInclVATCaption(TotalPurchaseHeader."Currency Code"))
        else
            exit(DocumentTotals2.GetTotalInclVATCaption(TotalPurchaseHeader."Currency Code"))
    end;

    local procedure SubTotalAmtExcVATCaption(): Text
    var
        RecGLSetup: Record "General Ledger Setup";
    begin
        // RecGLSetup.GET;
        // if Rec."Currency Code" <> '' then
        //exit('GSTORVAT,' + DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(TotalPurchaseHeader."Currency Code", TotalPurchaseHeader."Prices Including VAT"))
        // else
        //     exit('GSTORVAT,' + DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(RecGLSetup."LCY Code", TotalPurchaseHeader."Prices Including VAT"));

        CompanyInfo.GET;
        if CompanyInfo."Enable GST caption" then
            exit('GSTORVAT,' + DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(TotalPurchaseHeader."Currency Code", TotalPurchaseHeader."Prices Including VAT"))
        else
            exit(DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(TotalPurchaseHeader."Currency Code", TotalPurchaseHeader."Prices Including VAT"))
    end;

    local procedure InvDiscAmtCaption(): Text
    var
        RecGLSetup: Record "General Ledger Setup";
    begin
        // RecGLSetup.GET;
        // if Rec."Currency Code" <> '' then
        //exit('GSTORVAT,' + DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), TotalPurchaseHeader."Currency Code"))
        // else
        //     exit('GSTORVAT,' + DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), RecGLSetup."LCY Code"));

        CompanyInfo.GET;
        if CompanyInfo."Enable GST caption" then
            exit('GSTORVAT,' + DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), TotalPurchaseHeader."Currency Code"))
        else
            exit(DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), TotalPurchaseHeader."Currency Code"))
    end;

    local procedure GetCustomCaptionClass(Cp: Text): Text
    begin
        exit('GSTORVAT,' + Cp);
    end;
    //T51000-NS AS
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        EditablOnPurch_gBln := true;
        if rec."Document Type" = rec."Document Type"::Invoice then
            if rec."Receipt No." <> '' then
                EditablOnPurch_gBln := false;
    end;
    //T51000-NE AS
    // procedure IsEditableOnPurchaseLine()
    // var
    //     myInt: Integer;
    // begin
    //     if (Rec."Document Type" = Rec."Document Type"::Invoice) AND (Rec."Receipt No." <> '') then

    // end;
    // procedure IsEditableOnPurchaseLine(PurchaseLine: Record "Purchase Line"): Boolean
    // var
    //     DocType: Option "Invoice","Order","Credit Memo","Return Order";
    // begin
    //     if (Rec."Document Type" = DocType::Invoice) and (PurchaseLine."Receipt No." <> '') then
    //         exit(false); // Non-editable
    //     exit(true); // Editable
    // end;
    var
        EditablOnPurch_gBln: Boolean;
        DocumentTotals2: Codeunit "Document Totals";
        CompanyInfo: Record "Company Information";
}