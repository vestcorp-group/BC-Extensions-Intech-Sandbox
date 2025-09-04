tableextension 50105 KMP_TblExtWarehouseRreciptLine extends "Warehouse Receipt Line"//T12370-Full Comment
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