// table 53210 "Amendment Request Setup"//T12370-Full Comment
// {
//     Caption = 'Amendment Request Setup';
//     DataClassification = ToBeClassified;

//     fields
//     {
//         field(1; "DCM_Document Type"; Enum "DCM_Document Type")
//         {
//             Caption = 'Document Type';
//             DataClassification = CustomerContent;
//         }
//         field(2; "Amendment Type"; Enum "Amendment Type")
//         {
//             Caption = 'Amendment Type';
//             DataClassification = CustomerContent;
//             // trigger OnValidate()
//             // var
//             //     myInt: Integer;
//             // begin
//             //     If "Amendment Type" = "Amendment Type"::"Manual Amendment" then begin
//             //         Rec.Validate("DCM_Field No.", 0);
//             //         Rec.Validate("DCM_Field Name", '');
//             //     end
//             // end;
//         }
//         field(3; "DCM_Table No."; Integer)
//         {
//             Caption = 'Table No.';
//             DataClassification = CustomerContent;
//             TableRelation = AllObj."Object ID" where("Object Type" = const(Table), "Object ID" = filter(112 | 113));

//             trigger OnValidate()
//             var
//                 Object: Record AllObj;
//             begin
//                 Object.Reset();
//                 Object.SetRange("Object Type", Object."Object Type"::Table);
//                 Object.SetRange("Object ID", Rec."DCM_Table No.");
//                 if Object.FindFirst() then
//                     Rec."DCM_Table Name" := Object."Object Name"
//                 else
//                     Rec."DCM_Table Name" := '';
//             end;

//         }
//         field(4; "DCM_Field No."; Integer)
//         {
//             Caption = 'Field No.';
//             DataClassification = CustomerContent;
//             TableRelation = Field."No." where(TableNo = field("DCM_Table No."));

//             trigger OnValidate()
//             var
//                 Field: Record Field;
//             begin
//                 if "DCM_Field No." <> 0 then begin
//                     Field.Reset;
//                     Field.SetRange(Field.TableNo, "DCM_Table No.");
//                     Field.SetRange(Field."No.", "DCM_Field No.");
//                     if Field.FindFirst() then
//                         "DCM_Field Name" := Field.FieldName
//                     else
//                         "DCM_Field Name" := '';
//                 end else
//                     "DCM_Field Name" := '';
//             end;
//         }
//         field(5; "DCM_Field Name"; Text[50])
//         {
//             Caption = 'Field Name';
//             DataClassification = CustomerContent;
//             Editable = false;
//         }
//         field(6; "DCM_Table Name"; Text[50])
//         {
//             Caption = 'Change Type';
//             DataClassification = CustomerContent;
//             Editable = false;
//         }
//     }
//     keys
//     {
//         key(PK; "DCM_Document Type", "DCM_Table No.", "DCM_Field No.")
//         {
//             Clustered = true;
//         }
//     }
//     fieldgroups
//     {
//         fieldgroup(DropDown; "DCM_Document Type", "DCM_Table No.", "DCM_Field No.", "Amendment Type")
//         { }

//     }
// }
