page 50279 KMP_PageGenericName//T12370-N
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = KMP_TblGenericName;
    Caption = 'Generic Name';
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
        //             ReleaseToCompany: Codeunit "Release to Company";
        //         begin
        //             ReleaseToCompany.ReleaseGenericNameToCompany(Rec);
        //         end;
        //     }
        // }
    }

    var
        myInt: Integer;
}