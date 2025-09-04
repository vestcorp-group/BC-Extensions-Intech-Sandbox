// page 53003 "Open Orders Line API"//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'CP Open Order Line Entries';
//     DataCaptionFields = "Document Type", "Document No.";
//     PageType = List;
//     Permissions = TableData "Sales Line" = r;
//     PromotedActionCategories = 'New,Process,Report,Line,Entry,Navigate';
//     SourceTable = "Sales Line";
//     /* SourceTableView = SORTING("Entry No.")
//                       ORDER(Descending); */
//     UsageCategory = History;
//     SourceTableView = WHERE("Document Type" = FILTER(Order), Type = filter(Item));
//     //SourceTableTemporary = true;



//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field("Company Name"; COMPANYNAME)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     //ToolTip = 'Specifies the customer entry''s posting date.';
//                 }

//                 field("Document No."; Rec."Document No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     //ToolTip = 'Specifies the customer entry''s posting date.';
//                 }

//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     //ToolTip = 'Specifies the customer entry''s posting date.';
//                 }
//                 field(Description; Rec.Description)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     //ToolTip = 'Specifies the customer entry''s posting date.';
//                 }

//                 field("Unit of Measure"; Rec."Unit of Measure")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     //ToolTip = 'Specifies the customer entry''s posting date.';
//                 }
//                 field(Quantity; Rec.Quantity)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     //ToolTip = 'Specifies the customer entry''s posting date.';
//                 }
//                 field("Unit Price"; Rec."Unit Price")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     //ToolTip = 'Specifies the customer entry''s posting date.';
//                 }
//                 field(Amount; Rec.Amount)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     //ToolTip = 'Specifies the customer entry''s posting date.';
//                 }
//                 field("Amount Including VAT"; Rec."Amount Including VAT")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     //ToolTip = 'Specifies the customer entry''s posting date.';
//                 }
//                 field("Line Amount"; Rec."Line Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     //ToolTip = 'Specifies the customer entry''s posting date.';
//                 }
//                 field(HSNCode; Rec.HSNCode)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     //ToolTip = 'Specifies the customer entry''s posting date.';
//                 }

//                 field("Posting Date"; Rec."Posting Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     //ToolTip = 'Specifies the customer entry''s posting date.';
//                 }
//                 //field("Product Group Code"; "Product Group Code") { }

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

//     end;



//     var
//         PmtMethod: Record "Payment Terms";


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
