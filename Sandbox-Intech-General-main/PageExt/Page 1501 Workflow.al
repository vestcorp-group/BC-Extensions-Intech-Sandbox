pageextension 75058 Workflow_75058 extends Workflow
{
    layout
    {
        addafter(Category)
        {
            field("Send CC"; Rec."Send CC")
            {
                ApplicationArea = all;
            }
            field("Send BCC"; Rec."Send BCC")
            {
                ApplicationArea = all;
                Enabled = IsNotTemplate;
                Editable = IsNotTemplate;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        IsNotTemplate := NOT Rec.Template;
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        IsNotTemplate := NOT Rec.Template;
    end;

    var
        IsNotTemplate: Boolean;
}