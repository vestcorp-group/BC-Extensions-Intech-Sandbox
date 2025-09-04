tableextension 80020 "Sales Line Ext" extends "Sales Line"//T12370-Full Comment //T12724
{
    fields
    {
        field(80001; "Item Generic Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = KMP_TblGenericName.Description;
        }
        field(80002; "Line Generic Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = KMP_TblGenericName.Description;
            ValidateTableRelation = false;

            // TableRelation = KMP_TblGenericName.Code;

        }
        field(70000; "Customer Requested Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                ItemRec: Record Item;
            begin
                if "No." <> '' then begin
                    if ItemRec.Get("No.") then begin
                        "Item Generic Name" := ItemRec."Generic Description";
                        "Line Generic Name" := ItemRec."Generic Description";
                    end;
                end;
            end;
        }
    }

    var
        myInt: Integer;
}