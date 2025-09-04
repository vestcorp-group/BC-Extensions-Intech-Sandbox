// report 58001 "Payment Tracker Report"//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'Payment Tracker Report';
//     UsageCategory = ReportsAndAnalysis;
//     ProcessingOnly = true;
//     UseRequestPage = true;
//     requestpage
//     {
//         layout
//         {
//             area(content)
//             {
//                 group(General)
//                 {
//                     field(StartDate; StartDate)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'From';
//                     }
//                     field(EndDate; EndDate)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'To';

//                     }
//                     field(CompanyName; CompanyName)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Company';
//                         TableRelation = Company;
//                     }
//                     field(CustomerNo; VendorNo)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Vendor';
//                         TableRelation = Vendor;
//                     }
//                     field(GetDataFromOtherinstance; GetDataFromOtherinstance)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Include Data From India Instance';
//                     }
//                 }
//             }
//         }
//     }

//     trigger OnPreReport()
//     var

//     begin
//         Clear(PaymentTrackerG);
//         PaymentTrackerG.DeleteAll(true);
//     end;

//     trigger OnPostReport()
//     var
//         Response: Text;
//         TempBlob: Codeunit "Temp Blob";
//         Instr: InStream;
//         outStr: OutStream;
//         ExportGrossProfit: XmlPort GrossProfit;
//         ReplaceContent: Label '<Soap:Envelope xmlns:Soap="http://schemas.xmlsoap.org/soap/envelope/"><Soap:Body><RunReport_Result xmlns="urn:microsoft-dynamics-schemas/codeunit/GenerateGPReport"><return_value>';
//         ReplaceContent2: Label '</return_value></RunReport_Result></Soap:Body></Soap:Envelope>';
//     begin
//         if StartDate = 0D then
//             Error('From Date must have a value');
//         if EndDate = 0D then
//             Error('To Date must have a value');
//         RowNumber := 0;

//         CreateLinesFromPurchaseLine();
//         CreateLinesFromPurchaseLineFromArchive();

//         if not IsAPICall then begin
//             Commit();
//             //UpdateICInvoiceLineForUAESI();//updating COGS and charges in IC related Invoices for UAE ONLY
//         end;

//         /*if GetDataFromOtherinstance then begin
//             if CallApi(Response) then begin
//                 Clear(TempBlob);
//                 Clear(outStr);
//                 Clear(Instr);
//                 TempBlob.CreateOutStream(outStr);//, TEXTENCODING::UTF8
//                 Response := Response.Replace('&lt;', '<');
//                 Response := Response.Replace('&gt;', '>');
//                 Response := Response.Replace(ReplaceContent, '');
//                 Response := Response.Replace(ReplaceContent2, '');
//                 //Response := Response.Replace('<?xml version="1.0" encoding="UTF-8" standalone="no"?>', '');
//                 //Response := Response.Replace('<Root xmlns="urn:microsoft-dynamics-nav/xmlports/x54500">', '<Root>');
//                 //Message(Response);
//                 outStr.WriteText(Response);
//                 TempBlob.CreateInStream(Instr);
//                 Clear(ExportGrossProfit);
//                 ExportGrossProfit.SetEntryNumber(RowNumber);
//                 ExportGrossProfit.SetSource(Instr);
//                 ExportGrossProfit.Import();


//                 //commting inserted data to work on fetched rows for IC invoices and amount conversion
//                 Commit();
//                 // UpdateAmountForIndianInvoices();
//                 // UpdateICInvoiceLineForIndianSI();
//             end else
//                 Error(Response);
//         end;*/

//         if not IsAPICall then begin
//             //need to call API then run pages
//             //Create fields in company information for API URL and keys
//             Page.Run(Page::"Payment Tracker Report");

//         end;

//     end;

//     procedure InitializeReportParameter(StartDt: Date; EndDt: Date; IsAPI: Boolean)
//     begin
//         StartDate := StartDt;
//         EndDate := EndDt;
//         IsApiCall := IsAPI;
//     end;





//     local procedure CreateLinesFromPurchaseLine()
//     var
//         RecPurchaseHeader: Record "Purchase Header";
//         RecPurchaseLine: Record "Purchase Line";
//         Companies: Record Company;
//         ShortName: Record "Company Short Name";
//         ShortName2: Record "Company Short Name";
//         RecSalesPerson: Record "Salesperson/Purchaser";
//         RecItem: Record Item;
//         RecteamSalesPerson: Record "Team Salesperson";
//         RecVendorL: Record Vendor;
//         RecEntryExit: Record "Entry/Exit Point";
//         RecAre: Record "Area";
//         RecpurchaseInv: Record "Purch. Inv. Header";
//         RecpurchaseCrMemo: Record "Purch. Cr. Memo Hdr.";
//         VLE: Record "Vendor Ledger Entry";
//         VLE2: Record "Vendor Ledger Entry";
//         CrMemoAmt: Decimal;
//         SLine: Record "Sales Line";
//         SHeader: Record "Sales Header";
//     // RecSHeader: Record "Sales Header";
//     //Recteams: Record Team;
//     begin
//         Clear(POList);
//         Clear(Companies);
//         if CompanyName <> '' then
//             Companies.SetRange(Name, CompanyName);
//         Companies.FindSet();
//         repeat
//             Clear(ShortName);
//             ShortName.SetRange(Name, Companies.Name);
//             ShortName.SetRange("Block in Reports", true);
//             if not ShortName.FindFirst() then begin
//                 Clear(ShortName2);
//                 ShortName2.SetRange(Name, Companies.Name);
//                 ShortName2.FindFirst();
//                 Clear(RecPurchaseHeader);
//                 RecPurchaseHeader.ChangeCompany(Companies.Name);
//                 RecPurchaseHeader.SetRange("Document Type", RecPurchaseHeader."Document Type"::Order);
//                 RecPurchaseHeader.SetRange("Posting Date", StartDate, EndDate);
//                 if VendorNo <> '' then
//                     RecPurchaseHeader.SetRange("Buy-from Vendor No.", VendorNo)
//                 else
//                     RecPurchaseHeader.SetFilter("Buy-from Vendor No.", '<>%1', '');

//                 if RecPurchaseHeader.FindSet() then
//                 //coment
//                 begin
//                     repeat
//                         if not POList.Contains(RecPurchaseHeader."No.") then begin
//                             POList.Add(RecPurchaseHeader."No.");

//                             Clear(RecVendorL);
//                             RecVendorL.ChangeCompany(Companies.Name);
//                             RecVendorL.GET(RecPurchaseHeader."Buy-from Vendor No.");

//                             Clear(RecPurchaseLine);
//                             RecPurchaseLine.ChangeCompany(Companies.Name);
//                             RecPurchaseLine.SetRange("Document No.", RecPurchaseHeader."No.");
//                             RecPurchaseLine.SetRange("Document Type", RecPurchaseLine."Document Type"::Order);
//                             RecPurchaseLine.SetRange(Type, RecPurchaseLine.Type::Item);
//                             RecPurchaseLine.SetFilter("No.", '<>%1', '');
//                             if RecPurchaseLine.FindSet() then
//                             //coment
//                             begin
//                                 repeat

//                                     // if RecItem."Inventory Posting Group" <> 'SAMPLE' then begin
//                                     PaymentTrackerG.Init();
//                                     RowNumber += 1;
//                                     PaymentTrackerG."Entry No." := RowNumber;
//                                     PaymentTrackerG.Insert(true);
//                                     PaymentTrackerG."Comp." := ShortName2."Short Name";
//                                     //Clear(RecSHeader);
//                                     PaymentTrackerG."Order Date" := RecPurchaseHeader."Order Date";
//                                     PaymentTrackerG."PO No." := RecPurchaseHeader."No.";
//                                     PaymentTrackerG."Blanket Order No." := RecPurchaseLine."Blanket Order No.";
//                                     PaymentTrackerG."Vendor No." := RecPurchaseHeader."Buy-from Vendor No.";
//                                     PaymentTrackerG."Vendor Name" := RecPurchaseHeader."Buy-from Vendor Name";
//                                     PaymentTrackerG."Item No." := RecPurchaseLine."No.";
//                                     PaymentTrackerG."Item Description" := RecPurchaseLine.Description;

//                                     //Clear(RecItem);
//                                     //RecItem.ChangeCompany(Companies.Name);
//                                     // if RecItem.GET(RecPurchaseLine."Vendor Item No.") then
//                                     PaymentTrackerG."Vendor Item Name" := RecPurchaseLine."Vendor Item No.";//RecItem.Description;
//                                     PaymentTrackerG.Warehouse := RecPurchaseLine."Location Code";
//                                     PaymentTrackerG.Incoterm := RecPurchaseHeader."Transaction Specification";
//                                     if RecPurchaseHeader."Entry Point" <> '' then begin
//                                         Clear(RecEntryExit);
//                                         RecEntryExit.ChangeCompany(Companies.Name);
//                                         RecEntryExit.GET(RecPurchaseHeader."Entry Point");
//                                         PaymentTrackerG."POL Description" := RecEntryExit.Description;
//                                     end;
//                                     if RecPurchaseHeader."Area" <> '' then begin
//                                         Clear(RecAre);
//                                         RecAre.ChangeCompany(Companies.Name);
//                                         RecAre.GET(RecPurchaseHeader."Area");
//                                         PaymentTrackerG."POD Description" := RecAre."Text";
//                                     end;
//                                     PaymentTrackerG."Base UOM" := RecPurchaseLine."Base UOM";
//                                     PaymentTrackerG."Base UOM Qty." := RecPurchaseLine."Quantity (Base)";
//                                     PaymentTrackerG."Qty. Invoiced" := RecPurchaseLine."Quantity Invoiced";
//                                     PaymentTrackerG."GRN Quantity" := RecPurchaseLine."Quantity Received";
//                                     PaymentTrackerG."GRN Date" := RecPurchaseLine."Expected Receipt Date";//@@@@@@@@
//                                     PaymentTrackerG."Invoice Currency" := RecPurchaseHeader."Currency Code";//@@@@@@@
//                                     PaymentTrackerG."Unit Price" := RecPurchaseLine."Unit Price Base UOM";
//                                     RecPurchaseHeader.CalcFields("Amount Including VAT");
//                                     PaymentTrackerG."Invoice Value (with VAT)" := RecPurchaseHeader."Amount Including VAT";

//                                     if RecPurchaseLine."Quantity Received" = 0 then
//                                         PaymentTrackerG."Amount Payable (with VAT)" := RecPurchaseLine.Quantity * RecPurchaseLine."Unit Price Base UOM"
//                                     else
//                                         PaymentTrackerG."Amount Payable (with VAT)" := RecPurchaseLine."Quantity Received" * RecPurchaseLine."Unit Price Base UOM";
//                                     if RecPurchaseHeader."Currency Factor" <> 0 then
//                                         PaymentTrackerG."Amount Payable  (in AED)" := PaymentTrackerG."Amount Payable (with VAT)" / RecPurchaseHeader."Currency Factor"
//                                     else
//                                         PaymentTrackerG."Amount Payable  (in AED)" := PaymentTrackerG."Amount Payable (with VAT)";
//                                     PaymentTrackerG."Payment Term" := RecPurchaseHeader."Payment Terms Code";
//                                     PaymentTrackerG."Prepayment %" := RecPurchaseHeader."Prepayment %";
//                                     PaymentTrackerG."Prepayment Value" := (PaymentTrackerG."Amount Payable (with VAT)" * PaymentTrackerG."Prepayment %") / 100;
//                                     PaymentTrackerG."Due Date" := RecPurchaseHeader."Due Date";
//                                     Clear(RecpurchaseInv);
//                                     RecpurchaseInv.ChangeCompany(Companies.Name);
//                                     RecpurchaseInv.SetCurrentKey("Document Date");
//                                     RecpurchaseInv.SetAscending("Document Date", false);
//                                     RecpurchaseInv.SetRange("Order No.", RecPurchaseHeader."No.");
//                                     if RecpurchaseInv.FindFirst() then
//                                         PaymentTrackerG."Posted Purchase Invoice Date" := RecpurchaseInv."Document Date";
//                                     Clear(RecpurchaseInv);
//                                     RecpurchaseInv.ChangeCompany(Companies.Name);
//                                     RecpurchaseInv.SetRange("Order No.", RecPurchaseHeader."No.");
//                                     if RecpurchaseInv.FindSet() then begin
//                                         RecpurchaseInv.CalcFields("Amount Including VAT");
//                                         PaymentTrackerG."Posted Purchase Invoice Value" := RecpurchaseInv."Amount Including VAT";
//                                     end;

//                                     //BreakLoop := false;
//                                     Clear(RecpurchaseInv);
//                                     RecpurchaseInv.ChangeCompany(Companies.Name);
//                                     RecpurchaseInv.SetCurrentKey("Document Date");
//                                     RecpurchaseInv.SetAscending("Document Date", false);
//                                     RecpurchaseInv.SetRange("Order No.", RecPurchaseHeader."No.");
//                                     if RecpurchaseInv.FindSet() then begin
//                                         repeat
//                                             Clear(VLE);
//                                             VLE.ChangeCompany(Companies.Name);
//                                             VLE.SetRange("Document Type", VLE."Document Type"::Invoice);
//                                             VLE.SetRange("Document No.", RecpurchaseInv."No.");
//                                             VLE.SetFilter("Closed by Entry No.", '<>%1', 0);
//                                             if VLE.FindFirst() then begin
//                                                 Clear(VLE2);
//                                                 VLE2.ChangeCompany(Companies.Name);
//                                                 VLE2.GET(VLE."Closed by Entry No.");
//                                                 PaymentTrackerG."Posted Purch. Credit Memo Date" := VLE2."Posting Date";
//                                                 CrMemoAmt += VLE2.Amount;
//                                             end;
//                                         until RecpurchaseInv.Next() = 0;
//                                     end;
//                                     PaymentTrackerG."Posted Purch. Cred. Memo Value" := CrMemoAmt;

//                                     PaymentTrackerG."Balance payment" := PaymentTrackerG."Amount Payable (with VAT)" + PaymentTrackerG."Posted Purch. Cred. Memo Value";
//                                     PaymentTrackerG.ETD := RecPurchaseLine.CustomETD;
//                                     PaymentTrackerG.ETA := RecPurchaseLine.CustomETA;
//                                     PaymentTrackerG."R-ETD" := RecPurchaseLine.CustomR_ETD;
//                                     PaymentTrackerG."R-ETA" := RecPurchaseLine.CustomR_ETA;

//                                     PaymentTrackerG."SO No" := RecPurchaseLine."Sales Order No.";

//                                     Clear(SLine);
//                                     SLine.ChangeCompany(Companies.Name);
//                                     SLine.SetRange("Document Type", SLine."Document Type"::Order);
//                                     SLine.SetRange("Document No.", RecPurchaseLine."Sales Order No.");
//                                     SLine.SetFilter("Blanket Order No.", '<>%1', '');
//                                     if SLine.FindFirst() then begin
//                                         PaymentTrackerG."BSO No" := SLine."Blanket Order No.";
//                                         Clear(SHeader);
//                                         SHeader.ChangeCompany(Companies.Name);
//                                         SHeader.SetRange("Document Type", SHeader."Document Type"::Order);
//                                         SHeader.SetRange("No.", SLine."Document No.");
//                                         if SHeader.FindFirst() then begin
//                                             PaymentTrackerG."Sales Person" := SHeader."Salesperson Code";
//                                             PaymentTrackerG.Customer := SHeader."Sell-to Customer No.";
//                                         end;
//                                     end;

//                                     PaymentTrackerG.Modify(true);

//                                 until RecPurchaseLine.Next() = 0;
//                             end;
//                         end;
//                     until RecPurchaseHeader.Next() = 0;
//                 end;
//             end;
//         until Companies.Next() = 0;
//     end;

//     local procedure CreateLinesFromPurchaseLineFromArchive()
//     var
//         RecPurchaseHeader: Record "Purchase Header Archive";
//         RecPurchaseLine: Record "Purchase Line Archive";
//         Companies: Record Company;
//         ShortName: Record "Company Short Name";
//         ShortName2: Record "Company Short Name";
//         RecSalesPerson: Record "Salesperson/Purchaser";
//         RecItem: Record Item;
//         RecteamSalesPerson: Record "Team Salesperson";
//         RecVendorL: Record Vendor;
//         RecEntryExit: Record "Entry/Exit Point";
//         RecAre: Record "Area";
//         RecpurchaseInv: Record "Purch. Inv. Header";
//         RecpurchaseCrMemo: Record "Purch. Cr. Memo Hdr.";
//         VLE: Record "Vendor Ledger Entry";
//         VLE2: Record "Vendor Ledger Entry";
//         CrMemoAmt: Decimal;
//         SLine: Record "Sales Line";
//         SHeader: Record "Sales Header";
//     // RecSHeader: Record "Sales Header";
//     //Recteams: Record Team;
//     begin
//         Clear(POList);
//         Clear(Companies);
//         if CompanyName <> '' then
//             Companies.SetRange(Name, CompanyName);
//         Companies.FindSet();
//         repeat
//             Clear(ShortName);
//             ShortName.SetRange(Name, Companies.Name);
//             ShortName.SetRange("Block in Reports", true);
//             if not ShortName.FindFirst() then begin
//                 Clear(ShortName2);
//                 ShortName2.SetRange(Name, Companies.Name);
//                 ShortName2.FindFirst();
//                 Clear(RecPurchaseHeader);
//                 RecPurchaseHeader.ChangeCompany(Companies.Name);
//                 RecPurchaseHeader.SetRange("Document Type", RecPurchaseHeader."Document Type"::Order);
//                 RecPurchaseHeader.SetRange("Posting Date", StartDate, EndDate);
//                 if VendorNo <> '' then
//                     RecPurchaseHeader.SetRange("Buy-from Vendor No.", VendorNo)
//                 else
//                     RecPurchaseHeader.SetFilter("Buy-from Vendor No.", '<>%1', '');

//                 if RecPurchaseHeader.FindSet() then
//                 //coment
//                 begin
//                     repeat
//                         if not POList.Contains(RecPurchaseHeader."No.") then begin
//                             POList.Add(RecPurchaseHeader."No.");

//                             Clear(RecVendorL);
//                             RecVendorL.ChangeCompany(Companies.Name);
//                             RecVendorL.GET(RecPurchaseHeader."Buy-from Vendor No.");

//                             Clear(RecPurchaseLine);
//                             RecPurchaseLine.ChangeCompany(Companies.Name);
//                             RecPurchaseLine.SetRange("Document No.", RecPurchaseHeader."No.");
//                             RecPurchaseLine.SetRange("Document Type", RecPurchaseLine."Document Type"::Order);
//                             RecPurchaseLine.SetRange(Type, RecPurchaseLine.Type::Item);
//                             RecPurchaseLine.SetFilter("No.", '<>%1', '');
//                             if RecPurchaseLine.FindSet() then
//                             //coment
//                             begin
//                                 repeat

//                                     // if RecItem."Inventory Posting Group" <> 'SAMPLE' then begin
//                                     PaymentTrackerG.Init();
//                                     RowNumber += 1;
//                                     PaymentTrackerG."Entry No." := RowNumber;
//                                     PaymentTrackerG.Insert(true);
//                                     PaymentTrackerG."Comp." := ShortName2."Short Name";
//                                     //Clear(RecSHeader);
//                                     PaymentTrackerG."Order Date" := RecPurchaseHeader."Order Date";
//                                     PaymentTrackerG."PO No." := RecPurchaseHeader."No.";
//                                     PaymentTrackerG."Blanket Order No." := RecPurchaseLine."Blanket Order No.";
//                                     PaymentTrackerG."Vendor No." := RecPurchaseHeader."Buy-from Vendor No.";
//                                     PaymentTrackerG."Vendor Name" := RecPurchaseHeader."Buy-from Vendor Name";
//                                     PaymentTrackerG."Item No." := RecPurchaseLine."No.";
//                                     PaymentTrackerG."Item Description" := RecPurchaseLine.Description;
//                                     // Clear(RecItem);
//                                     // RecItem.ChangeCompany(Companies.Name);
//                                     // if RecItem.GET(RecPurchaseLine."Vendor Item No.") then
//                                     PaymentTrackerG."Vendor Item Name" := RecPurchaseLine."Vendor Item No.";//RecItem.Description;
//                                     PaymentTrackerG.Warehouse := RecPurchaseLine."Location Code";
//                                     PaymentTrackerG.Incoterm := RecPurchaseHeader."Transaction Specification";
//                                     if RecPurchaseHeader."Entry Point" <> '' then begin
//                                         Clear(RecEntryExit);
//                                         RecEntryExit.ChangeCompany(Companies.Name);
//                                         RecEntryExit.GET(RecPurchaseHeader."Entry Point");
//                                         PaymentTrackerG."POL Description" := RecEntryExit.Description;
//                                     end;
//                                     if RecPurchaseHeader."Area" <> '' then begin
//                                         Clear(RecAre);
//                                         RecAre.ChangeCompany(Companies.Name);
//                                         RecAre.GET(RecPurchaseHeader."Area");
//                                         PaymentTrackerG."POD Description" := RecAre."Text";
//                                     end;
//                                     PaymentTrackerG."Base UOM" := RecPurchaseLine."Unit of Measure Code";
//                                     PaymentTrackerG."Base UOM Qty." := RecPurchaseLine."Quantity (Base)";
//                                     PaymentTrackerG."Qty. Invoiced" := RecPurchaseLine."Quantity Invoiced";
//                                     PaymentTrackerG."GRN Quantity" := RecPurchaseLine."Quantity Received";
//                                     PaymentTrackerG."GRN Date" := RecPurchaseLine."Expected Receipt Date";//@@@@@@@@
//                                     PaymentTrackerG."Invoice Currency" := RecPurchaseHeader."Currency Code";//@@@@@@@
//                                     PaymentTrackerG."Unit Price" := RecPurchaseLine."Unit Cost";
//                                     RecPurchaseHeader.CalcFields("Amount Including VAT");
//                                     PaymentTrackerG."Invoice Value (with VAT)" := RecPurchaseHeader."Amount Including VAT";

//                                     if RecPurchaseLine."Quantity Received" = 0 then
//                                         PaymentTrackerG."Amount Payable (with VAT)" := RecPurchaseLine.Quantity * RecPurchaseLine."Unit Cost"
//                                     else
//                                         PaymentTrackerG."Amount Payable (with VAT)" := RecPurchaseLine."Quantity Received" * RecPurchaseLine."Unit Cost";
//                                     if RecPurchaseHeader."Currency Factor" <> 0 then
//                                         PaymentTrackerG."Amount Payable  (in AED)" := PaymentTrackerG."Amount Payable (with VAT)" / RecPurchaseHeader."Currency Factor"
//                                     else
//                                         PaymentTrackerG."Amount Payable  (in AED)" := PaymentTrackerG."Amount Payable (with VAT)";
//                                     PaymentTrackerG."Payment Term" := RecPurchaseHeader."Payment Terms Code";
//                                     PaymentTrackerG."Prepayment %" := RecPurchaseHeader."Prepayment %";
//                                     PaymentTrackerG."Prepayment Value" := (PaymentTrackerG."Amount Payable (with VAT)" * PaymentTrackerG."Prepayment %") / 100;
//                                     PaymentTrackerG."Due Date" := RecPurchaseHeader."Due Date";
//                                     Clear(RecpurchaseInv);
//                                     RecpurchaseInv.ChangeCompany(Companies.Name);
//                                     RecpurchaseInv.SetCurrentKey("Document Date");
//                                     RecpurchaseInv.SetAscending("Document Date", false);
//                                     RecpurchaseInv.SetRange("Order No.", RecPurchaseHeader."No.");
//                                     if RecpurchaseInv.FindFirst() then
//                                         PaymentTrackerG."Posted Purchase Invoice Date" := RecpurchaseInv."Document Date";
//                                     Clear(RecpurchaseInv);
//                                     RecpurchaseInv.ChangeCompany(Companies.Name);
//                                     RecpurchaseInv.SetRange("Order No.", RecPurchaseHeader."No.");
//                                     if RecpurchaseInv.FindSet() then begin
//                                         RecpurchaseInv.CalcFields("Amount Including VAT");
//                                         PaymentTrackerG."Posted Purchase Invoice Value" := RecpurchaseInv."Amount Including VAT";
//                                     end;

//                                     //BreakLoop := false;
//                                     Clear(RecpurchaseInv);
//                                     RecpurchaseInv.ChangeCompany(Companies.Name);
//                                     RecpurchaseInv.SetCurrentKey("Document Date");
//                                     RecpurchaseInv.SetAscending("Document Date", false);
//                                     RecpurchaseInv.SetRange("Order No.", RecPurchaseHeader."No.");
//                                     if RecpurchaseInv.FindSet() then begin
//                                         repeat
//                                             Clear(VLE);
//                                             VLE.ChangeCompany(Companies.Name);
//                                             VLE.SetRange("Document Type", VLE."Document Type"::Invoice);
//                                             VLE.SetRange("Document No.", RecpurchaseInv."No.");
//                                             VLE.SetFilter("Closed by Entry No.", '<>%1', 0);
//                                             if VLE.FindFirst() then begin
//                                                 Clear(VLE2);
//                                                 VLE2.ChangeCompany(Companies.Name);
//                                                 VLE2.GET(VLE."Closed by Entry No.");
//                                                 PaymentTrackerG."Posted Purch. Credit Memo Date" := VLE2."Posting Date";
//                                                 CrMemoAmt += VLE2.Amount;
//                                             end;
//                                         until RecpurchaseInv.Next() = 0;
//                                     end;
//                                     PaymentTrackerG."Posted Purch. Cred. Memo Value" := CrMemoAmt;


//                                     PaymentTrackerG."Balance payment" := PaymentTrackerG."Amount Payable (with VAT)" + PaymentTrackerG."Posted Purch. Cred. Memo Value";
//                                     PaymentTrackerG.ETD := RecPurchaseLine.CustomETD;
//                                     PaymentTrackerG.ETA := RecPurchaseLine.CustomETA;
//                                     PaymentTrackerG."R-ETD" := RecPurchaseLine.CustomR_ETD;
//                                     PaymentTrackerG."R-ETA" := RecPurchaseLine.CustomR_ETA;

//                                     PaymentTrackerG."SO No" := RecPurchaseLine."Sales Order No.";

//                                     Clear(SLine);
//                                     SLine.ChangeCompany(Companies.Name);
//                                     SLine.SetRange("Document Type", SLine."Document Type"::Order);
//                                     SLine.SetRange("Document No.", RecPurchaseLine."Sales Order No.");
//                                     SLine.SetFilter("Blanket Order No.", '<>%1', '');
//                                     if SLine.FindFirst() then begin
//                                         PaymentTrackerG."BSO No" := SLine."Blanket Order No.";
//                                         Clear(SHeader);
//                                         SHeader.ChangeCompany(Companies.Name);
//                                         SHeader.SetRange("Document Type", SHeader."Document Type"::Order);
//                                         SHeader.SetRange("No.", SLine."Document No.");
//                                         if SHeader.FindFirst() then begin
//                                             PaymentTrackerG."Sales Person" := SHeader."Salesperson Code";
//                                             PaymentTrackerG.Customer := SHeader."Sell-to Customer No.";
//                                         end;
//                                     end;

//                                     PaymentTrackerG.Modify(true);

//                                 until RecPurchaseLine.Next() = 0;
//                             end;
//                         end;
//                     until RecPurchaseHeader.Next() = 0;
//                 end;
//             end;
//         until Companies.Next() = 0;
//     end;


//     local procedure CallApi(var Response: Text): Boolean
//     var
//         HttpClient: HttpClient;
//         HttpResponse: HttpResponseMessage;
//         HttpHeadrs: HttpHeaders;
//         HttpContent: HttpContent;
//         ResponseJsonObject: JsonObject;
//         RecCompanyInformation: Record "Company Information";
//         TempBlob: Codeunit "Base64 Convert";
//         AuthString, BodyText : Text;
//         IsSuccess: Boolean;
//         EnvelopeData: Label '<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/"><Body><RunReport xmlns="urn:microsoft-dynamics-schemas/codeunit/GenerateGPReport"><startDt>%1</startDt><endDt>%2</endDt></RunReport></Body></Envelope>';
//         ResponseArray: array[1] of Text;
//     begin
//         Clear(IsSuccess);
//         RecCompanyInformation.GET;
//         RecCompanyInformation.TestField("Gross Profit Webservice URL");
//         RecCompanyInformation.TestField("Webserive Username");
//         RecCompanyInformation.TestField("Webservice Key");
//         RecCompanyInformation.TestField("Webservice Name");
//         AuthString := StrSubstNo('%1:%2', RecCompanyInformation."Webserive Username", RecCompanyInformation."Webservice Key");
//         AuthString := 'Basic ' + TempBlob.ToBase64(AuthString);
//         BodyText := StrSubstNo(EnvelopeData, FORMAT(StartDate, 0, '<Year4>-<Month,2>-<Day,2>'), FORMAT(EndDate, 0, '<Year4>-<Month,2>-<Day,2>'));
//         HttpClient.SetBaseAddress(RecCompanyInformation."Gross Profit Webservice URL");
//         HttpContent.WriteFrom(BodyText);
//         HttpClient.DefaultRequestHeaders.Add('Authorization', AuthString);
//         HttpContent.GetHeaders(HttpHeadrs);
//         HttpHeadrs.Remove('Content-Type');
//         HttpHeadrs.Add('Content-Type', 'application/xml');//; charset=utf-8');
//         HttpHeadrs.Add('SOAPACTION', 'urn:microsoft-dynamics-schemas/codeunit/' + RecCompanyInformation."Webservice Name" + ':RunReport');
//         HttpClient.DefaultRequestHeaders.Add('User-Agent', 'Dynamics 365');
//         HttpClient.DefaultRequestHeaders.TryAddWithoutValidation('Content-Type', 'application/xml');//; charset=utf-8
//         if HttpClient.Post(RecCompanyInformation."Gross Profit Webservice URL", HttpContent, HttpResponse) then begin
//             if HttpResponse.IsSuccessStatusCode() then begin
//                 HttpResponse.Content().ReadAs(Response);
//                 IsSuccess := true;
//             end else begin
//                 Response := HttpResponse.ReasonPhrase();
//                 //Response += 
//                 if HttpResponse.Headers.GetValues('NAV-Error', ResponseArray) then
//                     Response := Response + '\' + ResponseArray[1];
//                 IsSuccess := false;
//             end;
//         end else
//             Error('Something went wrong while connecting Business Central Instance. %1', HttpResponse.ReasonPhrase);
//         exit(IsSuccess);
//     end;









//     var
//         PaymentTrackerG: Record "Payment Tracker Report";
//         StartDate: Date;
//         EndDate: Date;
//         CompanyName: Text;
//         VendorNo: Code[20];
//         TotalSalesInvoiceLineAmount, CurrentLineAmount : Decimal;
//         IsAPICall: Boolean;
//         RowNumber: Integer;
//         GetDataFromOtherinstance: Boolean;
//         POList: List Of [Text];
// }
