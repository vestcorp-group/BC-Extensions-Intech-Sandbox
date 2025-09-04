tableextension 58007 "Team SalesPerson" extends "Team Salesperson"//T12370-Full Comment //T12574-N
{
    fields
    {
        field(58000; "E-Email"; Text[100])
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("User Setup"."E-Mail" where("Salespers./Purch. Code" = field("Salesperson Code")));
        }
        field(58001; "Manager Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";
            Editable = false;
            Description = 'T12574';
        }

        //23-10-2022-start
        // field(53000; "Power BI Block"; Boolean)
        // {
        //     DataClassification = ToBeClassified;
        // }
        //23-10-2022-end

    }
}
