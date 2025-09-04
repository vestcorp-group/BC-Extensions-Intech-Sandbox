page 80229 "Packaging Details Subform"
{
    ApplicationArea = All;
    Caption = 'Packaging Details Subform';
    PageType = ListPart;
    SourceTable = "Packaging detail Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Packaging Code"; Rec."Packaging Code")
                {
                    ToolTip = 'Specifies the value of the Packaging Code field.', Comment = '%';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure field.', Comment = '%';
                }
                field("Packaging Level"; Rec."Packaging Level")
                {
                    ToolTip = 'Specifies the value of the Packaging Level field.', Comment = '%';
                }
                field("Packaging Matrics"; Rec."Packaging Matrics")
                {
                    ToolTip = 'Specifies the value of the Packaging Matricsx field.', Comment = '%';
                }
                field("Packaging Weight"; Rec."Packaging Weight")
                {
                    ToolTip = 'Specifies the value of the Packaging Weight field.', Comment = '%';
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ToolTip = 'Specifies the value of the Net Weight field.', Comment = '%';
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ToolTip = 'Specifies the value of the Gross Weight field.', Comment = '%';
                }
                field(Length; Rec.Length)
                {
                    ToolTip = 'Specifies the value of the Length field.', Comment = '%';
                }
                field(Width; Rec.Width)
                {
                    ToolTip = 'Specifies the value of the Width field.', Comment = '%';
                }
                field(Height; Rec.Height)
                {
                    ToolTip = 'Specifies the value of the Height field.', Comment = '%';
                }
            }
        }
    }
}
