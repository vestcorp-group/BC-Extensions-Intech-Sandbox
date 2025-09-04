// page 50100 Testduedays
// {
//     PageType = Card;
//     ApplicationArea = All;
//     UsageCategory = Administration;


//     layout
//     {
//         area(Content)
//         {
//             group(GroupName)
//             {
//                 field(Date1; Date1)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Date2; Date2)
//                 {
//                     ApplicationArea = all;
//                 }

//             }
//         }
//     }

//     actions
//     {
//         area(Creation)
//         {
//             action(Message)
//             {
//                 ApplicationArea = all;
//                 Promoted = true;
//                 trigger OnAction()
//                 var
//                     PaymentTerms: Record "Payment Terms";
//                     SalesDocDueDays: DateFormula;
//                     CustomerMasterDueDays: DateFormula;
//                 begin

//                     if Date1 < Date2 then
//                         Message('Date 2 is bigger')
//                     else
//                         Message('Date 1 is bigger');

//                 end;

//             }

//         }
//     }

//     var
//         Date1: Date;
//         Date2: Date;
// }