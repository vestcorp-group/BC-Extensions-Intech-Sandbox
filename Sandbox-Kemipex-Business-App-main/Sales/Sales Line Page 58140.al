// pageextension 58150 Sales_line extends "Sales Lines"//T12370-Full Comment
// {
//     layout
//     {
//         addafter("Line Amount")
//         {
//             field("Outstanding Amount (LCY)"; rec."Outstanding Amount (LCY)")
//             {
//                 ApplicationArea = all;
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
//         modify("Shipment Date")
//         {
//             Visible = false;
//         }
//         modify(Reserve)
//         {
//             Visible = false;
//             Editable = false;
//         }
//         modify("Shortcut Dimension 1 Code")
//         {
//             Visible = false;
//         }

//     }

//     var
//         myInt: Integer;
// }