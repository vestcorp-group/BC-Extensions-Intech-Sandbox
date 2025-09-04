// page 50395 "Active Sessions"//T12370-Full Comment
// {
//     PageType = List;
//     ApplicationArea = All;
//     UsageCategory = Administration;
//     SourceTable = "Active Session";
//     Permissions = tabledata "Active Session" = rimd;
//     Editable = false;

//     layout
//     {
//         area(Content)
//         {
//             repeater(General)
//             {
//                 field("User ID"; rec."User ID")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("User SID"; rec."User SID")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Session ID"; rec."Session ID")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Database Name"; rec."Database Name")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }
//     actions
//     {
//         area(Processing)
//         {
//             action("Kill Session")
//             {
//                 ApplicationArea = All;
//                 Image = Delete;

//                 trigger OnAction()
//                 begin
//                     if Session.IsSessionActive(rec."Session ID") then if StopSession(rec."Session ID") then Message('Session stopped!');
//                 end;
//             }
//         }
//     }
//     var
//         myInt: Integer;
// }
