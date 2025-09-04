page 50503 "Posted Lot Testing Parameters"//T12370-Full Comment T13935-N
{
    PageType = List;
    SourceTable = "Posted Lot Testing Parameter";
    //ModifyAllowed = true;
    //DeleteAllowed = false;
    //InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Parameters)
            {
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = All;
                    Enabled = PageEditable;
                }
                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = all;
                    Enabled = false;
                    //Enabled = PageEditable;
                }
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                    Enabled = PageEditable;
                }
                field("Testing Parameter"; rec."Testing Parameter")
                {
                    ApplicationArea = all;
                    Enabled = PageEditable;
                }
                field(Minimum; rec.Minimum)
                {
                    ApplicationArea = all;
                    Enabled = PageEditable;
                }
                field(Maximum; rec.Maximum)
                {
                    ApplicationArea = all;
                    Enabled = PageEditable;
                }
                field(Value; rec.Value2)
                {
                    ApplicationArea = all;
                    Enabled = PageEditable;

                }
                field("Actual Value"; rec."Actual Value")
                {
                    ApplicationArea = all;
                    Editable = false;
                  
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    Enabled = PageEditable;
                }
                field("Show in COA"; Rec."Show in COA")
                {
                    ApplicationArea = All;
                    Enabled = PageEditable;
                }
                field("Default Value"; Rec."Default Value")
                {
                    ApplicationArea = All;
                    Enabled = PageEditable;
                }
                field("Testing Parameter Code"; Rec."Testing Parameter Code")
                {
                    ApplicationArea = All;
                    Editable = PageEditable;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        SetControl();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetControl();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControl();
    end;

    local procedure SetControl()
    var
        UserSetup: Record "User Setup";
    begin
        PageEditable := false;
        Clear(UserSetup);
        if UserSetup.GET(UserId) then begin
            if UserSetup."Edit Posted Lot Parameter" then begin
                PageEditable := true;
                CurrPage.Editable := true;
            end else
                CurrPage.Editable := false;
        end else
            CurrPage.Editable := false;
    end;

    var
        PageEditable: Boolean;
}