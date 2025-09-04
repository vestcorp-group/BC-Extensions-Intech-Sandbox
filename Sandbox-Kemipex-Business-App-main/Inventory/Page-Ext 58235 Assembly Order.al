// pageextension 58235 Assemblyorder extends "Assembly Order"//T12370-Full Comment
// {
//     layout
//     {
//     }
//     actions
//     {
//         modify("P&ost") // added by Bayas
//         {
//             trigger OnBeforeAction()
//             var
//                 AssemblyHeader: Record "Assembly Header";
//                 AssemblyLine: Record "Assembly Line";
//                 ItemRec: Record Item;
//                 ItemRec1: Record Item;
//                 Warning_label: Label 'Warning! \ Assembly order %1 Input %2 and Output %3 Item has different HS Code / Country of Origin.';
//             begin
//                 AssemblyLine.SetRange("Document No.", Rec."No.");
//                 AssemblyLine.SetRange("Document Type", Rec."Document Type");
//                 AssemblyLine.SetRange(Type, AssemblyLine.Type::Item);
//                 if AssemblyLine.Count() = 1 then begin
//                     AssemblyLine.FindFirst();
//                     ItemRec.get(rec."Item No.");
//                     ItemRec1.get(AssemblyLine."No.");
//                     if (ItemRec."Tariff No." <> ItemRec1."Tariff No.") OR (ItemRec."Country/Region of Origin Code" <> ItemRec1."Country/Region of Origin Code") then
//                         Message(Warning_label, Rec."No.", AssemblyLine."No.", rec."Item No.");
//                 end;
//             end;
//         }
//     }
// }
