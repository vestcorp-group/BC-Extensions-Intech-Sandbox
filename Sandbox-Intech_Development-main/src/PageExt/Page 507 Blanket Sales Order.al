// pageextension 50133 BSOExtended extends "Blanket Sales Order"
// {
//     layout
//     {
//         addlast(General)
//         {

//             field("Required Approval"; Rec."Required approval for Line")
//             {
//                 ApplicationArea = All;
//                 Description = 'T50268';
//                 Caption = 'Required Approval for Line';
//                 ToolTip = 'Specifies the value of the Required Approval field.', Comment = '%';
//             }
//             field("Required Approval Payment"; Rec."Required Approval Payment")
//             {
//                 ApplicationArea = all;
//                 Description = 'T50268';
//                 Caption = 'Required Approval for Payment Terms';
//                 ToolTip = 'Specifies the value of the Required Approval field.', Comment = '%';
//             }
//             field("Ship to Required Approval"; Rec."Required Appv. ShiptoAddress")
//             {
//                 ApplicationArea = all;
//                 Description = 'T50268';
//                 Caption = 'Required Approval for Ship to Address';
//                 ToolTip = 'Specifies the value of the Required Approval field.', Comment = '%';
//             }
//         }
//         modify(ShippingOptions)
//         {
//             trigger OnAfterValidate()
//             var
//                 myInt: Integer;
//             begin
//                 if rec.Status <> rec.Status::Open then
//                     Error('Status need to be open.');
//                 if not (ShipToOptions = ShipToOptions::"Default (Sell-to Address)") then begin
//                     rec."Required Appv. ShiptoAddress" := true;
//                     rec.Modify();
//                 end else begin
//                     rec."Required Appv. ShiptoAddress" := false;
//                     rec.Modify();
//                 end;
//             end;
//         }
//     }

// }