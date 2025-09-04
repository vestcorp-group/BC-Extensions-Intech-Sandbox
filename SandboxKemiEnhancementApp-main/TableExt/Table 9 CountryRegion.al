// tableextension 70101 CountryRegion extends "Country/Region"//T12370-Full Comment
// {
//     fields
//     {
//         field(58043; "Region Dimension"; Code[50])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "Dimension Value".Code where("Dimension Code" = const('RG'));
//         }
//     }

//     var
//         myInt: Integer;
// }