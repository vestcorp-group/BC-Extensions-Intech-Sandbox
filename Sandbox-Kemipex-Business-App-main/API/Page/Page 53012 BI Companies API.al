// page 53012 "BI Companies API"//T12370-Full Comment
// {
//     Caption = 'BI Companies API';
//     PageType = List;
//     SourceTable = Company;
//     Permissions = tabledata Company = R;
//     DataCaptionFields = Name;
//     ApplicationArea = All;
//     UsageCategory = History;
//     DeleteAllowed = false;
//     ModifyAllowed = false;
//     InsertAllowed = false;
//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 field(Name; Rec.Name)
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field(Currency; Currency)
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Block in Reports"; BlockInReport)
//                 {
//                     ApplicationArea = All;
//                 }

//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     var
//         GLSetup: Record "General Ledger Setup";
//         RecShortName: Record "Company Short Name";
//     begin
//         Clear(GLSetup);
//         GLSetup.ChangeCompany(Rec.Name);
//         GLSetup.GET;
//         Currency := GLSetup."LCY Code";
//         Clear(BlockInReport);
//         Clear(RecShortName);
//         if RecShortName.Get(Rec.Name) then
//             BlockInReport := RecShortName."Block in PowerBI";
//     end;

//     var
//         Currency: code[10];
//         BlockInReport: Boolean;
// }
