// page 53023 "Notification Setup Card"//T12370-Full Comment
// {
//     Caption = 'Notification Setup';
//     PageType = Document;
//     SourceTable = "Custom Notification Setup";

//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 field("Code"; Rec."Code")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Code field.';
//                     Enabled = false;
//                 }
//                 field("Table"; Rec."Table")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Table field.';
//                 }
//                 field("Field Id"; Rec."Field Id")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Field Id field.';
//                     DrillDown = true;

//                     trigger OnDrillDown()
//                     var
//                         RecFieldList: Record Field;
//                         PageFieldList: Page "Field List";
//                     begin
//                         Clear(RecFieldList);

//                         if Rec.Table = Rec.Table::Item then
//                             RecFieldList.SetRange(TableNo, 27)
//                         else
//                             if Rec.Table = Rec.Table::"Reservation Entry" then
//                                 RecFieldList.SetRange(TableNo, 337)
//                             else
//                                 if Rec.Table = Rec.Table::"Sales Header" then
//                                     RecFieldList.SetRange(TableNo, 36);

//                         RecFieldList.SetFilter("No.", '<%1', 2000000000);
//                         PageFieldList.SetTableView(RecFieldList);
//                         PageFieldList.SetRecord(RecFieldList);
//                         PageFieldList.LookupMode(true);
//                         IF PageFieldList.RunModal() = Action::LookupOK then begin
//                             // PageFieldList.SetSelectionFilter(RecFieldList);
//                             PageFieldList.GetRecord(RecFieldList);
//                             Rec."Field Id" := RecFieldList."No.";
//                             Rec."Field Name" := RecFieldList."Field Caption";
//                         end;
//                     end;
//                 }
//                 field("Field Name"; Rec."Field Name")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Field Name field.';
//                 }
//                 field("Filter Text"; Rec."Filter Text")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Filter Text field.';
//                 }
//                 field(Enabled; Rec.Enabled)
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Enabled field.';
//                 }
//                 field("Notification Text"; Rec."Notification Text")
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//             part(Lines; "Notification Lines")
//             {
//                 ApplicationArea = All;
//                 SubPageLink = "Notification Code" = field(Code);
//             }
//         }
//     }
// }
