// tableextension 58000 VLE extends "Value Entry"//T12370-Full Comment
// {
//     fields
//     {
//         field(53400; "ILE Posting Date"; Date)
//         {
//             FieldClass = FlowField;
//             CalcFormula = lookup("Item Ledger Entry"."Posting Date" where("Entry No." = field("Item Ledger Entry No.")));
//         }
//     }
// }
