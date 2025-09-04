// codeunit 53213 DCM_EventSubscribeMgt//T12370-Full Comment
// {
//     [EventSubscriber(ObjectType::Table, Database::"Amendment Request Line", 'OnAfterInsertEvent', '', false, false)]
//     local procedure OnAfterValidateFieldNo_RequestLine(var Rec: Record "Amendment Request Line")
//     var
//         cuChangeReqMgt: Codeunit "Amendment Management";
//         xRecRef: RecordRef;
//         recSalHead: Record "Sales Invoice Header";
//     begin
//         case Rec."Document Type" of
//             Rec."Document Type"::"Posted Sales Invoice":
//                 begin
//                     recSalHead.Get(Rec."Document No.");
//                     xRecRef.GetTable(recSalHead);

//                     Rec."Current Value" := cuChangeReqMgt.GetFieldCurrentValue(xRecRef, Rec."Field No.");
//                     Rec.Modify(true);
//                 end;
//         end;
//         Rec.ValidateDuplicateRecords();
//     end;

//     [EventSubscriber(ObjectType::Table, Database::"Amendment Request Line", 'OnAfterValidateEvent', 'Document Line No.', false, false)]
//     local procedure OnAfterValidateDocLineNo_RequestLine(var Rec: Record "Amendment Request Line")
//     var
//         cuChangeReqMgt: Codeunit "Amendment Management";
//         xRecRef: RecordRef;
//         recSalLine: Record "Sales Invoice Line";
//     begin
//         case Rec."Document Type" of
//             Rec."Document Type"::"Posted Sales Invoice":
//                 begin
//                     recSalLine.Get(Rec."Document No.", Rec."Document Line No.");
//                     xRecRef.GetTable(recSalLine);
//                     Rec."Current Value" := cuChangeReqMgt.GetFieldCurrentValue(xRecRef, Rec."Field No.");
//                 end;
//         end;
//         Rec.ValidateDuplicateRecords();
//     end;


//     [EventSubscriber(ObjectType::Table, Database::"Amendment Request Line", 'OnAfterValidateEvent', 'New Value', false, false)]
//     local procedure OnAfterValidateNewValueLine_RequestLine(var Rec: Record "Amendment Request Line")
//     var
//         cuChangeReqMgt: Codeunit "Amendment Management";
//         xRecRef: RecordRef;
//         recSalLine: Record "Sales Invoice Line";
//         recSalHead: Record "Sales Invoice Header";
//         xFieldRef: FieldRef;
//         DT: Date;
//     begin
//         case Rec."Document Type" of
//             Rec."Document Type"::"Posted Sales Invoice":
//                 begin
//                     case Rec."Table No." of
//                         Database::"Sales Invoice Header":
//                             begin
//                                 recSalHead.Get(Rec."Document No.");
//                                 xRecRef.GetTable(recSalHead);
//                                 xFieldRef := xRecRef.Field(Rec."Field No.");
//                                 if xFieldRef.Type = xFieldRef.Type::Date then begin
//                                     Evaluate(DT, Rec."New Value");
//                                     xFieldRef.Validate(DT);
//                                 end else
//                                     xFieldRef.Validate(Rec."New Value");
//                             end;
//                         Database::"Sales Invoice Line":
//                             begin
//                                 recSalLine.Get(Rec."Document No.", Rec."Document Line No.");
//                                 xRecRef.GetTable(recSalLine);
//                                 xFieldRef := xRecRef.Field(Rec."Field No.");
//                                 if xFieldRef.Type = xFieldRef.Type::Date then begin
//                                     Evaluate(DT, Rec."New Value");
//                                     xFieldRef.Validate(DT);
//                                 end else
//                                     xFieldRef.Validate(Rec."New Value");
//                             end;
//                     end;
//                 end;
//         end;

//     end;

// }
