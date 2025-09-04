page 50505 "Lot Variant Testing Parameters"//T12370-Full Comment // 03-12-24 T12946 CodeUncommented
{
    PageType = List;
    SourceTable = "Lot Variant Testing Parameter";
    UsageCategory = Administration;
    ApplicationArea = all;
    Caption = 'Lot Variant Testing Parameters';
    layout
    {
        area(Content)
        {
            repeater(Parameters)
            {

                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Lot No."; rec."Lot No.")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field("Testing Parameter"; rec."Testing Parameter")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Testing Parameter Code"; Rec."Testing Parameter Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rounding Precision"; Rec."Rounding Precision")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Rounding Precision field.', Comment = '%';
                    Editable = false;
                }
                field("Decimal Places"; Rec."Decimal Places")
                {
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
                    Editable = false;
                }
                field(Maximum; rec.Maximum)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Symbol; rec.Symbol)
                {
                    ApplicationArea = all;
                    Editable = false;
                    Visible = false;//25-06-2022
                }
                field(Value; rec.Value2)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Actual Value"; rec."Actual Value")
                {
                    ApplicationArea = all;
                    // Editable = NOT IsActualDisbaled;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Show in COA"; Rec."Show in COA")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Default Value"; Rec."Default Value")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }

                //T51170-NS
                field("Vendor COA Text Result"; Rec."Vendor COA Text Result")
                {
                    ApplicationArea = all;
                    Editable = "Actual TextEditable" AND (NOT IsActualDisbaled);
                }
                field("Vendor COA Value Result"; Rec."Vendor COA Value Result")
                {
                    ApplicationArea = Basic;
                    Editable = "Actual ValueEditable" AND (NOT IsActualDisbaled);
                }
                field(Result; Rec.Result)
                {
                    ToolTip = 'Specifies the value of the Result field.', Comment = '%';
                    Editable = (NOT IsActualDisbaled);
                }
                //T51170-NE
            }
        }
    }

    actions
    {
        area(Processing)
        {

        }
    }

    trigger OnOpenPage()
    var
        text1: Text;
    begin

    end;

    procedure DisableActualValueControl()
    begin
        IsActualDisbaled := true;
    end;

    trigger OnAfterGetRecord()
    begin

        AfterGetCurrRecord;

    end;

    local procedure AfterGetCurrRecord()
    begin
        //I-C0009-1001310-01 NS
        xRec := Rec;


        if Rec.Type = Rec.Type::Text then begin
            "Actual ValueEditable" := false;
            "Actual TextEditable" := true;
        end else
            if Rec.Type = Rec.Type::Range then begin
                "Actual ValueEditable" := true;
                "Actual TextEditable" := false; //Hypercare-18-03-25-N
            end else
                if ((Rec.Type = Rec.Type::Maximum) or (Rec.Type = Rec.Type::Minimum)) then begin
                    "Actual ValueEditable" := true;
                    "Actual TextEditable" := false;
                end;
        //I-C0009-1001310-01 NE

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
        IsActualDisbaled: Boolean;
        "Actual ValueEditable": Boolean;
        "Actual TextEditable": Boolean;

}