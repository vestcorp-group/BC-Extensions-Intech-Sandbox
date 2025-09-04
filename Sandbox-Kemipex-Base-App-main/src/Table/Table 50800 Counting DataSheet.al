table 50800 "Counting DataSheet"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Counting DataSheet";
    LookupPageId = "Counting DataSheet";


    fields
    {
        field(50800; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Item Journal Template";
            Editable = false;
        }
        field(50801; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
            Editable = false;
        }
        field(50802; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }
        field(50803; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
        }
        field(50804; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            Editable = false;

        }
        field(50805; "Version No."; Integer)
        {
            Caption = 'Round No.';
            Editable = false;
        }
        field(50806; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
            Editable = false;
        }
        field(50807; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(50808; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            Editable = false;
        }
        field(50809; "Lot No."; Code[50])
        {
            Caption = 'Lot No.';
            Editable = false;
        }
        field(50810; "BOE No."; Code[50])
        {
            Caption = 'BOE No.';
        }
        field(50811; "Variant Code"; Code[10])
        { }
        field(50812; "Smallest Packing"; Code[10])
        {
            Caption = 'Smallest Packing';
            Editable = false;
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));

        }
        field(50813; "Qty. Calc. Smallest Packing"; Decimal)
        {
            Caption = 'Qty. Calc. Smallest Packing';
            DecimalPlaces = 0 : 5;
            Editable = false;

        }
        field(50814; "Qty. Counted Smallest Packing"; Decimal)
        {
            Caption = 'Qty. Counted Smallest Packing';
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Qty. Counted Base UOM" := "Qty. Counted Smallest Packing" * "Conversion factor";
            end;
        }
        field(50815; "Conversion factor"; Decimal)
        {
            Caption = 'Conversion factor';
            DecimalPlaces = 0 : 5;
            Editable = false;

        }
        field(50816; "Base UOM"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
            Editable = false;
        }

        field(50817; "Qty. Calc. Base UOM"; Decimal)
        {
            Caption = 'Qty Calc. Base UOM';
            DecimalPlaces = 0 : 5;
            Editable = false;

        }
        field(50818; "Qty. Counted Base UOM"; Decimal)
        {
            Caption = 'Qty Counted Base UOM';
            DecimalPlaces = 0 : 5;
            Editable = false;

        }
        field(50819; Remarks; Text[1024])
        {
            Caption = 'Remarks';
        }
        field(50820; "Lot No. 2"; code[30])
        {
            Caption = 'Lot No.';
        }
        field(50821; "Exist in Batch"; Boolean)
        {
            Caption = 'Exist in Batch';
            FieldClass = FlowField;
            CalcFormula = exist("Item Journal Line" where("Journal Template Name" = field("Journal Template Name"), "Journal Batch Name" = field("Journal Batch Name"), "Line No." = field("Line No."), "Document No." = field("Document No."), "Posting Date" = field("Posting Date")));
        }
        field(50822; Status; Option)
        {
            OptionMembers = Imported,Registered;
            DataClassification = ToBeClassified;
        }
        field(50823; "Expiration Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50824; "Manufacturing Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Journal Template Name", "Journal Batch Name", "Line No.", "Document No.", "Posting Date", "Version No.")
        {
            Clustered = true;
        }
        key(LastVersion; "Journal Template Name", "Journal Batch Name", "Document No.", "Posting Date", "Version No.")
        {

        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        //>>PM
        CountingDataSheet1.Reset();

        CountingDataSheet1.SetRange("Document No.", "Document No.");
        CountingDataSheet1.SetRange(Status, CountingDataSheet1.Status::Registered);
        if CountingDataSheet1.FindFirst() then
            Error('Line can not be inserted because document is already registered for posting');
        //<<PM
    end;

    trigger OnModify()
    begin
        CountingDataSheet1.Reset();

        CountingDataSheet1.SetRange("Document No.", "Document No.");
        CountingDataSheet1.SetRange(Status, CountingDataSheet1.Status::Registered);
        if CountingDataSheet1.FindFirst() then
            Error('Line can not be modified because document is already registered for posting');
        //<<PM

    end;

    trigger OnDelete()
    begin
        if Status = Status::Registered then
            Error('Lines can not be deleted because quantities are already registered for posting');
        CountingDataSheet.Reset();
        CountingDataSheet.SetFilter("Version No.", '>%1', rec."Version No.");
        CountingDataSheet.SetRange("Document No.", rec."Document No.");
        if CountingDataSheet.FindFirst() then
            Error('Line can not be deleted because round %1 data already exist', CountingDataSheet."Version No.");

    end;

    trigger OnRename()
    begin

    end;

    var
        CountingDataSheet: Record "Counting DataSheet";
        CountingDataSheet1: Record "Counting DataSheet";

}