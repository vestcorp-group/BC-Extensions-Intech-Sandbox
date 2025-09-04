pageextension 50490 DemandForecastExt extends "Demand Forecast Variant Matrix"
{
    Editable = false;

    layout
    {
        addafter(Description)
        {

            field("Prod. Forecast Quantity Base_"; Rec."Prod. Forecast Quantity Base_")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Prod. Forecast Quantity (Base) field.', Comment = '%';
            }
            //     field("SalesPerson Filter"; rec."SalesPerson Filter")
            //     {
            //         ApplicationArea = all;
            //     }
            // }
            // Add changes to page layout here
        }
    }


    var
        myInt: Integer;

    trigger OnOpenPage()
    var
        UserSetuplRec: Record "User Setup";
    begin
        UserSetuplRec.Get(UserId);
        rec."SalesPerson Filter" := UserSetuplRec."Salespers./Purch. Code";
    end;

}