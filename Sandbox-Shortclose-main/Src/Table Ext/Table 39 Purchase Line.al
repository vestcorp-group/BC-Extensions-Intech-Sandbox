tableextension 79649 PurchaseLineExt_50006 extends "Purchase Line"
{
    fields
    {// T12084-NS
        field(79646; "Short Close Boolean"; Boolean)
        {
            Caption = 'Short Close Boolean';
            Description = 'T12084';
            Editable = false;
        }
        field(79647; "Short Closed Qty"; Decimal)
        {
            Caption = 'Short Closed Qty';
            Description = 'T12084';
            BlankZero = true;
            Editable = false;
        }

        field(79648; "Short Close Reason"; Code[20])
        {
            Caption = 'Short Close Reason';
            Description = 'T12084';
            Editable = false;
            TableRelation = "Short Close Reason";

        }
        // T12084-NE    
        field(79649; "Short Close Approval Required"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Description = 'T50306';
        }
    }
    var
        Text33029740Lbl: Label 'You Cannot Modify the Record.\Record is Applied for Purchase Short Close.';
    // T12084-NS
    trigger OnBeforeModify()
    begin
        IF "Short Close Boolean" THEN begin
            IF Quantity <> xRec.Quantity then
                ERROR(Text33029740Lbl);
        end;
    end;
    // T12084-NE
}
