pageextension 50105 KMP_PageExtPurchaseOrder extends "Purchase Order"//T12370-Full Comment
{
    layout
    {
        //         // Add changes to page layout here
        //         modify("Document Date")
        //         {
        //             Caption = 'Supplier Invoice Date';
        //         }

        addafter(Status)
        {
            field("Purchase Type"; rec."Purchase Type")
            {
                ApplicationArea = all;
            }
            field(CustomBOENumber; rec.CustomBOENumber)
            {
                ApplicationArea = All;
                Caption = 'Custom BOE No.';
                Editable = rec."Purchase Type" = rec."Purchase Type"::BOE;
            }
            //T13919-NS
            field("IC Transaction No."; Rec."IC Transaction No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the IC Transaction No. field.', Comment = '%';
                Editable = false;
            }
            //T13919-NE
        }
        //T52085-NS
        addfirst(factboxes)
        {
            part("Inventory Details"; "Item Company Wise Inventory")
            {
                ApplicationArea = all;
                Provider = PurchLines;
                SubPageLink = "Item No." = field("No.");
            }
        }
        //T52085-NE

    }

    //     actions
    //     {
    //         addafter("Create &Whse. Receipt")
    //         {
    //             action("Short Close")
    //             {
    //                 ApplicationArea = Suite;
    //                 Image = CloseDocument;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedIsBig = true;
    //                 Enabled = AllowShortCloseG;
    //                 Caption = 'Short Close Order';
    //                 ToolTip = 'Send the order to archive even if the order has not been fully received.';
    //                 trigger OnAction()
    //                 var
    //                     PurchaseLineL: Record "Purchase Line";
    //                     ShortCloseOrdQst: Label 'The Order %1 will be deleted and move to archive.\Do you want to continue?';
    //                 begin
    //                     rec.TestField(Status, rec.Status::Released);
    //                     If not Confirm(StrSubstNo(ShortCloseOrdQst, rec."No.")) then
    //                         exit;
    //                     rec."Short Close" := true;
    //                     rec.Modify();
    //                     PurchaseLineL.SetRange("Document Type", rec."Document Type");
    //                     PurchaseLineL.SetRange("Document No.", rec."No.");
    //                     // PurchaseLineL.ModifyAll("Qty. Rcd. Not Invoiced", 0);
    //                     rec.Delete(true);
    //                 end;
    //             }
    //         }
    //         addafter("Co&mments")
    //         {
    //             action(Remarks)
    //             {
    //                 Image = Comment;
    //                 Promoted = true;
    //                 ApplicationArea = All;
    //                 PromotedCategory = Category8;
    //                 PromotedIsBig = true;
    //                 trigger OnAction()
    //                 var
    //                     PurchaseRemarkL: Record "Purchase Remarks";
    //                 begin
    //                     PurchaseRemarkL.ShowRemarks(PurchaseRemarkL."Document Type"::Order, rec."No.", 0);
    //                 end;
    //             }
    //         }
    // }
    //     trigger OnOpenPage()
    //     var
    //         UserSetup: Record "User Setup";
    //     begin
    //         if UserSetup.Get(UserId) then
    //             AllowShortCloseG := UserSetup."Allow Short Close";
    //     end;

    //     var
    //         [InDataSet]
    //         AllowShortCloseG: Boolean;
}