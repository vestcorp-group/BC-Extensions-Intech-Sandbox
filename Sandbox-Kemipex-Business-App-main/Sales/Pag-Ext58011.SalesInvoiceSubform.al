// pageextension 58011 SalesInvSubform extends "Sales Invoice Subform"//T12370-Full Comment-do not open
// {
//     layout
//     {
//         addafter(Description)
//         {
//             field("Unit Price Base UOM 2"; Rec."Unit Price Base UOM 2")
//             {
//                 ApplicationArea = all;
//             }
//         }

//         //         //GST
//         //         modify("Total VAT Amount")
//         //         {
//         //             CaptionClass = GetTotalVATCaption();
//         //         }
//         //         modify("Total Amount Excl. VAT")
//         //         {
//         //             CaptionClass = GetTotalAmtExcVATCaption;
//         //         }
//         //         modify("Total Amount Incl. VAT")
//         //         {
//         //             CaptionClass = GetTotalAmtIncVATCaption;
//         //         }
//         //         modify("TotalSalesLine.""Line Amount""")
//         //         {
//         //             CaptionClass = SubTotalAmtExcVATCaption;
//         //         }
//         //         modify("Invoice Discount Amount")
//         //         {
//         //             CaptionClass = InvDiscAmtCaption;
//         //         }
//         //         modify("Line Amount")
//         //         {
//         //             CaptionClass = GetCustomCaptionClass(Rec.FieldCaption("Line Amount"));
//         //         }
//         //         modify("Unit Price")
//         //         {
//         //             Visible = false;
//         //             CaptionClass = GetCustomCaptionClass(Rec.FieldCaption("Unit Price"));
//         //         }
//         //         addlast(Control1)
//         //         {
//         //             field("Item Incentive Point (IIP)"; Rec."Item Incentive Point (IIP)")
//         //             {
//         //                 ApplicationArea = All;
//         //                 Editable = false;
//         //             }
//         //             field("Transaction Type"; rec."Transaction Type")
//         //             {
//         //                 ApplicationArea = all;
//         //                 Caption = 'Order Type';
//         //             }
//         //             field("Container Size"; rec."Container Size")
//         //             {
//         //                 ApplicationArea = All;
//         //             }
//         //             field("Shipping Remarks"; rec."Shipping Remarks")
//         //             {
//         //                 ApplicationArea = All;
//         //             }
//         //             field("In-Out Instruction"; rec."In-Out Instruction")
//         //             {
//         //                 ApplicationArea = All;
//         //             }
//         //             field("Shipping Line"; rec."Shipping Line")
//         //             {
//         //                 ApplicationArea = All;
//         //             }
//         //             field("BL-AWB No."; rec."BL-AWB No.")
//         //             {
//         //                 ApplicationArea = All;
//         //             }
//         //             field("Vessel-Voyage No."; rec."Vessel-Voyage No.")
//         //             {
//         //                 ApplicationArea = all;
//         //             }
//         //             field("Freight Forwarder"; rec."Freight Forwarder")
//         //             {
//         //                 ApplicationArea = all;
//         //             }
//         //             field("Freight Charge"; rec."Freight Charge")
//         //             {
//         //                 ApplicationArea = all;
//         //             }
//         //         }
//         //     }

//         //     local procedure GetTotalVATCaption(): Text
//         //     var
//         //         RecGLSetup: Record "General Ledger Setup";
//         //     begin
//         //         // RecGLSetup.GET;
//         //         // if Rec."Currency Code" <> '' then
//         //         //     exit('GSTORVAT,' + DocumentTotals2.GetTotalVATCaption(Rec."Currency Code"))
//         //         // else
//         //         //     exit('GSTORVAT,' + DocumentTotals2.GetTotalVATCaption(RecGLSetup."LCY Code"));
//         //         CompanyInfo.GET;
//         //         If CompanyInfo."Enable GST caption" then
//         //             exit('GSTORVAT,' + DocumentTotals2.GetTotalVATCaption(TotalSalesHeader."Currency Code"))
//         //         else
//         //             exit(DocumentTotals2.GetTotalVATCaption(TotalSalesHeader."Currency Code"))

//         //     end;

//         //     local procedure GetTotalAmtExcVATCaption(): Text
//         //     var
//         //         RecGLSetup: Record "General Ledger Setup";
//         //     begin
//         //         // RecGLSetup.GET;
//         //         // if Rec."Currency Code" <> '' then
//         //         //     exit('GSTORVAT,' + DocumentTotals2.GetTotalExclVATCaption(Rec."Currency Code"))
//         //         // else
//         //         //     exit('GSTORVAT,' + DocumentTotals2.GetTotalExclVATCaption(RecGLSetup."LCY Code"));
//         //         CompanyInfo.GET;
//         //         If CompanyInfo."Enable GST caption" then
//         //             exit('GSTORVAT,' + DocumentTotals2.GetTotalExclVATCaption(TotalSalesHeader."Currency Code"))
//         //         else
//         //             exit(DocumentTotals2.GetTotalExclVATCaption(TotalSalesHeader."Currency Code"))
//         //     end;

//         //     local procedure GetTotalAmtIncVATCaption(): Text
//         //     var
//         //         RecGLSetup: Record "General Ledger Setup";
//         //     begin
//         //         // RecGLSetup.GET;
//         //         // if Rec."Currency Code" <> '' then
//         //         //     exit('GSTORVAT,' + DocumentTotals2.GetTotalInclVATCaption(Rec."Currency Code"))
//         //         // else
//         //         //     exit('GSTORVAT,' + DocumentTotals2.GetTotalInclVATCaption(RecGLSetup."LCY Code"));

//         //         CompanyInfo.GET;
//         //         If CompanyInfo."Enable GST caption" then
//         //             exit('GSTORVAT,' + DocumentTotals2.GetTotalInclVATCaption(TotalSalesHeader."Currency Code"))
//         //         else
//         //             exit(DocumentTotals2.GetTotalInclVATCaption(TotalSalesHeader."Currency Code"))
//         //     end;

//         //     local procedure SubTotalAmtExcVATCaption(): Text
//         //     var
//         //         RecGLSetup: Record "General Ledger Setup";
//         //     begin
//         //         // RecGLSetup.GET;
//         //         // if Rec."Currency Code" <> '' then
//         //         //     exit('GSTORVAT,' + DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(Rec."Currency Code", TotalSalesHeader."Prices Including VAT"))
//         //         // else
//         //         //     exit('GSTORVAT,' + DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(RecGLSetup."LCY Code", TotalSalesHeader."Prices Including VAT"));
//         //         CompanyInfo.GET;
//         //         If CompanyInfo."Enable GST caption" then
//         //             exit('GSTORVAT,' + DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(TotalSalesHeader."Currency Code", TotalSalesHeader."Prices Including VAT"))
//         //         else
//         //             exit(DocumentTotals2.GetTotalLineAmountWithVATAndCurrencyCaption(TotalSalesHeader."Currency Code", TotalSalesHeader."Prices Including VAT"))
//         //     end;

//         //     local procedure InvDiscAmtCaption(): Text
//         //     var
//         //         RecGLSetup: Record "General Ledger Setup";
//         //     begin
//         //         // RecGLSetup.GET;
//         //         // if Rec."Currency Code" <> '' then
//         //         //     exit('GSTORVAT,' + DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), Rec."Currency Code"))
//         //         // else
//         //         //     exit('GSTORVAT,' + DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), RecGLSetup."LCY Code"));

//         //         CompanyInfo.GET;
//         //         If CompanyInfo."Enable GST caption" then
//         //             exit('GSTORVAT,' + DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), TotalSalesHeader."Currency Code"))
//         //         else
//         //             exit(DocumentTotals2.GetInvoiceDiscAmountWithVATAndCurrencyCaption(Rec.FieldCaption("Inv. Discount Amount"), TotalSalesHeader."Currency Code"))
//         //     end;

//         //     local procedure GetCustomCaptionClass(Cp: Text): Text
//         //     begin
//         //         exit('GSTORVAT,' + Cp);
//         //     end;

//         //     var
//         //         DocumentTotals2: Codeunit "Document Totals";
//         //         CompanyInfo: Record "Company Information";
//     }
// }