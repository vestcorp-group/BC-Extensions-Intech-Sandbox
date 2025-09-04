tableextension 50200 ItemBudgetEntryExt50200 extends "Item Budget Entry"
{
    fields
    {
        //T51238-NS
        field(50000; "Salesperson Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            var
                SalespersonPurchr_lRec: Record "Salesperson/Purchaser";
            begin
                SalespersonPurchr_lRec.Reset();
                If SalespersonPurchr_lRec.GET("Salesperson code") then
                    Rec."Salesperson Name" := SalespersonPurchr_lRec.Name;
            end;
        }

        field(50001; "Salesperson Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50002; "Team Code"; code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Team;
            trigger OnValidate()
            var
                Team_lRec: Record Team;
            begin
                Team_lRec.Reset();
                If Team_lRec.GET("Team code") then
                    Rec."Team Name" := Team_lRec.Name;
            end;
        }
        field(50003; "Team Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; "Country code"; code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";

            trigger OnValidate()
            var
                CountryRegion_lRec: Record "Country/Region";
            begin
                CountryRegion_lRec.Reset();
                If CountryRegion_lRec.GET("Country code") then
                    Rec."Country Name" := CountryRegion_lRec.Name;
            end;
        }
        field(50005; "Country Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        //T51238-NE
    }

}