page 50801 "Counting DataSheet"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Counting DataSheet";
    //Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Datasheet)
            {
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Journal Template Name';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Journal Batch Name';

                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Line No.';
                }

                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Journal Batch Name';
                }

                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Journal Batch Name';

                }
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = All;
                    Caption = 'Round No.';
                    ToolTip = 'Journal Batch Name';

                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Journal Batch Name';

                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Variant Code';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Journal Batch Name';

                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Journal Batch Name';

                }
                field("Lot No."; Rec."Lot No. 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Journal Batch Name';

                }
                field("BOE No."; Rec."BOE No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Journal Batch Name';

                }

                field("Smallest Packing"; Rec."Smallest Packing")
                {
                    ApplicationArea = All;
                    ToolTip = 'Journal Batch Name';

                }

                field("Qty. Calc. Smallest Packing"; Rec."Qty. Calc. Smallest Packing")
                {
                    ApplicationArea = All;
                    ToolTip = 'Journal Batch Name';

                }
                field("Qty. Counted Smallest Packing"; Rec."Qty. Counted Smallest Packing")
                {
                    ApplicationArea = All;
                    ToolTip = 'Journal Batch Name';

                }
                field("Conversion factor"; Rec."Conversion factor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Journal Batch Name';

                }

                field("Base UOM"; Rec."Base UOM")
                {
                    ApplicationArea = All;
                    ToolTip = 'Journal Batch Name';

                }
                field("Qty. Calc. Base UOM"; Rec."Qty. Calc. Base UOM")
                {
                    ApplicationArea = All;
                    ToolTip = 'Journal Batch Name';

                }
                field("Qty. Counted Base UOM"; Rec."Qty. Counted Base UOM")
                {
                    ApplicationArea = All;
                    ToolTip = 'Journal Batch Name';

                }

                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Journal Batch Name';

                }
                field("Exist in Batch"; Rec."Exist in Batch")
                {
                    ApplicationArea = All;
                    ToolTip = 'Exist in Batch';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Status';
                }
                field("Manufacturing Date"; Rec."Manufacturing Date")
                {
                    ApplicationArea = All;

                }
                field("Expiration Period"; Rec."Expiration Period")
                {
                    ApplicationArea = All;

                }

            }
        }
    }

}