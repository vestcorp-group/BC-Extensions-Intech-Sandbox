/// <summary>//T12370-Full Comment
/// Page Staging Gen. Journal (ID 60103).
/// </summary>

page 54002 "Upload Voucher Lines"       //T13413-FullUnComment
{
    Caption = 'Upload Voucher Lines';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Staging Gen. Journal Line";
    SourceTableView = sorting("Upload Batch No.", "Line No.") WHERE(Status = FILTER(<> Closed));
    InsertAllowed = false;
    DeleteAllowed = true;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Upload Batch No."; Rec."Upload Batch No.")
                {
                    ApplicationArea = All;
                    StyleExpr = LineColorChange;
                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = all;
                    StyleExpr = LineColorChange;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = all;
                    StyleExpr = LineColorChange;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;

                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                    StyleExpr = LineColorChange;

                }
                field("Gen. Doc"; Rec."Gen. Doc")
                {
                    ApplicationArea = all;
                    Caption = 'Created Document No.';
                    StyleExpr = LineColorChange;
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    StyleExpr = LineColorChange;

                }
                field("External Document No."; rec."External Document No.")
                {
                    ApplicationArea = All;
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;

                }
                field("Account Type"; rec."Account Type")
                {
                    ApplicationArea = All;
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;

                }
                field("Account No."; rec."Account No.")
                {
                    ApplicationArea = All;
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;

                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;

                }
                field("Currency Code"; rec."Currency Code")
                {
                    ApplicationArea = All;
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;

                }
                field(Amount; rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;

                }
                field("IC Partner G/L Account No."; rec."IC Partner G/L Account No.")
                {
                    ApplicationArea = All;
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;

                }
                field("Error Remarks"; rec."Error Remarks")
                {
                    ApplicationArea = all;
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;
                }
                field(Status; rec.Status)
                {
                    ApplicationArea = All;
                    Editable = NonEdiTablestatus;
                    StyleExpr = LineColorChange;
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;


                }
                field("Uploaded By"; Rec."Uploaded By")
                {
                    ApplicationArea = All;
                    StyleExpr = LineColorChange;
                }
                field("Uploaded Date/Time"; Rec."Uploaded Date/Time")
                {
                    ApplicationArea = all;
                    StyleExpr = LineColorChange;
                }
                field("Modify By"; Rec."Modify By")
                {
                    ApplicationArea = all;
                    Editable = false;
                    StyleExpr = LineColorChange;
                }
                field("Modify On"; Rec."Modify On")
                {
                    ApplicationArea = all;
                    Editable = false;
                    StyleExpr = LineColorChange;
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
            action("Import From Excel")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ProcessStagingActivities: Codeunit "Process Gen Journal Activitie";
                begin
                    ProcessStagingActivities.ImportStagingGenJournal();
                    CurrPage.Update();
                end;
            }
            action("ProcessGenLine")
            {
                Caption = 'Create Gen. Journal';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = CreateDocument;
                Visible = false;
                trigger OnAction()
                var
                    ProcessStagingActivities: Codeunit "Process Gen Journal Activitie";
                begin
                    ProcessStagingActivities.Run(Rec);
                    CurrPage.Update();
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        NonEdiTablestatus := false;
        if (rec.Status = rec.Status::Error) or (Rec.Status = Rec.Status::Deleted) then
            NonEdiTablestatus := true;
        LineColorChange := '';
        if rec.Status = rec.Status::Error then
            LineColorChange := 'Unfavorable'


    end;

    var

        NonEdiTablestatus: Boolean;
        LineColorChange: Text;
}