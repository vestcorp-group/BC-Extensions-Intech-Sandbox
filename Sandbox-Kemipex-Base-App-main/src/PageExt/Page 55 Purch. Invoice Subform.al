// /// <summary>//T12370-Full Comment
// /// PageExtension Purchase Invoice Ext (ID 60110) extends Record Purch. Invoice Subform;.
// /// </summary>
// pageextension 54010 "Purchase Invoice Ext2" extends "Purch. Invoice Subform"
// {
//     layout
//     {
//         // Add changes to page layout here


//     }

//     actions
//     {
//         // Add changes to page actions here
//     }
//     trigger OnDeleteRecord(): Boolean
//     begin
//         if PurchaseHeader.get(Rec."Document Type"::Invoice, Rec."Document No.") then;
//         StagingPurchInv.Reset();
//         StagingPurchInv.SetRange("Vendor Refrence", PurchaseHeader."Vendor Invoice No.");
//         StagingPurchInv.SetRange("Vendor No.", Rec."Buy-from Vendor No.");
//         StagingPurchInv.SetRange("Item No.", Rec."No.");
//         StagingPurchInv.SetRange(Status, StagingPurchInv.Status::Created);
//         StagingPurchInv.ModifyAll(Status, StagingPurchInv.Status::Deleted);

//     end;

//     var
//         StagingPurchInv: Record "Staging Purchase Invoice";
//         PurchaseHeader: Record "Purchase Header";



// }