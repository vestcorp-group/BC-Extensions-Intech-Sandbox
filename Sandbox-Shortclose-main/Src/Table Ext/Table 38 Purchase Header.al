tableextension 79648 PurchaseHeaderExt_50005 extends "Purchase Header"
{
    fields
    {
        // T12084-NS
        field(79646; "Short Close Boolean"; Boolean)
        {
            Caption = 'Short Close Boolean';
            Description = 'T12084';
            Editable = false;
        }
        field(79647; "Short Close Reason"; Code[20])
        {
            Caption = 'Short Close Reason';
            Description = 'T12084';
            Editable = false;
            TableRelation = "Short Close Reason";

        }
        // T12084-NE

        //T09749-NS
        field(79648; "Create By"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            Editable = false;
        }
        field(79649; "Modified By"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            Editable = false;
        }
        //T09749-NE

        //T10023-NS
        field(79650; "Retail Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        //T10023-NE
        //T50306-NS-NB
        field(79651; "ShortClose Approval"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'T50306';
        }
        //T50306-NE-NB
    }

    trigger OnBeforeInsert()
    begin
        "Create By" := UserId;
    end;

    trigger OnBeforeModify()
    begin
        "Modified By" := UserId;
    end;
}
