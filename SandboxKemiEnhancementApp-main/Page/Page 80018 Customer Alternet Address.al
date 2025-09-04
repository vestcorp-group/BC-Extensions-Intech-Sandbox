page 80018 "Customer Alternet Address"//T12370-Full Comment
{
    PageType = card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Customer Alternet Address";
    Caption = 'Customer Alternate Address';
    // LinksAllowed = false;
    layout
    {
        area(Content)
        {
            group("Customer Alternate Address")
            {
                field(CustomerNo; rec.CustomerNo)
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = all;
                    Caption = 'Alternate Customer Full Name';
                }
                //UK added control to page 01/04/20>>
                field("Alternate Short Name"; rec."Alternate Short Name")
                {
                    ApplicationArea = all;
                    caption = 'Alternate Customer Short Name';
                }
                //UK added control to page 01/04/20<<
                field(Address; rec.Address)
                {
                    ApplicationArea = all;
                    Caption = 'Address 1';
                }
                field(Address2; rec.Address2)
                {
                    ApplicationArea = all;
                    Caption = 'Address 2';
                }
                field("Country/Region Code"; rec."Country/Region Code")
                {
                    ApplicationArea = all;
                    Caption = 'Country';
                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(City; rec.City)
                {
                    ApplicationArea = all;
                    Caption = 'City';
                }
                field(County; rec.County)
                {
                    ApplicationArea = all;
                    Caption = 'State/Province';
                }
                field(PostCode; rec.PostCode)
                {
                    ApplicationArea = all;
                    Caption = 'Post Code';
                }
                field(Contact; rec.Contact)
                {
                    ApplicationArea = all;
                    Caption = 'Contact Name';
                }
                field(PhoneNo; rec.PhoneNo)
                {
                    ApplicationArea = all;
                    Caption = 'Phone No.';
                }
                field("Mobile No."; rec."Mobile No.")
                {
                    ApplicationArea = all;
                }
                field(Email; rec.Email)
                {
                    ApplicationArea = all;
                    Caption = 'Email';
                }
                field(FaxNo; rec.FaxNo)
                {
                    ApplicationArea = all;
                    Caption = 'Fax No.';
                }
                field(Website; rec.Website)
                {
                    ApplicationArea = all;
                    Caption = 'Website';
                }
                // field(telextNo; telextNo)
                // {
                //     ApplicationArea = all;
                //     Caption = 'Telex No.';
                // }
                field("Customer TRN"; rec."Customer TRN")
                {
                    ApplicationArea = all;
                    Caption = 'Customer TRN';
                }
                field("Customer Registration Type"; rec."Customer Registration Type")
                {
                    ApplicationArea = all;
                }
                field("Customer Registration No."; rec."Customer Registration No.")
                {
                    ApplicationArea = all;
                }
            }
        }

    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //  message('%1', Rec.CustomerNo);

    end;

    var
        myInt: Integer;

        CustNo: Code[20];
}