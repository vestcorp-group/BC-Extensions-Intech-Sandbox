// page 50423 TempDashboard
// {
//     PageType = Card;
//     ApplicationArea = All;
//     UsageCategory = Administration;


//     layout
//     {
//         area(Content)
//         {

//         }
//     }

//     actions
//     {
//         area(Processing)
//         {
//             // action("Copy Credit Memo Line")
//             // {
//             //     ApplicationArea = all;
//             //     Promoted = true;
//             //     PromotedIsBig = true;
//             //     PromotedCategory = Process;
//             //     trigger OnAction()
//             //     var
//             //         TempCopy: Codeunit tempCopyCodeunit;
//             //     begin
//             //         TempCopy.CopyPostedSalesCreditMemoLineData();
//             //     end;
//             // }
//             action("Copy Sale Credit Memo Header")
//             {
//                 ApplicationArea = all;
//                 Promoted = true;
//                 PromotedIsBig = true;
//                 PromotedCategory = Process;
//                 trigger OnAction()
//                 var
//                     TempCopy: Codeunit tempCopyCodeunit;
//                 begin
//                     TempCopy.CopypostedSalesCreditMemoHeaderData();
//                 end;
//             }
//             action("Copy Sales Header")
//             {
//                 ApplicationArea = all;
//                 Promoted = true;
//                 PromotedIsBig = true;
//                 PromotedCategory = Process;
//                 trigger OnAction()
//                 var
//                     TempCopy: Codeunit tempCopyCodeunit;
//                 begin
//                     TempCopy.CopySalesHeaderData();
//                 end;
//             }
//             action("Copy Sales Shipment  Header")
//             {
//                 ApplicationArea = all;
//                 Promoted = true;
//                 PromotedIsBig = true;
//                 PromotedCategory = Process;
//                 trigger OnAction()
//                 var
//                     TempCopy: Codeunit tempCopyCodeunit;
//                 begin
//                     TempCopy.CopySalesShipmentHeaderData();
//                 end;
//             }
//             action("Copy Sales Invoice Header")
//             {
//                 ApplicationArea = all;
//                 Promoted = true;
//                 PromotedIsBig = true;
//                 PromotedCategory = Process;
//                 trigger OnAction()
//                 var
//                     TempCopy: Codeunit tempCopyCodeunit;
//                 begin
//                     TempCopy.CopySalesInvoiceHeaderData();
//                 end;
//             }
//         }
//     }

//     var
//         myInt: Integer;
// }