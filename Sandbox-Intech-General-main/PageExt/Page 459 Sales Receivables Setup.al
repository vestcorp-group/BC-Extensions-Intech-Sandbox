pageextension 75046 Sales_Receivables_Setup_75046 extends "Sales & Receivables Setup"
{
    layout
    {

        addafter("Skip Manual Reservation")
        {
            //PostOption-NS
            field("Enable only Ship-Receive Sales"; Rec."Enable only Ship-Receive Sales")
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

            //PreviewPost-NS
            field("Enable Sales Preview Post"; Rec."Enable Sales Preview Post")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Enable Sales Preview Post field.';
            }
            //PreviewPost-NE

            //SkipRefNoChk-NS
            field("Enable Skip Ref Check "; Rec."Enable Skip Ref Check")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Enable Skip Check Invoice Reference for Old Invoice Credit Memo field.';
            }
            //SkipRefNoChk-NE

            //CheckGST-NS
            field("Check GST TCS on Sales Record"; Rec."Check GST TCS on Sales Record")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Check GST & TCS on Sales Record on Release and Post Document field.';
            }

            //CheckGST-NE

            //TaxEngine-Optimization-NS
            field("Skip TE on Sales Entry"; Rec."Skip TE on Sales Entry")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Skip Tax Engine Run on Sales Order Entry (Data Entry Optimization) field.';
            }
            //TaxEngine-Optimization-NE

            //I-C0059-1005707-01-NS
            field("No. Series Sele. -Quo. To Ord."; Rec."No. Series Sele. -Quo. To Ord.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the No. Series Sales Quote To Order field.';
            }
            //I-C0059-1005707-01-NE
        }

    }
}
