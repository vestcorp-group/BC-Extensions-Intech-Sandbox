pageextension 50142 GrossProfitReport extends "Gross Profit Report"
{
    //T48610-N create New Page
    layout
    {
        addafter("Eff GP %")
        {
            field("Eff GP %_"; ExpGPPercent)
            {
                ApplicationArea = All;
                Caption = 'Eff GP %';
            }
        }
        modify("Eff GP %")
        {
            Visible = false;
        }
        addafter(POD)
        {
            Field(CustCountry; CustCountry)
            {
                ApplicationArea = All;
                Caption = 'Customer Country';
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        Customer_lRec: Record Customer;
        CountryRegion_lRec: Record "Country/Region";
    begin
        CustCountry := '';
        ExpGPPercent := '';

        ExpGPPercent := Format(Round(Rec."Eff GP %", 0.01)) + '%';

        Clear(Customer_lRec);
        if Customer_lRec.get(Rec."Customer Code") then begin
            Clear(CountryRegion_lRec);
            if CountryRegion_lRec.Get(Customer_lRec."Country/Region Code") then
                CustCountry := CountryRegion_lRec.Name;
        end;

        if Rec."Document Type" in [Rec."Document Type"::"Credit Memo"] then begin
            Rec.QTY := Abs(Rec.QTY) * (-1);
        end;
    end;

    trigger OnOpenPage()
    var
        Customer_lRec: Record Customer;
    begin
        // Rec.SetRange("IC Company Code", '');
    end;

    Var
        ExpGPPercent: text;
        CustCountry: Text;

}