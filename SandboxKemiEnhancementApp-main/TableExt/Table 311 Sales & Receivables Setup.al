tableextension 80023 "Sales&ReceiableSetup_Ext" extends "Sales & Receivables Setup"//T12370-Full Comment //T12724-N
{
    fields
    {
        field(80001; "PI Validity Calculation"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}