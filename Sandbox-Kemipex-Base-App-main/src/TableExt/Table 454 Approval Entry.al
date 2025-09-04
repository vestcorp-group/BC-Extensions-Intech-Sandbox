tableextension 50434 ApprovalEntryExt extends "Approval Entry"
{
    fields
    {
        field(50100; "Short Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        // Add changes to table fields here
    }

    var
        myInt: Integer;
}