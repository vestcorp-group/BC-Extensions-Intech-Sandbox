pageextension 58178 PostedSalesinvoiceSubform extends "Posted Sales Invoice Subform"//T12370-Full Comment 
{
    layout
    {

        addafter("Item Generic Name")
        {
            field(LineHSNCode; rec.LineHSNCode)//T13796-MIG
            {
                ApplicationArea = all;
                Caption = 'Line HS Code';
            }
            field(LineCountryOfOrigin; rec.LineCountryOfOrigin)//T13796-MIG
            {
                ApplicationArea = all;
                Caption = 'Line Country of Origin';
            }
            field("Item Incentive Point (IIP)"; Rec."Item Incentive Point (IIP)")//Hypercare 07-03-2025
            {
                ApplicationArea = All;
                Editable = false;
            }
            // field("Location Code1"; Rec."Location Code")
            // {
            //     Caption = 'Location Code';
            //     ApplicationArea = all;
            //     Editable = false;
            // }
        }
        // addlast(Control1)
        // {
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
        // modify("Variant Code")
        // {
        //     ApplicationArea = All;
        //     Visible = true;
        //     trigger OnLookup(var Text: Text): Boolean
        //     var
        //         ItemVariant: Record "Item Variant";
        //         ItemVariantPage: Page "Item Variants";
        //     begin
        //         ItemVariant.Reset();
        //         ItemVariant.FilterGroup(2);
        //         ItemVariant.SetRange("Item No.", Rec."No.");
        //         ItemVariant.SetRange(Blocked1, false);
        //         Clear(ItemVariantPage);
        //         ItemVariantPage.SetRecord(ItemVariant);
        //         ItemVariantPage.SetTableView(ItemVariant);
        //         ItemVariantPage.LookupMode(true);
        //         if ItemVariantPage.RunModal() = Action::LookupOK then begin
        //             ItemVariantPage.GetRecord(ItemVariant);
        //             Rec."Variant Code" := ItemVariant.Code;
        //             rec.Validate("Variant Code");
        //         end;
        //         ItemVariant.FilterGroup(0);
        //     end;
        // }

        // addafter("Container No.")
        // {
        //     field("Net Weight"; rec."Net Weight")
        //     {
        //         ApplicationArea = all;
        //     }
        //     field("Gross Weight"; rec."Gross Weight")
        //     {
        //         ApplicationArea = all;
        //     }
        // }
        // modify("Line Discount %")
        // {
        //     Visible = false;
        // }
        // modify("Deferral Code")
        // {
        //     Visible = false;
        // }
        // modify("Shortcut Dimension 1 Code")
        // {
        //     Visible = false;
        // }
        // modify("Shortcut Dimension 2 Code")
        // {
        //     Visible = false;
        // }
        // modify("Shipment Method")
        // {
        //     Visible = false;
        // }
        // modify("Shipment Packing")
        // {
        //     Visible = false;
        // }
        // modify("Packing Qty")
        // {
        //     Visible = false;
        // }
        // modify("Packing Gross Weight")
        // {
        //     Visible = false;
        // }
        // modify("Packing Net Weight")
        // {
        //     Visible = false;
        // }
        // modify("No. of Load")
        // {
        //     Visible = false;
        // }
        // modify("ShortcutDimCode[3]")
        // {
        //     Visible = false;
        // }

        // modify("ShortcutDimCode[4]")
        // {
        //     Visible = false;
        // }
        // modify("ShortcutDimCode[5]")
        // {
        //     Visible = false;
        // }
        // modify("ShortcutDimCode[6]")
        // {
        //     Visible = false;
        // }
        // // modify("Qty. per Unit of Measure")
        // // {
        // //     Visible = false;
        // // }
        // moveafter("No."; Description)
        // moveafter("Line Generic Name"; "Base UOM 2") //PackingListExtChange
        // moveafter("Base UOM 2"; "Unit Price Base UOM 2")
        // moveafter("Unit of Measure Code"; Quantity)

        // //GST
        // modify("Total VAT Amount")
        // {
        //     CaptionClass = GetTotalVATCaption();
        // }
        // modify("Total Amount Excl. VAT")
        // {
        //     CaptionClass = GetTotalAmtExcVATCaption;
        // }
        // modify("Total Amount Incl. VAT")
        // {
        //     CaptionClass = GetTotalAmtIncVATCaption;
        // }
        // modify("Invoice Discount Amount")
        // {
        //     CaptionClass = InvDiscAmtCaption;
        // }
        // modify("Unit Price")
        // {
        //     Visible = false;
        //     CaptionClass = GetCustomCaptionClass(Rec.FieldCaption("Unit Price"));
        // }
        // modify("Line Amount")
        // {
        //     Editable = false;
        //     Visible = false;
        //     CaptionClass = GetCustomCaptionClass(Rec.FieldCaption("Line Amount"));
        // }
    }

    actions
    {
        // Add changes to page actions here
        //08-08-2022-start
        /* addlast("&Line")
        {
            action("Update Line")
            {
                ApplicationArea = All;
                Image = UpdateDescription;
                // Promoted = true;
                // PromotedOnly = true;
                trigger OnAction()
                var
                    RecLine: Record "Sales Invoice Line";
                    UpdateInvoiceLine: Page "Update Sales Inv Line";
                    UserSetup: Record "User Setup";
                begin
                    UserSetup.GET(UserId);
                    if not UserSetup."Modify Posted Sales Inv. Line" then
                        Error('You do not have permission to modify Posted Sales Invoice Line.');
                    Clear(RecLine);
                    RecLine.SetRange("Document No.", Rec."Document No.");
                    RecLine.SetRange("Line No.", Rec."Line No.");
                    RecLine.FindFirst();
                    Clear(UpdateInvoiceLine);
                    UpdateInvoiceLine.SetTableView(RecLine);
                    UpdateInvoiceLine.RunModal();
                end;
            }
        } */
        //08-08-2022-end
    }

    local procedure GetTotalVATCaption(): Text
    var
        RecGLSetup: Record "General Ledger Setup";
    begin
        // RecGLSetup.GET;
        // if Rec."Currency Code" <> '' then
        //     exit('GSTORVAT,' + DocumentTotals2.GetTotalVATCaption(Rec."Currency Code"))
        // else
        //     exit('GSTORVAT,' + DocumentTotals2.GetTotalVATCaption(RecGLSetup."LCY Code"));
        CompanyInfo.GET;
        If CompanyInfo."Enable GST caption" then
            exit('GSTORVAT,' + DocumentTotals2.GetTotalVATCaption(TotalSalesInvoiceHeader."Currency Code"))
        else
            exit(DocumentTotals2.GetTotalVATCaption(TotalSalesInvoiceHeader."Currency Code"))

    end;

    local procedure GetTotalAmtExcVATCaption(): Text
    var
        RecGLSetup: Record "General Ledger Setup";
    begin
        // RecGLSetup.GET;
        // if Rec."Currency Code" <> '' then
        //     exit('GSTORVAT,' + DocumentTotals2.GetTotalExclVATCaption(Rec."Currency Code"))
        // else
        //     exit('GSTORVAT,' + DocumentTotals2.GetTotalExclVATCaption(RecGLSetup."LCY Code"));
        CompanyInfo.GET;
        If CompanyInfo."Enable GST caption" then
            exit('GSTORVAT,' + DocumentTotals2.GetTotalExclVATCaption(TotalSalesInvoiceHeader."Currency Code"))
        else
            exit(DocumentTotals2.GetTotalExclVATCaption(TotalSalesInvoiceHeader."Currency Code"))
    end;

    local procedure GetTotalAmtIncVATCaption(): Text
    var
        RecGLSetup: Record "General Ledger Setup";
    begin
        // RecGLSetup.GET;
        // if Rec."Currency Code" <> '' then
        //     exit('GSTORVAT,' + DocumentTotals2.GetTotalInclVATCaption(Rec."Currency Code"))
        // else
        //     exit('GSTORVAT,' + DocumentTotals2.GetTotalInclVATCaption(RecGLSetup."LCY Code"));

        CompanyInfo.GET;
        If CompanyInfo."Enable GST caption" then
            exit('GSTORVAT,' + DocumentTotals2.GetTotalInclVATCaption(TotalSalesInvoiceHeader."Currency Code"))
        else
            exit(DocumentTotals2.GetTotalInclVATCaption(TotalSalesInvoiceHeader."Currency Code"))
    end;

    local procedure SubTotalAmtExcVATCaption(): Text
    var
        RecGLSetup: Record "General Ledger Setup";
    begin
        // RecGLSetup.GET;
        // if Rec."Currency Code" <> '' then
        //     exit('GSTORVAT,' + DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(Rec."Currency Code", TotalSalesInvoiceHeader."Prices Including VAT"))
        // else
        //     exit('GSTORVAT,' + DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(RecGLSetup."LCY Code", TotalSalesInvoiceHeader."Prices Including VAT"));
        CompanyInfo.GET;
        If CompanyInfo."Enable GST caption" then
            exit('GSTORVAT,' + DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(TotalSalesInvoiceHeader."Currency Code", TotalSalesInvoiceHeader."Prices Including VAT"))
        else
            exit(DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(TotalSalesInvoiceHeader."Currency Code", TotalSalesInvoiceHeader."Prices Including VAT"))
    end;

    local procedure InvDiscAmtCaption(): Text
    var
        RecGLSetup: Record "General Ledger Setup";
    begin
        // RecGLSetup.GET;
        // if Rec."Currency Code" <> '' then
        //     exit('GSTORVAT,' + DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), Rec."Currency Code"))
        // else
        //     exit('GSTORVAT,' + DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), RecGLSetup."LCY Code"));

        CompanyInfo.GET;
        If CompanyInfo."Enable GST caption" then
            exit('GSTORVAT,' + DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), TotalSalesInvoiceHeader."Currency Code"))
        else
            exit(DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), TotalSalesInvoiceHeader."Currency Code"))
    end;

    local procedure GetCustomCaptionClass(Cp: Text): Text
    begin
        exit('GSTORVAT,' + Cp);
    end;

    var
        DocumentTotals2: Codeunit "Document Totals";
        CompanyInfo: Record "Company Information";
}