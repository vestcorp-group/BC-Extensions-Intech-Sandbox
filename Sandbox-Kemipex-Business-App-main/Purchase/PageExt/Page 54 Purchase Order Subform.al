pageextension 58012 POLine extends "Purchase Order Subform"//T12370-Full Comment
{
    layout
    {


        //         modify("Planned Receipt Date")
        //         {
        //             Visible = false;
        //         }
        //         modify("Expected Receipt Date")
        //         {
        //             Visible = false;
        //         }
        //         modify("Shortcut Dimension 2 Code")
        //         {
        //             Visible = false;
        //         }
        //         // modify("Total VAT Amount")
        //         // {
        //         //     Visible = true;
        //         // }
        //T13620-NS
        // modify(CustomETA)
        // {
        //     Caption = 'ETA';
        // }
        // modify(CustomETD)
        // {
        //     Caption = 'ETD';
        // }
        // modify(CustomR_ETA)
        // {
        //     Caption = 'R-ETA';
        // }
        // modify(CustomR_ETD)
        // {
        //     Caption = 'R-ETD';
        // }
        //T13620-NE
        //         modify("Bin Code")
        //         {
        //             Visible = false;
        //         }
        //         modify(CustomBOENumber)
        //         {
        //             Visible = false;
        //         }
        //         modify("Shortcut Dimension 1 Code")
        //         {
        //             Visible = false;
        //         }
        //         modify(ShortcutDimCode3)
        //         {
        //             Visible = false;
        //         }
        //         modify(ShortcutDimCode4)
        //         {
        //             Visible = false;
        //         }
        //         modify(ShortcutDimCode5)
        //         {
        //             Visible = false;
        //         }
        //         modify(ShortcutDimCode6)
        //         {
        //             Visible = false;
        //         }
        //         modify("Promised Receipt Date")
        //         {
        //             Visible = false;
        //         }
        //         modify("Variant Code")
        //         {
        //             Visible = true;
        //             Editable = true;
        //         }
        modify(Description) //T13700-N
        {
            Caption = 'Vendor Description';
        }
        addafter(Description)
        {
            //             field("Item COO"; rec.Item_COO)
            //             {
            //                 ApplicationArea = all;
            //                 Editable = false;
            //             }
            //             field(Item_Manufacturer_Description; rec.Item_Manufacturer_Description)
            //             {
            //                 ApplicationArea = all;
            //             }
            field(Item_short_name; rec.Item_short_name) //T13700
            {
                Caption = 'Commercial Name';
                ApplicationArea = all;
            }
            field("Item HS Code"; rec."Item HS Code")//T13386-N
            {
                ApplicationArea = all;
                Editable = false;
            }

            field("Salesperson Code"; Rec."Salesperson Code")
            {
                ApplicationArea = All;
            }
        }
        addbefore("Direct Unit Cost")
        {
            field("Base UOM"; rec."Base UOM")
            {
                ApplicationArea = all;
                Editable = false;
            }
            //             field("Quantity (Base)"; rec."Quantity (Base)")
            //             {
            //                 ApplicationArea = all;
            //                 Caption = 'Base UOM Qty.';
            //                 Editable = false;
            //             }
            field("Unit Price Base UOM"; rec."Unit Price Base UOM")
            {
                ApplicationArea = all;
            }
        }
        //         movebefore("Qty. to Invoice"; "Quantity Received")
        //         movebefore("Quantity Received"; "Qty. to Receive")
        //         moveafter(CustomR_ETA; "Container No. 2")
        //         moveafter(CustomR_ETA; "Reserved Quantity")
        //         moveafter("Unit of Measure Code"; Quantity)

        //         //GST
        //         modify(AmountBeforeDiscount)
        //         {
        //             CaptionClass = SubTotalAmtExcVATCaption;
        //         }
        //         modify("Invoice Discount Amount")
        //         {
        //             CaptionClass = InvDiscAmtCaption;
        //         }
        //         modify("Total Amount Excl. VAT")
        //         {
        //             CaptionClass = GetTotalAmtExcVATCaption;
        //         }
        //         modify("Total VAT Amount")
        //         {
        //             Visible = false;
        //             CaptionClass = GetTotalVATCaption();
        //         }
        //         modify("Total Amount Incl. VAT")
        //         {
        //             CaptionClass = GetTotalAmtIncVATCaption;
        //         }

        //         modify("Line Amount")
        //         {
        //             CaptionClass = GetCustomCaptionClass(Rec.FieldCaption("Line Amount"));
        //         }
        //         modify("Direct Unit Cost")
        //         {
        //             Visible = false;
        //             CaptionClass = GetCustomCaptionClass(Rec.FieldCaption("Direct Unit Cost"));
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
        //         modify("Profit % IC")
        //         {
        //             Visible = false;
        //         }
        //         addafter("Quantity Received")
        //         {
        //             field("Qty. to Receive (Base)"; rec."Qty. to Receive (Base)")
        //             {
        //                 ApplicationArea = all;
        //             }
        //             field("Qty. Received (Base)"; rec."Qty. Received (Base)")
        //             {
        //                 ApplicationArea = all;
        //             }
        //         }
        //         addafter("Quantity Invoiced")
        //         {
        //             field("Qty. to Invoice (Base)"; rec."Qty. to Invoice (Base)")
        //             {
        //                 ApplicationArea = all;
        //             }
        //             field("Qty. Invoiced (Base)"; rec."Qty. Invoiced (Base)")
        //             {
        //                 ApplicationArea = all;
        //             }
        //         }

    }
    //     actions
    //     {

    //     }

    //     local procedure GetTotalVATCaption(): Text
    //     var
    //         RecGLSetup: Record "General Ledger Setup";
    //     begin
    //         // CompanyInfo.GET;
    //         // if not CompanyInfo."Enable GST caption" then
    //         //     exit(DocumentTotals2.GetTotalVATCaption(TotalPurchaseHeader."Currency Code"));
    //         // RecGLSetup.GET;
    //         // if Rec."Currency Code" <> '' then
    //         //exit('GSTORVAT,' + DocumentTotals2.GetTotalVATCaption(Rec."Currency Code"));
    //         // else
    //         //   exit('GSTORVAT,' + DocumentTotals2.GetTotalVATCaption(RecGLSetup."LCY Code"));
    //         CompanyInfo.GET;
    //         if CompanyInfo."Enable GST caption" then
    //             exit('GSTORVAT,' + DocumentTotals2.GetTotalVATCaption(TotalPurchaseHeader."Currency Code"))
    //         else
    //             exit(DocumentTotals2.GetTotalVATCaption(TotalPurchaseHeader."Currency Code"))


    //     end;

    //     local procedure GetTotalAmtExcVATCaption(): Text
    //     var
    //         RecGLSetup: Record "General Ledger Setup";
    //     begin
    //         // RecGLSetup.GET;
    //         // if Rec."Currency Code" <> '' then
    //         // exit('GSTORVAT,' + DocumentTotals2.GetTotalExclVATCaption(TotalPurchaseHeader."Currency Code"))
    //         // else
    //         //     exit('GSTORVAT,' + DocumentTotals2.GetTotalExclVATCaption(RecGLSetup."LCY Code"));
    //         CompanyInfo.GET;
    //         if CompanyInfo."Enable GST caption" then
    //             exit('GSTORVAT,' + DocumentTotals2.GetTotalExclVATCaption(TotalPurchaseHeader."Currency Code"))
    //         else
    //             exit(DocumentTotals2.GetTotalExclVATCaption(TotalPurchaseHeader."Currency Code"))
    //     end;

    //     local procedure GetTotalAmtIncVATCaption(): Text
    //     var
    //         RecGLSetup: Record "General Ledger Setup";
    //     begin
    //         // RecGLSetup.GET;
    //         // if Rec."Currency Code" <> '' then
    //         //exit('GSTORVAT,' + DocumentTotals2.GetTotalInclVATCaption(TotalPurchaseHeader."Currency Code"))
    //         // else
    //         //     exit('GSTORVAT,' + DocumentTotals2.GetTotalInclVATCaption(RecGLSetup."LCY Code"));

    //         CompanyInfo.GET;
    //         if CompanyInfo."Enable GST caption" then
    //             exit('GSTORVAT,' + DocumentTotals2.GetTotalInclVATCaption(TotalPurchaseHeader."Currency Code"))
    //         else
    //             exit(DocumentTotals2.GetTotalInclVATCaption(TotalPurchaseHeader."Currency Code"))
    //     end;

    //     local procedure SubTotalAmtExcVATCaption(): Text
    //     var
    //         RecGLSetup: Record "General Ledger Setup";
    //     begin
    //         // RecGLSetup.GET;
    //         // if Rec."Currency Code" <> '' then
    //         //exit('GSTORVAT,' + DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(TotalPurchaseHeader."Currency Code", TotalPurchaseHeader."Prices Including VAT"))
    //         // else
    //         //     exit('GSTORVAT,' + DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(RecGLSetup."LCY Code", TotalPurchaseHeader."Prices Including VAT"));

    //         CompanyInfo.GET;
    //         if CompanyInfo."Enable GST caption" then
    //             exit('GSTORVAT,' + DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(TotalPurchaseHeader."Currency Code", TotalPurchaseHeader."Prices Including VAT"))
    //         else
    //             exit(DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(TotalPurchaseHeader."Currency Code", TotalPurchaseHeader."Prices Including VAT"))
    //     end;

    //     local procedure InvDiscAmtCaption(): Text
    //     var
    //         RecGLSetup: Record "General Ledger Setup";
    //     begin
    //         // RecGLSetup.GET;
    //         // if Rec."Currency Code" <> '' then
    //         //exit('GSTORVAT,' + DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), TotalPurchaseHeader."Currency Code"))
    //         // else
    //         //     exit('GSTORVAT,' + DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), RecGLSetup."LCY Code"));

    //         CompanyInfo.GET;
    //         if CompanyInfo."Enable GST caption" then
    //             exit('GSTORVAT,' + DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), TotalPurchaseHeader."Currency Code"))
    //         else
    //             exit(DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), TotalPurchaseHeader."Currency Code"))
    //     end;

    //     local procedure GetCustomCaptionClass(Cp: Text): Text
    //     begin
    //         exit('GSTORVAT,' + Cp);
    //     end;

    //     var
    //         DocumentTotals2: Codeunit "Document Totals";
    //         CompanyInfo: Record "Company Information";
}