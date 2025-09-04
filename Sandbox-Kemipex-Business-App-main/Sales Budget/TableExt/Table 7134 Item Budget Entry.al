// tableextension 53404 "KFZE Item Buedget Entry" extends "Item Budget Entry"//T12370-Full Comment
// {
//     fields
//     {
//         field(53400; "KFZESalesperson Code"; Code[20])
//         {
//             DataClassification = CustomerContent;
//             Caption = 'Salesperson Code';
//             TableRelation = "Salesperson/Purchaser";
//             Editable = false;
//         }
//         field(53401; "KFZESales Team"; Code[20])
//         {
//             DataClassification = CustomerContent;
//             Caption = 'Sales Team';
//             TableRelation = Team;
//             Editable = false;
//         }
//     }

//     keys
//     {
//         // Add changes to keys here
//     }

//     fieldgroups
//     {
//         // Add changes to field groups here
//     }

//     var
//         myInt: Integer;
// }