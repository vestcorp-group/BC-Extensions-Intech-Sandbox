page 79647 "Short Close Setup"
{
    Caption = 'Short Close Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "Short Close Setup";
    UsageCategory = Administration;
    ApplicationArea = all;
    PageType = Card;
    Description = 'T12084';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Allow Purchase Short Close"; Rec."Allow Purchase Short Close")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Allow Purchase Short Close field.';
                }
                field("Allow Sales Short Close"; Rec."Allow Sales Short Close")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Allow Sales Short Close field.';
                }
                field("Allow Transfer Short Close"; Rec."Allow Transfer Short Close")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Allow Transfer Short Close field.';
                }

            }

        }
    }

    var

    trigger OnOpenPage()
    var
    begin
        Rec.RESET();
        IF NOT Rec.GET() THEN BEGIN
            Rec.INIT();
            Rec.INSERT();
        END;
    end;
}
