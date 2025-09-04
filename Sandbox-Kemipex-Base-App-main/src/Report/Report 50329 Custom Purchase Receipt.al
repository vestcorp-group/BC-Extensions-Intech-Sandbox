// //Add the report link in "Report Selection - Purchase"...original id is 408 //T12370-Full Comment
// report 50329 "Custom Purchase - Receipt"
// {
//     // version NAVW113.00
//     DefaultLayout = RDLC;
//     RDLCLayout = './Layouts/Custom Purchase - Receipt New.rdl';
//     Caption = 'Purchase - Receipt';
//     PreviewMode = PrintLayout;

//     dataset
//     {
//         dataitem("Purch. Rcpt. Header"; "Purch. Rcpt. Header")
//         {
//             DataItemTableView = SORTING("No.");
//             RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
//             RequestFilterHeading = 'Posted Purchase Receipt';
//             column(CustomBOENumber; CustomBOENumber)
//             { }
//             column(countrydesc; countrydesc) { }
//             column(Pay_to_Address; "Pay-to Address")
//             { }
//             column(Pay_to_Address_2; "Pay-to Address 2") { }
//             column(Pay_to_City; "Pay-to City") { }
//             column(Pay_to_Country_Region_Code; "Pay-to Country/Region Code") { }
//             column(Pay_to_Post_Code; "Pay-to Post Code") { }
//             column(Pay_to_Name; "Pay-to Name") { }
//             column(No_PurchRcptHeader; "No.")
//             {
//             }
//             column(Vendor_Invoice_No_; "Vendor Invoice No.")
//             {

//             }
//             column(CompName; CompanyInfo.Name)
//             {

//             }
//             column(Document_Date; format("Posting Date", 0, '<Day,2>-<Month Text>-<year4>'))
//             {

//             }
//             column(RemarksCap; RemarksCap)
//             {

//             }
//             column(SalesPurchPersonName; SalesPurchPerson."Short Name")
//             {
//             }
//             column(DocDateCaption; DocDateCaptionLbl)
//             {
//             }
//             column(RecDateCaption; RecDateCaptionLbl)
//             {
//             }
//             column(PageCaption; PageCaptionLbl)
//             {
//             }
//             column(DescCaption; DescCaptionLbl)
//             {
//             }
//             column(QtyCaption; QtyCaptionLbl)
//             {
//             }
//             column(UOMCaption; UOMCaptionLbl)
//             {
//             }
//             column(PaytoVenNoCaption; PaytoVenNoCaptionLbl)
//             {
//             }
//             column(EmailCaption; EmailCaptionLbl)
//             {
//             }
//             column(Order_No_; "Order No.")
//             {
//             }
//             column(ShipmentDocCaptionLbl; ShipmentDocCaptionLbl)
//             { }
//             column(PurchaseOrderCaptionLbl; PurchaseOrderCaptionLbl)
//             { }
//             column(Vendor_Shipment_No; "Purch. Rcpt. Header"."Vendor Shipment No.")
//             { }
//             column(RecDate_PurchRcptHeader; FORMAT("Purch. Rcpt. Header"."Posting Date", 0, 4))
//             { }
//             column(PaytoVenNo_PurchRcptHeader; "Purch. Rcpt. Header"."Pay-to Vendor No.")
//             {
//             }
//             column(Supplier_Invoice_Date1; "Supplier Invoice Date") { }
//             column(Supplier_Invoice_Date; format("Supplier Invoice Date", 0, '<Day,2>-<Month Text>-<year4>')) { }
//             column(Buy_from_Contact; "Buy-from Contact") { }
//             dataitem(Total2; Integer)
//             {
//                 DataItemTableView = SORTING(Number)
//                                             WHERE(Number = CONST(1));
//                 column(VendAddr1; VendAddr[1])
//                 {
//                 }
//                 column(VendAddr2; VendAddr[2])
//                 {
//                 }
//                 column(VendAddr3; VendAddr[3])
//                 {
//                 }
//                 column(VendAddr4; VendAddr[4])
//                 {
//                 }
//                 column(VendAddr5; VendAddr[5])
//                 {
//                 }
//                 column(VendAddr6; VendAddr[6])
//                 {
//                 }
//                 column(VendAddr7; VendAddr[7])
//                 {
//                 }
//                 column(VendAddr8; VendAddr[8])
//                 {
//                 }
//                 column(PaytoAddrCaption; PaytoAddrCaptionLbl)
//                 {
//                 }
//                 column(PaytoVenNo_PurchRcptHeaderCaption; "Purch. Rcpt. Header".FIELDCAPTION("Pay-to Vendor No."))
//                 {
//                 }
//             }
//             dataitem(CopyLoop; Integer)
//             {
//                 DataItemTableView = SORTING(Number);
//                 dataitem(PageLoop; Integer)
//                 {
//                     DataItemTableView = SORTING(Number)
//                                         WHERE(Number = CONST(1));
//                     column(PurchRcptCopyText; STRSUBSTNO(Text002, CopyText))
//                     {
//                     }
//                     // column(CurrentReportPageNo; STRSUBSTNO(Text003, FORMAT(CurrReport.PAGENO)))
//                     // {
//                     // }
//                     column(ShipToAddr1; ShipToAddr[1])
//                     {
//                     }
//                     column(CompanyAddr1; CompanyAddr[1])
//                     {
//                     }
//                     column(ShipToAddr2; ShipToAddr[2])
//                     {
//                     }
//                     column(CompanyAddr2; CompanyAddr[2])
//                     {
//                     }
//                     column(ShipToAddr3; ShipToAddr[3])
//                     {
//                     }
//                     column(CompanyAddr3; CompanyAddr[3])
//                     {
//                     }
//                     column(ShipToAddr4; ShipToAddr[4])
//                     {
//                     }
//                     column(CompanyAddr4; CompanyAddr[4])
//                     {
//                     }
//                     column(ShipToAddr5; ShipToAddr[5])
//                     {
//                     }
//                     column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
//                     {
//                     }

//                     column(ShipToAddr6; ShipToAddr[6])
//                     {
//                     }
//                     column(CompanyInfoHomePage; CompanyInfo."Home Page")
//                     {
//                     }
//                     column(CompanyInfoEmail; CompanyInfo."E-Mail")
//                     {
//                     }
//                     column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
//                     {
//                     }
//                     column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
//                     {
//                     }
//                     column(CompanyInfoBankName; CompanyInfo."Bank Name")
//                     {
//                     }
//                     column(CompanyInfoBankAccNo; CompanyInfo."Bank Account No.")
//                     {
//                     }
//                     column(PurchaserText; PurchaserText)
//                     {
//                     }

//                     column(No1_PurchRcptHeader; "Purch. Rcpt. Header"."No.")
//                     {
//                     }
//                     column(ReferenceText; ReferenceText)
//                     {
//                     }
//                     column(YourRef_PurchRcptHeader; "Purch. Rcpt. Header"."Your Reference")
//                     {
//                     }
//                     column(DocDate_PurchRcptHeader; format("Purch. Rcpt. Header"."Document Date", 0, '<Day,2>-<Month Text>-<year4>'))
//                     {

//                     }
//                     column(ShipToAddr7; ShipToAddr[7])
//                     {
//                     }
//                     column(ShipToAddr8; ShipToAddr[8])
//                     {
//                     }
//                     column(CompanyAddr5; CompanyAddr[5])
//                     {
//                     }
//                     column(CompanyAddr6; CompanyAddr[6])
//                     {
//                     }
//                     column(OutputNo; OutputNo)
//                     {
//                     }
//                     column(PhoneNoCaption; PhoneNoCaptionLbl)
//                     {
//                     }
//                     column(HomePageCaption; HomePageCaptionLbl)
//                     {
//                     }
//                     column(VATRegNoCaption; VATRegNoCaptionLbl)
//                     {
//                     }
//                     column(GiroNoCaption; GiroNoCaptionLbl)
//                     {
//                     }
//                     column(BankNameCaption; BankNameCaptionLbl)
//                     {
//                     }
//                     column(AccNoCaption; AccNoCaptionLbl)
//                     {
//                     }
//                     column(ShipmentNoCaption; ShipmentNoCaptionLbl)
//                     {
//                     }

//                     dataitem(DimensionLoop1; Integer)
//                     {
//                         DataItemLinkReference = "Purch. Rcpt. Header";
//                         DataItemTableView = SORTING(Number)
//                                             WHERE(Number = FILTER(1 ..));
//                         column(DimText; DimText)
//                         {
//                         }

//                         column(HeaderDimCaption; HeaderDimCaptionLbl)
//                         {
//                         }

//                         trigger OnAfterGetRecord()
//                         begin
//                             IF Number = 1 THEN BEGIN
//                                 IF NOT DimSetEntry1.FINDSET THEN
//                                     CurrReport.BREAK;
//                             END ELSE
//                                 IF NOT Continue THEN
//                                     CurrReport.BREAK;

//                             CLEAR(DimText);
//                             Continue := FALSE;
//                             REPEAT
//                                 OldDimText := DimText;
//                                 IF DimText = '' THEN
//                                     DimText := STRSUBSTNO('%1 - %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
//                                 ELSE
//                                     DimText :=
//                                       STRSUBSTNO(
//                                         '%1; %2 - %3', DimText,
//                                         DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
//                                 IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
//                                     DimText := OldDimText;
//                                     Continue := TRUE;
//                                     EXIT;
//                                 END;
//                             UNTIL DimSetEntry1.NEXT = 0;
//                         end;

//                         trigger OnPreDataItem()
//                         begin
//                             IF NOT ShowInternalInfo THEN
//                                 CurrReport.BREAK;
//                         end;
//                     }
//                     dataitem("Purch. Rcpt. Line"; "Purch. Rcpt. Line")
//                     {
//                         DataItemLinkReference = "Purch. Rcpt. Header";
//                         DataItemLink = "Document No." = FIELD("No.");
//                         DataItemTableView = SORTING("Document No.", "Line No.") where(Quantity = filter(> 0));

//                         column(Net_Weight; "Net Weight") { }
//                         column(Gross_Weight; "Gross Weight") { }
//                         column(ShowInternalInfo; ShowInternalInfo)
//                         {
//                         }
//                         column(Lotwise_GrossWeight; GrossWeightG) { }
//                         column(TotalGrossWeightG; TotalGrossWeightG) { }
//                         column(GrossTotalG; GrossTotalG) { }
//                         column(Origitext; Origitext)
//                         { }
//                         column(Type_PurchRcptLine; FORMAT(Type, 0, 2))
//                         {
//                         }
//                         column(Quantity_MT; Quantity)
//                         {

//                         }
//                         column(Line_No_; "Line No.") { }
//                         column(Desc_PurchRcptLine; Description)
//                         {
//                             IncludeCaption = false;
//                         }
//                         column(Qty_PurchRcptLine; Quantity)
//                         {
//                             IncludeCaption = false;
//                         }

//                         column(UOM_PurchRcptLine; "Unit of Measure")
//                         {
//                             IncludeCaption = false;
//                         }
//                         column(No_PurchRcptLine; "No.")
//                         {
//                         }
//                         column(DocNo_PurchRcptLine; "Document No.")
//                         {
//                         }
//                         column(LineNo_PurchRcptLine; "Line No.")
//                         {
//                             IncludeCaption = false;
//                         }
//                         column(No_PurchRcptLineCaption; FIELDCAPTION("No."))
//                         { }
//                         column(Location_Code; "Location Code")
//                         { }
//                         column(Generic_Name_; Item.GenericName)
//                         { }
//                         column(Item_GenericDesc; Item."Generic Description")
//                         {

//                         }
//                         column(Packing; Item."Description 2") { }
//                         /* column(Origin_; Item."Country/Region of Origin Code")
//                         { } */
//                         column(Origin_; Origitext)
//                         { }
//                         column(HS_Code_; Item."Tariff No.")
//                         { }

//                         column(Item_Unitofmeasure; UOMCodeG)
//                         {

//                         }
//                         column(Netweight; IUOMG."Net Weight" / ("Quantity (Base)" / IUOMG."Qty. per Unit of Measure"))

//                         { }
//                         column(Grossweight; IUOMG."Packing Weight" / ("Quantity (Base)" / IUOMG."Qty. per Unit of Measure"))
//                         {

//                         }
//                         dataitem(DimensionLoop2; Integer)
//                         {
//                             DataItemTableView = SORTING(Number)
//                                                 WHERE(Number = FILTER(1 ..));
//                             column(DimText1; DimText)
//                             {
//                             }
//                             column(LineDimCaption; LineDimCaptionLbl)
//                             {
//                             }

//                             trigger OnAfterGetRecord()
//                             begin
//                                 IF Number = 1 THEN BEGIN
//                                     IF NOT DimSetEntry2.FINDSET THEN
//                                         CurrReport.BREAK;
//                                 END ELSE
//                                     IF NOT Continue THEN
//                                         CurrReport.BREAK;

//                                 CLEAR(DimText);
//                                 Continue := FALSE;
//                                 REPEAT
//                                     OldDimText := DimText;
//                                     IF DimText = '' THEN
//                                         DimText := STRSUBSTNO('%1 - %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
//                                     ELSE
//                                         DimText :=
//                                           STRSUBSTNO(
//                                             '%1; %2 - %3', DimText,
//                                             DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
//                                     IF STRLEN(DimText) > MAXSTRLEN(OldDimText) THEN BEGIN
//                                         DimText := OldDimText;
//                                         Continue := TRUE;
//                                         EXIT;
//                                     END;
//                                 UNTIL DimSetEntry2.NEXT = 0;
//                             end;

//                             trigger OnPreDataItem()
//                             begin
//                                 IF NOT ShowInternalInfo THEN
//                                     CurrReport.BREAK;
//                             end;
//                         }
//                         dataitem(ItemLedgEntry; "Item Ledger Entry")
//                         {
//                             DataItemTableView = where("Entry Type" = filter(Purchase), "Document Type" = filter("Purchase Receipt"), Quantity = filter(> 0));
//                             DataItemLinkReference = "Purch. Rcpt. Line";
//                             DataItemLink = "Document No." = field("Document No."), "Document Line No." = field("Line No.");
//                             column(Lot_No; CustomLotNumber)
//                             { }
//                             /* column(Lotwise_NetWeight; ("Purch. Rcpt. Line"."Net Weight" / "Purch. Rcpt. Line".Quantity) * Quantity)
//                             { } */
//                             column(Lotwise_NetWeight; (Quantity / IUOMG."Qty. per Unit of Measure") * IUOMG."Net Weight") { }
//                             /* column(Lotwise_GrossWeight; ("Purch. Rcpt. Line"."Gross Weight" / "Purch. Rcpt. Line".Quantity) * Quantity)
//                             { } */

//                             column(Quantity__Base_; Quantity / UOMQuantityG) { }

//                         }

//                         trigger OnAfterGetRecord()
//                         var
//                             CountryRegRec: Record "Country/Region";
//                             ItemUoML: Record "Item Unit of Measure";
//                             UnitofMeasureL: Record "Unit of Measure";
//                             IUOML: Record "Item Unit of Measure";
//                         begin
//                             IF (NOT ShowCorrectionLines) AND Correction THEN
//                                 CurrReport.SKIP;

//                             DimSetEntry2.SETRANGE("Dimension Set ID", "Dimension Set ID");
//                             if Type = Type::Item then
//                                 Item.Get("No.");
//                             Clear(ItemLedgerEntry);
//                             ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Purchase);
//                             ItemLedgerEntry.SetRange("Document Type", ItemLedgerEntry."Document Type"::"Purchase Receipt");
//                             ItemLedgerEntry.SetRange("Document No.", "Purch. Rcpt. Header"."No.");
//                             ItemLedgerEntry.SetRange("Document Line No.", "Purch. Rcpt. Line"."Line No.");
//                             if ItemLedgerEntry.FindFirst() then
//                                 ;

//                             Clear(IUOMG);
//                             IUOMG.SetCurrentKey("Item No.", "Qty. per Unit of Measure");
//                             IUOMG.SetRange("Item No.", "No.");
//                             If IUOMG.FindFirst() then
//                                 ;

//                             Origitext := '';
//                             CountryRegRec.Reset();
//                             IF CountryRegRec.Get(Item."Country/Region of Origin Code") then
//                                 Origitext := CountryRegRec.Name
//                             else
//                                 Origitext := '';

//                             clear(NetweightG);
//                             Clear(GrossWeightG);
//                             CalculateNetAndGrossWeight("Unit of Measure Code", "No.", Quantity, NetweightG, GrossWeightG);

//                             GrossTotalG += GrossWeightG;

//                             Clear(UOMCodeG);
//                             Clear(UOMQuantityG);
//                             ItemUoML.Reset();
//                             ItemUoML.SetCurrentKey("Item No.", "Qty. per Unit of Measure");
//                             ItemUoML.Ascending(true);
//                             ItemUoML.SetRange("Item No.", "No.");
//                             if ItemUoML.FindSet() then
//                                 repeat
//                                     UnitofMeasureL.Get(ItemUoML.Code);
//                                     if not UnitofMeasureL."Decimal Allowed" then begin
//                                         UOMCodeG := ItemUoML.Code;
//                                         UOMQuantityG := ItemUoML."Qty. per Unit of Measure";
//                                         exit;
//                                     end;
//                                 until ItemUoML.Next() = 0;

//                             if UOMQuantityG = 0 then begin
//                                 Clear(UOMCodeG);
//                                 Clear(UOMCodeG);
//                                 IUOML.Reset();
//                                 IUOML.SetCurrentKey("Item No.", "Qty. per Unit of Measure");
//                                 IUOML.SetRange("Item No.", "No.");
//                                 If IUOML.FindFirst() then begin
//                                     UOMQuantityG := IUOML."Qty. per Unit of Measure";
//                                     UOMCodeG := IUOML.Code;
//                                 end;
//                             end;

//                         end;

//                         trigger OnPreDataItem()
//                         begin
//                             MoreLines := FIND('+');
//                             WHILE MoreLines AND (Description = '') AND ("No." = '') AND (Quantity = 0) DO
//                                 MoreLines := NEXT(-1) <> 0;
//                             IF NOT MoreLines THEN
//                                 CurrReport.BREAK;
//                             SETRANGE("Line No.", 0, "Line No.");
//                         end;
//                     }
//                     dataitem(Total; Integer)
//                     {
//                         DataItemTableView = SORTING(Number)
//                                             WHERE(Number = CONST(1));
//                         column(BuyfromVenNo_PurchRcptHeader; "Purch. Rcpt. Header"."Buy-from Vendor No.")
//                         {
//                         }
//                         column(BuyfromVenNo_PurchRcptHeaderCaption; "Purch. Rcpt. Header".FIELDCAPTION("Buy-from Vendor No."))
//                         {
//                         }

//                         trigger OnPreDataItem()
//                         begin
//                             IF "Purch. Rcpt. Header"."Buy-from Vendor No." = "Purch. Rcpt. Header"."Pay-to Vendor No." THEN
//                                 CurrReport.BREAK;
//                         end;
//                     }

//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     IF Number > 1 THEN BEGIN
//                         CopyText := FormatDocument.GetCOPYText;
//                         OutputNo += 1;
//                     END;
//                     // CurrReport.PAGENO := 1;
//                 end;

//                 trigger OnPostDataItem()
//                 begin
//                     IF NOT IsReportInPreviewMode THEN
//                         CODEUNIT.RUN(CODEUNIT::"Purch.Rcpt.-Printed", "Purch. Rcpt. Header");
//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     OutputNo := 1;

//                     NoOfLoops := ABS(NoOfCopies) + 1;
//                     CopyText := '';
//                     SETRANGE(Number, 1, NoOfLoops);
//                 end;
//             }
//             dataitem("Purchase Remark"; "Purchase Remark Archieve")
//             {
//                 DataItemLink = "No." = FIELD("No.");
//                 DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST(Receipt), "Document Line No." = FILTER(0));

//                 column(Remark; Remark)
//                 {
//                 }
//                 column(SNo; SNo)
//                 {

//                 }
//                 trigger OnAfterGetRecord()
//                 var
//                     myInt: Integer;
//                 begin
//                     SNo += 1;
//                 end;

//                 trigger OnPreDataItem()
//                 var
//                     myInt: Integer;
//                 begin
//                     SNo := 0;
//                 end;
//             }


//             trigger OnAfterGetRecord()
//             begin
//                 if CountryG.Get("Pay-to Country/Region Code") then
//                     countrydesc := CountryG.Name
//                 else
//                     countrydesc := '';

//                 FormatAddressFields("Purch. Rcpt. Header");
//                 FormatDocumentFields("Purch. Rcpt. Header");

//                 DimSetEntry1.SETRANGE("Dimension Set ID", "Dimension Set ID");
//             end;
//         }
//     }

//     requestpage
//     {
//         SaveValues = true;

//         layout
//         {
//             area(content)
//             {
//                 group(Options)
//                 {
//                     Caption = 'Options';
//                     field(NoOfCopies; NoOfCopies)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'No. of Copies';
//                         ToolTip = 'Specifies how many copies of the document to print.';
//                     }
//                     field(ShowInternalInfo; ShowInternalInfo)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Show Internal Information';
//                         ToolTip = 'Specifies if you want the printed report to show information that is only for internal use.';
//                     }
//                     field(LogInteraction; LogInteraction)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Log Interaction';
//                         Enabled = LogInteractionEnable;
//                         ToolTip = 'Specifies if you want the program to log this interaction.';
//                     }
//                     field(ShowCorrectionLines; ShowCorrectionLines)
//                     {
//                         ApplicationArea = Basic, Suite;
//                         Caption = 'Show Correction Lines';
//                         ToolTip = 'Specifies if the correction lines of an undoing of quantity posting will be shown on the report.';
//                     }
//                 }
//             }
//         }

//         actions
//         {
//         }

//         trigger OnInit()
//         begin
//             LogInteractionEnable := TRUE;
//         end;

//         trigger OnOpenPage()
//         begin
//             InitLogInteraction;
//             LogInteractionEnable := LogInteraction;
//         end;
//     }

//     labels
//     {
//     }

//     trigger OnInitReport()
//     begin
//         CompanyInfo.GET;

//     end;

//     trigger OnPostReport()
//     begin
//         IF LogInteraction AND NOT IsReportInPreviewMode THEN
//             IF "Purch. Rcpt. Header".FINDSET THEN
//                 REPEAT
//                     SegManagement.LogDocument(
//                       15, "Purch. Rcpt. Header"."No.", 0, 0, DATABASE::Vendor, "Purch. Rcpt. Header"."Buy-from Vendor No.",
//                       "Purch. Rcpt. Header"."Purchaser Code",
//                       '', "Purch. Rcpt. Header"."Posting Description", '');
//                 UNTIL "Purch. Rcpt. Header".NEXT = 0;
//     end;

//     trigger OnPreReport()
//     begin
//         IF NOT CurrReport.USEREQUESTPAGE THEN
//             InitLogInteraction;
//     end;

//     var
//         countrydesc: Text;
//         CompanyName: Text[50];
//         Text002: Label 'Purchase - Receipt %1', Comment = '%1 = Document No.';
//         Text003: Label 'Page %1';
//         CompanyInfo: Record "Company Information";
//         SalesPurchPerson: Record "Salesperson/Purchaser";
//         DimSetEntry1: Record "Dimension Set Entry";
//         DimSetEntry2: Record "Dimension Set Entry";
//         Language1: Record Language;
//         RespCenter: Record "Responsibility Center";
//         ItemLedgerEntry: Record "Item Ledger Entry";
//         Item: Record item;
//         IUOMG: Record "Item Unit of Measure";
//         ILEG: Record "Item Ledger Entry";
//         RemarksCap: Label 'Remarks:';
//         NetweightG: Decimal;
//         GrossWeightG: Decimal;
//         TotalGrossWeightG: Decimal;
//         QuantityG: Decimal;
//         Qty: Decimal;
//         FormatAddr: Codeunit "Format Address";
//         FormatDocument: Codeunit "Format Document";
//         languageCU: Codeunit Language;
//         SegManagement: Codeunit SegManagement;
//         VendAddr: array[8] of Text[50];
//         ShipToAddr: array[8] of Text[50];
//         CompanyAddr: array[8] of Text[50];
//         PurchaserText: Text[30];
//         Origitext: Text;
//         UOMQuantityG: Decimal;
//         UOMCodeG: Code[10];
//         GrossTotalG: Decimal;
//         ReferenceText: Text[80];
//         MoreLines: Boolean;
//         NoOfCopies: Integer;
//         NoOfLoops: Integer;
//         SNo: Integer;
//         PurchaseRemarksArchieve: Record "Purchase Remark Archieve";
//         CopyText: Text[30];
//         CountryG: Record "Country/Region";
//         DimText: Text[120];
//         OldDimText: Text[75];
//         ShowInternalInfo: Boolean;
//         EventSubscriberUnitG: Codeunit KMP_EventSubscriberUnit;
//         Continue: Boolean;
//         LogInteraction: Boolean;
//         ShowCorrectionLines: Boolean;
//         OutputNo: Integer;
//         [InDataSet]
//         LogInteractionEnable: Boolean;
//         PhoneNoCaptionLbl: Label 'Phone No.';
//         HomePageCaptionLbl: Label 'Home Page';
//         VATRegNoCaptionLbl: Label 'VAT Registration No.';
//         GiroNoCaptionLbl: Label 'Giro No.';
//         BankNameCaptionLbl: Label 'Bank';
//         AccNoCaptionLbl: Label 'Account No.';
//         ShipmentNoCaptionLbl: Label 'Puchase Receipt No.';
//         HeaderDimCaptionLbl: Label 'Header Dimensions';
//         LineDimCaptionLbl: Label 'Line Dimensions';
//         PaytoAddrCaptionLbl: Label 'Pay-to Address';
//         DocDateCaptionLbl: Label 'Document Date';
//         RecDateCaptionLbl: Label 'Purchase Receipt Date';
//         PageCaptionLbl: Label 'Page';
//         DescCaptionLbl: Label 'Description';
//         QtyCaptionLbl: Label 'Quantity';
//         UOMCaptionLbl: Label 'Unit Of Measure';
//         PaytoVenNoCaptionLbl: Label 'Pay-to Vendor No.';
//         EmailCaptionLbl: Label 'Email';
//         PurchaseOrderCaptionLbl: Label 'Purchase Order';
//         ShipmentDocCaptionLbl: Label 'Shipment Document';

//     procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; NewShowCorrectionLines: Boolean)
//     begin
//         NoOfCopies := NewNoOfCopies;
//         ShowInternalInfo := NewShowInternalInfo;
//         LogInteraction := NewLogInteraction;
//         ShowCorrectionLines := NewShowCorrectionLines;
//     end;

//     local procedure InitLogInteraction()
//     begin
//         LogInteraction := SegManagement.FindInteractTmplCode(15) <> '';
//     end;

//     local procedure IsReportInPreviewMode(): Boolean
//     var
//         MailManagement: Codeunit "Mail Management";
//     begin
//         EXIT(CurrReport.PREVIEW OR MailManagement.IsHandlingGetEmailBody);
//     end;

//     local procedure FormatAddressFields(var PurchRcptHeader: Record "Purch. Rcpt. Header")
//     begin
//         FormatAddr.GetCompanyAddr(PurchRcptHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
//         FormatAddr.PurchRcptShipTo(ShipToAddr, PurchRcptHeader);
//         FormatAddr.PurchRcptPayTo(VendAddr, PurchRcptHeader);
//     end;

//     local procedure FormatDocumentFields(PurchRcptHeader: Record "Purch. Rcpt. Header")
//     begin
//         FormatDocument.SetPurchaser(SalesPurchPerson, PurchRcptHeader."Purchaser Code", PurchaserText);

//         ReferenceText := FormatDocument.SetText(PurchRcptHeader."Your Reference" <> '', PurchRcptHeader.FIELDCAPTION("Your Reference"));
//     end;

//     procedure CalculateNetAndGrossWeight(UnitOfMeasureCodeP: code[20]; ItemNoP: Code[20]; QuantityP: Decimal; var NetWeightP: Decimal; var GrossWeightP: Decimal): Boolean
//     var
//         ItemUoML: Record "Item Unit of Measure";
//         UnitofMeasureL: Record "Unit of Measure";
//         BaseUOMQtyL: Decimal;
//     begin
//         if not UnitofMeasureL.Get(UnitOfMeasureCodeP) then
//             exit(false);
//         /*  if UnitofMeasureL."Decimal Allowed" then
//              exit(false); */
//         ItemUoML.Get(ItemNoP, UnitOfMeasureCodeP);
//         NetWeightP := QuantityP * ItemUoML."Net Weight";
//         // if NetWeightP < 100 then
//         //     exit(false);
//         GrossWeightP := NetWeightP;
//         BaseUOMQtyL := QuantityP * ItemUoML."Qty. per Unit of Measure";
//         ItemUoML.Reset();
//         ItemUoML.SetCurrentKey("Item No.", "Qty. per Unit of Measure");
//         ItemUoML.Ascending(true);
//         ItemUoML.SetRange("Item No.", ItemNoP);
//         /* if NetWeightP < 100 then begin
//             if ItemUoML.FindFirst() then
//                 GrossWeightP += Round(BaseUOMQtyL / ItemUoML."Qty. per Unit of Measure", 1, '>') * ItemUoML."Packing Weight";
//         end else */
//         if ItemUoML.FindSet() then
//             repeat
//                 UnitofMeasureL.Get(ItemUoML.Code);
//                 if not UnitofMeasureL."Decimal Allowed" then
//                     GrossWeightP += (NetWeightP / ItemUoML."Net Weight") * ItemUoML."Packing Weight";
//             //GrossWeightP += Round(QuantityP / ItemUoML."Qty. per Unit of Measure", 1, '>') * ItemUoML."Packing Weight";
//             until ItemUoML.Next() = 0;
//         exit(true);
//     end;

// }

