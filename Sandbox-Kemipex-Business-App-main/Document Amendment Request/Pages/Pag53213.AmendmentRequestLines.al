// page 53213 "Amendment Request Line"//T12370-Full Comment
// {
//     Caption = 'Amendment Request Line';
//     PageType = ListPart;
//     SourceTable = "Amendment Request Line";

//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 field("Line No."; Rec."Line No.")
//                 {
//                     ApplicationArea = All;
//                     Visible = false;
//                     ToolTip = 'Specifies the value of the Line No. field.';
//                 }
//                 field("Table No."; Rec."Table No.")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Table No. field.';
//                     Visible = false;
//                 }
//                 field("Change Type"; Rec."Change Type")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Table Name field.';
//                     Caption = 'Change Type';
//                     trigger OnLookup(var Text: Text): Boolean
//                     var
//                         pgSetup: Page "Amendment Request Setup";
//                         recSetup: record "Amendment Request Setup";
//                         recChangeLine: Record "Amendment Request Line";
//                         AmendmentReq: Record "Amendment Request";
//                     begin
//                         if (Rec."Document Type" = Rec."Document Type"::" ") then begin
//                             Rec."Document Type" := Rec."Document Type"::"Posted Sales Invoice";
//                         end;

//                         recSetup.Reset();
//                         recSetup.SetCurrentKey("Amendment Type");
//                         recSetup.SetAscending("Amendment Type", true);
//                         recSetup.SetRange("DCM_Document Type", Rec."Document Type");
//                         if recSetup.FindSet() then begin
//                             Clear(pgSetup);
//                             pgSetup.SetVisibility(true);
//                             pgSetup.SetTableView(recSetup);
//                             pgSetup.LookupMode(true);
//                             if pgSetup.RunModal() = Action::LookupOK then begin
//                                 pgSetup.GetRecord(recSetup);
//                                 Rec."Table No." := recSetup."DCM_Table No.";
//                                 Rec."Change Type" := recSetup."DCM_Table Name";
//                                 Rec."Field No." := recSetup."DCM_Field No.";
//                                 Rec."Field Name" := recSetup."DCM_Field Name";
//                                 Rec."Amendment Type" := recSetup."Amendment Type";
//                                 if Rec."Amendment Type" = Rec."Amendment Type"::"Sales Return" then begin
//                                     Clear(AmendmentReq);
//                                     AmendmentReq.SetRange("Amendment No.", Rec."Amendment No.");
//                                     if AmendmentReq.FindFirst() then begin
//                                         AmendmentReq."Amendment Type" := Rec."Amendment Type"::"Sales Return";
//                                         AmendmentReq.Modify();
//                                     end;
//                                 end else
//                                     if Rec."Amendment Type" = Rec."Amendment Type"::"Invoice Modification" then begin
//                                         Clear(recChangeLine);
//                                         recChangeLine.SetRange("Amendment No.", Rec."Amendment No.");
//                                         recChangeLine.SetRange("Amendment Type", recChangeLine."Amendment Type"::"Sales Return");
//                                         if not recChangeLine.FindFirst() then begin
//                                             Clear(AmendmentReq);
//                                             AmendmentReq.SetRange("Amendment No.", Rec."Amendment No.");
//                                             if AmendmentReq.FindFirst() then begin
//                                                 AmendmentReq."Amendment Type" := AmendmentReq."Amendment Type"::"Invoice Modification";
//                                                 AmendmentReq.Modify();
//                                             end;
//                                         end;
//                                     end else begin
//                                         Clear(recChangeLine);
//                                         recChangeLine.SetRange("Amendment No.", Rec."Amendment No.");
//                                         recChangeLine.SetFilter("Amendment Type", '%1|%2', recChangeLine."Amendment Type"::"Sales Return", recChangeLine."Amendment Type"::"Invoice Modification");
//                                         if not recChangeLine.FindFirst() then begin
//                                             Clear(AmendmentReq);
//                                             AmendmentReq.SetRange("Amendment No.", Rec."Amendment No.");
//                                             if AmendmentReq.FindFirst() then begin
//                                                 AmendmentReq."Amendment Type" := AmendmentReq."Amendment Type"::"Manual Amendment";
//                                                 AmendmentReq.Modify();
//                                             end;
//                                         end;
//                                     end;
//                             end;
//                         end;
//                     end;
//                 }
//                 field("Document No."; Rec."Document No.")
//                 {
//                     ApplicationArea = All;
//                     Visible = false;
//                 }
//                 field("Field No."; Rec."Field No.")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Field No. field.';
//                     Visible = false;
//                 }
//                 field("Document Line No."; Rec."Document Line No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Field Name"; Rec."Field Name")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Field Name field.';
//                 }
//                 field("Current Value"; Rec."Current Value")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the Current Value field.';
//                 }
//                 field("New Value"; Rec."New Value")
//                 {
//                     ApplicationArea = All;
//                     ToolTip = 'Specifies the value of the New Value field.';
//                 }
//                 field("Amendment Type"; Rec."Amendment Type")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//             }
//         }
//     }
// }
