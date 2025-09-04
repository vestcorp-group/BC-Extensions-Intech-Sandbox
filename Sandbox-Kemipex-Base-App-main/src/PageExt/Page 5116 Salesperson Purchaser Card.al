pageextension 50260 KMP_PagExtSalespeoplePurchaser extends "Salesperson/Purchaser Card"//T12370-Full Comment
{
    layout
    {
        addafter(Name)
        {
            field("Short Name"; rec."Short Name")
            {
                ApplicationArea = all;
            }
        }
        //         addlast(content)
        //         {
        //             part(SalespersonRegion; "Salesperson Customer Groups")
        //             {
        //                 SubPageLink = "Salesperson code" = field(Code);
        //                 ApplicationArea = all;
        //             }
        //         }
        //     }
        //     actions
        //     {
        //         addafter("Create &Interaction")
        //         {
        //             action(Release)
        //             {
        //                 Caption = 'Release to Companies';
        //                 ApplicationArea = all;
        //                 Promoted = true;
        //                 PromotedCategory = Process;
        //                 PromotedIsBig = true;
        //                 trigger OnAction()
        //                 var
        //                     ReleasetoCompany: Codeunit "Release to Company";
        //                 begin
        //                     ReleasetoCompany.ReleaseSalepersontoCompany(Rec);
        //                 end;
        //             }

        //         }
        //         // Add changes to page actions here
    }

    //     var
    //         myInt: Integer;
}