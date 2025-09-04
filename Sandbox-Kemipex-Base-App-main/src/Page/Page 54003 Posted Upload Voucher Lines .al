/// <summary>
/// Page Staging Gen. Journal (ID 60103).
/// </summary>

page 54003 "Posted Upload Voucher Lines"
{
    Caption = 'Posted Upload Voucher Lines';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Staging Gen. Journal Line";
    SourceTableView = sorting("Upload Batch No.", "Document No.", "Line No.") WHERE(Status = FILTER(Closed));
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Upload Batch No."; Rec."Upload Batch No.")
                {
                    ApplicationArea = All;
                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = all;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;

                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;

                }
                field("Gen. Doc"; Rec."Gen. Doc")
                {
                    ApplicationArea = all;
                    Caption = 'Created Document No.';
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;

                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = All;

                }
                field("Account Type"; rec."Account Type")
                {
                    ApplicationArea = All;

                }
                field("Account No."; rec."Account No.")
                {
                    ApplicationArea = All;

                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;

                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = All;

                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = All;

                }
                field("IC Partner G/L Account No."; rec."IC Partner G/L Account No.")
                {
                    ApplicationArea = All;

                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Editable = NonEdiTablestatus;

                }
                field("Uploaded By"; Rec."Uploaded By")
                {
                    ApplicationArea = All;
                }
                field("Uploaded Date/Time"; Rec."Uploaded Date/Time")
                {
                    ApplicationArea = all;
                }
                field("Modify By"; Rec."Modify By")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Modify On"; Rec."Modify On")
                {
                    ApplicationArea = all;
                    Editable = false;
                }

            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {

        }
    }
    trigger OnAfterGetRecord()
    begin
        NonEdiTablestatus := true;
        if rec.Status = rec.Status::Created then
            NonEdiTablestatus := false;


    end;

    var

        NonEdiTablestatus: Boolean;

}