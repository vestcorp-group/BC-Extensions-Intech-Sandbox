codeunit 80205 "INT Key Validation Mgt- PC"
{

    trigger OnRun()
    begin
    end;

    procedure onOpenPageKeyValidation()
    var
        INTProdSetup: Record "INT Packaging Config Setup";
        INTProdSetupPage: Page "INT Packaging Config Setup";
        MyNotification: Notification;
        EndDate: Date;
        NoofDay: Integer;
        TextLbl: Label 'Product Configurator Setup not Created yet,\Do you want to Create it Now?';
    begin
        IF NOT INTProdSetup.GET() then
            IF Confirm(TextLbl, true) then begin
                INTProdSetupPage.RunModal();
                INTProdSetup.GET();
                INTProdSetup.TESTFIELD("Activation Key");
            end;

        EndDate := ValidateEndDateFunction(INTProdSetup."Activation Key");
        IF EndDate < TODAY() THEN
            ERROR('Product Configurator App expired on %1,Contact to Intech Systems Pvt. Ltd. for activation', EndDate);

        NoofDay := EndDate - TODAY();
        IF NoofDay < 15 THEN BEGIN
            MyNotification.MESSAGE(STRSUBSTNO('Product Configurator App will expire in %1 days,Contact to Intech Systems Pvt. Ltd. for activation', NoofDay));
            MyNotification.ADDACTION('Activate Now', CODEUNIT::"INT Key Validation Mgt- PC", 'ExpireNotification');
            MyNotification.SEND();
        END;
    end;

    procedure ExpireNotification(MyNotification: Notification)
    var
        INTProdSetup: Page "INT Packaging Config Setup";
    begin
        INTProdSetup.RUNMODAL();
    end;

    procedure GetKey(NoofDays: Integer): Code[250]
    var
        BuildKey: Text;
    begin
        BuildKey := GetTSValue(TODAY()) + 'P' + GetTSValue(TODAY() + NoofDays);

        BuildKey := COPYSTR(GetRandomString(), 1, 5) + BuildKey + COPYSTR(GetRandomString(), 1, 6);

        EXIT(CopyStr(BuildKey, 1, 250));
    end;

    procedure ValidateEndDateFunction(BuildKey: Code[250]): Date
    var
        FirstDate: Date;
        EnDate: Date;
    begin
        IF BuildKey = '' THEN
            ERROR('Invalid Key');

        GetDTValue(BuildKey, FirstDate, EnDate);

        EXIT(EnDate);
    end;

    procedure ValidateKey(BuildKey: Code[250]): Date
    var
        FirstDate: Date;
        EnDate: Date;
    begin
        IF BuildKey = '' THEN
            ERROR('Invalid Key');

        GetDTValue(BuildKey, FirstDate, EnDate);

        IF FirstDate <> TODAY() THEN
            ERROR('Invalid Key');

        EXIT(EnDate);
    end;

    local procedure GetRandomString(): Text
    begin
        EXIT(DELCHR(FORMAT(CREATEGUID()), '=', '{}-'));
    end;

    local procedure "--------- Key Calculation -----------"()
    begin
    end;

    local procedure GetIntValue(InputKey: Code[2]): Integer
    begin
        CASE InputKey OF
            'VX':
                EXIT(0);
            'GR':
                EXIT(1);
            'CD':
                EXIT(2);
            'WE':
                EXIT(3);
            'HI':
                EXIT(4);
            'LC':
                EXIT(5);
            'QS':
                EXIT(6);
            'BU':
                EXIT(7);
            'WX':
                EXIT(8);
            'HY':
                EXIT(9);
        END;
    end;

    local procedure GetStrValue(InputKey: Text[1]): Text[2]
    begin
        CASE InputKey OF
            '0':
                EXIT('VX');
            '1':
                EXIT('GR');
            '2':
                EXIT('CD');
            '3':
                EXIT('WE');
            '4':
                EXIT('HI');
            '5':
                EXIT('LC');
            '6':
                EXIT('QS');
            '7':
                EXIT('BU');
            '8':
                EXIT('WX');
            '9':
                EXIT('HY');
        END;
    end;

    local procedure GetTSValue(Date: Date): Text[50]
    var
        DDInt: Integer;
        MMInt: Integer;
        YYYYInt: Integer;
        DDLocal: Text[2];
        MMLocal: Text[2];
        YYYYLocal: Text[4];
        i: Integer;
        FullDate: Text[100];
        EncrptValueDate: Text[250];
    begin
        DDInt := DATE2DMY(Date, 1);
        MMInt := DATE2DMY(Date, 2);
        YYYYInt := DATE2DMY(Date, 3);

        DDLocal := COPYSTR(FORMAT(DDInt), 1, MaxStrLen(DDLocal));
        IF STRLEN(DDLocal) = 1 THEN
            DDLocal := COPYSTR('0' + DDLocal, 1, MaxStrLen(DDLocal));

        MMLocal := COPYSTR(FORMAT(MMInt), 1, MaxStrLen(MMLocal));
        IF STRLEN(MMLocal) = 1 THEN
            MMLocal := COPYSTR('0' + MMLocal, 1, MaxStrLen(MMLocal));

        YYYYLocal := COPYSTR(FORMAT(YYYYInt), 1, MaxStrLen(YYYYLocal));
        IF STRLEN(YYYYLocal) = 2 THEN
            YYYYLocal := COPYSTR('20' + YYYYLocal, 1, MaxStrLen(YYYYLocal));

        FullDate := DDLocal + MMLocal + YYYYLocal;

        EncrptValueDate := '';
        FOR i := 1 TO STRLEN(FullDate) DO
            // IF EncrptValueDate = '' THEN
            //     EncrptValueDate := GetStrValue(copystr(FORMAT(FullDate[i]), 1, MaxStrLen(EncrptValueDate)))
            // ELSE
            //     EncrptValueDate += GetStrValue(copystr(FORMAT(FullDate[i]), 1, MaxStrLen(EncrptValueDate)));
            IF EncrptValueDate = '' THEN
                EncrptValueDate := GetStrValue(copystr(FORMAT(FullDate[i]), 1, 1))
            ELSE
                EncrptValueDate += GetStrValue(copystr(FORMAT(FullDate[i]), 1, 1));

        EXIT(Copystr(EncrptValueDate, 1, 50));
    end;

    local procedure GetDTValue(KeyValue: Code[1024]; var FirstDate: Date; var EnDate: Date): Date
    var
        FirstPart: Code[500];
        SecondPart: Code[500];
    begin
        IF KeyValue = '' THEN
            ERROR('Please enter valid Key Value');

        IF STRPOS(KeyValue, 'P') = 0 THEN
            ERROR('Please enter valid Key Value');

        IF STRLEN(KeyValue) < 44 THEN
            ERROR('Please enter valid Key Value');

        KeyValue := COPYSTR(KeyValue, 6, 33);

        FirstPart := Copystr(COPYSTR(KeyValue, 1, STRPOS(KeyValue, 'P') - 1), 1, MaxStrLen(FirstPart));
        SecondPart := Copystr(COPYSTR(KeyValue, STRPOS(KeyValue, 'P') + 1), 1, MaxStrLen(SecondPart));

        FirstDate := CalDatePart(FirstPart);
        EnDate := CalDatePart(SecondPart);
    end;

    local procedure CalDatePart(KeyValue: Code[500]): Date
    var
        i: Integer;
        FindValue: Code[2];
        LastFinalValue: Code[500];
        DDInt: Integer;
        MMInt: Integer;
        YYYYInt: Integer;
        DDLocal: Text[2];
        MMLocal: Text[2];
        YYYYLocal: Text[4];
    begin
        IF KeyValue = '' THEN
            EXIT;

        LastFinalValue := '';

        FOR i := 1 TO STRLEN(KeyValue) DO BEGIN
            FindValue := Copystr(FORMAT(KeyValue[i]), 1, MaxStrLen(FindValue));
            i += 1;
            FindValue += FORMAT(KeyValue[i]);

            IF LastFinalValue = '' THEN
                LastFinalValue := copystr(FORMAT(GetIntValue(FindValue)), 1, MaxStrLen(LastFinalValue))
            ELSE
                LastFinalValue += FORMAT(GetIntValue(FindValue));
        END;

        IF STRLEN(LastFinalValue) <> 8 THEN
            ERROR('Please enter valid Key Value');

        DDLocal := COPYSTR(LastFinalValue, 1, 2);
        MMLocal := COPYSTR(LastFinalValue, 3, 2);
        YYYYLocal := COPYSTR(LastFinalValue, 5, 4);

        IF NOT EVALUATE(DDInt, DDLocal) THEN
            ERROR('Please enter valid Key Value');

        IF NOT EVALUATE(MMInt, MMLocal) THEN
            ERROR('Please enter valid Key Value');

        IF NOT EVALUATE(YYYYInt, YYYYLocal) THEN
            ERROR('Please enter valid Key Value');

        EXIT(DMY2DATE(DDInt, MMInt, YYYYInt));
    end;
}

