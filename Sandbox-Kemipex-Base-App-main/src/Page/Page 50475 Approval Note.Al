// page 50475 "Approval Note"//T12370-Full Comment
// {
//     PageType = CardPart;
//     ApplicationArea = All;
//     UsageCategory = Administration;
//     SourceTable = "Kemipex Approval Entry";

//     layout
//     {
//         area(Content)
//         {

//             field(Note; Note)
//             {
//                 ApplicationArea = All;
//                 ShowCaption = false;
//                 MultiLine = true;
//                 ColumnSpan = 20;
//                 RowSpan = 30;
//                 Editable = false;
//             }
//         }
//     }


//     trigger OnAfterGetRecord()
//     var
//         RecordLink: Record "Record Link";
//         RecordLinkmangement: Codeunit "Record Link Management";
//     begin
//         RecordLink.Get(rec."Related Note");
//         RecordLink.CalcFields(Note);
//         Note := RecordLinkmangement.ReadNote(RecordLink);
//     end;

//     var
//         myInt: Integer;
//         Note: Text;
// }