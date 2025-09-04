report 85209 MyReportError
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = Excel;
    ExcelLayout = 'abc.xlsx';

    dataset
    {
        dataitem(Company; Company)
        {

            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {

                dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = field("No.");

                    column(InvoiceNo; "Sales Invoice Header"."No.")
                    {

                    }
                    column(LineNo; "Sales Invoice Line"."Line No.")
                    {

                    }
                    column(ErrorText_gTxt; ErrorText_gTxt)
                    {

                    }

                    trigger OnAfterGetRecord()
                    var
                    begin
                        if not CheckforError("Sales Invoice Header", "Sales Invoice Line", Company) then begin
                            ErrorText_gTxt := GetLastErrorText;
                            ClearLastError();
                        end
                        else
                            CurrReport.Skip();
                    end;

                }

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                    Customer_lrec: Record Customer;
                begin
                    Customer_lrec.Reset();
                    if Customer_lrec.Get("Sales Invoice Header"."Sell-to Customer No.") then begin
                        if Customer_lrec."IC Partner Code" <> '' then
                            CurrReport.Skip();
                    end
                end;
            }
        }
    }

    [TryFunction]
    procedure CheckforError(SalesInvoiceHeader_lRec: Record "Sales Invoice Header"; SalesInvoiceline_lRec: Record "Sales Invoice Line"; Companies_lRec: Record Company)
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseReceiptHeader: Record "Purch. Rcpt. Header";
        PurchaseReceiptLine: Record "Purch. Rcpt. Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        FindGRNLedgerEntry: Record "Item Ledger Entry";
        ItemApplicationEntry: Record "Item Application Entry";
        SalesShipmentLine: Record "Sales Shipment Line";
        ICShipmentLine: Record "Sales Shipment Line";
        ICRecSalesInvHeader: Record "Sales Invoice Header";
        ICSalesOrderNumber: Code[50];
        ICILE: Record "Item Ledger Entry";
        Companies: Record Company;
        ICCompanyList: Record Company;
        ICSalesOrderInvoiceLines: Record "Sales Invoice Line";
        RecSalesinvLines: Record "Sales Invoice Line";
        ICCOGSLCY: Decimal;
        ICValueEntry: Record "Value Entry";
        ICValueEntry2: Record "Value Entry";
        Vendor_lRec: Record Vendor;
        ICPartner_lRec: Record "IC Partner";
    begin
        SalesShipmentLine.ChangeCompany(Companies_lRec.Name);
        SalesShipmentLine.reset;
        SalesShipmentLine.SetRange("Order No.", SalesInvoiceHeader_lRec."Order No.");
        SalesShipmentLine.SetRange("No.", SalesInvoiceline_lRec."No.");
        if not SalesShipmentLine.FindLast() then
            Error('Sales Shipment not found'); // We are finding the Sales Shipment number which has Order number in header in same company.
        Clear(ItemLedgerEntry);
        ItemLedgerEntry.ChangeCompany(Companies_lRec.Name);
        ItemLedgerEntry.reset;
        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Sale);
        ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Sales Shipment");
        ItemLedgerEntry.SetRange("Document No.", SalesShipmentLine."Document No.");
        ItemLedgerEntry.SetRange("Document Line No.", SalesShipmentLine."Line No.");
        if not ItemLedgerEntry.FindSet() then Error('ILE of Sales not found.'); //Using Shipment for finding the Sales ILE in same company.
        repeat
            Clear(ItemApplicationEntry);
            ItemApplicationEntry.ChangeCompany(Companies_lRec.Name);
            ItemApplicationEntry.SetRange("Outbound Item Entry No.", ItemLedgerEntry."Entry No.");
            ItemApplicationEntry.Setfilter("Inbound Item Entry No.", '<>%1', 0);
            ItemApplicationEntry.SetRange("Item Ledger Entry No.", ItemLedgerEntry."Entry No.");
            if not ItemApplicationEntry.FindSet() then Error('Item Application entry not found for Purchase.');
            repeat
                Clear(FindGRNLedgerEntry);
                FindGRNLedgerEntry.ChangeCompany(Companies_lRec.Name);
                FindGRNLedgerEntry.Reset(); // Through Magic we found the Inbound ILE.
                if not FindGRNLedgerEntry.get(ItemApplicationEntry."Inbound Item Entry No.") then error('GRN ILE not found'); //and (FindGRNLedgerEntry."Document Type" = FindGRNLedgerEntry."Document Type"::"Purchase Receipt")
                Clear(PurchaseReceiptHeader); //After making sure that it is Purchase entry we are fidning the GRN header which must have order.
                PurchaseReceiptHeader.ChangeCompany(Companies_lRec.Name);
                PurchaseReceiptHeader.Reset();
                PurchaseReceiptHeader.SetRange("No.", FindGRNLedgerEntry."Document No.");
                PurchaseReceiptHeader.SetFilter("Order No.", '<>%1', '');
                if not PurchaseReceiptHeader.FindLast() then error('Purchase Receipt not found.');
                if PurchaseReceiptHeader."Vendor Order No." <> '' then begin
                    ICSalesOrderNumber := PurchaseReceiptHeader."Vendor Order No."; //If Previous company Vendor Order No in PO is not blank.
                end
                else begin
                    CLEAR(PurchaseHeader);
                    PurchaseHeader.ChangeCompany(Companies_lRec.Name);
                    PurchaseHeader.RESET;
                    PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
                    PurchaseHeader.SetRange("No.", PurchaseReceiptHeader."Order No.");
                    PurchaseHeader.SetFilter("Vendor Order No.", '<>%1', ''); // Finding PO with the help of GRN to get the Vendor Order no in the Selling company..
                    IF PurchaseHeader.FindLAST() THEN begin
                        ICSalesOrderNumber := PurchaseHeader."Vendor Order No.";
                    end;
                end;
                Vendor_lRec.ChangeCompany(Companies_lRec.Name);
                Vendor_lRec.Reset();
                if Vendor_lRec.Get(PurchaseHeader."Buy-from Vendor No.") then begin
                    if Vendor_lRec."IC Partner Code" = '' then exit;
                end;
                if ICSalesOrderNumber = '' then Error('ICSalesOrderNumber Not found.');
                ICPartner_lRec.ChangeCompany(Companies_lRec.Name);
                ICPartner_lRec.Reset();
                ICPartner_lRec.Get(Vendor_lRec."IC Partner Code");
                if ICPartner_lRec."Data Exchange Type" = ICPartner_lRec."Data Exchange Type"::Database then begin
                    ICCompanyList.Reset();
                    ICCompanyList.SetRange(Name, ICPartner_lRec."Inbox Details");
                    IF ICCompanyList.FindFirst() THEN
                        REPEAT
                            Clear(ICRecSalesInvHeader);
                            ICRecSalesInvHeader.ChangeCompany(ICCompanyList.Name);
                            ICRecSalesInvHeader.Reset();
                            ICRecSalesInvHeader.SetRange("Order No.", ICSalesOrderNumber); //Using the Order no to find the Sales Invoice creating in the Supplying comapany.
                            if not ICRecSalesInvHeader.FindLast() then Error('IC Sales Invoice not found.');
                            Clear(ICSalesOrderInvoiceLines);
                            ICSalesOrderInvoiceLines.ChangeCompany(ICCompanyList.Name);//Selling Company
                            ICSalesOrderInvoiceLines.reset;
                            ICSalesOrderInvoiceLines.SetRange("Document No.", ICRecSalesInvHeader."No."); //Selling Company finding the lines of the Sales Invoice.
                            ICSalesOrderInvoiceLines.SETRANGE("No.", RecSalesinvLines."No.");
                            if not ICSalesOrderInvoiceLines.FindLast() then Error('IC Sales Line not found.');

                            Clear(ICShipmentLine);
                            ICShipmentLine.ChangeCompany(ICCompanyList.Name);
                            ICShipmentLine.Reset();
                            ICShipmentLine.SetRange("Order No.", ICSalesOrderNumber);
                            ICShipmentLine.SetRange("No.", SalesInvoiceline_lRec."No.");
                            if not ICShipmentLine.FindLast() then Error('IC Shipment not found.');
                            Clear(ICILE);
                            ICILE.ChangeCompany(ICCompanyList.Name);
                            ICILE.Reset();
                            ICILE.SetRange("Document No.", ICShipmentLine."Document No.");
                            ICILE.SetRange("Document Line No.", ICShipmentLine."Line No.");
                            ICILE.SetRange("Item No.", SalesInvoiceline_lRec."No.");
                            ICILE.SetRange("Variant Code", SalesInvoiceline_lRec."Variant Code");
                            // ICILE.SetRange("Lot No.", FindGRNLedgerEntry."Lot No."); //We need to check if they require lot filter if only it is remaining same.
                            if not ICILE.FindLast() then Error('IC Sales ILE not found.');
                            CLEAR(ICValueEntry);
                            ICValueEntry.ChangeCompany(ICCompanyList.Name);
                            ICValueEntry.RESET;
                            ICValueEntry.SETRANGE("Item Ledger Entry No.", ICILE."Entry No.");
                            ICValueEntry.SetRange("Document No.", ICSalesOrderInvoiceLines."Document No.");
                            ICValueEntry.SETRANGE("Document Line No.", ICSalesOrderInvoiceLines."Line No.");
                            if not ICValueEntry.FindSet() then Error('IC Sales Value entry not found.');
                        until ICCompanyList.Next() = 0;
                end;
            until ItemApplicationEntry.Next() = 0;
        until ItemLedgerEntry.Next() = 0;

    end;

    var
        myInt: Integer;
        ErrorText_gTxt: Text;
}