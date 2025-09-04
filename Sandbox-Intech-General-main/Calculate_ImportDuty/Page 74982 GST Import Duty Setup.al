Page 74982 "GST Import Duty Setup"
{
    PageType = List;
    SourceTable = "GST Import Duty Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field("Landing Cost %"; Rec."Landing Cost %")
                {
                    ApplicationArea = Basic;
                }
                field("BCD %"; Rec."BCD %")
                {
                    ApplicationArea = Basic;
                }
                field("Custom eCess %"; Rec."Custom eCess %")
                {
                    ApplicationArea = Basic;
                }
                field("Custom SHE Cess %"; Rec."Custom SHE Cess %")
                {
                    ApplicationArea = Basic;
                }
                field("Against Advance License"; Rec."Against Advance License")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin
        CheckAllowPermission_lFnc;  //T18908-N
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        CheckAllowPermission_lFnc;  //T18908-N
    end;

    trigger OnModifyRecord(): Boolean
    begin
        CheckAllowPermission_lFnc;  //T18908-N
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CheckAllowPermission_lFnc;  //T18908-N
    end;

    local procedure CheckAllowPermission_lFnc()
    var
        UserSetup_lRec: Record "User Setup";
    begin
        //T18908-NS
        UserSetup_lRec.Get(UserId);
        if not UserSetup_lRec.Administrator then
            Error('User ID %1 doesnot have permission for perform this action', ConvertStr(UserId, '\', '_'));
        //T18908-NE
    end;
}

