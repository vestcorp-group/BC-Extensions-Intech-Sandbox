// pageextension 58136 ItemTracking_selectentries extends "Item Tracking Summary"//T12370-Full Comment
// {
//     layout
//     {
//         modify("Expiration Date")
//         {
//             Editable = false;
//             Visible = true;
//             ApplicationArea = all;
//         }
//         modify("Manufacturing Date 2")
//         {
//             Editable = false;
//         }
//         modify("Expiry Period 2")
//         {
//             Editable = false;
//         }
//         modify("Supplier Batch No. 2")
//         {
//             Editable = false;
//         }
//         modify("Gross Weight 2")
//         {
//             Visible = false;
//             Editable = false;
//         }
//         modify("Net Weight 2")
//         {
//             Visible = false;
//             Editable = false;
//         }
//         moveafter("Expiry Period 2"; "Expiration Date")

//     }
//     var
//         myInt: Integer;
// }