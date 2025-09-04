tableextension 50106 KMP_TblExtPurchRcptHeader extends "Purch. Rcpt. Header"
{
    fields
    {
        field(50100; CustomBOENumber; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Custom BOE No.';

        }
        field(50102; "Purchase Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Type';
            OptionMembers = BOE,LGP,LOCAL;
            OptionCaption = 'BOE,LGP,LOCAL';
        }
        // Start Issue - 59
        field(50103; "Supplier Invoice Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Supplier Invoice Date';
        }
        // Stop Issue - 59

        field(50104; "Vendor Invoice No."; Code[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Invoice No.';
        }
        //T13919-NS
        field(50110; "IC Transaction No."; Integer)
        {

        }
        //T13919-NE
        //ISPl-IC-Dev-RM&MC
    }


}