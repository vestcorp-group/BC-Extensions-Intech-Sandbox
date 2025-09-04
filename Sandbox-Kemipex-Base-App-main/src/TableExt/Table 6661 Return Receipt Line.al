tableextension 50310 KMP_TabExtReturnReceiptLine extends "Return Receipt Line"
{
    fields
    {
        field(50100; CustomBOENumber; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Custom BOE No.';
        }
        field(50112; "Container No. 2"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }

}