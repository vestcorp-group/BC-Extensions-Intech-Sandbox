table 50456 "Item Company Block"//T12370-N
{
    DataClassification = CustomerContent;
    DataPerCompany = false;
    ReplicateData = false;
    fields
    {
        field(1; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Item;
            NotBlank = true;
        }
        field(2; "Company"; Text[30])
        {
            DataClassification = CustomerContent;
            TableRelation = Company;
            NotBlank = true;
        }
        field(3; "Blocked"; Boolean)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                ItemRec: Record item;
            begin
                ItemRec.ChangeCompany(rec.Company);
                ItemRec.SetRange("No.", "Item No.");
                if ItemRec.FindFirst() then ItemRec.Blocked := Rec.Blocked;
                if ItemRec.Modify() then;
            end;
        }
        field(4; "Sales Blocked"; Boolean)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                ItemRec: Record item;
            begin
                ItemRec.ChangeCompany(rec.Company);
                ItemRec.SetRange("No.", "Item No.");
                if ItemRec.FindFirst() then ItemRec."Sales Blocked" := Rec."Sales Blocked";
                if ItemRec.Modify() then;
            end;
        }
        field(5; "Purchase Blocked"; Boolean)
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                ItemRec: Record item;
            begin
                ItemRec.ChangeCompany(rec.Company);
                ItemRec.SetRange("No.", "Item No.");
                if ItemRec.FindFirst() then ItemRec."Purchasing Blocked" := Rec."Purchase Blocked";
                if ItemRec.Modify() then;
            end;
        }
        field(6; "Company Blocked"; Boolean)
        {

            FieldClass = FlowField;
            CalcFormula = lookup("Company Short Name"."Block in Reports" where(Name = field(Company)));
        }
    }

    keys
    {
        key(Key1; "Item No.", Company)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        ItemRec: Record Item;
    begin
        ValidateItemCompanyBlock(Rec."Item No.");
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin
        ValidateItemCompanyBlock(Rec."Item No.");
    end;

    procedure ValidateItemCompanyBlock(ItemCode: Code[20])
    var
        ItemRec: Record Item;
    begin
        ItemRec.ChangeCompany(rec.Company);
        if ItemRec.Get(ItemCode) then begin
            Rec.Blocked := ItemRec.Blocked;
            Rec."Sales Blocked" := ItemRec."Sales Blocked";
            Rec."Purchase Blocked" := ItemRec."Purchasing Blocked";
            if Rec.Modify() then;
        end;
    end;
}