tableextension 80001 CustomerTabExt extends Customer//T12370-N
{
    fields
    {
        field(80000; "Default Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
            DataClassification = ToBeClassified;
        }
        field(80003; "Customer Registration Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(80001; "Customer Registration Type"; Text[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Customer Registration";
            // Editable = false;
            //T12370-NS
            // trigger OnLookup()
            // var
            //     custRegPage: Page "Customer Registration List";
            //     CustRegrec: Record "Customer Registration";
            // begin
            //     custRegPage.LookupMode(true);
            //     if custRegPage.RunModal() = Action::LookupOK then begin
            //         custRegPage.GetRecord(CustRegrec);
            //         "Customer Registration Type" := CustRegrec."Customer Registration Type";
            //         Modify();
            //     end;
            // end;
            //T12370-NE

        }
        field(70000; "Customer Port of Discharge"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Area";

        }
        field(80002; "Customer Registration No."; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(80004; "AltCustomerName"; Text[20])
        {
            Caption = 'Customer Alternate short name';
            DataClassification = ToBeClassified;
        }
        field(80005; "seller Bank Detail"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Hide Seller Bank Details';
        }
        field(58036; "Tax Type"; Code[40])
        {
            TableRelation = TaxType;
            DataClassification = ToBeClassified;
        }
        //T12370-NS
        // modify("Search Name")
        // {
        //     Caption = 'Customer Short Name';
        // }
        // modify("Country/Region Code")
        // {
        //     trigger OnAfterValidate()
        //     var
        //         CountryRegion: Record "Country/Region";
        //     begin
        //         if CountryRegion.get(Rec."Country/Region Code") then
        //             Rec."Global Dimension 2 Code" := CountryRegion."Region Dimension";
        //     end;
        // }
        //T12370-NE

    }

    fieldgroups
    {
        addlast(DropDown; AltCustomerName)
        {

        }
    }
}