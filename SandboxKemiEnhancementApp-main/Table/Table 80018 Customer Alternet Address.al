table 80018 "Customer Alternet Address"//T12370-N
{
    DataClassification = ToBeClassified;

    fields
    {
        field(10; CustomerNo; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;

            trigger OnValidate()
            var
                CustomerRec: Record Customer;
            begin
                if CustomerRec.Get(CustomerNo) then
                    Rec.Validate(Name, CustomerRec.Name);
            end;
        }
        field(20; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(30; Address; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(40; Address2; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50; City; Text[50])
        {
            DataClassification = CustomerContent;
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code".City ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            ValidateTableRelation = false;

            trigger OnLookup()
            var
                postcode_rec: Record "Post Code";

            begin
                postcode_rec.LookupPostCode(City, PostCode, County, "Country/Region Code");
            end;

        }
        field(60; Contact; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(70; PhoneNo; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(80; telextNo; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(90; FaxNo; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(100; PostCode; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code" ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
        }

        field(110; "Country/Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(120; County; Text[30])
        {
            DataClassification = ToBeClassified;
        }

        field(130; Email; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(140; "Customer TRN"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        //UK Added New field 01/04/20>>
        field(150; "Alternate Short Name"; Text[20])
        {
            Caption = 'Alternate Short Name';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                if Customer.get(CustomerNo) then begin
                    Customer.AltCustomerName := Rec."Alternate Short Name";
                    Customer.Modify(false);
                end;
            end;
        }
        //UK Added New field 01/04/20<<
        //UK added new field 06/04/20>>
        field(160; "Customer Registration Type"; Text[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Customer Registration";
            // Editable = false;
            //T12370-NS
            trigger OnLookup()
            var
                custRegPage: Page "Customer Registration List";
                CustRegrec: Record "Customer Registration";
            begin
                custRegPage.LookupMode(true);
                if custRegPage.RunModal() = Action::LookupOK then begin
                    custRegPage.GetRecord(CustRegrec);
                    "Customer Registration Type" := CustRegrec."Customer Registration Type";
                    Modify();
                end;
            end;
            //T12370-NE

        }
        field(170; "Customer Registration No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        //UK added new field 06/04/20<<

        field(180; Website; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(190; "Mobile No."; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; CustomerNo)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}