page 79646 "Short Close Reason"
{
    Caption = 'Short Close Reason';
    PageType = List;
    DataCaptionFields = Code;
    SourceTable = "Short Close Reason";
    Description = 'T12084';
    ApplicationArea = all;
    UsageCategory = Lists;


    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field(Code; Rec.Code)
                {

                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

}