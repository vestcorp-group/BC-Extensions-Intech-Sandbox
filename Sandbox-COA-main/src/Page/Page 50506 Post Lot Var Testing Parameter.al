page 50506 "Post Lot Var Testing Parameter"//T12370-Full Comment T13935-N
{
    PageType = List;
    SourceTable = "Post Lot Var Testing Parameter";
    Caption = 'Posted Lot Variant Testing Parameter';
    //ModifyAllowed = true;
    //DeleteAllowed = false;
    //InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Parameters)
            {
                field("Source ID"; Rec."Source ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source ID field.', Comment = '%';
                    Editable = false;

                }
                field("Source Ref. No."; Rec."Source Ref. No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Source Ref. No. field.', Comment = '%';
                    Editable = false;
                }
                field("BOE No."; Rec."BOE No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the BOE No. field.', Comment = '%';
                    Editable = false;
                }
                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = all;
                    Enabled = false;
                    //Enabled = PageEditable;
                }

                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = All;
                    Enabled = PageEditable;
                }
                field("Variant Code"; Rec."Variant Code") //AJAY
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field("Testing Parameter Code"; Rec."Testing Parameter Code")
                {
                    ApplicationArea = All;
                    Editable = PageEditable;
                }
                field("Rounding Precision"; Rec."Rounding Precision")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rounding Precision field.', Comment = '%';
                    Editable = false;
                }
                field("Decimal Places"; Rec."Decimal Places")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Decimal Places field.', Comment = '%';
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.', Comment = '%';
                    Editable = false;
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
                field("Actual Value"; rec."Actual Value")
                {
                    ApplicationArea = all;
                    //T51170-NS
                    Editable = false;
                    //Enabled = PageEditable;
                    //T51170-NE

                }
                field("Vendor COA Text Result"; Rec."Vendor COA Text Result")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor COA Text Result field.', Comment = '%';
                    Enabled = PageEditable;
                }
                field("Vendor COA Value Result"; Rec."Vendor COA Value Result")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vendor COA Value Result field.', Comment = '%';
                    Enabled = PageEditable;
                }



                field(Result; Rec.Result)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Result field.', Comment = '%';
                    Enabled = PageEditable;

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


    //53429-NS
    trigger OnDeleteRecord(): Boolean
    var
        myInt: Integer;
    begin
        PostedDataDeleteAllowed();//53429-N
    end;

    local procedure PostedDataDeleteAllowed()
    var
        UserSetup: Record "User Setup";
    begin
        Clear(UserSetup);
        if UserSetup.GET(UserId) then begin
            if not UserSetup."Edit Posted Lot Parameter" then
                Error('You do not have permission to delete this record.');
        end;
    end;
    //53429-NE

    var
        PageEditable: Boolean;
}