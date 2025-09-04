// table 50358 "User Task Setup"//T12370-Full Comment
// {
//     Description = 'User Task Setup';
//     fields
//     {
//         field(1; Primary; Integer)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(2; "User Task No Series"; code[20])
//         {
//             DataClassification = CustomerContent;
//             TableRelation = "No. Series";
//         }
//         field(3; "User Task Admin"; Code[20])
//         {
//             DataClassification = CustomerContent;
//             TableRelation = User."User Name";
//             ValidateTableRelation = false;
//         }
//     }
//     keys
//     {
//         key(PK; Primary)
//         {
//             Clustered = true;
//         }
//     }
//     var
//         myInt: Integer;
// }