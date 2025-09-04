table 60010 "E-Invoicing API Setup"//T12370-N
{
    Caption = 'E-Invoicing API Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(2; "Base URL"; Text[100])
        {
            Caption = 'Base URL';
            DataClassification = ToBeClassified;
        }
        field(3; "Login URL"; Text[100])
        {
            Caption = 'Login URL';
            DataClassification = ToBeClassified;
        }
        field(4; "Invoice URL"; Text[150])
        {
            Caption = 'Invoice URL';
            DataClassification = ToBeClassified;
        }
        field(5; "User Id"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Password"; Text[100])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
        }
        field(7; "Cancel EWB URL"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Cancel IRN URL"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Download Invoice URL"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Generate EWB URL"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
