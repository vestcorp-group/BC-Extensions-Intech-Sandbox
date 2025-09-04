// page 53013 "Update Sales Shipment Line"//T12370-Full Comment
// {
//     Caption = 'Sales Shipment Line';
//     PageType = Card;
//     SourceTable = "Sales Shipment Line";
//     Permissions = tabledata "Sales Shipment Line" = RM;
//     DeleteAllowed = false;
//     InsertAllowed = false;
//     ModifyAllowed = true;
//     layout
//     {
//         area(content)
//         {
//             group(General)
//             {
//                 field("Gross Weight"; Rec."Gross Weight")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(LineHSNCode; Rec.LineHSNCode)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Line HS Code';
//                 }
//                 field(LineCountryOfOrigin; Rec.LineCountryOfOrigin)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Line Country of Origin';
//                 }
//                 field(GenericName; GenericName)
//                 {
//                     Caption = 'Generic Name';
//                     ApplicationArea = All;
//                     TableRelation = KMP_TblGenericName;

//                     trigger OnValidate()
//                     var
//                         KMP_TblGenericName: Record KMP_TblGenericName;
//                     begin
//                         if GenericName <> '' then begin
//                             KMP_TblGenericName.GET(GenericName);
//                             Rec."Line Generic Name" := KMP_TblGenericName.Description;
//                         end else
//                             Rec."Line Generic Name" := '';
//                     end;
//                 }
//                 field("Line Generic Name"; Rec."Line Generic Name")
//                 {
//                     ApplicationArea = All;
//                     Enabled = false;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     var
//         KMP_TblGenericNameL: Record KMP_TblGenericName;
//     begin
//         if Rec."Line Generic Name" <> '' then begin
//             KMP_TblGenericNameL.SetRange(Description, Rec."Line Generic Name");
//             if KMP_TblGenericNameL.FindFirst() then
//                 GenericName := KMP_TblGenericNameL.Code;
//         end;
//     end;

//     var
//         GenericName: Text;
// }
