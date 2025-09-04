tableextension 74994 Item_Ledger_Entry_74994 extends "Item Ledger Entry"
{
    fields
    {
        field(74981; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
        }
        //AsOnDateInventory-NS
        /* field(74994; "Inbound Quantity"; Decimal)
        {
            Caption = 'Inbound Quantity';
            FieldClass = FlowField;
            CalcFormula = Sum("Item Application Entry".Quantity WHERE("Inbound Item Entry No." = FIELD("Entry No."), "Posting Date" = FIELD("Date Filter")));
        }
        field(74995; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        } */
        //AsOnDateInventory-NE
    }
}
