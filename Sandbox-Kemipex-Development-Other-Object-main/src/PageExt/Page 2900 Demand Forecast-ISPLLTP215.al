pageextension 50495 DemandForecastExt_ extends "Demand Forecast Variant Matrix"
{
    Editable = false;

    layout
    {
        addafter(Description)
        {

            // field("Prod. Forecast Quantity Base_"; Rec."Prod. Forecast Quantity Base_")
            // {
            //     ApplicationArea = All;
            //     Editable = false;
            //     Caption = 'Quantity Base';
            //     ToolTip = 'Specifies the value of the Prod. Forecast Quantity (Base) field.', Comment = '%';
            // }
            //     field("SalesPerson Filter"; rec."SalesPerson Filter")
            //     {
            //         ApplicationArea = all;
            //     }
        }
        // Add changes to page layout here

    }
    actions
    {
        addfirst(Processing)
        {

            action("Filter on QTY")
            {
                ApplicationArea = all;
                Image = FilterLines;
                trigger OnAction()
                begin
                    Rec.SetFilter("Prod. Forecast Quantity Base_", '<>0');
                end;
            }
            action("Clear Filter on QTY")
            {
                ApplicationArea = all;
                Image = ClearFilter;
                trigger OnAction()
                begin
                    Rec.SetRange("Prod. Forecast Quantity Base_");
                end;
            }
        }
    }



    trigger OnOpenPage()
    var
        UserSetuplRec: Record "User Setup";
    begin
        UserSetuplRec.Get(UserId);
        rec."SalesPerson Filter" := UserSetuplRec."Salespers./Purch. Code";
    end;
}