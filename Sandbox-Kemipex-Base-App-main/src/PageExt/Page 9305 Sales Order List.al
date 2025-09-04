pageextension 51202 KMP_PageListExtSales extends "Sales Order List"//T12370-Full Comment //50312-51202
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
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        VatAmountG: Decimal;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
        //SalesOrderListL: page "Sales Order Statistics";
        SalesHdrL: Record "Sales Header";
    begin
        //SalesHdrL.
        rec.CalcFields(Amount, "Amount Including VAT");
        VatAmountG := rec."Amount Including VAT" - rec.Amount;
    end;
}