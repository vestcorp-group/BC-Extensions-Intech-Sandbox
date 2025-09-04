//T36936-NS
Page 74987 "Vendor TDS Files List"
{
    ApplicationArea = All;
    Caption = 'Vendor Form16 TDS File List';
    PageType = List;
    SourceTable = "Vendor TDS File Header";
    UsageCategory = Lists;
    CardPageId = "Vendor TDS Files Card";
    Description = 'T36936';


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}
//T36936-NE
