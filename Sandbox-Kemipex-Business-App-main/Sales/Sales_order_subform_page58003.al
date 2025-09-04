// pageextension 58003 SOLine extends "Sales Order Subform"//T12370-Full Comment
// {
//     layout
//     {
       
        //     {
        //         addbefore(Description)
        //         {
        //             field("Variant Code1"; rec."Variant Code")
        //             {
        //                 Visible = true;
        //                 Editable = true;
        //                 Caption = 'Variant Code';
        //                 ApplicationArea = all;

        //                 trigger OnLookup(var Text: Text): Boolean
        //                 var
        //                     ItemVariant: Record "Item Variant";
        //                     ItemVariantPage: Page "Item Variants";
        //                 begin
        //                     ItemVariant.Reset();
        //                     ItemVariant.FilterGroup(2);
        //                     ItemVariant.SetRange("Item No.", Rec."No.");
        //                     ItemVariant.SetRange(Blocked1, false);
        //                     Clear(ItemVariantPage);
        //                     ItemVariantPage.SetRecord(ItemVariant);
        //                     ItemVariantPage.SetTableView(ItemVariant);
        //                     ItemVariantPage.LookupMode(true);
        //                     if ItemVariantPage.RunModal() = Action::LookupOK then begin
        //                         ItemVariantPage.GetRecord(ItemVariant);
        //                         Rec."Variant Code" := ItemVariant.Code;
        //                         rec.Validate("Variant Code");
        //                     end;
        //                     ItemVariant.FilterGroup(0);
        //                 end;
        //             }
        //         }
        //         modify("Variant Code")
        //         {
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
        //         modify("Item Reference No.") // Cross referece changed to Item Reference No.
        //         {
        //             Visible = true;
        //         }
        //         modify(CountryOfOrigin)
        //         {
        //             Visible = true;
        //             Editable = false;
        //         }
        //         modify(HSNCode)
        //         {
        //             Visible = true;
        //             Editable = false;
        //         }
        //         modify("Drop Shipment")
        //         {
        //             Visible = true;
        //         }
        //         modify("Promised Delivery Date")
        //         {
        //             Visible = true;
        //             Caption = 'Proposed Delivery Date';
        //             ApplicationArea = All;
        //             Editable = true;
        //         }
        //         modify("Shortcut Dimension 2 Code")
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
        //         modify(ShortcutDimCode7)
        //         {
        //             Visible = false;
        //         }
        //         modify(ShortcutDimCode8)
        //         {
        //             Visible = false;
        //         }
        //         modify(BillOfExit)
        //         {
        //             Visible = false;
        //         }
        //         modify("Shipment Date")
        //         {
        //             Visible = false;
        //         }
        //         // modify("Qty. per Unit of Measure")
        //         // {
        //         //     Visible = false;
        //         // }
        //         // modify("Shipment Packing")
        //         // {
        //         //     Visible = false;
        //         // }
        //         // modify("Shipment Method")
        //         // {
        //         //     Visible = false;
        //         // }
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
        //         // modify("Container No.")
        //         // {
        //         //     Visible = false;
        //         // }
        //         modify("Qty. to Assemble to Order")
        //         {
        //             Visible = false;
        //         }
        //         modify("Line Discount %")
        //         {
        //             Visible = false;
        //         }
        //         modify("Unit Price")
        //         {
        //             Visible = false;
        //             CaptionClass = GetCustomCaptionClass(Rec.FieldCaption("Unit Price"));
        //             trigger OnAfterValidate()
        //             begin
        //                 CurrPage.Update(false);
        //             end;
        //         }
        //         modify("Planned Delivery Date")
        //         {
        //             Visible = false;
        //         }
        //         modify("Planned Shipment Date")
        //         {
        //             Visible = false;
        //         }
        //         // modify("No. of Load")
        //         // {
        //         //     Visible = false;
        //         // }
        //         modify("Blanket Order No.")
        //         {
        //             Editable = false;
        //         }
        //         modify("Blanket Order Line No.")
        //         {
        //             Editable = false;
        //         }
        //         modify("Profit % IC")
        //         {
        //             Visible = false;
        //         }
        //         addafter("Quantity Invoiced")
        //         {
        //             field("IC Related SO"; rec."IC Related SO")
        //             {
        //                 ApplicationArea = all;
        //                 Editable = false;
        //             }

        //             field("Qty. to Ship (Base)"; Rec."Qty. to Ship (Base)")
        //             {
        //                 ApplicationArea = All;
        //                 Editable = false;
        //             }
        //             field("Qty. to Invoice (Base)"; Rec."Qty. to Invoice (Base)")
        //             {
        //                 ApplicationArea = all;
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
        //         }
        //         moveafter(Description; "Location Code")
        //         // moveafter(LineCountryOfOrigin; "Line Generic Name")
        //         moveafter("Location Code"; "Drop Shipment")
        //         moveafter("Drop Shipment"; "Allow Loose Qty.")
        //         moveafter("Allow Loose Qty."; "Unit of Measure Code")
        //         moveafter("Unit of Measure Code"; Quantity)
        //         moveafter(Quantity; "Base UOM 2")
        //         // moveafter("Base UOM"; "Quantity (Base)")
        //         // moveafter("Quantity (Base)"; "Unit Price Base UOM")
        // moveafter("Unit Price Base UOM 2"; "Line Amount")

        //         addafter("Base UOM 2")
        //         {
        //             field("Quantity (Base)"; rec."Quantity (Base)")
        //             {
        //                 ApplicationArea = all;
        //                 Editable = false;
        //             }
        //         }
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
        //         modify("TotalSalesLine.""Line Amount""")
        //         {
        //             CaptionClass = SubTotalAmtExcVATCaption;
        //         }
        //         modify("Invoice Discount Amount")
        //         {
        //             CaptionClass = InvDiscAmtCaption;
        //         }
        //         modify("Line Amount")
        //         {
        //             CaptionClass = GetCustomCaptionClass(Rec.FieldCaption("Line Amount"));
        //             Enabled = false;//19-10-2022
        //         }
        //         modify("Unit Price Base UOM 2")
        //         {
        //             StyleExpr = UnitPriceStyle;
        //             trigger OnAfterValidate()
        //             begin
        //                 SetExpr();
        //             end;
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
        //     }
        //     actions
        //     {
        //         movebefore("F&unctions"; ItemTrackingLines)
        //         // movebefore(ItemTrackingLines; "Copy IC Sales Lines")
        //         movebefore(ItemTrackingLines; Reserve)
        //         moveafter(Reserve; "Item Charge &Assignment")
        //         moveafter(ItemTrackingLines; DocumentLineTracking)

        //         modify("Copy IC Sales Lines")
        //         {
        //             Visible = false;
        //         }

        //         addbefore(Reserve)
        //         {
        //             action("Copy IC Sale Lines")
        //             {
        //                 ApplicationArea = all;
        //                 Image = Copy;
        //                 Promoted = true;

        //                 trigger OnAction()
        //                 var
        //                     ItemL: Record Item;
        //                     SalesHeaderL: Record "Sales Header";
        //                     SalesLineL: Record "Sales Line";
        //                     PageSalesOrderListL: Page KMP_ICSalesOrderList;
        //                     ICPartnerL: Record "IC Partner";
        //                     ICProfitMarginL: Record "Intercompany Profit Margin";
        //                     CurrExchRateL: Record "Currency Exchange Rate";
        //                     GLSetupL: Record "General Ledger Setup";
        //                     GLSetup2L: Record "General Ledger Setup";
        //                     UnitCostLCY: Decimal;
        //                     CostDifferenceL: Decimal;
        //                     CostZeroMsg: Label 'The cost for the Item %1 is 0.';
        //                     profit: Decimal;
        //                     IC_SalespriceLCY: Decimal;
        //                     CustomerPriceLCY: Decimal;
        //                     Itemvariant: Record "Item Variant";
        //                     Salesorer: Page "Sales Order";

        //                 begin
        //                     GLSetupL.Get();
        //                     SalesHeaderL.Get(rec."Document Type", rec."Document No.");
        //                     SalesHeaderL.TestField(Status, SalesHeaderL.Status::Open);
        //                     SalesHeaderL.TestField("Sell-to IC Partner Code");
        //                     ICPartnerL.Get(SalesHeaderL."Sell-to IC Partner Code");
        //                     ICPartnerL.TestField("Inbox Type", ICPartnerL."Inbox Type"::Database);
        //                     PageSalesOrderListL.InitTempTable(SalesHeaderL."Sell-to IC Partner Code");
        //                     PageSalesOrderListL.LookupMode(true);
        //                     if PageSalesOrderListL.RunModal() = Action::LookupOK then begin
        //                         PageSalesOrderListL.GetRecord(SalesHeaderL);
        //                         if not Confirm(StrSubstNo(CopyICLinesQst, SalesHeaderL."No.", SalesHeaderL."Posting Description"), false) then
        //                             exit;
        //                         SalesLineL.SetRange("Document Type", rec."Document Type");
        //                         SalesLineL.SetRange("Document No.", rec."Document No.");
        //                         if not SalesLineL.IsEmpty then
        //                             if Confirm(StrSubstNo(OverrideLinesQst, Rec."Document No."), false) then
        //                                 SalesLineL.DeleteAll()
        //                             else
        //                                 exit;
        //                         Clear(SalesLineL);
        //                         if ICProfitMarginL.Get(CompanyName, ICPartnerL."Inbox Details") then;
        //                         SalesLineL.ChangeCompany(SalesHeaderL."Posting Description");
        //                         GLSetup2L.ChangeCompany(SalesHeaderL."Posting Description");
        //                         GLSetup2L.Get();
        //                         SalesLineL.SetRange("Document Type", SalesHeaderL."Document Type");
        //                         SalesLineL.SetRange("Document No.", SalesHeaderL."No.");
        //                         SalesLineL.SetRange(Type, rec.Type::Item);
        //                         if SalesLineL.IsEmpty then
        //                             Error(NoLinesToCopyErr, SalesHeaderL."No.");
        //                         SalesLineL.FindSet();
        //                         repeat
        //                             UnitCostLCY := 0;
        //                             CostDifferenceL := 0;
        //                             Rec.Init();
        //                             Rec."Line No." := SalesLineL."Line No.";
        //                             Rec.Validate(Type, SalesLineL.Type);
        //                             Rec.Validate("No.", SalesLineL."No.");
        //                             Rec.Insert(true);
        //                             Rec."IC Copy" := true;
        //                             Rec.validate("Unit of Measure Code", SalesLineL."Unit of Measure Code");
        //                             Rec."IC Copy" := false;
        //                             Rec.Validate(Quantity, SalesLineL.Quantity);

        //                             if ItemL.Get(SalesLineL."No.") then begin
        //                                 UnitCostLCY := ItemL."Unit Cost";
        //                                 IC_SalespriceLCY := ((UnitCostLCY / 100) * ICProfitMarginL."Profit Margin %") + UnitCostLCY;

        //                                 CustomerPriceLCY := CurrExchRateL.ExchangeAmtFCYToFCY(Today, SalesLineL."Currency Code", '', SalesLineL."Unit Price Base UOM 2"); //PackingListExtChange
        //                             end;

        //                             if UnitCostLCY = 0 then
        //                                 Message(StrSubstNo(CostZeroMsg, SalesLineL."No."))
        //                             else
        //                                 if ICProfitMarginL."Profit Margin %" > 0 then begin
        //                                     // if CustomerPriceLCY > IC_SalespriceLCY then begin // hide by Baya
        //                                     if rec."Currency Code" = '' then
        //                                         rec.Validate("Unit Price Base UOM 2", Round(IC_SalespriceLCY, 5, '=')) //PackingListExtChange
        //                                     else
        //                                         rec.Validate("Unit Price Base UOM 2", Round(CurrExchRateL.ExchangeAmtFCYToFCY(Today, '', rec."Currency Code", IC_SalespriceLCY), 5, '=')); //PackingListExtChange
        //                                 end
        //                                 else begin
        //                                     if rec."Currency Code" <> '' then
        //                                         rec.Validate("Unit Price Base UOM 2", Round(CurrExchRateL.ExchangeAmtFCYToFCY(Today, '', rec."Currency Code", UnitCostLCY), 5, '=')) //PackingListExtChange
        //                                     else
        //                                         rec.Validate("Unit Price Base UOM 2", Round(UnitCostLCY, 5, '='));
        //                                 end;

        //                             rec."Customer Requested Unit Price" := rec."Unit Price Base UOM 2"; //added by baya
        //                             rec."Location Code" := SalesLineL."Location Code";
        //                             rec."IC Customer" := SalesHeaderL."Sell-to Customer Name";
        //                             rec."IC Related SO" := SalesHeaderL."No.";
        //                             if SalesLineL."Variant Code" <> '' then begin
        //                                 If not Itemvariant.Get(SalesLineL."No.", SalesLineL."Variant Code") then

        //                                     //Itemvariant.SetRange("Item No.", SalesLineL."No.");
        //                                     //Itemvariant.SetRange(Code, SalesLineL."Variant Code");
        //                                     //if not Itemvariant.FindFirst() then
        //                                     Error(ItemVariantErr, SalesLineL."No.", SalesLineL."Variant Code")
        //                                 else begin
        //                                     Rec."Variant Code" := SalesLineL."Variant Code";
        //                                     Rec.LineCountryOfOrigin := Itemvariant.CountryOfOrigin;
        //                                     Rec.HSNCode := Itemvariant.HSNCode;
        //                                     rec.CountryOfOrigin := Itemvariant.CountryOfOrigin;
        //                                     Rec.LineHSNCode := Itemvariant.HSNCode;
        //                                 end;

        //                             end;
        //                             rec.Modify(true);
        //                         until SalesLineL.Next() = 0;
        //                         CurrPage.Update();
        //                     end;
        //                 end;
        //             }
        //         }
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

        //     var
        //         DocumentTotals2: Codeunit "Document Totals";
        //         CompanyInfo: Record "Company Information";
        //         UnitPriceStyle: Text;
        //         CopyICLinesQst: Label 'Do you want to copy the lines from Sales Order %1 and Company %2?';
        //         NoLinesToCopyErr: Label 'There are no lines in Sales Order %1 to copy!!';
        //         OverrideLinesQst: Label 'There are lines exist in Sales Order %1. Do you want to override the existing lines?';
//         //         ItemVariantErr: Label 'Copied item %1 variant code %2 is not available in item variant table';
//     }
// }
