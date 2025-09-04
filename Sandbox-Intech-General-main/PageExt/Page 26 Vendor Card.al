pageextension 75053 Vendor_Card_75053 extends "Vendor Card"
{
    layout
    {
        addafter("Search Name")
        {
            //VendInvNoChk-NS
            field("Check Vendor Invoice No. FY"; Rec."Check Vendor Invoice No. FY")
            {
                ApplicationArea = all;
            }
            //VendInvNoChk-NE
        }
    }
}