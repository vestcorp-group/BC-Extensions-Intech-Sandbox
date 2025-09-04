// table 53204 "PO Approval Field Incl. Setup"//T12370-Full Comment
// {
//     Caption = 'PO Approval Field Include Setup';
//     LookupPageID = "PO Approval Field Incl. Setup";

//     fields
//     {
//         field(1; TableNo; Integer)
//         {
//             TableRelation = "Table Metadata".ID;
//             trigger OnValidate()
//             begin
//                 if TableObjects.Get(TableNo) then
//                     TableName := TableObjects.Name
//                 else
//                     TableName := '';
//             end;
//         }
//         field(2; "No."; Integer)
//         {
//             Caption = 'Field No.';
//             TableRelation = Field."No." where(TableNo = field(TableNo));
//             trigger OnValidate()
//             begin
//                 if FieldRec.Get(TableNo, "No.") then
//                     FieldName := FieldRec.FieldName
//                 else
//                     FieldName := '';
//             end;
//         }
//         field(3; TableName; Text[30])
//         {
//             Editable = false;
//         }

//         field(4; FieldName; Text[30])
//         {
//             Editable = false;
//         }
//         field(10; "Approval Document Type"; Enum "Approval Doc Type")
//         {
//         }

//     }

//     keys
//     {
//         key(pk; TableNo, "No.", "Approval Document Type")
//         {
//         }
//     }
//     var
//         TableObjects: Record "Table Metadata";
//         FieldRec: Record Field;
// }