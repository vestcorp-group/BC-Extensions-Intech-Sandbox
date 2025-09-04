pageextension 53005 PostedSalesShipmetSubform extends "Posted Sales Shpt. Subform" //T13796
//T12370-Full Comment 
{
    layout
    {
        addafter("Item Generic Name")
        {
            field(LineHSNCode; rec.LineHSNCode)//T13796
            {
                ApplicationArea = all;
                Caption = 'Line HS Code';
            }
            field(LineCountryOfOrigin; rec.LineCountryOfOrigin)//T13796
            {
                ApplicationArea = all;
                Caption = 'Line Country of Origin';
            }
        }
    }
    actions
    {
    }
    var
        DocumentTotals2: Codeunit "Document Totals";
        CompanyInfo: Record "Company Information";
}