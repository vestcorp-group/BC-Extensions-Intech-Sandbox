// tableextension 58242 Transferlineext extends "Transfer Line"//T12370-Full Comment
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
//                 if InventorySetup."Transfer Gen. Prod. Group" <> '' then begin
//                     Validate("Gen. Prod. Posting Group", InventorySetup."Transfer Gen. Prod. Group");
//                 end
//             end;
//         }
//     }
// }