// tableextension 58233 itemreference extends "Item Reference"//T12370-Full Comment
// {
//     fields
//     {
//         field(58234; LineHSNCode; Code[20])
//         {
//             Caption = 'Line HSN Code';
//             DataClassification = ToBeClassified;
//             TableRelation = "Tariff Number";
//             Editable = true;
//         }
//         field(58235; LineCountryOfOrigin; Code[20])
//         {
//             Caption = 'Line Country of Origin';
//             DataClassification = ToBeClassified;
//             TableRelation = "Country/Region";
//             Editable = true;
//         }
//         field(58236; "Line Generic Name"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = KMP_TblGenericName.Description;
//             Editable = true;
//             ValidateTableRelation = false;
//         }
//     }
// }