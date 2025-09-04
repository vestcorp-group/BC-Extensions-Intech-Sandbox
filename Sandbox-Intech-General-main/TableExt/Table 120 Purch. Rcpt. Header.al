tableextension 75027 PurchRcpt_Header_75027 extends "Purch. Rcpt. Header"
{
    fields
    {
        //T12240-NS
        field(74332; "LR/RR No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'C0007';
            Editable = false;
        }
        field(74333; "LR/RR Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'C0007';
            Editable = false;

        }
        //T12240-NE
    }

}