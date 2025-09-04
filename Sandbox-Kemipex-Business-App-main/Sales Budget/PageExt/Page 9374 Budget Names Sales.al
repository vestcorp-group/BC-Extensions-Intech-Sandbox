// pageextension 53400 "ABBudget Names Sales" extends "Budget Names Sales"//T12370-Full Comment
// {
//     layout
//     {
//         addafter(Blocked)
//         {

//             field("KFZESales Person Code"; Rec."KFZESales Person Code")
//             {
//                 ApplicationArea = All;
//                 ToolTip = 'Specifies the value of the Sales Person Code field.';
//             }
//         }
//     }
//     trigger OnOpenPage()
//     begin
//         Error('Please use Sales Budget - Custom');
//     end;

// }