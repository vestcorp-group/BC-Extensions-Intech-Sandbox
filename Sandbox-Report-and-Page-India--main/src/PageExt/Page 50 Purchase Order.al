pageextension 64110 PurchaseOrder extends "Purchase Order"//T12370-Full Comment
{
    layout
    {
        // Add changes to page layout here

    }

    actions
    {
        // Add changes to page actions here
        // addafter(Print)
        // {
        //     action("Print Preview CPI")
        //     {
        //         ApplicationArea = All;
        //         Image = PrintChecklistReport;
        //         Promoted = true;
        //         PromotedCategory = Category10;
        //         trigger OnAction()
        //         var
        //             Purc_header: Record "Purchase Header";
        //         begin
        //             Purc_header.Reset();
        //             Purc_header.SetRange("No.", Rec."No.");

        //             if Purc_header.FindSet() then
        //                 report.RunModal(58107, true, true, Purc_header);
        //         end;
        //     }
        // }
        modify("Print Preview")
        {
            Visible = false;
        }
        //T53930-NS
        // modify(Email)
        // {
        //     Visible = false;
        // }
        modify(AttachAsPDF)
        {
            Visible = false;
        }
        modify("&Print")
        {
            Visible = false;
        }
        modify(SendCustom)
        {
            Visible = false;
        }
        //T53930-NE
    }

    var
        myInt: Integer;
}