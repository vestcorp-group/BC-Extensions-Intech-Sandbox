// pageextension 58008 PIPage extends "Purchase Invoice"//T12370-Full Comment
// {
//     layout
//     {
//         // Add changes to page layout here
//         modify("Transaction Specification")
//         {
//             Caption = 'Incoterm';
//         }
//         modify("Transaction Type")
//         {
//             Visible = true;
//             Caption = 'Order Type';
//         }
//         addafter("Vendor Invoice No.")
//         {
//             field("Posting Description "; rec."Posting Description")
//             {
//                 ApplicationArea = all;
//             }
//         }
//         moveafter(Status; "Transaction Type")
//     }

//     actions
//     {
//         // addafter(DocAttach)
//         // {
//         //     action("Save PDF")
//         //     {
//         //         ApplicationArea = all;
//         //         trigger OnAction()
//         //         var
//         //             myInt: Integer;
//         //             PurchaseInvoiceReport: Report purchaseinvoice_layout;
//         //             PIH: Record "Purch. Inv. Header";

//         //         begin
//         //             PIH.Reset();
//         //             PIH.SetRange("No.", Rec."No.");

//         //         end;
//         //     }
//         // }
//     }
// }