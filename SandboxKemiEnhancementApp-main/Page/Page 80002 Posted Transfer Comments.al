// page 80002 "Posted Transfer Comments"//T12370-Full Comment
// {
//     PageType = List;
//     UsageCategory = Lists;
//     ApplicationArea = All;
//     SourceTable = "Posted Transfer Txn. Comments";
//     Editable = false;

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

//     actions
//     {
//         area(Processing)
//         {
//             action(ActionName)
//             {
//                 ApplicationArea = All;

//                 trigger OnAction();
//                 begin

//                 end;
//             }
//         }
//     }
// }