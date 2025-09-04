pageextension 50371 ShippingAgent extends "Shipping Agents"//T12370-Full Comment //Code Uncommented 24-12-24
{
    layout
    {
        addfirst(content)
        {
            field("Agent Code2"; rec."Agent Code2")
            {
                ApplicationArea = all;
            }
        }
        addafter(Name)
        {

            field(Address; rec.Address)
            {
                ApplicationArea = all;
            }
            field(Address2; rec.Address2)
            {
                ApplicationArea = all;
            }
            field(City; rec.City)
            {
                ApplicationArea = all;
            }
            field(Country; rec.Country)
            {
                ApplicationArea = all;
            }
            field("Phone No"; rec."Phone No")
            {
                ApplicationArea = all;
            }
            field("E-Mail"; rec."E-Mail")
            {
                ApplicationArea = all;
            }
            field("Contact Code"; rec."Contact Code")
            {
                ApplicationArea = all;
            }
            field("Contact Name"; rec."Contact Name")
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
        myInt: Record Customer;
}