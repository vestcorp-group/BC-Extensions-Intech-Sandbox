pageextension 50401 DemandForecastEntriesExt50401 extends "Demand Forecast Entries"
{
    caption = 'Sales-Rolling Forecast Entries';
    layout

    {
        modify(Control1)
        {
            Editable = LineEdit_lBln;

        }
        addafter("Component Forecast")
        {
            //T51238-NS
            field("Salesperson Code"; Rec."Salesperson Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Salesperson Code field.', Comment = '%';

            }
            field("Salesperson Name"; Rec."Salesperson Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Salesperson Name field.', Comment = '%';
                Editable = false;
            }
            field("Team Code"; Rec."Team Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Team Code field.', Comment = '%';

            }
            field("Team Name"; Rec."Team Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Team Name field.', Comment = '%';
                Editable = false;
            }
            field("Country code"; Rec."Country code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Country code field.', Comment = '%';
            }
            field("Country Name"; Rec."Country Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Country Name field.', Comment = '%';
                Editable = false;
            }
            field("Customer Code"; Rec."Customer Code")
            {
                ApplicationArea = All;
                trigger OnValidate()
                var
                    Customer_lRec: Record Customer;
                    County_lRec: Record "Country/Region";
                begin
                    if Customer_lRec.get(rec."Customer Code") then
                        rec."Country code" := Customer_lRec."Country/Region Code";
                    if County_lRec.get(Customer_lRec."Country/Region Code") then
                        rec."Country Name" := County_lRec.Name;
                end;
            }
            field("Customer Name"; Rec."Customer Name")
            {
                ApplicationArea = All;
                Editable = false;
            }

        }
        modify("Production Forecast Name")
        {
            Style = Attention;
            StyleExpr = ColorStyle_gBln;
        }
        modify("Forecast Quantity")
        {
            Style = Attention;
            StyleExpr = ColorStyle_gBln;
        }
        modify("Forecast Quantity (Base)")
        {
            Style = Attention;
            StyleExpr = ColorStyle_gBln;
            Editable = false;
        }
        modify("Forecast Date")
        {
            Style = Attention;
            StyleExpr = ColorStyle_gBln;
        }
        modify("Item No.")
        {
            Style = Attention;
            StyleExpr = ColorStyle_gBln;
            trigger OnAfterValidate()
            var
                Item_lRec: Record Item;
            begin
                if Item_lRec.get(rec."Item No.") then
                    rec.Description := Item_lRec.Description;
            end;
        }
        modify(Description)
        {
            Editable = false;
            Style = Attention;
            StyleExpr = ColorStyle_gBln;
        }
        modify("Location Code")
        {
            Style = Attention;
            StyleExpr = ColorStyle_gBln;
        }
        modify("Component Forecast")
        {
            Visible = false;
        }
        //T51238-NE

    }
    trigger OnOpenPage()
    var
        UserSetup_lRec: Record "User Setup";
    begin

        UserSetup_lRec.Get(UserId);

        //rec.FilterGroup(2);
        if UserSetup_lRec."Salespers./Purch. Code" <> '' then
            rec.SetRange("Salesperson Code", UserSetup_lRec."Salespers./Purch. Code");
        //rec.FilterGroup(0);
    end;

    trigger OnAfterGetRecord()
    var
        StartDate_lDte: Date;
        EndDate_lDte: Date;

    begin
        StartDate_lDte := CalcDate('-CM', Today);
        EndDate_lDte := CalcDate('-CM+2M', Today);
        if (rec."Forecast Date" >= EndDate_lDte) then begin// and (Rec."Forecast Date" <= EndDate_lDte) then begin
            LineEdit_lBln := true;
            ColorStyle_gBln := false;
        end
        else begin
            LineEdit_lBln := false;
            ColorStyle_gBln := true;
        end;

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    var
        UserSetup_lRec: Record "User Setup";
        SalesPerson_lRec: Record "Salesperson/Purchaser";
        TeamsSalesPerson: Record "Team Salesperson";
        Team_lRec: Record Team;
    begin
        UserSetup_lRec.get(UserId);
        rec."Salesperson Code" := UserSetup_lRec."Salespers./Purch. Code";
        if UserSetup_lRec."Salespers./Purch. Code" <> '' then begin
            SalesPerson_lRec.get(UserSetup_lRec."Salespers./Purch. Code");
            rec."Salesperson Name" := SalesPerson_lRec.Name;
        end;
        TeamsSalesPerson.Reset();
        TeamsSalesPerson.SetRange("Salesperson Code", UserSetup_lRec."Salespers./Purch. Code");
        if TeamsSalesPerson.FindFirst() then
            rec."Team Code" := TeamsSalesPerson."Team Code";
        if TeamsSalesPerson."Team Code" <> '' then begin
            Team_lRec.get(TeamsSalesPerson."Team Code");
            rec."Team Name" := Team_lRec.Name;
        end;
    end;

    var
        LineEdit_lBln: Boolean;
        ColorStyle_gBln: Boolean;
}