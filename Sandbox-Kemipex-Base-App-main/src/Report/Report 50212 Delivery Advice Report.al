// report 50212 "Delivery Advice Report"
// {
//     DefaultLayout = RDLC;
//     RDLCLayout = './Layouts/KMP_DeliveryAdvice.rdl';

//     dataset
//     {
//         dataitem(SalesHeader; "Sales Header")
//         {
//             RequestFilterFields = "No.";
//             column(Sell_to_Customer_No_; "Bill-to Customer No.")
//             {

//             }
//             column(commacap; commacap)
//             {

//             }

//             column(commacap1; commacap1)
//             {

//             }
//             column(Sell_to_Customer_Name; "Bill-to Name")
//             {

//             }
//             column(Sell_to_Address; "Bill-to Address")
//             {

//             }
//             column(Sell_to_Address_2; "Bill-to Address 2")
//             {

//             }
//             column(Sell_to_City; "Bill-to City")
//             {

//             }
//             column(Sell_to_Country_Region_Code; "Bill-to Country/Region Code")
//             {

//             }
//             column(No_; "No.")
//             {

//             }
//             column(DANoCap; DANoCap)
//             {

//             }
//             column(ExporterCodeCap; ExporterCodeCap)
//             {

//             }
//             column(ImporterCodeCap; ImporterCodeCap)
//             {

//             }
//             column(AgentCodeCap; AgentCodeCap)
//             {

//             }
//             column(AgentNameCap; AgentNameCap)
//             {

//             }
//             column(RepCardNoCap; RepCardNoCap)
//             {

//             }
//             column(ProductDetailsCap; ProductDetailsCap)
//             {

//             }
//             column(TypeCap; TypeCap)
//             {

//             }
//             column(QuantityCap; QuantityCap)
//             {

//             }
//             column(WeightCap; WeightCap)
//             {

//             }
//             column(VolumeCap; VolumeCap)
//             {

//             }
//             column(DescriptionofGoodsCap; DescriptionofGoodsCap)
//             {

//             }
//             column(ContainerNumbersCap; ContainerNumbersCap)
//             {

//             }
//             column(PaymentMethodCap; PaymentMethodCap)
//             {

//             }
//             column(CDRCashCap; CDRCashCap)
//             {

//             }
//             column(CreditACCap; CreditACCap)
//             {

//             }
//             column(FTTCap; FTTCap)
//             {

//             }
//             column(StanGCap; StanGCap)
//             {

//             }
//             column(AlcoholCap; AlcoholCap)
//             {

//             }
//             column(DepositCap; DepositCap)
//             {

//             }
//             column(BankGCap; BankGCap)
//             {

//             }
//             column(OtherCap; OtherCap)
//             {

//             }
//             column(RefACNo; RefACNo)
//             {

//             }
//             column(CustomsBillTypeCap; CustomsBillTypeCap)
//             {

//             }
//             column(ImportCap; ImportCap)
//             {

//             }
//             column(TemporaryExitCap; TemporaryExitCap)
//             {

//             }
//             column(ExportCap; ExportCap)
//             {

//             }
//             column(ImportforReExportCap; ImportforReExportCap)
//             {

//             }
//             column(FreeZoneInternalTransferCap; FreeZoneInternalTransferCap)
//             {

//             }
//             column(ForCustomsUseCap; ForCustomsUseCap)
//             {

//             }
//             column(DestinationCap; DestinationCap)
//             {

//             }
//             column(CarrierAgentCap; CarrierAgentCap)
//             {

//             }
//             column(ValueCap; ValueCap)
//             {

//             }
//             column(Text001; Text001)
//             {

//             }
//             column(Text002; Text002)
//             {

//             }
//             column(Text003; Text003)
//             {

//             }
//             column(Text004; Text004)
//             {

//             }
//             column(Text005; Text005)
//             {

//             }
//             column(Text006; Text006)
//             {

//             }
//             column(Text007; Text007)
//             {

//             }
//             column(DeliveryAdviceHeaderCap; DeliveryAdviceHeaderCap)
//             {

//             }
//             column(CDRBankCap; CDRBankCap)
//             {

//             }
//             column(Checkbox1; Checkbox1)
//             {

//             }
//             column(CountryCode; CountryCode)
//             {

//             }
//             column(CompanyInfo_Exporter; CompanyInfo."E-Mirsal Code")
//             {

//             }
//             column(CompanyInfo_Picture; CompanyInfo.Picture)
//             {

//             }
//             column(CompanyInfo_Name; CompanyInfo.Name)
//             {

//             }
//             column(CompanyInfo_Address; CompanyInfo.Address)
//             {

//             }
//             column(CompanyInfo_Address2; CompanyInfo."Address 2")
//             {

//             }
//             column(CompanyInfo_City; CompanyInfo.City)
//             {

//             }
//             column(CompanyInfo_Phoneno; CompanyInfo."Phone No.")
//             {

//             }
//             column(CompanyInfo_Email; CompanyInfo."E-Mail")
//             {

//             }
//             column(Posting_Date1; "Posting Date")
//             {

//             }
//             column(Posting_Date; format("Posting Date", 0, '<Day,2>-<Month Text>-<year4>'))
//             {

//             }
//             column(Shipping_Agent_Code; "Shipping Agent Code")
//             {

//             }
//             column(CountryCode1; CountryCode1)
//             {

//             }
//             column(AgentName; AgentName)
//             {

//             }
//             column(CompanyInfo_HomePage; CompanyInfo."Home Page")
//             {

//             }
//             column(Document_Date; format("Document Date", 0, '<Day,2>-<Month Text>-<year4>'))
//             {

//             }
//             column(Amount_Including_VAT; "Amount Including VAT")
//             {

//             }
//             column(GLSetup; "Currency Code")
//             {

//             }
//             column(ImporterCode1; ImporterCode1)
//             {

//             }
//             column(Exit_Point; "Exit Point")
//             {

//             }
//             column(ImporterCode; ImporterCode)
//             {

//             }
//             column(ExitPointDesc; ExitPointDesc)
//             {

//             }
//             column(Area1; Area1)
//             {

//             }
//             column(Sell_to_Post_Code; "Bill-to Post Code")
//             {

//             }
//             column(TransportMethod; TransportMethod)
//             {

//             }
//             column(Pagecaption; Pagecaption)
//             {

//             }
//             column(ContainerNo; ContainerNo)
//             {

//             }
//             trigger OnAfterGetRecord()
//             var
//                 SalesLineRec1: Record "Sales Line";
//             begin
//                 if ShAgent.Get(SalesHeader."Shipping Agent Code") then
//                     AgentName := ShAgent.Name;

//                 if TransportMethodRec.Get(SalesHeader."Transport Method") then
//                     TransportMethod := TransportMethodRec.Description;

//                 If AreaRec.Get(SalesHeader."Area") then
//                     Area1 := AreaRec.Text;

//                 if "Currency Code" = '' then
//                     "Currency Code" := GLSetup."LCY Code";

//                 if CountryRegion1.Get(SalesHeader."Bill-to Country/Region Code") then
//                     CountryCode1 := CountryRegion1.Name;

//                 if ExitPointRec.Get(SalesHeader."Exit Point") then
//                     ExitPointDesc := ExitPointRec.Description;

//                 if CustomerRec.Get(SalesHeader."Bill-to Customer No.") then
//                     ImporterCode1 := CustomerRec."E-Mirsal Code";

//                 SalesLineRec1.SetRange("Document Type", "Document Type");
//                 SalesLineRec1.SetRange("Document No.", "No.");
//                 SalesLineRec1.SetRange(Type, SalesLineRec1.Type::Item); //PSP
//                 if SalesLineRec1.FindFirst() then
//                     repeat
//                         If ContainerNo = '' then begin
//                             ContainerNo := SalesLineRec1."Container No. 2"
//                         end else begin
//                             //if (StrPos(ContainerNo, SalesLineRec1."Container No.") = 0) then
//                             if SalesLineRec1."Container No. 2" <> '' then
//                                 ContainerNo := ContainerNo + ', ' + SalesLineRec1."Container No. 2";
//                         end;
//                     until SalesLineRec1.Next() = 0;



//             end;
//         }
//         dataitem(SalesLine; "Sales Line")
//         {
//             DataItemLink = "Document No." = FIELD("No.");
//             DataItemLinkReference = SalesHeader;
//             //DataItemTableView = SORTING("Document No.", "Line No.") where(type = filter(<> " "));
//             DataItemTableView = SORTING("Line No.");
//             column(Item_No_; "No.")
//             { }
//             column(Description; Description)
//             {

//             }
//             column(SalesLineMerge; SalesLineMerge) { }
//             column(HSNCode; HSNCode) { }
//             column(Unit_of_Measure_Code; IUOMG.Code)
//             {

//             }
//             column(Quantity; "Quantity (Base)" / IUOMG."Qty. per Unit of Measure")
//             {

//             }
//             column(Quantity1; Quantity)
//             {

//             }
//             column(SL_Type; "Type")
//             {
//             }
//             column(Line_No_; "Line No.") { }
//             column(Item_Unitofmeasure; IUOMG.Code) { }
//             column(Quantity__Base_; Quantity / IUOMG."Qty. per Unit of Measure") { }

//             column(Unit_Cost__LCY_; "Unit Cost (LCY)")
//             {

//             }
//             column(BOEDescription; BOEDescription)
//             {

//             }
//             column(Description_2; "Description 2")
//             {

//             }
//             column(LineCountryOfOrigin; LineCountryOfOrigin)
//             {

//             }
//             column(Net_Weight; "Net Weight")
//             {

//             }
//             column(Gross_Weight; "Gross Weight")
//             {

//             }
//             column(Item_Category_Code; "Item Category Code")
//             {

//             }
//             column(ICC; ICC)
//             {

//             }
//             column(TariffNo; TariffNo)
//             {

//             }
//             column(CountryOfOrigin; CountryRegionCode.Name)
//             {

//             }
//             column(ItemNo1; "Line No.")
//             {

//             }

//             column(UOMVar; ItemCRec."Description 2")
//             {

//             }
//             trigger OnAfterGetRecord()
//             var
//                 SalesLineL: Record "Sales Line";
//                 IUOML: Record "Item Unit of Measure";
//             begin

//                 Clear(IUOMG);
//                 IUOMG.SetCurrentKey("Item No.", "Qty. per Unit of Measure");
//                 IUOMG.SetRange("Item No.", "No.");
//                 If IUOMG.FindFirst() then
//                     ;

//                 Clear(CountryRegionCode);
//                 If CountryRegionCode.Get(CountryOfOrigin) then
//                     ;


//                 if ItemCRec.Get(SalesLine."No.") then
//                     ICC := ItemCRec."Generic Description";

//                 if Itm.Get(SalesLine."No.") then
//                     TariffNo := Itm."Tariff No.";



//                 if UOMRec.Get("No.", "Unit of Measure Code") then begin
//                     UOMVar := Format(UOMRec."Net Weight") + ' kg ' + LowerCase("unit of Measure Code");
//                 end;

//                 Clear(BOEDescription);
//                 ItemTrackingLines.Reset();
//                 ItemTrackingLines.SetSourceFilter(Database::"Sales Line", "Document Type", "Document No.", "Line No.", true);
//                 if ItemTrackingLines.FindFirst() then begin
//                     repeat
//                         If BOEDescription = '' then
//                             BOEDescription := ItemTrackingLines.CustomBOENumber
//                         else
//                             if StrPos(BOEDescription, ItemTrackingLines.CustomBOENumber) = 0 then
//                                 BOEDescription := BOEDescription + ',' + ItemTrackingLines.CustomBOENumber;
//                     until ItemTrackingLines.Next() = 0;
//                 end;
//                 Clear(Quantity);
//                 Quantity := "Quantity (Base)" / IUOMG."Qty. per Unit of Measure";

//                 //psp
//                 if not SalesLineMerge then begin
//                     SalesLineL.Reset();
//                     SalesLineL.SetRange("Document Type", "Document Type");
//                     SalesLineL.SetRange("Document No.", "Document No.");
//                     SalesLineL.SetFilter("Line No.", '<%1', "Line No.");
//                     SalesLineL.SetRange("Unit of Measure Code", "Unit of Measure Code");
//                     SalesLineL.SetRange("Location Code", "Location Code");
//                     SalesLineL.SetRange("Unit Price", "Unit Price");
//                     SalesLineL.SetRange("No.", "No.");
//                     if SalesLineL.FindFirst() then
//                         CurrReport.Skip();
//                     SalesLineL.Reset();
//                     SalesLineL.SetRange("Document Type", "Document Type");
//                     SalesLineL.SetRange("Document No.", "Document No.");
//                     SalesLineL.SetFilter("Line No.", '>%1', "Line No.");
//                     SalesLineL.SetRange("No.", "No.");
//                     /* Clear(BOEDescription);
//                     ItemTrackingLines.Reset(); */
//                     if SalesLineL.FindSet() then
//                         repeat
//                             if ("Unit Price" = SalesLineL."Unit Price") and ("Unit of Measure Code" = SalesLineL."Unit of Measure Code") and ("Location Code" = SalesLineL."Location Code") then begin
//                                 Quantity += SalesLineL."Quantity (Base)" / IUOMG."Qty. per Unit of Measure";
//                                 "Amount Including VAT" += SalesLineL."Amount Including VAT";
//                                 Amount += SalesLineL.Amount;
//                                 "Net Weight" += SalesLineL."Net Weight";
//                                 "Gross Weight" += SalesLineL."Gross Weight";

//                                 ItemTrackingLines.SetSourceFilter(Database::"Sales Line", "Document Type", "Document No.", SalesLineL."Line No.", true);
//                                 if ItemTrackingLines.FindFirst() then begin
//                                     repeat
//                                         If BOEDescription = '' then
//                                             BOEDescription := ItemTrackingLines.CustomBOENumber
//                                         else
//                                             // if BOEDescription <> '' then
//                                             if StrPos(BOEDescription, ItemTrackingLines.CustomBOENumber) = 0 then
//                                                 BOEDescription := BOEDescription + ',' + ItemTrackingLines.CustomBOENumber;
//                                     until ItemTrackingLines.Next() = 0;
//                                 end;
//                             end;
//                         until SalesLineL.Next() = 0;
//                 end;
//             end;

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
//                     field("SalesLine Merge"; SalesLineMerge)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'SalesLine UnMerge';
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
//     trigger OnInitReport()
//     begin
//         CompanyInfo.GET;
//         CompanyInfo.CALCFIELDS(Picture);
//         GLSetup.Get();

//         if CountryRegion.Get(CompanyInfo."Country/Region Code") then
//             CountryCode := CountryRegion.Name;

//         if CompanyInfo.City = '' then
//             commacap := ''
//         else
//             commacap := ', ';

//         if CompanyInfo.City = '' then
//             commacap1 := ''
//         else
//             commacap1 := ', ';

//     end;

//     var
//         Qty: Decimal;
//         Qty1: Decimal;
//         commacap: Text[10];
//         commacap1: Text[10];
//         SalesLineRec: Record "Sales Line";
//         ImporterCode1: Text[30];
//         ExitPointDesc: Text[100];
//         ExitPointRec: Record "Entry/Exit Point";
//         ContainerNo1: Text[30];
//         CountryRegion1: Record "Country/Region";
//         UOM1: Text[50];
//         TransportMethodRec: Record "Transport Method";
//         IUOMG: Record "Item Unit of Measure";
//         AreaRec: Record "Area";
//         TransportMethod: Text[50];
//         UOMRec: Record 5404;
//         UOMVar: Text[100];
//         SalesLineMerge: Boolean;
//         Area1: Text[50];
//         ExporterCode: Text[50];
//         ImporterCode: Text[50];
//         CustomerRec: Record Customer;
//         GLSetup: Record "General Ledger Setup";
//         CountryRegionCode: Record "Country/Region";
//         BOE: Code[20];
//         BOEDescription: Text;
//         ItemTrackingLines: Record 337;
//         ShAgent: Record "Shipping Agent";
//         AgentName: Text[100];
//         Itm: Record Item;
//         TariffNo: Code[20];
//         ItemCRec: Record Item;
//         ICC: Text[100];
//         DANoCap: Label 'D.A.No.:';
//         ExporterCodeCap: Label 'Exporter Code:';
//         ImporterCodeCap: Label 'Importer Code:';
//         AgentNameCap: Label 'Agent Name:';
//         AgentCodeCap: Label 'Agent Code:';
//         RepCardNoCap: Label 'Rep.Card No.:';
//         ProductDetailsCap: Label 'Product Details';
//         TypeCap: Label 'Type';
//         QuantityCap: Label 'Quantity';
//         WeightCap: Label 'Weight  (KG)';
//         ContainerNo: Text;
//         VolumeCap: Label 'Volume (CBM)';
//         DescriptionofGoodsCap: Label 'Description of Goods';
//         ContainerNumbersCap: Label 'Container Numbers';
//         PaymentMethodCap: Label 'Payment Method (Mark where appropriate)';
//         CDRCashCap: Label 'CDR Cash';
//         CreditACCap: Label 'Credit A/C*';
//         FTTCap: Label 'F T T';
//         CDRBankCap: Label 'CDR Bank';
//         StanGCap: Label 'Stan G. *';
//         AlcoholCap: Label 'Alcohol';
//         DepositCap: Label 'Deposit';
//         BankGCap: Label 'Bank G. *';
//         OtherCap: Label 'Other';
//         RefACNo: Label 'Ref. A/C No. *';
//         CustomsBillTypeCap: Label 'Customs Bill Type (Mark where appropriate)';
//         ImportCap: Label 'Import';
//         TemporaryExitCap: Label 'Temporary Exit';
//         ExportCap: Label 'Export';
//         ImportforReExportCap: Label 'Import for Re-Export';
//         FreeZoneInternalTransferCap: Label 'FreeZone Internal Transfer';
//         ForCustomsUseCap: Label 'For Customs Use';
//         ExitPointCap: Label 'Exit Point:';
//         DestinationCap: Label 'Destination:';
//         CarrierAgentCap: Label 'Carrier Agent:';
//         ValueCap: Label 'Value:';
//         Text001: Label 'I/We declare the details given herein to be true & complete';
//         Text002: Label '* License Agent Stamp & Signature';
//         Text003: Label '* Importers Stamp & Signature';
//         Text004: Label '* Applicable only in case of Imports';
//         Text005: Label 'The Director,';
//         Text006: Label 'Dept. of Ports & Customs';
//         Text007: Label 'Please authorise release of the below mentioned goods from our warehouse to:';
//         DeliveryAdviceHeaderCap: Label 'DELIVERY ADVICE';
//         Checkbox1: Boolean;
//         CompanyInfo: Record "Company Information";
//         CountryRegion: Record "Country/Region";
//         CountryCode: Text[50];
//         CountryCode1: Text[50];
//         Pagecaption: Label 'Page ';

// }