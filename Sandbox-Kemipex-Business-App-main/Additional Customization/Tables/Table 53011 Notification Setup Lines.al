// table 53011 "Notification Setup Lines"//T12370-Full Comment
// {
//     Caption = 'Notification Setup Lines';
//     DataClassification = ToBeClassified;

//     fields
//     {
//         field(1; "Notification Code"; Code[10])
//         {
//             Caption = 'Notification Code';
//             DataClassification = ToBeClassified;
//         }
//         field(2; "User Id"; Text[30])
//         {
//             Caption = 'User Id';
//             DataClassification = ToBeClassified;
//             TableRelation = User."User Name";
//             ValidateTableRelation = false;

//             trigger OnValidate()
//             var
//                 UserSelection: Codeunit "User Selection";
//             begin
//                 UserSelection.ValidateUserName("User ID");
//             end;
//         }
//     }
//     keys
//     {
//         key(PK; "Notification Code", "User Id")
//         {
//             Clustered = true;
//         }
//     }
// }
