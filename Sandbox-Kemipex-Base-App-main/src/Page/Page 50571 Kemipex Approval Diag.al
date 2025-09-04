// page 50571 "Kemipex Approval Diag"//T12370-Full Comment
// {
//     PageType = StandardDialog;
//     // ApplicationArea = All;
//     // UsageCategory = Administration;
//     Caption = 'Approval Request Note';    // SourceTable = "Kemipex Notes";
//     layout
//     {
//         area(Content)
//         {
//             field(notetext; notetext)
//             {
//                 ApplicationArea = all;
//                 Width = 200;
//                 ShowCaption = false;
//                 MultiLine = true;
//                 trigger OnValidate()
//                 var
//                     myInt: Integer;
//                 begin

//                 end;
//             }
//         }
//     }

//     procedure Getnote(var Notes: Text)
//     begin
//         Notes := notetext;
//     end;

//     // procedure Getnote(): Text
//     // begin

//     //     exit(notetext);
//     // end;

//     var
//         notetext: Text;
// }