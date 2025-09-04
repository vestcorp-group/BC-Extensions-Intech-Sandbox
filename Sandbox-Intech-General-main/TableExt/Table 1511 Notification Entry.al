tableextension 75002 Notification_Entry_75002 extends "Notification Entry"
{
    fields
    {
        field(50000; "Workflow Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'T11244';
            Editable = false;
            NotBlank = true;
            TableRelation = Workflow;
        }
    }
}