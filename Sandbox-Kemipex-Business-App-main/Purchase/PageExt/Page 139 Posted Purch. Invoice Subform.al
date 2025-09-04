pageextension 58077 posted_purchase_inv_subform extends "Posted Purch. Invoice Subform"//T12370-Full Comment
{
    layout
    {
        addafter(Description)
        {
            // field("Variant Code1"; rec."Variant Code")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Variant Code';
            // }
            // field("Item COO"; rec.Item_COO)
            // {
            //     ApplicationArea = all;
            // }
            field(Item_Manufacturer_Description; rec.Item_Manufacturer_Description)
            {
                ApplicationArea = all;
            }
            field(Item_short_name; rec.Item_short_name)//T13700
            {
                ApplicationArea = all;
            }
            field("Item HS Code"; rec."Item HS Code")//T13386-N
            {
                ApplicationArea = all;
            }

        }
        // addlast(Control1)
        // {
        //     field("Item Incentive Point (IIP)"; Rec."Item Incentive Point (IIP)")
        //     {
        //         ApplicationArea = All;
        //         Editable = false;
        //     }
        //     field("Transaction Type"; rec."Transaction Type")
        //     {
        //         ApplicationArea = All;
        //         Editable = false;
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

        addbefore("Direct Unit Cost")
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
            }
        }
        // //GST
        // modify("Invoice Discount Amount")
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
    }
    local procedure GetTotalVATCaption(): Text
    var
        RecGLSetup: Record "General Ledger Setup";
    begin
        // CompanyInfo.GET;
        // if not CompanyInfo."Enable GST caption" then
        //     exit(DocumentTotals2.GetTotalVATCaption(TotalPurchInvHeader."Currency Code"));
        // RecGLSetup.GET;
        // if Rec."Currency Code" <> '' then
        //exit('GSTORVAT,' + DocumentTotals2.GetTotalVATCaption(Rec."Currency Code"));
        // else
        //   exit('GSTORVAT,' + DocumentTotals2.GetTotalVATCaption(RecGLSetup."LCY Code"));
        CompanyInfo.GET;
        if CompanyInfo."Enable GST caption" then
            exit('GSTORVAT,' + DocumentTotals2.GetTotalVATCaption(TotalPurchInvHeader."Currency Code"))
        else
            exit(DocumentTotals2.GetTotalVATCaption(TotalPurchInvHeader."Currency Code"))


    end;

    local procedure GetTotalAmtExcVATCaption(): Text
    var
        RecGLSetup: Record "General Ledger Setup";
    begin
        // RecGLSetup.GET;
        // if Rec."Currency Code" <> '' then
        // exit('GSTORVAT,' + DocumentTotals2.GetTotalExclVATCaption(TotalPurchInvHeader."Currency Code"))
        // else
        //     exit('GSTORVAT,' + DocumentTotals2.GetTotalExclVATCaption(RecGLSetup."LCY Code"));
        CompanyInfo.GET;
        if CompanyInfo."Enable GST caption" then
            exit('GSTORVAT,' + DocumentTotals2.GetTotalExclVATCaption(TotalPurchInvHeader."Currency Code"))
        else
            exit(DocumentTotals2.GetTotalExclVATCaption(TotalPurchInvHeader."Currency Code"))
    end;

    local procedure GetTotalAmtIncVATCaption(): Text
    var
        RecGLSetup: Record "General Ledger Setup";
    begin
        // RecGLSetup.GET;
        // if Rec."Currency Code" <> '' then
        //exit('GSTORVAT,' + DocumentTotals2.GetTotalInclVATCaption(TotalPurchInvHeader."Currency Code"))
        // else
        //     exit('GSTORVAT,' + DocumentTotals2.GetTotalInclVATCaption(RecGLSetup."LCY Code"));

        CompanyInfo.GET;
        if CompanyInfo."Enable GST caption" then
            exit('GSTORVAT,' + DocumentTotals2.GetTotalInclVATCaption(TotalPurchInvHeader."Currency Code"))
        else
            exit(DocumentTotals2.GetTotalInclVATCaption(TotalPurchInvHeader."Currency Code"))
    end;

    local procedure SubTotalAmtExcVATCaption(): Text
    var
        RecGLSetup: Record "General Ledger Setup";
    begin
        // RecGLSetup.GET;
        // if Rec."Currency Code" <> '' then
        //exit('GSTORVAT,' + DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(TotalPurchInvHeader."Currency Code", TotalPurchInvHeader."Prices Including VAT"))
        // else
        //     exit('GSTORVAT,' + DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(RecGLSetup."LCY Code", TotalPurchInvHeader."Prices Including VAT"));

        CompanyInfo.GET;
        if CompanyInfo."Enable GST caption" then
            exit('GSTORVAT,' + DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(TotalPurchInvHeader."Currency Code", TotalPurchInvHeader."Prices Including VAT"))
        else
            exit(DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(TotalPurchInvHeader."Currency Code", TotalPurchInvHeader."Prices Including VAT"))
    end;

    local procedure InvDiscAmtCaption(): Text
    var
        RecGLSetup: Record "General Ledger Setup";
    begin
        // RecGLSetup.GET;
        // if Rec."Currency Code" <> '' then
        //exit('GSTORVAT,' + DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), TotalPurchInvHeader."Currency Code"))
        // else
        //     exit('GSTORVAT,' + DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), RecGLSetup."LCY Code"));

        CompanyInfo.GET;
        if CompanyInfo."Enable GST caption" then
            exit('GSTORVAT,' + DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), TotalPurchInvHeader."Currency Code"))
        else
            exit(DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), TotalPurchInvHeader."Currency Code"))
    end;

    local procedure GetCustomCaptionClass(Cp: Text): Text
    begin
        exit('GSTORVAT,' + Cp);
    end;

    var
        DocumentTotals2: Codeunit "Document Totals";
        CompanyInfo: Record "Company Information";
}