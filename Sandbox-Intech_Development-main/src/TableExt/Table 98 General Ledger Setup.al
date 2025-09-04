tableextension 85201 GeneralledgerSetup50147 extends "General Ledger Setup"
{
    fields
    {
        //T13883-NS 270225
        field(74111; "Posting Restriction"; Text[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                DF_lDF: DateFormula;
                LowerString_lTxt: Text;
                LowerDF_lDF: DateFormula;
                HigherString_lTxt: Text;
                HigherDF_lDF: DateFormula;
                AllowPostingFrom_lDte: Date;
                AllowPostingTo_lDte: Date;
            begin
                if "Posting Restriction" <> '' then begin
                    "Posting Restriction" := DelChr("Posting Restriction", '=', ' ');
                    if StrPos("Posting Restriction", '..') <> 0 then begin
                        LowerString_lTxt := CopyStr("Posting Restriction", 1, StrPos("Posting Restriction", '..') - 1);
                        if not Evaluate(LowerDF_lDF, LowerString_lTxt) then
                            Error('Enter Correct Date Formula like -1D OR 1D Or you can enter range like : -1D..1D');

                        HigherString_lTxt := CopyStr("Posting Restriction", StrPos("Posting Restriction", '..') + 1);
                        if not Evaluate(HigherDF_lDF, HigherString_lTxt) then
                            Error('Enter Correct Date Formula like -1D OR 1D Or you can enter range like : -1D..1D');

                        AllowPostingFrom_lDte := CalcDate(LowerDF_lDF, Today);
                        AllowPostingTo_lDte := CalcDate(HigherDF_lDF, Today);

                        if AllowPostingFrom_lDte > AllowPostingTo_lDte then
                            Error('Lower Range Date Formula must be smaller then Higher Date Formula, Please enter the correct value like: -1D..1D');

                    end else begin
                        if not Evaluate(DF_lDF, "Posting Restriction") then
                            Error('Enter Correct Date Formula like -1D OR 1D Or you can enter range like : -1D..1D')
                    end;
                end;
            end;
        }
        //T13883-NE 270225
    }

}