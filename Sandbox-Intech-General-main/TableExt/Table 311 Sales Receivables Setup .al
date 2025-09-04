
tableextension 74992 Sales_Receivables_Setup_74992 extends "Sales & Receivables Setup"
{

    fields
    {
        //PostOption-NS
        field(74981; "Enable only Ship-Receive Sales"; Boolean)
        {
            Caption = 'Enable only Ship-Receive Sales';
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
        field(74983; "Enable Sales Preview Post"; Boolean)
        {
            Caption = 'Enable Sales Preview Post';
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
        //CheckGST-NS
        field(74988; "Check GST TCS on Sales Record"; Boolean)
        {
            Caption = 'Check GST & TCS on Sales Record on Release and Post Document';
            DataClassification = ToBeClassified;
        }
        //CheckGST-NE
        //TaxEngine-Optimization-NS
        field(74989; "Skip TE on Sales Entry"; Boolean)
        {
            Caption = 'Skip Tax Engine Run on Sales Order Entry (Data Entry Optimization)';
            DataClassification = ToBeClassified;
        }
        //TaxEngine-Optimization-NE

        //I-C0059-1005707-01-NS
        field(74984; "No. Series Sele. -Quo. To Ord."; Boolean)
        {
            Caption = 'No. Series Sales Quote To Order';
            DataClassification = ToBeClassified;
        }
        //I-C0059-1005707-01-NE
    }

}

