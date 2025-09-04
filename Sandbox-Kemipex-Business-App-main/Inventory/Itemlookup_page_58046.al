// pageextension 58046 itemLookup extends "Item Lookup"//T12370-Full Comment 
// {
//     layout
//     {
//         /* modify("Base Unit of Measure")
//         {
//             Visible = false;
//         }
//         modify("Vendor Item No.")
//         {
//             Visible = false;
//         }
//         modify("Vendor No.")
//         {
//             Visible = false;
//             Enabled = false;
//         }
//         modify("Unit Price")
//         {
//             Visible = false;
//         }
//         modify(Description)
//         {
//             ApplicationArea = all;
//         }
//         modify("Search Description")
//         {
//             Caption = 'Item Short Name';
//             Importance = Promoted;
//             Visible = true;
//             ApplicationArea = all;
//         }
//         modify("Unit Cost")
//         {
//             Visible = false;
//         }
//         addafter("Search Description")
//         {
//             field("Country/Region of Origin Code"; rec."Country/Region of Origin Code")
//             {
//                 ApplicationArea = all;
//             }
//         }
//         moveafter("Search Description"; Description) */

//     }

//     internal procedure GetSelectionFilter(): Text
//     var
//         Item: Record Item;
//         SelectionFilterManagement: Codeunit SelectionFilterManagement;
//     begin
//         CurrPage.SetSelectionFilter(Item);
//         exit(SelectionFilterManagement.GetSelectionFilterForItem(Item));
//     end;
// }