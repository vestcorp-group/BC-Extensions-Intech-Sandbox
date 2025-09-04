// table 53211 "Amendment Request"//T12370-Full Comment
// {
//     Caption = 'Amendment Request';
//     DataClassification = ToBeClassified;

//     fields
//     {
//         field(1; "Amendment No."; Code[20])
//         {
//             Caption = 'Amendment No.';
//             DataClassification = CustomerContent;
//             Editable = false;
//         }
//         field(2; "Document Type"; Enum "DCM_Document Type")
//         {
//             Caption = 'Document Type';
//             DataClassification = CustomerContent;
//             Editable = false;
//         }
//         field(3; "Document No."; Code[20])
//         {
//             Caption = 'Document No.';
//             DataClassification = CustomerContent;
//             Editable = false;
//         }
//         field(4; "Amendment Type"; Enum "Amendment Type")
//         {
//             Caption = 'Amendment Type';
//             DataClassification = CustomerContent;
//         }
//         field(5; "Requester"; Code[50])
//         {
//             Caption = 'Requester';
//             DataClassification = CustomerContent;
//             Editable = false;
//         }
//         field(6; "Requested DateTime"; DateTime)
//         {
//             Caption = 'Requested DateTime';
//             DataClassification = CustomerContent;
//             Editable = false;
//         }
//         field(7; "Request Status"; enum "Amendment Request Status")
//         {
//             Caption = 'Request Status';
//             DataClassification = CustomerContent;
//             Editable = false;
//         }
//         field(8; "Amendment Remarks"; BLOB)
//         {
//             Caption = 'Amendment Remarks';
//         }
//         field(9; "Approval Remarks"; BLOB)
//         {
//             Caption = 'Approval Remarks';
//         }
//         field(10; "Customer Name"; Text[100])
//         {
//             Caption = 'Customer Name';
//             Editable = false;
//         }
//         field(11; "Invoice Date"; Date)
//         {
//             Caption = 'Invoice Date';
//             Editable = false;
//         }
//         field(12; "Approved Date Time"; DateTime)
//         {
//             DataClassification = ToBeClassified;
//         }
//     }
//     keys
//     {
//         key(PK; "Amendment No.")
//         {
//             Clustered = true;
//         }
//     }

//     var
//         recGenLedSetup: Record "General Ledger Setup";
//         ReadingDataSkippedMsg: Label 'Loading field %1 will be skipped because there was an error when reading the data.\To fix the current data, contact your administrator.\Alternatively, you can overwrite the current data by entering data in the field.', Comment = '%1=field caption';


//     trigger OnInsert()
//     var
//         recNoSeriesMgt: Codeunit NoSeriesManagement;
//     begin
//         recGenLedSetup.Get();
//         recGenLedSetup.TestField("Amendment Request Nos.");

//         if Rec."Amendment No." = '' then begin
//             Rec."Amendment No." := recNoSeriesMgt.GetNextNo(recGenLedSetup."Amendment Request Nos.", Today, true);
//         end;

//         Requester := UserId;
//         "Requested DateTime" := CurrentDateTime;
//     end;

//     trigger OnDelete()
//     var
//         recReqLine: Record "Amendment Request Line";
//     begin
//         if Requester <> UserId then
//             Error('You do not have permission to delete Amendment Request.');

//         Rec.TestField("Request Status", Rec."Request Status"::Open);

//         recReqLine.SetRange("Amendment No.", Rec."Amendment No.");
//         if recReqLine.FindSet() then
//             recReqLine.DeleteAll();
//     end;

//     procedure SetAmendmentRemarks(NewWorkDescription: Text)
//     var
//         OutStream: OutStream;
//     begin
//         Clear(Rec."Amendment Remarks");
//         Rec."Amendment Remarks".CreateOutStream(OutStream, TEXTENCODING::UTF8);
//         OutStream.WriteText(NewWorkDescription);
//         Rec.Modify;
//     end;

//     procedure GetAmendmentRemarks() WorkDescription: Text
//     var
//         TypeHelper: Codeunit "Type Helper";
//         InStream: InStream;
//     begin
//         Rec.CalcFields(Rec."Amendment Remarks");
//         Rec."Amendment Remarks".CreateInStream(InStream, TEXTENCODING::UTF8);
//         if not TypeHelper.TryReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator(), WorkDescription) then
//             Message(ReadingDataSkippedMsg, Rec.FieldCaption("Amendment Remarks"));
//     end;

//     procedure SetApprovalRemarks(NewWorkDescription: Text)
//     var
//         OutStream: OutStream;
//     begin
//         Clear(Rec."Approval Remarks");
//         Rec."Approval Remarks".CreateOutStream(OutStream, TEXTENCODING::UTF8);
//         OutStream.WriteText(NewWorkDescription);
//         Rec.Modify;
//     end;

//     procedure GetApprovalRemarks() WorkDescription: Text
//     var
//         TypeHelper: Codeunit "Type Helper";
//         InStream: InStream;
//     begin
//         Rec.CalcFields(Rec."Approval Remarks");
//         Rec."Approval Remarks".CreateInStream(InStream, TEXTENCODING::UTF8);
//         if not TypeHelper.TryReadAsTextWithSeparator(InStream, TypeHelper.LFSeparator(), WorkDescription) then
//             Message(ReadingDataSkippedMsg, Rec.FieldCaption("Approval Remarks"));
//     end;

// }
