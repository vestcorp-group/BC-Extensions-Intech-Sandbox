// table 53212 "Amendment Request Line"//T12370-Full Comment
// {
//     Caption = 'Amendment Request Line';
//     DataClassification = ToBeClassified;

//     fields
//     {
//         field(1; "Amendment No."; Code[20])
//         {
//             Caption = 'Amendment No.';
//             DataClassification = CustomerContent;
//             Editable = false;
//         }
//         field(2; "Line No."; Integer)
//         {
//             Caption = 'Line No.';
//             DataClassification = CustomerContent;
//             Editable = false;
//         }
//         field(3; "Document Line No."; Integer)
//         {
//             Caption = 'Document Line No.';
//             DataClassification = CustomerContent;
//             TableRelation = if ("Table No." = const(113)) "Sales Invoice Line"."Line No." where("Document No." = field("Document No."));
//         }
//         field(4; "Table No."; Integer)
//         {
//             Caption = 'Table No.';
//             DataClassification = CustomerContent;
//             TableRelation = AllObj."Object ID" where("Object Type" = const(Table), "Object ID" = filter(112 | 113));
//             Editable = false;
//         }
//         field(5; "Field No."; Integer)
//         {
//             Caption = 'Field No.';
//             DataClassification = CustomerContent;
//             TableRelation = Field."No." where(TableNo = field("Table No."));
//             Editable = false;
//         }
//         field(6; "Current Value"; Text[100])
//         {
//             Caption = 'Current Value';
//             DataClassification = CustomerContent;
//             Editable = false;
//         }
//         field(7; "New Value"; Text[100])
//         {
//             Caption = 'New Value';
//             DataClassification = CustomerContent;
//         }
//         field(8; "Field Name"; Text[50])
//         {
//             Caption = 'Field Name';
//             DataClassification = CustomerContent;
//             Editable = false;
//         }
//         field(9; "Change Type"; Text[50])
//         {
//             Caption = 'Change Type';
//             DataClassification = CustomerContent;
//             //Editable = false;
//             trigger OnValidate()
//             begin
//                 Rec.ValidateDuplicateRecords();
//             end;
//         }
//         field(10; "Document Type"; enum "DCM_Document Type")
//         {
//             Caption = 'Document Type';
//             DataClassification = CustomerContent;
//             Editable = false;
//         }
//         field(11; "Document No."; Code[20])
//         {
//             Caption = 'Document No.';
//             DataClassification = CustomerContent;
//             Editable = false;
//         }
//         field(12; "Amendment Type"; Enum "Amendment Type")
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//     }
//     keys
//     {
//         key(PK; "Amendment No.", "Line No.")
//         {
//             Clustered = true;
//         }
//     }

//     var
//         recReqHead: Record "Amendment Request";
//         SAlesLine: Record "Sales Line";

//     trigger OnInsert()
//     begin
//         if "Line No." = 0 then
//             "Line No." := GetNextEntryNo(Rec."Amendment No.");

//         if (Rec."Document Type" = Rec."Document Type"::"Posted Sales Invoice") then begin
//             recReqHead.Get(Rec."Amendment No.");
//             Rec."Document Type" := recReqHead."Document Type";
//             Rec."Document No." := recReqHead."Document No.";
//         end;
//     end;

//     trigger OnModify()
//     var
//         recApprovalRequest: Record "Amendment Request";
//     begin
//         recApprovalRequest.Get(Rec."Amendment No.");
//         recApprovalRequest.TestField("Request Status", recApprovalRequest."Request Status"::Open);
//     end;

//     trigger OnDelete()
//     var
//         recApprovalRequest: Record "Amendment Request";
//         recChangeLine: Record "Amendment Request Line";
//         AmendmentReq: Record "Amendment Request";
//     begin
//         recApprovalRequest.Get(Rec."Amendment No.");
//         recApprovalRequest.TestField("Request Status", recApprovalRequest."Request Status"::Open);


//         Clear(AmendmentReq);
//         AmendmentReq.SetRange("Amendment No.", Rec."Amendment No.");
//         if AmendmentReq.FindFirst() then begin
//             Clear(recChangeLine);
//             recChangeLine.SetRange("Amendment No.", Rec."Amendment No.");
//             recChangeLine.SetRange("Amendment Type", recChangeLine."Amendment Type"::"Sales Return");
//             recChangeLine.SetFilter("Line No.", '<>%1', Rec."Line No.");
//             if recChangeLine.FindFirst() then begin
//                 AmendmentReq."Amendment Type" := AmendmentReq."Amendment Type"::"Sales Return";
//             end
//             else begin
//                 Clear(recChangeLine);
//                 recChangeLine.SetRange("Amendment No.", Rec."Amendment No.");
//                 recChangeLine.SetRange("Amendment Type", recChangeLine."Amendment Type"::"Invoice Modification");
//                 recChangeLine.SetFilter("Line No.", '<>%1', Rec."Line No.");
//                 if recChangeLine.FindFirst() then begin
//                     AmendmentReq."Amendment Type" := AmendmentReq."Amendment Type"::"Invoice Modification";
//                 end else
//                     AmendmentReq."Amendment Type" := AmendmentReq."Amendment Type"::"Manual Amendment";
//             end;
//             AmendmentReq.Modify();
//         end;
//     end;

//     procedure GetNextEntryNo(RequestNo: Code[20]): Integer
//     var
//         recChangeReqLine: Record "Amendment Request Line";
//     begin
//         recChangeReqLine.Reset();
//         recChangeReqLine.SetRange("Amendment No.", RequestNo);
//         if recChangeReqLine.FindLast() then
//             exit(recChangeReqLine."Line No." + 1);

//         exit(1);
//     end;

//     procedure ValidateDuplicateRecords()
//     var
//         recChangeLine: Record "Amendment Request Line";
//     begin
//         case Rec."Table No." of
//             Database::"Sales Invoice Header":
//                 begin
//                     Clear(recChangeLine);
//                     recChangeLine.SetRange("Amendment No.", Rec."Amendment No.");
//                     recChangeLine.SetFilter("Line No.", '<>%1', Rec."Line No.");
//                     recChangeLine.SetRange("Document No.", Rec."Document No.");
//                     recChangeLine.SetRange("Table No.", Rec."Table No.");
//                     recChangeLine.SetRange("Field No.", Rec."Field No.");
//                     if recChangeLine.FindFirst() then
//                         Error('Amendment Line already exists. Table No. %1, Field No. %2, Line No. %3', Rec."Table No.", Rec."Field No.", recChangeLine."Line No.");
//                 end;

//             Database::"Sales Invoice Line":
//                 begin
//                     Clear(recChangeLine);
//                     recChangeLine.SetRange("Amendment No.", Rec."Amendment No.");
//                     recChangeLine.SetRange("Document No.", Rec."Document No.");
//                     recChangeLine.SetFilter("Line No.", '<>%1', Rec."Line No.");
//                     recChangeLine.SetRange("Table No.", Rec."Table No.");
//                     recChangeLine.SetRange("Document Line No.", Rec."Document Line No.");
//                     recChangeLine.SetRange("Field No.", Rec."Field No.");
//                     if recChangeLine.FindFirst() then
//                         Error('Amendment Line already exists. Table No. %1, Field No. %2, Document Line No. %3, Line No. %4', Rec."Table No.", Rec."Field No.", Rec."Document Line No.", recChangeLine."Line No.");
//                 end;
//         end;
//     end;
// }
