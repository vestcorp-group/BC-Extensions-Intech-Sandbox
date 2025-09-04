query 53007 "API - Vendor"//T12370-Full Comment //T50051 Code Uncommented
{
    QueryType = API;
    APIPublisher = 'KempexCustom';
    APIGroup = 'app1';
    APIVersion = 'v1.0';
    Caption = 'BI Vendor', Locked = true;
    EntityName = 'Vendor';
    EntitySetName = 'Vendor';

    elements
    {
        dataitem(Vendor; Vendor)
        {
            column(No_; "No.")
            {
                Caption = 'No.', Locked = true;
            }
            column(name; Name)
            {
                Caption = 'Name', Locked = true;
            }
            column(Address; Address)
            {
                Caption = 'Address', Locked = true;
            }
            column(Address_2; "Address 2")
            {
                Caption = 'Address 2', Locked = true;
            }
            column(City; City)
            {
                Caption = 'City', Locked = true;
            }
            column(Contact; Contact)
            {
                Caption = 'Contact', Locked = true;
            }
            column(Territory_Code; "Territory Code")
            {
                Caption = 'Territory Code', Locked = true;
            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
                Caption = 'Global Dimension 1', Locked = true;
            }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            {
                Caption = 'Global Dimension 2', Locked = true;
            }
            column(Vendor_Posting_Group; "Vendor Posting Group")
            {
                Caption = 'Vendor Posting Group', Locked = true;
            }
            column(Currency_Code; "Currency Code")
            {
                Caption = 'Currency Code', Locked = true;
            }
            column(Payment_Terms_Code; "Payment Terms Code")
            {
                Caption = 'Payment Terms', Locked = true;
            }
            column(Purchaser_Code; "Purchaser Code")
            {
                Caption = 'Purchaser', Locked = true;
            }
            column(Payment_Method_Code; "Payment Method Code")
            {
                Caption = 'Payment Method', Locked = true;
            }
            column(ICPartner; "IC Company Code")
            {
                Caption = 'ICPartner', Locked = true;
            }

        }
    }
}