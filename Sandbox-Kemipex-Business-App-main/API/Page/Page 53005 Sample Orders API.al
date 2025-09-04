// page 53005 "Sample Orders API"//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'CP Sample Orders API';
//     //DataCaptionFields = "Customer No.";
//     PageType = List;
//     Permissions = TableData "Cust. Ledger Entry" = r;
//     PromotedActionCategories = 'New,Process,Report,Line,Entry,Navigate';
//     SourceTable = "Sales Line";
//     SourceTableView = SORTING("Document Type", "Document No.", "Line No.")
//                       ORDER(Descending);
//     UsageCategory = History;
//     SourceTableTemporary = true;



//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;

//                 field("Sell-to Customer No."; Rec."Sell-to Customer No.") { ApplicationArea = Basic, Suite; }
//                 field("Document No."; Rec."Document No.") { ApplicationArea = Basic, Suite; }
//                 field("Line No."; Rec."Line No.") { ApplicationArea = Basic, Suite; }
//                 field(Type; Rec.Type) { ApplicationArea = Basic, Suite; }
//                 field("No."; Rec."No.") { ApplicationArea = Basic, Suite; }
//                 field(Description; Rec.Description) { ApplicationArea = Basic, Suite; }
//                 field("Unit of Measure"; Rec."Unit of Measure") { ApplicationArea = Basic, Suite; }
//                 field(Quantity; Rec.Quantity) { ApplicationArea = Basic, Suite; }
//                 //field("Unit Price"; "Unit Price") { ApplicationArea = Basic, Suite; }
//                 //field(Amount; Amount) { ApplicationArea = Basic, Suite; }
//                 //field("Amount Including VAT"; "Amount Including VAT") { ApplicationArea = Basic, Suite; }
//                 field("Bill-to Customer No."; Rec."Bill-to Customer No.") { ApplicationArea = Basic, Suite; }
//                 field("Posting Date"; Rec."Posting Date") { ApplicationArea = Basic, Suite; }
//                 field(Status; Rec."Description 2") { ApplicationArea = Basic, Suite; }
//                 field("Company Name"; COMPANYNAME) { ApplicationArea = Basic, Suite; }

//             }
//         }

//     }



//     trigger OnAfterGetCurrRecord()
//     var
//         IncomingDocument: Record "Incoming Document";
//     begin
//         //HasIncomingDocument := IncomingDocument.PostedDocExists("Document No.", "Posting Date");
//         //HasDocumentAttachment := HasPostedDocAttachment();
//     end;

//     trigger OnAfterGetRecord()
//     begin
//         //StyleTxt := SetStyle();
//     end;

//     trigger OnInit()
//     begin
//         AmountVisible := true;
//     end;

//     trigger OnModifyRecord(): Boolean
//     begin
//         //CODEUNIT.Run(CODEUNIT::"Cust. Entry-Edit", Rec);
//         //exit(false);
//     end;

//     trigger OnOpenPage()
//     begin
//         /* SetControlVisibility();
//         SetDimVisibility();

//         if (GetFilters() <> '') and not Find() then
//             if FindFirst() then; */
//         InitTempTable();
//     end;

//     var
//         Navigate: Page Navigate;
//         DimensionSetIDFilter: Page "Dimension Set ID Filter";
//         HasIncomingDocument: Boolean;
//         HasDocumentAttachment: Boolean;
//         AmountVisible: Boolean;
//         DebitCreditVisible: Boolean;
//         CustNameVisible: Boolean;
//         ExportToPaymentFileConfirmTxt: Label 'Editing the Exported to Payment File field will change the payment suggestions in the Payment Journal. Edit this field only if you must correct a mistake.\Do you want to continue?';
//         NoReminderCreatedErr: Label 'No reminder was created. Check the reminder terms for the customer.';
//         NoFinanceChargeMemoHeaderCreatedErr: Label 'No finance charge memo was created. Check the finance charge terms for the customer.';

//     protected var
//         Dim1Visible: Boolean;
//         Dim2Visible: Boolean;
//         Dim3Visible: Boolean;
//         Dim4Visible: Boolean;
//         Dim5Visible: Boolean;
//         Dim6Visible: Boolean;
//         Dim7Visible: Boolean;
//         Dim8Visible: Boolean;
//         StyleTxt: Text;

//     local procedure InitTempTable()
//     var
//         salesline: Record "Sales Line";
//         salesinvline: Record "Sales Invoice Line";
//         sh: Record "Sales Header";
//         sih: Record "Sales Invoice Header";
//     begin
//         Rec.Reset();
//         Rec.DeleteAll();
//         Rec.SetCurrentKey("Document No.", "Line No.");

//         sh.reset;
//         sh.SetRange("Document Type", Rec."Document Type"::Order);
//         //sh.SetFilter("Payment Terms Code", '*SAMPLE*');
//         if sh.FindSet() then
//             repeat
//                 if StrPos(uppercase(sh."Payment Terms Code"), 'SAMPLE') <> 0 then begin
//                     salesline.Reset();
//                     salesline.SetRange("Document No.", sh."No.");
//                     salesline.SetRange(Type, Rec.Type::Item);
//                     if salesline.FindSet() then
//                         repeat
//                             Rec := salesline;
//                             if sh.Status = sh.Status::Released then
//                                 Rec."Description 2" := 'Preparation'
//                             else
//                                 Rec."Description 2" := 'Requested';
//                             Rec.Insert();
//                         until salesline.next = 0;
//                 end;
//             until sh.next = 0;
//         sih.reset;
//         //sh.SetRange("Document Type", "Document Type"::Order);
//         //sih.SetFilter("Payment Terms Code", '*SAMPLE*');
//         if sih.FindSet() then
//             repeat
//                 if StrPos(uppercase(sih."Payment Terms Code"), 'SAMPLE') <> 0 then begin
//                     salesinvline.Reset();
//                     salesinvline.SetRange("Document No.", sih."No.");
//                     salesinvline.SetRange(Type, Rec.Type::Item);
//                     if salesinvline.FindSet() then
//                         repeat
//                             Rec."Document Type" := rec."Document Type"::Order;
//                             Rec."Document No." := salesinvline."Document No.";
//                             Rec."Line No." := salesinvline."Line No.";
//                             Rec.Type := Rec.Type::Item;
//                             Rec."No." := salesinvline."No.";
//                             Rec."Sell-to Customer No." := salesinvline."Sell-to Customer No.";
//                             Rec.Description := salesinvline.Description;
//                             Rec."Unit of Measure" := salesinvline."Unit of Measure";
//                             Rec.Quantity := salesinvline.Quantity;
//                             Rec."Unit Price" := salesinvline."Unit Price";
//                             Rec.Amount := salesinvline.Amount;
//                             Rec."Amount Including VAT" := salesinvline."Amount Including VAT";
//                             Rec."Bill-to Customer No." := salesinvline."Bill-to Customer No.";
//                             Rec."Posting Date" := salesinvline."Posting Date";
//                             Rec."Description 2" := 'Delivered';
//                             Rec.Insert();
//                         until salesinvline.next = 0;
//                 end;
//             until sih.next = 0;
//         /*         OpenCLE.Reset();
//                 OpenCLE.SetRange("Document Type", "Document Type"::Invoice);
//                 OpenCLE.SetRange(Open, true);
//                 if OpenCLE.FindSet() then
//                     repeat
//                         Rec := OpenCLE;
//                         Insert();
//                     until OpenCLE.Next() = 0; */



//         if Rec.FindFirst() then;
//     end;
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
