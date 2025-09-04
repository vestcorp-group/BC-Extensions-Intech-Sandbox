tableextension 80011 Item_Ledger_Entry_Ext extends "Item Ledger Entry"//T12370-Full Comment  //T12573-N
{
    fields
    {
        field(50106; "Group GRN Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(70000; "Production Wh."; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Location."Production Warehouse" where(Code = field("Location Code")));
        }
    }

    var
        myInt: Integer;
}