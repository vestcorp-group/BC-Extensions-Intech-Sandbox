pageextension 50116 CompInfoExt extends "Company Information"//T12370-Full Comment
{
    layout
    {
        addlast(General)
        {

            field("Enable GST caption"; Rec."Enable GST caption")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Enable GST caption field.', Comment = '%';
            }
        }
        // Add changes to page layout here
        addafter("Address 2")
        {
            //     field("Registration No New"; rec."Registration No New")
            //     {
            //         ApplicationArea = all;

            //     }
            field("LUT ARN No"; rec."LUT ARN No")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}