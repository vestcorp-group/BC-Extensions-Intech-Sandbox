codeunit 80011 TextManagement//T12370-Full Comment
{
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var
        TodayText: Label 'TODAY', Comment = 'Must be uppercase hint reuse the transtaltion from cod1 for 2009 sp1';
        WorkdateText: Label 'WORKDATE', Comment = 'Must be uppercase hint reuse the transtaltion from cod1 for 2009 sp1';
        PeriodText: Label 'PERIOD', Comment = 'Must be uppercase hint reuse the transtaltion from cod1 for 2009 sp1';
        YearText: Label 'YEAR', Comment = 'Must be uppercase hint reuse the transtaltion from cod1 for 2009 sp1';
        NumeralOutOfRangeError: Label 'When you specify periods and years, you can use numbers from 1 - 999, such as P-1, P1, Y2 or Y+3.';
        AlphabetText: Label 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', Comment = 'Uppercase - translate into entire alphabet.';
        NowText: Label 'NOW', Comment = 'Must be uppercase.';
        YesterdayText: Label 'YESTERDAY', Comment = 'Must be uppercase';
        TomorrowText: Label 'TOMORROW', Comment = 'Must be uppercase';
        WeekText: Label 'WEEK', Comment = 'Must be uppercase';
        MonthText: Label 'MONTH', Comment = 'Must be uppercase';
        QuarterText: Label 'QUARTER', Comment = 'Must be uppercase';
        UserText: Label 'USER', Comment = 'Must be uppercase';
        MeText: Label 'ME', Comment = 'Must be uppercase';
        MyCustomersText: Label 'MYCUSTOMERS', Comment = 'Must be uppercase';
        MyItemsText: Label 'MYITEMS', Comment = 'Must be uppercase';
        MyVendorsText: Label 'MYVENDORS', Comment = 'Must be uppercase';
        CompanyText: Label 'COMPANY', Comment = 'Must be uppercase';
        OverflowMsg: Label 'The filter contains more than 2000 numbers and has been truncated.';
        UnincrementableStringErr: Label '%1 contains no number and cannot be incremented.';
        FilterType: Option DateTime,Date,Time;

    // [Scope('Personalization')]
    procedure MakeDateTimeText(var DateTimeText: Text): Integer
    var
        Date: Date;
        Time: Time;
    begin
        IF GetSeparateDateTime(DateTimeText, Date, Time) THEN BEGIN
            IF Date = 0D THEN
                EXIT(0);
            IF Time = 0T THEN
                Time := 000000T;
            DateTimeText := FORMAT(CREATEDATETIME(Date, Time));
        END;
        EXIT(0);
    end;

    // [Scope('Personalization')]
    procedure GetSeparateDateTime(DateTimeText: Text; var Date: Date; var Time: Time): Boolean
    var
        DateText: Text[250];
        TimeText: Text[250];
        Position: Integer;
        Length: Integer;
    begin
        IF DateTimeText IN [NowText, 'NOW'] THEN
            DateTimeText := FORMAT(CURRENTDATETIME);
        Date := 0D;
        Time := 0T;
        Position := 1;
        Length := STRLEN(DateTimeText);
        ReadCharacter(' ', DateTimeText, Position, Length);
        ReadUntilCharacter(' ', DateTimeText, Position, Length);
        DateText := DELCHR(COPYSTR(DateTimeText, 1, Position - 1), '<>');
        TimeText := DELCHR(COPYSTR(DateTimeText, Position), '<>');
        IF DateText = '' THEN
            EXIT(TRUE);

        IF MakeDateText(DateText) = 0 THEN;
        IF NOT EVALUATE(Date, DateText) THEN
            EXIT(FALSE);

        IF TimeText = '' THEN
            EXIT(TRUE);

        IF MakeTimeText(TimeText) = 0 THEN;
        IF EVALUATE(Time, TimeText) THEN
            EXIT(TRUE);
    end;

    // [Scope('Personalization')]
    procedure MakeDateText(var DateText: Text): Integer
    var
        Date: Date;
        PartOfText: Text;
        Position: Integer;
        Length: Integer;
    begin
        Position := 1;
        Length := STRLEN(DateText);
        ReadCharacter(' ', DateText, Position, Length);
        IF NOT FindText(PartOfText, DateText, Position, Length) THEN
            EXIT(0);
        CASE PartOfText OF
            COPYSTR('TODAY', 1, STRLEN(PartOfText)), COPYSTR(TodayText, 1, STRLEN(PartOfText)):
                Date := TODAY;
            COPYSTR('WORKDATE', 1, STRLEN(PartOfText)), COPYSTR(WorkdateText, 1, STRLEN(PartOfText)):
                Date := WORKDATE;
            ELSE
                EXIT(0);
        END;
        Position := Position + STRLEN(PartOfText);
        ReadCharacter(' ', DateText, Position, Length);
        IF Position > Length THEN BEGIN
            DateText := FORMAT(Date);
            EXIT(0);
        END;
        EXIT(Position);
    end;

    // [Scope('Personalization')]
    procedure MakeTimeText(var TimeText: Text): Integer
    var
        PartOfText: Text[132];
        Position: Integer;
        Length: Integer;
    begin
        Position := 1;
        Length := STRLEN(TimeText);
        ReadCharacter(' ', TimeText, Position, Length);
        IF NOT FindText(PartOfText, TimeText, Position, Length) THEN
            EXIT(0);
        IF PartOfText <> COPYSTR(TimeText, 1, STRLEN(PartOfText)) THEN
            EXIT(0);
        Position := Position + STRLEN(PartOfText);
        ReadCharacter(' ', TimeText, Position, Length);
        IF Position <= Length THEN
            EXIT(Position);
        TimeText := FORMAT(000000T + ROUND(TIME - 000000T, 1000));
        EXIT(0);
    end;

    // [Scope('Personalization')]
    procedure MakeText(var Text: Text): Integer
    var
        StandardText: Record "Standard Text";
        PartOfText: Text[132];
        Position: Integer;
        Length: Integer;
    begin
        Position := 1;
        Length := STRLEN(Text);
        ReadCharacter(' ', Text, Position, Length);
        IF NOT ReadSymbol('?', Text, Position, Length) THEN
            EXIT(0);
        PartOfText := COPYSTR(Text, Position);
        IF PartOfText = '' THEN BEGIN
            IF PAGE.RUNMODAL(0, StandardText) = ACTION::LookupOK THEN
                Text := StandardText.Description;
            EXIT(0);
        END;
        StandardText.Code := COPYSTR(Text, Position, MAXSTRLEN(StandardText.Code));
        IF NOT StandardText.FIND('=>') OR
           (UPPERCASE(PartOfText) <> COPYSTR(StandardText.Code, 1, STRLEN(PartOfText)))
        THEN
            EXIT(Position);
        Text := StandardText.Description;
        EXIT(0);
    end;

    // [Scope('Personalization')]
    procedure MakeTextFilter(var TextFilterText: Text): Integer
    var
        Position: Integer;
        Length: Integer;
        PartOfText: Text[250];
        HandledByEvent: Boolean;
    begin
        OnBeforeMakeTextFilter(TextFilterText, Position, HandledByEvent);
        IF HandledByEvent THEN
            EXIT(Position);

        Position := 1;
        Length := STRLEN(TextFilterText);
        ReadCharacter(' ', TextFilterText, Position, Length);
        IF FindText(PartOfText, TextFilterText, Position, Length) THEN
            CASE PartOfText OF
                COPYSTR('ME', 1, STRLEN(PartOfText)), COPYSTR(MeText, 1, STRLEN(PartOfText)):
                    BEGIN
                        Position := Position + STRLEN(PartOfText);
                        TextFilterText := USERID;
                    END;
                COPYSTR('USER', 1, STRLEN(PartOfText)), COPYSTR(UserText, 1, STRLEN(PartOfText)):
                    BEGIN
                        Position := Position + STRLEN(PartOfText);
                        TextFilterText := USERID;
                    END;
                COPYSTR('COMPANY', 1, STRLEN(PartOfText)), COPYSTR(CompanyText, 1, STRLEN(PartOfText)):
                    BEGIN
                        Position := Position + STRLEN(PartOfText);
                        TextFilterText := COMPANYNAME;
                    END;
                COPYSTR('MYCUSTOMERS', 1, STRLEN(PartOfText)), COPYSTR(MyCustomersText, 1, STRLEN(PartOfText)):
                    BEGIN
                        Position := Position + STRLEN(PartOfText);
                        GetMyFilterText(TextFilterText, DATABASE::"My Customer");
                    END;
                COPYSTR('MYITEMS', 1, STRLEN(PartOfText)), COPYSTR(MyItemsText, 1, STRLEN(PartOfText)):
                    BEGIN
                        Position := Position + STRLEN(PartOfText);
                        GetMyFilterText(TextFilterText, DATABASE::"My Item");
                    END;
                COPYSTR('MYVENDORS', 1, STRLEN(PartOfText)), COPYSTR(MyVendorsText, 1, STRLEN(PartOfText)):
                    BEGIN
                        Position := Position + STRLEN(PartOfText);
                        GetMyFilterText(TextFilterText, DATABASE::"My Vendor");
                    END;
            END;
        OnAfterMakeTextFilter(TextFilterText, Position);
        EXIT(Position);
    end;

    // [Scope('Personalization')]
    procedure MakeDateTimeFilter(var DateTimeFilterText: Text): Integer
    var
        FilterText: Text;
    begin
        FilterText := DateTimeFilterText;
        MakeFilterExpression(FilterType::DateTime, FilterText);
        DateTimeFilterText := COPYSTR(FilterText, 1, MAXSTRLEN(DateTimeFilterText));
        OnAfterMakeDateTimeFilter(DateTimeFilterText);
        EXIT(0);
    end;

    local procedure MakeDateTimeFilter2(var DateTimeFilterText: Text)
    var
        DateTime1: DateTime;
        DateTime2: DateTime;
        Date1: Date;
        Date2: Date;
        Time1: Time;
        Time2: Time;
        StringPosition: Integer;
    begin
        StringPosition := STRPOS(DateTimeFilterText, '..');
        IF StringPosition = 0 THEN BEGIN
            IF NOT GetSeparateDateTime(DateTimeFilterText, Date1, Time1) THEN
                EXIT;
            IF Date1 = 0D THEN
                EXIT;
            IF Time1 = 0T THEN BEGIN
                DateTimeFilterText := FORMAT(CREATEDATETIME(Date1, 000000T)) + '..' + FORMAT(CREATEDATETIME(Date1, 235959.995T));
                EXIT;
            END;
            DateTimeFilterText := FORMAT(CREATEDATETIME(Date1, Time1));
            EXIT;
        END;
        IF NOT GetSeparateDateTime(COPYSTR(DateTimeFilterText, 1, StringPosition - 1), Date1, Time1) THEN
            EXIT;
        IF NOT GetSeparateDateTime(COPYSTR(DateTimeFilterText, StringPosition + 2), Date2, Time2) THEN
            EXIT;

        IF (Date1 = 0D) AND (Date2 = 0D) THEN
            EXIT;

        IF Date1 <> 0D THEN BEGIN
            IF Time1 = 0T THEN
                Time1 := 000000T;
            DateTime1 := CREATEDATETIME(Date1, Time1);
        END;
        IF Date2 <> 0D THEN BEGIN
            IF Time2 = 0T THEN
                Time2 := 235959T;
            DateTime2 := CREATEDATETIME(Date2, Time2);
        END;
        DateTimeFilterText := FORMAT(DateTime1) + '..' + FORMAT(DateTime2);
    end;

    // [Scope('Personalization')]
    procedure MakeDateFilter(var DateFilterText: Text): Integer
    begin
        MakeFilterExpression(FilterType::Date, DateFilterText);
        OnAfterMakeDateFilter(DateFilterText);
        EXIT(0);
    end;

    local procedure MakeDateFilterInternal(var DateFilterText: Text): Integer
    var
        Date1: Date;
        Date2: Date;
        Text1: Text[30];
        Text2: Text[30];
        StringPosition: Integer;
        i: Integer;
        OK: Boolean;
    begin
        DateFilterText := DELCHR(DateFilterText, '<>');
        IF DateFilterText = '' THEN
            EXIT(0);
        StringPosition := STRPOS(DateFilterText, '..');
        IF StringPosition = 0 THEN BEGIN
            i := MakeDateFilter2(OK, Date1, Date2, DateFilterText);
            IF i <> 0 THEN
                EXIT(i);
            IF OK THEN
                IF Date1 = Date2 THEN
                    DateFilterText := FORMAT(Date1)
                ELSE
                    DateFilterText := STRSUBSTNO('%1..%2', Date1, Date2);
            EXIT(0);
        END;

        Text1 := COPYSTR(DateFilterText, 1, StringPosition - 1);
        i := MakeDateFilter2(OK, Date1, Date2, Text1);
        IF i <> 0 THEN
            EXIT(i);
        IF OK THEN
            Text1 := FORMAT(Date1);

        ReadCharacter('.', DateFilterText, StringPosition, STRLEN(DateFilterText));

        Text2 := COPYSTR(DateFilterText, StringPosition);
        i := MakeDateFilter2(OK, Date1, Date2, Text2);
        IF i <> 0 THEN
            EXIT(StringPosition + i - 1);
        IF OK THEN
            Text2 := FORMAT(Date2);

        DateFilterText := Text1 + '..' + Text2;
        EXIT(0);
    end;

    local procedure MakeDateFilter2(var OK: Boolean; var Date1: Date; var Date2: Date; DateFilterText: Text): Integer
    var
        PartOfText: Text[250];
        RemainderOfText: Text;
        Position: Integer;
        Length: Integer;
        DateFormula: DateFormula;
    begin
        IF EVALUATE(DateFormula, DateFilterText) THEN BEGIN
            RemainderOfText := DateFilterText;
            DateFilterText := '';
        END ELSE BEGIN
            Position := STRPOS(DateFilterText, '+');
            IF Position = 0 THEN
                Position := STRPOS(DateFilterText, '-');

            IF Position > 0 THEN BEGIN
                RemainderOfText := DELCHR(COPYSTR(DateFilterText, Position));
                IF EVALUATE(DateFormula, RemainderOfText) THEN
                    DateFilterText := DELCHR(COPYSTR(DateFilterText, 1, Position - 1))
                ELSE
                    RemainderOfText := '';
            END;
        END;

        Position := 1;
        Length := STRLEN(DateFilterText);
        FindText(PartOfText, DateFilterText, Position, Length);

        IF PartOfText <> '' THEN
            CASE PartOfText OF
                COPYSTR('PERIOD', 1, STRLEN(PartOfText)), COPYSTR(PeriodText, 1, STRLEN(PartOfText)):
                    OK := FindPeriod(Date1, Date2, FALSE, DateFilterText, PartOfText, Position, Length);
                COPYSTR('YEAR', 1, STRLEN(PartOfText)), COPYSTR(YearText, 1, STRLEN(PartOfText)):
                    OK := FindPeriod(Date1, Date2, TRUE, DateFilterText, PartOfText, Position, Length);
                COPYSTR('TODAY', 1, STRLEN(PartOfText)), COPYSTR(TodayText, 1, STRLEN(PartOfText)):
                    OK := FindDate(TODAY, Date1, Date2, DateFilterText, PartOfText, Position, Length);
                COPYSTR('WORKDATE', 1, STRLEN(PartOfText)), COPYSTR(WorkdateText, 1, STRLEN(PartOfText)):
                    OK := FindDate(WORKDATE, Date1, Date2, DateFilterText, PartOfText, Position, Length);
                COPYSTR('NOW', 1, STRLEN(PartOfText)), COPYSTR(NowText, 1, STRLEN(PartOfText)):
                    OK := FindDate(DT2DATE(CURRENTDATETIME), Date1, Date2, DateFilterText, PartOfText, Position, Length);
                COPYSTR('YESTERDAY', 1, STRLEN(PartOfText)), COPYSTR(YesterdayText, 1, STRLEN(PartOfText)):
                    OK := FindDate(CALCDATE('<-1D>'), Date1, Date2, DateFilterText, PartOfText, Position, Length);
                COPYSTR('TOMORROW', 1, STRLEN(PartOfText)), COPYSTR(TomorrowText, 1, STRLEN(PartOfText)):
                    OK := FindDate(CALCDATE('<1D>'), Date1, Date2, DateFilterText, PartOfText, Position, Length);
                COPYSTR('WEEK', 1, STRLEN(PartOfText)), COPYSTR(WeekText, 1, STRLEN(PartOfText)):
                    OK := FindDates('<-CW>', '<CW>', Date1, Date2, DateFilterText, PartOfText, Position, Length);
                COPYSTR('MONTH', 1, STRLEN(PartOfText)), COPYSTR(MonthText, 1, STRLEN(PartOfText)):
                    OK := FindDates('<-CM>', '<CM>', Date1, Date2, DateFilterText, PartOfText, Position, Length);
                COPYSTR('QUARTER', 1, STRLEN(PartOfText)), COPYSTR(QuarterText, 1, STRLEN(PartOfText)):
                    OK := FindDates('<-CQ>', '<CQ>', Date1, Date2, DateFilterText, PartOfText, Position, Length);
            END
        ELSE
            IF (DateFilterText <> '') AND EVALUATE(Date1, DateFilterText) THEN BEGIN
                Date2 := Date1;
                OK := TRUE;
                Position := 0;
            END ELSE
                IF RemainderOfText <> '' THEN BEGIN
                    Date1 := TODAY;
                    Date2 := Date1;
                    OK := TRUE;
                    Position := 0;
                END ELSE
                    OK := FALSE;

        IF OK AND (RemainderOfText <> '') THEN BEGIN
            Date1 := CALCDATE(DateFormula, Date1);
            Date2 := CALCDATE(DateFormula, Date2);
        END;
        EXIT(Position);
    end;

    // [Scope('Personalization')]
    procedure MakeTimeFilter(var TimeFilterText: Text): Integer
    var
        FilterText: Text;
    begin
        FilterText := TimeFilterText;
        MakeFilterExpression(FilterType::Time, FilterText);
        TimeFilterText := COPYSTR(FilterText, 1, MAXSTRLEN(TimeFilterText));
        OnAfterMakeTimeFilter(TimeFilterText);
        EXIT(0);
    end;

    local procedure MakeTimeFilter2(var TimeFilterText: Text)
    var
        Time1: Time;
        Time2: Time;
        StringPosition: Integer;
    begin
        StringPosition := STRPOS(TimeFilterText, '..');
        IF StringPosition = 0 THEN BEGIN
            IF NOT GetTime(Time1, TimeFilterText) THEN
                EXIT;
            IF Time1 = 0T THEN BEGIN
                TimeFilterText := FORMAT(000000T) + '..' + FORMAT(235959.995T);
                EXIT;
            END;
            TimeFilterText := FORMAT(Time1);
            EXIT;
        END;
        IF NOT GetTime(Time1, COPYSTR(TimeFilterText, 1, StringPosition - 1)) THEN
            EXIT;
        IF NOT GetTime(Time2, COPYSTR(TimeFilterText, StringPosition + 2)) THEN
            EXIT;

        IF Time1 = 0T THEN
            Time1 := 000000T;
        IF Time2 = 0T THEN
            Time2 := 235959T;

        TimeFilterText := FORMAT(Time1) + '..' + FORMAT(Time2);
    end;

    local procedure MakeFilterExpression(TypeOfFilter: Option; var FilterText: Text)
    var
        Head: Text;
        Tail: Text;
        Position: Integer;
        Length: Integer;
    begin
        FilterText := DELCHR(FilterText, '<>');
        Position := 1;
        Length := STRLEN(FilterText);
        WHILE Length <> 0 DO BEGIN
            ReadCharacter(' |()', FilterText, Position, Length);
            IF Position > 1 THEN BEGIN
                Head := Head + COPYSTR(FilterText, 1, Position - 1);
                FilterText := COPYSTR(FilterText, Position);
                Position := 1;
                Length := STRLEN(FilterText);
            END;
            IF Length <> 0 THEN BEGIN
                ReadUntilCharacter('|()', FilterText, Position, Length);
                IF Position > 1 THEN BEGIN
                    Tail := COPYSTR(FilterText, Position);
                    FilterText := COPYSTR(FilterText, 1, Position - 1);
                    CallMakeFilterFunction(TypeOfFilter, FilterText);
                    EVALUATE(Head, Head + FilterText);
                    FilterText := Tail;
                    Position := 1;
                    Length := STRLEN(FilterText);
                END;
            END;
        END;
        FilterText := Head;
    end;

    local procedure CallMakeFilterFunction(TypeOfFilter: Option; var FilterText: Text)
    begin
        CASE TypeOfFilter OF
            FilterType::DateTime:
                MakeDateTimeFilter2(FilterText);
            FilterType::Date:
                MakeDateFilterInternal(FilterText);
            FilterType::Time:
                MakeTimeFilter2(FilterText);
        END;
    end;

    // [Scope('Personalization')]
    procedure EvaluateIncStr(StringToIncrement: Code[50]; ErrorHint: Text)
    begin
        IF INCSTR(StringToIncrement) = '' THEN
            ERROR(UnincrementableStringError, ErrorHint);
    end;

    // [Scope('Personalization')]
    procedure UnincrementableStringError(): Text
    begin
        EXIT(UnincrementableStringErr)
    end;

    local procedure GetTime(var Time0: Time; FilterText: Text): Boolean
    begin
        FilterText := DELCHR(FilterText);
        IF FilterText IN [NowText, 'NOW'] THEN BEGIN
            Time0 := TIME;
            EXIT(TRUE);
        END;
        EXIT(EVALUATE(Time0, FilterText));
    end;

    local procedure FindPeriod(var Date1: Date; var Date2: Date; FindYear: Boolean; DateFilterText: Text; PartOfText: Text; var Position: Integer; Length: Integer): Boolean
    var
        AccountingPeriod: Record "Accounting Period";
        AccountingPeriodMgt: Codeunit "Accounting Period Mgt.";
        Sign: Text[1];
        Numeral: Integer;
    begin
        Position := Position + STRLEN(PartOfText);
        ReadCharacter(' ', DateFilterText, Position, Length);

        IF AccountingPeriod.ISEMPTY THEN BEGIN
            IF FindYear THEN
                AccountingPeriodMgt.InitStartYearAccountingPeriod(AccountingPeriod, WORKDATE)
            ELSE
                AccountingPeriodMgt.InitDefaultAccountingPeriod(AccountingPeriod, WORKDATE);
            ReadNumeral(Numeral, DateFilterText, Position, Length);
            Date1 := AccountingPeriod."Starting Date";
            Date2 := CALCDATE('<CY>', AccountingPeriod."Starting Date");
            ReadCharacter(' ', DateFilterText, Position, Length);
            IF Position > Length THEN
                Position := 0;
            EXIT(TRUE);
        END;

        IF FindYear THEN
            AccountingPeriod.SETRANGE("New Fiscal Year", TRUE)
        ELSE
            AccountingPeriod.SETRANGE("New Fiscal Year");
        Sign := '';
        IF ReadSymbol('+', DateFilterText, Position, Length) THEN
            Sign := '+'
        ELSE
            IF ReadSymbol('-', DateFilterText, Position, Length) THEN
                Sign := '-';
        IF Sign = '' THEN
            IF ReadNumeral(Numeral, DateFilterText, Position, Length) THEN BEGIN
                IF FindYear THEN
                    AccountingPeriod.FINDFIRST
                ELSE BEGIN
                    AccountingPeriod.SETRANGE("New Fiscal Year", TRUE);
                    AccountingPeriod."Starting Date" := WORKDATE;
                    AccountingPeriod.FIND('=<');
                    AccountingPeriod.SETRANGE("New Fiscal Year");
                END;
                AccountingPeriod.NEXT(Numeral - 1);
            END ELSE BEGIN
                AccountingPeriod."Starting Date" := WORKDATE;
                AccountingPeriod.FIND('=<');
            END
        ELSE BEGIN
            IF NOT ReadNumeral(Numeral, DateFilterText, Position, Length) THEN
                EXIT(TRUE);
            IF Sign = '-' THEN
                Numeral := -Numeral;
            AccountingPeriod."Starting Date" := WORKDATE;
            AccountingPeriod.FIND('=<');
            AccountingPeriod.NEXT(Numeral);
        END;
        Date1 := AccountingPeriod."Starting Date";
        IF AccountingPeriod.NEXT = 0 THEN
            Date2 := DMY2DATE(31, 12, 9999)
        ELSE
            Date2 := AccountingPeriod."Starting Date" - 1;
        ReadCharacter(' ', DateFilterText, Position, Length);
        IF Position > Length THEN
            Position := 0;
        EXIT(TRUE);
    end;

    local procedure FindDate(Date1Input: Date; var Date1: Date; var Date2: Date; DateFilterText: Text; PartOfText: Text; var Position: Integer; Length: Integer): Boolean
    begin
        Position := Position + STRLEN(PartOfText);
        ReadCharacter(' ', DateFilterText, Position, Length);
        Date1 := Date1Input;
        Date2 := Date1;
        IF Position > Length THEN
            Position := 0;
        EXIT(TRUE);
    end;

    local procedure FindDates(DateFormulaText1: Text; DateFormulaText2: Text; var Date1: Date; var Date2: Date; DateFilterText: Text; PartOfText: Text; var Position: Integer; Length: Integer): Boolean
    var
        DateFormula1: DateFormula;
        DateFormula2: DateFormula;
    begin
        Position := Position + STRLEN(PartOfText);
        ReadCharacter(' ', DateFilterText, Position, Length);
        EVALUATE(DateFormula1, DateFormulaText1);
        EVALUATE(DateFormula2, DateFormulaText2);
        Date1 := CALCDATE(DateFormula1);
        Date2 := CALCDATE(DateFormula2);
        IF Position > Length THEN
            Position := 0;
        EXIT(TRUE);
    end;

    local procedure FindText(var PartOfText: Text; Text: Text; Position: Integer; Length: Integer): Boolean
    var
        Position2: Integer;
    begin
        Position2 := Position;
        ReadCharacter(AlphabetText, Text, Position, Length);
        IF Position = Position2 THEN
            EXIT(FALSE);
        PartOfText := UPPERCASE(COPYSTR(Text, Position2, Position - Position2));
        EXIT(TRUE);
    end;

    local procedure ReadSymbol(Token: Text[30]; Text: Text; var Position: Integer; Length: Integer): Boolean
    begin
        IF Token <> COPYSTR(Text, Position, STRLEN(Token)) THEN
            EXIT(FALSE);
        Position := Position + STRLEN(Token);
        ReadCharacter(' ', Text, Position, Length);
        EXIT(TRUE);
    end;

    local procedure ReadNumeral(var Numeral: Integer; Text: Text; var Position: Integer; Length: Integer): Boolean
    var
        Position2: Integer;
        i: Integer;
    begin
        Position2 := Position;
        ReadCharacter('0123456789', Text, Position, Length);
        IF Position2 = Position THEN
            EXIT(FALSE);
        Numeral := 0;
        FOR i := Position2 TO Position - 1 DO
            IF Numeral < 1000 THEN
                Numeral := Numeral * 10 + STRPOS('0123456789', COPYSTR(Text, i, 1)) - 1;
        IF (Numeral < 1) OR (Numeral > 999) THEN
            ERROR(NumeralOutOfRangeError);
        EXIT(TRUE);
    end;

    local procedure ReadCharacter(Character: Text[50]; Text: Text; var Position: Integer; Length: Integer)
    begin
        WHILE (Position <= Length) AND (STRPOS(Character, UPPERCASE(COPYSTR(Text, Position, 1))) <> 0) DO
            Position := Position + 1;
    end;

    local procedure ReadUntilCharacter(Character: Text[50]; Text: Text; var Position: Integer; Length: Integer)
    begin
        WHILE (Position <= Length) AND (STRPOS(Character, UPPERCASE(COPYSTR(Text, Position, 1))) = 0) DO
            Position := Position + 1;
    end;

    local procedure GetMyFilterText(var TextFilterText: Text; MyTableNo: Integer)
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
        NoOfValues: Integer;
    begin
        IF NOT (MyTableNo IN [DATABASE::"My Customer", DATABASE::"My Vendor", DATABASE::"My Item"]) THEN
            EXIT;

        TextFilterText := '';
        NoOfValues := 0;
        RecRef.OPEN(MyTableNo);
        FieldRef := RecRef.FIELD(1);
        FieldRef.SETRANGE(USERID);
        IF RecRef.FIND('-') THEN
            REPEAT
                FieldRef := RecRef.FIELD(2);
                AddToFilter(TextFilterText, FORMAT(FieldRef.VALUE));
                NoOfValues += 1;
            UNTIL (RecRef.NEXT = 0) OR (NoOfValues > 2000);
        RecRef.CLOSE;

        IF NoOfValues > 2000 THEN
            MESSAGE(OverflowMsg);
    end;

    local procedure AddToFilter(var FilterString: Text; MyNo: Code[20])
    begin
        IF FilterString = '' THEN
            FilterString := MyNo
        ELSE
            FilterString += '|' + MyNo;
    end;

    // [Scope('Personalization')]
    procedure RemoveMessageTrailingDots(Message: Text): Text
    begin
        EXIT(DELCHR(Message, '>', '.'));
    end;

    // [Scope('Personalization')]
    procedure GetRecordErrorMessage(ErrorMessageField1: Text[250]; ErrorMessageField2: Text[250]; ErrorMessageField3: Text[250]; ErrorMessageField4: Text[250]): Text
    begin
        EXIT(ErrorMessageField1 + ErrorMessageField2 + ErrorMessageField3 + ErrorMessageField4);
    end;

    // [Scope('Personalization')]
    procedure SetRecordErrorMessage(var ErrorMessageField1: Text[250]; var ErrorMessageField2: Text[250]; var ErrorMessageField3: Text[250]; var ErrorMessageField4: Text[250]; ErrorText: Text)
    begin
        ErrorMessageField2 := '';
        ErrorMessageField3 := '';
        ErrorMessageField4 := '';
        ErrorMessageField1 := COPYSTR(ErrorText, 1, 250);
        IF STRLEN(ErrorText) > 250 THEN
            ErrorMessageField2 := COPYSTR(ErrorText, 251, 250);
        IF STRLEN(ErrorText) > 500 THEN
            ErrorMessageField3 := COPYSTR(ErrorText, 501, 250);
        IF STRLEN(ErrorText) > 750 THEN
            ErrorMessageField4 := COPYSTR(ErrorText, 751, 250);
    end;

    // [Scope('Internal')]
    // procedure XMLTextIndent(InputXMLText: Text): Text
    // var
    //     TempBlob: Record "99008535";
    //     XMLDOMMgt: Codeunit "6224";
    //     XMLDocument: DotNet XmlDocument;
    //     OutStream: OutStream;
    // begin
    //     // Format input XML text: append indentations
    //     IF XMLDOMMgt.LoadXMLDocumentFromText(InputXMLText,XMLDocument) THEN BEGIN
    //       TempBlob.INIT;
    //       TempBlob.Blob.CREATEOUTSTREAM(OutStream,TEXTENCODING::UTF8);
    //       XMLDocument.Save(OutStream);
    //       EXIT(TempBlob.ReadAsTextWithCRLFLineSeparator);
    //     END;
    //     CLEARLASTERROR;
    //     EXIT(InputXMLText);
    // end;

    // [Scope('Personalization')]
    // procedure Replace(InputText: Text;ToReplace: Text;ReplacementText: Text): Text
    // var
    //     DotNetString: DotNet String;
    // begin
    //     IF ToReplace = '' THEN
    //       EXIT(InputText);

    //     DotNetString := InputText;
    //     EXIT(DotNetString.Replace(ToReplace,ReplacementText));
    // end;

    // //[TryFunction]
    // [Scope('Personalization')]
    // procedure ReplaceRegex(InputText: Text;ReplacePattern: Text;ReplacementText: Text;var Result: Text)
    // var
    //     TypeHelper: Codeunit "10";
    // begin
    //     Result := TypeHelper.RegexReplace(InputText,ReplacePattern,ReplacementText);
    // end;

    [EventSubscriber(ObjectType::Codeunit, 2000000007, 'MakeDateTimeFilter', '', false, false)]
    local procedure DoMakeDateTimeFilter(var DateTimeFilterText: Text)
    begin
        MakeDateTimeFilter(DateTimeFilterText);
    end;

    [EventSubscriber(ObjectType::Codeunit, 2000000007, 'MakeDateFilter', '', false, false)]
    local procedure DoMakeDateFilter(var DateFilterText: Text)
    begin
        MakeDateFilter(DateFilterText);
    end;

    [EventSubscriber(ObjectType::Codeunit, 2000000007, 'MakeTextFilter', '', false, false)]
    local procedure DoMakeTextFilter(var TextFilterText: Text)
    begin
        MakeTextFilter(TextFilterText);
    end;

    [EventSubscriber(ObjectType::Codeunit, 2000000007, 'MakeCodeFilter', '', false, false)]
    local procedure DoMakeCodeFilter(var TextFilterText: Text)
    begin
        MakeTextFilter(TextFilterText);
    end;

    [EventSubscriber(ObjectType::Codeunit, 2000000007, 'MakeTimeFilter', '', false, false)]
    local procedure DoMakeTimeFilter(var TimeFilterText: Text)
    begin
        MakeTimeFilter(TimeFilterText);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeMakeTextFilter(var TextFilterText: Text; var Position: Integer; var HandledByEvent: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterMakeDateTimeFilter(var DateTimeFilterText: Text)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterMakeDateFilter(var DateFilterText: Text)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterMakeTextFilter(var TextFilterText: Text; var Position: Integer)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterMakeTimeFilter(var TimeFilterText: Text)
    begin
    end;
}

