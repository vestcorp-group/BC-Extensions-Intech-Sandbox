// table 53214 "Amendment Approval Entries"//T12370-Full Comment
// {
//     Caption = 'Amendment Approval Entries';
//     DataClassification = ToBeClassified;

//     fields
//     {
//         field(1; "Entry No."; Integer)
//         {
//             Caption = 'Entry No.';
//             DataClassification = CustomerContent;
//         }
//         field(3; "Document Type"; Enum "DCM_Document Type")
//         {
//             Caption = 'Document Type';
//             DataClassification = CustomerContent;
//         }
//         field(4; "Document No."; Code[20])
//         {
//             Caption = 'Document No.';
//             DataClassification = CustomerContent;
//         }
//         field(2; "Amendment No."; Code[20])
//         {
//             Caption = 'Amendment No.';
//             DataClassification = CustomerContent;
//         }
//         field(5; "Requester Name"; Code[100])
//         {
//             Caption = 'Requester Name';
//             DataClassification = CustomerContent;
//         }
//         field(6; "Approver Name"; Code[100])
//         {
//             Caption = 'Approver Name';
//             DataClassification = CustomerContent;
//         }
//         field(7; "Approval Submit DateTime"; DateTime)
//         {
//             Caption = 'Approval Submit DateTime';
//             DataClassification = CustomerContent;
//         }
//         field(8; "Approval Request Status"; Enum "Amendment Approval Status")
//         {
//             Caption = 'Approval Request Status';
//             DataClassification = CustomerContent;
//         }
//         field(9; "Last Modify DateTime"; DateTime)
//         {
//             Caption = 'Last Modify DateTime';
//             DataClassification = CustomerContent;
//         }
//         field(10; "Approval Sequence"; Integer)
//         {
//             Caption = 'Approval Sequence';
//             DataClassification = CustomerContent;
//         }
//         field(11; "Last Modify By"; code[100])
//         {
//             Caption = 'Last Modify By';
//             DataClassification = CustomerContent;
//         }
//         field(12; "Requester E-Mail"; Text[100])
//         {
//             Caption = 'Requester E-Mail';
//         }
//         field(13; "Approver E-Mail"; Text[100])
//         {
//             Caption = 'Approver E-Mail';
//         }
//         field(14; "Approved Date Time"; DateTime)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(15; "Rejected Date Time"; DateTime)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(16; "Amendment Type"; Enum "Amendment Type")
//         {
//             DataClassification = ToBeClassified;
//         }
//     }
//     keys
//     {
//         key(PK; "Entry No.")
//         {
//             Clustered = true;
//         }
//     }

//     trigger OnInsert()
//     begin
//         "Last Modify DateTime" := CurrentDateTime;
//         "Last Modify By" := UserId;
//     end;

//     trigger OnModify()
//     begin
//         "Last Modify DateTime" := CurrentDateTime;
//         "Last Modify By" := UserId;
//     end;

//     procedure GetNextEntryNo(): Integer
//     begin
//         if Rec.FindLast() then
//             exit(Rec."Entry No." + 1)
//         else
//             exit(1);
//     end;
// }
