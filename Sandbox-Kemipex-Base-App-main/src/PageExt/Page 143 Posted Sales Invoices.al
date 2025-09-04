pageextension 51205 KMP_PageListExtPostedSalesInv extends "Posted Sales Invoices"//T12370-Full Comment
{
    layout
    {
        // Add changes to page layout here
        addafter(Amount)
        {

            field(VatAmountG; abs(VatAmountG))
            {
                ApplicationArea = All;
                Caption = 'Vat Amount';
            }
        }
        addafter(Corrective)
        {
            field("User ID"; Rec."User ID")
            {
                ApplicationArea = All;
            }
        }
    }



    var
        myInt: Integer;
        VatAmountG: Decimal;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        //SalesOrderListL: page "Sales Order Statistics";
        SalesHdrL: Record "Sales Invoice Header";
    begin
        //SalesHdrL.
        rec.CalcFields(Amount, "Amount Including VAT");
        VatAmountG := rec."Amount Including VAT" - rec.Amount;
    end;
}