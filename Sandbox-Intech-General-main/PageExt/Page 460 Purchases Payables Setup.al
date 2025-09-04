pageextension 75047 Purchases_Payables_Setup_75047 extends "Purchases & Payables Setup"
{
    layout
    {

        addafter("Exact Cost Reversing Mandatory")
        {
            //VendInvNoChk-NS
            field("Check Vendor Invoice No. FY Wi"; Rec."Check Vendor Invoice No. FY Wi")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Check Vendor Invoice No. FY Wi field.';
            }
            //VendInvNoChk-NE

            //PreviewPost-NS
            field("Enable Purchase Preview Post"; Rec."Enable Purchase Preview Post")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Enable Purchase Preview Post field.';
            }
            //PreviewPost-NE

            //PostOption-NS
            field("Enable Ship-Recieve Purchase"; Rec."Enable Ship-Recieve Purchase")
            {
                ApplicationArea = All;
            }
            //PostOption-NE

            //StopDelete-NS
            field(" Stop Delete Order on Post"; Rec."Stop Delete Order on Post")
            {
                ApplicationArea = All;
            }
            //StopDelete-NE

            //SkipRefNoChk-NS
            field("Enable Skip Ref Check "; Rec."Enable Skip Ref Check")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Enable Skip Check Invoice Reference for Old Invoice Credit Memo field.';
            }
            //SkipRefNoChk-NE

            //CheckGST-NS
            field("Check GST TDS on Purch Record"; Rec."Check GST TDS on Purch Record")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Check GST & TDS on Purcahse Record on Release and Post Document field.';
            }
            //CheckGST-NE

            //TaxEngine-Optimization-NS
            field("Skip TE on Purchase Entry"; Rec."Skip TE on Purchase Entry")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Skip Tax Engine Run on Purchase Order Entry (Data Entry Optimization) field.';
            }
            //TaxEngine-Optimization-NE

            //VendorTDSFormEmail-NS
            // field("Vendor TDS Files Email Tmplt"; Rec."Vendor TDS Files Email Tmplt")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Vendor TDS Files Email Template field.';
            // }

            field("Vendor TDS Files No. Series"; Rec."Vendor TDS Files No. Series")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Vendor TDS Files No. Series field.';
            }
            //VendorTDSFormEmail-NE
        }

    }
}
