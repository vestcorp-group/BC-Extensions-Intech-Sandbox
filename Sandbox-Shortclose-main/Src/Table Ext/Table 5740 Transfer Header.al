tableextension 79650 TransferHeaderExt_50007 extends "Transfer Header"
{
    fields
    {
        // T12084-NS
        field(79646; "Short Close Boolean"; Boolean)
        {
            Caption = 'Short Close Boolean';
            Description = 'T12084';
            Editable = false;
        }
        field(79647; "Short Close Reason"; Code[20])
        {
            Caption = 'Short Close Reason';
            Description = 'T12084';
            Editable = false;
            TableRelation = "Short Close Reason";

        }
        // T12084-NE      
    }
}
