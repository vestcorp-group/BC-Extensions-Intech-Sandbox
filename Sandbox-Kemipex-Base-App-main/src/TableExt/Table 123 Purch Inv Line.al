tableextension 50271 KMP_TblExtPurchInvLine extends "Purch. Inv. Line"
{
    fields
    {
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

}