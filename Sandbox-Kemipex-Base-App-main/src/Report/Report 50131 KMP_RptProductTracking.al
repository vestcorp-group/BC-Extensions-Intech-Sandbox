report 50131 KMP_RptProductTracking//T12370-Full Comment
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Product Tracking';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/KMP_RptProductTracking.rdl';
    dataset
    {
        dataitem(ItemLedgerEntry; "Item Ledger Entry")
        {
            column(Posting_Date; "Posting Date")
            { }
            column(Document_No_; "Document No.")
            { }
            column(Location_Code; LocationG.Code)
            { }
            column(Source_No_; AccountNameG)
            { }
            column(Item_No_; "Item No.")
            { }
            column(Description; ItemG.Description)
            { }
            column(SearchDescription; ItemG."Search Description")
            { }
            column(Unit_of_Measure_Code; "Unit of Measure Code")
            { }
            column(Quantity; Quantity)
            { }
            column(Rate_Received_at_; DirectUnitCostG)
            { }
            column(Cost_Amount__Actual_; "Cost Amount (Actual)")
            { }
            column(Remaining_Quantity_; "Remaining Quantity")
            { }
            column(Company_Name_; CompanyInfoG.Name)
            { }
            // column(Lot_No_; "Lot No.")
            // { }
            column(Lot_No_; CustomLotNumber)
            { }
            column(Entry_Type; "Entry Type")
            { }
            column(Net_Amount_; NetAmountG)
            { }
            column(Average_Rate_; ItemG."Unit Cost")
            { }
            column(Balance_Cost_; BalanceValueG)
            { }
            column(Reserved_Quantity; "Reserved Quantity")
            { }
            column(ReportNameG; ReportNameG)
            { }
            column(BOE_No_; BOENoG)
            { }
            column(CompanyAddr1Value; CompanyAddrG[2])
            { }
            column(CompanyAddr2Value; CompanyAddrG[3])
            { }

            column(BillOfExit; BillOfExit)
            { }
            column(CurrencyCode; CurrencyCodeG)
            { }

            column(FromDate; FromDateG)
            { }
            column(ToDate; ToDateG)
            { }

            trigger OnPreDataItem()
            begin
                IF (FromDateG = 0D) or (ToDateG = 0D) then
                    Error('Please enter the Posting date to filter');
                ReportNameG := StrSubstNo(ReportNameLbl, FromDateG, ToDateG);
                ItemLedgerEntry.SetRange("Posting Date", FromDateG, ToDateG);

                if LotNoG > '' then
                    ItemLedgerEntry.SetRange(CustomLotNumber, LotNoG);

                if BOENoG > '' then
                    ItemLedgerEntry.SetRange(CustomBOENumber2, BOENoG);

                if BillOfExitG > '' then
                    ItemLedgerEntry.SetRange(BillOfExit, BillOfExitG);
                if ItemNickNameG > '' then
                    ItemLedgerEntry.SetRange("Item No.", ItemNickNameG);
                if AccountNoG > '' then
                    ItemLedgerEntry.SetRange("Source No.", AccountNoG);
                if EntryTypeG > EntryTypeG::" " then
                    ItemLedgerEntry.SetRange("Entry Type", EntryTypeG - 1);
                CompanyInfoG.Get();
                FormatAddrG.Company(CompanyAddrG, CompanyInfoG);
            end;

            trigger OnAfterGetRecord()
            var
                CustomerL: Record Customer;
                PurchRcptLineL: Record "Purch. Rcpt. Line";
                SalesShipmentLineL: Record "Sales Shipment Line";
                TransferShipmentL: Record "Transfer Shipment Line";
                TransferReceiptL: Record "Transfer Receipt Line";
                CurrencyExcRateL: Record "Currency Exchange Rate";
                GLSetupL: Record "General Ledger Setup";

            begin
                if LocationCodeG > '' then
                    if "Location Code" <> LocationCodeG then
                        CurrReport.Skip();

                DirectUnitCostG := 0;
                ItemG.Get("Item No.");

                GLSetupL.Get();
                Clear(CurrencyCodeG);
                if "Location Code" > '' then
                    LocationG.Get("Location Code");
                Clear(AccountNameG);
                Clear(BOENoG);
                case "Source Type" of
                    "Source Type"::Vendor:
                        begin
                            VendorG.Get("Source No.");
                            AccountNameG := VendorG.Name + ' ' + VendorG."Name 2";
                        end;
                    "Source Type"::Customer:
                        begin
                            CustomerL.get("Source No.");
                            AccountNameG := CustomerL.Name + ' ' + CustomerL."Name 2";
                        end;
                end;
                // DirectUnitCostG := ItemG.CalcUnitPriceExclVAT();
                BOENoG := CustomBOENumber;
                case "Entry Type" of
                    "Entry Type"::Sale:
                        begin
                            case "Document Type" of
                                "Document Type"::"Sales Shipment":
                                    begin
                                        SalesShipmentLineL.get("Document No.", "Document Line No.");
                                        DirectUnitCostG := SalesShipmentLineL."Unit Price";
                                        SalesShipmentLineL.CalcFields("Currency Code");
                                        CurrencyCodeG := SalesShipmentLineL."Currency Code";
                                    end;
                            end;
                        end;
                    "Entry Type"::Purchase:
                        begin
                            case "Document Type" of
                                "Document Type"::"Purchase Receipt":
                                    begin
                                        PurchRcptLineL.get("Document No.", "Document Line No.");
                                        DirectUnitCostG := PurchRcptLineL."Direct Unit Cost";
                                        PurchRcptLineL.CalcFields("Currency Code");
                                        CurrencyCodeG := PurchRcptLineL."Currency Code";
                                    end;
                            end;
                        end;
                    "Entry Type"::"Positive Adjmt.", "Entry Type"::"Negative Adjmt.":
                        begin
                            CalcFields("Cost Amount (Actual)");
                            DirectUnitCostG := abs("Cost Amount (Actual)" / Quantity);
                        end;

                end;
                NetAmountG := Quantity * DirectUnitCostG;

                if CurrencyCodeG > '' then
                    NetAmountG := CurrencyExcRateL.ExchangeAmtFCYToFCY(ItemLedgerEntry."Posting Date", CurrencyCodeG, GLSetupL."LCY Code", NetAmountG)
                else
                    CurrencyCodeG := GLSetupL."LCY Code";
                BalanceValueG := "Remaining Quantity" * ItemG."Unit Cost";

            end;
        }


    }


    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filters)
                {
                    field("From Date"; FromDateG)
                    {
                        ApplicationArea = All;
                    }
                    field("To Date"; ToDateG)
                    {
                        ApplicationArea = All;
                    }
                    field("Entry Type"; EntryTypeG)
                    {
                        ApplicationArea = all;
                    }

                    field("Lot No."; LotNoG)
                    {
                        ApplicationArea = All;
                    }
                    field("BOE No."; BOENoG)
                    {
                        ApplicationArea = All;
                    }

                    field("Bill Of Exit"; BillOfExitG)
                    {
                        ApplicationArea = All;
                    }

                    field("Warehouse"; LocationCodeG)
                    {
                        ApplicationArea = All;
                        TableRelation = Location;
                    }
                    field("Account Type"; AccountTypeG)
                    {
                        ApplicationArea = all;
                    }

                    field("Account Name"; AccountNoG)
                    {
                        ApplicationArea = All;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            CustomerL: Record Customer;
                            VendorL: Record Vendor;
                            CustomerLookupL: Page "Customer Lookup";
                            VendorLookupL: page "Vendor Lookup";
                        begin
                            if AccountTypeG = AccountTypeG::Customer then begin
                                CustomerLookupL.LookupMode(true);
                                CustomerLookupL.SetRecord(CustomerL);
                                if CustomerLookupL.RunModal() = Action::LookupOK then begin
                                    CustomerLookupL.SetSelectionFilter(CustomerL);
                                    CustomerL.FindFirst();
                                    AccountNoG := CustomerL."No.";
                                end;
                            end else
                                if AccountTypeG = AccountTypeG::Vendor then begin
                                    VendorLookupL.LookupMode(true);
                                    VendorLookupL.SetRecord(VendorL);
                                    if VendorLookupL.RunModal() = Action::LookupOK then begin
                                        VendorLookupL.SetSelectionFilter(VendorL);
                                        VendorL.FindFirst();
                                        AccountNoG := VendorL."No.";
                                    end;
                                end;


                        end;

                    }
                    field("Item Nick Name"; ItemNickNameG)
                    {
                        ApplicationArea = All;
                        TableRelation = Item;
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnInitReport()
    var
        myInt: Integer;
    begin
        EntryTypeG := EntryTypeG::" ";
    end;

    var
        CompanyInfoG: Record "Company Information";
        LocationG: Record Location;
        VendorG: Record Vendor;
        FromDateG: Date;
        ToDateG: Date;
        ItemG: Record Item;
        DirectUnitCostG: Decimal;
        NetAmountG: Decimal;
        BalanceValueG: Decimal;
        ReportNameLbl: Label 'Stock Ledger %1 to %2';
        ReportNameG: Text;
        AccountNameG: Text;
        LotNoG: Code[50];
        BOENoG: Text;
        BillOfExitG: Text;
        LocationCodeG: Text;

        ItemNickNameG: Text;
        CompanyInfo: Record 79;
        CompanyAddrG: array[8] of Text[100];
        FormatAddrG: Codeunit "Format Address";
        EntryTypeG: Option " ",Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output,,"Assembly Consumption","Assembly Output";

        AccountTypeG: Option " ",Customer,Vendor;
        CurrencyCodeG: Code[20];
        AccountNoG: Code[20];

}