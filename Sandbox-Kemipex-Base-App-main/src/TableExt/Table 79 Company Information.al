tableextension 50256 TabExtCompanyInformation extends "Company Information"//T12370-N
{
    fields
    {
        field(50005; "E-Mirsal Code"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        //Coroplus start
        field(50006; "License No. Cust."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Registration No. Cust."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        //Coroplus end

        // field(50600; "Default Profit %"; Decimal)
        // {
        //     Caption = 'Default Profit %';

        //     trigger OnValidate()
        //     var
        //         Company: Record Company;
        //         ICPartner: Record "IC Partner";
        //     begin
        //         Company.Reset();
        //         if Company.FindSet(false) then
        //             repeat
        //                 ICPartner.Reset();
        //                 ICPartner.ChangeCompany(Company.Name);
        //                 ICPartner.SetRange("Inbox Type", ICPartner."Inbox Type"::Database);
        //                 ICPartner.SetRange("Inbox Details", CompanyName);
        //                 if ICPartner.FindSet(true) then
        //                     repeat
        //                         ICPartner."Default Profit %" := rec."Default Profit %";
        //                         ICPartner.Modify();
        //                     until ICPartner.Next() = 0;
        //             until Company.Next() = 0;
        //     end;
        // }

    }

    var
        myInt: Integer;
}