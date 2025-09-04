// page 50100 TempNote
// {
//     PageType = List;
//     ApplicationArea = all;
//     UsageCategory = Administration;
//     SourceTable = "Record Link";

//     layout
//     {
//         area(Content)
//         {
//             repeater(GroupName)
//             {

//                 field("Link ID"; REC."Link ID")
//                 {
//                     ApplicationArea = ALL;

//                 }

//                 field(textNote; textNote)
//                 {
//                     ApplicationArea = All;
//                     MultiLine = true;
//                     RowSpan = 10;
//                     ShowCaption = false;
//                 }
//             }
//         }
//     }


//     trigger OnAfterGetRecord()
//     var
//         myInt: Integer;
//         Ins: InStream;
//     begin
//         Clear(textNote);
//         rec.CalcFields(Note);
//         rec.Note.CreateinStream(Ins, TextEncoding::UTF8);
//         Ins.ReadText(textNote);
//     end;

//     var
//         textNote: Text;
// }