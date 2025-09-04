pageextension 58083 paymenttermspg extends "Payment Terms"//T12370-Full Comment
{
    layout
    {
        addafter("Due Date Calculation")
        {
            field("Advance Payment"; rec."Advance Payment")
            {
                ApplicationArea = all;
            }
            //12-10-2022-start
            field(DL; Rec.DL)
            {
                ApplicationArea = All;
            }
            field(LC; Rec.LC)
            {
                ApplicationArea = All;
            }
            //12-10-2022-end
            field("Management Approval"; rec."Management Approval")
            {
                ApplicationArea = all;
            }
            field("Sales Blocked"; rec."Sales Blocked")
            {
                ApplicationArea = all;
            }
        }
        modify("Discount %")
        {
            Visible = false;
        }
        modify("Discount Date Calculation")
        {
            Visible = false;
        }
        modify("Calc. Pmt. Disc. on Cr. Memos")
        {
            Visible = false;
        }
    }
    // actions
    // {
    //     addfirst(Creation)
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
    //     moveafter(Release; "T&ranslation")
    //     // Add changes to page actions here
    // }
    var
        myInt: Integer;
}