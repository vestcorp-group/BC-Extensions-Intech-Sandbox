page 50169 "Purchase Remark Sheet"//T12370-N
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Purchase Remarks";
    AutoSplitKey = true;
    DelayedInsert = true;
    Caption = 'Remarks';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Remark; rec.Remark)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        if rec."Document Type" = rec."Document Type"::Invoice then
            CurrPage.CAPTION := 'Purchase Invoice Remarks'
        else
            if rec."Document Type" = rec."Document Type"::Receipt then
                CurrPage.CAPTION := 'Posted Purchase Receipt Remarks'
            else
                if rec."Document Type" = rec."Document Type"::"Posted Invoice" then
                    CurrPage.CAPTION := 'Posted Purchase Invoice Remarks'
                else
                    if rec."Document Type" = rec."Document Type"::Order then
                        CurrPage.CAPTION := 'Purchase Receipt Remarks'
                    else
                        CurrPage.CAPTION := 'Purchase Remark Sheet';

    end;

    var
        CaptionTxt: Text[30];
}