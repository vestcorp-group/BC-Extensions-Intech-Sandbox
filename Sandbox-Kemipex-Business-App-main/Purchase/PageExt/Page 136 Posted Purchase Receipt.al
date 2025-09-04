pageextension 58027 PostPurchRec50228 extends "Posted Purchase Receipt"//T12370-Full Comment
{
    layout
    {
        addlast(Shipping)
        {
            field("Area"; rec."Area")
            {
                ApplicationArea = All;
                Caption = 'Port of Discharge';
                Editable = false;
            }
            field("Entry Point"; rec."Entry Point")
            {
                ApplicationArea = all;
                Caption = 'Port of Loading';
                Editable = false;
            }
            // field("Transaction Specification"; rec."Transaction Specification")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Incoterm';
            //     Editable = false;
            // }
        }
        // addafter(CustomBOENumber)
        // {

        //     field("Transaction Type"; rec."Transaction Type")
        //     {
        //         ApplicationArea = all;
        //         Caption = 'Order Type';
        //     }
        // }
    }
    actions
    {
        //T13574-NS

        addafter("&Print")
        {
            action("Posted Purchase Receipt")
            {
                ApplicationArea = all;
                Image = Receipt;
                Promoted = true;
                PromotedCategory = Category5;
                trigger OnAction()
                var
                    PostedPurchHdr_lRec: Record "Purch. Rcpt. Header";
                    PostedPurchReceipt_lRpt: Report "Posted Purchase - Receipt";
                begin
                    PostedPurchHdr_lRec.Reset();
                    PostedPurchHdr_lRec.SetRange("No.", Rec."No.");
                    PostedPurchReceipt_lRpt.SetTableView(PostedPurchHdr_lRec);
                    PostedPurchReceipt_lRpt.RunModal();

                end;
            }
        }
        //T13574-NE
    }

    // trigger OnDeleteRecord(): Boolean
    // begin
    //     Error('Not allowed to delete the record!');
    // end;
}
