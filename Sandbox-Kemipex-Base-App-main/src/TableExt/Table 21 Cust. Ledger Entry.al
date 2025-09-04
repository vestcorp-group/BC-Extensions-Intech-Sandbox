// tableextension 50447 CLEExt extends "Cust. Ledger Entry"//T12370-Full Comment
// {
//     fields
//     {
//         // Add changes to table fields here
//         field(50200; "Customer Group Code"; Code[20])
//         {
//             FieldClass = FlowField;
//             CalcFormula = lookup(Customer."Customer Group Code" where("No." = field("Customer No.")));
//         }
//         field(50201; "Customer Group Code 2"; Code[200])
//         {
//             FieldClass = FlowField;
//             CalcFormula = lookup(Customer."Customer Group Code 2" where("No." = field("Customer No.")));
//         }
//     }

//     var
//         myInt: Integer;
// }