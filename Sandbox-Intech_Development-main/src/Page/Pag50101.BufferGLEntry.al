page 50101 TempGLData
{
    ApplicationArea = All;
    Caption = 'TempGLData';
    PageType = List;
    SourceTable = TempGLData;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(EntryNo; Rec.EntryNo)
                {
                    ToolTip = 'Specifies the value of the EntryNo field.', Comment = '%';
                }
                field("G/L Account Name"; Rec."G/L Account Name")
                {
                    ToolTip = 'Specifies the value of the G/L Account Name field.', Comment = '%';
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ToolTip = 'Specifies the value of the G/L Account No. field.', Comment = '%';
                }
                field("Income/Balance"; Rec."Income/Balance")
                {
                    ToolTip = 'Specifies the value of the Income/Balance field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.', Comment = '%';
                }

                field("Net Balance"; Rec."Net Balance")
                {
                    ToolTip = 'Specifies the value of the Net Balance field.', Comment = '%';
                }
                field("Opening Balance"; Rec."Opening Balance")
                {
                    ToolTip = 'Specifies the value of the Opening Balance field.', Comment = '%';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.', Comment = '%';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the value of the Location Code field.', Comment = '%';
                }
                field("Location Name"; Rec."Location Name")
                {
                    ToolTip = 'Specifies the value of the Location Name field.', Comment = '%';
                }
                field("Market Code"; Rec."Market Code")
                {
                    ToolTip = 'Specifies the value of the Market Code field.', Comment = '%';
                }
                field("Market Name"; Rec."Market Name")
                {
                    ToolTip = 'Specifies the value of the Market Name field.', Comment = '%';
                }


            }
        }
    }
}
