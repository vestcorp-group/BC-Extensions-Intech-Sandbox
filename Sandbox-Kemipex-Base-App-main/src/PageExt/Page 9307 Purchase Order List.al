pageextension 51210 KMP_PageListExtPurchase extends "Purchase Order List"//T12370-Full Comment//Hypercare Support
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