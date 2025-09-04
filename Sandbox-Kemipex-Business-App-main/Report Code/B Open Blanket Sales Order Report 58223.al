report 58223 "Open BSO Report"//T12370-Full Comment  //T12724
{
    UsageCategory = Administration;
    ApplicationArea = all;
    RDLCLayout = 'Reports/B Open Blanket Sales Order Report.rdl';
    Caption = 'Open Blanket SO Report Detail';
    dataset
    {
        dataitem(Company; Company)
        {
            DataItemTableView = where(Name = filter('<>Consolidate All companies&<>Consolidate Caspian&<>Consolidate Kemipex'));
            column(Company_name; Company_short_Name."Short Name") { }
            dataitem("Sales Header"; "Sales Header")
            {
                // RequestFilterFields = "Salesperson Code", "Bill-to Customer No.";
                DataItemTableView = where("Document Type" = filter("Blanket Order"));
                column(Order_Date; "Order Date") { }
                column(No_; "No.") { }
                column("Salesperson"; Sp."Short Name") { }
                column(Bill_to_Customer_No_; "Bill-to Customer No.") { }
                column(Payment_Terms_Code; "Payment Terms Code") { }
                column(Bill_to_Name; CustomerName) { }
                column(Bill_to_County; CustomerCountry) { }
                column(Currency_Code; "Currency Code") { }
                column(Incoterm; "Transaction Specification") { }
                column("PortofDischarge"; POD.Text) { }
                column("PortofLoading"; POL.Description) { }
                column("Status"; Status) { }
                column(SystemCreatedBy; SystemCreatedBy) { }
                column(Transaction_Type; "Transaction Type") { }
                column(Promised_Delivery_Date; "Promised Delivery Date") { }
                dataitem("Sales Line"; "Sales Line")
                {
                    DataItemLink = "Document No." = field("No.");
                    RequestFilterFields = "No.";
                    column(Item_no; "No.") { }
                    column(Variant_Code; "Variant Code") { }
                    column(Line_Description; Description) { }
                    column(Item_Description; ItemDescription) { }
                    column(Base_UOM; "Base UOM 2") { } //PackingListExtChange
                    column(qty_BUOM; "Quantity (Base)") { }
                    column(Qty__Shipped__Base_; "Qty. Shipped (Base)") { }
                    column(Qty__Invoiced__Base_; "Qty. Invoiced (Base)") { }
                    column(Out_qty_BUOM; "Outstanding Qty. (Base)") { }
                    column(UnitPriceBaseUOM; "Unit Price Base UOM 2") { } //PackingListExtChange
                    column(Amount; Amount) { }
                    column(Shipped_Not_Invoiced__LCY_; "Shipped Not Invoiced (LCY)") { }
                    column(Shipped_Not_Inv___LCY__No_VAT; "Shipped Not Inv. (LCY) No VAT") { }
                    column(Outstanding_Amount__LCY_; "Outstanding Amount (LCY)") { }
                    column(ShippedAmount_LCY; ShippedAmount_LCY) { }
                    column(InvoicedAmount_LCY; InvoicedAmount_LCY) { }
                    column(ApprovalEntry; ApprovalEntry."Last Date-Time Modified") { }

                    trigger OnPreDataItem()
                    var
                        myInt: Integer;
                    begin
                        //if pendingInvoice = true then begin
                        //SetFilter("Qty. Shipped Not Invd. (Base)", '<>0');end;
                        ChangeCompany(Company.Name);
                    end;

                    trigger OnAfterGetRecord()
                    var
                        myInt: Integer;
                        VariantRec: Record "Item Variant";
                    begin
                        Clear(ShippedAmount_LCY);
                        Clear(InvoicedAmount_LCY);
                        Clear(ApprovalEntry);
                        Clear(ItemDescription);
                        Item.ChangeCompany(Company.Name);
                        ItemDescription := Description;
                        if Item.Get("No.") then
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


                        ApprovalEntry.ChangeCompany(Company.Name);

                        ApprovalEntry.SetRange("Document No.", "Sales Line"."Document No.");
                        if ApprovalEntry.FindLast() then;

                        ShippedAmount_LCY := "Sales Line"."Qty. Shipped (Base)" * "Sales Line"."Unit Price Base UOM 2"; //PackingListExtChange
                        InvoicedAmount_LCY := "Sales Line"."Qty. Invoiced (Base)" * "Sales Line"."Unit Price Base UOM 2"; //PackingListExtChange
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    GeneralLedgerRec: Record "General Ledger Setup";
                begin
                    Clear(SP);
                    Clear(POD);
                    Clear(POL);
                    Clear(customer);
                    Clear(CustomerName);
                    Clear(CustomerCountry);


                    GeneralLedgerRec.ChangeCompany(Company.Name);
                    sp.ChangeCompany(Company.Name);
                    POD.ChangeCompany(Company.Name);
                    POL.ChangeCompany(Company.Name);
                    customer.ChangeCompany(Company.Name);
                    CountrCodeRec.ChangeCompany(Company.Name);
                    if sp.Get("Sales Header"."Salesperson Code") then;
                    if pod.Get("Sales Header"."Area") then;
                    if POL.Get("Sales Header"."Exit Point") then;
                    if customer.Get("Sales Header"."Bill-to Customer No.") then;
                    GeneralLedgerRec.get();

                    if AlternateCustomerName.Get("Sales Header"."Bill-to Customer No.") then begin
                        CustomerName := AlternateCustomerName.Name;
                        CustomerCountry := AlternateCustomerName."Country/Region Code";
                    end
                    else begin
                        CustomerName := customer.Name;
                        CustomerCountry := customer."Country/Region Code";
                    end;
                    if "Currency Code" = '' then begin
                        //"Currency Code" := 'AED';
                        "Currency Code" := GeneralLedgerRec."LCY Code";
                    end;
                    If customer.Get("Bill-to Customer No.") and (customer."IC Partner Code" > '') and (not Showintercompany) then CurrReport.Skip();
                end;

                trigger OnPreDataItem()
                var
                begin
                    comp.Get();
                    SetFilter("Order Date", '%1..%2', FromDate, ToDate);
                    SetFilter("Salesperson Code", SalesPerson);
                    SetFilter("Bill-to Customer No.", Customer_filter);
                    ChangeCompany(Company.Name);
                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                Company_short_Name.Get(Name);
            end;

            trigger OnPreDataItem()
            var
            begin
                SetFilter(Name, select_company);
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
                    ApplicationArea = all;
                    Caption = 'From Date';
                }
                field(ToDate; ToDate)
                {
                    Caption = 'To Date';
                    ApplicationArea = all;
                }
                field(ItemNo; ItemNo)
                {
                    TableRelation = Item;
                    ApplicationArea = all;
                    Caption = 'Item';
                }
                field(Customer_filter; Customer_filter)
                {
                    TableRelation = Customer;
                    ApplicationArea = all;
                    Caption = 'Customer';
                }
                field(SalesPerson; SalesPerson)
                {
                    ApplicationArea = all;
                    Caption = 'Salesperson';
                    TableRelation = "Salesperson/Purchaser";
                }
                field(select_company; select_company)
                {
                    ApplicationArea = all;
                    Caption = 'Select Company';
                    TableRelation = Company;
                }
                /*
                                field(pendingInvoice; pendingInvoice)
                                {
                                    Caption = 'Show Pending Invoice Orders';
                                    ApplicationArea = all;
                                }
                  */
                field(Showintercompany; Showintercompany)
                {
                    Caption = 'Show Intercompany SO';
                    ApplicationArea = all;
                }
            }
        }
    }

    var
        POL: Record "Entry/Exit Point";
        POD: Record "Area";
        comp: Record "Company Information";
        SP: Record "Salesperson/Purchaser";
        AlternateCustomerName: Record "Customer Alternet Address";
        customer: Record Customer;
        Company_short_Name: Record "Company Short Name";
        FromDate: Date;
        ToDate: date;
        Showintercompany: Boolean;
        pendingInvoice: Boolean;
        SalesPerson: Text;
        ItemNo: Text;
        Customer_filter: Text;
        select_company: Text;
        ShippedAmount_LCY: Decimal;
        InvoicedAmount_LCY: Decimal;
        CustomerName: Text;
        CustomerCountry: Text;
        CountrCodeRec: Record "Country/Region";
        ApprovalEntry: Record "Approval Entry";
        ItemDescription: Text[100];
        item: Record Item;
}