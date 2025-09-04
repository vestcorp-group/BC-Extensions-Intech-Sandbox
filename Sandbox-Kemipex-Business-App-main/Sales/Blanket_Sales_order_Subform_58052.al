pageextension 58052 BSO_line extends "Blanket Sales Order Subform"//T12370-Full Comment
{
    layout

    {


        //         modify("Variant Code")
        //         {
        //             Visible = true;
        //             Editable = true;
        //             trigger OnLookup(var Text: Text): Boolean
        //             var
        //                 ItemVariant: Record "Item Variant";
        //                 ItemVariantPage: Page "Item Variants";
        //             begin
        //                 ItemVariant.Reset();
        //                 ItemVariant.FilterGroup(2);
        //                 ItemVariant.SetRange("Item No.", Rec."No.");
        //                 ItemVariant.SetRange(Blocked1, false);
        //                 Clear(ItemVariantPage);
        //                 ItemVariantPage.SetRecord(ItemVariant);
        //                 ItemVariantPage.SetTableView(ItemVariant);
        //                 ItemVariantPage.LookupMode(true);
        //                 if ItemVariantPage.RunModal() = Action::LookupOK then begin
        //                     ItemVariantPage.GetRecord(ItemVariant);
        //                     Rec."Variant Code" := ItemVariant.Code;
        //                     rec.Validate("Variant Code");
        //                 end;
        //                 ItemVariant.FilterGroup(0);
        //             end;
        //         }
        addafter(Description)
        {
            field(HSNCode; rec.HSNCode)
            {
                Editable = false;
                ApplicationArea = all;
                Caption = 'Item HS Code';
            }
            field(CountryOfOrigin; rec.CountryOfOrigin)
            {
                Editable = false;
                ApplicationArea = all;
                Caption = 'Item Country of Origin';
            }
            field(LineHSNCode; rec.LineHSNCode)
            {
                Caption = 'Line HS Code';
                ApplicationArea = all;
            }
            field(LineCountryOfOrigin; rec.LineCountryOfOrigin)
            {
                ApplicationArea = all;
            }
            // field("Unit Price Base UOM 2"; Rec."Unit Price Base UOM 2")
            // {
            //     ApplicationArea = all;
            // }
            //         }
            //         addafter("Location Code")
            //         {
            //             field("Allow Loose Qty."; rec."Allow Loose Qty.")
            //             {
            //                 ApplicationArea = all;
            //             }
            //         }
            //         addafter("Quantity Invoiced")
            //         {
            //             // field("Net Weight"; rec."Net Weight")
            //             // {
            //             //     ApplicationArea = all;
            //             // }
            //             // field("Gross Weight"; rec."Gross Weight")
            //             // {
            //             //     ApplicationArea = all;
            //             // }

            //             field("Qty. to Ship (Base)"; Rec."Qty. to Ship (Base)")
            //             {
            //                 ApplicationArea = All;
            //                 Editable = false;
            //             }

            //             field("Qty. Shipped (Base)"; Rec."Qty. Shipped (Base)")
            //             {
            //                 ApplicationArea = All;
            //                 Editable = false;
            //             }
            //             field("Qty. Invoiced (Base)"; Rec."Qty. Invoiced (Base)")
            //             {
            //                 ApplicationArea = All;
            //                 Editable = false;
            //             }
        }

        //         modify("Unit of Measure Code")
        //         {
        //             ApplicationArea = all;
        //             Caption = 'Unit of Measure';
        //         }
        //         //PackingListExtChange
        //         // modify("Packing Qty")
        //         // {
        //         //     Visible = false;
        //         // }
        //         // modify("Packing Net Weight")
        //         // {
        //         //     Visible = false;
        //         // }
        //         // modify("Packing Gross Weight")
        //         // {
        //         //     Visible = false;
        //         // }
        //         // modify("Shipment Packing")
        //         // {
        //         //     Visible = false;
        //         // }
        //         // modify("No. of Load")
        //         // {
        //         //     Visible = false;
        //         // }
        //         modify("Line Discount %")
        //         {
        //             Visible = false;
        //         }
        //         modify("Shortcut Dimension 1 Code")
        //         {
        //             Visible = false;
        //         }
        //         modify("Shortcut Dimension 2 Code")
        //         {
        //             Visible = false;
        //         }
        //         modify("ShortcutDimCode[3]")
        //         {
        //             Visible = false;
        //         }
        //         modify("ShortcutDimCode[4]")
        //         {
        //             Visible = false;
        //         }
        //         modify("ShortcutDimCode[5]")
        //         {
        //             Visible = false;
        //         }
        //         modify("ShortcutDimCode[6]")
        //         {
        //             Visible = false;
        //         }
        //         modify("ShortcutDimCode[7]")
        //         {
        //             Visible = false;
        //         }
        //         modify("Unit Price")
        //         {
        //             Visible = false;
        //             CaptionClass = GetCustomCaptionClass(Rec.FieldCaption("Unit Price"));
        //         }
        //         modify("Shipment Date")
        //         {
        //             Visible = false;
        //         }
        //         // modify("Shipment Method 2") //PackingListExtChange
        //         // {
        //         //     Visible = false;
        //         // }
        //         modify("Line Amount")
        //         {
        //             Editable = false;
        //             Visible = false;
        //             CaptionClass = GetCustomCaptionClass(Rec.FieldCaption("Line Amount"));
        //         }
        //         // modify("Qty. per Unit of Measure")
        //         // {
        //         //     Visible = false;
        //         // }


        //         moveafter(Description; "Location Code")
        //         moveafter("Location Code"; "Unit of Measure Code")
        //         moveafter("Unit of Measure Code"; Quantity)
        //         moveafter(Quantity; "Unit of Measure")
        //         moveafter("Unit of Measure"; "Base UOM 2") //PackingListExtChange
        //         // moveafter("Base UOM 2"; "Quantity (Base)") //PackingListExtChange
        //         moveafter(CountryOfOrigin; "Item Generic Name")
        //         moveafter(LineCountryOfOrigin; "Line Generic Name")

        //         addafter("Base UOM 2")
        //         {
        //             field("Quantity (Base)"; rec."Quantity (Base)")
        //             {
        //                 ApplicationArea = all;
        //                 Editable = false;
        //             }
        //         }

        //         //GST
        //         //GST
        //         modify("Total VAT Amount")
        //         {
        //             CaptionClass = GetTotalVATCaption();
        //         }
        //         modify("Total Amount Excl. VAT")
        //         {
        //             CaptionClass = GetTotalAmtExcVATCaption;
        //         }
        //         modify("Total Amount Incl. VAT")
        //         {
        //             CaptionClass = GetTotalAmtIncVATCaption;
        //         }
        //         modify(SubtotalExclVAT)
        //         {
        //             CaptionClass = SubTotalAmtExcVATCaption;
        //         }
        //         modify("Invoice Discount Amount")
        //         {
        //             CaptionClass = InvDiscAmtCaption;
        //         }
        //         addlast(Control1)
        //         {
        //             field("Item Incentive Point (IIP)"; Rec."Item Incentive Point (IIP)")
        //             {
        //                 ApplicationArea = All;
        //                 Editable = false;
        //             }
        //             field("Transaction Type"; rec."Transaction Type")
        //             {
        //                 ApplicationArea = all;
        //                 Caption = 'Order Type';
        //             }
        //             field("Container Size"; rec."Container Size")
        //             {
        //                 ApplicationArea = All;
        //             }
        //             field("Shipping Remarks"; rec."Shipping Remarks")
        //             {
        //                 ApplicationArea = All;
        //             }
        //             field("In-Out Instruction"; rec."In-Out Instruction")
        //             {
        //                 ApplicationArea = All;
        //             }
        //             field("Shipping Line"; rec."Shipping Line")
        //             {
        //                 ApplicationArea = All;
        //             }
        //             field("BL-AWB No."; rec."BL-AWB No.")
        //             {
        //                 ApplicationArea = All;
        //             }
        //             field("Vessel-Voyage No."; rec."Vessel-Voyage No.")
        //             {
        //                 ApplicationArea = all;
        //             }
        //             field("Freight Forwarder"; rec."Freight Forwarder")
        //             {
        //                 ApplicationArea = all;
        //             }
        //             field("Freight Charge"; rec."Freight Charge")
        //             {
        //                 ApplicationArea = all;
        //             }
        //         }

        //         //28-09-2022-start
        // modify("Unit Price Base UOM 2")
        // {
        //     StyleExpr = UnitPriceStyle;
        //     trigger OnAfterValidate()
        //     begin
        //         SetExpr();
        //     end;
        // }
        //         //28-09-2022-end

        //     }
        //     actions
        //     {
        //     }

        //     local procedure GetTotalVATCaption(): Text
        //     var
        //         RecGLSetup: Record "General Ledger Setup";
        //     begin
        //         // RecGLSetup.GET;
        //         // if Rec."Currency Code" <> '' then
        //         //     exit('GSTORVAT,' + DocumentTotals2.GetTotalVATCaption(Rec."Currency Code"))
        //         // else
        //         //     exit('GSTORVAT,' + DocumentTotals2.GetTotalVATCaption(RecGLSetup."LCY Code"));
        //         CompanyInfo.GET;
        //         If CompanyInfo."Enable GST caption" then
        //             exit('GSTORVAT,' + DocumentTotals2.GetTotalVATCaption(TotalSalesHeader."Currency Code"))
        //         else
        //             exit(DocumentTotals2.GetTotalVATCaption(TotalSalesHeader."Currency Code"))

        //     end;

        //     local procedure GetTotalAmtExcVATCaption(): Text
        //     var
        //         RecGLSetup: Record "General Ledger Setup";
        //     begin
        //         // RecGLSetup.GET;
        //         // if Rec."Currency Code" <> '' then
        //         //     exit('GSTORVAT,' + DocumentTotals2.GetTotalExclVATCaption(Rec."Currency Code"))
        //         // else
        //         //     exit('GSTORVAT,' + DocumentTotals2.GetTotalExclVATCaption(RecGLSetup."LCY Code"));
        //         CompanyInfo.GET;
        //         If CompanyInfo."Enable GST caption" then
        //             exit('GSTORVAT,' + DocumentTotals2.GetTotalExclVATCaption(TotalSalesHeader."Currency Code"))
        //         else
        //             exit(DocumentTotals2.GetTotalExclVATCaption(TotalSalesHeader."Currency Code"))
        //     end;

        //     local procedure GetTotalAmtIncVATCaption(): Text
        //     var
        //         RecGLSetup: Record "General Ledger Setup";
        //     begin
        //         // RecGLSetup.GET;
        //         // if Rec."Currency Code" <> '' then
        //         //     exit('GSTORVAT,' + DocumentTotals2.GetTotalInclVATCaption(Rec."Currency Code"))
        //         // else
        //         //     exit('GSTORVAT,' + DocumentTotals2.GetTotalInclVATCaption(RecGLSetup."LCY Code"));

        //         CompanyInfo.GET;
        //         If CompanyInfo."Enable GST caption" then
        //             exit('GSTORVAT,' + DocumentTotals2.GetTotalInclVATCaption(TotalSalesHeader."Currency Code"))
        //         else
        //             exit(DocumentTotals2.GetTotalInclVATCaption(TotalSalesHeader."Currency Code"))
        //     end;

        //     local procedure SubTotalAmtExcVATCaption(): Text
        //     var
        //         RecGLSetup: Record "General Ledger Setup";
        //     begin
        //         // RecGLSetup.GET;
        //         // if Rec."Currency Code" <> '' then
        //         //     exit('GSTORVAT,' + DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(Rec."Currency Code", TotalSalesHeader."Prices Including VAT"))
        //         // else
        //         //     exit('GSTORVAT,' + DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(RecGLSetup."LCY Code", TotalSalesHeader."Prices Including VAT"));
        //         CompanyInfo.GET;
        //         If CompanyInfo."Enable GST caption" then
        //             exit('GSTORVAT,' + DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(TotalSalesHeader."Currency Code", TotalSalesHeader."Prices Including VAT"))
        //         else
        //             exit(DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(TotalSalesHeader."Currency Code", TotalSalesHeader."Prices Including VAT"))
        //     end;

        //     local procedure InvDiscAmtCaption(): Text
        //     var
        //         RecGLSetup: Record "General Ledger Setup";
        //     begin
        //         // RecGLSetup.GET;
        //         // if Rec."Currency Code" <> '' then
        //         //     exit('GSTORVAT,' + DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), Rec."Currency Code"))
        //         // else
        //         //     exit('GSTORVAT,' + DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), RecGLSetup."LCY Code"));

        //         CompanyInfo.GET;
        //         If CompanyInfo."Enable GST caption" then
        //             exit('GSTORVAT,' + DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), TotalSalesHeader."Currency Code"))
        //         else
        //             exit(DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), TotalSalesHeader."Currency Code"))
        //     end;

        //     local procedure GetCustomCaptionClass(Cp: Text): Text
        //     begin
        //         exit('GSTORVAT,' + Cp);
        //     end;

        //     //28-09-2022-start
        //     trigger OnAfterGetRecord()
        //     begin
        //         SetExpr();
        //     end;

        //     local procedure SetExpr()
        //     begin
        //         // if (Rec."Price Change %" < 0) AND (Rec."Price Change %" > -2) then
        //         //     UnitPriceStyle := 'Ambiguous'
        //         // else
        //         //     if Rec."Price Change %" <= -2 then
        //         //         UnitPriceStyle := 'Unfavorable'
        //         //     else
        //         //         if Rec."Price Change %" = 0 then
        //         //             UnitPriceStyle := 'None'
        //         //         else
        //         //             if Rec."Price Change %" > 0 then
        //         //                 UnitPriceStyle := 'Favorable'
        //         if (Rec."Price Change %" < 0) then
        //             UnitPriceStyle := 'Unfavorable'
        //         else
        //             UnitPriceStyle := 'None';
        //     end;
        //     //28-09-2022-end
        //     var
        //         DocumentTotals2: Codeunit "Document Totals";
        //         CompanyInfo: Record "Company Information";
        //         UnitPriceStyle: Text;

    }
}