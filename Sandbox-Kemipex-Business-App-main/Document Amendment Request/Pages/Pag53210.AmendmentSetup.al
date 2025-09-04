// page 53210 "Amendment Request Setup"//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'Amendment Request Setup';
//     PageType = List;
//     SourceTable = "Amendment Request Setup";
//     UsageCategory = Administration;
//     DelayedInsert = true;

//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 field("DCM_Document Type"; Rec."DCM_Document Type")
//                 {
//                     ApplicationArea = All;
//                     Visible = NOT DisableField;
//                     ToolTip = 'Specifies the value of the Document Type field.';
//                 }
//                 field("DCM_Table No."; Rec."DCM_Table No.")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Table No. field.';
//                     DrillDown = true;
//                     Visible = NOT DisableField;
//                     trigger OnDrillDown()
//                     var
//                         AllObj: Record AllObj;
//                         TableList: Page "Table List";
//                     begin
//                         Clear(AllObj);
//                         AllObj.SetRange("Object Type", AllObj."Object Type"::Table);
//                         AllObj.SetFilter("Object ID", '%1|%2', 112, 113);
//                         TableList.SetTableView(AllObj);
//                         TableList.SetRecord(AllObj);
//                         TableList.LookupMode(true);
//                         IF TableList.RunModal() = Action::LookupOK then begin
//                             TableList.GetRecord(AllObj);
//                             Rec."DCM_Table No." := AllObj."Object ID";
//                             Rec."DCM_Table Name" := AllObj."Object Name";
//                         end;
//                     end;
//                 }
//                 field("DCM_Table Name"; Rec."DCM_Table Name")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Table No. field.';
//                 }
//                 field("DCM_Field No."; Rec."DCM_Field No.")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Field No. field.';
//                     DrillDown = true;
//                     Visible = NOT DisableField;

//                     trigger OnDrillDown()
//                     var
//                         RecFieldList: Record Field;
//                         PageFieldList: Page "Field List";
//                     begin
//                         Clear(RecFieldList);
//                         RecFieldList.SetRange(TableNo, Rec."DCM_Table No.");
//                         RecFieldList.SetFilter("No.", '<%1', 2000000000);
//                         PageFieldList.SetTableView(RecFieldList);
//                         PageFieldList.SetRecord(RecFieldList);
//                         PageFieldList.LookupMode(true);
//                         IF PageFieldList.RunModal() = Action::LookupOK then begin
//                             PageFieldList.GetRecord(RecFieldList);
//                             Rec."DCM_Field No." := RecFieldList."No.";
//                             Rec."DCM_Field Name" := RecFieldList."Field Caption";
//                         end;
//                     end;

//                 }
//                 field("DCM_Field Name"; Rec."DCM_Field Name")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Field No. field.';
//                 }
//                 field("DCM_Change Level"; Rec."Amendment Type")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Change Level field.';
//                 }
//             }
//         }
//     }
//     procedure SetVisibility(DisableFieldp: Boolean)
//     begin
//         DisableField := DisableFieldp;
//     end;

//     var
//         DisableField: Boolean;
// }
