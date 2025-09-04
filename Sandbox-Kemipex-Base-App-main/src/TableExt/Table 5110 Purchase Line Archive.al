tableextension 50349 KMP_TblExtPurArchiveLine extends "Purchase Line Archive"
{
    fields
    {
        // Add changes to table fields here
        field(50100; CustomBOENumber; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Custom BOE No.';
        }
        field(50101; CustomETA; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50102; CustomETD; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50103; CustomR_ETA; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50104; CustomR_ETD; Date)
        {
            DataClassification = ToBeClassified;
        }

        //Moved from PDCnothers Extension
        field(50105; "Container No. 2"; Text[200])
        {
            DataClassification = ToBeClassified;
        }

    }

    var
        myInt: Integer;
}