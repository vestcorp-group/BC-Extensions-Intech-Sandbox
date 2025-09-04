/// <summary>
/// TableExtension Gen Journal Line Ext (ID 60103) extends Record MyTargetTable.
/// </summary>
tableextension 54001 "Gen Journal Line Ext" extends "Gen. Journal Line"
{
    fields
    {
        // Add changes to table fields here

        field(54001; "Upload Document No."; code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(54002; "Upload Document Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        /* modify("Document No.") //T12370_MIG
        {
            trigger OnAfterValidate()
            begin
                ChangeDocNo;
            end;
        } */
        field(50600; "IC Elimination"; Boolean)
        {

        }


    }


    trigger OnDelete()
    begin
        /*  StagingGenJournal.Reset(); //T12370_MIG
        StagingGenJournal.SetRange("Document No.", Rec."Upload Document No.");
        StagingGenJournal.SetRange("Line No.", Rec."Upload Document Line No.");
        StagingGenJournal.SetRange(Status, StagingGenJournal.Status::Created);
        StagingGenJournal.ModifyAll(Status, StagingGenJournal.Status::Deleted); */
    end;

    procedure ChangeDocNo()
    begin
        // StagingGenJournal.Reset();
        // StagingGenJournal.SetRange("Document No.", Rec."Upload Document No.");
        // StagingGenJournal.SetRange("Line No.", Rec."Upload Document Line No.");
        // if StagingGenJournal.FindFirst() then begin
        //     StagingGenJournal."Document No." := Rec."Document No.";
        //     StagingGenJournal.Modify();
        // end;

    end;

    var
        StagingGenJournal: Record "Staging Gen. Journal Line";
}