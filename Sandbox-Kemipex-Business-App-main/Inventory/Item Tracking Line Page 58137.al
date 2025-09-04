// pageextension 58137 ItemTrackingLinePage extends "Item Tracking Lines"//T12370-Full Comment
// {
//     layout
//     {

//         modify("Lot No.")
//         {
//             trigger OnAfterValidate()
//             var
//                 myInt: Integer;
//             begin
//                 rec.Validate("Lot No.");
//             end;
//         }
//         modify("Expiration Date")
//         {
//             Visible = true;
//             Enabled = Sales_yes;
//         }
//         modify("Supplier Batch No. 2")
//         {
//             Enabled = Sales_yes;
//         }
//         modify("Manufacturing Date 2")
//         {
//             Editable = Sales_yes;
//         }
//         modify("Expiry Period 2")
//         {
//             Editable = Sales_yes;
//         }
//         modify("Serial No.")
//         {
//             Visible = false;
//         }
//         moveafter("Expiry Period 2"; "Expiration Date")
//         /* addafter("Expiration Date") // start Added or tem purpose
//         {
//             field("New Expiration Date84701"; Rec."New Expiration Date")
//             {
//                 ApplicationArea = All;
//             }
//         }
//         addafter(CustomLotNumber)
//         {
//             field("New Lot No.79166"; Rec."New Lot No.")
//             {
//                 ApplicationArea = All;
//             }
//         }
//         moveafter(CustomLotNumber; "New Custom Lot No.")
//         modify("New BOE No.")
//         {
//             Width = 18;
//         }
//         addafter("Manufacturing Date 2")
//         {
//             field("Manufacturing Date 207246"; Rec."Manufacturing Date 2")
//             {
//                 ApplicationArea = All;
//             }
//         }
//         addafter("Supplier Batch No. 2")
//         {
//             field("Supplier Batch No. 291452"; Rec."Supplier Batch No. 2")
//             {
//                 ApplicationArea = All;
//             }
//             field("New Custom BOE No."; Rec."New Custom BOE No.")
//             {
//                 ApplicationArea = All;
//             }
//         } */ // end Added for temp purpose
//     }
//     actions
//     {
//         // Add changes to page actions here
//     }

//     trigger OnAfterGetCurrRecord()
//     var
//         myInt: Integer;
//     begin
//         if rec."Source Type" = 37 then Sales_yes := false else Sales_yes := true;
//     end;

//     var
//         Sales_yes: Boolean;

// }