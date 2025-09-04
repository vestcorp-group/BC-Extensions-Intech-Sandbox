page 74985 "INT_Tax Transcation Value View"
{
    ApplicationArea = All;
    Caption = 'Tax Transcation Value View';
    PageType = List;
    SourceTable = "Tax Transaction Value";
    UsageCategory = Administration;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ID field.';
                }
                field("Case ID"; Rec."Case ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Case ID field.';
                }
                field("Column Name"; Rec."Column Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Column Name field.';
                }
                field("Column Value"; Rec."Column Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Column Value field.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency Code field.';
                }
                field("Currency Factor"; Rec."Currency Factor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Currency Factor field.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.';
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount (LCY) field.';
                }

                field("Option Index"; Rec."Option Index")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Option Index field.';
                }
                field(Percent; Rec.Percent)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Percent field.';
                }
                field("Tax Record ID"; Format(Rec."Tax Record ID"))
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tax Record ID field.';
                }
                field("Tax Type"; Rec."Tax Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tax Type field.';
                }
                field("Value ID"; Rec."Value ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Value ID field.';
                }
                field("Value Type"; Rec."Value Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Value Type field.';
                }
                field("Visible on Interface"; Rec."Visible on Interface")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Visible on Interface field.';
                }
            }
        }
    }
}
