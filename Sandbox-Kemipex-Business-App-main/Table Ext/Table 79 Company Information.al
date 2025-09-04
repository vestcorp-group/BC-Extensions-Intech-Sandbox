tableextension 58061 Company_information extends "Company Information"//T12370-Full Comment T12946-Code Uncommented
{
    fields
    {
        field(58004; Company_Classification; Code[20])
        {
            TableRelation = Company_Classification;
        }
        //Gross Profit
        field(53000; "Gross Profit Webservice URL"; Text[250])
        {
            Caption = 'Gross Profit Webservice URL';
            DataClassification = ToBeClassified;
        }
        field(53001; "Webserive Username"; Code[50])
        {
            Caption = 'Webserive Username';
            DataClassification = ToBeClassified;
        }
        field(53002; "Webservice Key"; Text[250])
        {
            Caption = 'Webservice Key';
            DataClassification = ToBeClassified;
        }
        field(53003; "Webservice Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        //Stamp
        field(58005; "Stamp"; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        //Hypercare-NS 
        field(53010; "Secret ID"; Text[100])
        {
            Caption = 'Secret ID';
            DataClassification = ToBeClassified;
        }
        field(53020; "Client ID"; Text[100])
        {
            Caption = 'Client ID';
            DataClassification = ToBeClassified;
        }
        field(58030; "Logo"; Blob)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }

        //Hypercare-NE
        //IC API -NS
        field(58040; "IC Tenant ID"; Text[50])
        {
            Caption = 'InterCompany Tenant ID';
            DataClassification = ToBeClassified;
        }
        field(58050; "IC Tenant Name"; Text[50])
        {
            Caption = 'InterCompany Tenant Name';
            DataClassification = ToBeClassified;
        }
        //IC API -NE
    }
    var

}