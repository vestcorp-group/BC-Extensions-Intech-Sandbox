table 58244 "Item Variant Details"//T12370-N
{
    Caption = 'Item Variant Details';
    DataCaptionFields = "Item No.", "Variant Code";
    LookupPageID = "Item Variant Details";

    fields
    {
        field(58244; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item."No." where("No." = field("Item No."));
        }
        field(58245; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            NotBlank = true;
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."));
        }
        field(58246; "Manufacturer Name"; Text[100])
        {
            Caption = 'Manufacturer Name';
            // TableRelation = KMP_TblManufacturerName;//T12855-O
            TableRelation = Manufacturer;//T12855-N table relation change
        }
        field(58247; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            TableRelation = Vendor;
        }
        field(58248; "Vendor Item Description"; Text[100])
        {
            Caption = 'Vendor Item Description';
            DataClassification = ToBeClassified;
        }
        field(58249; "Vendor Country of Origin"; Code[20])
        {
            Caption = 'Vendor Country of Origin';
            TableRelation = "Country/Region";
        }
    }
    keys
    {
        key(Key1; "Item No.", "Variant Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Item No.", "Variant Code")
        {
        }
    }

}

