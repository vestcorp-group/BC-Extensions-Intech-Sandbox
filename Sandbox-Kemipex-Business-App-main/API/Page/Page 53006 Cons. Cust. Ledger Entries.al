// page 53006 "Cons. Cust. Ledger Entries"//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'BI Consolidated Cust. Ledger Entries';
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


//                 field("Sales Order No."; Rec."Document No.")
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
//                 field("Posting Date"; Rec."Posting Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Editable = false;
//                     ToolTip = 'Specifies the posting date that the entry is linked to.';
//                     //Visible = CustNameVisible;
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

//                 field("Due Date"; Rec."Due Date")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     //StyleExpr = StyleTxt;
//                     ToolTip = 'Specifies the due date on the entry.';
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
//         Companies: Record Company;
//         i: Integer;

//     local procedure InitTempTable()
//     var
//         OpenCLE: Record "Cust. Ledger Entry";
//         ClosedCLE: Record "Cust. Ledger Entry";
//     begin
//         Rec.Reset();
//         Rec.DeleteAll();
//         Rec.SetCurrentKey("Document Type", Open);
//         i := 0;

//         Companies.Reset();
//         if Companies.FindSet() then
//             repeat

//                 OpenCLE.Reset();
//                 OpenCLE.ChangeCompany(Companies.Name);
//                 OpenCLE.SetRange("Document Type", Rec."Document Type"::Invoice);
//                 OpenCLE.SetRange(Open, true);
//                 if OpenCLE.FindSet() then
//                     repeat
//                         Rec := OpenCLE;
//                         i += 1;
//                         Rec."Entry No." := i;
//                         if Rec."Currency Code" = '' then
//                             Rec."Currency Code" := GlSetup."LCY Code";
//                         Rec.Insert();
//                     until OpenCLE.Next() = 0;

//             until Companies.Next() = 0;

//         if Rec.FindFirst() then;
//     end;
// }
