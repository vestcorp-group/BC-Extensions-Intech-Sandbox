report 50116 "IC Related SO Batch"//06-02-2025 T50891-N
{
    ApplicationArea = All;
    Caption = 'IC Related SO Batch';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    UseRequestPage = true;
    Permissions = tabledata "Sales Invoice Line" = rm;
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
                    field(MakeAllBlank; BlankBln)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    var

    begin

    end;

    trigger OnPostReport()
    var

    begin
        if StartDate = 0D then
            Error('From Date must have a value');
        if EndDate = 0D then
            Error('To Date must have a value');

        ICRelatedSOUpdateForSalesInvoice();

    end;

    procedure InitializeReportParameter(StartDt: Date; EndDt: Date; IsAPI: Boolean)
    begin
        StartDate := StartDt;
        EndDate := EndDt;
        IsApiCall := IsAPI;
    end;





    local procedure ICRelatedSOUpdateForSalesInvoice()
    var
        FinalCustomerRecSalesInvHeader: Record "Sales Invoice Header";
        FinalCustomerRecSalesinvLines: Record "Sales Invoice Line";
        DestinationRecSalesInvHeader: Record "Sales Invoice Header";
        DestinationRecSalesInvLines: Record "Sales Invoice Line";
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
        //
        PurchaseHeader: Record "Purchase Header";
        PurchaseReceiptHeader: Record "Purch. Rcpt. Header";
        PurchaseReceiptLine: Record "Purch. Rcpt. Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        FindGRNLedgerEntry: Record "Item Ledger Entry";
        ItemApplicationEntry: Record "Item Application Entry";
        SalesShipmentHeader: Record "Sales Shipment Header";
        salesshiomentLine: Record "Sales Shipment Line";

    //
    begin

        if BlankBln then begin
            Clear(Companies);
            if CompanyName <> '' then
                Companies.SetRange(Name, CompanyName);
            if Companies.FindSet() then begin
                repeat
                    RecSalesinvLines2.ChangeCompany(Companies.Name);
                    RecSalesinvLines2.Reset();
                    RecSalesinvLines2.SetFilter("IC Related SO", '<>%1', '');
                    if RecSalesinvLines2.FindSet() then
                        repeat
                            RecSalesinvLines2."IC Related SO" := '';
                            RecSalesinvLines2.Modify();
                        until RecSalesinvLines2.Next() = 0;
                until Companies.Next() = 0;
            end;
        end;

        Clear(Companies);
        if CompanyName <> '' then
            Companies.SetRange(Name, CompanyName);
        Companies.FindSet();
        repeat
            //Go to each company
            Clear(FinalCustomerRecSalesInvHeader);
            FinalCustomerRecSalesInvHeader.ChangeCompany(Companies.Name);
            FinalCustomerRecSalesInvHeader.SetRange("Posting Date", StartDate, EndDate);
            if CustomerNo <> '' then
                FinalCustomerRecSalesInvHeader.SetRange("Sell-to Customer No.", CustomerNo);
            if FinalCustomerRecSalesInvHeader.FindSet() then begin //Apply Filter and find Sales Invoices in the same company.
                repeat
                    CLEAR(RecCsutomerL);
                    RecCsutomerL.ChangeCompany(Companies.Name);
                    RecCsutomerL.SETRANGE("No.", FinalCustomerRecSalesInvHeader."Sell-to Customer No.");
                    IF (RecCsutomerL.FINDFIRST) and (RecCsutomerL."IC Partner Code" = '') THEN begin //If Customer is Final Sales Customer then go ahead and find lines in the same company.
                        FinalCustomerRecSalesinvLines.ChangeCompany(Companies.Name);
                        FinalCustomerRecSalesinvLines.Reset();
                        FinalCustomerRecSalesinvLines.SetRange("Document No.", FinalCustomerRecSalesInvHeader."No.");
                        FinalCustomerRecSalesinvLines.SetFilter("Shipment No.", '<>%1', '');
                        if FinalCustomerRecSalesinvLines.FindFirst() then begin //We are fidnding the lines which has Shipment numbers in the same company.
                            SalesShipmentHeader.ChangeCompany(Companies.Name);
                            SalesShipmentHeader.reset;
                            SalesShipmentHeader.SetRange("No.", FinalCustomerRecSalesinvLines."Shipment No.");
                            SalesShipmentHeader.SetFilter("Order No.", '<>%1', '');
                            if SalesShipmentHeader.FindFirst() then begin // We are finding the Sales Shipment number which has Order number in header in same company.
                                Clear(ItemLedgerEntry);
                                ItemLedgerEntry.ChangeCompany(Companies.Name);
                                ItemLedgerEntry.reset;
                                ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
                                ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Sales Shipment");
                                ItemLedgerEntry.SetRange("Document No.", SalesShipmentHeader."No.");
                                if ItemLedgerEntry.FindFirst() then begin //Using Shipment for finding the Sales ILE in same company.
                                    Clear(ItemApplicationEntry);
                                    ItemApplicationEntry.ChangeCompany(Companies.Name);
                                    ItemApplicationEntry.SetRange("Outbound Item Entry No.", ItemLedgerEntry."Entry No.");
                                    ItemApplicationEntry.Setfilter("Inbound Item Entry No.", '<>%1', 0);
                                    ItemApplicationEntry.SetRange("Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
                                    if ItemApplicationEntry.FindFirst() then begin
                                        Clear(FindGRNLedgerEntry);
                                        FindGRNLedgerEntry.ChangeCompany(Companies.Name);
                                        FindGRNLedgerEntry.Reset(); // Through Magic we found the Inbound ILE.
                                        if FindGRNLedgerEntry.get(ItemApplicationEntry."Inbound Item Entry No.") and (FindGRNLedgerEntry."Document Type" = FindGRNLedgerEntry."Document Type"::"Purchase Receipt") then begin
                                            Clear(PurchaseReceiptHeader); //After making sure that it is Purchase entry we are fidning the GRN header which must have order.
                                            PurchaseReceiptHeader.ChangeCompany(Companies.Name);
                                            PurchaseReceiptHeader.Reset();
                                            PurchaseReceiptHeader.SetRange("No.", FindGRNLedgerEntry."Document No.");
                                            PurchaseReceiptHeader.SetFilter("Order No.", '<>%1', '');
                                            if PurchaseReceiptHeader.FindFIRST() then begin
                                                Clear(ICCompanyList);
                                                ICCompanyList.SetFilter(Name, '<>%1', Companies.Name); //find in different companies other than current company.
                                                IF ICCompanyList.FindSet() THEN
                                                    REPEAT
                                                        if PurchaseReceiptHeader."Vendor Order No." <> '' then begin //If Previous company Vendor Order No in PO is not blank.
                                                            Clear(DestinationRecSalesInvLines);
                                                            DestinationRecSalesInvLines.ChangeCompany(ICCompanyList.Name);//Initial Company
                                                            DestinationRecSalesInvLines.reset;
                                                            // DestinationRecSalesInvLines.SetRange("Document No.", DestinationRecSalesInvHeader."No.");
                                                            DestinationRecSalesInvLines.SetRange("Order No.", PurchaseReceiptHeader."Vendor Order No."); //We are finding the Sales Invoice lines with the order considering the user would have used the Shipment function for the creating the invoice.
                                                            if DestinationRecSalesInvLines.FindSet() then
                                                                repeat
                                                                    DestinationRecSalesInvLines."IC Related SO" := FinalCustomerRecSalesInvHeader."Order No.";
                                                                    DestinationRecSalesInvLines.Modify();
                                                                until DestinationRecSalesInvLines.next = 0;
                                                        end
                                                        else begin
                                                            CLEAR(PurchaseHeader);
                                                            PurchaseHeader.ChangeCompany(Companies.Name);
                                                            PurchaseHeader.RESET;
                                                            PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
                                                            PurchaseHeader.SetRange("No.", PurchaseReceiptHeader."Order No.");
                                                            PurchaseHeader.SetFilter("Vendor Order No.", '<>%1', ''); // Finding PO with the help of GRN to get the Vendor Order no in the Selling company..
                                                            IF PurchaseHeader.FindLAST() THEN begin
                                                                Clear(DestinationRecSalesInvHeader);
                                                                DestinationRecSalesInvHeader.ChangeCompany(ICCompanyList.Name);
                                                                DestinationRecSalesInvHeader.Reset();
                                                                DestinationRecSalesInvHeader.SetRange("Order No.", PurchaseHeader."Vendor Order No."); //Using the Order no to find the Sales Invoice creating in the Supplying comapany.
                                                                if DestinationRecSalesInvHeader.FindLast() then begin
                                                                    Clear(DestinationRecSalesInvLines);
                                                                    DestinationRecSalesInvLines.ChangeCompany(ICCompanyList.Name);//Selling Company
                                                                    DestinationRecSalesInvLines.reset;
                                                                    DestinationRecSalesInvLines.SetRange("Document No.", DestinationRecSalesInvHeader."No."); //Selling Company finding the lines of the Sales Invoice.
                                                                    // DestinationRecSalesInvLines.SetRange("Order No.", PurchaseReceiptHeader."Vendor Order No.");
                                                                    if DestinationRecSalesInvLines.FindSet() then
                                                                        repeat
                                                                            DestinationRecSalesInvLines."IC Related SO" := FinalCustomerRecSalesInvHeader."Order No.";
                                                                            DestinationRecSalesInvLines.Modify();
                                                                        until DestinationRecSalesInvLines.next = 0;
                                                                end;
                                                            end;
                                                        end;
                                                    until ICCompanyList.next = 0;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                // end;
                //close IC Partner
                until FinalCustomerRecSalesInvHeader.Next() = 0;
            end;
        // end;
        until Companies.Next() = 0;
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
        BlankBln: Boolean;
}
