tableextension 75021 TaxAccountingPeriodExt_75021 extends "Tax Accounting Period"
{
    //I-C0059-1001707-01-NS - Create new Field
    fields
    {
        field(75021; "TDS Receivable Account"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}
