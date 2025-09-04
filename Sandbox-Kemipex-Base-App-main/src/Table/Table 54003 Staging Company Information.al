table 54003 "Staging Company Information"//T14179-N
{
    Caption = 'Stagging Company Information';
    DataClassification = ToBeClassified;
    DataPerCompany = false;
    fields
    {
        field(1; "Code"; Code[30])
        {
            // Caption = 'Primary Key';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; "Name 2"; Text[50])
        {
            Caption = 'Name 2';
        }
        field(4; Address; Text[100])
        {
            Caption = 'Address';
        }
        field(5; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(6; City; Text[30])
        {
            Caption = 'City';
            TableRelation = if ("Country/Region Code" = const('')) "Post Code".City
            else
            if ("Country/Region Code" = filter(<> '')) "Post Code".City where("Country/Region Code" = field("Country/Region Code"));
            ValidateTableRelation = false;
        }
        field(7; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(8; "Phone No. 2"; Text[30])
        {
            Caption = 'Phone No. 2';
            ExtendedDatatype = PhoneNo;
        }
        field(9; "Telex No."; Text[30])
        {
            Caption = 'Telex No.';
        }
        field(10; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }


        field(19; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';



        }
        field(20; "Registration No."; Text[20])
        {
            Caption = 'Registration No.';
        }
        field(36; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";


        }
        field(29; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }


        field(58005; "Stamp"; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(58030; "Logo"; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }



    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, Name)
        {
        }
    }

}