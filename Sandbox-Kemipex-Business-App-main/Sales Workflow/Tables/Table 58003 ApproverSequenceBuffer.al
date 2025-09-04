table 58003 ApproverSequenceBuffer//T12370-Full Comment //T12574-N
{
    Caption = 'ApproverSequenceBuffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Approver ID"; Code[100])
        {
            Caption = 'Approver ID';
            DataClassification = ToBeClassified;
        }
        field(2; Sequence; Integer)
        {
            Caption = 'Sequence';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Approver ID", Sequence)
        {
            Clustered = true;
        }
    }
}
