// report 50208 KMP_ShortClosureSOandPO//T12370-Full Comment
// {
//     Caption = 'Short Closure of SO and PO';
//     ProcessingOnly = true;
//     UseRequestPage = false;

//     dataset
//     {
//         dataitem(SalesHeader; "Sales Header")
//         {
//             DataItemTableView = sorting("Document Type", "No.") where("Document Type" = filter(Order), Status = const(Released));
//             trigger OnAfterGetRecord()
//             var
//                 SalesLineL: Record "Sales Line";
//             begin
//                 SalesLineL.SetRange("Document Type", SalesHeader."Document Type");
//                 SalesLineL.SetRange("Document No.", "No.");
//                 if SalesLineL.IsEmpty then
//                     CurrReport.Skip();
//                 SalesLineL.CalcSums("Outstanding Qty. (Base)");
//                 if SalesLineL."Outstanding Qty. (Base)" = 0 then begin
//                     SalesLineL.ModifyAll("Qty. Shipped Not Invoiced", 0);
//                     if Delete(true) then;
//                 end;
//             end;
//         }
//         dataitem(PurchaseHeader; "Purchase Header")
//         {
//             DataItemTableView = sorting("Document Type", "No.") where("Document Type" = filter(Order), Status = const(Released));
//             trigger OnAfterGetRecord()
//             var
//                 PurchaseLineL: Record "Purchase Line";
//             begin
//                 PurchaseLineL.SetRange("Document Type", SalesHeader."Document Type");
//                 PurchaseLineL.SetRange("Document No.", "No.");
//                 if PurchaseLineL.IsEmpty then
//                     CurrReport.Skip();
//                 PurchaseLineL.CalcSums("Outstanding Qty. (Base)");
//                 if PurchaseLineL."Outstanding Qty. (Base)" = 0 then begin
//                     PurchaseLineL.ModifyAll("Qty. Rcd. Not Invoiced", 0);
//                     if Delete(true) then;
//                 end;
//             end;
//         }
//     }



//     var
//         myInt: Integer;
// }