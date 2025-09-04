// tableextension 50116 SalesHdrExt extends "Sales Header"
// {
//     fields
//     {
//         field(50150; "Required Approval for Line"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//             Description = 'T50268';
//             Editable = false;
//         }
//         field(50151; "Required Approval Payment"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//             Description = 'T50268';
//             Editable = false;
//         }
//         field(50152; "Required Appv. ShiptoAddress"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//             Description = 'T50268';
//             Editable = false;
//         }
//         //T50219-NS-NB
//         modify("Payment Terms Code")
//         {
//             trigger OnAfterValidate()
//             var
//                 Customer_lRec: Record Customer;
//             begin
//                 if rec.Status <> rec.Status::Open then
//                     Error('Status need to be open.');
//                 if rec."Sell-to Customer No." <> '' then
//                     if Customer_lRec.Get("Sell-to Customer No.") then
//                         if not (Customer_lRec."Payment Terms Code" = rec."Payment Terms Code") then begin
//                             rec."Required Approval Payment" := true;
//                             if rec.Modify() then;
//                         end else begin
//                             rec."Required Approval Payment" := false;
//                             if rec.Modify() then;
//                         end;
//             end;
//         }
//         //T50219-NE-NB
//     }

//     keys
//     {
//         // Add changes to keys here
//     }

//     var
//         myInt: Integer;
// }