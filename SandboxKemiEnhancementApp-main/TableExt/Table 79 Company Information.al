tableextension 80111 CompanyInfoTable_Ext extends "Company Information"
{
    fields
    {
        field(50110; "Company Group"; Option)
        {
            OptionMembers = ALL,CA,CH,CO,KM;
            OptionCaption = 'ALL,CA,CH,CO,KM';
        }
        field(70100; "Insurance Policy Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(70150; "Registered in"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(70151; "License No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(70152; "Enable GST caption"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}