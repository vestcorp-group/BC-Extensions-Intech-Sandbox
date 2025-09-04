page 50352 UserTaskRemarks//T12370-Full Comment T12724
{
    Caption = 'Remarks';
    PageType = ListPart;
    SourceTable = "KM Remarks Table";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document Line No."; Rec."Document Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Remark; Rec.Remark)
                {
                    ApplicationArea = All;
                    // ColumnSpan = 5;
                    Width = 200;
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                    begin

                    end;
                }
                field("Date and Time"; rec."Date and Time")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Width = 10;
                }
                field(User; rec.User)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Width = 15;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        I: Integer;
        SH: Record "Sales Header";
        AE: Record "Approval Entry";
    begin
        Rec."Date and Time" := CurrentDateTime();
        rec.User := UserId;
    end;
}
