page 50372 "Shipping Agents List"//T12370-Full Comment // CodeUcommented 24-12-24
{

    ApplicationArea = All;
    Caption = 'Shipping Agents List';
    PageType = List;
    SourceTable = "Shipping Agent";
    UsageCategory = Administration;
    Editable = false;
    CardPageId = "Shipping Agent Card";

    layout
    {
        area(content)
        {
            repeater(General)
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

                field("Contact Name"; Rec."Contact Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
