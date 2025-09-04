pageextension 75059 TaxAccountingPeriodsExt_50318 extends "Tax Accounting Periods"
{
    //I-C0059-1001707-01-NS - Create new Page
    layout
    {
        addlast(General)
        {
            field("TDS Receivable Account"; Rec."TDS Receivable Account")
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
    }
}
