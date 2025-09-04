// pageextension 80000 ItemList_PageExt extends "Item List"//T12370-Full Comment
// {
//     layout
//     {
//         addafter("Unit Cost")
//         {
//             field("Item Value"; CostValue)
//             {
//                 Editable = false;
//                 ApplicationArea = all;
//             }
//         }
//     }

//     actions
//     {
//         addlast(Reports)
//         {
//             action("Stock Aging Report")
//             {
//                 ApplicationArea = all;
//                 Promoted = true;
//                 PromotedCategory = Report;
//                 Image = Report;
//                 trigger OnAction()
//                 var
//                 begin
//                     Report.Run(80105);
//                 end;
//             }
//         }
//     }
//     trigger OnAfterGetRecord()
//     Begin
//         CostValue := 0;
//         CostValue := Rec.Inventory * Rec."Unit Cost";
//     End;

//     var
//         CostValue: Decimal;
//         myInt: Integer;
// }