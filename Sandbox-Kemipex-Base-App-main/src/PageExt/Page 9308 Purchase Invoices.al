pageextension 51209 KMP_PageListExtPurchaseInv extends "Purchase Invoices"//T12370-Full Comment
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

    begin

        rec.CalcFields(Amount, "Amount Including VAT");
        VatAmountG := rec."Amount Including VAT" - rec.Amount;
    end;
}