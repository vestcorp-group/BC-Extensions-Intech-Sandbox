// tableextension 58243 AssemblyHeaderext extends "Assembly Header"//T12370-Full Comment
// {
//     fields
//     {
//         modify("Item No.")
//         {
//             trigger OnAfterValidate() // added by baya
//             var
//                 InventorySetup: Record "Inventory Setup";
//             begin
//                 InventorySetup.Get();
//                 if InventorySetup."Assembly Gen. Prod. Group" <> '' then begin
//                     Validate("Gen. Prod. Posting Group", InventorySetup."Assembly Gen. Prod. Group");
//                 end
//             end;
//         }
//     }
// }