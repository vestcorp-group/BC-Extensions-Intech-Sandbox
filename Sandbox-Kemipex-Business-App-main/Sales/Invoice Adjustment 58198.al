// page 58198 Invoiceadjustment//T12370-Full Comment
// {
//     PageType = List;
//     ApplicationArea = All;
//     UsageCategory = Administration;
//     SourceTable = "Sales Invoice Line";
//     Permissions = tabledata 113 = rm;
//     Caption = 'Invoice Line Adjusment';
//     Editable = true;
//     DeleteAllowed = false;
//     InsertAllowed = false;

//     layout
//     {
//         area(Content)
//         {
//             repeater(GroupName)
//             {
//                 field("Document No."; rec."Document No.")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("No."; rec."No.")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field(Description; rec.Description)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Quantity (Base)"; rec."Quantity (Base)")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Base UOM"; rec."Base UOM 2") //PackingListExtChange
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field(HSNCode; rec.HSNCode)
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                 }
//                 field(CountryOfOrigin; rec.CountryOfOrigin)
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                 }
//                 field(LineHSNCode; rec.LineHSNCode)
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                 }
//                 field(LineCountryOfOrigin; rec.LineCountryOfOrigin)
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                 }
//                 field("Customer Requested Unit Price"; rec."Customer Requested Unit Price")
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                 }
//                 field("Net Weight"; rec."Net Weight")
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                 }
//                 field("Gross Weight"; rec."Gross Weight")
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                 }
//                 field("IC Related SO"; rec."IC Related SO")
//                 {
//                     ApplicationArea = all;
//                     Editable = true;
//                 }
//             }
//         }
//     }


//     actions
//     {
//         area(Processing)
//         {
//             action(ActionName)
//             {
//                 ApplicationArea = All;

//                 trigger OnAction()
//                 begin
//                 end;
//             }
//         }
//     }
// }
