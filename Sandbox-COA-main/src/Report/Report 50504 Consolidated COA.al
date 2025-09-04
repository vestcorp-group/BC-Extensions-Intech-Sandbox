report 50504 "Consolidated COA"
{
    ApplicationArea = All;
    Caption = 'Consolidated COA_OLD';
    UsageCategory = ReportsAndAnalysis;
    UseRequestPage = true;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {

            RequestFilterFields = "No.";

            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                DataItemTableView = sorting("Line No.") order(ascending) where(Type = const(Item));

                trigger OnAfterGetRecord()
                var
                    RecLotTestingParameter: Record "Lot Testing Parameter";
                    ReservationEntry: Record "Reservation Entry";
                    RecCountry: Record "Country/Region";
                    ItemTestingParameter: Record "Item Testing Parameter";
                begin

                    SheetNumber += 1;

                    if not SheetCreated then
                        ExcelBuf.Reset();

                    ExcelBuf.DeleteAll();
                    Clear(ReservationEntry);
                    ReservationEntry.SetRange("Source ID", "Sales Header"."No.");
                    ReservationEntry.SetRange("Source Ref. No.", "Line No.");
                    ReservationEntry.SetRange("Source Type", Database::"Sales Line");
                    ReservationEntry.SetRange("Item No.", "No.");
                    ReservationEntry.SetFilter("Quantity (Base)", '<0');
                    ReservationEntry.SetRange("Source Subtype", 1);
                    if ReservationEntry.FindSet() then begin
                        if SheetCreated then begin
                            ExcelBuf.SetCurrent(0, 0);
                            ExcelBuf.SelectOrAddSheet(StrSubstNo("Sales Line"."No." + '_%1', SheetNumber));
                        end;
                    end;

                    Clear(ReservationEntry);
                    ReservationEntry.SetRange("Source ID", "Sales Header"."No.");
                    ReservationEntry.SetRange("Source Ref. No.", "Line No.");
                    ReservationEntry.SetRange("Source Type", Database::"Sales Line");
                    ReservationEntry.SetRange("Item No.", "No.");
                    ReservationEntry.SetFilter(Quantity, '<0');
                    ReservationEntry.SetRange("Source Subtype", 1);
                    if ReservationEntry.FindSet() then begin
                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('Certificate of Analysis', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        //ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.AddColumn(RecCompanyInfo.Name, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        //ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.AddColumn(RecCompanyInfo.Address + ', ' + RecCompanyInfo.City, FALSE, '', false, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        //ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        Clear(RecCountry);
                        if RecCompanyInfo."Country/Region Code" <> '' then begin
                            RecCountry.GET(RecCompanyInfo."Country/Region Code");
                            ExcelBuf.AddColumn(RecCountry.Name, FALSE, '', false, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        end;

                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        //ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.AddColumn('Tel: ' + RecCompanyInfo."Phone No.", FALSE, '', false, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        // ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.AddColumn('Web: ' + RecCompanyInfo."Home Page", FALSE, '', false, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        // ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.AddColumn('TRN: ' + RecCompanyInfo."VAT Registration No.", FALSE, '', false, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('Product Description', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn(Description, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        //ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.AddColumn('#Container', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn("Sales Line"."Container No. 2", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        MakeExcelDataHeader("Line No.", ReservationEntry.CustomLotNumber, ReservationEntry.CustomBOENumber);
                        repeat

                            ExcelBuf.NewRow;
                            ExcelBuf.AddColumn(ReservationEntry.CustomLotNumber, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                            Clear(RecLotTestingParameter);
                            RecLotTestingParameter.SetCurrentKey(Priority);
                            RecLotTestingParameter.SetAscending(Priority, true);
                            RecLotTestingParameter.SetRange("Item No.", "No.");
                            //RecLotTestingParameter.SetRange("Variant Code", "Variant Code");
                            RecLotTestingParameter.SetRange("Source ID", "Sales Header"."No.");
                            RecLotTestingParameter.SetRange("Lot No.", ReservationEntry.CustomLotNumber);
                            RecLotTestingParameter.SetRange("Source Ref. No.", "Line No.");
                            RecLotTestingParameter.SetRange("BOE No.", ReservationEntry.CustomBOENumber);
                            RecLotTestingParameter.SetRange("Show in COA", true);
                            if RecLotTestingParameter.FindSet() then begin
                                repeat
                                    clear(ItemTestingParameter);
                                    ItemTestingParameter.SetRange("Item No.", RecLotTestingParameter."Item No.");
                                    ItemTestingParameter.SetRange(Code, RecLotTestingParameter.Code);
                                    if ItemTestingParameter.FindFirst() then begin
                                        if ItemTestingParameter."Data Type" = ItemTestingParameter."Data Type"::Alphanumeric then begin
                                            ExcelBuf.AddColumn(RecLotTestingParameter.Value2, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                            if RecLotTestingParameter."Actual Value" <> '' then
                                                ExcelBuf.AddColumn(RecLotTestingParameter."Actual Value", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                            else
                                                if RecLotTestingParameter."Default Value" then
                                                    ExcelBuf.AddColumn('Pass', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                                else
                                                    ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                        end else begin
                                            if RecLotTestingParameter.Minimum <> 0 then
                                                ExcelBuf.AddColumn(RecLotTestingParameter.Minimum, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                            else
                                                ExcelBuf.AddColumn('-', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                            if RecLotTestingParameter."Actual Value" <> '' then
                                                ExcelBuf.AddColumn(RecLotTestingParameter."Actual Value", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                            else
                                                if RecLotTestingParameter."Default Value" then
                                                    ExcelBuf.AddColumn('Pass', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                                else
                                                    ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                            if RecLotTestingParameter.Maximum <> 0 then
                                                ExcelBuf.AddColumn(RecLotTestingParameter.Maximum, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                            else
                                                ExcelBuf.AddColumn('-', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                        end;
                                    end;
                                until RecLotTestingParameter.Next() = 0;
                                if ReservationEntry."Manufacturing Date 2" <> 0D then begin
                                    ExcelBuf.AddColumn(GetMonthName(Date2DMY(ReservationEntry."Manufacturing Date 2", 2)), FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                    ExcelBuf.AddColumn(Date2DMY(ReservationEntry."Manufacturing Date 2", 3), FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                    ExcelBuf.AddColumn(GetMonthName(Date2DMY(CalcDate(ReservationEntry."Expiry Period 2", ReservationEntry."Manufacturing Date 2"), 2)), FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                    ExcelBuf.AddColumn(Date2DMY(CalcDate(ReservationEntry."Expiry Period 2", ReservationEntry."Manufacturing Date 2"), 3), FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                end else begin
                                    ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                    ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                    ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                    ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                end;

                                if ReservationEntry."Analysis Date" <> 0D then begin
                                    ExcelBuf.AddColumn(GetMonthName(Date2DMY(ReservationEntry."Analysis Date", 2)), FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                    ExcelBuf.AddColumn(Date2DMY(ReservationEntry."Analysis Date", 3), FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                end else begin
                                    ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                    ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                end;
                            end;
                        until ReservationEntry.Next() = 0;
                        ExcelBuf.NewRow;
                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.AddColumn('Electronically generated document, signature not required', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);

                        if not SheetCreated then begin
                            SheetCreated := true;
                            ExcelBuf.CreateNewBook(StrSubstNo(ReservationEntry."Item No." + '_%1', SheetNumber));
                        end;
                        ExcelBuf.WriteSheet(Text102, COMPANYNAME, USERID);
                    end else
                        CurrReport.Skip()
                end;
            }
            trigger OnPreDataItem()
            begin

            end;
        }

    }

    trigger OnPreReport()
    begin
        Clear(RowNumber);
        SheetCreated := false;
        SheetNumber := 0;
        RecCompanyInfo.GET;
    end;


    trigger OnPostReport()
    var
        FileName: Text;
    begin
        FileName := 'COA_' + "Sales Header"."No." + DelChr(Format(CurrentDateTime), '=', ':AMPM\/ ');// + '.xlsx';
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(FileName);
        ExcelBuf.OpenExcel();
    end;


    local procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text103), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(CompanyName, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text105), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text102), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        // ExcelBuf.NewRow;
        // ExcelBuf.AddInfoColumn(FORMAT(Text108), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        // ExcelBuf.AddInfoColumn(FORMAT(VATFilters), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text104), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Consolidated COA", FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text106), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text107), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddInfoColumn(TIME, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Time);
        ExcelBuf.NewRow;
        ExcelBuf.ClearNewRow;
    end;

    local procedure MakeExcelDataHeader(LineNumber: Integer; LotNumber: Code[50]; BOE: Text[20])
    var
        RecLine: Record "Sales Line";
        RecLotTestingParameter: Record "LOT Testing Parameter";
        ReservationEntry: Record "Reservation Entry";
        ParameterCount, i, J : Integer;
        char1, char2 : char;
        ItemTestingParameter: Record "Item Testing Parameter";
        RowNumber: List of [Integer];
    begin
        char1 := 13;
        char2 := 10;
        Clear(RowNumber);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Batch / Pallet', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        Clear(RecLine);
        RecLine.SetCurrentKey("Document Type", "Document No.", "Line No.");
        RecLine.SetAscending("Line No.", true);
        RecLine.SetRange("Document Type", "Sales Header"."Document Type");
        RecLine.SetRange("Document No.", "Sales Header"."No.");
        RecLine.SetRange(Type, RecLine.Type::Item);
        RecLine.SetRange("Line No.", LineNumber);
        if RecLine.FindSet() then begin
            repeat
                Clear(ReservationEntry);
                ReservationEntry.SetRange("Source ID", "Sales Header"."No.");
                ReservationEntry.SetRange("Source Ref. No.", LineNumber);
                ReservationEntry.SetRange("Source Type", Database::"Sales Line");
                ReservationEntry.SetRange("Item No.", RecLine."No.");
                ReservationEntry.SetFilter(Quantity, '<0');
                ReservationEntry.SetRange("Source Subtype", 1);
                ReservationEntry.SetRange(CustomLotNumber, LotNumber);
                ReservationEntry.SetRange(CustomBOENumber, BOE);
                ReservationEntry.FindFirst();

                ParameterCount := 0;
                Clear(RecLotTestingParameter);
                RecLotTestingParameter.SetCurrentKey(Priority);
                RecLotTestingParameter.SetAscending(Priority, true);
                RecLotTestingParameter.SetRange("Item No.", RecLine."No.");
                RecLotTestingParameter.SetRange("Source ID", "Sales Header"."No.");
                RecLotTestingParameter.SetRange("Lot No.", ReservationEntry.CustomLotNumber);
                RecLotTestingParameter.SetRange("Source Ref. No.", LineNumber);
                RecLotTestingParameter.SetRange("BOE No.", ReservationEntry.CustomBOENumber);
                RecLotTestingParameter.SetRange("Show in COA", true);
                if RecLotTestingParameter.FindSet() then begin
                    repeat
                        ParameterCount += 1;
                        RecLotTestingParameter.CalcFields("Testing Parameter Code");
                        // ExcelBuf.AddColumn(StrSubstNo('%1\ %2', RecLotTestingParameter."Testing Parameter", RecLotTestingParameter."Testing Parameter Code"), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn(RecLotTestingParameter."Testing Parameter" + Format(char1) + Format(char2) + RecLotTestingParameter."Testing Parameter Code", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        Clear(ItemTestingParameter);
                        ItemTestingParameter.SetRange("Item No.", RecLotTestingParameter."Item No.");
                        ItemTestingParameter.SetRange(Code, RecLotTestingParameter.Code);
                        if ItemTestingParameter.FindFirst() then begin
                            if ItemTestingParameter."Data Type" = ItemTestingParameter."Data Type"::Alphanumeric then begin
                                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                                RowNumber.Add(ParameterCount);
                            end else begin
                                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                            end;
                        end;
                    until RecLotTestingParameter.Next() = 0;
                    ExcelBuf.AddColumn('Manufacturing', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Expiry', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Analysis', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    //next row  
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    for i := 1 to ParameterCount do begin
                        if RowNumber.Contains(i) then begin
                            ExcelBuf.AddColumn('Spec', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn('Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                            // ExcelBuf.AddColumn('Max', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        end else begin
                            ExcelBuf.AddColumn('Min', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn('Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                            ExcelBuf.AddColumn('Max', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        end;
                    end;
                    ExcelBuf.AddColumn('Month', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Year', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Month', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Year', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Month', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Year', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                end;
            until RecLine.Next() = 0;
        end;
    END;


    local procedure GetMonthName(Number: Integer): Text
    begin
        case Number of
            1:
                exit('January');
            2:
                exit('February');
            3:
                exit('March');
            4:
                exit('April');
            5:
                exit('May');
            6:
                exit('June');
            7:
                exit('July');
            8:
                exit('August');
            9:
                exit('September');
            10:
                exit('october');
            11:
                exit('November');
            12:
                exit('December');

        end;
    end;

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        ReportName: Label 'Certificate of Analysis';
        TenantMedia: Record "Tenant Media";
        OutStr: OutStream;
        Text101: Label 'Data';
        Text103: Label 'Certificate of Analysis';
        Text102: Label 'Certificate of Analysis';
        Text104: Label 'Report No.';
        Text105: Label 'Report Name';
        Text106: Label 'User ID';
        Text107: Label 'Date / Time';
        RowNumber: Integer;
        SheetCreated: Boolean;
        SheetNumber: Integer;
        RecCompanyInfo: Record "Company Information";
}
