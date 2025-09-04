Codeunit 75027 "Common Function DE"
{

    trigger OnRun()
    var
        InputValue_lTxt: Text;
        n: Integer;
        i: Integer;
        OutputString: Text;
    begin


    end;

    var
        Text021_gTxt: label 'Select a Folder...';
        Text022_gTxt: label 'Shared Directory does not exists: %1';
        Text024_gTxt: label 'Export Attachment';
        Text025_gTxt: label 'File - %1 attached successfully.';
        DateFormat_gOpt: Option "YYYY-MM-DD","DD-MM-YYYY","MM-DD-YYYY","DD-MMM-YY";


    procedure "---------- General -----------"()
    begin
    end;





    procedure UpdatePath_gFnc(var Path_vTxt: Text[250])
    begin
        if CopyStr(Path_vTxt, StrLen(Path_vTxt), 1) <> '\' then
            Path_vTxt := Path_vTxt + '\';
    end;





    procedure AddNewLineChar_gFnc(FirstText_iTxt: Text; SecondText_iTxt: Text): Text
    var
        Ch: Text[2];
    begin
        Ch[1] := 13; // CR - Carriage Return
        Ch[2] := 10; // LF - Line Feed
        exit(FirstText_iTxt + Ch + SecondText_iTxt)
    end;


    procedure CleanCRLFTAB_gFnc(var InputTxt_vTxt: Text[250])
    var
        Ch: Text[3];
    begin
        //DELETE TAB Char

        Ch[1] := 9;  // TAB
        Ch[2] := 13; // CR - Carriage Return
        Ch[3] := 10; // LF - Line Feed
        InputTxt_vTxt := DelChr(InputTxt_vTxt, '=', Ch);
    end;


    procedure ReplaceString_gFnc(var IPString_vTxt: Text; FindSrting_iTxt: Text; ReplaceString_iTxt: Text)
    var
        AantalPos: Integer;
        Deel1: Text;
        Deel2: Text;
    begin
        if StrPos(IPString_vTxt, FindSrting_iTxt) = 0 then
            exit;

        AantalPos := StrPos(IPString_vTxt, FindSrting_iTxt);
        if AantalPos <> 0 then begin
            if AantalPos > 1 then
                Deel1 := CopyStr(IPString_vTxt, 1, AantalPos - 1);
            if AantalPos <> StrLen(IPString_vTxt) - (StrLen(FindSrting_iTxt) - 1) then
                Deel2 := CopyStr(IPString_vTxt, AantalPos + StrLen(FindSrting_iTxt));

            IPString_vTxt := Deel1 + ReplaceString_iTxt + Deel2;
        end;

        if StrPos(IPString_vTxt, FindSrting_iTxt) = 0 then
            exit;

        ReplaceString_gFnc(IPString_vTxt, FindSrting_iTxt, ReplaceString_iTxt);
    end;





    procedure DeleteInvChar_gFnc(var Input_vTxt: Text)
    begin
        Input_vTxt := DelChr(Input_vTxt, '=', '#%&*:<>?\/{|}~,');
    end;


    procedure CheckAllowedChar_gFnc(var Description_vTxt: Text)
    var
        AllowedChars_ltxt: Text[250];
        RemChkString_lTxt: Text;
    begin
        AllowedChars_ltxt := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'; // string with all allowed characters
        RemChkString_lTxt := DelChr(Description_vTxt, '=', AllowedChars_ltxt);
        if RemChkString_lTxt <> '' then
            Error('Characters "%1" are not allowed', RemChkString_lTxt);
    end;


    procedure KeepOnlyRequireChar_gFnc(var InputValue_vTxt: Text)
    var
        IntialInputValue_lTxt: Text;
        AllowedChars_ltxt: Text[250];
    begin
        IntialInputValue_lTxt := InputValue_vTxt;
        AllowedChars_ltxt := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,* -_+/'; // string with all allowed characters
        InputValue_vTxt := DelChr(IntialInputValue_lTxt, '=', DelChr(IntialInputValue_lTxt, '=', AllowedChars_ltxt));
        InputValue_vTxt := DelChr(InputValue_vTxt, '<>', ' ');
    end;


    procedure GetUserName_gFnc(USERID_iCod: Code[50]): Text[50]
    var
        User_lRec: Record User;
    begin
        User_lRec.Reset;
        User_lRec.SetRange("User Name", USERID_iCod);
        if not User_lRec.FindFirst then
            exit(USERID_iCod);

        if User_lRec."Full Name" <> '' then
            exit(User_lRec."Full Name")
        else
            exit(USERID_iCod);
    end;


    procedure GetMonthYearFromDate_gFnc(Date_iDte: Date): Text[100]
    var
        Month_lInt: Integer;
        Year_lInt: Integer;
        Month_lTxt: Text[20];
        ExportValue_lTxt: Text;
    begin
        Month_lInt := Date2dmy(Date_iDte, 2);
        Year_lInt := Date2dmy(Date_iDte, 3);

        Month_lTxt := GetMonthText_gFnc(Month_lInt);

        exit(Format(Month_lTxt) + '-' + Format(Year_lInt));   // MAR-2015
    end;


    procedure GetMonthYearDateFromDate_gFnc(Date_iDte: Date): Text[100]
    var
        Month_lInt: Integer;
        Year_lInt: Integer;
        Date_lInt: Integer;
        Month_lTxt: Text[20];
        ExportValue_lTxt: Text;
    begin
        Month_lInt := Date2dmy(Date_iDte, 2);
        Year_lInt := Date2dmy(Date_iDte, 3);
        Date_lInt := Date2dmy(Date_iDte, 1);

        Month_lTxt := GetMonthText_gFnc(Month_lInt);

        exit(Format(Month_lTxt) + ' ' + Format(Date_lInt) + ',' + Format(Year_lInt));  // MAR 31,2015
    end;


    procedure GetMonthText_gFnc(Month_iInt: Integer): Text[20]
    begin
        case Month_iInt of
            1:
                exit('JAN');
            2:
                exit('FEB');
            3:
                exit('MAR');
            4:
                exit('APR');
            5:
                exit('MAY');
            6:
                exit('JUN');
            7:
                exit('JLY');
            8:
                exit('AUG');
            9:
                exit('SEP');
            10:
                exit('OCT');
            11:
                exit('NOV');
            12:
                exit('DEC');
        end;
    end;


    procedure GetFinancialYear_gFnc(Date_iDte: Date): Text[50]
    var
        OrderDateMonth_lInt: Integer;
        OrderDateYear_lInt: Integer;
        FinancialYr_lTxt: Text;
    begin
        OrderDateMonth_lInt := Date2dmy(Date_iDte, 2);
        OrderDateYear_lInt := Date2dmy(Date_iDte, 3);

        if OrderDateMonth_lInt >= 4 then
            exit(Format(OrderDateYear_lInt) + ' - ' + Format(OrderDateYear_lInt + 1))
        else
            exit(Format(OrderDateYear_lInt - 1) + ' - ' + Format(OrderDateYear_lInt));
    end;


    procedure GetFinancialYearWithDate_gFnc(Date_iDte: Date): Text[100]
    var
        OrderDateMonth_lInt: Integer;
        OrderDateYear_lInt: Integer;
        FinancialYr_lTxt: Text;
    begin
        OrderDateMonth_lInt := Date2dmy(Date_iDte, 2);
        OrderDateYear_lInt := Date2dmy(Date_iDte, 3);

        if OrderDateMonth_lInt >= 4 then
            exit(Format(Dmy2date(1, 4, OrderDateYear_lInt)) + ' - ' + Format(Dmy2date(31, 3, OrderDateYear_lInt + 1)))
        else
            exit(Format(Dmy2date(1, 4, OrderDateYear_lInt - 1)) + ' - ' + Format(Dmy2date(31, 3, OrderDateYear_lInt)));
    end;


    procedure GetFYDate_gFnc(Date_iDte: Date; var FYStartDate_vDte: Date; var FYSEndDate_vDte: Date)
    var
        CurrMonth_lInt: Integer;
    begin
        CurrMonth_lInt := Date2dmy(Date_iDte, 2);

        if CurrMonth_lInt in [1, 2, 3] then begin
            FYStartDate_vDte := Dmy2date(1, 4, Date2dmy(Date_iDte, 3) - 1);
            FYSEndDate_vDte := Dmy2date(31, 3, Date2dmy(Date_iDte, 3));
        end else begin
            FYStartDate_vDte := Dmy2date(1, 4, Date2dmy(Date_iDte, 3));
            FYSEndDate_vDte := Dmy2date(31, 3, Date2dmy(Date_iDte, 3) + 1)
        end;
    end;

    local procedure DateFormatNew_gFnc(InputDate_iTxt: Text): Date
    var
        Year_lInt: Integer;
        Month_lInt: Integer;
        Date_lInt: Integer;
        RemText_lTxt: Text;
        FirstValue_lTxt: Text;
        SecondValue_lTxt: Text;
        ThirdValue_lTxt: Text;
        IdentifySeperator_ltxt: Text[1];
    begin
        DateFormat_gOpt := Dateformat_gopt::"DD-MMM-YY";

        if InputDate_iTxt = '' then
            exit;

        case DateFormat_gOpt of
            Dateformat_gopt::"YYYY-MM-DD":
                begin
                    Evaluate(Year_lInt, CopyStr(InputDate_iTxt, 1, 4));
                    Evaluate(Month_lInt, CopyStr(InputDate_iTxt, 6, 2));
                    Evaluate(Date_lInt, CopyStr(InputDate_iTxt, 9, 2));
                    exit(Dmy2date(Date_lInt, Month_lInt, Year_lInt));
                end;
            Dateformat_gopt::"DD-MM-YYYY":  //20-12-2018
                begin
                    Evaluate(Date_lInt, CopyStr(InputDate_iTxt, 1, 2));
                    Evaluate(Month_lInt, CopyStr(InputDate_iTxt, 4, 2));
                    Evaluate(Year_lInt, CopyStr(InputDate_iTxt, 7, 4));
                    exit(Dmy2date(Date_lInt, Month_lInt, Year_lInt));
                end;
            Dateformat_gopt::"MM-DD-YYYY":  //12-20-2018
                begin
                    Evaluate(Date_lInt, CopyStr(InputDate_iTxt, 4, 2));
                    Evaluate(Month_lInt, CopyStr(InputDate_iTxt, 1, 2));
                    Evaluate(Year_lInt, CopyStr(InputDate_iTxt, 7, 4));
                    exit(Dmy2date(Date_lInt, Month_lInt, Year_lInt));
                end;
            Dateformat_gopt::"DD-MMM-YY":  //4-APR-20 or 04-APR-20
                begin
                    if StrPos(InputDate_iTxt, '-') <> 0 then begin
                        IdentifySeperator_ltxt := '-';
                    end else
                        if StrPos(InputDate_iTxt, '/') <> 0 then begin
                            IdentifySeperator_ltxt := '/';
                        end else
                            if StrPos(InputDate_iTxt, '.') <> 0 then begin
                                IdentifySeperator_ltxt := '.';
                            end else
                                Error('Invalid Seperator in date %1', InputDate_iTxt);

                    FirstValue_lTxt := CopyStr(InputDate_iTxt, 1, StrPos(InputDate_iTxt, IdentifySeperator_ltxt) - 1);
                    RemText_lTxt := CopyStr(InputDate_iTxt, StrPos(InputDate_iTxt, IdentifySeperator_ltxt) + 1);
                    SecondValue_lTxt := CopyStr(RemText_lTxt, 1, StrPos(RemText_lTxt, IdentifySeperator_ltxt) - 1);
                    RemText_lTxt := CopyStr(RemText_lTxt, StrPos(RemText_lTxt, IdentifySeperator_ltxt) + 1);
                    ThirdValue_lTxt := RemText_lTxt;

                    Evaluate(Date_lInt, FirstValue_lTxt);
                    Month_lInt := GetMonthValueFromMonthText_gFnc(SecondValue_lTxt);
                    Evaluate(Year_lInt, ThirdValue_lTxt);
                    if Year_lInt < 100 then
                        Year_lInt := Year_lInt + 2000;
                    exit(Dmy2date(Date_lInt, Month_lInt, Year_lInt));
                end;
            else
                Error('The Date doesnt match any of the specified format');
        end;
    end;

    local procedure DateFormatNewALExtension_gFnc(InputDate_iTxt: Text): Date
    var
        Year_lInt: Integer;
        Month_lInt: Integer;
        Date_lInt: Integer;
        RemText_lTxt: Text;
        FirstValue_lTxt: Text;
        SecondValue_lTxt: Text;
        ThirdValue_lTxt: Text;
        IdentifySeperator_ltxt: Text[1];
    begin
        if InputDate_iTxt = '' then
            exit;

        //3/6/2020 10:51 PM
        InputDate_iTxt := DelChr(InputDate_iTxt, '<>', ' ');  //Trim
        if StrPos(InputDate_iTxt, ' ') <> 0 then
            InputDate_iTxt := CopyStr(InputDate_iTxt, 1, StrPos(InputDate_iTxt, ' ') - 1);  //3/6/2020


        case DateFormat_gOpt of
            Dateformat_gopt::"YYYY-MM-DD":
                begin
                    if StrPos(InputDate_iTxt, '-') <> 0 then begin
                        IdentifySeperator_ltxt := '-';
                    end else
                        if StrPos(InputDate_iTxt, '/') <> 0 then begin
                            IdentifySeperator_ltxt := '/';
                        end else
                            if StrPos(InputDate_iTxt, '.') <> 0 then begin
                                IdentifySeperator_ltxt := '.';
                            end else
                                Error('Invalid Seperator in date %1', InputDate_iTxt);

                    FirstValue_lTxt := CopyStr(InputDate_iTxt, 1, StrPos(InputDate_iTxt, IdentifySeperator_ltxt) - 1);
                    RemText_lTxt := CopyStr(InputDate_iTxt, StrPos(InputDate_iTxt, IdentifySeperator_ltxt) + 1);
                    SecondValue_lTxt := CopyStr(RemText_lTxt, 1, StrPos(RemText_lTxt, IdentifySeperator_ltxt) - 1);
                    RemText_lTxt := CopyStr(RemText_lTxt, StrPos(RemText_lTxt, IdentifySeperator_ltxt) + 1);
                    ThirdValue_lTxt := RemText_lTxt;

                    Evaluate(Date_lInt, ThirdValue_lTxt);
                    Evaluate(Month_lInt, SecondValue_lTxt);
                    Evaluate(Year_lInt, FirstValue_lTxt);
                    if Year_lInt < 100 then
                        Year_lInt := Year_lInt + 2000;
                    exit(Dmy2date(Date_lInt, Month_lInt, Year_lInt));
                end;
            Dateformat_gopt::"DD-MM-YYYY":  //20-12-2018
                begin
                    if StrPos(InputDate_iTxt, '-') <> 0 then begin
                        IdentifySeperator_ltxt := '-';
                    end else
                        if StrPos(InputDate_iTxt, '/') <> 0 then begin
                            IdentifySeperator_ltxt := '/';
                        end else
                            if StrPos(InputDate_iTxt, '.') <> 0 then begin
                                IdentifySeperator_ltxt := '.';
                            end else
                                Error('Invalid Seperator in date %1', InputDate_iTxt);

                    FirstValue_lTxt := CopyStr(InputDate_iTxt, 1, StrPos(InputDate_iTxt, IdentifySeperator_ltxt) - 1);
                    RemText_lTxt := CopyStr(InputDate_iTxt, StrPos(InputDate_iTxt, IdentifySeperator_ltxt) + 1);
                    SecondValue_lTxt := CopyStr(RemText_lTxt, 1, StrPos(RemText_lTxt, IdentifySeperator_ltxt) - 1);
                    RemText_lTxt := CopyStr(RemText_lTxt, StrPos(RemText_lTxt, IdentifySeperator_ltxt) + 1);
                    ThirdValue_lTxt := RemText_lTxt;

                    Evaluate(Date_lInt, FirstValue_lTxt);
                    Evaluate(Month_lInt, SecondValue_lTxt);
                    Evaluate(Year_lInt, ThirdValue_lTxt);
                    if Year_lInt < 100 then
                        Year_lInt := Year_lInt + 2000;
                    exit(Dmy2date(Date_lInt, Month_lInt, Year_lInt));
                end;
            Dateformat_gopt::"MM-DD-YYYY":  //12-20-2018,4-5-2020,4-12-20
                begin

                    if StrPos(InputDate_iTxt, '-') <> 0 then begin
                        IdentifySeperator_ltxt := '-';
                    end else
                        if StrPos(InputDate_iTxt, '/') <> 0 then begin
                            IdentifySeperator_ltxt := '/';
                        end else
                            if StrPos(InputDate_iTxt, '.') <> 0 then begin
                                IdentifySeperator_ltxt := '.';
                            end else
                                Error('Invalid Seperator in date %1', InputDate_iTxt);

                    FirstValue_lTxt := CopyStr(InputDate_iTxt, 1, StrPos(InputDate_iTxt, IdentifySeperator_ltxt) - 1);
                    RemText_lTxt := CopyStr(InputDate_iTxt, StrPos(InputDate_iTxt, IdentifySeperator_ltxt) + 1);
                    SecondValue_lTxt := CopyStr(RemText_lTxt, 1, StrPos(RemText_lTxt, IdentifySeperator_ltxt) - 1);
                    RemText_lTxt := CopyStr(RemText_lTxt, StrPos(RemText_lTxt, IdentifySeperator_ltxt) + 1);
                    ThirdValue_lTxt := RemText_lTxt;

                    Evaluate(Date_lInt, SecondValue_lTxt);
                    Evaluate(Month_lInt, FirstValue_lTxt);
                    Evaluate(Year_lInt, ThirdValue_lTxt);
                    if Year_lInt < 100 then
                        Year_lInt := Year_lInt + 2000;
                    exit(Dmy2date(Date_lInt, Month_lInt, Year_lInt));
                end;
            Dateformat_gopt::"DD-MMM-YY":  //4-APR-20 or 04-APR-20
                begin
                    if StrPos(InputDate_iTxt, '-') <> 0 then begin
                        IdentifySeperator_ltxt := '-';
                    end else
                        if StrPos(InputDate_iTxt, '/') <> 0 then begin
                            IdentifySeperator_ltxt := '/';
                        end else
                            if StrPos(InputDate_iTxt, '.') <> 0 then begin
                                IdentifySeperator_ltxt := '.';
                            end else
                                Error('Invalid Seperator in date %1', InputDate_iTxt);

                    FirstValue_lTxt := CopyStr(InputDate_iTxt, 1, StrPos(InputDate_iTxt, IdentifySeperator_ltxt) - 1);
                    RemText_lTxt := CopyStr(InputDate_iTxt, StrPos(InputDate_iTxt, IdentifySeperator_ltxt) + 1);
                    SecondValue_lTxt := CopyStr(RemText_lTxt, 1, StrPos(RemText_lTxt, IdentifySeperator_ltxt) - 1);
                    RemText_lTxt := CopyStr(RemText_lTxt, StrPos(RemText_lTxt, IdentifySeperator_ltxt) + 1);
                    ThirdValue_lTxt := RemText_lTxt;

                    Evaluate(Date_lInt, FirstValue_lTxt);
                    Month_lInt := GetMonthValueFromMonthText_gFnc(SecondValue_lTxt);
                    Evaluate(Year_lInt, ThirdValue_lTxt);
                    if Year_lInt < 100 then
                        Year_lInt := Year_lInt + 2000;
                    exit(Dmy2date(Date_lInt, Month_lInt, Year_lInt));
                end;
            else
                Error('The Date doesnt match any of the specified format');
        end;
    end;


    procedure GetMonthValueFromMonthText_gFnc(Month_iTxt: Text[10]): Integer
    begin
        case UpperCase(Month_iTxt) of
            'JAN':
                exit(1);
            'FEB':
                exit(2);
            'MAR':
                exit(3);
            'APR':
                exit(4);
            'MAY':
                exit(5);
            'JUN':
                exit(6);
            'JLY':
                exit(7);
            'AUG':
                exit(8);
            'SEP':
                exit(9);
            'OCT':
                exit(10);
            'NOV':
                exit(11);
            'DEC':
                exit(12);
        end;
    end;


    procedure ConvUTCtoIST_gFnc(var DateTime_vDte: DateTime)
    begin
        if DateTime_vDte = 0DT then
            exit;

        DateTime_vDte := DateTime_vDte + 19800000;
    end;


    procedure ConvISTtoUTC_gFnc(var DateTime_vDte: DateTime)
    begin
        if DateTime_vDte = 0DT then
            exit;

        DateTime_vDte := DateTime_vDte - 19800000;
    end;


    procedure CheckSpecialChr_gFnc(InputValue_lTxt: Text)
    begin
        //NG-NS
        if InputValue_lTxt = '' then
            exit;

        if StrPos(InputValue_lTxt, '&') <> 0 then
            Error('You cannot not user sepecial char & in value %1', InputValue_lTxt);

        if StrPos(InputValue_lTxt, '?') <> 0 then
            Error('You cannot not user sepecial char ? in value %1', InputValue_lTxt);

        if StrPos(InputValue_lTxt, '%') <> 0 then
            Error('You cannot not user sepecial char % in value %1', InputValue_lTxt);

        //IF STRPOS(InputValue_lTxt,'.') <> 0 THEN
        //  ERROR('You cannot not user sepecial char . in value %1',InputValue_lTxt);

        if StrPos(InputValue_lTxt, '*') <> 0 then
            Error('You cannot not user sepecial char * in value %1', InputValue_lTxt);

        if StrPos(InputValue_lTxt, '=') <> 0 then
            Error('You cannot not user sepecial char = in value %1', InputValue_lTxt);
        //NG-NE
    end;


    procedure ConvertTextToDate_gFnc(TextDateTime_iTxt: Text[250]; Format_iInt: Integer): DateTime
    var
        ConvertedDateTime_iDT: DateTime;
        DD: Integer;
        MM: Integer;
        YYYY: Integer;
        OnlyDate: Date;
        OnlyTime: Time;
    begin
        if TextDateTime_iTxt = '' then
            exit(0DT);

        ConvertedDateTime_iDT := 0DT;
        case Format_iInt of
            1: //16-03-2018 13:29 PM
                begin
                    if StrLen(TextDateTime_iTxt) >= 10 then begin  //16-03-2018 13:29 PM
                        Evaluate(DD, CopyStr(TextDateTime_iTxt, 1, 2));
                        Evaluate(MM, CopyStr(TextDateTime_iTxt, 4, 2));
                        Evaluate(YYYY, CopyStr(TextDateTime_iTxt, 7, 4));
                        OnlyDate := Dmy2date(DD, MM, YYYY);
                        Evaluate(OnlyTime, CopyStr(TextDateTime_iTxt, 12, 5));

                        ConvertedDateTime_iDT := CreateDatetime(OnlyDate, OnlyTime);
                    end;
                end;
            2: //2017-07-22 13:33:35
                begin
                    if StrLen(TextDateTime_iTxt) >= 10 then begin  //16-03-2018 13:29 PM
                        Evaluate(YYYY, CopyStr(TextDateTime_iTxt, 1, 4));
                        Evaluate(MM, CopyStr(TextDateTime_iTxt, 6, 2));
                        Evaluate(DD, CopyStr(TextDateTime_iTxt, 9, 2));

                        OnlyDate := Dmy2date(DD, MM, YYYY);
                        Evaluate(OnlyTime, CopyStr(TextDateTime_iTxt, 12));

                        ConvertedDateTime_iDT := CreateDatetime(OnlyDate, OnlyTime);
                    end;
                end;
        end;
    end;


    procedure ConvertTextToDateTime_gFnc(TextDateTime_iTxt: Text[250]; Format_iInt: Integer): DateTime
    var
        ConvertedDateTime_iDT: DateTime;
        DD: Integer;
        MM: Integer;
        YYYY: Integer;
        OnlyDate: Date;
        OnlyTime: Time;
    begin
        if TextDateTime_iTxt = '' then
            exit(0DT);

        //2020-09-09 17:27:00

        ConvertedDateTime_iDT := 0DT;
        case Format_iInt of
            1: //16-03-2018 13:29 PM
                begin
                    if StrLen(TextDateTime_iTxt) >= 10 then begin  //16-03-2018 13:29 PM
                        Evaluate(DD, CopyStr(TextDateTime_iTxt, 1, 2));
                        Evaluate(MM, CopyStr(TextDateTime_iTxt, 4, 2));
                        Evaluate(YYYY, CopyStr(TextDateTime_iTxt, 7, 4));
                        OnlyDate := Dmy2date(DD, MM, YYYY);
                        Evaluate(OnlyTime, CopyStr(TextDateTime_iTxt, 12, 5));

                        ConvertedDateTime_iDT := CreateDatetime(OnlyDate, OnlyTime);
                    end;
                end;
            2: //2017-07-22 13:33:35
                begin
                    if StrLen(TextDateTime_iTxt) >= 10 then begin  //16-03-2018 13:29 PM
                        Evaluate(YYYY, CopyStr(TextDateTime_iTxt, 1, 4));
                        Evaluate(MM, CopyStr(TextDateTime_iTxt, 6, 2));
                        Evaluate(DD, CopyStr(TextDateTime_iTxt, 9, 2));

                        OnlyDate := Dmy2date(DD, MM, YYYY);
                        Evaluate(OnlyTime, CopyStr(TextDateTime_iTxt, 12));

                        ConvertedDateTime_iDT := CreateDatetime(OnlyDate, OnlyTime);
                    end;
                end;
        end;
        exit(ConvertedDateTime_iDT);
    end;


    procedure GetNoOfMonthsBtwTwoDate_gFnc(StartDate: Date; EndDate: Date): Integer
    var
        Date: Record Date;
        i: Integer;
    begin
        //https://andreilungu.com/allocate-amounts-considering-two-dates/
        //second method. Advantage: if needed you can Mark the periods in the Date record
        //and return the marked periods using a byReference parameter
        StartDate := CalcDate('<CM +1D>', StartDate);
        EndDate := CalcDate('<CM +1D>', EndDate);
        Date.SetRange("Period Start", StartDate, EndDate);
        Date.FindSet;
        repeat
            StartDate := CalcDate('<CM +1D>', Date."Period Start");
            Date.SetRange("Period Start", StartDate, EndDate);
            i += 1;
        until (Date.Next = 0) or (StartDate > EndDate);

        exit(i - 1);
    end;





    procedure GetMonthDiff_gFnc(StartDate_iDte: Date; EndDate_iDte: Date): Integer
    var
        g1: Integer;
        m1: Integer;
        d1: Integer;
        m1days: Integer;
        g2: Integer;
        m2: Integer;
        d2: Integer;
        g: Integer;
        m: Integer;
        d: Integer;
        FD_lDte: Date;
        LD_lDte: Date;
        TotalMonth_lInt: Integer;
    begin
        if StartDate_iDte > EndDate_iDte then begin
            exit(0);
        end;

        if (StartDate_iDte = 0D) or (EndDate_iDte = 0D) then
            exit(0);

        g1 := Date2dmy(StartDate_iDte, 3);
        m1 := Date2dmy(StartDate_iDte, 2);
        d1 := Date2dmy(StartDate_iDte, 1);

        FD_lDte := Dmy2date(1, m1, g1);
        LD_lDte := CalcDate('CM', FD_lDte);
        m1days := Date2dmy(LD_lDte, 1);   //LastDayOfMonth(g1, m1);    // Simple function to find last day of month using Date table

        g2 := Date2dmy(EndDate_iDte, 3);
        m2 := Date2dmy(EndDate_iDte, 2);
        d2 := Date2dmy(EndDate_iDte, 1);

        if d2 < d1 then begin
            d2 += m1days;
            m2 -= 1;
        end;
        d := d2 - d1;

        if m2 < m1 then begin
            m2 += 12;
            g2 -= 1;
        end;
        m := m2 - m1;

        g := g2 - g1;

        TotalMonth_lInt := (g * 12) + m;
        exit(TotalMonth_lInt);
        //ERROR('%1',TotalMonth_lInt);

        //ERROR(CONVERTSTR(FORMAT(g, 2) + '-' + FORMAT(m, 2) + '-' + FORMAT(d, 2), ' ', '0'));  //This Return Year - Month - Day Diff
    end;

    local procedure GetRecordFromRecordID_gFnc()
    var
        ApprovalEntry_lRec: Record "Approval Entry";
        RecRef_lRecRef: RecordRef;
        FieldRef_lFrf: FieldRef;
        GenLine_lRec: Record "Gen. Journal Line";
        GenJournalBatch_lRec: Record "Gen. Journal Batch";
        GenJnlManagement: Codeunit GenJnlManagement;
        RecIDToImport: RecordID;
        CustLedgerEntry_lRec: Record "Cust. Ledger Entry";
    begin
        //MESSAGE(FORMAT(ApprovalEntry_lRec."Record ID to Approve"));  //Gen. Journal Line: BANK PAYME,ADITYA-ESC,10000

        //Record Ref Function

        if ApprovalEntry_lRec."Table ID" = 81 then begin
            RecRef_lRecRef.Get(ApprovalEntry_lRec."Record ID to Approve");
            FieldRef_lFrf := RecRef_lRecRef.Field(1);  //Journal Template Name
            GenLine_lRec."Journal Template Name" := FieldRef_lFrf.Value;

            RecRef_lRecRef.Get(ApprovalEntry_lRec."Record ID to Approve");
            FieldRef_lFrf := RecRef_lRecRef.Field(51);  //Journal Batch Name
            GenLine_lRec."Journal Batch Name" := FieldRef_lFrf.Value;

            RecRef_lRecRef.Get(ApprovalEntry_lRec."Record ID to Approve");
            FieldRef_lFrf := RecRef_lRecRef.Field(2);  //Line No.
            GenLine_lRec."Line No." := FieldRef_lFrf.Value;

            GenJournalBatch_lRec.Get(GenLine_lRec."Journal Template Name", GenLine_lRec."Journal Batch Name");
            GenJnlManagement.TemplateSelectionFromBatch(GenJournalBatch_lRec);
        end;


        //T24352-NS
        //Check the Table Number from Record ID and Get the Rec Reference and Field Reference from it
        if RecIDToImport.TableNo in [21, 25, 36, 38, 454, 5062, 50005, 33029480, 33029801, 33029990] then begin
            if RecRef_lRecRef.Get(RecIDToImport) then begin
                FieldRef_lFrf := RecRef_lRecRef.Field(50462);
                FieldRef_lFrf.Value(true);
                RecRef_lRecRef.Modify;
            end;
        end;
        //T24352-NE

        //Also we can get the Direct table record using the Record ID if we have record id field

        if CustLedgerEntry_lRec.Get(RecIDToImport) then begin
            CustLedgerEntry_lRec.Open := true;
            CustLedgerEntry_lRec.Modify(true);
            //MESSAGE('%1',CustLedgerEntry_lRec."Entry No.");
        end;

        //You can direct use RecordRef Variable to Direct Set on Record and Use all Record Value
        RecRef_lRecRef.SetTable(GenLine_lRec);
    end;


    procedure "-------- Send Email ---------"()
    begin
    end;

    procedure FormatMailDate_gFnc(Date_iDte: Date): Text
    begin
        exit(Format(Date_iDte, 0, '<Day,2>/<Month,2>/<Year>'));
    end;


    procedure "--------- Attachment --------"()
    begin
    end;


    procedure ImportAttachemt_gFnc(RequestNo_iCod: Code[20]; RecordIF_iRecID: RecordID)
    var
        CompanyInformation_lRec: Record "Company Information";
        ImportFile_lTxt: Text[250];
        FileName_lTxt: Text[250];
    begin
        CompanyInformation_lRec.Get;
        //CompanyInformation_lRec.TESTFIELD("Shared Directory");
        //CheckDirExists_gFnc(CompanyInformation_lRec."Shared Directory");
        //ImportFile_lTxt := ImportFile_gFnc(CompanyInformation_lRec."Shared Directory",RequestNo_iCod,FileName_lTxt);
        if ImportFile_lTxt <> '' then begin
            InsertRecordLink_gFnc(RecordIF_iRecID, ImportFile_lTxt, FileName_lTxt);
            Message(Text025_gTxt, FileName_lTxt)
        end;
    end;


    procedure InsertRecordLink_gFnc(RecordID_iRecID: RecordID; ImportFilePath_iTxt: Text[250]; ImportFileName_iTxt: Text[250])
    var
        RecLink_lRec: Record "Record Link";
    begin
        RecLink_lRec.Init;
        RecLink_lRec."Record ID" := RecordID_iRecID;
        RecLink_lRec.URL1 := ImportFilePath_iTxt;
        RecLink_lRec.Description := ImportFileName_iTxt;
        RecLink_lRec.Type := RecLink_lRec.Type::Link;
        RecLink_lRec.Created := CurrentDatetime;
        RecLink_lRec."User ID" := UserId;
        RecLink_lRec.Company := COMPANYNAME;
        RecLink_lRec.Insert(true);
    end;



    local procedure "-------SalaryHR----------"()
    begin
    end;


    procedure GetNewLineNo_gFnc(TemplateName_iCod: Code[10]; BatchName_iCod: Code[10]): Integer
    var
        GenJournalLine_lRec: Record "Gen. Journal Line";
    begin
        //SalaryHR-NS
        GenJournalLine_lRec.Reset;
        GenJournalLine_lRec.SetRange("Journal Template Name", TemplateName_iCod);
        GenJournalLine_lRec.SetRange("Journal Batch Name", BatchName_iCod);
        if GenJournalLine_lRec.FindLast then
            exit(GenJournalLine_lRec."Line No." + 10000)
        else
            exit(10000);
        //SalaryHR-NE
    end;


    procedure DateWithMonthText2_gFnc(Date_iDte: Date): Text
    begin
        //EXIT(FORMAT(DATE2DMY(Date_iDte,1)) + '-' + FORMAT(Date_iDte,0,'<Month Text>') + ' (Year: ' + FORMAT(DATE2DMY(Date_iDte,3)) + ')');
        exit(Format(Date2dmy(Date_iDte, 1)) + '-' + Format(Date_iDte, 0, '<Month Text>') + '-' + Format(Date2dmy(Date_iDte, 3)));
    end;


    procedure AmountFormatEmail_gFnc(Decimal_iDec: Decimal): Text
    begin
        exit(Format(ROUND(Decimal_iDec, 0.01), 0, '<Precision,2><sign><Integer Thousand><Decimals,3>'));  //T2897
    end;

    local procedure "----DeleteSpecialChr------"()
    begin
    end;



    local procedure DeleteNewLineChar_lFnc(var InputTxt_vTxt: Text)
    var
        CRLF_lTxt: Text[10];
        TAB_lTxt: Text[10];
    begin
        //Delete TAB and New line character
        CRLF_lTxt[1] := 10;
        CRLF_lTxt[2] := 13;
        TAB_lTxt[1] := 9;
        InputTxt_vTxt := DelChr(InputTxt_vTxt, '=', CRLF_lTxt);
        InputTxt_vTxt := DelChr(InputTxt_vTxt, '=', TAB_lTxt);
    end;

    local procedure "-------- Regular Expersion Validation ------"()
    begin
    end;





    local procedure "-------- Calender Function ----------"()
    begin
    end;

    local procedure GetBackwordDate(CalCode_iCod: Code[10]; DF_iDF: DateFormula; InputDate_iDte: Date): Date
    var
        FirstTempCalDate_lDte: Date;
        Cnt_lInt: Integer;
        SecondTempDate_lDte: Date;
        FinalCalDate_lDte: Date;
    begin
        FirstTempCalDate_lDte := CalcDate(DF_iDF, InputDate_iDte);
        Cnt_lInt := FirstTempCalDate_lDte - InputDate_iDte;
        if Cnt_lInt <= 0 then
            exit(InputDate_iDte);

        SecondTempDate_lDte := InputDate_iDte;
        while (Cnt_lInt > 0) do begin
            SecondTempDate_lDte -= 1;
            if not CheckDateStatus(CalCode_iCod, SecondTempDate_lDte) then begin
                Cnt_lInt -= 1;
            end;
        end;

        exit(SecondTempDate_lDte);
    end;

    local procedure GetForwordDate(CalCode_iCod: Code[10]; DF_iDF: DateFormula; InputDate_iDte: Date): Date
    var
        FirstTempCalDate_lDte: Date;
        Cnt_lInt: Integer;
        SecondTempDate_lDte: Date;
        FinalCalDate_lDte: Date;
    begin
        FirstTempCalDate_lDte := CalcDate(DF_iDF, InputDate_iDte);
        Cnt_lInt := FirstTempCalDate_lDte - InputDate_iDte;
        if Cnt_lInt <= 0 then
            exit(InputDate_iDte);

        SecondTempDate_lDte := InputDate_iDte;
        while (Cnt_lInt > 0) do begin
            SecondTempDate_lDte += 1;
            if not CheckDateStatus(CalCode_iCod, SecondTempDate_lDte) then begin
                Cnt_lInt -= 1;
            end;
        end;

        exit(SecondTempDate_lDte);
    end;


    procedure CheckDateStatus(CalendarCode: Code[10]; TargetDate: Date): Boolean
    var
        BaseCalChange: Record "Base Calendar Change";
    begin
        BaseCalChange.Reset;
        BaseCalChange.SetRange("Base Calendar Code", CalendarCode);
        if BaseCalChange.FindSet then
            repeat
                case BaseCalChange."Recurring System" of
                    BaseCalChange."recurring system"::" ":
                        if TargetDate = BaseCalChange.Date then begin
                            exit(BaseCalChange.Nonworking);
                        end;
                    BaseCalChange."recurring system"::"Weekly Recurring":
                        if Date2dwy(TargetDate, 1) = BaseCalChange.Day then begin
                            exit(BaseCalChange.Nonworking);
                        end;
                    BaseCalChange."recurring system"::"Annual Recurring":
                        if (Date2dmy(TargetDate, 2) = Date2dmy(BaseCalChange.Date, 2)) and
                           (Date2dmy(TargetDate, 1) = Date2dmy(BaseCalChange.Date, 1))
                        then begin
                            exit(BaseCalChange.Nonworking);
                        end;
                end;
            until BaseCalChange.Next = 0;
    end;

    local procedure "-------DateTime-------"()
    begin
    end;

    local procedure CalculateUnixTimeStamp_gFnc(Duration: Integer)
    var
        NoOfDays: Decimal;
        RemDur: Decimal;
        StartDate: Date;
        StartTime: Time;
        EndDate: Date;
        EndTime: Time;
    begin
        StartDate := 20700101D;
        StartTime := 000000T;

        //Duration in Seconds
        if Duration = 0 then begin
            EndDate := StartDate;
            EndTime := StartTime;
            exit;
        end;

        NoOfDays := Duration DIV 86400;
        RemDur := Duration - (NoOfDays * 86400);

        EndTime := StartTime + (RemDur * 1000);
        EndDate := StartDate + NoOfDays;

        if EndTime < StartTime then
            EndDate := EndDate + 1;

        Message('%1 %2', EndDate, EndTime);
    end;


    procedure GetDateTimeToUnixTimeStap_gFnc(dt: DateTime): BigInteger
    var
        myTime: Time;
        seconds: Integer;
        minutes: Integer;
        hours: Integer;
        days: Integer;
    begin
        dt -= GetUTCOffset();
        myTime := Dt2Time(dt);
        Evaluate(hours, Format(myTime, 0, '<Hours24,2>'));
        Evaluate(minutes, Format(myTime, 0, '<Minutes,2>'));
        Evaluate(seconds, Format(myTime, 0, '<Seconds,2>'));
        days := (Dt2Date(dt) - Dmy2date(1, 1, 1970));
        exit(days * 24 * 60 * 60 + hours * 60 * 60 + minutes * 60 + seconds);
    end;

    local procedure GetUTCOffset(): Integer
    var
        lLocalTime: Time;
        lUTCTime: Time;
        lDateTimeTxt: Text;
        lTimeTxt: Text;
    begin
        Evaluate(lLocalTime, '17:00');
        lDateTimeTxt := Format(CreateDatetime(Today(), lLocalTime), 0, 9);
        lTimeTxt := CopyStr(lDateTimeTxt, StrPos(lDateTimeTxt, 'T') + 1);
        lTimeTxt := CopyStr(lTimeTxt, 1, StrLen(lTimeTxt) - 1);
        Evaluate(lUTCTime, lTimeTxt);
        exit((lLocalTime - lUTCTime));
    end;

    local procedure CalNoofMinutesBetweenTwoTime_lFnc()
    var
        DurationOfTime_lDUr: Duration;
        CalculatedMin_lDec: Decimal;
        StartTime_lTime: Time;
        EndTime_lTime: Time;
    begin
        //NG-NS 190421
        if StartTime_lTime = 0T then
            exit;

        if EndTime_lTime = 0T then
            exit;

        DurationOfTime_lDUr := EndTime_lTime - StartTime_lTime;
        CalculatedMin_lDec := ((DurationOfTime_lDUr / 1000) / 60);  //Convert to Minutes
        CalculatedMin_lDec := ROUND(CalculatedMin_lDec, 1);
        //NG-NE 190421
    end;

    local procedure MakeSDED_And_WhileLoop_ForMonth_lFnc()
    begin
        /*   //For Example done in pluga ticket - T24062
        EnDate_gDte := 0D;
        IF StartDate_gDte <> 0D THEN
          StartDate_gDte := CALCDATE('-CM',StartDate_gDte);
        
        EnDate_gDte  := CALCDATE('CM',EnDate_gDte);
        
        CalDate_lDate := StartDate_gDte;
        WHILE(CalDate_lDate < EnDate_gDte) DO BEGIN
          MS_lDte := CalDate_lDate;
          ME_lDte := CALCDATE('CM',MS_lDte);
        
          MakeExcelDataBody_lFnc;
        
          CalDate_lDate := CALCDATE('1M',CalDate_lDate);  //Last
        END;
        */
        //T24062-NE

    end;
}
