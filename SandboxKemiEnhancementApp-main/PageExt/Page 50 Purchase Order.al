// pageextension 80013 "Purchase Order Page Extension" extends "Purchase Order"//T12370-Full Comment
// {
//     layout
//     {
//         addlast(General)
//         {
//             field("Buy-from IC Partner Code"; Rec."Buy-from IC Partner Code")
//             {
//                 ApplicationArea = All;
//             }
//             field("Send IC Document"; Rec."Send IC Document")
//             {
//                 ApplicationArea = All;
//             }
//             field("IC Direction"; Rec."IC Direction")
//             {
//                 ApplicationArea = All;
//             }
//             field("IC Status"; Rec."IC Status")
//             {
//                 ApplicationArea = All;
//             }
//         }
//     }

//     actions
//     {
//         // Add changes to page actions here
//     }

//     var
//         myInt: Integer;
// }