page 58002 "Sales Approver User Setup"//T12370-Full Comment //T12574-N
{
    ApplicationArea = All;
    Caption = 'Sales Approver User Setup';
    PageType = List;
    SourceTable = "Sales Approver User Setup";
    UsageCategory = Lists;
    RefreshOnActivate = true;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        UpdatePriority();
                    end;
                }
                field("Type"; Rec."Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Type field.';
                    ShowMandatory = true;
                    trigger OnValidate()
                    begin
                        UpdatePriority();
                    end;
                }
                field("Calculation Type"; Rec."Calculation Type")
                {
                    ApplicationArea = All;
                }
                field("From Value"; Rec."From Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the From Value field.';
                    ShowMandatory = true;
                }
                field("To Value"; Rec."To Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the To Value field.';
                }
                field("Approver Type"; Rec."Approver Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Approver Type field.';
                    ShowMandatory = true;
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the User Id field.';
                    Editable = Rec."Approver Type" = Rec."Approver Type"::User;
                }
                field(Sequence; Rec."Sequence No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sequence field.';
                    ShowMandatory = true;
                }
                field("Workflow Priority"; Rec."Workflow Priority")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowXRec: Boolean): Boolean
    begin
        UpdatePriority();
        Rec.TestField("Workflow Priority");
    end;

    local procedure UpdatePriority()
    var
        myInt: Integer;
    begin
        myInt := SalesWorkflowCod.UpdateWorkflowPriority(Rec);
        if myInt <> 0 then
            Rec."Workflow Priority" := myInt;
    end;

    var
        SalesWorkflowCod: Codeunit "Sales Approval Events";
}
