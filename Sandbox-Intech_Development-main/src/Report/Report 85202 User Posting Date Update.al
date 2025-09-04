Report 85202 "User Posting Date Update"
{
    //T11452 - NEw Report
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    ApplicationArea = All;

    dataset
    {
        dataitem(US; "User Setup")
        {
            RequestFilterFields = "User ID";
            trigger OnAfterGetRecord()
            var
                DF_lDF: DateFormula;
                LowerString_lTxt: Text;
                LowerDF_lDF: DateFormula;
                HigherString_lTxt: Text;
                HigherDF_lDF: DateFormula;
                AllowPostingFrom_lDte: Date;
                AllowPostingTo_lDte: Date;
            begin
                CurrentRec_gDec += 1;
                Windows_gDlg.Update(2, CurrentRec_gDec);

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
                        Error('Enter Correct Date Formula like -1D OR 1D Or you can enter range like : -1D..1D');

                    AllowPostingFrom_lDte := CalcDate(DF_lDF, Today);
                    AllowPostingTo_lDte := CalcDate(DF_lDF, Today);
                end;

                US."Allow Posting From" := AllowPostingFrom_lDte;
                US."Allow Posting To" := AllowPostingTo_lDte;
                US.Modify();
                Commit();
            end;

            trigger OnPostDataItem()
            begin
                Windows_gDlg.Close;
            end;

            trigger OnPreDataItem()
            begin
                US.SetFilter("Posting Restriction", '<>%1', '');
                Windows_gDlg.Open('Total Record : #1#########\' + 'Current Record : #2##########\');
                Windows_gDlg.Update(1, Count);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Windows_gDlg: Dialog;
        CurrentRec_gDec: Decimal;
}