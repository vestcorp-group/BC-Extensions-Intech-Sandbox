// report 50144 "KMP_SalesAnalysisReport"
// {
//     UsageCategory = Administration;
//     ApplicationArea = All;
//     Caption = 'Sales Analysis';
//     DefaultLayout = RDLC;
//     RDLCLayout = './Layouts/KMP_SalesAnalysisReport.rdl';
//     dataset
//     {
//         dataitem(MainDataItem; Integer)
//         {
//             DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
//             dataitem(SalesInvoiceLine; "Sales Invoice Line")
//             {
//                 UseTemporary = true;

//                 column(CompanyName_Filter; CompanyName_Filter)
//                 { }
//                 column(FromDate; PostingFromDateG)
//                 { }
//                 column(ToDate; PostingToDateG)
//                 { }
//                 column(Order_Date_; SalesInvoiceHdrG."Order Date")
//                 { }
//                 column(Order_No_; SalesInvoiceLine."Order No.")
//                 { }
//                 column(Invoice_No_; SalesInvoiceHdrG."No.")
//                 { }
//                 column(Bill_to_Name_; SalesInvoiceHdrG."Bill-to Name")
//                 { }
//                 column(Bill_to_Customer_No_; SalesInvoiceHdrG."Bill-to Customer No.")
//                 { }
//                 column(Bill_to_Country_; SalesInvoiceHdrG."Bill-to Country/Region Code")
//                 { }
//                 column(Sales_Person_Code_; SalesPersonG.Name)
//                 { }
//                 column(ItemCode; "No.")
//                 { }
//                 column(Item_Description_; Description)
//                 { }
//                 column(ItemSearchDesc; ItemG."Search Description")
//                 { }
//                 column(Base_UOM; "Base UOM")
//                 { }
//                 column(Quantity__Base_; "Quantity (Base)")
//                 { }
//                 column(Unit_Price_Base_UOM; "Unit Price Base UOM")
//                 { }
//                 column(Quantity; "Quantity (Base)")
//                 { }
//                 column(Unit_Price; "Unit Price Base UOM")
//                 { }
//                 column(Unit_of_Measure; "Unit of Measure")
//                 { }
//                 column(Unit_of_Measure_Code; "Base UOM")
//                 { }
//                 column(Currency_Code_; SalesInvoiceHdrG."Currency Code")
//                 { }
//                 column(Line_Amount; "Line Amount")
//                 { }
//                 // column(Line_Amount_AED_; "Line Amount" * SalesInvoiceHdrG."Currency Factor")
//                 // { }
//                 //After discussion with Manish on 1-Jul-2019, Currency Factor formula should be as below
//                 column(Line_Amount_AED_; "Line Amount" * (1 / SalesInvoiceHdrG."Currency Factor"))
//                 { }
//                 column(Posting_Date; "Posting Date")
//                 { }
//                 column(Item_Category_Code; ItemCatG.Description)
//                 { }
//                 column(CompanyAddr1Value; CompanyAddrG[2])
//                 { }
//                 column(CompanyAddr2Value; CompanyAddrG[3])
//                 { }
//                 column(CompanyAddr3Value; CompanyAddrG[1])
//                 { }
//                 column(Total_Currency_Code; TotalAmountG."No.")
//                 { }
//                 column(Total_Currency_Wise_Amount_; TotalAmountG."Invoice Discount Value")
//                 { }
//                 column(Cogs_; abs(CogsG))
//                 { }
//                 column(Company_Name_; "Description 2")
//                 { }

//                 trigger OnPreDataItem()
//                 var
//                     myInt: Integer;

//                 begin
//                     // SalesInvoiceLine.SetCurrentKey("Posting Date");
//                     // SalesInvoiceLine.SetRange("Posting Date", PostingFromDateG, PostingToDateG);
//                     // if BillToCustNoG > '' then
//                     //     SalesInvoiceLine.SetRange("Bill-to Customer No.", BillToCustNoG);
//                     // if ItemNoG > '' then
//                     //     SalesInvoiceLine.SetRange("No.", ItemNoG);
//                     // if ItemCategoryG > '' then
//                     //     SalesInvoiceLine.SetRange("Item Category Code", ItemCategoryG);


//                 end;

//                 trigger OnAfterGetRecord()
//                 var
//                     GLSetupL: Record "General Ledger Setup";
//                     ValueEntryL: Record "Value Entry";
//                     CustomerL: Record Customer;
//                 begin
//                     Clear(SalesPersonG);
//                     Clear(ItemCatG);
//                     GLSetupL.ChangeCompany("Description 2");
//                     SalesInvoiceHdrG.ChangeCompany("Description 2");
//                     ValueEntryL.ChangeCompany("Description 2");
//                     ItemG.ChangeCompany("Description 2");
//                     SalesPersonG.ChangeCompany("Description 2");
//                     ItemCatG.ChangeCompany("Description 2");
//                     CurrencyExcRateG.ChangeCompany("Description 2");
//                     CustomerL.ChangeCompany("Description 2");
//                     If CustomerL.Get("Sell-to Customer No.") and (CustomerL."IC Partner Code" > '') and (not ShowInterCompany) then
//                         CurrReport.Skip();
//                     GLSetupL.Get();
//                     ItemG."Search Description" := Description;
//                     SalesInvoiceHdrG.Get("Document No.");
//                     if (SalesInvoiceLine.Type = SalesInvoiceLine.Type::Item) and (ItemG.Get("No.")) then
//                         if (ItemG."Inventory Posting Group" <> 'PD') and (ItemG."Inventory Posting Group" <> 'RAW') then
//                             CurrReport.Skip();
//                     if CountryCodeG > '' then
//                         if SalesInvoiceHdrG."Bill-to Country/Region Code" <> CountryCodeG then
//                             CurrReport.Skip();
//                     if SalesPersonCodeG > '' then
//                         if SalesInvoiceHdrG."Salesperson Code" <> SalesPersonCodeG then
//                             CurrReport.Skip();
//                     if SalesInvoiceHdrG."Currency Factor" = 0 then
//                         SalesInvoiceHdrG."Currency Factor" := 1;
//                     if SalesInvoiceHdrG."Currency Code" = '' then
//                         SalesInvoiceHdrG."Currency Code" := GLSetupL."LCY Code";
//                     if CurrencyCodeG > '' then
//                         if SalesInvoiceHdrG."Currency Code" <> CurrencyCodeG then
//                             CurrReport.Skip();
//                     if not TotalAmountG.Get(SalesInvoiceHdrG."Currency Code") then begin
//                         TotalAmountG.Init();
//                         TotalAmountG."No." := SalesInvoiceHdrG."Currency Code";
//                         TotalAmountG.Insert();
//                     end;
//                     ValueEntryL.SETCURRENTKEY("Document Type", "Document No.", "Document Line No.");
//                     ValueEntryL.SetRange("Document Type", ValueEntryL."Document Type"::"Sales Invoice");
//                     ValueEntryL.SetRange("Document No.", SalesInvoiceHdrG."No.");
//                     ValueEntryL.SetRange("Document Line No.", SalesInvoiceLine."Line No.");
//                     ValueEntryL.CalcSums("Cost Amount (Actual)");
//                     //CogsG := CurrencyExcRateG.ExchangeAmtFCYToFCY(SalesInvoiceHdrG."Posting Date", SalesInvoiceHdrG."Currency Code", GLSetupL."LCY Code", ValueEntryL."Cost Amount (Actual)");
//                     CogsG := ValueEntryL."Cost Amount (Actual)";
//                     TotalAmountG."Invoice Discount Value" := "Line Amount";
//                     TotalAmountG.Modify();

//                     if (SalesInvoiceHdrG."Salesperson Code" > '') and (SalesPersonG.Get(SalesInvoiceHdrG."Salesperson Code")) then;
//                     if ("Item Category Code" > '') and (ItemCatG.Get("Item Category Code")) then;
//                 end;
//             }


//             dataitem(SalesCreditMemoLine; "Sales Cr.Memo Line")
//             {
//                 UseTemporary = true;

//                 column(Order_Date_G; SalesCreditMemoHdrG."Posting Date")
//                 { }
//                 column(Order_No_G; SalesCreditMemoLine."Order No.")
//                 { }
//                 column(Invoice_No_G; SalesCreditMemoHdrG."No.")
//                 { }
//                 column(Bill_to_Name_G; SalesCreditMemoHdrG."Bill-to Name")
//                 { }
//                 column(Bill_to_Customer_No_G; SalesCreditMemoHdrG."Bill-to Customer No.")
//                 { }
//                 column(Bill_to_Country_G; SalesCreditMemoHdrG."Bill-to Country/Region Code")
//                 { }
//                 column(Sales_Person_Code_G; SalesPerson2G.Name)
//                 { }
//                 column(ItemCode_G; "No.")
//                 { }
//                 column(Item_Description_G; Description)
//                 { }
//                 column(ItemSearchDesc_G; Item2G."Search Description")
//                 { }
//                 column(Quantity_G; Quantity)
//                 { }
//                 column(Unit_Price_G; "Unit Price")
//                 { }
//                 column(Unit_of_Measure_G; "Unit of Measure")
//                 { }
//                 column(Unit_of_Measure_Code_G; "Unit of Measure Code")
//                 { }
//                 column(Currency_Code_G; SalesCreditMemoHdrG."Currency Code")
//                 { }
//                 column(Line_Amount_G; "Line Amount")
//                 { }
//                 // column(Line_Amount_AED_; "Line Amount" * SalesInvoiceHdrG."Currency Factor")
//                 // { }
//                 //After discussion with Manish on 1-Jul-2019, Currency Factor formula should be as below
//                 column(Line_Amount_AED_G; "Line Amount" * (1 / SalesCreditMemoHdrG."Currency Factor"))
//                 { }
//                 column(Posting_Date_G; "Posting Date")
//                 { }
//                 column(Item_Category_Code_G; ItemCat2G.Description)
//                 { }

//                 // column(CompanyAddr1Value; CompanyAddrG[2])
//                 // { }
//                 // column(CompanyAddr2Value; CompanyAddrG[3])
//                 // { }
//                 // column(CompanyAddr3Value; CompanyAddrG[1])
//                 // { }
//                 column(Total_Currency_Code_G; TotalAmountG."No.")
//                 { }
//                 column(Total_Currency_Wise_Amount_G; TotalAmountG."Invoice Discount Value")
//                 { }
//                 column(Cogs_G; abs(Cogs2G))
//                 { }
//                 column(Company_Name_G; "Description 2")
//                 { }

//                 trigger OnPreDataItem()
//                 var
//                     myInt: Integer;

//                 begin
//                     // SalesCreditMemoLine.SetCurrentKey("Posting Date");
//                     // SalesCreditMemoLine.SetRange("Posting Date", PostingFromDateG, PostingToDateG);
//                     // if BillToCustNo2G > '' then
//                     //     SalesCreditMemoLine.SetRange("Bill-to Customer No.", BillToCustNo2G);
//                     // if ItemNo2G > '' then
//                     //     SalesCreditMemoLine.SetRange("No.", ItemNo2G);
//                     // if ItemCategory2G > '' then
//                     //     SalesCreditMemoLine.SetRange("Item Category Code", ItemCategory2G);


//                 end;

//                 trigger OnAfterGetRecord()
//                 var
//                     GLSetupL: Record "General Ledger Setup";
//                     ValueEntryL: Record "Value Entry";
//                     CustomerL: Record Customer;
//                 begin
//                     Clear(SalesPerson2G);
//                     Clear(ItemCat2G);
//                     GLSetupL.ChangeCompany("Description 2");
//                     SalesCreditMemoHdrG.ChangeCompany("Description 2");
//                     ValueEntryL.ChangeCompany("Description 2");
//                     Item2G.ChangeCompany("Description 2");
//                     SalesPerson2G.ChangeCompany("Description 2");
//                     ItemCat2G.ChangeCompany("Description 2");
//                     CurrencyExcRateG.ChangeCompany("Description 2");
//                     CustomerL.ChangeCompany("Description 2");
//                     If CustomerL.Get("Sell-to Customer No.") and (CustomerL."IC Partner Code" > '') and (not ShowInterCompany) then
//                         CurrReport.Skip();
//                     GLSetupL.Get();
//                     Item2G."Search Description" := Description;
//                     SalesCreditMemoHdrG.Get("Document No.");
//                     if (SalesCreditMemoLine.Type = SalesCreditMemoLine.Type::Item) and (Item2G.Get("No.")) then
//                         if (Item2G."Inventory Posting Group" <> 'PD') and (Item2G."Inventory Posting Group" <> 'RAW') then
//                             CurrReport.Skip();
//                     if CountryCodeG > '' then
//                         if SalesCreditMemoHdrG."Bill-to Country/Region Code" <> CountryCodeG then
//                             CurrReport.Skip();
//                     if SalesPersonCodeG > '' then
//                         if SalesCreditMemoHdrG."Salesperson Code" <> SalesPersonCodeG then
//                             CurrReport.Skip();
//                     if SalesCreditMemoHdrG."Currency Factor" = 0 then
//                         SalesCreditMemoHdrG."Currency Factor" := 1;
//                     if SalesCreditMemoHdrG."Currency Code" = '' then
//                         SalesCreditMemoHdrG."Currency Code" := GLSetupL."LCY Code";
//                     if CurrencyCodeG > '' then
//                         if SalesCreditMemoHdrG."Currency Code" <> CurrencyCodeG then
//                             CurrReport.Skip();
//                     if not TotalAmountG.Get(SalesCreditMemoHdrG."Currency Code") then begin
//                         TotalAmountG.Init();
//                         TotalAmountG."No." := SalesCreditMemoHdrG."Currency Code";
//                         TotalAmountG.Insert();
//                     end;
//                     ValueEntryL.SETCURRENTKEY("Document Type", "Document No.", "Document Line No.");
//                     ValueEntryL.SetRange("Document Type", ValueEntryL."Document Type"::"Sales Credit Memo");
//                     ValueEntryL.SetRange("Document No.", SalesCreditMemoHdrG."No.");
//                     ValueEntryL.SetRange("Document Line No.", SalesCreditMemoLine."Line No.");
//                     ValueEntryL.CalcSums("Cost Amount (Actual)");
//                     //Cogs2G := CurrencyExcRateG.ExchangeAmtFCYToFCY(SalesCreditMemoHdrG."Posting Date", SalesCreditMemoHdrG."Currency Code", GLSetupL."LCY Code", ValueEntryL."Cost Amount (Actual)");
//                     Cogs2G := ValueEntryL."Cost Amount (Actual)";
//                     TotalAmountG."Invoice Discount Value" := -"Line Amount";
//                     TotalAmountG.Modify();

//                     if (SalesCreditMemoHdrG."Salesperson Code" > '') and (SalesPerson2G.Get(SalesCreditMemoHdrG."Salesperson Code")) then
//                         ;
//                     if ("Item Category Code" > '') and (ItemCat2G.Get("Item Category Code")) then
//                         ;
//                 end;
//             }
//             trigger OnPreDataItem()
//             var
//                 myInt: Integer;
//             begin
//                 IF CompanyNameG > '' THEN BEGIN
//                     InsertIntoTemp(CompanyNameG)
//                 END else BEGIN
//                     CompanyG.FINDSET();
//                     REPEAT
//                         InsertIntoTemp(CompanyG.Name);
//                     UNTIL CompanyG.NEXT = 0;
//                 END;
//                 if CompanyNameG = '' then
//                     CompanyName_Filter := 'Group Of Companies'
//                 else
//                     CompanyName_Filter := CompanyNameG;
//             end;
//         }
//     }

//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(GroupName)
//                 {
//                     field("From Date"; PostingFromDateG)
//                     {
//                         ApplicationArea = All;
//                         ShowMandatory = true;
//                     }
//                     field("To Date"; PostingToDateG)
//                     {
//                         ApplicationArea = all;
//                         ShowMandatory = true;
//                     }
//                     field("Bill-to Customer No."; BillToCustNoG)
//                     {
//                         ApplicationArea = all;
//                         TableRelation = Customer;
//                     }
//                     field("Item Category"; ItemCategoryG)
//                     {
//                         ApplicationArea = all;
//                         TableRelation = "Item Category";
//                     }
//                     field("Sell-to Country"; CountryCodeG)
//                     {
//                         ApplicationArea = all;
//                         TableRelation = "Country/Region";
//                     }
//                     field("Item No."; ItemNoG)
//                     {
//                         ApplicationArea = all;
//                         //TableRelation = Item where ("Inventory Posting Group" = filter (<> 'SAMPLE'));
//                         TableRelation = Item where("Inventory Posting Group" = filter('PD'));
//                     }
//                     field("Sales Person"; SalesPersonCodeG)
//                     {
//                         ApplicationArea = all;
//                         TableRelation = "Salesperson/Purchaser";
//                     }
//                     field("Currency Code"; CurrencyCodeG)
//                     {
//                         ApplicationArea = all;
//                         TableRelation = Currency;
//                     }
//                     field("Company Name"; CompanyNameG)
//                     {
//                         ApplicationArea = all;
//                         TableRelation = Company;
//                     }
//                     field("Show Intercompany"; ShowInterCompany)
//                     {
//                         ApplicationArea = all;
//                     }
//                 }
//             }
//         }

//     }
//     trigger OnPreReport()
//     begin
//         CompanyInfoG.Get();
//         FormatAddrG.Company(CompanyAddrG, CompanyInfoG);
//     end;

//     local procedure InsertIntoTemp(ComanyNameP: text)
//     var
//         SalesInvoiceLineL: Record "Sales Invoice Line";
//         SalesCrMemoLineL: Record "Sales Cr.Memo Line";
//     begin
//         SalesInvoiceLineL.CHANGECOMPANY(ComanyNameP);
//         SalesInvoiceLineL.SetCurrentKey("Posting Date");
//         SalesInvoiceLineL.SETRANGE(Type, SalesInvoiceLineL.Type::"G/L Account", SalesInvoiceLineL.Type::"Charge (Item)");
//         SalesInvoiceLineL.SETRANGE("Posting Date", PostingFromDateG, PostingToDateG);
//         if not ShowInterCompany then
//             SalesInvoiceLineL.SetRange("IC Partner Reference", '');
//         if BillToCustNoG > '' then
//             SalesInvoiceLineL.SetRange("Bill-to Customer No.", BillToCustNoG);
//         if ItemNoG > '' then
//             SalesInvoiceLineL.SetRange("No.", ItemNoG);
//         if ItemCategoryG > '' then
//             SalesInvoiceLineL.SetRange("Item Category Code", ItemCategoryG);
//         IF SalesInvoiceLineL.FINDSET then
//             REPEAT
//                 SalesInvoiceLine := SalesInvoiceLineL;
//                 SalesInvoiceLine."Description 2" := ComanyNameP;
//                 if SalesInvoiceLine.INSERT then;
//             UNTIL SalesInvoiceLineL.NEXT = 0;

//         SalesCrMemoLineL.CHANGECOMPANY(ComanyNameP);
//         SalesCrMemoLineL.SetCurrentKey("Posting Date");
//         SalesCrMemoLineL.SETRANGE(Type, SalesCrMemoLineL.Type::"G/L Account", SalesCrMemoLineL.Type::"Charge (Item)");
//         SalesCrMemoLineL.SETRANGE("Posting Date", PostingFromDateG, PostingToDateG);
//         if not ShowInterCompany then
//             SalesCrMemoLineL.SetRange("IC Partner Reference", '');
//         if BillToCustNoG > '' then
//             SalesCrMemoLineL.SetRange("Bill-to Customer No.", BillToCustNoG);
//         if ItemNoG > '' then
//             SalesCrMemoLineL.SetRange("No.", ItemNoG);
//         if ItemCategoryG > '' then
//             SalesCrMemoLineL.SetRange("Item Category Code", ItemCategoryG);
//         IF SalesCrMemoLineL.FINDSET then
//             REPEAT
//                 SalesCreditMemoLine := SalesCrMemoLineL;
//                 SalesCreditMemoLine."Description 2" := ComanyNameP;
//                 if SalesCreditMemoLine.INSERT then;
//             UNTIL SalesCrMemoLineL.NEXT = 0;



//     end;

//     var
//         SalesInvoiceHdrG: Record "Sales Invoice Header";
//         SalesCreditMemoHdrG: Record "Sales Cr.Memo Header";
//         TotalAmountG: Record "Sales Invoice Header" temporary;
//         TotalAmount2G: Record "Sales Cr.Memo Header" temporary;
//         CompanyInfoG: Record "Company Information";
//         CurrencyExcRateG: Record "Currency Exchange Rate";
//         CompanyG: Record Company;
//         FormatAddrG: Codeunit "Format Address";
//         FormatAddr2G: Codeunit "Format Address";
//         PostingFromDateG: Date;
//         PostingFromDate2G: Date;
//         PostingToDateG: date;
//         PostingToDate2G: date;
//         BillToCustNoG: Code[20];
//         BillToCustNo2G: Code[20];
//         ItemCategoryG: Code[20];
//         ItemCategory2G: Code[20];
//         CountryCodeG: code[20];
//         CountryCode2G: code[20];
//         ItemNoG: Code[20];
//         ItemNo2G: Code[20];
//         ShowInterCompany: Boolean;
//         CompanyAddrG: array[8] of Text[100];
//         CompanyAddr2G: array[8] of Text[100];

//         ItemG: Record Item;
//         Item2G: Record Item;
//         SalesPersonG: Record "Salesperson/Purchaser";
//         SalesPerson2G: Record "Salesperson/Purchaser";
//         ItemCatG: Record "Item Category";
//         ItemCat2G: Record "Item Category";

//         //Define the global variable as we can use these variables in both the dataitem
//         Order_Date_G: Date;
//         Order_No_G: Code[20];
//         Invoice_No_G: Code[20];
//         Bill_to_Name_G: Text[50];
//         Bill_to_Country_G: Text[50];
//         CompanyNameG: Text;
//         CogsG: Decimal;
//         Cogs2G: Decimal;
//         SalesPersonCodeG: Code[20];
//         CurrencyCodeG: Code[20];
//         CompanyName_Filter: Text;

// }