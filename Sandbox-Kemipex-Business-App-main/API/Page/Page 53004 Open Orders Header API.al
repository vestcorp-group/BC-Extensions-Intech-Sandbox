// page 53004 "Open Orders Header API"//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'CP Open Orders Entries';
//     DataCaptionFields = "Document Type", "No.";
//     PageType = List;
//     Permissions = TableData "Sales Header" = r;
//     PromotedActionCategories = 'New,Process,Report,Line,Entry,Navigate';
//     SourceTable = "Sales Header";
//     /* SourceTableView = SORTING("Entry No.")
//                       ORDER(Descending); */
//     UsageCategory = History;
//     SourceTableView = WHERE("Document Type" = FILTER(Order));
//     //SourceTableTemporary = true;



//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Company Name"; COMPANYNAME) { ApplicationArea = Basic, Suite; }
//                 field("Document Type"; Rec."Document Type") { ApplicationArea = Basic, Suite; }
//                 field("Document No."; Rec."No.") { ApplicationArea = Basic, Suite; }
//                 field("Sell-to Customer No."; Rec."Sell-to Customer No.") { ApplicationArea = Basic, Suite; }


//                 field("Order Date"; Rec."Order Date") { ApplicationArea = Basic, Suite; }
//                 field("Posting Date"; Rec."Posting Date") { ApplicationArea = Basic, Suite; }
//                 field("Payment Terms Code"; Rec."Payment Terms Code") { ApplicationArea = Basic, Suite; }

//                 field("Currency Code"; CurrCode) { ApplicationArea = Basic, Suite; }


//                 field("Amount"; Rec."Amount") { ApplicationArea = Basic, Suite; }
//                 field("Amount Including VAT"; Rec."Amount Including VAT") { ApplicationArea = Basic, Suite; }
//                 field(Status; NewStatus) { ApplicationArea = Basic, Suite; }
//                 // field("Customer Purchase Ref"; Rec."External Document No.")
//                 // { ApplicationArea = Basic, Suite; }
//                 field("Customer Purchase Ref"; Reference)//08-07-2022
//                 { ApplicationArea = Basic, Suite; }

//             }
//         }

//     }

//     trigger OnOpenPage()
//     begin
//         Rec.SetAutoCalcFields(Amount);
//         Rec.SetFilter(Amount, '<>%1', 0);
//     end;

//     trigger OnAfterGetRecord()
//     begin

//         clear(NewStatus);

//         /*08-07-2022 commented below code and added new conditions below to change status 
//         if Rec.Status = Rec.Status::Open then
//             NewStatus := 'Open'
//         else
//             if Rec.Status = Rec.Status::Released then
//                 NewStatus := 'Confirmed'
//             else
//                 NewStatus := 'Pending';
//         if PmtMethod.Get(Rec."Payment Terms Code") then
//             if PmtMethod."Advance Payment" then begin
//                 sih.Reset();
//                 SIH.SetRange("Prepayment Order No.", Rec."No.");
//                 if sih.FindFirst() then begin
//                     sih.CalcFields("Remaining Amount");
//                     if sih."Remaining Amount" = 0 then
//                         NewStatus := 'Pending for shipment'
//                     else
//                         NewStatus := 'Pending for payment';
//                 end;
//             end;*/
//         SalesLine.Reset();
//         SalesLine.SetRange("Document Type", Rec."Document Type");
//         SalesLine.SetRange("Document No.", Rec."No.");
//         SalesLine.SetFilter("Quantity Shipped", '<>%1', 0);
//         if SalesLine.FindFirst() then
//             NewStatus := 'Shipped';

//         //if sp.Get("Salesperson Code") then;
//         GLsetup.Get();
//         clear(CurrCode);
//         CurrCode := Rec."Currency Code";
//         if CurrCode = '' then
//             CurrCode := GLsetup."LCY Code";

//         //08-07-2022-start
//         clear(Reference);
//         if Rec."Your Reference" <> '' then
//             Reference := Rec."Your Reference"
//         else
//             Reference := Rec."External Document No.";


//         //status

//         If Rec.Status = Rec.Status::"Pending Approval" then
//             NewStatus := 'Review'
//         else
//             if Rec.Status = Rec.Status::Released then begin
//                 NewStatus := 'Confirmed';
//                 Rec.CalcFields(Shipped);
//                 if Rec.Shipped then
//                     NewStatus := 'Dispatched';
//             end
//             else
//                 if Rec.Status = Rec.Status::Open then begin
//                     if PaymentTerms.Get(Rec."Payment Terms Code") then begin
//                         if PaymentTerms."Advance Payment" then begin
//                             SalesInvoiceHdr.Reset();
//                             SalesInvoiceHdr.SetRange("Prepayment Order No.", Rec."No.");
//                             if SalesInvoiceHdr.FindFirst() then begin
//                                 SalesInvoiceHdr.CalcFields("Remaining Amount");
//                                 if SalesInvoiceHdr."Remaining Amount" = 0 then
//                                     NewStatus := 'Pending Sales'//Pending for shipment
//                                 else
//                                     NewStatus := 'Pending Payment'//Pending for payment';
//                             end;
//                         end else
//                             NewStatus := 'Pending Sales';
//                     end else
//                         NewStatus := 'Pending Sales';
//                 end;

//         //08-07-2022-end
//     end;



//     var

//         NewStatus: Text;
//         GLsetup: Record "General Ledger Setup";
//         SalesLine: Record "Sales Line";
//         SalesInvoiceHdr: Record "Sales Invoice Header";
//         PaymentTerms: Record "Payment Terms";
//         SP: Record "Salesperson/Purchaser";
//         CurrCode: Code[10];
//         Reference: Text;

//     /*     local procedure SetDimVisibility()
//         var
//             DimensionManagement: Codeunit DimensionManagement;
//         begin
//             DimensionManagement.UseShortcutDims(Dim1Visible, Dim2Visible, Dim3Visible, Dim4Visible, Dim5Visible, Dim6Visible, Dim7Visible, Dim8Visible);
//         end;

//         local procedure SetControlVisibility()
//         var
//             GLSetup: Record "General Ledger Setup";
//             SalesSetup: Record "Sales & Receivables Setup";
//         begin
//             GLSetup.Get();
//             AmountVisible := not (GLSetup."Show Amounts" = GLSetup."Show Amounts"::"Debit/Credit Only");
//             DebitCreditVisible := not (GLSetup."Show Amounts" = GLSetup."Show Amounts"::"Amount Only");
//             SalesSetup.Get();
//             CustNameVisible := SalesSetup."Copy Customer Name to Entries";
//         end; */
// }
