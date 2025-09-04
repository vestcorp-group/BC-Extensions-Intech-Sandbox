// page 53008 "Customer Sales Declaration"//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'Sales Invoice Shipment Info';
//     DataCaptionFields = "No.", "Sell-to Customer No.", "Sell-to Customer Name";
//     PageType = List;
//     Permissions = TableData "Sales Invoice Header" = rmd, tabledata "Item Ledger Entry" = rm;
//     PromotedActionCategories = 'New,Process,Report,Line,Entry,Navigate';
//     SourceTable = "Sales Invoice Header";
//     SourceTableView = SORTING("No.")
//                       ORDER(Descending);
//     UsageCategory = Lists;
//     Editable = true;
//     DeleteAllowed = false;
//     //SourceTableTemporary = true;



//     layout
//     {

//         area(content)
//         {
//             repeater(Control1)
//             {
//                 //ShowCaption = false;
//                 Caption = 'Customer Sales Declaration';
//                 field("Posting Date"; Rec."Posting Date") { ApplicationArea = Basic, Suite; Editable = false; }
//                 field("Document No."; Rec."No.") { ApplicationArea = Basic, Suite; Editable = false; }
//                 field("Customer No."; Rec."Sell-to Customer No.") { ApplicationArea = Basic, Suite; Editable = false; }
//                 field("Customer Name"; Rec."Sell-to Customer Name") { ApplicationArea = Basic, Suite; Editable = false; }
//                 field("Inco Term"; Rec."Transaction Specification") { ApplicationArea = Basic, Suite; Editable = false; Caption = 'Inco Term'; }
//                 field(POD; Rec."Area") { ApplicationArea = Basic, Suite; Editable = false; Caption = 'POD'; }
//                 field(POL; Rec."Exit Point") { ApplicationArea = Basic, Suite; Editable = false; Caption = 'POL'; }
//                 field("Sales Order No."; Rec."Order No.") { ApplicationArea = Basic, Suite; Editable = false; }
//                 field("Salesperson Code"; Rec."Salesperson Code") { ApplicationArea = Basic, Suite; Editable = false; }
//                 field("Salesperson Name"; Salesperson.Name) { ApplicationArea = Basic, Suite; Editable = false; }
//                 field("Payment Terms Description"; PmtTerms.Description) { ApplicationArea = Basic, Suite; Editable = false; }
//                 field("Declaration Type"; Rec."Declaration Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Enabled = blnDecNo;
//                     trigger OnValidate()
//                     begin
//                         if (rec."Declaration Type" = rec."Declaration Type"::Direct) then
//                             rec.Validate(BillOfExit, Format(rec."Declaration Type"));
//                     end;
//                 }
//                 field("Declaration No."; Rec.BillOfExit)
//                 {
//                     ApplicationArea = Basic, Suite;
//                     Caption = 'Declaration No.';
//                     Enabled = blnDecNo;
//                 }
//                 field("Bill of Lading No."; Rec."Bill of Lading No.") { ApplicationArea = Basic, Suite; Enabled = blnBill; }
//                 field("Carrier Name"; Rec."Carrier Name") { ApplicationArea = Basic, Suite; Enabled = blnCar; }
//                 field(ETD; Rec.ETD) { ApplicationArea = Basic, Suite; Enabled = blnETD; }
//                 field(ETA; Rec.ETA) { ApplicationArea = Basic, Suite; Enabled = blnETA; }
//                 //field(carr)
//                 field("User ID"; Rec."User ID") { ApplicationArea = Basic, Suite; Editable = false; }

//             }
//         }
//     }
//     trigger OnAfterGetRecord()
//     begin

//         if PmtTerms.Get(Rec."Payment Terms Code") then;
//         if Salesperson.Get(Rec."Salesperson Code") then;
//         UserSetup.Get(UserId);
//         blnDecType := true;
//         blnDecNo := true;
//         blnBill := true;
//         blnCar := true;
//         blnETA := true;
//         blnETD := true;
//         //UserSetup.Get(UserId);
//         //if not UserSetup."Allow Edit ETA/ETD" then
//         if Rec."Declaration Type" <> xRec."Declaration Type"::" " then
//             if not UserSetup."Allow Edit ETA/ETD" then
//                 blnDecType := false;
//         if Rec.BillOfExit <> '' then
//             if not UserSetup."Allow Edit ETA/ETD" then
//                 blnDecNo := false;
//         if Rec."Bill of Lading No." <> '' then
//             if not UserSetup."Allow Edit ETA/ETD" then
//                 blnBill := false;
//         if Rec."Carrier Name" <> '' then
//             if not UserSetup."Allow Edit ETA/ETD" then
//                 blnCar := false;
//     end;

//     trigger OnOpenPage()
//     begin
//         //if UserSetup.Get(UserId) then
//         //  if not UserSetup."Allow Edit ETA/ETD" then
//         //    Error('Permission rights required to modify the ETA/ETD information');

//         blnDecType := true;
//         blnDecNo := true;
//         blnBill := true;
//         blnCar := true;
//         blnETA := true;
//         blnETD := true;
//     end;

//     trigger OnAfterGetCurrRecord()
//     begin
//         /* if UserSetup.Get(UserId) then
//             if not UserSetup."Allow Edit ETA/ETD" then begin
//                 if xRec."Declaration Type" <> xRec."Declaration Type"::" " then
//                     blnDecType := false;
//                 if xRec.BillOfExit <> '' then
//                     blnDecNo := false;
//                 if xRec."Bill of Lading No." <> '' then
//                     blnBill := false;
//                 if xRec."Carrier Name" <> '' then
//                     blnCar := false;
//                 if xRec.ETA <> 0D then
//                     blnETA := false;
//                 if xRec.ETD <> 0D then
//                     blnETD := false;
//             end; */

//         /*blnDecType := true;
//         blnDecNo := true;
//         blnBill := true;
//         blnCar := true;
//         blnETA := true;
//         blnETD := true;
//         UserSetup.Get(UserId);
//         //if not UserSetup."Allow Edit ETA/ETD" then
//         if Rec."Declaration Type" <> xRec."Declaration Type"::" " then
//             if not UserSetup."Allow Edit ETA/ETD" then
//                 blnDecType := false;
//         if Rec.BillOfExit <> '' then
//             if not UserSetup."Allow Edit ETA/ETD" then
//                 blnDecNo := false;
//         if Rec."Bill of Lading No." <> '' then
//             if not UserSetup."Allow Edit ETA/ETD" then
//                 blnBill := false;
//         if Rec."Carrier Name" <> '' then
//             if not UserSetup."Allow Edit ETA/ETD" then
//                 blnCar := false;*/


//     end;

//     var
//         PmtTerms: Record "Payment Terms";
//         Salesperson: Record "Salesperson/Purchaser";
//         UserSetup: Record "User Setup";
//         blnDecType: Boolean;
//         blnDecNo: Boolean;
//         blnBill: Boolean;
//         blnCar: Boolean;
//         blnETA: Boolean;
//         blnETD: Boolean;
// }