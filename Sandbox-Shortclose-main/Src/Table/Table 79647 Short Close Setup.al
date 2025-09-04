table 79647 "Short Close Setup"
{
    Caption = 'Short Close Setup';
    Description = 'T12084';
    fields
    {
        field(79646; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(79647; "Allow Purchase Short Close"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(79648; "Allow Sales Short Close"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(79649; "Allow Transfer Short Close"; Boolean)
        {
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

}
