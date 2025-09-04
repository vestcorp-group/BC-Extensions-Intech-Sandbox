tableextension 50001 ForecastExt extends "Forecast Item Variant Loc"
{

    fields
    {
        field(50000; "Prod. Forecast Quantity Base_"; Decimal)
        {
            CalcFormula = sum("Production Forecast Entry"."Forecast Quantity (Base)" where("Item No." = field("No."),
                                                                                            "Production Forecast Name" = field("Production Forecast Name"),
                                                                                            "Forecast Date" = field("Date Filter"),
                                                                                            "Location Code" = field("Location Filter"),
                                                                                            "Component Forecast" = field("Component Forecast"),
                                                                                            "Variant Code" = field("Variant Filter"),
                                                                                            "Salesperson Code" = field("SalesPerson Filter")));
            Caption = 'Prod. Forecast Quantity_';
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
        }// Add changes to table fields here
        field(50001; "SalesPerson Filter"; Code[20])
        {
            Caption = 'SalesPerson Filter';
            FieldClass = FlowFilter;
        }// Add changes to table fields here

    }



    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}