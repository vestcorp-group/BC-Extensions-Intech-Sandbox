tableextension 79647 SalesHeaderExt_50004 extends "Sales Header"
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
        field(79648; "Short Close Approval Required"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Description = 'T50307';
        }
    }
}
