// page 50471 "Kemipex Notes"
// {
//     PageType = ListPart;
//     SourceTable = "Kemipex Notes";

//     layout
//     {
//         area(Content)
//         {
//             repeater(GroupName)
//             {

//                 Caption = 'Note';
//                 field(NoteTex; NoteTex)
//                 {
//                     ApplicationArea = All;
//                     MultiLine = true;
//                     ShowCaption = false;
//                     Width = 45;
//                     Editable = true;
//                     RowSpan = 60;
//                 }
//                 field(SystemCreatedAt; rec.SystemCreatedAt)
//                 {
//                     ApplicationArea = all;
//                     ShowCaption = false;
//                     Width = 10;
//                 }
//             }
//         }
//     }


//     trigger OnAfterGetRecord()
//     var
//         myInt: Integer;
//         Ins: InStream;
//     begin
//         Clear(NoteTex);
//         rec.CalcFields(Note);
//         rec.Note.CreateinStream(Ins, TextEncoding::UTF8);
//         Ins.ReadText(NoteTex);

//     end;


//     var
//         NoteTex: Text;
//         noteRec: Record "Record Link";
//         Plus: Label '+';

// }