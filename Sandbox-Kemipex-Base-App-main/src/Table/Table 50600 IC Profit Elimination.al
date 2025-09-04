table 50600 "IC Profit Elimination"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Bussines Unit"; code[20]) { }
        field(2; postingDate; Date) { }
        field(3; entryNo; Integer) { }
        field(4; "IC Source No."; Code[20]) { }
        field(5; "Lot No."; Code[50]) { }
        field(6; "Item No."; Code[20]) { }
        field(7; EN; Integer) { }
        field(10; "Remaining Quantity"; Decimal) { }
        field(15; unitCost; Decimal) { }
        field(20; totalValue; Decimal) { }
        field(25; "Profit % IC"; Decimal) { }
        field(30; "Unrealized Profit"; Decimal) { }
        field(35; BU_CompName; Text[30]) { }
        field(40; Scenario; Integer) { }
    }

    keys
    {
        key(Key1; "Bussines Unit", entryNo, "IC Source No.", "Lot No.", EN)
        {
            Clustered = true;
        }
    }
}