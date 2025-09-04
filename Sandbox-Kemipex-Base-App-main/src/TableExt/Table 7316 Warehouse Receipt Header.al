tableextension 50104 KMP_TblExtWarehouseRreciptHdr extends "Warehouse Receipt Header"//T12370-Full Comment
{
    fields
    {
        field(50100; CustomBOENumber; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Custom BOE No.';
        }
    }
}