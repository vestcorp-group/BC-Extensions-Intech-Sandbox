// page 53021 "Custom Notification Setup"//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'Custom Notification Setup';
//     PageType = List;
//     SourceTable = "Custom Notification Setup";
//     UsageCategory = Lists;
//     CardPageId = "Notification Setup Card";
//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 field("Code"; Rec."Code")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Code field.';
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
//             }
//         }
//     }

//     actions
//     {
//         area(Processing)
//         {
//             action("Run Notification Job")
//             {
//                 ApplicationArea = All;
//                 Image = ExecuteBatch;
//                 Promoted = true;
//                 PromotedOnly = true;
//                 PromotedCategory = Process;
//                 trigger OnAction()
//                 begin
//                     Report.Run(Report::"Custom Notification Dispatcher");
//                 end;
//             }
//         }
//     }
// }
