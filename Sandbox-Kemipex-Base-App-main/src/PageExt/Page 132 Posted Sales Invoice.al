// pageextension 50326 KMP_PageExtPostedSalesInv extends "Posted Sales Invoice"//T12370-Full Comment
// {
//     layout
//     {
//         // Add changes to page layout here
//         addafter("External Document No.")
//         {
//             field(BillOfExit; rec.BillOfExit)
//             {
//                 ApplicationArea = all;
//                 Caption = 'Bill Of Exit';
//                 Editable = false;
//             }
//         }
//         addafter("Responsibility Center")
//         {
//             // field("Seller/Buyer 2"; rec."Seller/Buyer 2")
//             // {
//             //     ApplicationArea = all;
//             //     Caption = 'Seller/Buyer';
//             //     Editable = false;
//             // }

//             field("Bank on Invoice 2"; rec."Bank on Invoice 2")
//             {
//                 Caption = 'Bank on Invoice';
//                 ApplicationArea = All;
//             }
//             field("Inspection Required 2"; rec."Inspection Required 2")
//             {
//                 ApplicationArea = All;
//                 Caption = 'Inspection Required';
//                 // Visible = false;
//             }
//             field("Legalization Required 2"; rec."Legalization Required 2")
//             {
//                 ApplicationArea = All;
//                 Caption = 'Legalization Required';
//                 // Visible = false;
//             }
//             field("Seller/Buyer 2"; rec."Seller/Buyer 2")
//             {
//                 ApplicationArea = all;

//                 Caption = 'Seller/Buyer';
//             }
//             field("LC No. 2"; rec."LC No. 2")
//             {
//                 ApplicationArea = All;
//                 Caption = 'LC No.';
//             }
//             field("LC Date 2"; rec."LC Date 2")
//             {
//                 ApplicationArea = all;
//                 Caption = 'LC Date';
//             }
//         }
//     }
//     actions
//     {

//         addfirst(processing)
//         {
//             // action("Posted Delivery Advice")
//             // {
//             //     Image = Delivery;
//             //     Promoted = true;
//             //     PromotedCategory = Process;
//             //     PromotedIsBig = true;
//             //     ApplicationArea = all;
//             //     trigger OnAction()
//             //     var
//             //         SalesInvRec: Record "Sales Invoice Header";
//             //     begin

//             //         SalesInvRec.Reset();
//             //         CurrPage.SetSelectionFilter(SalesInvRec);
//             //         if SalesInvRec.FindFirst then
//             //             Report.RunModal(Report::"Posted Delivery Advice Report", true, true, SalesInvRec);
//             //     end;
//             // }
//         }
//         addafter("Co&mments")
//         {
//             action(Remarks)
//             {
//                 Image = Comment;
//                 Promoted = true;
//                 ApplicationArea = All;
//                 PromotedCategory = Category4;
//                 PromotedIsBig = true;
//                 trigger OnAction()
//                 var
//                     SalesRemarkL: Record "Sales Remark Archieve";
//                 begin
//                     SalesRemarkL.ShowRemarks(SalesRemarkL."Document Type"::"Posted Invoice", rec."No.", 0);
//                 end;
//             }
//         }
//     }
// }