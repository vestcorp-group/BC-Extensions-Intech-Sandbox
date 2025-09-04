Codeunit 75014 "Get Indian Format"
{
    //IndianFormatAmount

    trigger OnRun()
    begin
        Message('%1  --> %2', 99999, GetIndianFormat_gFnc(99999));
        Message('%1  --> %2', 3434, GetIndianFormat_gFnc(3434));
        Message('%1  --> %2', -9999999.99, GetIndianFormat_gFnc(-9999999.99));
        Message('%1  --> %2', 99922399, GetIndianFormat_gFnc(99922399));
        Message('%1  --> %2', 2332312.23, GetIndianFormat_gFnc(2332312.23));
        Message('%1  --> %2', 22312.2, GetIndianFormat_gFnc(22312.2));
        Message('%1  --> %2', 932312.2343, GetIndianFormat_gFnc(932312.2343));
        Message('%1  --> %2', -333342212.223, GetIndianFormat_gFnc(-333342212.223));
        Message('%1  --> %2', 2332.03, GetIndianFormat_gFnc(2332.03));
        Message('%1  --> %2', 233223211.233, GetIndianFormat_gFnc(233223211.233));
    end;


    procedure GetIndianFormat_gFnc(Amount_iDec: Decimal) RtnValue: Text[50]
    var
        AddMinuSIng_lBln: Boolean;
        i: Integer;
        FromAmt_lDec: Decimal;
        ToAmt_lDec: Decimal;
    begin
        if Amount_iDec < 0 then
            AddMinuSIng_lBln := true;

        Amount_iDec := Abs(ROUND(Amount_iDec, 0.01));
        if Amount_iDec <= 99999.99 then begin  // 1 Lakh
            if AddMinuSIng_lBln then
                RtnValue := '-' + Format(Amount_iDec, 0, '<Precision,2><sign><Integer Thousand><Decimals,3>')
            else
                RtnValue := Format(Amount_iDec, 0, '<Precision,2><sign><Integer Thousand><Decimals,3>');

            exit(RtnValue);
        end;

        if Amount_iDec <= 9999999.99 then begin
            for i := 1 to 99 do begin
                FromAmt_lDec := i * 100000;
                ToAmt_lDec := FromAmt_lDec + 99999.99;

                if (Amount_iDec >= FromAmt_lDec) and (Amount_iDec <= ToAmt_lDec) then begin
                    Amount_iDec := Amount_iDec - FromAmt_lDec;

                    if AddMinuSIng_lBln then
                        RtnValue := '-' + Format(i) + ',' + Format(Amount_iDec, 0, '<Precision,2><sign><Integer Thousand><Decimals,3>')
                    else
                        RtnValue := Format(i) + ',' + Format(Amount_iDec, 0, '<Precision,2><sign><Integer Thousand><Decimals,3>');

                    exit(RtnValue);
                end;
            end;
        end;

        if Amount_iDec > 9999999.99 then begin
            for i := 1 to 99 do begin
                FromAmt_lDec := i * 10000000;
                ToAmt_lDec := FromAmt_lDec + 9999999.99;

                if (Amount_iDec >= FromAmt_lDec) and (Amount_iDec <= ToAmt_lDec) then begin
                    Amount_iDec := Amount_iDec - FromAmt_lDec;

                    if AddMinuSIng_lBln then
                        RtnValue := '-' + Format(i) + ',' + GetIndianFormat_gFnc(Amount_iDec)
                    else
                        RtnValue := Format(i) + ',' + GetIndianFormat_gFnc(Amount_iDec);

                    exit(RtnValue);
                end;
            end;
        end;

        Error('Input Value %1 Invalid', Amount_iDec);
    end;
}

