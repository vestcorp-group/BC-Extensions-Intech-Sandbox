// page 80014 "Sales Order Remarks"//T12370-Full Comment
// {
//     PageType = List;
//     UsageCategory = Lists;
//     ApplicationArea = All;
//     SourceTable = "Sales Order Remarks";
//     DelayedInsert = true;
//     MultipleNewLines = true;
//     AutoSplitKey = true;
//     LinksAllowed = false;
//     layout
//     {
//         area(Content)
//         {
//             repeater(Group)
//             {
//                 field(Comments; rec.Comments)
//                 {
//                     ApplicationArea = All;
//                 }

//             }
//         }
//         area(Factboxes)
//         {

//         }
//     }


//     trigger OnInsertRecord(BelowxRec: Boolean): Boolean
//     var
//     begin
//     end;
// }