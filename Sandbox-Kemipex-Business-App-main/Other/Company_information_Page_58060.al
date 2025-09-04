pageextension 58060 CompanyInfo extends "Company Information"//T12370-Full Comment
{
    layout
    {

        //         addafter(Picture)
        //         {
        //             field(Company_Classification; rec.Company_Classification)
        //             {
        //                 Caption = 'Company Classification';
        //                 ApplicationArea = all;
        //             }
        //         }

        //         addafter("License No.")
        //         {
        //             field("Registration No.1"; rec."Registration No.")
        //             {
        //                 ApplicationArea = all;
        //                 Caption = 'Registration No.';
        //             }
        //         }
        //         modify("Registration No. Cust.")
        //         {
        //             Visible = false;
        //         }
        //         modify("License No. Cust.")
        //         {
        //             Visible = false;
        //         }
        //Gross Profit
        addbefore("User Experience")
        {
            group("Gross Profit Report")
            {
                field("Gross Profit Webservice URL"; Rec."Gross Profit Webservice URL")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Webservice Name"; Rec."Webservice Name")
                {
                    ApplicationArea = All;
                }
                field("Webserive Username"; Rec."Webserive Username")
                {
                    ApplicationArea = All;
                }
                field("Webservice Key"; Rec."Webservice Key")
                {
                    ApplicationArea = All;
                }
                field("Client ID"; Rec."Client ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Client ID field.', Comment = '%';
                }
                field("Secret ID"; Rec."Secret ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Secret ID field.', Comment = '%';
                }
                //IC API -NS
                field("IC Tenant ID"; Rec."IC Tenant ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the IC Tenant ID field.', Comment = '%';
                }
                field("IC Tenant Name"; Rec."IC Tenant Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the InterCompany Tenant Name field.', Comment = '%';
                }
                //IC API -NE
            }
        }

        //Stamp
        addafter(Picture)
        {
            //Stamp
            field(Stamp; Rec.Stamp)
            {
                ApplicationArea = All;
            }
            field(Logo; Rec.Logo)
            {
                ApplicationArea = All; //Hypercare
            }
        }
    }

}