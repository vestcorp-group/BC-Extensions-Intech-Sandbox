// tableextension 50351 UserTaskTblEx extends "User Task"//T12370-Full Comment
// {
//     fields
//     {
//         modify(ID)
//         {
//             trigger OnAfterValidate()
//             var
//                 ApprovalEN: Record "Approval Entry";

//             begin
//                 ID2 := Format(ID);
//                 Rec.Modify();
//             end;
//         }
//         field(50100; "Task Requester"; code[30])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = User."User Name";
//             ValidateTableRelation = false;

//             trigger OnValidate()
//             var
//                 myInt: Integer;
//             begin
//                 TestField(rec."Approval Status", Rec."Approval Status"::Open);
//             end;
//         }
//         field(50101; ID2; Code[50])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(50102; "Task Document Type"; Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionCaption = ' ,Sales Order,Customer Registration,System Issues,Blanket Sales Order,Other,New Blanket Sales Order,New IC Sales Order';
//             OptionMembers = "","Order","Customer Registration","System Issues","Blanket Order",Other,"New Blanket Sales Order","New IC Sales Order",;
//             trigger OnValidate()
//             var
//                 myInt: Integer;
//             begin
//                 TestField(rec."Approval Status", Rec."Approval Status"::Open);
//             end;
//         }
//         field(50103; "Task Reference Document"; Code[50])
//         {
//             DataClassification = ToBeClassified;
// #pragma warning disable AL0603 // TODO: - Option set is different than sales document type option-30-04-2022
//             TableRelation = "Sales Header"."No." where("Document Type" = field("Task Document Type"));
// #pragma warning restore AL0603 // TODO: - Option set is different than sales document type option-30-04-2022
//             trigger OnValidate()
//             var
//                 myInt: Integer;
//             begin
//                 TestField(rec."Approval Status", Rec."Approval Status"::Open);
//             end;
//         }
//         field(50104; "Approval Status"; Option)
//         {
//             OptionMembers = "Open","Pending Approval",Approved,Rejected,Delegated;
//             OptionCaption = 'Open,Pending Approval,Approved,Rejected,Delegated';
//             DataClassification = ToBeClassified;
//             trigger OnValidate()
//             var

//                 UserTaskSetup: Record "User Task Setup";
//             begin
//                 UserTaskSetup.Get();
//                 if UserId <> UserTaskSetup."User Task Admin" then Error('Approval status is not editable');
//             end;
//         }
//         field(50105; "Task Document No"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(50106; "6th"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         modify("Assigned To User Name")
//         {
//             trigger OnBeforeValidate()
//             var
//                 myInt: Integer;
//             begin
//                 TestField(rec."Approval Status", Rec."Approval Status"::Open);
//             end;
//         }
//         modify("Completed By")
//         {
//             trigger OnBeforeValidate()
//             var
//                 myInt: Integer;
//             begin
//                 TestField(rec."Approval Status", Rec."Approval Status"::Open);
//             end;
//         }
//         modify("Completed By User Name")
//         {
//             trigger OnBeforeValidate()
//             var
//                 myInt: Integer;
//             begin
//                 TestField(rec."Approval Status", Rec."Approval Status"::Open);
//             end;
//         }
//         modify(Title)
//         {
//             trigger OnBeforeValidate()
//             var
//                 myInt: Integer;
//             begin
//                 TestField(rec."Approval Status", Rec."Approval Status"::Open);
//             end;
//         }
//         modify(Description)
//         {
//             trigger OnBeforeValidate()
//             var
//                 myInt: Integer;
//             begin
//                 TestField(rec."Approval Status", Rec."Approval Status"::Open);
//             end;
//         }
//         modify("User Task Group Assigned To")
//         {
//             trigger OnBeforeValidate()
//             var
//                 myInt: Integer;
//             begin
//                 TestField(rec."Approval Status", Rec."Approval Status"::Open);
//             end;
//         }
//         modify("Due DateTime")
//         {
//             trigger OnBeforeValidate()
//             var
//                 myInt: Integer;
//             begin
//                 TestField(rec."Approval Status", Rec."Approval Status"::Open);
//             end;
//         }
//         modify("Object ID")
//         {
//             trigger OnBeforeValidate()
//             var
//                 myInt: Integer;
//             begin
//                 TestField(rec."Approval Status", Rec."Approval Status"::Open);
//             end;
//         }
//         modify("Object Type")
//         {
//             trigger OnBeforeValidate()
//             var
//                 myInt: Integer;
//             begin
//                 TestField(rec."Approval Status", Rec."Approval Status"::Open);
//             end;
//         }
//         modify("Percent Complete")
//         {
//             trigger OnBeforeValidate()
//             var
//                 myInt: Integer;
//             begin
//                 TestField(rec."Approval Status", Rec."Approval Status"::Open);
//             end;
//         }
//         modify("Start DateTime")
//         {
//             trigger OnBeforeValidate()
//             var
//                 myInt: Integer;
//             begin
//                 TestField(rec."Approval Status", Rec."Approval Status"::Open);
//             end;
//         }
//         modify(Priority)
//         {
//             trigger OnBeforeValidate()
//             var
//                 myInt: Integer;
//             begin
//                 TestField(rec."Approval Status", Rec."Approval Status"::Open);
//             end;
//         }
//         modify("Completed DateTime")
//         {
//             trigger OnBeforeValidate()
//             var
//                 myInt: Integer;
//             begin
//                 TestField(rec."Approval Status", Rec."Approval Status"::Open);
//             end;
//         }
//     }

//     procedure CheckApprovalStatus() AllowedModify: Boolean;
//     begin
//         if Rec."Approval Status" = Rec."Approval Status"::Open then
//             AllowedModify := true;
//         exit(AllowedModify);
//     end;
// }