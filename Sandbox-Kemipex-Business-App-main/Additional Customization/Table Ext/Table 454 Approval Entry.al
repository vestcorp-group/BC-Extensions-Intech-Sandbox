tableextension 58011 Approval_Entries extends "Approval Entry"//T12370-Full Comment //T12574-N
{
    fields
    {
        field(58000; "Approver Remarks"; Text[250])
        {
            Caption = 'Approver Remarks';
            DataClassification = ToBeClassified;
            Description = 'T12574';
        }
    }
}
