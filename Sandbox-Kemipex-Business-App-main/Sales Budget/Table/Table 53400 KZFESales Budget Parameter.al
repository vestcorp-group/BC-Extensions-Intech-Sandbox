// table 53400 "KZFESales Budget Parameter"//T12370-Full Comment
// {
//     DataClassification = CustomerContent;
//     Caption = 'Sales Budget Parameter';

//     fields
//     {
//         field(1; "Primary Key"; Code[10])
//         {
//             DataClassification = ToBeClassified;
//             Caption = 'Code';
//         }
//         field(2; "Show as Lines"; Text[30])
//         {
//             DataClassification = CustomerContent;

//             trigger OnLookup()
//             var
//                 ItemBudgetName: Record "Item Budget Name";
//                 NewCode: Text[30];
//             begin
//                 NewCode := ItemBudgetManagement.GetDimSelection(Rec."Show as Lines", ItemBudgetName);
//                 if NewCode <> Rec."Show as Lines" then
//                     Rec."Show as Lines" := NewCode;
//             end;
//         }
//         field(3; "Show as Columns"; Text[30])
//         {
//             DataClassification = CustomerContent;

//             trigger OnLookup()
//             var
//                 ItemBudgetName: Record "Item Budget Name";
//                 NewCode: Text[30];
//             begin
//                 NewCode := ItemBudgetManagement.GetDimSelection("Show as Columns", ItemBudgetName);
//                 if NewCode <> "Show as Columns" then
//                     "Show as Columns" := NewCode;
//             end;
//         }
//         field(4; "Show Value as"; Enum "Item Analysis Value Type")
//         {
//             DataClassification = CustomerContent;
//         }
//         field(5; "Rounding Factor"; Enum "Analysis Rounding Factor")
//         {
//             DataClassification = CustomerContent;
//         }
//     }

//     keys
//     {
//         key(Key1; "Primary Key")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//         // Add changes to field groups here
//     }

//     var
//         ItemBudgetManagement: Codeunit "Item Budget Management";

//     trigger OnInsert()
//     begin

//     end;

//     trigger OnModify()
//     begin

//     end;

//     trigger OnDelete()
//     begin

//     end;

//     trigger OnRename()
//     begin

//     end;

// }