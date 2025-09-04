tableextension 50348 KMP_TblExtPurArchive extends "Purchase Header Archive"
{
    fields
    {
        // Add changes to table fields here
        field(50100; CustomBOENumber; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Custom BOE No.';
        }
        field(50101; "Short Close"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Short Close';
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
    }

    var
        myInt: Integer;
}