page 50277 KMP_PageMarketIndustry//T12370-N
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = KMP_TblMarketIndustry;
    Caption = 'Market Industry';
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; rec.Code)
                {
                    ApplicationArea = All;

                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        // area(Processing)//T12370-Full Comment
        // {
        //     action(Release)
        //     {
        //         Caption = 'Release to Companies';
        //         ApplicationArea = all;
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         PromotedIsBig = true;
        //         trigger OnAction()
        //         var
        //             releasetocompany: Codeunit "Release to Company";
        //         begin
        //             releasetocompany.ReleaseMarktetIndustry(Rec);
        //         end;
        //     }
        // }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(ActionName)
    //         {
    //             ApplicationArea = All;

    //             trigger OnAction()
    //             begin

    //             end;
    //         }
    //     }
    // }

    var
        myInt: Integer;
}