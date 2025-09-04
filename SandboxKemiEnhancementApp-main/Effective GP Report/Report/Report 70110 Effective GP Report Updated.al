// report 70110 "Effective GP Report Updated"//T12370-Full Comment
// {
//     UsageCategory = Administration;
//     ApplicationArea = All;
//     DefaultLayout = RDLC;
//     RDLCLayout = 'Effective GP Report\EffectiveGPReportUpdated.rdl';
//     dataset
//     {
//         dataitem(Companies; Company)
//         {
//             DataItemTableView = sorting(Name);
//             PrintOnlyIfDetail = TRUE;
//             column(Name; CompanyInformation."Custom System Indicator Text") { }
//             column(ExcludeCharges; ExcludeCharges) { }
//             column(FromDate; FromDate) { }
//             column(ToDate; ToDate) { }
//             column(ReportFilter; DatesExist) { }
//             column(FromDateFilter; FromDateFilter) { }
//             column(ToDateFilter; ToDateFilter) { }
//             dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
//             {
//                 DataItemTableView = sorting("Posting Date");
//                 dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
//                 {
//                     DataItemLinkReference = "Sales Cr.Memo Header";
//                     DataItemTableView = where("No." = FILTER(<> ''));
//                     DataItemLink = "Document No." = field("No.");
//                     column(CSrNo; CSrNo) { }
//                     column(CPOL1; EntryExitPoint.Description) { }
//                     column(CPOd; Areas.Text) { }
//                     column(CrMemoDate; SOOrderDate) { }
//                     column(CTransactionSpecification; "Transaction Specification") { }
//                     column(CRowColour; RowColour) { }
//                     column(CSONo; SONo) { }
//                     column(CSalesPersonName; SalesPerson.Name) { }
//                     column(CTeams; Teams."Team Name") { }
//                     column(CSIDate; "Sales Cr.Memo Header"."Posting Date") { }
//                     column(CSINo; "Sales Cr.Memo Header"."No.") { }
//                     column(CCustomerNo; Customer."No.") { }
//                     column(CCustShortName; CustomerShortName) { }
//                     column(CCustCountry; Customer."Country/Region Code") { }
//                     column(CItemNo; "No.") { }
//                     column(CItemMarketIndustry; KMP_TblMarketIndustry.Description) { }
//                     column(CItemShortName; Item."Search Description") { }
//                     column(CItemCategory; ItemCategory.Description) { }
//                     column(CBaseUOM; "Base UOM 2") { } //PackingListExtChange
//                     column(CQuanity; Qty) { }
//                     column(CCurrency; CurrencyCode) { }
//                     column(CBaseUOMPrice; "Unit Price Base UOM 2") { } //PackingListExtChanges
//                     column(CTotalAmount; TotalAmount) { }
//                     column(CCOGSLCY; COGSLCY) { }
//                     column(COtherRevenues; OtherRevenues) { }
//                     column(CTotalAmountLCY; TotalAmountLCY) { }
//                     column(CEXPCDT; EXPCDT) { }
//                     column(CEXPCOO; EXPCOO) { }
//                     column(CEXPFRT; EXPFRT) { }
//                     column(CEXPINPC; EXPINPC) { }
//                     column(CEXPINS; EXPINS) { }
//                     column(CEXPLEGAL; EXPLEGAL) { }
//                     column(CEXPOthers; EXPOthers) { }
//                     column(CEXPSERV; EXPSERV) { }
//                     column(CEXPTHC; EXPTHC) { }
//                     column(CEXPTRC; EXPTRC) { }
//                     column(CEXPWHHNDL; EXPWHHNDL) { }
//                     column(CEXPWHPACK; EXPWHPACK) { }
//                     column(CRebateToCustomer; RebateToCustomer) { }
//                     column(CDemurrageToCustomer; DemurrageToCustomer) { }
//                     column(COtherCharges; OtherCharges) { }
//                     column(COtherPaymentCharges; OtherPaymentCharges) { }
//                     column(CTotalDiscountAmount; TotalDiscountAmount) { }
//                     column(CTotalSalesExpensesLCY; TotalSalesExpensesLCY) { }
//                     column(CCOSLCY; -ABS((COSLCY))) { }
//                     column(CEffectiveGPLCY; EffectiveGPLCY - abs(OtherPaymentChargesLCY)) { }

//                     TRIGGER OnPreDataItem()
//                     BEGIN
//                         "Sales Cr.Memo Line".ChangeCompany(Companies.Name);
//                         IF ItemCategoryFilter <> '' THEN
//                             "Sales Cr.Memo Line".SETRANGE("Item Category Code", ItemCategoryFilter);
//                         IF ItemFilter <> '' THEN
//                             "Sales Cr.Memo Line".SETRANGE("No.", ItemFilter);
//                     END;

//                     TRIGGER OnAfterGetRecord()
//                     BEGIN
//                         CLEAR(Customer);
//                         CLEAR(SalesPerson);
//                         CLEAR(Item);
//                         CLEAR(SalesShipmentHeader);
//                         CLEAR(GeneralLedgerSetup);
//                         CLEAR(ValueEntry);
//                         CLEAR(ValueEntry2);
//                         CLEAR(UnitOfMeasure);
//                         CLEAR(ItemCategory);
//                         Clear(EntryExitPoint);
//                         Clear(Areas);
//                         Clear(Teams);
//                         Clear(KMP_TblMarketIndustry);

//                         Customer.ChangeCompany(Companies.Name);
//                         Customer_Rec.ChangeCompany(Companies.Name);
//                         Teams.ChangeCompany(Companies.Name);
//                         SalesPerson.ChangeCompany(Companies.Name);
//                         Item.ChangeCompany(Companies.Name);
//                         SalesShipmentHeader.ChangeCompany(Companies.Name);
//                         KMP_TblMarketIndustry.ChangeCompany(Companies.Name);

//                         GeneralLedgerSetup.ChangeCompany(Companies.Name);
//                         ValueEntry.ChangeCompany(Companies.Name);
//                         ValueEntry2.ChangeCompany(Companies.Name);
//                         UnitOfMeasure.ChangeCompany(Companies.Name);
//                         ItemCategory.ChangeCompany(Companies.Name);
//                         EntryExitPoint.ChangeCompany(Companies.Name);
//                         Areas.ChangeCompany(Companies.Name);

//                         if EntryExitPoint.Get("Sales Cr.Memo Header"."Exit Point") then;

//                         Customer.SetRange("No.", "Sales Cr.Memo Header"."Sell-to Customer No.");
//                         if Customer.FindFirst() then;

//                         if Customer_Rec.GET("Sales Cr.Memo Header"."Sell-to Customer No.") then begin
//                             if Customer_Rec.AltCustomerName <> '' then
//                                 CustomerShortName := Customer_Rec.AltCustomerName
//                             else
//                                 CustomerShortName := Customer_Rec."Search Name";
//                         end;
//                         IF SalesPerson.GET("Sales Cr.Memo Header"."Salesperson Code") THEN;

//                         IF Item.GET("Sales Cr.Memo Line"."No.") THEN;

//                         IF Item."Inventory Posting Group" = 'SAMPLE' THEN
//                             CurrReport.Skip();

//                         IF ItemCategory.GET("Sales Cr.Memo Line"."Item Category Code") THEN;

//                         Teams.Setrange("Salesperson Code", "Sales Cr.Memo Header"."Salesperson Code");
//                         if Teams.FindFirst() then
//                             Teams.CalcFields(teams."Team Name");

//                         if KMP_TblMarketIndustry.get(Item.MarketIndustry) then;



//                         CLEAR(SONo);
//                         CLEAR(SOOrderDate);


//                         CSrNo += 1;
//                         RowColour := NOT RowColour;

//                         CLEAR(Qty);
//                         IF UnitOfMeasure.GET("Sales Cr.Memo Line"."Base UOM 2") THEN BEGIN //PackingListExtChange
//                             IF UnitOfMeasure."Decimal Allowed" THEN
//                                 Qty := FORMAT("Sales Cr.Memo Line"."Quantity (Base)", 0, '<Precision,3:2><Standard Format,2>')
//                             ELSE
//                                 Qty := FORMAT("Sales Cr.Memo Line"."Quantity (Base)", 0, '<Precision,0><Standard Format,2>');
//                         END
//                         ELSE BEGIN
//                             Qty := FORMAT("Sales Cr.Memo Line"."Quantity (Base)", 0, '<Precision,3:2><Standard Format,2>');
//                         END;


//                         GeneralLedgerSetup.GET;
//                         CLEAR(CurrencyCode);
//                         IF "Sales Cr.Memo Header"."Currency Code" <> '' THEN
//                             CurrencyCode := "Sales Cr.Memo Header"."Currency Code"
//                         ELSE
//                             CurrencyCode := GeneralLedgerSetup."LCY Code";

//                         CLEAR(TotalAmount);
//                         TotalAmount := "Sales Cr.Memo Line"."Quantity (Base)" * "Sales Cr.Memo Line"."Unit Price Base UOM 2"; //PackingListExtChange

//                         CLEAR(RebateToCustomer);
//                         CLEAR(DemurrageToCustomer);
//                         CLEAR(COGSLCY);
//                         //Other Charges
//                         CLEAR(OtherPaymentCharges);
//                         Clear(OtherPaymentChargesLCY);

//                         CLEAR(CurrentLineAmount);
//                         CLEAR(TotalSalesInvoiceLineAmount);
//                         CLEAR(TotalDiscountAmount);
//                         CLEAR(SalesCrMemoLine);

//                         SalesCrMemoLine.ChangeCompany(Companies.Name);
//                         SalesCrMemoLine.RESET;
//                         SalesCrMemoLine.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
//                         SalesCrMemoLine.SETRANGE(Type, SalesCrMemoLine.Type::"G/L Account");
//                         IF SalesCrMemoLine.FINDFIRST THEN
//                             REPEAT
//                                 GeneralLedgerSetup.ChangeCompany(Companies.Name);
//                                 GeneralLedgerSetup.RESET;
//                                 GeneralLedgerSetup.SETFILTER("GP G/L Accounts", '@*' + SalesCrMemoLine."No." + '*');
//                                 IF GeneralLedgerSetup.FINDFIRST THEN BEGIN
//                                     TotalDiscountAmount += SalesCrMemoLine."Quantity (Base)" * SalesCrMemoLine."Unit Price Base UOM 2";  //PackingListExtChange
//                                 END;
//                             UNTIL SalesCrMemoLine.NEXT = 0;
//                         IF TotalDiscountAmount <> 0 THEN BEGIN
//                             SalesCrMemoLine.RESET;
//                             SalesCrMemoLine.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
//                             SalesCrMemoLine.SETRANGE(Type, SalesCrMemoLine.Type::Item);
//                             IF SalesCrMemoLine.FINDFIRST THEN
//                                 REPEAT
//                                     TotalSalesInvoiceLineAmount += SalesCrMemoLine."Quantity (Base)" * SalesCrMemoLine."Unit Price Base UOM 2"; //PackingListExtChange
//                                 UNTIL SalesInvoiceLine.NEXT = 0;
//                             CurrentLineAmount := "Sales Cr.Memo Line"."Quantity (Base)" * "Sales Cr.Memo Line"."Unit Price Base UOM 2"; //PackingListExtChange

//                             IF TotalSalesInvoiceLineAmount <> 0 THEN
//                                 OtherPaymentCharges := (CurrentLineAmount / TotalSalesInvoiceLineAmount) * TotalDiscountAmount;

//                             if CurrencyCode <> '' then
//                                 OtherPaymentChargesLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Sales Cr.Memo Header"."Posting Date", CurrencyCode, OtherPaymentCharges, "Sales Cr.Memo Header"."Currency Factor"))
//                             else
//                                 OtherPaymentCharges := ROUND(OtherPaymentCharges);
//                         END;
//                         CLEAR(TotalAmountLCY);

//                         CLEAR(COGSLCY);
//                         Clear(COSLCY);
//                         Clear(EffectiveGPLCY);

//                         //Purchase Charges
//                         CLEAR(EXPFRT);
//                         CLEAR(EXPCDT);
//                         CLEAR(EXPINS);
//                         CLEAR(EXPTRC);
//                         CLEAR(EXPTHC);
//                         CLEAR(EXPSERV);
//                         CLEAR(EXPOthers);
//                         CLEAR(OtherCharges);
//                         CLEAR(EXPWHHNDL);
//                         CLEAR(EXPINPC);
//                         CLEAR(EXPWHPACK);
//                         CLEAR(EXPCOO);
//                         CLEAR(EXPLEGAL);
//                         CLEAR(RebateToCustomer);
//                         CLEAR(DemurrageToCustomer);
//                         CLEAR(TotalSalesExpensesLCY);

//                         ValueEntry.RESET;
//                         ValueEntry.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
//                         ValueEntry.SETRANGE("Document Line No.", "Sales Cr.Memo Line"."Line No.");
//                         ValueEntry.SETRANGE("Item No.", "Sales Cr.Memo Line"."No.");
//                         ValueEntry.SETRANGE(Adjustment, FALSE);
//                         IF ValueEntry.FINDFIRST THEN BEGIN
//                             REPEAT
//                                 ValueEntry2.RESET;
//                                 ValueEntry2.SETRANGE("Item Ledger Entry No.", ValueEntry."Item Ledger Entry No.");
//                                 ValueEntry2.SETFILTER("Item Charge No.", '<>%1', '');
//                                 ValueEntry2.SETRANGE("Item No.", ValueEntry."Item No.");
//                                 ValueEntry2.SETFILTER("Item Ledger Entry Type", '<>%1', ValueEntry2."Item Ledger Entry Type"::Sale);
//                                 IF ValueEntry2.FINDFIRST THEN
//                                     REPEAT
//                                         IF ValueEntry2."Item Charge No." = '01' THEN
//                                             EXPFRT += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                         ELSE
//                                             IF ValueEntry2."Item Charge No." = '02' THEN
//                                                 EXPCDT += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                             ELSE
//                                                 IF ValueEntry2."Item Charge No." = '03' THEN
//                                                     EXPINS += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                 ELSE
//                                                     IF ValueEntry2."Item Charge No." = '04' THEN
//                                                         EXPTRC += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                     ELSE
//                                                         IF ValueEntry2."Item Charge No." = '05' THEN
//                                                             EXPTHC += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                         ELSE
//                                                             IF ValueEntry2."Item Charge No." = '06' THEN
//                                                                 EXPSERV += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                             ELSE
//                                                                 IF ValueEntry2."Item Charge No." = '07' THEN
//                                                                     EXPOthers += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                 ELSE
//                                                                     IF ValueEntry2."Item Charge No." = '09' THEN
//                                                                         EXPWHHNDL += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                     ELSE
//                                                                         IF ValueEntry2."Item Charge No." = '10' THEN
//                                                                             EXPINPC += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                         ELSE
//                                                                             IF ValueEntry2."Item Charge No." = '21' THEN
//                                                                                 EXPWHPACK += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                             ELSE
//                                                                                 IF ValueEntry2."Item Charge No." = '24' THEN
//                                                                                     EXPCOO += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                                 ELSE
//                                                                                     IF ValueEntry2."Item Charge No." = '26' THEN
//                                                                                         EXPLEGAL += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                                     ELSE
//                                                                                         IF ValueEntry2."Item Charge No." = '32' THEN
//                                                                                             RebateToCustomer += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                                         ELSE
//                                                                                             IF ValueEntry2."Item Charge No." = '33' THEN
//                                                                                                 DemurrageToCustomer += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                                             ELSE
//                                                                                                 OtherCharges += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1;
//                                     UNTIL ValueEntry2.NEXT = 0;
//                             UNTIL ValueEntry.NEXT = 0;
//                         END;

//                         ValueEntry.RESET;
//                         ValueEntry.SETRANGE("Document No.", "Sales Cr.Memo Line"."Document No.");
//                         ValueEntry.SETRANGE("Document Line No.", "Sales Cr.Memo Line"."Line No.");
//                         ValueEntry.SetRange("Item No.", "Sales Cr.Memo Line"."No.");//dn
//                         IF ValueEntry.FINDFIRST THEN
//                             REPEAT
//                                 COGSLCY += (ValueEntry."Cost Amount (Actual)" * -1);
//                             UNTIL ValueEntry.NEXT = 0;



//                         if "Sales Cr.Memo Header"."Currency Factor" <> 0 then
//                             TotalAmountLCY := TotalAmount * (1 / "Sales Cr.Memo Header"."Currency Factor")
//                         else
//                             TotalAmountLCY := TotalAmount;

//                         //TotalExpenses

//                         TotalSalesExpensesLCY := EXPCDT + EXPCOO + EXPFRT + EXPINPC + EXPINS + EXPLEGAL + EXPOthers + EXPSERV + EXPTHC + EXPTRC + EXPWHHNDL + EXPWHPACK + RebateToCustomer + DemurrageToCustomer + OtherCharges;
//                         //TotalExpenses
//                         //COSLCY

//                         COSLCY := COGSLCY + ABS(TotalSalesExpensesLCY);
//                         CLEAR(EffectiveGPLCY);
//                         EffectiveGPLCY := TotalAmountLCY - ABS(COSLCY);

//                     END;
//                 }
//                 trigger OnPreDataItem()
//                 begin
//                     "Sales Cr.Memo Header".ChangeCompany(Companies.Name);

//                     IF (FromDate <> 0D) AND (ToDate <> 0D) THEN
//                         "Sales Cr.Memo Header".SETRANGE("Posting Date", FromDate, ToDate);
//                     IF CustomerFilter <> '' THEN
//                         "Sales Cr.Memo Header".SETRANGE("Sell-to Customer No.", CustomerFilter);
//                 end;

//                 trigger OnAfterGetRecord()
//                 begin

//                     CLEAR(ICPartners);
//                     ICPartners.ChangeCompany(Companies.Name);
//                     ICPartners.RESET;
//                     ICPartners.SETRANGE("Customer No.", "Sales Cr.Memo Header"."Sell-to Customer No.");
//                     IF ICPartners.FINDFIRST THEN
//                         CurrReport.Skip();
//                 end;
//             }
//             dataitem("Sales Invoice Header"; "Sales Invoice Header")
//             {
//                 DataItemTableView = sorting("Posting Date");

//                 dataitem("Sales Invoice Line"; "Sales Invoice Line")
//                 {
//                     DataItemLinkReference = "Sales Invoice Header";
//                     DataItemTableView = where(Type = filter(Item));
//                     DataItemLink = "Document No." = field("No.");
//                     column(SrNo; SrNo) { }
//                     column(POL; EntryExitPoint.Description) { }
//                     column(Teams; Teams."Team Name") { }
//                     column("POD"; Areas.Text) { }
//                     column(SOOrderDate; SOOrderDate) { }
//                     column(Transaction_Specification; "Transaction Specification") { }
//                     column(RowColour; RowColour) { }
//                     column(SONo; SONo) { }
//                     column(SalesPersonName; SalesPerson.Name) { }
//                     column(Location_Code; "Location Code") { }
//                     column(SIDate; "Sales Invoice Header"."Posting Date") { }
//                     column(SINo; "Sales Invoice Header"."No.") { }
//                     column(CustomerNo; Customer."No.") { }
//                     column(CustomerHide; Customer."Hide in Reports") { }
//                     column(CustShortName; CustomerShortName) { }
//                     column(CustCountry; Customer."Country/Region Code") { }
//                     column(ItemNo; "No.") { }
//                     column(ItemMarketIndustry; KMP_TblMarketIndustry.Description) { }
//                     column(ItemShortName; Item."Search Description") { }
//                     column(ItemCategory; ItemCategory.Description) { }
//                     column(BaseUOM; "Base UOM 2") { } //PackingListExtChange
//                     column(Quanity; Qty) { }
//                     column(Currency; CurrencyCode) { }
//                     column(BaseUOMPrice; "Unit Price Base UOM 2") { } //PackingListExtChanges
//                     column(TotalAmount; TotalAmount - ABS(OtherPaymentCharges)) { }
//                     column(COGSLCY; COGSLCY) { }
//                     column(OtherRevenues; OtherRevenues) { }
//                     column(TotalAmountLCY; TotalAmountLCY - ABS(OtherPaymentChargesLCY)) { }
//                     column(EXPCDT; EXPCDT) { }
//                     column(EXPCOO; EXPCOO) { }
//                     column(EXPFRT; EXPFRT) { }
//                     column(EXPINPC; EXPINPC) { }
//                     column(EXPINS; EXPINS) { }
//                     column(EXPLEGAL; EXPLEGAL) { }
//                     column(EXPOthers; EXPOthers) { }
//                     column(EXPSERV; EXPSERV) { }
//                     column(EXPTHC; EXPTHC) { }
//                     column(EXPTRC; EXPTRC) { }
//                     column(EXPWHHNDL; EXPWHHNDL) { }
//                     column(EXPWHPACK; EXPWHPACK) { }
//                     column(RebateToCustomer; RebateToCustomer) { }
//                     column(DemurrageToCustomer; DemurrageToCustomer) { }
//                     column(OtherCharges; OtherCharges) { }
//                     column(OtherPaymentCharges; OtherPaymentCharges) { }
//                     column(TotalDiscountAmount; TotalDiscountAmount) { }
//                     column(TotalSalesExpensesLCY; TotalSalesExpensesLCY) { }
//                     column(COSLCY; COSLCY) { }
//                     column(EffectiveGPLCY; EffectiveGPLCY - abs(OtherPaymentChargesLCY)) { }

//                     TRIGGER OnPreDataItem()
//                     BEGIN
//                         "Sales Invoice Line".ChangeCompany(Companies.Name);
//                         IF ItemCategoryFilter <> '' THEN
//                             "Sales Invoice Line".SETRANGE("Item Category Code", ItemCategoryFilter);
//                         IF ItemFilter <> '' THEN
//                             "Sales Invoice Line".SETRANGE("No.", ItemFilter);
//                     END;

//                     TRIGGER OnAfterGetRecord()
//                     BEGIN
//                         CLEAR(Customer);
//                         CLEAR(SalesPerson);
//                         CLEAR(Item);
//                         CLEAR(SalesShipmentHeader);

//                         CLEAR(GeneralLedgerSetup);
//                         CLEAR(ValueEntry);
//                         CLEAR(ValueEntry2);
//                         CLEAR(UnitOfMeasure);
//                         CLEAR(ItemCategory);
//                         Clear(EntryExitPoint);
//                         Clear(Areas);
//                         Clear(Teams);
//                         clear(KMP_TblMarketIndustry);

//                         Customer.ChangeCompany(Companies.Name);
//                         Customer_Rec.ChangeCompany(Companies.Name);
//                         Teams.ChangeCompany(Companies.Name);
//                         SalesPerson.ChangeCompany(Companies.Name);
//                         Item.ChangeCompany(Companies.Name);
//                         SalesShipmentHeader.ChangeCompany(Companies.Name);
//                         KMP_TblMarketIndustry.ChangeCompany(Companies.Name);

//                         GeneralLedgerSetup.ChangeCompany(Companies.Name);
//                         ValueEntry.ChangeCompany(Companies.Name);
//                         ValueEntry2.ChangeCompany(Companies.Name);
//                         UnitOfMeasure.ChangeCompany(Companies.Name);
//                         ItemCategory.ChangeCompany(Companies.Name);
//                         EntryExitPoint.ChangeCompany(Companies.Name);
//                         Areas.ChangeCompany(Companies.Name);

//                         if EntryExitPoint.Get("Sales Invoice Header"."Exit Point") then;

//                         Customer.SetRange("No.", "Sales Invoice Header"."Sell-to Customer No.");
//                         //Customer.SetRange("Hide in Reports ", false);
//                         if Customer.FindFirst() then
//                             if Customer."Hide in Reports" then
//                                 CurrReport.Skip();

//                         //IF Customer.GET("Sales Invoice Header"."Sell-to Customer No.") THEN;

//                         if Customer_Rec.GET("Sales Invoice Header"."Sell-to Customer No.") then begin
//                             if Customer_Rec.AltCustomerName <> '' then
//                                 CustomerShortName := Customer_Rec.AltCustomerName
//                             else
//                                 CustomerShortName := Customer_Rec."Search Name";
//                         end;
//                         IF SalesPerson.GET("Sales Invoice Header"."Salesperson Code") THEN;
//                         IF Item.GET("Sales Invoice Line"."No.") THEN;
//                         IF Item."Inventory Posting Group" = 'SAMPLE' THEN
//                             CurrReport.Skip();

//                         IF ItemCategory.GET("Sales Invoice Line"."Item Category Code") THEN;

//                         Teams.Setrange("Salesperson Code", "Sales Invoice Header"."Salesperson Code");
//                         if Teams.FindFirst() then
//                             Teams.CalcFields(teams."Team Name");



//                         if KMP_TblMarketIndustry.get(Item.MarketIndustry) then;

//                         If Areas.Get("Area") then;

//                         CLEAR(SONo);
//                         CLEAR(SOOrderDate);

//                         ValueEntry.RESET;
//                         ValueEntry.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
//                         ValueEntry.SETRANGE("Document Line No.", "Sales Invoice Line"."Line No.");
//                         ValueEntry.SETRANGE("Item No.", "Sales Invoice Line"."No.");
//                         ValueEntry.SETRANGE(Adjustment, FALSE);
//                         IF ValueEntry.FINDFIRST THEN BEGIN
//                             CLEAR(ILE);
//                             ILE.RESET;
//                             ILE.ChangeCompany(Companies.Name);
//                             ILE.SETRANGE("Entry No.", ValueEntry."Item Ledger Entry No.");
//                             IF ILE.FINDFIRST THEN BEGIN
//                                 SalesShipmentHeader.RESET;
//                                 SalesShipmentHeader.SETRANGE("No.", ILE."Document No.");
//                                 IF SalesShipmentHeader.FINDFIRST THEN BEGIN
//                                     SONo := SalesShipmentHeader."Order No.";
//                                     SalesHeaderArchieve.ChangeCompany(Companies.Name);
//                                     SalesHeaderArchieve.RESET;
//                                     SalesHeaderArchieve.SETRANGE("No.", SalesShipmentHeader."Order No.");
//                                     IF SalesHeaderArchieve.FindFirst() THEN
//                                         SOOrderDate := SalesHeaderArchieve."Order Date";
//                                     IF SOOrderDate = 0D THEN BEGIN
//                                         SalesHeader.ChangeCompany(Companies.Name);
//                                         SalesHeader.RESET;
//                                         SalesHeader.SETRANGE("No.", SalesShipmentHeader."Order No.");
//                                         IF SalesHeader.FindFirst() THEN
//                                             SOOrderDate := SalesHeader."Order Date";
//                                     END;
//                                 END;
//                             END;
//                         END;

//                         CLEAR(ChargesFound);
//                         CLEAR(ICChargesFound);

//                         IF ChargeItemFilter <> '' THEN BEGIN
//                             ValueEntry.RESET;
//                             ValueEntry.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
//                             ValueEntry.SETRANGE("Document Line No.", "Sales Invoice Line"."Line No.");
//                             ValueEntry.SETRANGE("Item No.", "Sales Invoice Line"."No.");
//                             ValueEntry.SETRANGE(Adjustment, FALSE);
//                             IF ValueEntry.FINDFIRST THEN BEGIN
//                                 ValueEntry2.RESET;
//                                 ValueEntry2.SETRANGE("Item Ledger Entry No.", ValueEntry."Item Ledger Entry No.");
//                                 ValueEntry2.SETFILTER("Item Charge No.", '<>%1', '');
//                                 ValueEntry2.SETRANGE("Item No.", ValueEntry."Item No.");
//                                 ValueEntry2.SETFILTER("Item Ledger Entry Type", '<>%1', ValueEntry2."Item Ledger Entry Type"::Sale);
//                                 ValueEntry2.SETRANGE("Item Charge No.", ChargeItemFilter);
//                                 IF ValueEntry2.FINDFIRST THEN
//                                     ChargesFound := TRUE;
//                             END;

//                             IF SONo <> '' THEN BEGIN
//                                 ICCompanyList.RESET;
//                                 IF ICCompanyList.FindFirst() THEN
//                                     REPEAT
//                                         CLEAR(ICSalesOrderInvoiceLines);
//                                         ICSalesOrderInvoiceLines.ChangeCompany(ICCompanyList.Name);
//                                         ICSalesOrderInvoiceLines.RESET;
//                                         ICSalesOrderInvoiceLines.SETRANGE("IC Related SO", SONo);
//                                         ICSalesOrderInvoiceLines.SETRANGE("No.", "Sales Invoice Line"."No.");
//                                         IF ICSalesOrderInvoiceLines.FindFirst() THEN BEGIN
//                                             REPEAT
//                                                 ICValueEntry.ChangeCompany(ICCompanyList.Name);
//                                                 ICValueEntry.RESET;
//                                                 ICValueEntry.SETRANGE("Document No.", ICSalesOrderInvoiceLines."Document No.");
//                                                 ICValueEntry.SETRANGE("Document Line No.", ICSalesOrderInvoiceLines."Line No.");
//                                                 ICValueEntry.SETRANGE("Item No.", ICSalesOrderInvoiceLines."No.");
//                                                 ICValueEntry.SETRANGE(Adjustment, FALSE);
//                                                 IF ICValueEntry.FINDFIRST THEN BEGIN
//                                                     REPEAT
//                                                         ICValueEntry2.ChangeCompany(ICCompanyList.Name);
//                                                         ICValueEntry2.RESET;
//                                                         ICValueEntry2.SETRANGE("Item Ledger Entry No.", ICValueEntry."Item Ledger Entry No.");
//                                                         ICValueEntry2.SETFILTER("Item Charge No.", '<>%1', '');
//                                                         ICValueEntry2.SETRANGE("Item No.", ICValueEntry."Item No.");
//                                                         ICValueEntry2.SETFILTER("Item Ledger Entry Type", '<>%1', ICValueEntry2."Item Ledger Entry Type"::Sale);
//                                                         ICValueEntry2.SETRANGE("Item Charge No.", ChargeItemFilter);
//                                                         IF ICValueEntry2.FINDFIRST THEN
//                                                             ICChargesFound := TRUE;
//                                                     UNTIL ICCompanyList.NEXT = 0;
//                                                 END;
//                                             UNTIL ICSalesOrderInvoiceLines.NEXT = 0;
//                                         END;
//                                     UNTIL ICCompanyList.NEXT = 0;
//                             END;
//                         END;
//                         IF ChargeItemFilter <> '' THEN
//                             IF NOT (ChargesFound OR ICChargesFound) THEN
//                                 CurrReport.SKIP;

//                         SrNo += 1;
//                         RowColour := NOT RowColour;

//                         CLEAR(Qty);
//                         IF UnitOfMeasure.GET("Sales Invoice Line"."Base UOM 2") THEN BEGIN //PackingListExtChange
//                             IF UnitOfMeasure."Decimal Allowed" THEN
//                                 Qty := FORMAT("Sales Invoice Line"."Quantity (Base)", 0, '<Precision,3:2><Standard Format,2>')
//                             ELSE
//                                 Qty := FORMAT("Sales Invoice Line"."Quantity (Base)", 0, '<Precision,0><Standard Format,2>');
//                         END
//                         ELSE BEGIN
//                             Qty := FORMAT("Sales Invoice Line"."Quantity (Base)", 0, '<Precision,3:2><Standard Format,2>');
//                         END;


//                         GeneralLedgerSetup.GET;
//                         CLEAR(CurrencyCode);
//                         IF "Sales Invoice Header"."Currency Code" <> '' THEN
//                             CurrencyCode := "Sales Invoice Header"."Currency Code"
//                         ELSE
//                             CurrencyCode := GeneralLedgerSetup."LCY Code";

//                         CLEAR(TotalAmount);
//                         TotalAmount := "Sales Invoice Line"."Quantity (Base)" * "Sales Invoice Line"."Unit Price Base UOM 2"; //PackingListExtChange


//                         CLEAR(OtherRevenues);
//                         ValueEntry.RESET;
//                         ValueEntry.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
//                         ValueEntry.SETRANGE("Document Line No.", "Sales Invoice Line"."Line No.");
//                         ValueEntry.SETRANGE("Item No.", "Sales Invoice Line"."No.");
//                         ValueEntry.SETRANGE(Adjustment, FALSE);
//                         IF ValueEntry.FINDFIRST THEN
//                             REPEAT
//                                 ValueEntry2.RESET;
//                                 ValueEntry2.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
//                                 ValueEntry2.SETRANGE("Item Ledger Entry No.", ValueEntry."Item Ledger Entry No.");
//                                 ValueEntry2.SETFILTER("Item Charge No.", '<>%1', '');
//                                 ValueEntry2.SETRANGE("Item No.", ValueEntry."Item No.");
//                                 IF ValueEntry2.FINDFIRST THEN
//                                     REPEAT
//                                         OtherRevenues += ValueEntry2."Sales Amount (Actual)";
//                                     UNTIL ValueEntry2.NEXT = 0;
//                             UNTIL ValueEntry.NEXT = 0;
//                         //Purchase Charges
//                         CLEAR(EXPFRT);
//                         CLEAR(EXPCDT);
//                         CLEAR(EXPINS);
//                         CLEAR(EXPTRC);
//                         CLEAR(EXPTHC);
//                         CLEAR(EXPSERV);
//                         CLEAR(EXPOthers);
//                         CLEAR(OtherCharges);
//                         CLEAR(EXPWHHNDL);
//                         CLEAR(EXPINPC);
//                         CLEAR(EXPWHPACK);
//                         CLEAR(EXPCOO);
//                         CLEAR(EXPLEGAL);
//                         CLEAR(RebateToCustomer);
//                         CLEAR(DemurrageToCustomer);
//                         ValueEntry.RESET;
//                         ValueEntry.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
//                         ValueEntry.SETRANGE("Document Line No.", "Sales Invoice Line"."Line No.");
//                         ValueEntry.SETRANGE("Item No.", "Sales Invoice Line"."No.");
//                         ValueEntry.SETRANGE(Adjustment, FALSE);
//                         IF ValueEntry.FINDFIRST THEN BEGIN
//                             REPEAT
//                                 ValueEntry2.RESET;
//                                 ValueEntry2.SETRANGE("Item Ledger Entry No.", ValueEntry."Item Ledger Entry No.");
//                                 ValueEntry2.SETFILTER("Item Charge No.", '<>%1', '');
//                                 ValueEntry2.SETRANGE("Item No.", ValueEntry."Item No.");
//                                 ValueEntry2.SETFILTER("Item Ledger Entry Type", '<>%1', ValueEntry2."Item Ledger Entry Type"::Sale);
//                                 IF ValueEntry2.FINDFIRST THEN
//                                     REPEAT
//                                         IF ValueEntry2."Item Charge No." = '01' THEN
//                                             EXPFRT += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                         ELSE
//                                             IF ValueEntry2."Item Charge No." = '02' THEN
//                                                 EXPCDT += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                             ELSE
//                                                 IF ValueEntry2."Item Charge No." = '03' THEN
//                                                     EXPINS += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                 ELSE
//                                                     IF ValueEntry2."Item Charge No." = '04' THEN
//                                                         EXPTRC += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                     ELSE
//                                                         IF ValueEntry2."Item Charge No." = '05' THEN
//                                                             EXPTHC += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                         ELSE
//                                                             IF ValueEntry2."Item Charge No." = '06' THEN
//                                                                 EXPSERV += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                             ELSE
//                                                                 IF ValueEntry2."Item Charge No." = '07' THEN
//                                                                     EXPOthers += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                 ELSE
//                                                                     IF ValueEntry2."Item Charge No." = '09' THEN
//                                                                         EXPWHHNDL += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                     ELSE
//                                                                         IF ValueEntry2."Item Charge No." = '10' THEN
//                                                                             EXPINPC += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                         ELSE
//                                                                             IF ValueEntry2."Item Charge No." = '21' THEN
//                                                                                 EXPWHPACK += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                             ELSE
//                                                                                 IF ValueEntry2."Item Charge No." = '24' THEN
//                                                                                     EXPCOO += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                                 ELSE
//                                                                                     IF ValueEntry2."Item Charge No." = '26' THEN
//                                                                                         EXPLEGAL += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                                     ELSE
//                                                                                         IF ValueEntry2."Item Charge No." = '32' THEN
//                                                                                             RebateToCustomer += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                                         ELSE
//                                                                                             IF ValueEntry2."Item Charge No." = '33' THEN
//                                                                                                 DemurrageToCustomer += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                                             ELSE
//                                                                                                 OtherCharges += ValueEntry2."Cost Amount (Non-Invtbl.)" * -1;
//                                     UNTIL ValueEntry2.NEXT = 0;
//                             UNTIL ValueEntry.NEXT = 0;
//                         END;
//                         //Purchase Charges

//                         CLEAR(COGSLCY);
//                         ValueEntry.RESET;
//                         ValueEntry.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
//                         ValueEntry.SETRANGE("Document Line No.", "Sales Invoice Line"."Line No.");
//                         ValueEntry.SetRange("Item No.", "Sales Invoice Line"."No.");//dn
//                         IF ValueEntry.FINDFIRST THEN
//                             REPEAT
//                                 COGSLCY += (ValueEntry."Cost Amount (Actual)" * -1);
//                             UNTIL ValueEntry.NEXT = 0;
//                         //Other Charges
//                         CLEAR(OtherPaymentCharges);
//                         Clear(OtherPaymentChargesLCY);
//                         CLEAR(CurrentLineAmount);
//                         CLEAR(TotalSalesInvoiceLineAmount);
//                         CLEAR(TotalDiscountAmount);
//                         CLEAR(SalesInvoiceLine);
//                         SalesInvoiceLine.ChangeCompany(Companies.Name);
//                         SalesInvoiceLine.RESET;
//                         SalesInvoiceLine.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
//                         SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::"G/L Account");
//                         IF SalesInvoiceLine.FINDFIRST THEN
//                             REPEAT
//                                 GeneralLedgerSetup.ChangeCompany(Companies.Name);
//                                 GeneralLedgerSetup.RESET;
//                                 GeneralLedgerSetup.SETFILTER("GP G/L Accounts", '@*' + SalesInvoiceLine."No." + '*');
//                                 IF GeneralLedgerSetup.FINDFIRST THEN BEGIN
//                                     TotalDiscountAmount += SalesInvoiceLine."Quantity (Base)" * SalesInvoiceLine."Unit Price Base UOM 2";  //PackingListExtChange
//                                 END;
//                             UNTIL SalesInvoiceLine.NEXT = 0;
//                         IF TotalDiscountAmount <> 0 THEN BEGIN
//                             SalesInvoiceLine.RESET;
//                             SalesInvoiceLine.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
//                             SalesInvoiceLine.SETRANGE(Type, SalesInvoiceLine.Type::Item);
//                             IF SalesInvoiceLine.FINDFIRST THEN
//                                 REPEAT
//                                     TotalSalesInvoiceLineAmount += SalesInvoiceLine."Quantity (Base)" * SalesInvoiceLine."Unit Price Base UOM 2"; //PackingListExtChange
//                                 UNTIL SalesInvoiceLine.NEXT = 0;
//                             CurrentLineAmount := "Sales Invoice Line"."Quantity (Base)" * "Sales Invoice Line"."Unit Price Base UOM 2"; //PackingListExtChange

//                             IF TotalSalesInvoiceLineAmount <> 0 THEN begin
//                                 if TotalSalesInvoiceLineAmount <> 0 then
//                                     OtherPaymentCharges := (CurrentLineAmount / TotalSalesInvoiceLineAmount) * TotalDiscountAmount
//                                 else
//                                     OtherPaymentCharges := 0;
//                             end;


//                             if CurrencyCode <> '' then
//                                 OtherPaymentChargesLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY("Sales Invoice Header"."Posting Date", CurrencyCode, OtherPaymentCharges, "Sales Invoice Header"."Currency Factor"))
//                             else
//                                 OtherPaymentCharges := ROUND(OtherPaymentCharges);

//                         END;
//                         //Other Charges
//                         CLEAR(ICCOGSLCY);
//                         IF SONo <> '' THEN BEGIN
//                             ICCompanyList.RESET;
//                             IF ICCompanyList.FindFirst() THEN
//                                 REPEAT
//                                     CLEAR(ICSalesOrderInvoiceLines);
//                                     ICSalesOrderInvoiceLines.ChangeCompany(ICCompanyList.Name);
//                                     ICSalesOrderInvoiceLines.RESET;
//                                     ICSalesOrderInvoiceLines.SETRANGE("IC Related SO", SONo);
//                                     ICSalesOrderInvoiceLines.SETRANGE("No.", "Sales Invoice Line"."No.");
//                                     ICSalesOrderInvoiceLines.SetRange("Location Code", "Sales Invoice Line"."Location Code");
//                                     IF ICSalesOrderInvoiceLines.FindFirst() THEN BEGIN
//                                         REPEAT
//                                             CLEAR(ICValueEntry);
//                                             Clear(COGSLCY);
//                                             Clear(ICCOGSLCY);
//                                             ICValueEntry.ChangeCompany(ICCompanyList.Name);
//                                             ICValueEntry.RESET;
//                                             ICValueEntry.SETRANGE("Document No.", ICSalesOrderInvoiceLines."Document No.");
//                                             ICValueEntry.SetRange("Item No.", ICSalesOrderInvoiceLines."No.");
//                                             ICValueEntry.SETRANGE("Document Line No.", ICSalesOrderInvoiceLines."Line No.");
//                                             //   ICValueEntry.SetFilter("Item Ledger Entry Quantity", '%1', ICSalesOrderInvoiceLines.Quantity);//dn
//                                             ICValueEntry.SetRange("Location Code", ICSalesOrderInvoiceLines."Location Code"); //DN
//                                             IF ICValueEntry.FINDFIRST THEN
//                                                 REPEAT
//                                                     ICCOGSLCY += (ICValueEntry."Cost Amount (Actual)" * -1);
//                                                 UNTIL ICValueEntry.NEXT = 0;

//                                             IF ICCOGSLCY <> 0 THEN
//                                                 COGSLCY := ICCOGSLCY;

//                                             ICValueEntry2.ChangeCompany(ICCompanyList.Name);

//                                             //Purchase Charges
//                                             ICValueEntry.RESET;
//                                             ICValueEntry.SETRANGE("Document No.", ICSalesOrderInvoiceLines."Document No.");
//                                             ICValueEntry.SETRANGE("Document Line No.", ICSalesOrderInvoiceLines."Line No.");
//                                             ICValueEntry.SETRANGE("Item No.", ICSalesOrderInvoiceLines."No.");
//                                             ICValueEntry.SETRANGE(Adjustment, FALSE);
//                                             IF ICValueEntry.FINDFIRST THEN BEGIN
//                                                 REPEAT
//                                                     ICValueEntry2.RESET;
//                                                     ICValueEntry2.SETRANGE("Item Ledger Entry No.", ICValueEntry."Item Ledger Entry No.");
//                                                     ICValueEntry2.SETFILTER("Item Charge No.", '<>%1', '');
//                                                     ICValueEntry2.SETRANGE("Item No.", ICValueEntry."Item No.");
//                                                     ICValueEntry2.SETFILTER("Item Ledger Entry Type", '<>%1', ICValueEntry2."Item Ledger Entry Type"::Sale);
//                                                     IF ChargeItemFilter <> '' THEN
//                                                         ICValueEntry2.SETFILTER("Item Charge No.", ChargeItemFilter);
//                                                     IF ICValueEntry2.FINDFIRST THEN
//                                                         REPEAT
//                                                             IF ICValueEntry2."Item Charge No." = '01' THEN
//                                                                 EXPFRT += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                             ELSE
//                                                                 IF ICValueEntry2."Item Charge No." = '02' THEN
//                                                                     EXPCDT += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                 ELSE
//                                                                     IF ICValueEntry2."Item Charge No." = '03' THEN
//                                                                         EXPINS += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                     ELSE
//                                                                         IF ICValueEntry2."Item Charge No." = '04' THEN
//                                                                             EXPTRC += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                         ELSE
//                                                                             IF ICValueEntry2."Item Charge No." = '05' THEN
//                                                                                 EXPTHC += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                             ELSE
//                                                                                 IF ICValueEntry2."Item Charge No." = '06' THEN
//                                                                                     EXPSERV += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                                 ELSE
//                                                                                     IF ICValueEntry2."Item Charge No." = '07' THEN
//                                                                                         EXPOthers += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                                     ELSE
//                                                                                         IF ICValueEntry2."Item Charge No." = '09' THEN
//                                                                                             EXPWHHNDL += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                                         ELSE
//                                                                                             IF ICValueEntry2."Item Charge No." = '10' THEN
//                                                                                                 EXPINPC += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                                             ELSE
//                                                                                                 IF ICValueEntry2."Item Charge No." = '21' THEN
//                                                                                                     EXPWHPACK += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                                                 ELSE
//                                                                                                     IF ICValueEntry2."Item Charge No." = '24' THEN
//                                                                                                         EXPCOO += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                                                     ELSE
//                                                                                                         IF ICValueEntry2."Item Charge No." = '26' THEN
//                                                                                                             EXPLEGAL += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                                                         ELSE
//                                                                                                             IF ICValueEntry2."Item Charge No." = '32' THEN
//                                                                                                                 RebateToCustomer += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                                                             ELSE
//                                                                                                                 IF ICValueEntry2."Item Charge No." = '33' THEN
//                                                                                                                     DemurrageToCustomer += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1
//                                                                                                                 ELSE
//                                                                                                                     OtherCharges += ICValueEntry2."Cost Amount (Non-Invtbl.)" * -1;
//                                                         UNTIL ICValueEntry2.NEXT = 0;
//                                                 UNTIL ICValueEntry.NEXT = 0;
//                                             END;
//                                         //Purchase Charges   
//                                         UNTIL ICSalesOrderInvoiceLines.NEXT = 0;
//                                     END;

//                                 UNTIL ICCompanyList.NEXT = 0;

//                         END;

//                         CLEAR(TotalAmountLCY);
//                         //TotalAmountLCY := TotalAmount + OtherRevenues;
//                         ValueEntry.RESET;
//                         ValueEntry.SETRANGE("Document No.", "Sales Invoice Line"."Document No.");
//                         //ValueEntry.SETRANGE("Document Line No.", "Sales Invoice Line"."Line No.");
//                         ValueEntry.SETRANGE("Item No.", "Sales Invoice Line"."No.");
//                         ValueEntry.SetRange("Document Line No.", "Sales Invoice Line"."Line No.");
//                         ValueEntry.SETRANGE(Adjustment, FALSE);
//                         IF ValueEntry.FINDFIRST THEN
//                             REPEAT
//                                 TotalAmountLCY += (ValueEntry."Sales Amount (Actual)");
//                             UNTIL ValueEntry.NEXT = 0;
//                         TotalAmountLCY := TotalAmountLCY + OtherRevenues;

//                         //TotalExpenses
//                         CLEAR(TotalSalesExpensesLCY);
//                         TotalSalesExpensesLCY := EXPCDT + EXPCOO + EXPFRT + EXPINPC + EXPINS + EXPLEGAL + EXPOthers + EXPSERV + EXPTHC + EXPTRC + EXPWHHNDL + EXPWHPACK + RebateToCustomer + DemurrageToCustomer + OtherCharges;
//                         //TotalExpenses
//                         //COSLCY
//                         CLEAR(COSLCY);
//                         COSLCY := COGSLCY + TotalSalesExpensesLCY;
//                         CLEAR(EffectiveGPLCY);
//                         EffectiveGPLCY := TotalAmountLCY - COSLCY;
//                         //COSLCY
//                     END;
//                 }
//                 TRIGGER OnPreDataItem()
//                 BEGIN
//                     "Sales Invoice Header".ChangeCompany(Companies.Name);
//                     IF (FromDate <> 0D) AND (ToDate <> 0D) THEN
//                         "Sales Invoice Header".SETRANGE("Posting Date", FromDate, ToDate);
//                     IF CustomerFilter <> '' THEN
//                         "Sales Invoice Header".SETRANGE("Sell-to Customer No.", CustomerFilter);
//                 END;

//                 TRIGGER OnAfterGetRecord()
//                 BEGIN
//                     CLEAR(ICPartners);
//                     ICPartners.ChangeCompany(Companies.Name);
//                     ICPartners.RESET;
//                     ICPartners.SETRANGE("Customer No.", "Sales Invoice Header"."Sell-to Customer No.");
//                     IF ICPartners.FINDFIRST THEN
//                         CurrReport.Skip();
//                 END;
//             }


//             TRIGGER OnPreDataItem()
//             BEGIN
//                 IF CompanyFilter <> '' THEN
//                     Companies.SETRANGE(Name, CompanyFilter);
//             END;

//             TRIGGER OnAfterGetRecord()
//             BEGIN
//                 CompanyInformation.ChangeCompany(Companies.Name);
//                 CompanyInformation.GET();
//             END;
//         }

//     }

//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(Options)
//                 {
//                     field(ExcludeCharges; ExcludeCharges)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Hide Item Charge Details';
//                     }
//                     field(FromDate; FromDate)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'From Date';
//                     }
//                     field(ToDate; ToDate)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'To Date';
//                         TRIGGER OnValidate()
//                         BEGIN
//                             IF (ToDate <> 0D) AND (FromDate = 0D) THEN Error('From date should not be blanl');
//                         END;
//                     }
//                     field(CompanyFilter; CompanyFilter)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Company';
//                         TableRelation = Company;
//                     }
//                     field(CustomerFilter; CustomerFilter)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Customer';
//                         TableRelation = Customer."No." where("Hide in Reports" = filter(false));
//                     }
//                     field(ItemCategoryFilter; ItemCategoryFilter)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Item Category';
//                         TableRelation = "Item Category";
//                     }
//                     field(ItemFilter; ItemFilter)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Item';
//                         TableRelation = Item;
//                     }
//                     field(ChargeItemFilter; ChargeItemFilter)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Item Charge';
//                         TableRelation = "Item Charge";
//                     }
//                 }
//             }
//         }

//         actions
//         {
//             area(processing)
//             {
//                 action(ActionName)
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//         }
//     }
//     TRIGGER OnPreReport()
//     BEGIN
//         IF (FromDate <> 0D) AND (ToDate = 0D) THEN ERROR('To date should not be blank');
//         IF (FromDate = 0D) AND (ToDate <> 0D) THEN ERROR('From date should not be blank');
//         CLEAR(FromDateFilter);
//         CLEAR(ToDateFilter);
//         IF FromDate <> 0D THEN
//             FromDateFilter := FORMAT(FromDate, 0, '<Closing><Day,2>-<Month Text>-<Year4>');
//         IF ToDate <> 0D THEN
//             ToDateFilter := FORMAT(ToDate, 0, '<Closing><Day,2>-<Month Text>-<Year4>');

//         IF (FromDate <> 0D) AND (ToDate <> 0D) THEN
//             DatesExist := TRUE;
//     END;

//     var
//         SrNo: Integer;

//         CurrExchRate: Record "Currency Exchange Rate";
//         KMP_TblMarketIndustry: Record KMP_TblMarketIndustry;
//         CSrNo: Integer;
//         invenotry: Report "Inventory Valuation";
//         Teams: Record "Team Salesperson";
//         EntryExitPoint: Record "Entry/Exit Point";
//         Areas: Record "Area";
//         CustomerShortName: Code[50];
//         RowColour: Boolean;
//         FromDate: Date;
//         ToDate: Date;
//         CurrencyCode: Code[20];
//         Qty: Text[20];
//         CompanyFilter: Text[30];
//         CustomerFilter: Code[20];
//         ItemCategoryFilter: Code[20];
//         ItemFilter: Code[20];
//         ChargeItemFilter: Code[20];
//         CompanyInformation: Record "Company Information";
//         ExcludeCharges: Boolean;
//         Customer: Record Customer;
//         SalesPerson: Record "Salesperson/Purchaser";
//         Item: Record Item;
//         SONo: Code[20];
//         SalesShipmentHeader: Record "Sales Shipment Header";
//         GeneralLedgerSetup: Record "General Ledger Setup";
//         TotalAmount: Decimal;
//         COGSLCY: Decimal;
//         OtherRevenues: Decimal;
//         ValueEntry: Record "Value Entry";
//         ValueEntry2: Record "Value Entry";
//         EXPFRT: Decimal;
//         EXPTHC: Decimal;
//         EXPCDT: Decimal;
//         EXPTRC: Decimal;
//         EXPOthers: Decimal;
//         EXPINS: Decimal;
//         EXPSERV: Decimal;
//         EXPINPC: Decimal;
//         EXPWHPACK: Decimal;
//         EXPWHHNDL: Decimal;
//         EXPLEGAL: Decimal;
//         EXPCOO: Decimal;
//         OtherCharges: Decimal;
//         RebateToCustomer: Decimal;
//         DemurrageToCustomer: Decimal;
//         ICSalesOrderInvoiceLines: Record "Sales Invoice Line";
//         ICSalesCrMemoInvoiceLines: Record "Sales Cr.Memo Line";
//         ICCompanyList: Record Company;
//         ICCOGSLCY: Decimal;
//         ICValueEntry: Record "Value Entry";
//         Customer_Rec: Record Customer;
//         ICValueEntry2: Record "Value Entry";
//         TotalSalesExpensesLCY: Decimal;
//         COSLCY: Decimal;

//         EffectiveGPLCY: Decimal;
//         TotalAmountLCY: Decimal;
//         ReportFilter: Text[250];
//         UnitOfMeasure: Record "Unit of Measure";
//         SalesInvoiceLine: Record "Sales Invoice Line";
//         SalesCrMemoLine: Record "Sales Cr.Memo Line";
//         ICPartners: Record "IC Partner";
//         OtherPaymentCharges: Decimal;
//         OtherPaymentChargesLCY: Decimal;
//         FromDateFilter: Text;
//         ToDateFilter: Text;
//         SOOrderDate: Date;
//         ItemCategory: Record "Item Category";
//         DatesExist: Boolean;
//         ChargesFound: Boolean;
//         ICChargesFound: Boolean;
//         TotalSalesInvoiceLineAmount: Decimal;
//         TotalDiscountAmount: Decimal;
//         CurrentLineAmount: Decimal;
//         SalesHeader: Record "Sales Header";
//         SalesHeaderArchieve: Record "Sales Header Archive";
//         ILE: Record "Item Ledger Entry";
// }