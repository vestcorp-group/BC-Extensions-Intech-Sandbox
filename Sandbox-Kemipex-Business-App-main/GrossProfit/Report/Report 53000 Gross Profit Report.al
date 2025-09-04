report 53000 "Gross Profit Report"//T12370-Full Comment T12946-Code Uncommented
{
    ApplicationArea = All;
    Caption = 'Gross Profit Report';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;
    requestpage
    {
        layout
        {
            area(content)
            {
                group(General)
                {
                    field(StartDate; StartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'From';
                    }
                    field(EndDate; EndDate)
                    {
                        ApplicationArea = All;
                        Caption = 'To';

                    }
                    field(CompanyName; CompanyName)
                    {
                        ApplicationArea = All;
                        Caption = 'Company';
                        TableRelation = Company;
                    }
                    field(CustomerNo; CustomerNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Customer';
                        TableRelation = Customer;
                    }
                    field(GetDataFromOtherinstance; GetDataFromOtherinstance)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Data From Other Instance';
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    var

    begin
        Clear(RecGrossProfitG);
        RecGrossProfitG.DeleteAll(true);
    end;

    trigger OnPostReport()
    var
        Response: Text;
        TempBlob: Codeunit "Temp Blob";
        Instr: InStream;
        outStr: OutStream;
        ExportGrossProfit: XmlPort GrossProfit;
        ReplaceContent: Label '<Soap:Envelope xmlns:Soap="http://schemas.xmlsoap.org/soap/envelope/"><Soap:Body><RunReport_Result xmlns="urn:microsoft-dynamics-schemas/codeunit/GenerateGPReport"><return_value>';
        ReplaceContent2: Label '</return_value></RunReport_Result></Soap:Body></Soap:Envelope>';
    begin
        if StartDate = 0D then
            Error('From Date must have a value');
        if EndDate = 0D then
            Error('To Date must have a value');
        RowNumber := 0;

        CreateLinesForSalesInvoice();

        CreateLinesForSalesCreditMemo();

        if not IsAPICall then begin
            Commit();
            UpdateICInvoiceLineForUAESI();//updating COGS and charges in IC related Invoices for UAE ONLY
        end;

        if GetDataFromOtherinstance then begin
            if CallApi(Response) then begin
                Clear(TempBlob);
                Clear(outStr);
                Clear(Instr);
                TempBlob.CreateOutStream(outStr);//, TEXTENCODING::UTF8
                Response := Response.Replace('&lt;', '<');
                Response := Response.Replace('&gt;', '>');
                Response := Response.Replace(ReplaceContent, '');
                Response := Response.Replace(ReplaceContent2, '');
                //Response := Response.Replace('<?xml version="1.0" encoding="UTF-8" standalone="no"?>', '');
                //Response := Response.Replace('<Root xmlns="urn:microsoft-dynamics-nav/xmlports/x54500">', '<Root>');
                //Message(Response);
                outStr.WriteText(Response);
                TempBlob.CreateInStream(Instr);
                Clear(ExportGrossProfit);
                ExportGrossProfit.SetEntryNumber(RowNumber);
                ExportGrossProfit.SetSource(Instr);
                ExportGrossProfit.Import();


                //commting inserted data to work on fetched rows for IC invoices and amount conversion
                Commit();
                UpdateAmountForIndianInvoices();
                UpdateICInvoiceLineForIndianSI();
            end else
                Error(Response);
        end;

        if not IsAPICall then begin
            //need to call API then run pages
            //Create fields in company information for API URL and keys
            Page.Run(Page::"Gross Profit Report");

        end;

    end;

    procedure InitializeReportParameter(StartDt: Date; EndDt: Date; IsAPI: Boolean)
    begin
        StartDate := StartDt;
        EndDate := EndDt;
        IsApiCall := IsAPI;
    end;





    local procedure CreateLinesForSalesInvoice()
    var
        RecSalesInvHeader: Record "Sales Invoice Header";
        RecSalesinvLines: Record "Sales Invoice Line";
        Companies: Record Company;
        ShortName: Record "Company Short Name";
        ShortName2: Record "Company Short Name";
        RecSHeader: Record "Sales Header";
        RecSalesPerson: Record "Salesperson/Purchaser";
        RecItem: Record Item;
        Recteams: Record Team;
        RecteamSalesPerson: Record "Team Salesperson";
        RecValueEntry: Record "Value Entry";
        RecValueEntry2: Record "Value Entry";
        RecSalesinvLines2: Record "Sales Invoice Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
        RecEntryExit: Record "Entry/Exit Point";
        RecAre: Record "Area";
        ICCompanyList: Record Company;
        ICCOGSLCY: Decimal;
        ICValueEntry: Record "Value Entry";
        ICValueEntry2: Record "Value Entry";
        ICSalesOrderInvoiceLines: Record "Sales Invoice Line";
        ICPartners: Record "IC Partner";
        TotalDiscountAmount: Decimal;
        RecValueRelationEntry: Record "Value Entry Relation";
        RecILE: Record "Item Ledger Entry";
        RecILE2: Record "Item Ledger Entry";
        RecVLE: Record "Value Entry";
        RecVendor: Record Vendor;
        RecPurchInvHdr: Record "Purch. Inv. Header";
        ExcludeForIndiaIC: Boolean;
        RecCsutomerL: Record Customer;
        InvoicedQty: Decimal;
        RecICPartner: Record "IC Partner";
    begin

        Clear(Companies);
        if CompanyName <> '' then
            Companies.SetRange(Name, CompanyName);
        Companies.FindSet();
        repeat
            Clear(ShortName);
            ShortName.SetRange(Name, Companies.Name);
            ShortName.SetRange("Block in Reports", true);
            if not ShortName.FindFirst() then begin
                Clear(ShortName2);
                ShortName2.SetRange(Name, Companies.Name);
                ShortName2.FindFirst();
                Clear(RecSalesInvHeader);
                RecSalesInvHeader.ChangeCompany(Companies.Name);
                RecSalesInvHeader.SetRange("Posting Date", StartDate, EndDate);
                if CustomerNo <> '' then
                    RecSalesInvHeader.SetRange("Sell-to Customer No.", CustomerNo);
                if RecSalesInvHeader.FindSet() then
                //coment
                begin
                    repeat
                        CLEAR(ICPartners);
                        ICPartners.ChangeCompany(Companies.Name);
                        ICPartners.SETRANGE("Customer No.", RecSalesInvHeader."Sell-to Customer No.");
                        IF not ICPartners.FINDFIRST THEN
                        //coment
                        begin
                            ExcludeForIndiaIC := false;//settings default value

                            //checking IC customer for india environment to exclude those customers
                            Clear(RecCsutomerL);
                            RecCsutomerL.ChangeCompany(Companies.Name);
                            if RecSalesInvHeader."Sell-to Customer No." <> '' then // added by baya
                                RecCsutomerL.GET(RecSalesInvHeader."Sell-to Customer No.");
                            if IsAPICall AND (RecCsutomerL."IC Company Code" <> '') then
                                ExcludeForIndiaIC := true;

                            if ExcludeForIndiaIC = false then
                            //comment
                            begin
                                Clear(RecSalesinvLines);
                                RecSalesinvLines.ChangeCompany(Companies.Name);
                                RecSalesinvLines.SetRange("Document No.", RecSalesInvHeader."No.");
                                RecSalesinvLines.SetRange(Type, RecSalesinvLines.Type::Item);
                                if RecSalesinvLines.FindSet() then
                                //coment
                                begin
                                    repeat
                                        Clear(RecItem);
                                        RecItem.ChangeCompany(Companies.Name);
                                        RecItem.GET(RecSalesinvLines."No.");
                                        if RecItem."Inventory Posting Group" <> 'SAMPLE' then begin
                                            RecGrossProfitG.Init();
                                            RowNumber += 1;
                                            RecGrossProfitG."Entry No." := RowNumber;
                                            RecGrossProfitG.Insert(true);
                                            RecGrossProfitG."Document Type" := RecGrossProfitG."Document Type"::Invoice;
                                            RecGrossProfitG."Group Co." := ShortName2."Short Name";
                                            //Clear(RecSHeader);

                                            RecGrossProfitG."SO Date" := RecSalesInvHeader."Order Date";
                                            RecGrossProfitG."SO No." := RecSalesInvHeader."Order No.";
                                            RecGrossProfitG."SI Date" := RecSalesInvHeader."Posting Date";
                                            RecGrossProfitG."SI No." := RecSalesInvHeader."No.";
                                            if RecSalesInvHeader."Exit Point" <> '' then begin
                                                Clear(RecEntryExit);
                                                RecEntryExit.ChangeCompany(Companies.Name);
                                                RecEntryExit.GET(RecSalesInvHeader."Exit Point");
                                                RecGrossProfitG.POL := RecEntryExit.Description;
                                            end;
                                            if RecSalesInvHeader."Area" <> '' then begin
                                                Clear(RecAre);
                                                RecAre.ChangeCompany(Companies.Name);
                                                RecAre.GET(RecSalesInvHeader."Area");
                                                RecGrossProfitG.POD := RecAre."Text";
                                            end;

                                            RecGrossProfitG."Customer Code" := RecSalesInvHeader."Sell-to Customer No.";
                                            RecGrossProfitG."Customer Short Name" := RecSalesInvHeader."Customer Short Name";
                                            RecGrossProfitG."Customer Name" := RecSalesInvHeader."Sell-To Customer Name";
                                            RecGrossProfitG."Customer Incentive Point (CIP)" := RecSalesInvHeader."Customer Incentive Point (CIP)";
                                            Clear(RecteamSalesPerson);
                                            RecteamSalesPerson.ChangeCompany(Companies.Name);
                                            RecteamSalesPerson.SetRange("Salesperson Code", RecSalesInvHeader."Salesperson Code");
                                            if RecteamSalesPerson.FindFirst() then begin
                                                Clear(Recteams);
                                                Recteams.ChangeCompany(Companies.Name);
                                                Recteams.GET(RecteamSalesPerson."Team Code");
                                                RecGrossProfitG.Teams := Recteams.Name;
                                                RecteamSalesPerson.CalcFields("Salesperson Name");
                                                RecGrossProfitG."Salesperson Name" := RecteamSalesPerson."Salesperson Name";
                                            end;
                                            RecGrossProfitG.Incoterm := RecSalesInvHeader."Transaction Specification";
                                            RecGrossProfitG."Item Code" := RecSalesinvLines."No.";
                                            RecGrossProfitG."Item Short Name" := RecItem."Search Description";
                                            RecGrossProfitG."Item Category" := RecItem."Item Category Desc.";
                                            RecGrossProfitG."Item Market Industry" := RecItem."Market Industry Desc.";
                                            RecGrossProfitG."Variant Code" := RecSalesinvLines."Variant Code";//Hypercare 17-02-2025
                                            RecGrossProfitG."Item Incentive Point (IIP)" := RecSalesinvLines."Item Incentive Point (IIP)";
                                            RecGrossProfitG."Base UOM" := RecSalesinvLines."Base UOM 2";
                                            RecGrossProfitG.QTY := RecSalesinvLines."Quantity (Base)";

                                            Clear(GeneralLedgerSetup);
                                            GeneralLedgerSetup.ChangeCompany(Companies.Name);
                                            GeneralLedgerSetup.GET;
                                            IF RecSalesInvHeader."Currency Code" <> '' THEN
                                                RecGrossProfitG.CUR := RecSalesInvHeader."Currency Code"
                                            ELSE
                                                RecGrossProfitG.CUR := GeneralLedgerSetup."LCY Code";

                                            RecGrossProfitG."Base UOM Price" := RecSalesinvLines."Unit Price Base UOM 2";
                                            RecGrossProfitG."Total Amount" := RecSalesinvLines."Quantity (Base)" * RecSalesinvLines."Unit Price Base UOM 2";


                                            Clear(RecValueEntry);
                                            RecValueEntry.ChangeCompany(Companies.Name);
                                            RecValueEntry.SETRANGE("Document No.", RecSalesinvLines."Document No.");
                                            RecValueEntry.SETRANGE("Document Line No.", RecSalesinvLines."Line No.");
                                            RecValueEntry.SETRANGE("Item No.", RecSalesinvLines."No.");
                                            RecValueEntry.SETRANGE(Adjustment, FALSE);
                                            IF RecValueEntry.FINDFIRST THEN
                                                REPEAT
                                                    Clear(RecValueEntry2);
                                                    RecValueEntry2.ChangeCompany(Companies.Name);
                                                    RecValueEntry2.SETRANGE("Document No.", RecSalesinvLines."Document No.");
                                                    RecValueEntry2.SETRANGE("Item Ledger Entry No.", RecValueEntry."Item Ledger Entry No.");
                                                    RecValueEntry2.SETFILTER("Item Charge No.", '<>%1', '');
                                                    RecValueEntry2.SETRANGE("Item No.", RecValueEntry."Item No.");
                                                    IF RecValueEntry2.FINDFIRST THEN
                                                        REPEAT
                                                            RecGrossProfitG."Other Revenue (LCY)" += RecValueEntry2."Sales Amount (Actual)";
                                                        UNTIL RecValueEntry2.NEXT = 0;
                                                UNTIL RecValueEntry.NEXT = 0;

                                            //+
                                            Clear(InvoicedQty);
                                            Clear(RecValueEntry);
                                            RecValueEntry.ChangeCompany(Companies.Name);
                                            RecValueEntry.SETRANGE("Document No.", RecSalesinvLines."Document No.");
                                            RecValueEntry.SETRANGE("Document Line No.", RecSalesinvLines."Line No.");
                                            IF RecValueEntry.FINDFIRST THEN
                                                REPEAT
                                                    RecGrossProfitG."Cogs (LCY)" += (RecValueEntry."Cost Amount (Actual)" * -1);
                                                    InvoicedQty += ABS(RecValueEntry."Invoiced Quantity");
                                                UNTIL RecValueEntry.NEXT = 0;
                                            if RecGrossProfitG."Cogs (LCY)" <> 0 then
                                                RecGrossProfitG."Cogs (LCY)" := (RecGrossProfitG."Cogs (LCY)" / InvoicedQty) * RecGrossProfitG.QTY;

                                            //-



                                            Clear(RecValueEntry);
                                            RecValueEntry.ChangeCompany(Companies.Name);
                                            RecValueEntry.SETRANGE("Document No.", RecSalesinvLines."Document No.");
                                            RecValueEntry.SETRANGE("Document Line No.", RecSalesinvLines."Line No.");
                                            RecValueEntry.SETRANGE("Item No.", RecSalesinvLines."No.");
                                            RecValueEntry.SETRANGE(Adjustment, FALSE);
                                            IF RecValueEntry.FINDFIRST THEN
                                             //coment
                                             BEGIN
                                                REPEAT
                                                    Clear(RecValueEntry2);
                                                    RecValueEntry2.ChangeCompany(Companies.Name);
                                                    RecValueEntry2.SETRANGE("Item Ledger Entry No.", RecValueEntry."Item Ledger Entry No.");
                                                    RecValueEntry2.SETFILTER("Item Charge No.", '<>%1', '');
                                                    RecValueEntry2.SETRANGE("Item No.", RecValueEntry."Item No.");
                                                    RecValueEntry2.SETFILTER("Item Ledger Entry Type", '<>%1', RecValueEntry."Item Ledger Entry Type"::Sale);
                                                    IF RecValueEntry2.FINDFIRST THEN
                                                        REPEAT
                                                            IF RecValueEntry2."Item Charge No." = '01' THEN
                                                                RecGrossProfitG."EXP-FRT" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                            ELSE
                                                                IF RecValueEntry2."Item Charge No." = '02' THEN
                                                                    RecGrossProfitG."EXP-CDT" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                ELSE
                                                                    IF RecValueEntry2."Item Charge No." = '03' THEN
                                                                        RecGrossProfitG."EXP-INS" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                    ELSE
                                                                        IF RecValueEntry2."Item Charge No." = '04' THEN
                                                                            RecGrossProfitG."EXP-TRC" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                        ELSE
                                                                            IF RecValueEntry2."Item Charge No." = '05' THEN
                                                                                RecGrossProfitG."EXP-THC" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                            ELSE
                                                                                IF RecValueEntry2."Item Charge No." = '06' THEN
                                                                                    RecGrossProfitG."EXP-SERV" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                ELSE
                                                                                    IF RecValueEntry2."Item Charge No." = '07' THEN
                                                                                        RecGrossProfitG."EXP-OTHER" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                    ELSE
                                                                                        IF RecValueEntry2."Item Charge No." = '09' THEN
                                                                                            RecGrossProfitG."EXP-WH HNDL" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                        ELSE
                                                                                            IF RecValueEntry2."Item Charge No." = '10' THEN
                                                                                                RecGrossProfitG."EXP-INPC" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                            ELSE
                                                                                                IF RecValueEntry2."Item Charge No." = '21' THEN
                                                                                                    RecGrossProfitG."EXP-WH PACK" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                                ELSE
                                                                                                    IF RecValueEntry2."Item Charge No." = '24' THEN
                                                                                                        RecGrossProfitG."EXP-COO" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                                    ELSE
                                                                                                        IF RecValueEntry2."Item Charge No." = '26' THEN
                                                                                                            RecGrossProfitG."EXP-LEGAL" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                                        ELSE
                                                                                                            IF RecValueEntry2."Item Charge No." = '32' THEN
                                                                                                                RecGrossProfitG."REBATE TO CUSTOMER" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                                            ELSE
                                                                                                                IF RecValueEntry2."Item Charge No." = '33' THEN
                                                                                                                    RecGrossProfitG."DEMURRAGE CHARGES" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                                                ELSE
                                                                                                                    RecGrossProfitG."Other Charges" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY;

                                                        UNTIL RecValueEntry2.NEXT = 0;
                                                UNTIL RecValueEntry.NEXT = 0;
                                            END;

                                            //moved cogs code to above expense

                                            Clear(TotalDiscountAmount);
                                            Clear(TotalSalesInvoiceLineAmount);

                                            CLEAR(RecSalesinvLines2);
                                            RecSalesinvLines2.ChangeCompany(Companies.Name);
                                            RecSalesinvLines2.RESET;
                                            RecSalesinvLines2.SETRANGE("Document No.", RecSalesinvLines."Document No.");
                                            RecSalesinvLines2.SETRANGE(Type, RecSalesinvLines.Type::"G/L Account");
                                            IF RecSalesinvLines2.FINDFIRST THEN
                                                REPEAT
                                                    Clear(GeneralLedgerSetup);
                                                    GeneralLedgerSetup.ChangeCompany(Companies.Name);
                                                    GeneralLedgerSetup.RESET;
                                                    GeneralLedgerSetup.SETFILTER("GP G/L Accounts", '@*' + RecSalesinvLines2."No." + '*');
                                                    IF GeneralLedgerSetup.FINDFIRST THEN BEGIN
                                                        TotalDiscountAmount += RecSalesinvLines2."Quantity (Base)" * RecSalesinvLines2."Unit Price Base UOM 2";  //PackingListExtChange
                                                    END;
                                                UNTIL RecSalesinvLines2.NEXT = 0;

                                            IF TotalDiscountAmount <> 0 THEN BEGIN
                                                Clear(RecSalesinvLines2);
                                                RecSalesinvLines2.ChangeCompany(Companies.Name);
                                                RecSalesinvLines2.SETRANGE("Document No.", RecSalesinvLines."Document No.");
                                                RecSalesinvLines2.SETRANGE(Type, RecSalesinvLines2.Type::Item);
                                                IF RecSalesinvLines2.FINDFIRST THEN
                                                    REPEAT
                                                        TotalSalesInvoiceLineAmount += RecSalesinvLines2."Quantity (Base)" * RecSalesinvLines2."Unit Price Base UOM 2"; //PackingListExtChange
                                                    UNTIL RecSalesinvLines2.NEXT = 0;
                                                CurrentLineAmount := RecSalesinvLines."Quantity (Base)" * RecSalesinvLines."Unit Price Base UOM 2"; //PackingListExtChange

                                                IF TotalSalesInvoiceLineAmount <> 0 THEN
                                                    RecGrossProfitG."Total Sales Discount" := (CurrentLineAmount / TotalSalesInvoiceLineAmount) * RecGrossProfitG."Total Sales Discount";
                                            END;


                                            //IC charges and cost calculation-start
                                            Clear(ICCOGSLCY);
                                            IF RecGrossProfitG."SO No." <> '' THEN
                                            //coment
                                            BEGIN
                                                Clear(ICCompanyList);
                                                IF ICCompanyList.FindFirst() THEN
                                                    REPEAT
                                                        CLEAR(ICSalesOrderInvoiceLines);
                                                        ICSalesOrderInvoiceLines.ChangeCompany(ICCompanyList.Name);
                                                        ICSalesOrderInvoiceLines.RESET;
                                                        ICSalesOrderInvoiceLines.SETRANGE("IC Related SO", RecGrossProfitG."SO No.");
                                                        ICSalesOrderInvoiceLines.SETRANGE("No.", RecSalesinvLines."No.");
                                                        IF ICSalesOrderInvoiceLines.FindFirst() THEN
                                                     //coment
                                                     BEGIN
                                                            REPEAT
                                                                Clear(InvoicedQty);
                                                                Clear(ICCOGSLCY);
                                                                CLEAR(ICValueEntry);
                                                                ICValueEntry.ChangeCompany(ICCompanyList.Name);
                                                                ICValueEntry.RESET;
                                                                ICValueEntry.SETRANGE("Document No.", ICSalesOrderInvoiceLines."Document No.");
                                                                ICValueEntry.SETRANGE("Document Line No.", ICSalesOrderInvoiceLines."Line No.");
                                                                IF ICValueEntry.FINDFIRST THEN
                                                                    REPEAT
                                                                        ICCOGSLCY += (ICValueEntry."Cost Amount (Actual)" * -1);
                                                                        InvoicedQty += ABS(ICValueEntry."Invoiced Quantity");
                                                                    UNTIL ICValueEntry.NEXT = 0;
                                                                if ICCOGSLCY <> 0 then
                                                                    ICCOGSLCY := (ICCOGSLCY / InvoicedQty) * RecGrossProfitG.QTY;
                                                                ICValueEntry2.ChangeCompany(ICCompanyList.Name);

                                                                //Purchase Charges
                                                                ICValueEntry.RESET;
                                                                ICValueEntry.SETRANGE("Document No.", ICSalesOrderInvoiceLines."Document No.");
                                                                ICValueEntry.SETRANGE("Document Line No.", ICSalesOrderInvoiceLines."Line No.");
                                                                ICValueEntry.SETRANGE("Item No.", ICSalesOrderInvoiceLines."No.");
                                                                ICValueEntry.SETRANGE(Adjustment, FALSE);
                                                                IF ICValueEntry.FINDFIRST THEN
                                                                //coment
                                                                BEGIN
                                                                    REPEAT
                                                                        ICValueEntry2.RESET;
                                                                        ICValueEntry2.SETRANGE("Item Ledger Entry No.", ICValueEntry."Item Ledger Entry No.");
                                                                        ICValueEntry2.SETFILTER("Item Charge No.", '<>%1', '');
                                                                        ICValueEntry2.SETRANGE("Item No.", ICValueEntry."Item No.");
                                                                        ICValueEntry2.SETFILTER("Item Ledger Entry Type", '<>%1', ICValueEntry2."Item Ledger Entry Type"::Sale);
                                                                        // IF ChargeItemFilter <> '' THEN
                                                                        //     ICValueEntry2.SETFILTER("Item Charge No.", ChargeItemFilter);
                                                                        IF ICValueEntry2.FINDFIRST THEN
                                                                            REPEAT
                                                                                IF ICValueEntry2."Item Charge No." = '01' THEN
                                                                                    RecGrossProfitG."EXP-FRT" += ((ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                ELSE
                                                                                    IF ICValueEntry2."Item Charge No." = '02' THEN
                                                                                        RecGrossProfitG."EXP-CDT" += ((ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                    ELSE
                                                                                        IF ICValueEntry2."Item Charge No." = '03' THEN
                                                                                            RecGrossProfitG."EXP-INS" += ((ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                        ELSE
                                                                                            IF ICValueEntry2."Item Charge No." = '04' THEN
                                                                                                RecGrossProfitG."EXP-TRC" += ((ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                            ELSE
                                                                                                IF ICValueEntry2."Item Charge No." = '05' THEN
                                                                                                    RecGrossProfitG."EXP-THC" += ((ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                                ELSE
                                                                                                    IF ICValueEntry2."Item Charge No." = '06' THEN
                                                                                                        RecGrossProfitG."EXP-SERV" += ((ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                                    ELSE
                                                                                                        IF ICValueEntry2."Item Charge No." = '07' THEN
                                                                                                            RecGrossProfitG."EXP-OTHER" += ((ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                                        ELSE
                                                                                                            IF ICValueEntry2."Item Charge No." = '09' THEN
                                                                                                                RecGrossProfitG."EXP-WH HNDL" += ((ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                                            ELSE
                                                                                                                IF ICValueEntry2."Item Charge No." = '10' THEN
                                                                                                                    RecGrossProfitG."EXP-INPC" += ((ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                                                ELSE
                                                                                                                    IF ICValueEntry2."Item Charge No." = '21' THEN
                                                                                                                        RecGrossProfitG."EXP-WH PACK" += ((ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                                                    ELSE
                                                                                                                        IF ICValueEntry2."Item Charge No." = '24' THEN
                                                                                                                            RecGrossProfitG."EXP-COO" += ((ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                                                        ELSE
                                                                                                                            IF ICValueEntry2."Item Charge No." = '26' THEN
                                                                                                                                RecGrossProfitG."EXP-LEGAL" += ((ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                                                            ELSE
                                                                                                                                IF ICValueEntry2."Item Charge No." = '32' THEN
                                                                                                                                    RecGrossProfitG."REBATE TO CUSTOMER" += ((ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                                                                ELSE
                                                                                                                                    IF ICValueEntry2."Item Charge No." = '33' THEN
                                                                                                                                        RecGrossProfitG."DEMURRAGE CHARGES" += ((ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                                                                    ELSE
                                                                                                                                        RecGrossProfitG."Other Charges" += ((ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY;
                                                                            UNTIL ICValueEntry2.NEXT = 0;
                                                                    UNTIL ICValueEntry.NEXT = 0;
                                                                END;
                                                            //Purchase Charges
                                                            UNTIL ICSalesOrderInvoiceLines.NEXT = 0;
                                                        END;
                                                    UNTIL ICCompanyList.NEXT = 0;
                                                IF ICCOGSLCY <> 0 THEN
                                                    RecGrossProfitG."Cogs (LCY)" := ICCOGSLCY;
                                            END;
                                            //- IC end

                                            //- IC which has no IC Related SO but IC Partner code is there in vendor card -start
                                            // Clear(ICSalesOrderInvoiceLines);
                                            // ICSalesOrderInvoiceLines.
                                            //-end
                                            Clear(RecValueEntry);
                                            RecValueEntry.ChangeCompany(Companies.Name);
                                            RecValueEntry.SetRange("Document No.", RecSalesInvHeader."No.");
                                            RecValueEntry.SetRange("Item No.", RecSalesinvLines."No.");
                                            RecValueEntry.SetRange(Adjustment, false);
                                            RecValueEntry.SetRange("Document Line No.", RecSalesinvLines."Line No.");
                                            if RecValueEntry.FindSet() then begin
                                                REPEAT
                                                    RecGrossProfitG."Total Amount (LCY)" += RecValueEntry."Sales Amount (Actual)";
                                                UNTIL RecValueEntry.NEXT = 0;
                                            end;
                                            RecGrossProfitG."Total Amount (LCY)" := RecGrossProfitG."Total Amount (LCY)" + RecGrossProfitG."Other Revenue (LCY)";


                                            RecGrossProfitG."Total Sales Expenses (LCY)" := RecGrossProfitG."EXP-CDT" + RecGrossProfitG."EXP-COO" + RecGrossProfitG."EXP-FRT" + RecGrossProfitG."EXP-INPC" + RecGrossProfitG."EXP-INS" + RecGrossProfitG."EXP-LEGAL" + RecGrossProfitG."EXP-OTHER" + RecGrossProfitG."EXP-SERV" + RecGrossProfitG."EXP-THC" + RecGrossProfitG."EXP-TRC" + RecGrossProfitG."EXP-WH HNDL" + RecGrossProfitG."EXP-WH PACK" + RecGrossProfitG."REBATE TO CUSTOMER" + RecGrossProfitG."DEMURRAGE CHARGES" + RecGrossProfitG."Other Charges";
                                            RecGrossProfitG."COS (LCY)" := RecGrossProfitG."Cogs (LCY)" + RecGrossProfitG."Total Sales Expenses (LCY)";
                                            RecGrossProfitG."Eff GP (LCY)" := RecGrossProfitG."Total Amount (LCY)" - RecGrossProfitG."COS (LCY)";

                                            if RecGrossProfitG."Total Amount (LCY)" <> 0 then
                                                RecGrossProfitG."Eff GP %" := RecGrossProfitG."Eff GP (LCY)" * 100 / (RecGrossProfitG."Total Amount (LCY)")
                                            else
                                                RecGrossProfitG."Eff GP %" := RecGrossProfitG."Eff GP (LCY)" * 100 / 1;


                                            //FOr indian environment to get company Id and custome BOE
                                            if IsAPICall then begin
                                                Clear(RecValueRelationEntry);
                                                RecValueRelationEntry.SetCurrentKey("Source RowId");
                                                RecValueRelationEntry.SetRange("Source RowId", RowID1(RecSalesinvLines));
                                                if RecValueRelationEntry.Find('-') then begin
                                                    Clear(RecValueEntry);
                                                    RecValueEntry.SetRange("Entry No.", RecValueRelationEntry."Value Entry No.");
                                                    if RecValueEntry.FindFirst() then begin
                                                        Clear(RecILE);
                                                        RecILE.SetRange("Entry No.", RecValueEntry."Item Ledger Entry No.");
                                                        if RecILE.FindFirst() then begin
                                                            Clear(RecILE2);
                                                            RecILE2.SetCurrentKey("Entry No.", "Posting Date");
                                                            RecILE2.SetAscending("Posting Date", false);
                                                            RecILE2.SetRange("Item No.", RecSalesinvLines."No.");
                                                            RecILE2.SetRange(CustomLotNumber, RecILE.CustomLotNumber);
                                                            RecILE2.SetFilter("Posting Date", '<=%1', RecILE."Posting Date");
                                                            RecILE2.SetRange("Entry Type", RecILE2."Entry Type"::Purchase);
                                                            RecILE2.SetRange("Document Type", RecILE2."Document Type"::"Purchase Receipt");
                                                            if RecILE2.FindLast() then begin
                                                                if RecILE2."Source Type" = RecILE2."Source Type"::Vendor then begin
                                                                    Clear(RecVendor);
                                                                    RecVendor.GET(RecILE2."Source No.");
                                                                    if RecVendor."IC Company Code" <> '' then begin
                                                                        RecGrossProfitG."IC Company Code" := RecVendor."IC Company Code";
                                                                        RecGrossProfitG."Custom LOT No." := RecILE2.CustomLotNumber;
                                                                        Clear(RecVLE);
                                                                        RecVLE.SetRange("Item Ledger Entry No.", RecILE2."Entry No.");
                                                                        RecVLE.SetRange("Entry Type", RecVLE."Entry Type"::"Direct Cost");
                                                                        RecVLE.SetRange("Document Type", RecVLE."Document Type"::"Purchase Invoice");
                                                                        RecVLE.SetFilter("Invoiced Quantity", '<>0');
                                                                        if RecVLE.FindFirst() then begin
                                                                            Clear(RecPurchInvHdr);
                                                                            RecPurchInvHdr.SetRange("No.", RecVLE."Document No.");
                                                                            if RecPurchInvHdr.FindFirst() then begin
                                                                                RecGrossProfitG."Vendor Invoice No." := RecPurchInvHdr."Vendor Invoice No.";
                                                                            end;
                                                                        end;
                                                                    end;
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                                RecGrossProfitG."Created By Other Instance" := true;
                                            end;

                                            if not IsAPICall then begin
                                                if ICCOGSLCY = 0 then begin
                                                    //added for same instance IC -start
                                                    Clear(RecValueRelationEntry);
                                                    RecValueRelationEntry.ChangeCompany(Companies.Name);
                                                    RecValueRelationEntry.SetCurrentKey("Source RowId");
                                                    RecValueRelationEntry.SetRange("Source RowId", RowID1(RecSalesinvLines));
                                                    if RecValueRelationEntry.Find('-') then begin
                                                        Clear(RecValueEntry);
                                                        RecValueEntry.ChangeCompany(Companies.Name);
                                                        RecValueEntry.SetRange("Entry No.", RecValueRelationEntry."Value Entry No.");
                                                        if RecValueEntry.FindFirst() then begin
                                                            Clear(RecILE);
                                                            RecILE.ChangeCompany(Companies.Name);
                                                            RecILE.SetRange("Entry No.", RecValueEntry."Item Ledger Entry No.");
                                                            if RecILE.FindFirst() then begin
                                                                Clear(RecILE2);
                                                                RecILE2.ChangeCompany(Companies.Name);
                                                                RecILE2.SetCurrentKey("Entry No.", "Posting Date");
                                                                RecILE2.SetAscending("Posting Date", false);
                                                                RecILE2.SetRange("Item No.", RecSalesinvLines."No.");
                                                                RecILE2.SetRange(CustomLotNumber, RecILE.CustomLotNumber);
                                                                RecILE2.SetFilter("Posting Date", '<=%1', RecILE."Posting Date");
                                                                RecILE2.SetRange("Entry Type", RecILE2."Entry Type"::Purchase);
                                                                RecILE2.SetRange("Document Type", RecILE2."Document Type"::"Purchase Receipt");
                                                                if RecILE2.FindLast() then begin
                                                                    if RecILE2."Source Type" = RecILE2."Source Type"::Vendor then begin
                                                                        Clear(RecVendor);
                                                                        RecVendor.ChangeCompany(Companies.Name);
                                                                        RecVendor.GET(RecILE2."Source No.");
                                                                        if RecVendor."IC Partner Code" <> '' then begin
                                                                            Clear(RecICPartner);
                                                                            RecICPartner.ChangeCompany(Companies.Name);
                                                                            RecICPartner.GET(RecVendor."IC Partner Code");
                                                                            if RecICPartner."Inbox Type" = RecICPartner."Inbox Type"::Database then begin
                                                                                RecGrossProfitG."IC Company Code" := RecICPartner."Inbox Details";
                                                                                RecGrossProfitG."Custom LOT No." := RecILE2.CustomLotNumber;
                                                                                Clear(RecVLE);
                                                                                RecVLE.ChangeCompany(Companies.Name);
                                                                                RecVLE.SetRange("Item Ledger Entry No.", RecILE2."Entry No.");
                                                                                RecVLE.SetRange("Entry Type", RecVLE."Entry Type"::"Direct Cost");
                                                                                RecVLE.SetRange("Document Type", RecVLE."Document Type"::"Purchase Invoice");
                                                                                RecVLE.SetFilter("Invoiced Quantity", '<>0');
                                                                                if RecVLE.FindFirst() then begin
                                                                                    Clear(RecPurchInvHdr);
                                                                                    RecPurchInvHdr.ChangeCompany(Companies.Name);
                                                                                    RecPurchInvHdr.SetRange("No.", RecVLE."Document No.");
                                                                                    if RecPurchInvHdr.FindFirst() then begin
                                                                                        RecGrossProfitG."Created By Other Instance" := false;
                                                                                        RecGrossProfitG."Vendor Invoice No." := RecPurchInvHdr."Vendor Invoice No.";
                                                                                    end;
                                                                                end;
                                                                            end;
                                                                        end;
                                                                    end;
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                    //-end
                                                end;
                                            end;
                                            RecGrossProfitG.Modify(true);
                                        end;
                                    until RecSalesinvLines.Next() = 0;
                                end;
                            end;
                        end;
                    until RecSalesInvHeader.Next() = 0;
                end;
            end;
        until Companies.Next() = 0;
    end;


    local procedure CreateLinesForSalesCreditMemo()
    var
        RecSalesCrMemoHeader: Record "Sales Cr.Memo Header";
        RecSalesCrMemoLines: Record "Sales Cr.Memo Line";
        Companies: Record Company;
        ShortName: Record "Company Short Name";
        ShortName2: Record "Company Short Name";
        RecSalesPerson: Record "Salesperson/Purchaser";
        RecItem: Record Item;
        Recteams: Record Team;
        RecteamSalesPerson: Record "Team Salesperson";
        RecValueEntry: Record "Value Entry";
        RecValueEntry2: Record "Value Entry";
        RecSalesCrMemoLines2: Record "Sales Cr.Memo Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
        RecEntryExit: Record "Entry/Exit Point";
        RecAre: Record "Area";
        ICPartners: Record "IC Partner";
        TotalDiscountAmount, InvoicedQty : Decimal;
        RecCustomerL: Record Customer;
    begin
        //Credit Memo-start

        Clear(Companies);
        if CompanyName <> '' then
            Companies.SetRange(Name, CompanyName);

        Companies.FindSet();
        repeat
            Clear(ShortName);
            ShortName.SetRange(Name, Companies.Name);
            ShortName.SetRange("Block in Reports", true);
            if not ShortName.FindFirst() then begin
                Clear(ShortName2);
                ShortName2.SetRange(Name, Companies.Name);
                ShortName2.FindFirst();
                Clear(RecSalesCrMemoHeader);
                RecSalesCrMemoHeader.ChangeCompany(Companies.Name);
                RecSalesCrMemoHeader.SetRange("Posting Date", StartDate, EndDate);
                if CustomerNo <> '' then
                    RecSalesCrMemoHeader.SetRange("Sell-to Customer No.", CustomerNo);
                if RecSalesCrMemoHeader.FindSet() then
                //comment
                begin
                    repeat
                        CLEAR(ICPartners);
                        ICPartners.ChangeCompany(Companies.Name);
                        ICPartners.SETRANGE("Customer No.", RecSalesCrMemoHeader."Sell-to Customer No.");
                        IF not ICPartners.FINDFIRST THEN begin
                            Clear(RecCustomerL);
                            RecCustomerL.ChangeCompany(Companies.Name);
                            RecCustomerL.GET(RecSalesCrMemoHeader."Sell-to Customer No.");
                            if not RecCustomerL."Hide in Reports" then begin
                                Clear(RecSalesCrMemoLines);
                                RecSalesCrMemoLines.ChangeCompany(Companies.Name);
                                RecSalesCrMemoLines.SetRange("Document No.", RecSalesCrMemoHeader."No.");
                                RecSalesCrMemoLines.SetFilter(Type, '%1|%2', RecSalesCrMemoLines.Type::Item, RecSalesCrMemoLines.Type::"G/L Account");
                                if RecSalesCrMemoLines.FindSet() then begin
                                    repeat
                                        if RecSalesCrMemoLines.Type = RecSalesCrMemoLines.Type::Item then begin
                                            Clear(RecItem);
                                            RecItem.ChangeCompany(Companies.Name);
                                            RecItem.GET(RecSalesCrMemoLines."No.");
                                            if RecItem."Inventory Posting Group" <> 'SAMPLE' then begin
                                                RecGrossProfitG.Init();
                                                RowNumber += 1;
                                                RecGrossProfitG."Entry No." := RowNumber;
                                                RecGrossProfitG.Insert(true);
                                                RecGrossProfitG."Document Type" := RecGrossProfitG."Document Type"::"Credit Memo";
                                                RecGrossProfitG."Group Co." := ShortName2."Short Name";
                                                //Clear(RecSHeader);

                                                //RecGrossProfit."SO Date" := RecSalesCrMemoHeader."Order Date";
                                                //RecGrossProfit."SO No." := RecSalesCrMemoHeader."Order No.";
                                                RecGrossProfitG."SI Date" := RecSalesCrMemoHeader."Posting Date";
                                                RecGrossProfitG."SI No." := RecSalesCrMemoHeader."No.";
                                                if RecSalesCrMemoHeader."Exit Point" <> '' then begin
                                                    Clear(RecEntryExit);
                                                    RecEntryExit.ChangeCompany(Companies.Name);
                                                    RecEntryExit.GET(RecSalesCrMemoHeader."Exit Point");
                                                    RecGrossProfitG.POL := RecEntryExit.Description;
                                                end;
                                                if RecSalesCrMemoHeader."Area" <> '' then begin
                                                    Clear(RecAre);
                                                    RecAre.ChangeCompany(Companies.Name);
                                                    RecAre.GET(RecSalesCrMemoHeader."Area");
                                                    RecGrossProfitG.POD := RecAre."Text";
                                                end;

                                                RecGrossProfitG."Customer Code" := RecSalesCrMemoHeader."Sell-to Customer No.";
                                                RecGrossProfitG."Customer Short Name" := RecSalesCrMemoHeader."Customer Short Name";
                                                RecGrossProfitG."Customer Name" := RecSalesCrMemoHeader."Sell-To Customer Name";
                                                RecGrossProfitG."Customer Incentive Point (CIP)" := RecSalesCrMemoHeader."Customer Incentive Point (CIP)";
                                                Clear(RecteamSalesPerson);
                                                RecteamSalesPerson.ChangeCompany(Companies.Name);
                                                RecteamSalesPerson.SetRange("Salesperson Code", RecSalesCrMemoHeader."Salesperson Code");
                                                if RecteamSalesPerson.FindFirst() then begin
                                                    Clear(Recteams);
                                                    Recteams.ChangeCompany(Companies.Name);
                                                    Recteams.GET(RecteamSalesPerson."Team Code");
                                                    RecGrossProfitG.Teams := Recteams.Name;
                                                    RecteamSalesPerson.CalcFields("Salesperson Name");
                                                    RecGrossProfitG."Salesperson Name" := RecteamSalesPerson."Salesperson Name";
                                                end;
                                                RecGrossProfitG.Incoterm := RecSalesCrMemoHeader."Transaction Specification";
                                                RecGrossProfitG."Item Code" := RecSalesCrMemoLines."No.";
                                                RecGrossProfitG."Item Short Name" := RecItem."Search Description";
                                                RecGrossProfitG."Item Category" := RecItem."Item Category Desc.";
                                                RecGrossProfitG."Item Market Industry" := RecItem."Market Industry Desc.";
                                                RecGrossProfitG."Variant Code" := RecSalesCrMemoLines."Variant Code";//Hypercare 17-02-2025
                                                RecGrossProfitG."Item Incentive Point (IIP)" := RecSalesCrMemoLines."Item Incentive Point (IIP)";
                                                RecGrossProfitG."Base UOM" := RecSalesCrMemoLines."Base UOM 2";
                                                RecGrossProfitG.QTY := RecSalesCrMemoLines."Quantity (Base)";

                                                Clear(GeneralLedgerSetup);
                                                GeneralLedgerSetup.ChangeCompany(Companies.Name);
                                                GeneralLedgerSetup.GET;
                                                IF RecSalesCrMemoHeader."Currency Code" <> '' THEN
                                                    RecGrossProfitG.CUR := RecSalesCrMemoHeader."Currency Code"
                                                ELSE
                                                    RecGrossProfitG.CUR := GeneralLedgerSetup."LCY Code";

                                                RecGrossProfitG."Base UOM Price" := RecSalesCrMemoLines."Unit Price Base UOM 2";
                                                RecGrossProfitG."Total Amount" := RecSalesCrMemoLines."Quantity (Base)" * RecSalesCrMemoLines."Unit Price Base UOM 2" * -1;


                                                Clear(TotalSalesInvoiceLineAmount);
                                                CLEAR(TotalDiscountAmount);

                                                CLEAR(RecSalesCrMemoLines2);
                                                RecSalesCrMemoLines2.ChangeCompany(Companies.Name);
                                                RecSalesCrMemoLines2.RESET;
                                                RecSalesCrMemoLines2.SETRANGE("Document No.", RecSalesCrMemoLines."Document No.");
                                                RecSalesCrMemoLines2.SETRANGE(Type, RecSalesCrMemoLines.Type::"G/L Account");
                                                IF RecSalesCrMemoLines2.FINDFIRST THEN
                                                    REPEAT
                                                        Clear(GeneralLedgerSetup);
                                                        GeneralLedgerSetup.ChangeCompany(Companies.Name);
                                                        GeneralLedgerSetup.RESET;
                                                        GeneralLedgerSetup.SETFILTER("GP G/L Accounts", '@*' + RecSalesCrMemoLines2."No." + '*');
                                                        IF GeneralLedgerSetup.FINDFIRST THEN BEGIN
                                                            TotalDiscountAmount += RecSalesCrMemoLines2."Quantity (Base)" * RecSalesCrMemoLines2."Unit Price Base UOM 2";  //PackingListExtChange
                                                        END;
                                                    UNTIL RecSalesCrMemoLines2.NEXT = 0;


                                                IF TotalDiscountAmount <> 0 THEN BEGIN
                                                    Clear(RecSalesCrMemoLines2);
                                                    RecSalesCrMemoLines2.ChangeCompany(Companies.Name);
                                                    RecSalesCrMemoLines2.SETRANGE("Document No.", RecSalesCrMemoLines."Document No.");
                                                    RecSalesCrMemoLines2.SETRANGE(Type, RecSalesCrMemoLines2.Type::Item);
                                                    IF RecSalesCrMemoLines2.FINDFIRST THEN
                                                        REPEAT
                                                            TotalSalesInvoiceLineAmount += RecSalesCrMemoLines2."Quantity (Base)" * RecSalesCrMemoLines2."Unit Price Base UOM 2"; //PackingListExtChange
                                                        UNTIL RecSalesCrMemoLines2.NEXT = 0;
                                                    CurrentLineAmount := RecSalesCrMemoLines."Quantity (Base)" * RecSalesCrMemoLines."Unit Price Base UOM 2"; //PackingListExtChange

                                                    IF TotalSalesInvoiceLineAmount <> 0 THEN
                                                        RecGrossProfitG."Total Sales Discount" := (CurrentLineAmount / TotalSalesInvoiceLineAmount) * RecGrossProfitG."Total Sales Discount";
                                                END;

                                                //+
                                                Clear(InvoicedQty);
                                                Clear(RecValueEntry);
                                                RecValueEntry.ChangeCompany(Companies.Name);
                                                RecValueEntry.SETRANGE("Document No.", RecSalesCrMemoLines."Document No.");
                                                RecValueEntry.SETRANGE("Document Line No.", RecSalesCrMemoLines."Line No.");
                                                RecValueEntry.SetRange("Item No.", RecSalesCrMemoLines."No.");//dn
                                                IF RecValueEntry.FINDFIRST THEN
                                                    REPEAT
                                                        RecGrossProfitG."Cogs (LCY)" += (RecValueEntry."Cost Amount (Actual)" * -1);
                                                        InvoicedQty += ABS(RecValueEntry."Invoiced Quantity");
                                                    UNTIL RecValueEntry.NEXT = 0;
                                                //T50866-NS
                                                if InvoicedQty = 0 then
                                                    InvoicedQty := 1;
                                                //T50866-NE
                                                RecGrossProfitG."Cogs (LCY)" := (RecGrossProfitG."Cogs (LCY)" / InvoicedQty) * RecGrossProfitG.QTY;
                                                //-

                                                Clear(RecValueEntry);
                                                RecValueEntry.ChangeCompany(Companies.Name);
                                                RecValueEntry.SETRANGE("Document No.", RecSalesCrMemoLines."Document No.");
                                                RecValueEntry.SETRANGE("Document Line No.", RecSalesCrMemoLines."Line No.");
                                                RecValueEntry.SETRANGE("Item No.", RecSalesCrMemoLines."No.");
                                                RecValueEntry.SETRANGE(Adjustment, FALSE);
                                                IF RecValueEntry.FINDFIRST THEN BEGIN
                                                    REPEAT
                                                        Clear(RecValueEntry2);
                                                        RecValueEntry2.ChangeCompany(Companies.Name);
                                                        RecValueEntry2.SETRANGE("Item Ledger Entry No.", RecValueEntry."Item Ledger Entry No.");
                                                        RecValueEntry2.SETFILTER("Item Charge No.", '<>%1', '');
                                                        RecValueEntry2.SETRANGE("Item No.", RecValueEntry."Item No.");
                                                        RecValueEntry2.SETFILTER("Item Ledger Entry Type", '<>%1', RecValueEntry."Item Ledger Entry Type"::Sale);
                                                        IF RecValueEntry2.FINDFIRST THEN
                                                            REPEAT
                                                                IF RecValueEntry2."Item Charge No." = '01' THEN
                                                                    RecGrossProfitG."EXP-FRT" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                ELSE
                                                                    IF RecValueEntry2."Item Charge No." = '02' THEN
                                                                        RecGrossProfitG."EXP-CDT" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                    ELSE
                                                                        IF RecValueEntry2."Item Charge No." = '03' THEN
                                                                            RecGrossProfitG."EXP-INS" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                        ELSE
                                                                            IF RecValueEntry2."Item Charge No." = '04' THEN
                                                                                RecGrossProfitG."EXP-TRC" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                            ELSE
                                                                                IF RecValueEntry2."Item Charge No." = '05' THEN
                                                                                    RecGrossProfitG."EXP-THC" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                ELSE
                                                                                    IF RecValueEntry2."Item Charge No." = '06' THEN
                                                                                        RecGrossProfitG."EXP-SERV" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                    ELSE
                                                                                        IF RecValueEntry2."Item Charge No." = '07' THEN
                                                                                            RecGrossProfitG."EXP-OTHER" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                        ELSE
                                                                                            IF RecValueEntry2."Item Charge No." = '09' THEN
                                                                                                RecGrossProfitG."EXP-WH HNDL" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                            ELSE
                                                                                                IF RecValueEntry2."Item Charge No." = '10' THEN
                                                                                                    RecGrossProfitG."EXP-INPC" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                                ELSE
                                                                                                    IF RecValueEntry2."Item Charge No." = '21' THEN
                                                                                                        RecGrossProfitG."EXP-WH PACK" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                                    ELSE
                                                                                                        IF RecValueEntry2."Item Charge No." = '24' THEN
                                                                                                            RecGrossProfitG."EXP-COO" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                                        ELSE
                                                                                                            IF RecValueEntry2."Item Charge No." = '26' THEN
                                                                                                                RecGrossProfitG."EXP-LEGAL" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                                            ELSE
                                                                                                                IF RecValueEntry2."Item Charge No." = '32' THEN begin
                                                                                                                    RecGrossProfitG."REBATE TO CUSTOMER" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY;
                                                                                                                    RecGrossProfitG."REBATE TO CUSTOMER" += ((RecValueEntry2."Sales Amount (Actual)" * -1) / InvoicedQty) * RecGrossProfitG.QTY

                                                                                                                end
                                                                                                                ELSE
                                                                                                                    IF RecValueEntry2."Item Charge No." = '33' THEN
                                                                                                                        RecGrossProfitG."DEMURRAGE CHARGES" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY
                                                                                                                    ELSE
                                                                                                                        RecGrossProfitG."Other Charges" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitG.QTY;
                                                            UNTIL RecValueEntry2.NEXT = 0;
                                                    UNTIL RecValueEntry.NEXT = 0;
                                                END;





                                                //cogs moved to upside
                                                if RecSalesCrMemoHeader."Currency Factor" <> 0 then
                                                    RecGrossProfitG."Total Amount (LCY)" := RecGrossProfitG."Total Amount" * (1 / RecSalesCrMemoHeader."Currency Factor")
                                                else
                                                    RecGrossProfitG."Total Amount (LCY)" := RecGrossProfitG."Total Amount";


                                                RecGrossProfitG."Total Sales Expenses (LCY)" := (RecGrossProfitG."EXP-CDT" + RecGrossProfitG."EXP-COO" + RecGrossProfitG."EXP-FRT" + RecGrossProfitG."EXP-INPC" + RecGrossProfitG."EXP-INS" + RecGrossProfitG."EXP-LEGAL" + RecGrossProfitG."EXP-OTHER" + RecGrossProfitG."EXP-SERV" + RecGrossProfitG."EXP-THC" + RecGrossProfitG."EXP-TRC" + RecGrossProfitG."EXP-WH HNDL" + RecGrossProfitG."EXP-WH PACK" + RecGrossProfitG."REBATE TO CUSTOMER" + RecGrossProfitG."DEMURRAGE CHARGES" + RecGrossProfitG."Other Charges") * -1;
                                                RecGrossProfitG."COS (LCY)" := RecGrossProfitG."Cogs (LCY)" + ABS(RecGrossProfitG."Total Sales Expenses (LCY)");
                                                RecGrossProfitG."Eff GP (LCY)" := RecGrossProfitG."Total Amount (LCY)" - RecGrossProfitG."COS (LCY)";

                                                if RecGrossProfitG."Total Amount (LCY)" <> 0 then
                                                    RecGrossProfitG."Eff GP %" := RecGrossProfitG."Eff GP (LCY)" * 100 / (ABS(RecGrossProfitG."Total Amount (LCY)"))
                                                else
                                                    RecGrossProfitG."Eff GP %" := (RecGrossProfitG."Eff GP (LCY)" * 100 / 1) * -1;

                                                if RecGrossProfitG."Eff GP (LCY)" > 0 then
                                                    RecGrossProfitG."Eff GP (LCY)" := RecGrossProfitG."Eff GP (LCY)" * -1;

                                                if RecGrossProfitG."Eff GP %" > 0 then
                                                    RecGrossProfitG."Eff GP %" := RecGrossProfitG."Eff GP %" * -1;

                                                if IsAPICall then
                                                    RecGrossProfitG."Created By Other Instance" := true;
                                                RecGrossProfitG.Modify(true);
                                            end;
                                        end else begin
                                            if RecSalesCrMemoLines.Type = RecSalesCrMemoLines.Type::"G/L Account" then begin

                                                RecGrossProfitG.Init();
                                                RowNumber += 1;
                                                RecGrossProfitG."Entry No." := RowNumber;
                                                RecGrossProfitG.Insert(true);
                                                RecGrossProfitG."Document Type" := RecGrossProfitG."Document Type"::"Credit Memo";
                                                RecGrossProfitG."Group Co." := ShortName2."Short Name";
                                                //Clear(RecSHeader);

                                                //RecGrossProfit."SO Date" := RecSalesCrMemoHeader."Order Date";
                                                //RecGrossProfit."SO No." := RecSalesCrMemoHeader."Order No.";
                                                RecGrossProfitG."SI Date" := RecSalesCrMemoHeader."Posting Date";
                                                RecGrossProfitG."SI No." := RecSalesCrMemoHeader."No.";
                                                if RecSalesCrMemoHeader."Exit Point" <> '' then begin
                                                    Clear(RecEntryExit);
                                                    RecEntryExit.ChangeCompany(Companies.Name);
                                                    RecEntryExit.GET(RecSalesCrMemoHeader."Exit Point");
                                                    RecGrossProfitG.POL := RecEntryExit.Description;
                                                end;
                                                if RecSalesCrMemoHeader."Area" <> '' then begin
                                                    Clear(RecAre);
                                                    RecAre.ChangeCompany(Companies.Name);
                                                    RecAre.GET(RecSalesCrMemoHeader."Area");
                                                    RecGrossProfitG.POD := RecAre."Text";
                                                end;

                                                RecGrossProfitG."Customer Code" := RecSalesCrMemoHeader."Sell-to Customer No.";
                                                RecGrossProfitG."Customer Short Name" := RecSalesCrMemoHeader."Customer Short Name";
                                                RecGrossProfitG."Customer Name" := RecSalesCrMemoHeader."Sell-To Customer Name";
                                                Clear(RecteamSalesPerson);
                                                RecteamSalesPerson.ChangeCompany(Companies.Name);
                                                RecteamSalesPerson.SetRange("Salesperson Code", RecSalesCrMemoHeader."Salesperson Code");
                                                if RecteamSalesPerson.FindFirst() then begin
                                                    Clear(Recteams);
                                                    Recteams.ChangeCompany(Companies.Name);
                                                    Recteams.GET(RecteamSalesPerson."Team Code");
                                                    RecGrossProfitG.Teams := Recteams.Name;
                                                    RecteamSalesPerson.CalcFields("Salesperson Name");
                                                    RecGrossProfitG."Salesperson Name" := RecteamSalesPerson."Salesperson Name";
                                                end;
                                                RecGrossProfitG.Incoterm := RecSalesCrMemoHeader."Transaction Specification";
                                                RecGrossProfitG."Item Code" := RecSalesCrMemoLines."No.";

                                                // RecGrossProfitG."Item Short Name" := RecItem."Search Description";
                                                // RecGrossProfitG."Item Category" := RecItem."Item Category Desc.";
                                                // RecGrossProfitG."Item Market Industry" := RecItem."Market Industry Desc.";
                                                RecGrossProfitG."Base UOM" := RecSalesCrMemoLines."Base UOM 2";
                                                RecGrossProfitG.QTY := RecSalesCrMemoLines."Quantity (Base)";

                                                Clear(GeneralLedgerSetup);
                                                GeneralLedgerSetup.ChangeCompany(Companies.Name);
                                                GeneralLedgerSetup.GET;
                                                IF RecSalesCrMemoHeader."Currency Code" <> '' THEN
                                                    RecGrossProfitG.CUR := RecSalesCrMemoHeader."Currency Code"
                                                ELSE
                                                    RecGrossProfitG.CUR := GeneralLedgerSetup."LCY Code";

                                                RecGrossProfitG."Base UOM Price" := RecSalesCrMemoLines."Unit Price Base UOM 2";
                                                RecGrossProfitG."Total Amount" := RecSalesCrMemoLines."Quantity (Base)" * RecSalesCrMemoLines."Unit Price Base UOM 2" * -1;


                                                //cogs moved to upside
                                                if RecSalesCrMemoHeader."Currency Factor" <> 0 then
                                                    RecGrossProfitG."Total Amount (LCY)" := RecGrossProfitG."Total Amount" * (1 / RecSalesCrMemoHeader."Currency Factor")
                                                else
                                                    RecGrossProfitG."Total Amount (LCY)" := RecGrossProfitG."Total Amount";


                                                RecGrossProfitG."Eff GP (LCY)" := RecGrossProfitG."Total Amount (LCY)" - RecGrossProfitG."COS (LCY)";

                                                if RecGrossProfitG."Total Amount (LCY)" <> 0 then
                                                    RecGrossProfitG."Eff GP %" := RecGrossProfitG."Eff GP (LCY)" * 100 / (ABS(RecGrossProfitG."Total Amount (LCY)"))
                                                else
                                                    RecGrossProfitG."Eff GP %" := (RecGrossProfitG."Eff GP (LCY)" * 100 / 1) * -1;

                                                if RecGrossProfitG."Eff GP (LCY)" > 0 then
                                                    RecGrossProfitG."Eff GP (LCY)" := RecGrossProfitG."Eff GP (LCY)" * -1;

                                                if RecGrossProfitG."Eff GP %" > 0 then
                                                    RecGrossProfitG."Eff GP %" := RecGrossProfitG."Eff GP %" * -1;

                                                if IsAPICall then
                                                    RecGrossProfitG."Created By Other Instance" := true;
                                                RecGrossProfitG.Modify(true);
                                            end;
                                        end;
                                    until RecSalesCrMemoLines.Next() = 0;
                                end;
                            end;
                        end;
                    until RecSalesCrMemoHeader.Next() = 0;
                end;
            end;
        until Companies.Next() = 0;
        //Credit Memo End
    end;


    local procedure CallApi(var Response: Text): Boolean
    var
        HttpClient: HttpClient;
        HttpResponse: HttpResponseMessage;
        HttpHeadrs: HttpHeaders;
        HttpContent: HttpContent;
        ResponseJsonObject: JsonObject;
        RecCompanyInformation: Record "Company Information";
        TempBlob: Codeunit "Base64 Convert";
        AuthString, BodyText : Text;
        IsSuccess: Boolean;
        EnvelopeData: Label '<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/"><Body><RunReport xmlns="urn:microsoft-dynamics-schemas/codeunit/GenerateGPReport"><startDt>%1</startDt><endDt>%2</endDt></RunReport></Body></Envelope>';
        ResponseArray: array[1] of Text;
        //Hypercare-NS
        Scopes: List of [Text];
        oAuth2: Codeunit OAuth2;
        Accesstoken: Text;
        TockenURL_lTxt: Text;
        TenantID_lTxt: Text;
    //Hypercare-NE
    begin
        Clear(IsSuccess);
        RecCompanyInformation.GET;
        RecCompanyInformation.TestField("Gross Profit Webservice URL");
        RecCompanyInformation.TestField("Webserive Username");
        RecCompanyInformation.TestField("Webservice Key");
        RecCompanyInformation.TestField("Webservice Name");

        //Hpercare-NS
        TenantID_lTxt := '3e2937d0-cd42-4c48-bf44-ee7afb3be012';//India Tenent
        RecCompanyInformation.TestField("Client ID");
        RecCompanyInformation.TestField("Secret ID");
        TockenURL_lTxt := StrSubstNo('https://login.microsoftonline.com/%1/oauth2/v2.0/token', TenantID_lTxt);
        Scopes.Add('https://api.businesscentral.dynamics.com/.default');
        OAuth2.AcquireTokenWithClientCredentials(RecCompanyInformation."Client ID", RecCompanyInformation."Secret ID", TockenURL_lTxt, '', Scopes, Accesstoken);
        //Hpercare-NE

        AuthString := StrSubstNo('%1:%2', RecCompanyInformation."Webserive Username", RecCompanyInformation."Webservice Key");
        AuthString := 'Basic ' + TempBlob.ToBase64(AuthString);
        BodyText := StrSubstNo(EnvelopeData, FORMAT(StartDate, 0, '<Year4>-<Month,2>-<Day,2>'), FORMAT(EndDate, 0, '<Year4>-<Month,2>-<Day,2>'));
        HttpClient.SetBaseAddress(RecCompanyInformation."Gross Profit Webservice URL");
        HttpContent.WriteFrom(BodyText);
        // HttpClient.DefaultRequestHeaders.Add('Authorization', AuthString);//Hypercare-O
        HttpClient.DefaultRequestHeaders().Add('Authorization', 'Bearer ' + AccessToken);//Hypercare-N
        HttpContent.GetHeaders(HttpHeadrs);
        HttpHeadrs.Remove('Content-Type');
        HttpHeadrs.Add('Content-Type', 'application/xml');//; charset=utf-8');
        HttpHeadrs.Add('SOAPACTION', 'urn:microsoft-dynamics-schemas/codeunit/' + RecCompanyInformation."Webservice Name" + ':RunReport');
        HttpClient.DefaultRequestHeaders.Add('User-Agent', 'Dynamics 365');
        HttpClient.DefaultRequestHeaders.TryAddWithoutValidation('Content-Type', 'application/xml');//; charset=utf-8
        if HttpClient.Post(RecCompanyInformation."Gross Profit Webservice URL", HttpContent, HttpResponse) then begin
            if HttpResponse.IsSuccessStatusCode() then begin
                HttpResponse.Content().ReadAs(Response);
                IsSuccess := true;
            end else begin
                Response := HttpResponse.ReasonPhrase();
                //Response += 
                if HttpResponse.Headers.GetValues('NAV-Error', ResponseArray) then
                    Response := Response + '\' + ResponseArray[1];
                IsSuccess := false;
            end;
        end else
            Error('Something went wrong while connecting Business Central Instance. %1', HttpResponse.ReasonPhrase);
        exit(IsSuccess);
    end;




    procedure RowID1(SalesInvLine: Record "Sales Invoice Line"): Text[250]
    var
        ItemTrackingMgt: Codeunit "Item Tracking Management";
    begin
        exit(ItemTrackingMgt.ComposeRowID(DATABASE::"Sales Invoice Line",
            0, SalesInvLine."Document No.", '', 0, SalesInvLine."Line No."));
    end;

    local procedure UpdateICInvoiceLineForIndianSI()
    var
        RecSalesInvHeader: Record "Sales Invoice Header";
        RecSalesinvLines: Record "Sales Invoice Line";
        ShortName2: Record "Company Short Name";
        RecSHeader: Record "Sales Header";
        RecSalesPerson: Record "Salesperson/Purchaser";
        RecItem: Record Item;
        Recteams: Record Team;
        RecteamSalesPerson: Record "Team Salesperson";
        RecValueEntry: Record "Value Entry";
        RecValueEntry2: Record "Value Entry";
        RecSalesinvLines2: Record "Sales Invoice Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
        RecEntryExit: Record "Entry/Exit Point";
        RecAre: Record "Area";
        ICCompanyList: Record Company;
        ICCOGSLCY: Decimal;
        ICValueEntry: Record "Value Entry";
        ICValueEntry2: Record "Value Entry";
        ICSalesOrderInvoiceLines: Record "Sales Invoice Line";
        ICPartners: Record "IC Partner";
        TotalDiscountAmount: Decimal;
        RecGrossProfitL: Record "Gross Profit Report";
        InvoicedQty: Decimal;
    begin
        Clear(RecGrossProfitL);
        RecGrossProfitL.SetRange("Created By Other Instance", true);
        RecGrossProfitL.SetFilter("IC Company Code", '<>%1', '');
        RecGrossProfitL.SetFilter("Vendor Invoice No.", '<>%1', '');
        if RecGrossProfitL.FindSet() then
        //comment
        begin
            repeat
                Clear(RecSalesInvHeader);
                RecSalesInvHeader.ChangeCompany(RecGrossProfitL."IC Company Code");
                RecSalesInvHeader.SetRange("No.", RecGrossProfitL."Vendor Invoice No.");
                if RecSalesInvHeader.FindSet() then
                //coment
                begin
                    repeat
                        Clear(RecSalesinvLines);
                        RecSalesinvLines.ChangeCompany(RecGrossProfitL."IC Company Code");
                        RecSalesinvLines.SetRange("Document No.", RecSalesInvHeader."No.");
                        RecSalesinvLines.SetRange(Type, RecSalesinvLines.Type::Item);
                        RecSalesinvLines.SetRange("No.", RecGrossProfitL."Item Code");
                        if RecSalesinvLines.FindSet() then
                        //coment
                        begin
                            repeat
                                Clear(RecItem);
                                RecItem.ChangeCompany(RecGrossProfitL."IC Company Code");
                                RecItem.GET(RecSalesinvLines."No.");
                                if RecItem."Inventory Posting Group" <> 'SAMPLE' then begin
                                    //RecGrossProfitL.Init();
                                    //RowNumber += 1;
                                    //RecGrossProfitL."Entry No." := RowNumber;
                                    //RecGrossProfitL.Insert(true);
                                    //RecGrossProfitL."Document Type" := RecGrossProfitL."Document Type"::Invoice;
                                    //RecGrossProfitL."Group Co." := ShortName2."Short Name";
                                    //Clear(RecSHeader);

                                    //RecGrossProfitL."SO Date" := RecSalesInvHeader."Order Date";
                                    //RecGrossProfitL."SO No." := RecSalesInvHeader."Order No.";
                                    //RecGrossProfitL."SI Date" := RecSalesInvHeader."Posting Date";
                                    //RecGrossProfitL."SI No." := RecSalesInvHeader."No.";
                                    // if RecSalesInvHeader."Exit Point" <> '' then begin
                                    //     Clear(RecEntryExit);
                                    //     RecEntryExit.ChangeCompany(RecGrossProfitL."IC Company Code");
                                    //     RecEntryExit.GET(RecSalesInvHeader."Exit Point");
                                    //     RecGrossProfitL.POL := RecEntryExit.Description;
                                    // end;
                                    // if RecSalesInvHeader."Area" <> '' then begin
                                    //     Clear(RecAre);
                                    //     RecAre.ChangeCompany(RecGrossProfitL."IC Company Code");
                                    //     RecAre.GET(RecSalesInvHeader."Area");
                                    //     RecGrossProfitL.POD := RecAre."Text";
                                    // end;

                                    //RecGrossProfitL."Customer Code" := RecSalesInvHeader."Sell-to Customer No.";
                                    //RecGrossProfitL."Customer Short Name" := RecSalesInvHeader."Customer Short Name";
                                    // Clear(RecteamSalesPerson);
                                    // RecteamSalesPerson.ChangeCompany(RecGrossProfitL."IC Company Code");
                                    // RecteamSalesPerson.SetRange("Salesperson Code", RecSalesInvHeader."Salesperson Code");
                                    // if RecteamSalesPerson.FindFirst() then begin
                                    //     Clear(Recteams);
                                    //     Recteams.ChangeCompany(RecGrossProfitL."IC Company Code");
                                    //     Recteams.GET(RecteamSalesPerson."Team Code");
                                    //     RecGrossProfitL.Teams := Recteams.Name;
                                    //     RecteamSalesPerson.CalcFields("Salesperson Name");
                                    //     RecGrossProfitL."Salesperson Name" := RecteamSalesPerson."Salesperson Name";
                                    // end;
                                    // RecGrossProfitL.Incoterm := RecSalesInvHeader."Transaction Specification";
                                    // RecGrossProfitL."Item Code" := RecSalesinvLines."No.";

                                    // RecGrossProfitL."Item Short Name" := RecItem."Search Description";
                                    // RecGrossProfitL."Item Category" := RecItem."Item Category Desc.";
                                    // RecGrossProfitL."Item Market Industry" := RecItem."Market Industry Desc.";
                                    // RecGrossProfitL."Base UOM" := RecSalesinvLines."Base UOM 2";
                                    // RecGrossProfitL.QTY := RecSalesinvLines."Quantity (Base)";

                                    // Clear(GeneralLedgerSetup);
                                    // GeneralLedgerSetup.ChangeCompany(RecGrossProfitL."IC Company Code");
                                    // GeneralLedgerSetup.GET;
                                    // IF RecSalesInvHeader."Currency Code" <> '' THEN
                                    //     RecGrossProfitL.CUR := RecSalesInvHeader."Currency Code"
                                    // ELSE
                                    //     RecGrossProfitL.CUR := GeneralLedgerSetup."LCY Code";

                                    // RecGrossProfitL."Base UOM Price" := RecSalesinvLines."Unit Price Base UOM 2";
                                    // RecGrossProfitL."Total Amount" := RecSalesinvLines."Quantity (Base)" * RecSalesinvLines."Unit Price Base UOM 2";


                                    // Clear(RecValueEntry);
                                    // RecValueEntry.ChangeCompany(RecGrossProfitL."IC Company Code");
                                    // RecValueEntry.SETRANGE("Document No.", RecSalesinvLines."Document No.");
                                    // RecValueEntry.SETRANGE("Document Line No.", RecSalesinvLines."Line No.");
                                    // RecValueEntry.SETRANGE("Item No.", RecSalesinvLines."No.");
                                    // RecValueEntry.SETRANGE(Adjustment, FALSE);
                                    // IF RecValueEntry.FINDFIRST THEN
                                    //     REPEAT
                                    //         Clear(RecValueEntry2);
                                    //         RecValueEntry2.ChangeCompany(RecGrossProfitL."IC Company Code");
                                    //         RecValueEntry2.SETRANGE("Document No.", RecSalesinvLines."Document No.");
                                    //         RecValueEntry2.SETRANGE("Item Ledger Entry No.", RecValueEntry."Item Ledger Entry No.");
                                    //         RecValueEntry2.SETFILTER("Item Charge No.", '<>%1', '');
                                    //         RecValueEntry2.SETRANGE("Item No.", RecValueEntry."Item No.");
                                    //         IF RecValueEntry2.FINDFIRST THEN
                                    //             REPEAT
                                    //                 RecGrossProfitL."Other Revenue (LCY)" += RecValueEntry2."Sales Amount (Actual)";
                                    //             UNTIL RecValueEntry2.NEXT = 0;
                                    //     UNTIL RecValueEntry.NEXT = 0;

                                    //+
                                    RecGrossProfitL."Cogs (LCY)" := 0;
                                    Clear(InvoicedQty);
                                    Clear(RecValueEntry);
                                    RecValueEntry.ChangeCompany(RecGrossProfitL."IC Company Code");
                                    RecValueEntry.SETRANGE("Document No.", RecSalesinvLines."Document No.");
                                    RecValueEntry.SETRANGE("Document Line No.", RecSalesinvLines."Line No.");
                                    IF RecValueEntry.FINDFIRST THEN
                                        REPEAT
                                            RecGrossProfitL."Cogs (LCY)" += (RecValueEntry."Cost Amount (Actual)" * -1);// not adding COGS as it should show from UAE only
                                            InvoicedQty += ABS(RecValueEntry."Invoiced Quantity");
                                        UNTIL RecValueEntry.NEXT = 0;
                                    RecGrossProfitL."Cogs (LCY)" := (RecGrossProfitL."Cogs (LCY)" / InvoicedQty) * RecGrossProfitL.QTY;
                                    //-
                                    // Clear(OtherCharges);
                                    Clear(RecValueEntry);
                                    RecValueEntry.ChangeCompany(RecGrossProfitL."IC Company Code");
                                    RecValueEntry.SETRANGE("Document No.", RecSalesinvLines."Document No.");
                                    RecValueEntry.SETRANGE("Document Line No.", RecSalesinvLines."Line No.");
                                    RecValueEntry.SETRANGE("Item No.", RecSalesinvLines."No.");
                                    RecValueEntry.SETRANGE(Adjustment, FALSE);
                                    IF RecValueEntry.FINDFIRST THEN
                                     //coment
                                     BEGIN
                                        REPEAT
                                            Clear(RecValueEntry2);
                                            RecValueEntry2.ChangeCompany(RecGrossProfitL."IC Company Code");
                                            RecValueEntry2.SETRANGE("Item Ledger Entry No.", RecValueEntry."Item Ledger Entry No.");
                                            RecValueEntry2.SETFILTER("Item Charge No.", '<>%1', '');
                                            RecValueEntry2.SETRANGE("Item No.", RecValueEntry."Item No.");
                                            RecValueEntry2.SETFILTER("Item Ledger Entry Type", '<>%1', RecValueEntry."Item Ledger Entry Type"::Sale);
                                            IF RecValueEntry2.FINDFIRST THEN
                                                REPEAT
                                                    IF RecValueEntry2."Item Charge No." = '01' THEN
                                                        RecGrossProfitL."EXP-FRT" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                    ELSE
                                                        IF RecValueEntry2."Item Charge No." = '02' THEN
                                                            RecGrossProfitL."EXP-CDT" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                        ELSE
                                                            IF RecValueEntry2."Item Charge No." = '03' THEN
                                                                RecGrossProfitL."EXP-INS" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                            ELSE
                                                                IF RecValueEntry2."Item Charge No." = '04' THEN
                                                                    RecGrossProfitL."EXP-TRC" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                                ELSE
                                                                    IF RecValueEntry2."Item Charge No." = '05' THEN
                                                                        RecGrossProfitL."EXP-THC" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                                    ELSE
                                                                        IF RecValueEntry2."Item Charge No." = '06' THEN
                                                                            RecGrossProfitL."EXP-SERV" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                                        ELSE
                                                                            IF RecValueEntry2."Item Charge No." = '07' THEN
                                                                                RecGrossProfitL."EXP-OTHER" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                                            ELSE
                                                                                IF RecValueEntry2."Item Charge No." = '09' THEN
                                                                                    RecGrossProfitL."EXP-WH HNDL" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                                                ELSE
                                                                                    IF RecValueEntry2."Item Charge No." = '10' THEN
                                                                                        RecGrossProfitL."EXP-INPC" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                                                    ELSE
                                                                                        IF RecValueEntry2."Item Charge No." = '21' THEN
                                                                                            RecGrossProfitL."EXP-WH PACK" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                                                        ELSE
                                                                                            IF RecValueEntry2."Item Charge No." = '24' THEN
                                                                                                RecGrossProfitL."EXP-COO" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                                                            ELSE
                                                                                                IF RecValueEntry2."Item Charge No." = '26' THEN
                                                                                                    RecGrossProfitL."EXP-LEGAL" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                                                                ELSE
                                                                                                    IF RecValueEntry2."Item Charge No." = '32' THEN
                                                                                                        RecGrossProfitL."REBATE TO CUSTOMER" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                                                                    ELSE
                                                                                                        IF RecValueEntry2."Item Charge No." = '33' THEN
                                                                                                            RecGrossProfitL."DEMURRAGE CHARGES" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                                                                        ELSE
                                                                                                            RecGrossProfitL."Other Charges" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY;
                                                UNTIL RecValueEntry2.NEXT = 0;
                                        UNTIL RecValueEntry.NEXT = 0;
                                    END;
                                    //Message('%1', RecGrossProfitL."Other Charges");//@@@@@@@@@@@@@@@@@
                                    //moved cogs above
                                    Clear(TotalDiscountAmount);
                                    Clear(TotalSalesInvoiceLineAmount);

                                    CLEAR(RecSalesinvLines2);
                                    RecSalesinvLines2.ChangeCompany(RecGrossProfitL."IC Company Code");
                                    RecSalesinvLines2.RESET;
                                    RecSalesinvLines2.SETRANGE("Document No.", RecSalesinvLines."Document No.");
                                    RecSalesinvLines2.SETRANGE(Type, RecSalesinvLines.Type::"G/L Account");
                                    IF RecSalesinvLines2.FINDFIRST THEN
                                        REPEAT
                                            Clear(GeneralLedgerSetup);
                                            GeneralLedgerSetup.ChangeCompany(RecGrossProfitL."IC Company Code");
                                            GeneralLedgerSetup.RESET;
                                            GeneralLedgerSetup.SETFILTER("GP G/L Accounts", '@*' + RecSalesinvLines2."No." + '*');
                                            IF GeneralLedgerSetup.FINDFIRST THEN BEGIN
                                                TotalDiscountAmount += RecSalesinvLines2."Quantity (Base)" * RecSalesinvLines2."Unit Price Base UOM 2";  //PackingListExtChange
                                            END;
                                        UNTIL RecSalesinvLines2.NEXT = 0;

                                    IF TotalDiscountAmount <> 0 THEN BEGIN
                                        Clear(RecSalesinvLines2);
                                        RecSalesinvLines2.ChangeCompany(RecGrossProfitL."IC Company Code");
                                        RecSalesinvLines2.SETRANGE("Document No.", RecSalesinvLines."Document No.");
                                        RecSalesinvLines2.SETRANGE(Type, RecSalesinvLines2.Type::Item);
                                        IF RecSalesinvLines2.FINDFIRST THEN
                                            REPEAT
                                                TotalSalesInvoiceLineAmount += RecSalesinvLines2."Quantity (Base)" * RecSalesinvLines2."Unit Price Base UOM 2"; //PackingListExtChange
                                            UNTIL RecSalesinvLines2.NEXT = 0;
                                        CurrentLineAmount := RecSalesinvLines."Quantity (Base)" * RecSalesinvLines."Unit Price Base UOM 2"; //PackingListExtChange

                                        IF TotalSalesInvoiceLineAmount <> 0 THEN
                                            RecGrossProfitL."Total Sales Discount" := (CurrentLineAmount / TotalSalesInvoiceLineAmount) * RecGrossProfitL."Total Sales Discount";
                                    END;


                                    // //IC charges and cost calculation-start
                                    // Clear(ICCOGSLCY);
                                    // IF RecGrossProfitL."SO No." <> '' THEN
                                    // //coment
                                    // BEGIN
                                    //     Clear(ICCompanyList);
                                    //     IF ICCompanyList.FindFirst() THEN
                                    //         REPEAT
                                    //             CLEAR(ICSalesOrderInvoiceLines);
                                    //             ICSalesOrderInvoiceLines.ChangeCompany(ICCompanyList.Name);
                                    //             ICSalesOrderInvoiceLines.RESET;
                                    //             ICSalesOrderInvoiceLines.SETRANGE("IC Related SO", RecGrossProfitL."SO No.");
                                    //             ICSalesOrderInvoiceLines.SETRANGE("No.", RecSalesinvLines."No.");
                                    //             IF ICSalesOrderInvoiceLines.FindFirst() THEN
                                    //              //coment
                                    //              BEGIN
                                    //                 REPEAT
                                    //                     CLEAR(ICValueEntry);
                                    //                     ICValueEntry.ChangeCompany(ICCompanyList.Name);
                                    //                     ICValueEntry.RESET;
                                    //                     ICValueEntry.SETRANGE("Document No.", ICSalesOrderInvoiceLines."Document No.");
                                    //                     ICValueEntry.SETRANGE("Document Line No.", ICSalesOrderInvoiceLines."Line No.");
                                    //                     IF ICValueEntry.FINDFIRST THEN
                                    //                         REPEAT
                                    //                             ICCOGSLCY += (ICValueEntry."Cost Amount (Actual)" * -1);
                                    //                         UNTIL ICValueEntry.NEXT = 0;

                                    //                     ICValueEntry2.ChangeCompany(ICCompanyList.Name);

                                    //                     //Purchase Charges
                                    //                     ICValueEntry.RESET;
                                    //                     ICValueEntry.SETRANGE("Document No.", ICSalesOrderInvoiceLines."Document No.");
                                    //                     ICValueEntry.SETRANGE("Document Line No.", ICSalesOrderInvoiceLines."Line No.");
                                    //                     ICValueEntry.SETRANGE("Item No.", ICSalesOrderInvoiceLines."No.");
                                    //                     ICValueEntry.SETRANGE(Adjustment, FALSE);
                                    //                     IF ICValueEntry.FINDFIRST THEN
                                    //                     //coment
                                    //                     BEGIN
                                    //                         REPEAT
                                    //                             ICValueEntry2.RESET;
                                    //                             ICValueEntry2.SETRANGE("Item Ledger Entry No.", ICValueEntry."Item Ledger Entry No.");
                                    //                             ICValueEntry2.SETFILTER("Item Charge No.", '<>%1', '');
                                    //                             ICValueEntry2.SETRANGE("Item No.", ICValueEntry."Item No.");
                                    //                             ICValueEntry2.SETFILTER("Item Ledger Entry Type", '<>%1', ICValueEntry2."Item Ledger Entry Type"::Sale);
                                    //                             // IF ChargeItemFilter <> '' THEN
                                    //                             //     ICValueEntry2.SETFILTER("Item Charge No.", ChargeItemFilter);
                                    //                             IF ICValueEntry2.FINDFIRST THEN
                                    //                                 REPEAT
                                    //                                     IF ICValueEntry2."Item Charge No." = '01' THEN
                                    //                                         RecGrossProfitL."EXP-FRT" += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
                                    //                                     ELSE
                                    //                                         IF ICValueEntry2."Item Charge No." = '02' THEN
                                    //                                             RecGrossProfitL."EXP-CDT" += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
                                    //                                         ELSE
                                    //                                             IF ICValueEntry2."Item Charge No." = '03' THEN
                                    //                                                 RecGrossProfitL."EXP-INS" += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
                                    //                                             ELSE
                                    //                                                 IF ICValueEntry2."Item Charge No." = '04' THEN
                                    //                                                     RecGrossProfitL."EXP-TRC" += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
                                    //                                                 ELSE
                                    //                                                     IF ICValueEntry2."Item Charge No." = '05' THEN
                                    //                                                         RecGrossProfitL."EXP-THC" += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
                                    //                                                     ELSE
                                    //                                                         IF ICValueEntry2."Item Charge No." = '06' THEN
                                    //                                                             RecGrossProfitL."EXP-SERV" += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
                                    //                                                         ELSE
                                    //                                                             IF ICValueEntry2."Item Charge No." = '07' THEN
                                    //                                                                 RecGrossProfitL."EXP-OTHER" += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
                                    //                                                             ELSE
                                    //                                                                 IF ICValueEntry2."Item Charge No." = '09' THEN
                                    //                                                                     RecGrossProfitL."EXP-WH HNDL" += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
                                    //                                                                 ELSE
                                    //                                                                     IF ICValueEntry2."Item Charge No." = '10' THEN
                                    //                                                                         RecGrossProfitL."EXP-INPC" += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
                                    //                                                                     ELSE
                                    //                                                                         IF ICValueEntry2."Item Charge No." = '21' THEN
                                    //                                                                             RecGrossProfitL."EXP-WH PACK" += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
                                    //                                                                         ELSE
                                    //                                                                             IF ICValueEntry2."Item Charge No." = '24' THEN
                                    //                                                                                 RecGrossProfitL."EXP-COO" += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
                                    //                                                                             ELSE
                                    //                                                                                 IF ICValueEntry2."Item Charge No." = '26' THEN
                                    //                                                                                     RecGrossProfitL."EXP-LEGAL" += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
                                    //                                                                                 ELSE
                                    //                                                                                     IF ICValueEntry2."Item Charge No." = '32' THEN
                                    //                                                                                         RecGrossProfitL."REBATE TO CUSTOMER" += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
                                    //                                                                                     ELSE
                                    //                                                                                         IF ICValueEntry2."Item Charge No." = '33' THEN
                                    //                                                                                             RecGrossProfitL."DEMURRAGE CHARGES" += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
                                    //                                                                                         ELSE
                                    //                                                                                             OtherCharges += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1;
                                    //                                 UNTIL ICValueEntry2.NEXT = 0;
                                    //                         UNTIL ICValueEntry.NEXT = 0;
                                    //                     END;
                                    //                 //Purchase Charges
                                    //                 UNTIL ICSalesOrderInvoiceLines.NEXT = 0;
                                    //             END;
                                    //         UNTIL ICCompanyList.NEXT = 0;
                                    //     IF ICCOGSLCY <> 0 THEN
                                    //         RecGrossProfitL."Cogs (LCY)" := ICCOGSLCY;
                                    // END;
                                    // //- IC end


                                    // Clear(RecValueEntry);
                                    // RecValueEntry.ChangeCompany(RecGrossProfitL."IC Company Code");
                                    // RecValueEntry.SetRange("Document No.", RecSalesInvHeader."No.");
                                    // RecValueEntry.SetRange("Item No.", RecSalesinvLines."No.");
                                    // RecValueEntry.SetRange(Adjustment, false);
                                    // RecValueEntry.SetRange("Document Line No.", RecSalesinvLines."Line No.");
                                    // if RecValueEntry.FindSet() then begin
                                    //     REPEAT
                                    //         RecGrossProfitL."Total Amount (LCY)" += RecValueEntry."Sales Amount (Actual)";
                                    //     UNTIL RecValueEntry.NEXT = 0;
                                    // end;
                                    // RecGrossProfitL."Total Amount (LCY)" := RecGrossProfitL."Total Amount (LCY)" + RecGrossProfitL."Other Revenue (LCY)";


                                    RecGrossProfitL."Total Sales Expenses (LCY)" := RecGrossProfitL."EXP-CDT" + RecGrossProfitL."EXP-COO" + RecGrossProfitL."EXP-FRT" + RecGrossProfitL."EXP-INPC" + RecGrossProfitL."EXP-INS" + RecGrossProfitL."EXP-LEGAL" + RecGrossProfitL."EXP-OTHER" + RecGrossProfitL."EXP-SERV" + RecGrossProfitL."EXP-THC" + RecGrossProfitL."EXP-TRC" + RecGrossProfitL."EXP-WH HNDL" + RecGrossProfitL."EXP-WH PACK" + RecGrossProfitL."REBATE TO CUSTOMER" + RecGrossProfitL."DEMURRAGE CHARGES" + RecGrossProfitL."Other Charges";
                                    RecGrossProfitL."COS (LCY)" := RecGrossProfitL."Cogs (LCY)" + RecGrossProfitL."Total Sales Expenses (LCY)";
                                    RecGrossProfitL."Eff GP (LCY)" := RecGrossProfitL."Total Amount (LCY)" - RecGrossProfitL."COS (LCY)";

                                    if RecGrossProfitL."Total Amount (LCY)" <> 0 then
                                        RecGrossProfitL."Eff GP %" := RecGrossProfitL."Eff GP (LCY)" * 100 / (RecGrossProfitL."Total Amount (LCY)")
                                    else
                                        RecGrossProfitL."Eff GP %" := RecGrossProfitL."Eff GP (LCY)" * 100 / 1;

                                    RecGrossProfitL.Modify(true);
                                end;
                            until RecSalesinvLines.Next() = 0;
                        end;
                    until RecSalesInvHeader.Next() = 0;
                end;
            until RecGrossProfitL.Next() = 0;
        end;
    end;


    local procedure UpdateICInvoiceLineForUAESI()
    var
        RecSalesInvHeader: Record "Sales Invoice Header";
        RecSalesinvLines: Record "Sales Invoice Line";
        ShortName2: Record "Company Short Name";
        RecSHeader: Record "Sales Header";
        RecSalesPerson: Record "Salesperson/Purchaser";
        RecItem: Record Item;
        Recteams: Record Team;
        RecteamSalesPerson: Record "Team Salesperson";
        RecValueEntry: Record "Value Entry";
        RecValueEntry2: Record "Value Entry";
        RecSalesinvLines2: Record "Sales Invoice Line";
        GeneralLedgerSetup: Record "General Ledger Setup";
        RecEntryExit: Record "Entry/Exit Point";
        RecAre: Record "Area";
        ICCompanyList: Record Company;
        ICCOGSLCY: Decimal;
        ICValueEntry: Record "Value Entry";
        ICValueEntry2: Record "Value Entry";
        ICSalesOrderInvoiceLines: Record "Sales Invoice Line";
        ICPartners: Record "IC Partner";
        TotalDiscountAmount: Decimal;
        RecGrossProfitL: Record "Gross Profit Report";
        InvoicedQty: Decimal;
        ICPartner_lRec: Record "IC Partner";
    begin
        Clear(RecGrossProfitL);
        RecGrossProfitL.SetRange("Created By Other Instance", false);//false for UAE
        RecGrossProfitL.SetFilter("IC Company Code", '<>%1', '');
        RecGrossProfitL.SetFilter("Vendor Invoice No.", '<>%1', '');
        if RecGrossProfitL.FindSet() then
        //comment
        begin
            repeat
                /*//Hypercare-YH
                 ICPartner_lRec.Reset();
                ICPartner_lRec.SetRange("Inbox Details", RecGrossProfitL."IC Company Code");
                if ICPartner_lRec.findfirst then begin
                    if ICPartner_lRec."Data Exchange Type" = ICPartner_lRec."Data Exchange Type"::API then
                        exit;
                end; */
                Clear(RecSalesInvHeader);
                RecSalesInvHeader.ChangeCompany(RecGrossProfitL."IC Company Code");
                RecSalesInvHeader.SetRange("No.", RecGrossProfitL."Vendor Invoice No.");
                if RecSalesInvHeader.FindSet() then
                //coment
                begin
                    repeat
                        Clear(RecSalesinvLines);
                        RecSalesinvLines.ChangeCompany(RecGrossProfitL."IC Company Code");
                        RecSalesinvLines.SetRange("Document No.", RecSalesInvHeader."No.");
                        RecSalesinvLines.SetRange(Type, RecSalesinvLines.Type::Item);
                        RecSalesinvLines.SetRange("No.", RecGrossProfitL."Item Code");
                        if RecSalesinvLines.FindSet() then
                        //coment
                        begin
                            repeat
                                Clear(RecItem);
                                RecItem.ChangeCompany(RecGrossProfitL."IC Company Code");
                                RecItem.GET(RecSalesinvLines."No.");
                                if RecItem."Inventory Posting Group" <> 'SAMPLE' then begin

                                    //+
                                    RecGrossProfitL."Cogs (LCY)" := 0;
                                    Clear(InvoicedQty);
                                    Clear(RecValueEntry);
                                    RecValueEntry.ChangeCompany(RecGrossProfitL."IC Company Code");
                                    RecValueEntry.SETRANGE("Document No.", RecSalesinvLines."Document No.");
                                    RecValueEntry.SETRANGE("Document Line No.", RecSalesinvLines."Line No.");
                                    IF RecValueEntry.FINDFIRST THEN
                                        REPEAT
                                            RecGrossProfitL."Cogs (LCY)" += (RecValueEntry."Cost Amount (Actual)" * -1);// not adding COGS as it should show from UAE only
                                            InvoicedQty += ABS(RecValueEntry."Invoiced Quantity");
                                        UNTIL RecValueEntry.NEXT = 0;
                                    RecGrossProfitL."Cogs (LCY)" := (RecGrossProfitL."Cogs (LCY)" / InvoicedQty) * RecGrossProfitL.QTY;
                                    //-
                                    // Clear(OtherCharges);
                                    Clear(RecValueEntry);
                                    RecValueEntry.ChangeCompany(RecGrossProfitL."IC Company Code");
                                    RecValueEntry.SETRANGE("Document No.", RecSalesinvLines."Document No.");
                                    RecValueEntry.SETRANGE("Document Line No.", RecSalesinvLines."Line No.");
                                    RecValueEntry.SETRANGE("Item No.", RecSalesinvLines."No.");
                                    RecValueEntry.SETRANGE(Adjustment, FALSE);
                                    IF RecValueEntry.FINDFIRST THEN
                                     //coment
                                     BEGIN
                                        REPEAT
                                            Clear(RecValueEntry2);
                                            RecValueEntry2.ChangeCompany(RecGrossProfitL."IC Company Code");
                                            RecValueEntry2.SETRANGE("Item Ledger Entry No.", RecValueEntry."Item Ledger Entry No.");
                                            RecValueEntry2.SETFILTER("Item Charge No.", '<>%1', '');
                                            RecValueEntry2.SETRANGE("Item No.", RecValueEntry."Item No.");
                                            RecValueEntry2.SETFILTER("Item Ledger Entry Type", '<>%1', RecValueEntry."Item Ledger Entry Type"::Sale);
                                            IF RecValueEntry2.FINDFIRST THEN
                                                REPEAT
                                                    IF RecValueEntry2."Item Charge No." = '01' THEN
                                                        RecGrossProfitL."EXP-FRT" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                    ELSE
                                                        IF RecValueEntry2."Item Charge No." = '02' THEN
                                                            RecGrossProfitL."EXP-CDT" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                        ELSE
                                                            IF RecValueEntry2."Item Charge No." = '03' THEN
                                                                RecGrossProfitL."EXP-INS" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                            ELSE
                                                                IF RecValueEntry2."Item Charge No." = '04' THEN
                                                                    RecGrossProfitL."EXP-TRC" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                                ELSE
                                                                    IF RecValueEntry2."Item Charge No." = '05' THEN
                                                                        RecGrossProfitL."EXP-THC" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                                    ELSE
                                                                        IF RecValueEntry2."Item Charge No." = '06' THEN
                                                                            RecGrossProfitL."EXP-SERV" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                                        ELSE
                                                                            IF RecValueEntry2."Item Charge No." = '07' THEN
                                                                                RecGrossProfitL."EXP-OTHER" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                                            ELSE
                                                                                IF RecValueEntry2."Item Charge No." = '09' THEN
                                                                                    RecGrossProfitL."EXP-WH HNDL" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                                                ELSE
                                                                                    IF RecValueEntry2."Item Charge No." = '10' THEN
                                                                                        RecGrossProfitL."EXP-INPC" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                                                    ELSE
                                                                                        IF RecValueEntry2."Item Charge No." = '21' THEN
                                                                                            RecGrossProfitL."EXP-WH PACK" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                                                        ELSE
                                                                                            IF RecValueEntry2."Item Charge No." = '24' THEN
                                                                                                RecGrossProfitL."EXP-COO" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                                                            ELSE
                                                                                                IF RecValueEntry2."Item Charge No." = '26' THEN
                                                                                                    RecGrossProfitL."EXP-LEGAL" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                                                                ELSE
                                                                                                    IF RecValueEntry2."Item Charge No." = '32' THEN
                                                                                                        RecGrossProfitL."REBATE TO CUSTOMER" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                                                                    ELSE
                                                                                                        IF RecValueEntry2."Item Charge No." = '33' THEN
                                                                                                            RecGrossProfitL."DEMURRAGE CHARGES" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY
                                                                                                        ELSE
                                                                                                            RecGrossProfitL."Other Charges" += ((RecValueEntry2."Cost Amount (Non-Invtbl.)" * -1) / InvoicedQty) * RecGrossProfitL.QTY;
                                                UNTIL RecValueEntry2.NEXT = 0;
                                        UNTIL RecValueEntry.NEXT = 0;
                                    END;
                                    //moved cogs above
                                    Clear(TotalDiscountAmount);
                                    Clear(TotalSalesInvoiceLineAmount);

                                    CLEAR(RecSalesinvLines2);
                                    RecSalesinvLines2.ChangeCompany(RecGrossProfitL."IC Company Code");
                                    RecSalesinvLines2.RESET;
                                    RecSalesinvLines2.SETRANGE("Document No.", RecSalesinvLines."Document No.");
                                    RecSalesinvLines2.SETRANGE(Type, RecSalesinvLines.Type::"G/L Account");
                                    IF RecSalesinvLines2.FINDFIRST THEN
                                        REPEAT
                                            Clear(GeneralLedgerSetup);
                                            GeneralLedgerSetup.ChangeCompany(RecGrossProfitL."IC Company Code");
                                            GeneralLedgerSetup.RESET;
                                            GeneralLedgerSetup.SETFILTER("GP G/L Accounts", '@*' + RecSalesinvLines2."No." + '*');
                                            IF GeneralLedgerSetup.FINDFIRST THEN BEGIN
                                                TotalDiscountAmount += RecSalesinvLines2."Quantity (Base)" * RecSalesinvLines2."Unit Price Base UOM 2";  //PackingListExtChange
                                            END;
                                        UNTIL RecSalesinvLines2.NEXT = 0;

                                    IF TotalDiscountAmount <> 0 THEN BEGIN
                                        Clear(RecSalesinvLines2);
                                        RecSalesinvLines2.ChangeCompany(RecGrossProfitL."IC Company Code");
                                        RecSalesinvLines2.SETRANGE("Document No.", RecSalesinvLines."Document No.");
                                        RecSalesinvLines2.SETRANGE(Type, RecSalesinvLines2.Type::Item);
                                        IF RecSalesinvLines2.FINDFIRST THEN
                                            REPEAT
                                                TotalSalesInvoiceLineAmount += RecSalesinvLines2."Quantity (Base)" * RecSalesinvLines2."Unit Price Base UOM 2"; //PackingListExtChange
                                            UNTIL RecSalesinvLines2.NEXT = 0;
                                        CurrentLineAmount := RecSalesinvLines."Quantity (Base)" * RecSalesinvLines."Unit Price Base UOM 2"; //PackingListExtChange

                                        IF TotalSalesInvoiceLineAmount <> 0 THEN
                                            RecGrossProfitL."Total Sales Discount" := (CurrentLineAmount / TotalSalesInvoiceLineAmount) * RecGrossProfitL."Total Sales Discount";
                                    END;

                                    RecGrossProfitL."Total Sales Expenses (LCY)" := RecGrossProfitL."EXP-CDT" + RecGrossProfitL."EXP-COO" + RecGrossProfitL."EXP-FRT" + RecGrossProfitL."EXP-INPC" + RecGrossProfitL."EXP-INS" + RecGrossProfitL."EXP-LEGAL" + RecGrossProfitL."EXP-OTHER" + RecGrossProfitL."EXP-SERV" + RecGrossProfitL."EXP-THC" + RecGrossProfitL."EXP-TRC" + RecGrossProfitL."EXP-WH HNDL" + RecGrossProfitL."EXP-WH PACK" + RecGrossProfitL."REBATE TO CUSTOMER" + RecGrossProfitL."DEMURRAGE CHARGES" + RecGrossProfitL."Other Charges";
                                    RecGrossProfitL."COS (LCY)" := RecGrossProfitL."Cogs (LCY)" + RecGrossProfitL."Total Sales Expenses (LCY)";
                                    RecGrossProfitL."Eff GP (LCY)" := RecGrossProfitL."Total Amount (LCY)" - RecGrossProfitL."COS (LCY)";

                                    if RecGrossProfitL."Total Amount (LCY)" <> 0 then
                                        RecGrossProfitL."Eff GP %" := RecGrossProfitL."Eff GP (LCY)" * 100 / (RecGrossProfitL."Total Amount (LCY)")
                                    else
                                        RecGrossProfitL."Eff GP %" := RecGrossProfitL."Eff GP (LCY)" * 100 / 1;

                                    RecGrossProfitL.Modify(true);
                                end;
                            until RecSalesinvLines.Next() = 0;
                        end;
                    until RecSalesInvHeader.Next() = 0;
                end;
            until RecGrossProfitL.Next() = 0;
        end;
    end;

    local procedure UpdateAmountForIndianInvoices()
    var
        RecGrossProfitL: Record "Gross Profit Report";
        CurrencyExchangeRate: Record "Currency Exchange Rate";
    begin
        Clear(RecGrossProfitL);
        RecGrossProfitL.SetRange("Created By Other Instance", true);
        if RecGrossProfitL.FindSet() then
        //comment
        begin
            repeat
                Clear(CurrencyExchangeRate);
                // if RecGrossProfitL."Base UOM Price" <> 0 then
                //     RecGrossProfitL."Base UOM Price" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."Base UOM Price", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");

                if RecGrossProfitL."Total Amount (LCY)" <> 0 then
                    RecGrossProfitL."Total Amount (LCY)" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."Total Amount (LCY)", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");


                // if RecGrossProfitL."Total Amount" <> 0 then
                //     RecGrossProfitL."Total Amount" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."Total Amount", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");

                if RecGrossProfitL."EXP-FRT" <> 0 then
                    RecGrossProfitL."EXP-FRT" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."EXP-FRT", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");//Hypercare from hardcode 'INR' to RecGrossProfitL.CUR

                if RecGrossProfitL."EXP-THC" <> 0 then
                    RecGrossProfitL."EXP-THC" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."EXP-THC", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");//Hypercare from hardcode 'INR' to RecGrossProfitL.CUR

                if RecGrossProfitL."EXP-CDT" <> 0 then
                    RecGrossProfitL."EXP-CDT" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."EXP-CDT", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");//Hypercare from hardcode 'INR' to RecGrossProfitL.CUR

                if RecGrossProfitL."EXP-TRC" <> 0 then
                    RecGrossProfitL."EXP-TRC" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."EXP-TRC", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");//Hypercare from hardcode 'INR' to RecGrossProfitL.CUR

                if RecGrossProfitL."EXP-OTHER" <> 0 then
                    RecGrossProfitL."EXP-OTHER" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."EXP-OTHER", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");//Hypercare from hardcode 'INR' to RecGrossProfitL.CUR

                if RecGrossProfitL."EXP-INS" <> 0 then
                    RecGrossProfitL."EXP-INS" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."EXP-INS", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");//Hypercare from hardcode 'INR' to RecGrossProfitL.CUR

                if RecGrossProfitL."EXP-SERV" <> 0 then
                    RecGrossProfitL."EXP-SERV" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."EXP-SERV", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");//Hypercare from hardcode 'INR' to RecGrossProfitL.CUR

                if RecGrossProfitL."EXP-INPC" <> 0 then
                    RecGrossProfitL."EXP-INPC" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."EXP-INPC", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");//Hypercare from hardcode 'INR' to RecGrossProfitL.CUR


                if RecGrossProfitL."EXP-WH PACK" <> 0 then
                    RecGrossProfitL."EXP-WH PACK" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."EXP-WH PACK", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");//Hypercare from hardcode 'INR' to RecGrossProfitL.CUR

                if RecGrossProfitL."EXP-WH HNDL" <> 0 then
                    RecGrossProfitL."EXP-WH HNDL" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."EXP-WH HNDL", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");//Hypercare from hardcode 'INR' to RecGrossProfitL.CUR

                if RecGrossProfitL."EXP-LEGAL" <> 0 then
                    RecGrossProfitL."EXP-LEGAL" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."EXP-LEGAL", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");//Hypercare from hardcode 'INR' to RecGrossProfitL.CUR

                if RecGrossProfitL."EXP-COO" <> 0 then
                    RecGrossProfitL."EXP-COO" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."EXP-COO", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");//Hypercare from hardcode 'INR' to RecGrossProfitL.CUR

                if RecGrossProfitL."REBATE TO CUSTOMER" <> 0 then
                    RecGrossProfitL."REBATE TO CUSTOMER" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."REBATE TO CUSTOMER", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");//Hypercare from hardcode 'INR' to RecGrossProfitL.CUR

                if RecGrossProfitL."DEMURRAGE CHARGES" <> 0 then
                    RecGrossProfitL."DEMURRAGE CHARGES" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."DEMURRAGE CHARGES", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");//Hypercare from hardcode 'INR' to RecGrossProfitL.CUR

                if RecGrossProfitL."Total Sales Discount" <> 0 then
                    RecGrossProfitL."Total Sales Discount" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."Total Sales Discount", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");


                if RecGrossProfitL."Cogs (LCY)" <> 0 then
                    RecGrossProfitL."Cogs (LCY)" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."Cogs (LCY)", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");//Hypercare from hardcode 'INR' to RecGrossProfitL.CUR


                if RecGrossProfitL."Other Revenue (LCY)" <> 0 then
                    RecGrossProfitL."Other Revenue (LCY)" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."Other Revenue (LCY)", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");//Hypercare from hardcode 'INR' to RecGrossProfitL.CUR

                //Message('%1', RecGrossProfitL."Other Charges");//@@@@@@@@@@@@@@@@@
                if RecGrossProfitL."Other Charges" <> 0 then
                    RecGrossProfitL."Other Charges" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."Other Charges", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");//Hypercare from hardcode 'INR' to RecGrossProfitL.CUR
                // Message('%1', RecGrossProfitL."Other Charges");//@@@@@@@@@@@@@@@@@
                if RecGrossProfitL."Total Sales Expenses (LCY)" <> 0 then
                    RecGrossProfitL."Total Sales Expenses (LCY)" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."Total Sales Expenses (LCY)", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");//Hypercare from hardcode 'INR' to RecGrossProfitL.CUR

                if RecGrossProfitL."COS (LCY)" <> 0 then
                    RecGrossProfitL."COS (LCY)" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."COS (LCY)", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");//Hypercare from hardcode 'INR' to RecGrossProfitL.CUR

                if RecGrossProfitL."Eff GP (LCY)" <> 0 then
                    RecGrossProfitL."Eff GP (LCY)" := CurrencyExchangeRate.ExchangeAmount(RecGrossProfitL."Eff GP (LCY)", RecGrossProfitL.CUR, 'AED', RecGrossProfitL."SI Date");//Hypercare from hardcode 'INR' to RecGrossProfitL.CUR

                if RecGrossProfitL."Total Amount (LCY)" <> 0 then
                    RecGrossProfitL."Eff GP %" := RecGrossProfitL."Eff GP (LCY)" * 100 / (RecGrossProfitL."Total Amount (LCY)")
                else
                    RecGrossProfitL."Eff GP %" := RecGrossProfitL."Eff GP (LCY)" * 100 / 1;

                if RecGrossProfitL."Document Type" = RecGrossProfitL."Document Type"::"Credit Memo" then begin
                    if RecGrossProfitL."Eff GP (LCY)" > 0 then
                        RecGrossProfitL."Eff GP (LCY)" := RecGrossProfitL."Eff GP (LCY)" * -1;

                    if RecGrossProfitL."Eff GP %" > 0 then
                        RecGrossProfitL."Eff GP %" := RecGrossProfitL."Eff GP %" * -1;
                end;
                RecGrossProfitL.Modify();
            until RecGrossProfitL.Next() = 0;
        end
    end;

    var
        RecGrossProfitG: Record "Gross Profit Report";
        StartDate: Date;
        EndDate: Date;
        CompanyName: Text;
        CustomerNo: Code[20];
        TotalSalesInvoiceLineAmount, CurrentLineAmount : Decimal;
        IsAPICall: Boolean;
        RowNumber: Integer;
        GetDataFromOtherinstance: Boolean;
}
