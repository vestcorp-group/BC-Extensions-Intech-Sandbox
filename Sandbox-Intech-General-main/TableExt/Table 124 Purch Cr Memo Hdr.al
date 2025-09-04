tableextension 74997 Purch_Cr_Memo_Hdr_74997 extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        field(74331; Remarks; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(74332; "LR/RR No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'C0007';
        }
        field(74333; "LR/RR Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'C0007';
        }
        field(74334; "Vendor Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(74335; "Vendor Invoice No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        //SkipRefNoChk-NS
        field(74981; "Skip Check Invoice Ref"; Boolean)
        {
            Caption = 'Skip Check Invoice Reference for Old Invoice Credit Memo';
            DataClassification = ToBeClassified;
        }
        //SkipRefNoChk-NE
    }
}