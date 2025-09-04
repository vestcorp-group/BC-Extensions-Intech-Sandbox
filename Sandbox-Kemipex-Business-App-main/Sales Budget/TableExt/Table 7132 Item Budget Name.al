// /// <summary>
// /// TableExtension KFZEItem Budget Name (ID 53400) extends Record Item Budget Name.
// /// </summary>
// tableextension 53400 "KFZEItem Budget Name" extends "Item Budget Name"//T12370-Full Comment
// {
//     fields
//     {
//         field(53400; "KFZESales Person Filter"; Code[100])
//         {
//             FieldClass = FlowFilter;
//             Caption = 'Sales Person Filter';
//         }
//         field(53401; "KFZESales Person Code"; Code[100])
//         {
//             TableRelation = "Salesperson/Purchaser";
//             Caption = 'Sales Person Code';
//         }
//         field(53402; "KFZEShow as Lines"; Text[30])
//         {
//             DataClassification = CustomerContent;
//             Caption = 'Show as Lines';
//         }
//         field(53403; "KFZEShow as Columns"; Text[30])
//         {
//             DataClassification = CustomerContent;
//             Caption = 'Show as Columns';
//         }
//         field(53404; "KFZEShow Value as"; Enum "Item Analysis Value Type")
//         {
//             DataClassification = CustomerContent;
//             Caption = 'Show Value as';
//         }
//         field(53405; "KFZERounding Factor"; Enum "Analysis Rounding Factor")
//         {
//             DataClassification = CustomerContent;
//             Caption = 'Rounding Factor';
//         }
//         field(53406; "KFZE Year"; Integer)
//         {
//             DataClassification = CustomerContent;
//             Caption = 'Year';
//         }
//         field(53407; "KFZEParameter"; Code[10])
//         {
//             DataClassification = CustomerContent;
//             Caption = 'Budget Parameters';
//             TableRelation = "KZFESales Budget Parameter";

//             trigger OnValidate()
//             var
//                 UserSetup: Record "User Setup";
//                 SalesBudgetParameter: Record "KZFESales Budget Parameter";
//             begin
//                 UserSetup.Get(UserId);
//                 SalesBudgetParameter.Get(KFZEParameter);

//                 Rec."KFZESales Person Code" := UserSetup."Salespers./Purch. Code";
//                 Rec."KFZERounding Factor" := SalesBudgetParameter."Rounding Factor";
//                 Rec."KFZEShow as Columns" := SalesBudgetParameter."Show as Columns";
//                 Rec."KFZEShow as Lines" := SalesBudgetParameter."Show as Lines";
//                 Rec."KFZEShow Value as" := SalesBudgetParameter."Show Value as";
//             end;
//         }
//     }

// }