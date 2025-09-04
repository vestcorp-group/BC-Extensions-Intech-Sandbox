
tableextension 74993 Purchases_Payables_Setup_74993 extends "Purchases & Payables Setup"
{
    fields
    {
        //PostOption-NS
        field(74981; "Enable Ship-Recieve Purchase"; Boolean)
        {
            Caption = 'Enable only Ship-Recieve Purchase';
            DataClassification = ToBeClassified;
        }
        //PostOption-NE

        //StopDelete-NS
        field(74982; "Stop Delete Order on Post"; Boolean)
        {
            Caption = 'Stop Delete Order on Post';
            DataClassification = ToBeClassified;
        }
        //StopDelete-NE

        //PreviewPost-NS
        field(74983; "Enable Purchase Preview Post"; Boolean)
        {
            Caption = 'Enable Purchase Preview Post';
            DataClassification = ToBeClassified;
        }
        //PreviewPost-NE

        //SkipRefNoChk-NS
        field(74987; "Enable Skip Ref Check"; Boolean)
        {
            Caption = 'Enable Skip Check Invoice Reference for Old Invoice Credit Memo';
            DataClassification = ToBeClassified;
        }
        //SkipRefNoChk-NE

        //VendInvNoChk-NS
        field(74988; "Check Vendor Invoice No. FY Wi"; Boolean)
        {
            Caption = 'Check Vendor Invoice No. FY Wi';
            DataClassification = ToBeClassified;
        }
        //VendInvNoChk-NE

        //CheckGST-NS
        field(74989; "Check GST TDS on Purch Record"; Boolean)
        {
            Caption = 'Check GST & TDS on Purcahse Record on Release and Post Document';
            DataClassification = ToBeClassified;
        }
        //CheckGST-NE

        //TaxEngine-Optimization-NS
        field(74990; "Skip TE on Purchase Entry"; Boolean)
        {
            Caption = 'Skip Tax Engine Run on Purchase Order Entry (Data Entry Optimization)';
            DataClassification = ToBeClassified;
        }
        //TaxEngine-Optimization-NE

        //VendorTDSFormEmail-NS
        // field(74991; "Vendor TDS Files Email Tmplt"; Code[30])
        // {
        //     Caption = 'Vendor TDS Files Email Template';
        //     DataClassification = ToBeClassified;
        //     TableRelation = "Email Template";
        // }
        field(74992; "Vendor TDS Files No. Series"; Code[20])
        {
            Caption = 'Vendor TDS Files No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        //VendorTDSFormEmail-NE
    }
}

