tableextension 74986 Item_74986 extends Item
{
    fields
    {
        // Add changes to table fields here
        field(74981; "GST Import Duty Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'GSTImport';
            TableRelation = "GST Import Duty Setup".Code;
        }
    }

    var
        myInt: Integer;
}