page 80228 "Packaging Detail"
{
    ApplicationArea = All;
    Caption = 'Packaging Detail';
    PageType = Document;
    SourceTable = "Packaging Detail Header";
    // InsertAllowed = false;
    // ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Packaging Code"; Rec."Packaging Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Product Code"; Rec."Product Code")
                {
                    ToolTip = 'Specifies the value of the Product Code field.', Comment = '%';
                }
            }
            part("Packaging Detail Lines"; "Packaging Details Subform")
            {
                ApplicationArea = All;
                SubPageView = sorting("Packaging Code", "Line No.");
                SubPageLink = "Packaging Code" = field("Packaging Code");
            }
        }
    }
}
