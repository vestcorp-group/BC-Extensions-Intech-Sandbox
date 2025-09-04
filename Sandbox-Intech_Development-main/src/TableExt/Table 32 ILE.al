tableextension 50115 ILEExt50115 extends "Item Ledger Entry"
{
    fields
    {
        field(50043; "Inbound Quantity"; Decimal)
        {
            CalcFormula = sum("Item Application Entry".Quantity where("Inbound Item Entry No." = field("Entry No."),
                                                                       "Posting Date" = field("Date Filter")));
            Description = 'T47866';
            FieldClass = FlowField;
        }
        field(50044; "Date Filter"; Date)
        {
            Description = 'T47866';
            FieldClass = FlowFilter;
        }
        field(51021; "Applied Found"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'T47866';
            Editable = false;
        }
        field(51022; "Origin Found"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'T47866';
            Editable = false;
        }
        field(51023; "Applied Wksh Entry Found"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'T47866';
            Editable = false;
        }
        field(51024; "FPO No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'T51982';
            Editable = false;
        }
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