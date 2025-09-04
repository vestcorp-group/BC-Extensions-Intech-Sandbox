// table 53213 "Amendment Approval Setup"//T12370-Full Comment
// {
//     Caption = 'Amendment Approval Setup';
//     DataClassification = ToBeClassified;

//     fields
//     {
//         field(1; "Document type"; Enum "DCM_Document Type")
//         {
//             Caption = 'Document type';
//             DataClassification = CustomerContent;
//         }
//         field(2; "Requester Name"; Code[100])
//         {
//             Caption = 'Requester Name';
//             DataClassification = CustomerContent;
//             TableRelation = "User Setup";
//             ObsoleteState = Removed;
//         }
//         field(3; "Requester E-Mail"; Text[100])
//         {
//             Caption = 'Requester E-Mail';
//             DataClassification = CustomerContent;
//             ObsoleteState = Removed;
//         }
//         field(4; "Approver Name"; Code[100])
//         {
//             Caption = 'Approver Name';
//             DataClassification = CustomerContent;
//             TableRelation = "User Setup";
//             trigger OnValidate()
//             var
//                 userSetup: Record "User Setup";
//                 Setup: Record "Amendment Approval Setup";
//             begin
//                 userSetup.GET("Approver Name");
//                 "Approver E-Mail" := userSetup."E-Mail";
//                 Clear(Setup);
//                 Setup.SetRange("Document type", Rec."Document type");
//                 Setup.SetRange("Amendment Type", Rec."Amendment Type");
//                 Setup.SetRange("Approver Name", Rec."Approver Name");
//                 if Setup.FindFirst() then
//                     Error('Amendment Setup already exists for the same Approver %1', Rec."Approver Name");
//             end;
//         }
//         field(5; "Approver E-Mail"; Text[100])
//         {
//             Caption = 'Approver E-Mail';
//             DataClassification = CustomerContent;
//         }
//         field(6; "Approver Level"; Integer)
//         {
//             Caption = 'Approval Level';
//             DataClassification = CustomerContent;
//         }
//         field(7; "Amendment Type"; Enum "Amendment Type")
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(8; "Approver Type"; Option)
//         {
//             Caption = 'Approver Type';
//             DataClassification = ToBeClassified;
//             OptionMembers = " ","User","Manager","Salesperson","Posted User";
//             trigger OnValidate()
//             begin
//                 if "Approver Type" <> "Approver Type"::User then
//                     "Approver Name" := '';
//             end;
//         }
//     }
//     keys
//     {
//         //key(PK; "Document type", "Requester Name", "Approver Name")
//         key(PK; "Document type", "Amendment Type", "Approver Name", "Approver Level")
//         {
//             Clustered = true;
//         }
//     }
// }
