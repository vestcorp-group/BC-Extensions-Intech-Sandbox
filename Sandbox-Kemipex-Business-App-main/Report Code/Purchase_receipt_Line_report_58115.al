Report 58115 Purchase_reciept_report//T12370-Full Comment
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    RDLCLayout = 'Reports/Purchase_receipt_line_report.rdl';
    Caption = 'Purchase Receipt Report';
    dataset
    {
        dataitem(Company2; Company)
        {
            DataItemTableView = where(Name = filter('<>Consolidate All companies&<>Consolidate Caspian&<>Consolidate Kemipex'));
            column(company_short_name; company_short_name."Short Name") { }
            dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
            {
                DataItemTableView = where(Quantity = filter('<>0'));
                //  RequestFilterFields = "Buy-from Vendor No.", "No.";
                column(BPO_date; Purch_header_archive."Order Date") { }
                column(Blanket_Order_No_; "Blanket Order No.") { }
                column(Order_No_; "Order No.") { }
                column(Order_Date; "Order Date") { }
                column(Posting_Date; "Posting Date") { }
                column(Document_No_; "Document No.") { }
                column(Buy_from_Vendor_No_; "Buy-from Vendor No.") { }
                column(Vendor_Name; vendor.Name) { }
                column(No_; "No.") { }
                column(Description; Description) { }
                column(Location_Code; "Location Code") { }
                column("BaseUOM"; itemrec."Base Unit of Measure") { }
                column("BaseUOMQty"; "Quantity (Base)") { }
                column(Currency_Code; "Currency Code") { }
                column(Direct_Unit_Cost; "Direct Unit Cost") { }
                column(TotalAmt; TotalAmt) { }
                column(CustomETD; CustomETD) { }
                column(CustomETA; CustomETA) { }
                column(CustomR_ETD; CustomR_ETD) { }
                column(CustomR_ETA; CustomR_ETA) { }
                column(Vendor_invoice_no; Vendor_invoice_no) { }
                column("Incoterm"; PR_header."Transaction Specification") { }
                column(UnitPrice_var; UnitPrice_var) { }
                column(purchaseInvoiceNo; purchaseInvoiceNo) { }
                column(Vendor_Invoice_Date; PR_header."Document Date") { }
                trigger OnAfterGetRecord()
                var
                    GLS: Record "General Ledger Setup";
                    postedPurchaseInvoiceheader: Record "Purch. Inv. Header";
                    PostedPurchaseInvoiceLine: Record "Purch. Inv. Line";
                begin
                    Clear(TotalAmt);
                    Clear(PR_header);
                    Clear(vendor);
                    Clear(TotalAmt);
                    Clear(Purch_header_archive);
                    Clear(itemRec);
                    Clear(Vendor_invoice_no);
                    Clear(UnitPrice_var);
                    Clear(purchaseInvoiceNo);

                    vendor.ChangeCompany(Company2.Name);
                    Purch_header_archive.ChangeCompany(Company2.Name);
                    PR_header.ChangeCompany(Company2.Name);
                    postedPurchaseInvoiceheader.ChangeCompany(Company2.Name);
                    PostedPurchaseInvoiceLine.ChangeCompany(Company2.Name);

                    PostedPurchaseInvoiceLine.SetRange("Receipt No.", "Purch. Rcpt. Line"."Document No.");
                    PostedPurchaseInvoiceLine.SetRange("Receipt Line No.", "Purch. Rcpt. Line"."Line No.");
                    if PostedPurchaseInvoiceLine.FindFirst() then begin
                        UnitPrice_var := PostedPurchaseInvoiceLine."Direct Unit Cost" * PostedPurchaseInvoiceLine."Qty. per Unit of Measure";
                        purchaseInvoiceNo := PostedPurchaseInvoiceLine."Document No.";
                        postedPurchaseInvoiceheader.SetRange("No.", PostedPurchaseInvoiceLine."Document No.");
                        if postedPurchaseInvoiceheader.FindFirst() then
                            Vendor_invoice_no := postedPurchaseInvoiceheader."Vendor Invoice No.";
                    end;

                    if vendor.Get("Purch. Rcpt. Line"."Buy-from Vendor No.") then;
                    if itemRec.Get("Purch. Rcpt. Line"."No.") then;
                    if PR_header.Get("Purch. Rcpt. Line"."Document No.") then;
                    // if Purch_header_archive.Get("Blanket Order No.") then;

                    //TotalAmt := "Direct Unit Cost" * Quantity;
                    gls.Get();
                    if "Currency Code" = '' then "Currency Code" := gls."LCY Code";
                    If Vendor.Get("Buy-from Vendor No.") and (Vendor."IC Partner Code" > '') and (not Showintercompa) then CurrReport.Skip();
                    //  if "Document No." = '' then CurrReport.Skip();
                end;

                trigger OnPreDataItem()
                var
                begin
                    ChangeCompany(Company2.Name);
                    SetFilter("Posting Date", '%1..%2', FromDate, ToDate);
                    SetFilter("No.", Item);
                    SetFilter("Buy-from Vendor No.", VendorVar);
                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                RecShortName: Record "Company Short Name";//20MAY2022
            begin
                company_short_name.Get(Name);
                Clear(RecShortName);//20MAY2022
                RecShortName.SetRange(Name, Name);
                RecShortName.SetRange("Block in Reports", true);
                if RecShortName.FindFirst() then
                    CurrReport.Skip();
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetFilter(Name, selectCompany);
            end;
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                field(FromDate; FromDate)
                {
                    Caption = 'From Date:';
                    ApplicationArea = all;
                }
                field(ToDate; ToDate)
                {
                    Caption = 'To Date:';
                    ApplicationArea = all;
                }
                field(Item; Item)
                {
                    Caption = 'Item';
                    TableRelation = Item;
                    ApplicationArea = all;
                }
                field(VendorVar; VendorVar)
                {
                    Caption = 'Vendor';
                    TableRelation = Vendor;
                    ApplicationArea = all;
                }
                field(selectCompany; selectCompany)
                {
                    Caption = 'Select Company';
                    ApplicationArea = all;
                    TableRelation = Company;
                }
                field(Showintercompa; Showintercompa)
                {
                    Caption = 'Show Intercompany Purchase';
                    ApplicationArea = all;
                }
            }
        }
    }

    var
        vendor: Record Vendor;
        company_short_name: Record "Company Short Name";
        PR_header: Record "Purch. Rcpt. Header";
        Purch_header_archive: Record "Purchase Header Archive";
        TotalAmt: Decimal;
        FromDate: Date;
        ToDate: date;
        Showintercompa: Boolean;
        Item: Code[20];
        VendorVar: Code[20];
        selectCompany: Text;
        itemRec: Record Item;
        UnitPrice_var: Decimal;
        Vendor_invoice_no: Text[50];
        purchaseInvoiceNo: Text[20];
}
