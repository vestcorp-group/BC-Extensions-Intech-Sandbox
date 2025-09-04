pageextension 50335 KMP_PageExtSalesInvoice extends "Sales Invoice"//T12370-Full Comment //T-12855
{
    layout
    {
        addafter("Responsibility Center")
        {
            //PackingListExtChange
            field("Bank on Invoice"; rec."Bank on Invoice 2")
            {
                ApplicationArea = all; //T-12855
            }
            //             //PackingListExtChange
            //             field("Legalization Required"; rec."Legalization Required 2")
            //             {
            //                 ApplicationArea = all;
            //             }
            //             // field("Seller/Buyer 2"; rec."Seller/Buyer 2")
            //             // {
            //             //     ApplicationArea = all;
            //             //     Caption = 'Seller/Buyer ';
            //             //     Editable = false;
            //             // }

            field("Bank on Invoice 2"; rec."Bank on Invoice 2")
            {
                Caption = 'Bank on Invoice';
                ApplicationArea = All;
            }
            //             field("Inspection Required 2"; rec."Inspection Required 2")
            //             {
            //                 ApplicationArea = All;
            //                 Caption = 'Inspection Required';
            //                 // Visible = false;
            //             }
            //             field("Legalization Required 2"; rec."Legalization Required 2")
            //             {
            //                 ApplicationArea = All;
            //                 Caption = 'Legalization Required';
            //                 // Visible = false;
            //             }
            //             field("Seller/Buyer 2"; rec."Seller/Buyer 2")
            //             {
            //                 ApplicationArea = all;

            //                 Caption = 'Seller/Buyer';
            //             }
            field("LC No. 2"; rec."LC No. 2")
            {
                ApplicationArea = All;
                Caption = 'LC No.';
            }
            field("LC Date 2"; rec."LC Date 2")
            {
                ApplicationArea = all;
                Caption = 'LC Date';
            }
            //         }
            //         addafter("External Document No.")
            //         {
            //             field(BillOfExit; rec.BillOfExit)
            //             {
            //                 Caption = 'Bill Of Exit';
            //                 ApplicationArea = All;
            //             }
        }
    }
    //     actions
    //     {
    //         // Add changes to page actions here
    //         addfirst(processing)
    //         {
    //             action("Print Pre Sales Inv.")
    //             {
    //                 Image = PrintVoucher;
    //                 Promoted = true;
    //                 PromotedCategory = Process;
    //                 PromotedIsBig = true;
    //                 ApplicationArea = all;
    //                 //RunObject = report 50102;
    //                 //RunPageOnRec = true;
    //                 trigger OnAction()
    //                 var
    //                     SalesInvRec: Record "Sales Header";
    //                 begin
    //                     SalesInvRec.Reset();
    //                     CurrPage.SetSelectionFilter(SalesInvRec);
    //                     //SalesInvRec.SetRange("No.", Rec."No.");
    //                     if SalesInvRec.FindFirst then
    //                         //Message('Total Rec :%1', SalesInvRec.Count());                        
    //                          Report.RunModal(Report::KMP_PreSalesInvoiceReport, true, true, SalesInvRec);
    //                 end;
    //             }
    //         }
    //         addafter("Print Pre Sales Inv.")
    //         {
    //             // action("Delivery Advice")
    //             // {
    //             //     Image = Delivery;
    //             //     Promoted = true;
    //             //     PromotedCategory = Process;
    //             //     PromotedIsBig = true;
    //             //     ApplicationArea = all;
    //             //     trigger OnAction()
    //             //     var
    //             //         SalesInvRec: Record "Sales Header";
    //             //     begin
    //             //         SalesInvRec.Reset();
    //             //         CurrPage.SetSelectionFilter(SalesInvRec);
    //             //         if SalesInvRec.FindFirst then
    //             //             Report.RunModal(Report::"Delivery Advice Report", true, true, SalesInvRec);
    //             //     end;
    //             // }
    //         }
    //         addafter("Co&mments")
    //         {
    //             action(Remarks)
    //             {
    //                 Image = Comment;
    //                 Promoted = true;
    //                 ApplicationArea = All;
    //                 PromotedCategory = Category7;
    //                 PromotedIsBig = true;
    //                 trigger OnAction()
    //                 var
    //                     SalesRemarkL: Record "Sales Remark";
    //                 begin
    //                     SalesRemarkL.ShowRemarks(SalesRemarkL."Document Type"::Invoice, rec."No.", 0);
    //                 end;
    //             }
    //         }
}
// }