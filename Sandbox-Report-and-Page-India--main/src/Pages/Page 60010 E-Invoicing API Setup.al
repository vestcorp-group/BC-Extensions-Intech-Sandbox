page 60010 "E-Invoicing API Setup"//T12370-N
{
    Caption = 'E-Invoicing API Setup';
    PageType = Card;
    SourceTable = "E-Invoicing API Setup";
    ApplicationArea = All;
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Base URL"; Rec."Base URL")
                {
                    ToolTip = 'Specifies the value of the Base URL field.';
                    ApplicationArea = All;
                }
                field("User Id"; Rec."User Id")
                {
                    ApplicationArea = All;
                }
                field(Password; Rec.Password)
                {
                    ApplicationArea = All;
                    ExtendedDatatype = Masked;
                }
                field("Login URL"; Rec."Login URL")
                {
                    ToolTip = 'Specifies the value of the Login URL field.';
                    ApplicationArea = All;
                }
                field("Invoice URL"; Rec."Invoice URL")
                {
                    ToolTip = 'Specifies the value of the Invoice URL field.';
                    ApplicationArea = All;
                }
                field("Generate EWB URL"; Rec."Generate EWB URL")
                {
                    ApplicationArea = All;
                }
                field("Cancel EWB URL"; Rec."Cancel EWB URL")
                {
                    ToolTip = 'Specifies the value of the Cancel EWB URL field.';
                    ApplicationArea = All;
                }
                field("Cancel IRN URL"; Rec."Cancel IRN URL")
                {
                    ToolTip = 'Specifies the value of the Cancel IRN URL field.';
                    ApplicationArea = All;
                }
                field("Download Invoice URL"; Rec."Download Invoice URL")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;
}
