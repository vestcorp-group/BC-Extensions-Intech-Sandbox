pageextension 50265 PageExtCompanyInformation extends "Company Information"//T12370-Full Comment
{
    layout
    {
        addafter("E-Mail")
        {
            field("E-Mirsal Code"; rec."E-Mirsal Code")
            {
                ApplicationArea = All;
            }
            field("License No. Cust."; rec."License No. Cust.")
            {
                ApplicationArea = All;
                Caption = 'License No. Cust.';
            }
            field("Registration No. Cust."; rec."Registration No. Cust.")
            {
                ApplicationArea = All;
                Caption = 'Registration No.';
            }
        }
        //addafter("IC Inbox Details")//30-04-2022
        // addlast(Communication)//30-04-2022
        // {
        //     field("Default Profit %"; rec."Default Profit %")
        //     {
        //         ApplicationArea = All;
        //     }
        // }
    }

    actions
    {
        // Add changes to page actions here
        //addafter("Email Account Setup")//30-04-2022
        addlast("System Settings")
        {
            action(doStupid)
            {
                ApplicationArea = all;
                caption = 'get scenario 4';
                Visible = false;

                trigger OnAction()
                var
                    codeunitcode: Codeunit "Elimination Proces";
                begin
                    codeunitcode.forceSecnario4();
                end;
            }
        }
    }

    var
        myInt: Integer;
}