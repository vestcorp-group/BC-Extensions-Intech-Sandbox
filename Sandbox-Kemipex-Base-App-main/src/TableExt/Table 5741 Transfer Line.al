tableextension 50112 KMP_TblExtTransferLine extends "Transfer Line"//T12370-Full Comment
{
    fields
    {
        // Add changes to table fields here
        field(50100; CustomBOENumber; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Custom BOE No.';
            Editable = false;
        }
    }
}