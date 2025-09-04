page 50373 "Shipping Agent Card"//T12370-Full Comment //Code Commented 24-12-24
{

    Caption = 'Shippig Agent Card';
    PageType = Card;
    SourceTable = "Shipping Agent";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Agent Code2"; rec."Agent Code2")
                {
                    ApplicationArea = all;
                }
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field(Address2; Rec.Address2)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Phone No"; Rec."Phone No")
                {
                    ApplicationArea = All;
                }
                field("Contact Code"; rec."Contact Code")
                {
                    ApplicationArea = all;
                }
                field("Contact Name"; Rec."Contact Name")
                {
                    ApplicationArea = All;
                    DrillDown = true;
                }
            }
        }
    }
}
