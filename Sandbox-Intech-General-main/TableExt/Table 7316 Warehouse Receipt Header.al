tableextension 75028 WarehouseRcpt_Header_75028 extends "Warehouse Receipt Header"
{
    fields
    {
        //T12240-NS
        field(74332; "LR/RR No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'C0007';
            // Editable = false;
        }
        field(74333; "LR/RR Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'C0007';
            // Editable = false;

        }
        field(74334; "Shipping Agent Code"; Code[10])
        {
            Caption = 'Shipping Agent Code';
            TableRelation = "Shipping Agent";
        }
        //T12240-NE
    }

}