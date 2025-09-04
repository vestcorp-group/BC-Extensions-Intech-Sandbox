/* query 53039 SalesForecastWebAPI
{
    QueryType = Normal;

    elements
    {
        dataitem(Sales_Forecast_Header; "Sales Forecast Header")
        {
            column(Projection_No_; "Projection No.") { }
            column(Target_Year; "Target Year") { }
            column(Description; Description) { }
            column(Sales_Year; "Sales Year") { }
            column(Completely_Locked; "Completely Locked") { }
            column(Completely_Approved; "Completely Approved") { }
            column(GP__; "GP %") { }
            column(No__of_Previous_Years_Sale; "No. of Previous Years Sale") { }

        }
    }

    var
        myInt: Integer;

    trigger OnBeforeOpen()
    begin

    end;
} */