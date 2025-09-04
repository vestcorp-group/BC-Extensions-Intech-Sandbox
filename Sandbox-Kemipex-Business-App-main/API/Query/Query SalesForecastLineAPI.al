/* query 53040 SalesForecastLineWebAPI
{
    QueryType = Normal;

    elements
    {
        dataitem(Sales_Forecast_Line; "Sales Forecast Line")
        {
            column(Projection_No_; "Projection No.") { }
            column(Target_Year; "Target Year") { }
            column(Line_No_; "Line No.") { }
            column(Sales_Year; "Sales Year") { }
            column(Team; Team) { }
            column(Locked; Locked) { }
            column(Sales_Person; "Sales Person") { }
            column(Proposed_Sales_Targed; "Proposed Sales Targed") { }
            column(Target_GP; "Target GP") { }
            column(Sale_Budget; "Sale Budget") { }
            column(Additional_Stretch_Sale; "Additional Stretch-Sale") { }
            column(Budget_GP; "Budget GP") { }
            column(Line_Type; "Line Type") { }
            column(Team_Manager_Code; "Team Manager Code") { }
            column(Indentation; Indentation) { }
            column(Budget_GP_SalYr; "Budget GP_SalYr") { }
            column(Budget_SalYr; Budget_SalYr) { }
            column(Sale_Till_Date_SalYr; "Sale Till Date_SalYr") { }
            column(GP_Till_Date_SalYr; "GP Till Date_SalYr") { }
            column(Sale_Full_Year_SalYr; "Sale Full Year_SalYr") { }
            column(Sale_Achieve___SalYr; "Sale Achieve %_SalYr") { }
            column(GP_Full_Year_SalYr; "GP Full Year_SalYr") { }
            column(GP_Achieve___SalYr; "GP Achieve %_SalYr") { }
            column(Sales_Actual_1; "Sales Actual_1") { }
            column(Sales_Actual_2; "Sales Actual_2") { }
            column(Sales_Actual_3; "Sales Actual_3") { }
            //column(Sales_Year; "Sales Year") { }

        }
    }

    var
        myInt: Integer;

    trigger OnBeforeOpen()
    begin

    end;
} */