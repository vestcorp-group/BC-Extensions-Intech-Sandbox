pageextension 50253 KMP_UserSetup extends "User Setup"//T12370-Full Comment
{
    layout
    {
        addlast(Control1)
        {
            // field("Allow Short Close"; rec."Allow Short Close")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies whether the short closure function can be used by the user to close the order.';
            // }
            // field("Document Reopen"; rec."Document Reopen")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the user permission to access the reopen functionality.';
            // }
            // // Start Issue 50
            // field("Allow Sales Unit of Measure"; rec."Allow Sales Unit of Measure")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the user permission to change the unit of measure in sales lines.';
            // }
            // field("Allow Payment Terms on Sales"; rec."Allow Payment Terms on Sales")
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the use permssion to change higher Due date payment terms in Sales documents.';
            // }
            // field("Show Qty. Calculated & BOE"; Rec."Show Qty.Calc.(Counting Sheet)")
            // {
            //     Caption = 'Show Qty. Calculated';
            //     ApplicationArea = All;
            // }
            // field("Skip IC PO Restriction"; Rec."Skip IC PO Restriction")
            // {
            //     Caption = 'Skip IC PO Create Restriction';
            //     ApplicationArea = All;
            //     ToolTip = 'If enabled, When click Send IC Sales Order, system will not check wheather IC PO is Created or Not. This will allow user to create multiple IC PO from same SO.';
            // }
            field("Sales Support User"; rec."Sales Support User")
            {
                ApplicationArea = all;
                Editable = true;
            }

            // Stop Issue 50
        }
    }

    actions
    {
        addfirst(Creation)
        {
            // action(Release)
            // {
            //     Caption = 'Release to Companies';
            //     ApplicationArea = all;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     trigger OnAction()
            //     var
            //         releasetocompany: Codeunit "Release to Company";
            //     begin
            //         releasetocompany.ReleaseUserSetupToCompany(Rec);
            //     end;
            // }

        }


        // Add changes to page actions here
    }

    var
        myInt: Integer;
}