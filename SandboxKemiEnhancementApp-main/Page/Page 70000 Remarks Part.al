//T12724 NS 07110224
page 70000 "Remarks Part"//T12370-Full Comment
{

    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Order Remarks";
    Caption = 'Remarks';
    Editable = true;
    AutoSplitKey = true;
    // MultipleNewLines = true;
    DelayedInsert = True;


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Comments; rec.Comments)
                {
                    Caption = 'Remarks';
                    ApplicationArea = All;
                    Width = 200;

                }
            }
        }
    }



    var
        myInt: Integer;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if (rec."Line No." <> 0) and (rec.Comments = '') then
            Error('System Can not insert blank line');
    end;
}
//T12724 NE 07110224