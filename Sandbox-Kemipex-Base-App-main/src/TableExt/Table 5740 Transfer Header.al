tableextension 50111 KMP_TblExtTransferHeader extends "Transfer Header"//T12370-Full Comment
{
    fields
    {
        // Add changes to table fields here
        field(50100; CustomBOENumber; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Custom BOE No.';
            trigger OnValidate()
            var
                TransferLineL: Record "Transfer Line";
            begin
                TransferLineL.SetRange("Document No.", "No.");
                TransferLineL.ModifyAll(CustomBOENumber, CustomBOENumber);
            end;
        }
    }
}