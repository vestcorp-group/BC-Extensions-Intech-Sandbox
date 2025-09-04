report 58219 "S004Purchase In Transit Report"//T12370-Full Comment  //T13413-Full UnComment
{
    UsageCategory = Administration;
    ApplicationArea = all;
    RDLCLayout = 'Reports/Purchase Intransit Report.rdl';
    Caption = 'S004 Purchase In Transit Report';

    dataset
    {
        dataitem(Company; Company)
        {
            column(Company_name; Company_short_Name."Short Name") { }
            dataitem("Purchase Line"; "Purchase Line")
            {
                RequestFilterFields = "Location Code";

                DataItemTableView = where("Document Type" = filter(Order));
                // column(comp; comp.Name) { }
                column(Order_Date; "Order Date") { }
                column(Document_No_; "Document No.") { }
                column(No_; "No.") { }
                column(Currency_Code; "Currency Code") { }
                column(Buy_from_Vendor_No_; "Buy-from Vendor No.") { }
                column(Vendor; Vendor.Name) { }
                column(Location_Code; "Location Code") { }
                column(Quantity__Base_; "Quantity (Base)") { DecimalPlaces = 0 : 3; }
                column(Qty__Received__Base_; "Qty. Received (Base)") { DecimalPlaces = 0 : 3; }
                column(Qty__Invoiced__Base_; "Qty. Invoiced (Base)") { DecimalPlaces = 0 : 3; }
                column(Quantity; Quantity) { }
                column(Base_UOM; "Base UOM") { }
                column(Unit_of_Measure; "Unit of Measure") { }
                column(itemName; ItemSearchDesc) { }
                column(CustomETA; CustomETA) { }
                column(CustomETD; CustomETD) { }
                column(CustomR_ETD; CustomR_ETD) { }
                column(CustomR_ETA; CustomR_ETA) { }
                column(Quantity_Received; "Quantity Received") { }
                column(Quantity_Invoiced; "Quantity Invoiced") { }

                column(Reserved_Qty___Base_; "Reserved Qty. (Base)") { }
                column(ItemOrigin; Country_Region_Code) { }
                column(Sales_Order_No_; "Sales Order No.") { }
                column(CustomerName; SalesHeader."Bill-to Name") { }
                column(SalesPersonShortName; SPRec."Short Name") { }
                column(Variant_Code; "Variant Code") { }
                column(PackingDescription; PackingDescription) { }



                trigger OnAfterGetRecord()
                var

                    VariantRec: Record "Item Variant";

                begin

                    if "Document No." = '' then CurrReport.Skip();
                    Clear(item);
                    Clear(ReceivedAmount);
                    Clear(SalesHeader);
                    Clear(SPRec);
                    Clear(PackingDescription);

                    Vendor.ChangeCompany(Company.Name);
                    item.ChangeCompany(Company.Name);
                    SPRec.ChangeCompany(Company.Name);
                    SalesHeader.ChangeCompany(Company.Name);

                    if item.Get("Purchase Line"."No.") then;
                    if "Currency Code" = '' then "Currency Code" := 'AED';
                    If Vendor.Get("Buy-from Vendor No.") and (Vendor."IC Partner Code" > '') and (not Showintercompa) then CurrReport.Skip();
                    ReceivedAmount := "Quantity Received" * "Direct Unit Cost";

                    if SalesHeader.get("Document Type"::Order, "Sales Order No.") then;
                    if SPRec.Get(SalesHeader."Salesperson Code") then;
                    if ItemOrginRec.Get(item."Country/Region of Origin Code") then;
                    if item."Inventory Posting Group" = 'CONSUMABLE' then CurrReport.Skip();
                    if item.Type = item.Type::"Non-Inventory" then CurrReport.Skip();

                    if "Variant Code" <> '' then begin // add by bayas
                        VariantRec.Get("No.", "Variant Code");
                        if VariantRec.Blocked1 = true then begin
                            ItemSearchDesc := Item.Description + ' - RAW';
                        end else
                            if VariantRec.Description <> '' then begin
                                ItemSearchDesc := VariantRec.Description;
                            end else begin
                                ItemSearchDesc := Item.Description;
                            end;

                        if VariantRec.CountryOfOrigin <> '' then begin
                            ItemOrginRec.Get(VariantRec.CountryOfOrigin);
                            Country_Region_Code := ItemOrginRec.Name;
                        end else begin
                            Country_Region_Code := ItemOrginRec.Name;
                        end;


                        if VariantRec."Packing Description" <> '' then begin
                            PackingDescription := VariantRec."Packing Description";
                        end else begin
                            PackingDescription := item."Description 2";
                        end;

                    end else begin
                        if Item."Sales Blocked" = true then begin
                            ItemSearchDesc := 'Raw Material';
                        end else begin
                            ItemSearchDesc := item.Description;
                        end;
                        PackingDescription := item."Description 2";
                        Country_Region_Code := ItemOrginRec.Name;
                    end;


                end;

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    ChangeCompany(Company.Name);

                    comp.Get();
                    if (FromDate <> 0D) and (ToDate <> 0D) then begin
                        SetFilter("Order Date", '%1..%2', FromDate, ToDate);
                    end;
                    if only_eta = true then begin
                        SetFilter(CustomR_ETD, '%1', 0D);
                        SetFilter(CustomETA, '<>%1&<%2', 0D, WorkDate());
                    end;
                    if Only_R_ETA = true then begin
                        SetFilter(CustomR_ETA, '<>%1', 0D);
                        SetFilter(CustomETA, '<%1', WorkDate());
                    end;
                    SetFilter("No.", ItemNo);

                end;

            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                PurchaseLine: Record "Purchase Line";
                RecShortName: Record "Company Short Name";//20MAY2022
            begin
                Company_short_Name.Get(Name);

                Clear(RecShortName);//20MAY2022
                RecShortName.SetRange(Name, Name);
                RecShortName.SetRange("Block in Reports", true);
                if RecShortName.FindFirst() then
                    CurrReport.Skip();

                // if "Purchase Line"."Document No." = '' then CurrReport.skip;
                PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                PurchaseLine.ChangeCompany(Name);
                if not PurchaseLine.FindSet() then CurrReport.skip;

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
                    ApplicationArea = all;
                    Caption = 'Item No.';
                    TableRelation = Item;
                }
                field(select_company; select_company)
                {
                    ApplicationArea = all;
                    Caption = 'Company Selection';
                    TableRelation = Company;
                }
                field(only_eta; only_eta)
                {
                    Caption = 'Show Only Elapsed ETA';
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                    begin
                        Only_R_ETA := false;
                    end;
                }
                field(Only_R_ETA; Only_R_ETA)
                {
                    Caption = 'Show Only Elapsed R-ETA';
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                    begin
                        only_eta := false;
                    end;
                }
                // field(Showintercompa; Showintercompa)
                // {
                //     Caption = 'Show Intercompany Purchase';
                //     ApplicationArea = all;
                // }
            }
        }
    }

    var
        Vendor: Record Vendor;
        item: Record 27;
        comp: Record "Company Information";
        only_eta: Boolean;
        Only_R_ETA: Boolean;
        datevar: Date;
        FromDate: Date;
        ToDate: date;
        Showintercompa: Boolean;
        Company_short_Name: Record "Company Short Name";
        ReceivedAmount: Decimal;
        select_company: Text;
        ItemNo: Code[20];
        SalesHeader: Record "Sales Header";
        SPRec: Record "Salesperson/Purchaser";
        ItemOrginRec: Record "Country/Region";
        PackingDescription: Text[100];
        ItemSearchDesc: Text[100];
        Country_Region_Code: Text[100];

}