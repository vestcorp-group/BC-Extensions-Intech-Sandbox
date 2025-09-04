page 50366 "Warehouse Instruction Setup"//T12370-Full Comment
{
    Caption = 'Warehouse Instruction Setup';
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = "Warehouse Instruction Setup";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("CC Email Address"; Rec."CC Email Address")
                {
                    ApplicationArea = All;
                }
                field("WDI No. Series"; Rec."Whse Delivery Ins No. Series")
                {
                    Caption = 'Warehouse Delivery Instruction No. Series';
                    ApplicationArea = All;
                }
                field("Agent No. Series"; rec."Agent No. Series")
                {
                    ApplicationArea = all;
                }
                field("Ex-Works Incoterm"; rec."Ex-Works Incoterm")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
