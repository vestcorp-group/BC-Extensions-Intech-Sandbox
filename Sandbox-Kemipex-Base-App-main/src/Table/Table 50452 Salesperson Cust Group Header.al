// table 50452 "Salesperson Cust Group Header"//T12370-Full Comment
// {
//     DataClassification = ToBeClassified;
//     fields
//     {
//         field(1; "Salesperson Code"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "Salesperson/Purchaser";
//             trigger OnValidate()
//             var
//                 SalespersonRec: Record "Salesperson/Purchaser";
//             begin
//                 if SalespersonRec.Get("Salesperson Code") then "Salesperson Name" := SalespersonRec.Name;

//             end;
//         }
//         field(2; "Salesperson Name"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//         }
//     }

//     keys
//     {
//         key(PK; "Salesperson Code")
//         {
//             Clustered = true;
//         }
//     }

//     var
//         myInt: Integer;

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