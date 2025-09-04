// page 53002 "Temp. Cust. Ledger Entries"//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'CP Temp. Customer Ledger Entries';
//     DataCaptionFields = "Customer No.";
//     PageType = List;
//     Permissions = TableData "Cust. Ledger Entry" = r;
//     PromotedActionCategories = 'New,Process,Report,Line,Entry,Navigate';
//     SourceTable = "Cust. Ledger Entry";
//     SourceTableView = SORTING("Entry No.")
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

//                 field("Posting Date"; Rec."Posting Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Specifies the customer entry''s posting date.';
//                 }
//                 field("Document Type"; Rec."Document Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     //StyleExpr = StyleTxt;
//                     ToolTip = 'Specifies the document type that the customer entry belongs to.';
//                 }
//                 field("Document No."; Rec."Document No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     //StyleExpr = StyleTxt;
//                     ToolTip = 'Specifies the entry''s document number.';
//                 }
//                 field("Customer No."; Rec."Customer No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Specifies the customer account number that the entry is linked to.';
//                 }
//                 field("Customer Name"; Rec."Customer Name")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Specifies the customer name that the entry is linked to.';
//                     Visible = CustNameVisible;
//                 }

//                 field("Currency Code"; Rec."Currency Code")
//                 {
//                     ApplicationArea = Suite;
//                     Editable = false;
//                     ToolTip = 'Specifies the currency code for the amount on the line.';
//                 }

//                 field(Amount; Rec.Amount)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Specifies the amount of the entry.';
//                     //Visible = AmountVisible;
//                 }

//                 field("Remaining Amount"; Rec."Remaining Amount")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Specifies the amount that remains to be applied to before the entry has been completely applied.';
//                 }


//                 field("Due Date"; Rec."Due Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     //StyleExpr = StyleTxt;
//                     ToolTip = 'Specifies the due date on the entry.';
//                 }
//                 field("Document Date"; Rec."Document Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     //StyleExpr = StyleTxt;
//                     ToolTip = 'Specifies the due date on the entry.';
//                 }

//                 field(Open; Rec.Open)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Specifies whether the amount on the entry has been fully paid or there is still a remaining amount that must be applied to.';
//                 }



//                 field("External Document No."; Rec."External Document No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.';
//                     //Visible = false;
//                 }
//                 field("Closed at Date"; Rec."Closed at Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }
//                 field("Company Name"; COMPANYNAME)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                 }

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
//         GlSetup: Record "General Ledger Setup";

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
//         OpenCLE: Record "Cust. Ledger Entry";
//         ClosedCLE: Record "Cust. Ledger Entry";
//     begin
//         Rec.Reset();
//         Rec.DeleteAll();
//         Rec.SetCurrentKey("Document Type", Open);

//         GlSetup.Get();

//         OpenCLE.Reset();
//         OpenCLE.SetAutoCalcFields(Amount);
//         OpenCLE.SetRange("Document Type", Rec."Document Type"::Invoice);
//         OpenCLE.SetRange(Open, true);
//         OpenCLE.SetFilter(Amount, '<>%1', 0);
//         if OpenCLE.FindSet() then
//             repeat
//                 Rec := OpenCLE;
//                 if Rec."Currency Code" = '' then
//                     Rec."Currency Code" := GlSetup."LCY Code";
//                 Rec.Insert();
//             until OpenCLE.Next() = 0;

//         ClosedCLE.Reset();
//         ClosedCLE.SetAutoCalcFields(Amount);
//         ClosedCLE.SetRange(Open, false);
//         ClosedCLE.SetRange("Posting Date", CalcDate('<-365D>', today), Today);
//         ClosedCLE.SetRange("Document Type", Rec."Document Type"::Invoice);
//         ClosedCLE.SetFilter(Amount, '<>%1', 0);
//         if ClosedCLE.FindSet() then
//             repeat
//                 Rec := ClosedCLE;
//                 if Rec."Currency Code" = '' then
//                     Rec."Currency Code" := GlSetup."LCY Code";
//                 Rec.Insert();
//             until ClosedCLE.Next() = 0;

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
