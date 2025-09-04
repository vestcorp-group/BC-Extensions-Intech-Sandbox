// pageextension 58026 PstdSalesCrdmemo50225 extends "Posted Sales Credit Memo"//T12370-Full Comment
// {
//     layout
//     {
//         //27-07-2022-start
//         addlast(General)
//         {
//             field("Release Of Shipping Document"; Rec."Release Of Shipping Document")
//             {
//                 ApplicationArea = All;
//             }
//             field("Courier Details"; Rec."Courier Details")
//             {
//                 ApplicationArea = All;
//                 MultiLine = true;
//             }
//             field("Free Time Requested"; Rec."Free Time Requested")
//             {
//                 ApplicationArea = All;
//                 MultiLine = true;
//             }
//             field("Customer Incentive Point (CIP)"; Rec."Customer Incentive Point (CIP)")
//             {
//                 ApplicationArea = All;
//                 Editable = false;
//             }
//             field("Transaction Type"; rec."Transaction Type")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Order Type';
//             }
//         }
//         //27-07-2022-end
//         addlast("Shipping and Billing")
//         {
//             field("Area"; rec."Area")
//             {
//                 ApplicationArea = All;
//                 Caption = 'Port of Discharge';
//                 Editable = false;
//             }
//             field("Exit Point"; rec."Exit Point")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Port of Loading';
//                 Editable = false;
//             }
//         }

//         addafter("Shipping and Billing")
//         {
//             group("Agent Representative")
//             {
//                 Caption = 'Agent Representative';

//                 field("Agent Rep. Code"; Rec."Agent Rep. Code")
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Agent Rep. Code';
//                     ToolTip = 'Specifies a link to select Agent Representative.';
//                 }
//                 field("Agent Rep. Name"; Rec."Agent Rep. Name")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Agent Rep. Address"; Rec."Agent Rep. Address")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Agent Rep. Address 2"; Rec."Agent Rep. Address 2")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Agent Rep. City"; Rec."Agent Rep. City")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Agent Rep. Post Code"; Rec."Agent Rep. Post Code")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Agent Rep. Country/Region Code"; Rec."Agent Rep. Country/Region Code")
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//         }

//         addlast(General)
//         {
//             field("Salesperson Name"; Rec."Salesperson Name")
//             {
//                 ApplicationArea = All;
//                 Editable = false;
//             }
//             field("Sub Status"; Rec."Sub Status")
//             {
//                 ApplicationArea = All;
//                 Editable = false;
//             }
//         }
//     }
//     trigger OnDeleteRecord(): Boolean
//     begin
//         Error('Not allowed to delete the record!');
//     end;
// }
