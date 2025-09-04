pageextension 50298 KMP_PageExtLocation extends "Location Card"//T12370-Full Comment
{
    // layout
    // {
    //     addafter("Use As In-Transit")
    //     {
    //         field("Production Warehouse"; rec."Production Warehouse")
    //         {
    //             ApplicationArea = all;
    //             Caption = 'Production Warehouse';
    //         }
    //     }
    // }

    actions
    {
        // Add changes to page actions here
        // addfirst(Creation)
        // {
        //     action(Release2)
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
        //             releasetocompany.BlanketReleaseToCompany(rec.RecordId, Rec.Name);
        //             // releasetocompany.ReleaseLocationToCompany(Rec);
        //         end;
        //     }

        addafter("Warehouse Employees")//T51170-N
        {
            action("Quality Assurance Employee")
            {
                ApplicationArea = all;
                Image = Questionaire;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Quality Assurance Employee";
                RunPageLink = "Location Code" = field(Code);
            }
        }
    }
}