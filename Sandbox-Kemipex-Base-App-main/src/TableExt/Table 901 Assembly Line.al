// tableextension 50155 KMP_AssemblyLine extends "Assembly Line"//T12370-Full Comment
// {
//     fields
//     {
//         modify("Quantity to Consume")
//         {
//             trigger OnBeforeValidate()
//             var
//                 myInt: Integer;
//             begin
//                 //PSP 06-05-20
//                 WhseValidateSourceLine.AssemblyLineVerifyChange(Rec, xRec);
//                 RoundQty("Quantity to Consume");
//                 RoundQty("Remaining Quantity");
//                 if "Quantity to Consume" > Quantity then
//                     Error(Text003,
//                       FieldCaption("Quantity to Consume"), FieldCaption(Quantity), Quantity);
//                 //PSP 06-05-20
//             end;
//         }

//         field(50100; "Blanket Assembly Order No."; Code[20])
//         {
//             DataClassification = CustomerContent;
//             Caption = 'Blanket Assembly Order No.';
//         }
//         field(50101; "Blanket Ass. Order Line No."; Integer)
//         {
//             DataClassification = CustomerContent;
//             Caption = 'Blanket Assembly Order Line No.';
//         }

//     }

//     var
//         Text003: Label '%1 cannot be higher than the %2, which is %3.';
//         WhseValidateSourceLine: Codeunit "Whse. Validate Source Line";


//     local procedure RoundQty(var Qty: Decimal)
//     var
//         UOMMgt: Codeunit "Unit of Measure Management";
//     begin
//         Qty := UOMMgt.RoundQty(Qty);
//     end;

// }