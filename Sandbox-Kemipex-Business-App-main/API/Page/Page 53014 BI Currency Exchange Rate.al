page 53014 "BI Currency Exchange Rate"//T12370-Full Comment //T50051 Code Uncommented
{
    ApplicationArea = All;
    Caption = 'BI Currency Exchange Rate';
    PageType = List;
    SourceTable = "Currency Exchange Rate";
    Permissions = tabledata "Currency Exchange Rate" = R;
    DataCaptionFields = "Currency Code";
    UsageCategory = History;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Currency_Code; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field(Starting_Date; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field(Relational_Currency_Code; Rec."Relational Currency Code")
                {
                    ApplicationArea = All;
                }
                field(Exchange_Rate_Amount; Rec."Exchange Rate Amount")
                {
                    ApplicationArea = All;
                }
                field(Relational_Exch__Rate_Amount; Rec."Relational Exch. Rate Amount")
                {
                    ApplicationArea = All;
                }
                field(Converted_Relat__Exch__Rate; Converted_Relat__Exch__Rate)
                {
                    ApplicationArea = All;
                    Caption = 'Converted Relational Exch. Rate';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec."Relational Exch. Rate Amount" <> 0 then
            Converted_Relat__Exch__Rate := Rec."Exchange Rate Amount" / Rec."Relational Exch. Rate Amount"
        else
            Converted_Relat__Exch__Rate := Rec."Exchange Rate Amount";
    end;

    var
        Converted_Relat__Exch__Rate: Decimal;
}
