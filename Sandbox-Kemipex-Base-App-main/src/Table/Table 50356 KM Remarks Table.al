table 50356 "KM Remarks Table"//T12370-Full Comment  T12724
{
    Caption = 'KM Remarks ';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Shipment,Posted Invoice,Posted Credit Memo,Posted Return Receipt,User Task,Warehouse Instruction';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Shipment,"Posted Invoice","Posted Credit Memo","Posted Return Receipt","User Task","Warehouse Instruction";
            Editable = false;
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }
        field(6; Remark; Text[500])
        {
            Caption = 'Remark';
        }
        field(7; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
        }
        field(4; "Date and Time"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "User"; Code[50]) //Length 20-50 HyperCare Support
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.", "Document Line No.", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }


    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin
        if "Document Type" = "Document Type"::"User Task" then Error('Remarks cannot be edited');
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    var

        Itemcharge: Page "Item Charge Assignment (Purch)";


}
