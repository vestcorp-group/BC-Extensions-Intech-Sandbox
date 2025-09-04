// pageextension 50510 "Item Tracking Summary" extends "Item Tracking Summary"//T12370-Full Comment
// {
//     layout
//     {
//         modify("Lot No.")
//         {
//             StyleExpr = HighLightRow;
//         }
//         modify(CustomBOENumber)
//         {
//             StyleExpr = HighLightRow;
//         }
//         modify(CustomLotNumber)
//         {
//             StyleExpr = HighLightRow;
//         }
//         modify("Serial No.")
//         {
//             StyleExpr = HighLightRow;
//         }
//         modify("Total Quantity")
//         {
//             StyleExpr = HighLightRow;
//         }
//         modify("Supplier Batch No. 2")
//         {
//             StyleExpr = HighLightRow;
//         }
//         modify("Selected Quantity")
//         {
//             StyleExpr = HighLightRow;
//         }
//         modify("Manufacturing Date 2")
//         {
//             StyleExpr = HighLightRow;
//         }
//         modify("Expiry Period 2")
//         {
//             StyleExpr = HighLightRow;
//         }
//         modify("Expiration Date")
//         {
//             StyleExpr = HighLightRow;
//         }
//         modify("Total Requested Quantity")
//         {
//             StyleExpr = HighLightRow;
//         }
//         modify("Total Reserved Quantity")
//         {
//             StyleExpr = HighLightRow;
//         }
//         modify("Current Pending Quantity")
//         {
//             StyleExpr = HighLightRow;
//         }
//         modify("Current Reserved Quantity")
//         {
//             StyleExpr = HighLightRow;
//         }
//     }

//     trigger OnAfterGetRecord()
//     begin
//         if Rec."Of Spec" then
//             HighLightRow := 'Unfavorable'//'Ambiguous'
//         else
//             HighLightRow := 'None';
//     end;

//     var
//         HighLightRow: Text;
// }
