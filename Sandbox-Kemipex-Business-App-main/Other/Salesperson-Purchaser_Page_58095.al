pageextension 58095 Salesperson_page extends "Salesperson/Purchaser Card"//T12370-Full Comment      //T13413-Full UnComment
{

    layout
    {
        addafter("Privacy Blocked")
        {
            field("Sales Blocked"; rec."Sales Blocked")
            {
                ApplicationArea = all;

            }
            field("Purchase Blocked"; rec."Purchase Blocked")
            {
                ApplicationArea = all;
            }
        }
    }
    // actions
    // {


    //     addafter("Create &Interaction")
    //     {
    //         action(Release)
    //         {
    //             Caption = 'Release to Companies';
    //             ApplicationArea = all;
    //             Promoted = true;
    //             PromotedCategory = Process;
    //             PromotedIsBig = true;
    //             trigger OnAction()
    //             var
    //                 myInt: Integer;
    //             begin
    //                 rec.companytransfer(xRec);

    //             end;
    //         }

    //     }
    //     // Add changes to page actions here
    // }
}