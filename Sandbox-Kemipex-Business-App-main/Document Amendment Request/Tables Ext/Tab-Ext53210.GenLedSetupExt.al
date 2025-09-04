tableextension 53210 GenLedSetupExt extends "General Ledger Setup"//T12370-N
{
    fields
    {
        field(53210; "Enable Amendment Request Mgmt"; Boolean)
        {
            Caption = 'Enable Amendment Request Mgmt';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if Rec."Enable Amendment Request Mgmt" then
                    Rec.TestField("Amendment Request Nos.");
            end;
        }
        field(53211; "Amendment Request Nos."; Code[10])
        {
            Caption = 'Amendment Request Nos.';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
    }
}
