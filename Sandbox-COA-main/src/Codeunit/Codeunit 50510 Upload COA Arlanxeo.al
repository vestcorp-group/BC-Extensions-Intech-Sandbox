codeunit 50510 "Upload COA Arlanxeo"//T12370-Full Comment   //T13935-N
{
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;

    procedure UploadDataCOA(POLine: Record "Purchase Line")
    var
        ExcelBuffer: Record "Excel Buffer" temporary;
        ItemTestingParamter: Record "Item Testing Parameter";
        TestingParametermaster: Record "Testing Parameter";
        ReservationEntry: Record "Reservation Entry";
        ItemVariantTestingParameter: Record "Item Variant Testing Parameter"; //AJAY
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
        Ins: InStream;
        row: Integer;
        column: Integer;
        N: Integer;
        N2: Integer;
        lastrow: Integer;
        LastColumn: Integer;
        EntryNoL: Integer;
        PalletNo: Text;
        Filename: Text;
        PalletNolist: list of [Text];
        TestCodeAr: array[30] of Text[50];
        PerBatchQty: Decimal;
        LineQty: Decimal;
        LotNumber: Code[50];
        ExpiryPeriodvar: DateFormula;
        ExpiryDateVar: Date;
        NameValueBuffer: Record "Name/Value Buffer";
        SheetName: Text;
        ItemTrackingPage: Page "Item Tracking Lines";
        DecValL: Decimal;//T51170-N
        SICduQCCOA_lCdu: Codeunit "COA_QC_SI";//T51170
        Item_lRec: Record item;//T51170-N
    begin
        if UploadIntoStream('Select COA File', '', '', Filename, Ins) then begin
            // ExcelBuffer.GetSheetsNameListFromStream(Ins, NameValueBuffer);
            SheetName := ExcelBuffer.SelectSheetsNameStream(Ins);
            ExcelBuffer.OpenBookStream(Ins, SheetName);
            ExcelBuffer.ReadSheet();
            ExcelBuffer.FindLast();
            lastrow := ExcelBuffer."Row No.";
            column := ExcelBuffer."Column No.";
            ExcelBuffer.Reset();
            ExcelBuffer.SetRange("Row No.", 1);
            ExcelBuffer.SetCurrentKey("Column No.");
            if ExcelBuffer.FindSet() then begin
                LastColumn := ExcelBuffer.Count;
                repeat
                    N := N + 1;
                    TestCodeAr[N] := GetTextWithInterger(ExcelBuffer, ExcelBuffer."Column No.", 1);
                until ExcelBuffer.Next() = 0;
            end;
            ExcelBuffer.Reset();
            SICduQCCOA_lCdu.ClearProcess_gFnc();//T51170-N
            for row := 2 to lastrow do begin
                Clear(LotNumber);
                Clear(LineQty);
                Clear(ExpiryDateVar);
                Clear(ExpiryPeriodvar);
                Clear(PerBatchQty);
                PalletNo := GetTextWithInterger(ExcelBuffer, 2, row);
                PalletNo := PalletNo.Replace(' ', '');
                PalletNolist := PalletNo.Split(',');
                N2 := PalletNolist.Count;
                Evaluate(LineQty, GetTextWithInterger(ExcelBuffer, 3, row));
                PerBatchQty := LineQty / N2;
                begin
                    repeat
                        LotNumber := GetTextWithInterger(ExcelBuffer, 1, row) + ' ' + PalletNolist.Get(N2);
                        if ReservationEntry.FindLast() then EntryNoL := ReservationEntry."Entry No." + 1;
                        ReservationEntry.Reset();
                        // ReservationEntry.SetSourceFilter(POLine.RecordId.TableNo, POLine."Document Type", POLine."Document No.", POLine."Line No.", true);
                        ReservationEntry.SetRange("Item No.", POLine."No.");
                        ReservationEntry.SetRange("Variant Code", POLine."Variant Code");
                        ReservationEntry.SetRange("Source ID", POLine."Document No.");
                        ReservationEntry.SetRange("Source Ref. No.", POLine."Line No.");
                        ReservationEntry.SetRange("Reservation Status", ReservationEntry."Reservation Status"::Surplus);
                        ReservationEntry.SetRange(CustomLotNumber, LotNumber);
                        ReservationEntry.SetRange(CustomBOENumber, POLine.CustomBOENumber);
                        // ReservationEntry.SetRange("Quantity (Base)", PerBatchQty);
                        if not ReservationEntry.FindFirst() then begin
                            ReservationEntry.Init();
                            ReservationEntry."Entry No." := EntryNoL;
                            ReservationEntry.Positive := true;
                            ReservationEntry.SetSource(POLine.RecordId.TableNo, POLine."Document Type".AsInteger(), POLine."Document No.", POLine."Line No.", '', 0);//30-04-2022-added as integer with enum
                            ReservationEntry.SetItemData(POLine."No.", '', POLine."Location Code", POLine."Variant Code", POLine."Qty. per Unit of Measure");
                            ReservationEntry."Creation Date" := WorkDate();
                            ReservationEntry."Created By" := UserId;
                            ReservationEntry."Reservation Status" := ReservationEntry."Reservation Status"::Surplus;
                            ReservationEntry."Expected Receipt Date" := POLine."Expected Receipt Date";
                            ReservationEntry."Item Tracking" := ReservationEntry."Item Tracking"::"Lot No.";
                            ReservationEntry.Validate(CustomLotNumber, LotNumber);
                            ReservationEntry.CustomBOENumber := POLine.CustomBOENumber;
                            ReservationEntry."Variant Code" := POLine."Variant Code";
                            ReservationEntry."Lot No." := LotNumber + '@' + POLine.CustomBOENumber;
                            ReservationEntry.Validate("Quantity (Base)", PerBatchQty);
                            ReservationEntry."Manufacturing Date 2" := GetDateWithInteger(ExcelBuffer, 4, row);
                            ReservationEntry."Warranty Date" := GetDateWithInteger(ExcelBuffer, 4, row); //26032025
                            ExpiryDatevar := GetDateWithInteger(ExcelBuffer, 5, row);
                            ReservationEntry."Analysis Date" := GetDateWithInteger(ExcelBuffer, 6, row);
                            Evaluate(ExpiryPeriodVar, Format(ExpiryDatevar - ReservationEntry."Manufacturing Date 2") + 'D');
                            ReservationEntry.Validate("Expiry Period 2", ExpiryPeriodvar);
                            ReservationEntry."Expiration Date" := GetDateWithInteger(ExcelBuffer, 5, row); //26032025
                            // ReservationEntry."Expiration Date" := CalcDate(ExpiryPeriodvar, ReservationEntry."Manufacturing Date 2");
                            if ReservationEntry.Insert() then;

                        end else begin
                            ReservationEntry.Validate("Quantity (Base)", PerBatchQty);
                            ReservationEntry."Manufacturing Date 2" := GetDateWithInteger(ExcelBuffer, 4, row);
                            ReservationEntry."Warranty Date" := GetDateWithInteger(ExcelBuffer, 4, row); //26032025
                            ExpiryDatevar := GetDateWithInteger(ExcelBuffer, 5, row);
                            ReservationEntry."Analysis Date" := GetDateWithInteger(ExcelBuffer, 6, row);
                            Evaluate(ExpiryPeriodVar, Format(ExpiryDatevar - ReservationEntry."Manufacturing Date 2" + 1) + 'D');
                            ReservationEntry.Validate("Expiry Period 2", ExpiryPeriodvar);
                            ReservationEntry."Expiration Date" := GetDateWithInteger(ExcelBuffer, 5, row); //26032025
                            if ReservationEntry.Modify() then;
                        end;

                        for column := 7 to LastColumn do begin
                            Clear(TestingParametermaster);
                            Clear(ItemTestingParamter);
                            if TestingParametermaster.Get(TestCodeAr[column]) then;
                            if ItemTestingParamter.Get(POLine."No.", TestCodeAr[column]) then;
                            if LotVariantTestingParameter.Get(POLine."Document No.", POLine."Line No.", POLine."No.", POLine."Variant Code", LotNumber, POLine.CustomBOENumber, TestCodeAr[column]) then begin
                                SICduQCCOA_lCdu.SetProcess_gFnc(true);
                                if LotVariantTestingParameter.Type = LotVariantTestingParameter.Type::Text then
                                    LotVariantTestingParameter.Validate("Vendor COA Text Result", GetTextWithInterger(ExcelBuffer, column, row))
                                else begin
                                    evaluate(DecValL, GetTextWithInterger(ExcelBuffer, column, row));
                                    LotVariantTestingParameter.Validate("Vendor COA Value Result", DecValL);//T51170-N
                                end;
                                //LotVariantTestingParameter.Validate("Actual Value", GetTextWithInterger(ExcelBuffer, column, row));
                                if LotVariantTestingParameter.Modify() then
                                    ReservationEntry."Of Spec" := LotVariantTestingParameter."Of Spec";
                                if ReservationEntry.Modify() then;
                            end
                            else begin
                                //T51170-NS
                                Item_lRec.get(POLine."No.");
                                if (Item_lRec."COA Applicable") then begin
                                    //T51170-NE
                                    LotVariantTestingParameter.Init();
                                    LotVariantTestingParameter."Source ID" := POLine."Document No.";
                                    LotVariantTestingParameter."Source Ref. No." := POLine."Line No.";
                                    LotVariantTestingParameter."Item No." := POLine."No.";
                                    LotVariantTestingParameter."Variant Code" := POLine."Variant Code";
                                    LotVariantTestingParameter."Lot No." := LotNumber;
                                    LotVariantTestingParameter."BOE No." := POLine.CustomBOENumber;
                                    LotVariantTestingParameter.Validate(Code, TestCodeAr[column]);
                                    //T51170-NS
                                    SICduQCCOA_lCdu.SetProcess_gFnc(true);
                                    if LotVariantTestingParameter.Type = LotVariantTestingParameter.Type::Text then
                                        LotVariantTestingParameter.Validate("Vendor COA Text Result", GetTextWithInterger(ExcelBuffer, column, row))
                                    else begin
                                        evaluate(DecValL, GetTextWithInterger(ExcelBuffer, column, row));
                                        LotVariantTestingParameter.Validate("Vendor COA Value Result", DecValL);//T51170-N
                                    end;
                                    //T51170-O LotVariantTestingParameter.Validate("Actual Value", GetTextWithInterger(ExcelBuffer, column, row));
                                    if LotVariantTestingParameter.Insert() then
                                        ReservationEntry."Of Spec" := LotVariantTestingParameter."Of Spec";
                                    if ReservationEntry.Modify() then;
                                end;//T51170-N
                            end;
                        end;
                        N2 := N2 - 1;
                    until N2 = 0;
                end;

            end;
            SICduQCCOA_lCdu.ClearProcess_gFnc();//T51170-N
        end;
    end;

    // procedure "Month to Number"(Month: Text; Year: Text) OutDate: Date;
    // var
    //     MonthVar: Integer;
    // begin
    //     case Month of
    //         'Jan':
    //             MonthVar := 1;
    //         'Feb':
    //             MonthVar := 2;
    //         'Mar':
    //             MonthVar := 3;
    //         'Apr':
    //             MonthVar := 3;
    //     end
    // end;

    procedure GetTextWithText(var Buffer: Record "Excel Buffer" temporary; Col: Text; Row: Integer): Text
    begin
        if Buffer.Get(Row, GetColumnNumber(col)) then
            exit(Buffer."Cell Value as Text");
    end;

    procedure GetTextWithInterger(var Buffer: Record "Excel Buffer" temporary; Col: Integer; Row: Integer): Text
    begin
        if Buffer.Get(Row, Col) then
            exit(Buffer."Cell Value as Text");
    end;

    procedure GetDateWithInteger(var Buffer: Record "Excel Buffer" temporary; Col: Integer; Row: Integer): Date
    var
        d: Date;
    begin
        if Buffer.Get(Row, Col) then begin
            Evaluate(D, Buffer."Cell Value as Text");
            exit(D);
        end;
    end;

    procedure GetDate(var Buffer: Record "Excel Buffer" temporary; Col: Text; Row: Integer): Date
    var
        d: Date;
    begin
        if Buffer.Get(Row, GetColumnNumber(col)) then begin
            Evaluate(D, Buffer."Cell Value as Text");
            exit(D);
        end;
    end;

    procedure GetColumnNumber(ColumnName: Text): Integer
    var
        columnIndex: Integer;
        factor: Integer;
        pos: Integer;
    begin
        factor := 1;
        for pos := strlen(ColumnName) downto 1 do
            if ColumnName[pos] >= 65 then begin
                columnIndex += factor * ((ColumnName[pos] - 65) + 1);
                factor *= 26;
            end;

        exit(columnIndex);
    end;

    procedure GetColumnName(columnNumber: Integer): Text
    var
        dividend: Integer;
        columnName: Text;
        modulo: Integer;
        c: Char;
    begin
        dividend := columnNumber;

        while (dividend > 0) do begin
            modulo := (dividend - 1) mod 26;
            c := 65 + modulo;
            columnName := format(c) + columnName;
            dividend := (dividend - modulo) DIV 26;
        end;

        exit(columnName);
    end;
}