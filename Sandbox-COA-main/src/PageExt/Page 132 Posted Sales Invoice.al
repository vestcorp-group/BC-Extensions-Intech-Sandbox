pageextension 50500 PosSalInvExt extends "Posted Sales Invoice"
{
    actions
    {
        // Add changes to page actions here
        addafter(Print)
        {
            //T13827-NS
            action("Print COA")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = Print;
                PromotedCategory = Category6;
                trigger OnAction()
                var
                    SalesInvoiceHeader_lRec: Record "Sales Invoice Header";
                    COAforPostedSalesInvoice_lRpt: Report "COA for Posted Sales Invoice";
                begin
                    Clear(COAforPostedSalesInvoice_lRpt);
                    SalesInvoiceHeader_lRec.Reset();
                    SalesInvoiceHeader_lRec.SetRange("No.", Rec."No.");
                    COAforPostedSalesInvoice_lRpt.SetTableView(SalesInvoiceHeader_lRec);
                    COAforPostedSalesInvoice_lRpt.RunModal();
                end;
            }
        }
        //T13827-NE
    }
}