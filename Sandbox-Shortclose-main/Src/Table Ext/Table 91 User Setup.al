tableextension 79652 "Table 91 User Setup" extends "User Setup"
{
    fields
    {
        //T12084-NS
        field(79646; "Allow to Update Short Close PO"; Boolean)
        {
            Caption = 'Allow to Insert/Delete Short Close Purchase Order';
            DataClassification = CustomerContent;
        }
        field(79647; "Allow to Update Short Close SO"; Boolean)
        {
            Caption = 'Allow to Insert/Delete Short Close Sales Order';
            DataClassification = CustomerContent;
        }
        field(79648; "Allow to Update Short Close TO"; Boolean)
        {
            Caption = 'Allow to Insert/Delete Short Close Transfer Order';
            DataClassification = CustomerContent;
        }
        //T12084-NE
    }
}
