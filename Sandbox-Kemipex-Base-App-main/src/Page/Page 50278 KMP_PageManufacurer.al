page 50278 KMP_PageManufacurer//T12370-N
{
    PageType = List;
    // ApplicationArea = All; as per Yaksh Thakar
    UsageCategory = Administration;
    //SourceTable = KMP_TblCountryOfOrigin;
    SourceTable = KMP_TblManufacturerName;
    //Caption = 'Country Of Origin';
    Caption = 'Manufacturer Name';
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
        //             ReleaseToCompany.ReleaseManufacturerToCompany(Rec);
        //         end;
        //     }
        // }
    }

    var
        myInt: Integer;
}