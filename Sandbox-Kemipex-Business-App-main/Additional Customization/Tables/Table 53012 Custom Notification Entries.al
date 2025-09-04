table 53012 "Custom Notification Entries"//T12370-Full Comment  //T13413-Full UnComment
{
    Caption = 'Custom Notification Entries';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Notification Date"; Date)
        {
            Caption = 'Notification Date';
            DataClassification = ToBeClassified;
        }
        field(3; "Notification"; Text[500])
        {
            Caption = 'Notification';
            DataClassification = ToBeClassified;
        }
        field(4; "User Id"; Code[50])
        {
            Caption = 'User Id';
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                UserSelection: Codeunit "User Selection";
            begin
                UserSelection.ValidateUserName("User ID");
            end;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(key2; "Notification Date")
        {

        }
    }
}
