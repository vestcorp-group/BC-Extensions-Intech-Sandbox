report 58133 "Sales Shipment Line Report"//T12370-Full Comment     //T13413-Full UnComment
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = 'Reports/Sales Shipment Line Report.rdl';
    Caption = 'Sales Shipment Report';
    dataset
    {
        dataitem(Company2; Company)
        {
            RequestFilterFields = Name;
            column(Name; company_short_name."Short Name") { }
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemTableView = where("Posting Group" = filter('<>Sample'), "Type" = filter(item), Correction = filter(false));
                column(Posting_Group; "Posting Group") { }
                column(Posting_Date; "Posting Date") { }
                column(Document_No_; "Document No.") { }
                column(Sales_invoice_No; Sales_invoice_No) { }
                column(Bill_to_Customer_No_; "Bill-to Customer No.") { }
                column("Customer_Name"; customer.Name) { }
                column("Customer_Country"; Country.Name) { }
                column("salesPerson"; sp."Short Name") { }
                column(Location_Code; "Location Code") { }
                column(No_; "No.") { }
                column(ItemNickName; ItemDescription) { }
                column(Line_Description; Description) { }
                column(Variant_Code; "Variant Code") { }
                column(Base_UOM; "Base UOM 2") { } //PackingListExtChange
                column(Quantity__Base_; "Quantity (Base)") { }
                column(Currency_Code; "Currency Code") { }
                column(Unit_Price_Base_UOM; "Unit Price Base UOM 2") { } //PackingListExtChange
                column(Amount; Amount) { }
                column(Order_No_; "Order No.") { }
                column(Transaction_Type; "Transaction Type") { }
                trigger OnAfterGetRecord()
                var
                    GLE: Record "General Ledger Setup";
                    Sales_invoice_line: Record "Sales Invoice Line";
                    ILE: Record "Item Ledger Entry";
                    VLE: Record "Value Entry";
                    VariantRec: Record "Item Variant";
                begin
                    Clear(customer);
                    Clear(Country);
                    Clear(SalesShipmentHeader);
                    Clear(sp);
                    Clear(Sales_invoice_No);
                    Clear(ItemDescription);

                    Sales_invoice_line.ChangeCompany(Company2.Name);
                    SalesShipmentHeader.ChangeCompany(Company2.Name);
                    customer.ChangeCompany(Company2.Name);
                    VLE.ChangeCompany(Company2.Name);
                    ILE.ChangeCompany(Company2.Name);

                    if customer.get("Sales Shipment Line"."Bill-to Customer No.") then;
                    if Country.get(customer."Country/Region Code") then;
                    if SalesShipmentHeader.get("Sales Shipment Line"."Document No.") then;
                    if sp.get(SalesShipmentHeader."Salesperson Code") then;
                    if item.get("Sales Shipment Line"."No.") then;
                    Amount := "Quantity (Base)" * "Unit Price Base UOM 2"; //PackingListExtChange
                    gle.Get();
                    if "Currency Code" = '' then "Currency Code" := GLE."LCY Code";
                    If customer.Get("Bill-to Customer No.") and (customer."IC Partner Code" > '') and (not Showintercompany) then CurrReport.Skip();
                    ItemDescription := Description;
                    if type = Type::Item then
                        if "Variant Code" <> '' then begin // added by bayas
                            VariantRec.Get("No.", "Variant Code");
                            if VariantRec.Description <> '' then begin
                                ItemDescription := VariantRec.Description;
                            end else begin
                                ItemDescription := item.Description;
                            end;
                        end else begin
                            ItemDescription := item.Description;
                        end;

                    Sales_invoice_line.SetRange("Shipment No.", "Document No.");
                    Sales_invoice_line.SetRange("Shipment Line No.", "Line No.");
                    if Sales_invoice_line.FindSet() then
                        Sales_invoice_No := Sales_invoice_line."Document No."
                    else begin
                        ILE.SetRange("Document Type", ILE."Document Type"::"Sales Shipment");
                        ile.SetRange("Document No.", "Document No.");
                        if ILE.FindFirst() THEN begin
                            VLE.SetRange("Item Ledger Entry No.", ILE."Entry No.");
                            VLE.SetRange("Document Type", VLE."Document Type"::"Sales Invoice");
                            if VLE.FindFirst() then
                                Sales_invoice_No := VLE."Document No.";
                        end;
                    end;
                end;

                trigger OnPreDataItem()
                var
                begin
                    SetFilter("Posting Date", '%1..%2', FromDate, ToDate);
                    SetFilter("No.", ItemFil);
                    ChangeCompany(Company2.Name);
                end;
            }
            trigger OnAfterGetRecord()
            var
                RecShortName: Record "Company Short Name";//20MAY2022
            begin
                company_short_name.Get(Name);
                Clear(RecShortName);//20MAY2022
                RecShortName.SetRange(Name, Name);
                RecShortName.SetRange("Block in Reports", true);
                if RecShortName.FindFirst() then
                    CurrReport.Skip();
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
                group(GroupName)
                {
                    field("From Date"; FromDate)
                    {
                        ApplicationArea = all;
                    }
                    field("To Date"; ToDate)
                    {
                        ApplicationArea = all;
                    }
                    field(ItemFil; ItemFil)
                    {
                        Caption = 'Item';
                        ApplicationArea = all;
                        TableRelation = Item;
                    }
                    field(Showintercompa; Showintercompany)
                    {
                        Caption = 'Show Intercompany Sales';
                        ApplicationArea = all;
                    }
                }
            }
        }
    }
    var
        item: Record Item;
        customer: Record Customer;
        SP: Record "Salesperson/Purchaser";
        Country: Record "Country/Region";
        SalesShipmentHeader: Record "Sales Shipment Header";
        //   Company: Record "Company Information";
        Amount: Decimal;
        FromDate: Date;
        ToDate: date;
        Showintercompany: Boolean;
        Select_Company: Text;
        company_short_name: Record "Company Short Name";
        ItemFil: Code[30];
        Sales_invoice_No: Code[20];
        DOcLineTracking: Page "Document Line Tracking";
        ItemDescription: Text[100];
}