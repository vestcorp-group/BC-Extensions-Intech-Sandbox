// codeunit 60010 "Generate E-Invoice"//T12370-N //T12574-MIG USING ISPL E-Invoice Ext.
// {
//     TableNo = "Sales Invoice Header";
//     Permissions = tabledata "Sales Invoice Header" = RIMD;
//     trigger OnRun()
//     var
//         RecSalesInvHdr: Record "Sales Invoice Header";
//         selection: Integer;
//     begin
//         if not Rec.Find then
//             Error('There is nothing to send for E-Invoicing.');

//         selection := StrMenu(OptionText, 1);
//         if selection = 2 then
//             IRNWithEway := true
//         else
//             IRNWithEway := false;

//         RecSalesInvHdr.Copy(Rec);
//         "Code"(RecSalesInvHdr);
//         Rec := RecSalesInvHdr;
//     end;

//     local procedure "Code"(var SIHdr: Record "Sales Invoice Header")
//     var
//         EInvoiceSetup: Record "E-Invoicing API Setup";
//         RecTransportMethod: Record "Transport Method";
//         IrisAPI: Codeunit "Iris Web service";
//         CheckvehicleNumber: Codeunit Regex;
//         BodyText: Text;
//         LoginJson: Label '{"email":"%1","password":"%2"}';
//         IsSuccess: Boolean;
//         ResponseText: Text;
//         Token: Text;
//         CompanyId: Text;
//         // Vehicleformat: Label '^[A-Z]{2}[0-9]{2}[A-Z]{2}[0-9]{4}$';
//         Vehicleformat: Label '^[A-Z]{2}[0-9]{2}$';
//         RecLocation: Record Location;
//         SLine: Record "Sales Line";
//     begin
//         EInvoiceSetup.GET;
//         EInvoiceSetup.TestField("User Id");
//         EInvoiceSetup.TestField(Password);
//         EInvoiceSetup.TestField("Base URL");
//         EInvoiceSetup.TestField("Login URL");
//         EInvoiceSetup.TestField("Invoice URL");
//         SIHdr.TestField("Transport Method");
//         //SIHdr.TestField("Transaction Mode");
//         // SIHdr.TestField("Transporter ID");
//         // SIHdr.TestField("Transporter Name");


//         if SIHdr."Transport Method" <> '' then begin
//             Clear(RecTransportMethod);
//             RecTransportMethod.GET(SIHdr."Transport Method");
//             RecTransportMethod.TestField("E-Invoice Code");
//             if RecTransportMethod."E-Invoice Code" = 'ROAD' then begin
//                 SIHdr.TestField("Vehicle Type");
//                 // SIHdr.TestField("Vehicle No.");
//                 // if SIHdr."Vehicle No." <> '' then begin
//                 //     if not CheckvehicleNumber.IsMatch(Copystr(SIHdr."Vehicle No.", 1, 4), Vehicleformat, 0) then
//                 //         Error('Vehicle No. is not valid. It must be in %1 format.', 'KA12KA1234');
//                 // end
//             end else begin
//                 SIHdr.TestField("Transport Doc No.");
//                 SIHdr.TestField("Transport Doc Date");
//             end;
//         end;

//         Clear(IsSuccess);
//         Clear(ResponseText);
//         Clear(IrisAPI);
//         Clear(Token);
//         IrisAPI.SetWebseriveProperties(EInvoiceSetup."Base URL" + EInvoiceSetup."Login URL", StrSubstNo(LoginJson, EInvoiceSetup."User Id", EInvoiceSetup.Password), true, '', '', false);
//         IrisAPI.Run();
//         IrisAPI.GetResponse(IsSuccess, ResponseText);
//         if IsSuccess then
//             Token := GetAPITokenFromResponse(ResponseText, CompanyId)
//         else
//             Error(ResponseText);
//         // Message(Token);//@@@@@@@@@@@@@@@@@@@@@@ TOKEN
//         Clear(ResponseText);
//         Clear(BodyText);

//         BodyText := CreateJSONForIRIS(SIHdr, false);//seding True for demo 

//         //Message(BodyText);//////////////@@@@@@@@@@@@@@@@@@@@@@@ TESTING 

//         Clear(IrisAPI);
//         IrisAPI.SetWebseriveProperties(EInvoiceSetup."Base URL" + EInvoiceSetup."Invoice URL", BodyText, false, Token, CompanyId, false);
//         IrisAPI.Run();
//         IrisAPI.GetResponse(IsSuccess, ResponseText);
//         if IsSuccess then
//             StoreIrisResponse(ResponseText, SIHdr)
//         else
//             Error(ResponseText);
//     end;

//     procedure CreateJSONForIRIS(var SIHdr: Record "Sales Invoice Header"; Isdemocall: Boolean): Text
//     var
//         JsonObject: JsonObject;
//         JsonObjectLines: JsonObject;
//         JsonArray: JsonArray;
//         JsonToken: JsonToken;
//         companyInfo: Record "Company Information";
//         GSTledgerentry: Record "Detailed GST Ledger Entry";
//         RecLines: Record "Sales Invoice Line";
//         JsonText: Text;
//         // RecCustomer: Record Customer;
//         RecState: Record State;
//         CalcStatistics: Codeunit "Calculate Statistics";
//         TotalInclTaxAmount: Decimal;
//         ItmVal: Decimal;
//         DemoGSTIN: Label '27AAACI9260R002';
//         DemoGSTIN2: Label '19AAACI9260R002';
//         RecIUOM: Record "Unit of Measure";
//         RecTransportMethod: Record "Transport Method";
//         RecCountry: Record "Country/Region";
//         GenLedSetup: Record "General Ledger Setup";
//         ShipToOptions: Option "Default (Sell-to Address)","Alternate Shipping Address","Custom Address";
//         BillToOptions: Option "Default (Customer)","Another Customer","Custom Address";
//         SVal: Decimal;
//         RecEntry: Record "Entry/Exit Point";
//         CurrencyExchangeRate: Record "Currency Exchange Rate";
//     begin
//         companyInfo.GET;

//         Clear(JsonObject);

//         if Isdemocall then
//             JsonObject.Add('userGstin', DemoGSTIN)
//         else
//             JsonObject.Add('userGstin', companyInfo."GST Registration No.");

//         if SIHdr."GST Bill-to State Code" = 'MH' then
//             JsonObject.Add('ntr', 'Intra')
//         else
//             JsonObject.Add('ntr', 'Inter');

//         JsonObject.Add('docType', 'RI');//C for credit notex


//         CalculateShipToBillToOptions(ShipToOptions, BillToOptions, SIHdr);
//         // if (ShipToOptions = ShipToOptions::"Default (Sell-to Address)") AND (SIHdr."Sell-to Country/Region Code" = 'IND') then
//         //     JsonObject.Add('trnTyp', 'REG')
//         // else
//         //     JsonObject.Add('trnTyp', 'SHP');
//         JsonObject.Add('trnTyp', FORMAT(SIHdr."Transaction Mode"));

//         JsonObject.Add('supplyType', 'O');

//         JsonObject.Add('no', SIHdr."No.");
//         JsonObject.Add('dt', FORMAT(SIHdr."Posting Date", 0, '<Day,2>-<Month,2>-<Year4>'));
//         if Isdemocall then
//             JsonObject.Add('sgstin', DemoGSTIN)
//         else
//             JsonObject.Add('sgstin', companyInfo."GST Registration No.");

//         JsonObject.Add('slglNm', CompanyProperty.DisplayName());//SIHdr."Sell-to Customer Name");
//         JsonObject.Add('sbnm', companyInfo.Address);// SIHdr."Sell-to Address");
//         JsonObject.Add('sloc', companyInfo.City);// SIHdr."Sell-to City");
//         JsonObject.Add('spin', DelChr(companyInfo."Post Code", '=', '-, '));

//         if companyInfo."State Code" <> '' then begin
//             Clear(RecState);
//             RecState.GET(companyInfo."State Code");
//             JsonObject.Add('sstcd', RecState."State Code (GST Reg. No.)");//state code
//         end;


//         //In case of inter-state outward supply, the place of supply should be different from the location of supplier
//         //if SIHdr."Location State Code" <> '' then begin


//         JsonObject.Add('blglNm', SIHdr."Sell-to Customer Name");
//         JsonObject.Add('bbnm', SIHdr."Sell-to Address");
//         JsonObject.Add('bloc', SIHdr."Sell-to City");

//         //need to test once
//         if SIHdr."Sell-to Country/Region Code" <> '' then begin
//             Clear(RecCountry);
//             RecCountry.GET(SIHdr."Sell-to Country/Region Code");
//             JsonObject.Add('cntcd', RecCountry."E-Invoice Code");
//         end;
//         if SIHdr."Sell-to Country/Region Code" <> 'IND' then begin

//             GSTledgerentry.Reset();
//             GSTledgerentry.SetRange("Document Type", GSTledgerentry."Document Type"::Invoice);
//             GSTledgerentry.SetRange("Transaction Type", GSTledgerentry."Transaction Type"::Sales);
//             GSTledgerentry.SetRange("Document No.", SIHdr."No.");
//             GSTledgerentry.SetFilter("Document Line No.", '<>0');
//             GSTledgerentry.SetRange("GST Component Code", 'IGST');
//             IF GSTledgerentry.FindSet() THEN begin
//                 GSTledgerentry.CalcSums("GST Amount");
//                 if Abs(GSTledgerentry."GST Amount") <> 0 then
//                     JsonObject.Add('catg', 'EXWP')
//                 else
//                     JsonObject.Add('catg', 'EXWOP')
//             end else
//                 JsonObject.Add('catg', 'EXWOP');


//             JsonObject.Add('bstcd', '96'); // sending harcoded value in case of out of india
//             JsonObject.Add('bpin', '999999'); // sending harcoded value in case of out of india
//             JsonObject.Add('pos', '96');
//             if Isdemocall then
//                 JsonObject.Add('bgstin', DemoGSTIN2)
//             else
//                 JsonObject.Add('bgstin', 'URP');

//         end else begin
//             JsonObject.Add('catg', 'B2B');
//             if Isdemocall then
//                 JsonObject.Add('bgstin', DemoGSTIN2)
//             else
//                 JsonObject.Add('bgstin', SIHdr."Customer GST Reg. No.");

//             if SIHdr."GST Bill-to State Code" <> '' then begin
//                 Clear(RecState);
//                 RecState.GET(SIHdr."GST Bill-to State Code");
//                 JsonObject.Add('bstcd', RecState."State Code (GST Reg. No.)");//state code
//             end;
//             //If transaction mode is Regular or Bill To - Ship To, then Dispatch From Trade Name should be blank
//             if SIHdr."Bill-to Post Code" <> '' then
//                 JsonObject.Add('bpin', DelChr(SIHdr."Bill-to Post Code", '=', '-, '))
//             else
//                 if SIHdr."Sell-to Post Code" <> '' then
//                     JsonObject.Add('bpin', DelChr(SIHdr."Sell-to Post Code", '=', '-, '));

//             if SIHdr."GST Bill-to State Code" = 'MH' then begin
//                 if SIHdr."Location State Code" <> '' then begin
//                     Clear(RecState);
//                     RecState.GET(SIHdr."Location State Code");
//                     JsonObject.Add('pos', RecState."State Code (GST Reg. No.)");
//                 end;
//             end else begin
//                 if SIHdr."GST Bill-to State Code" <> '' then begin
//                     Clear(RecState);
//                     RecState.GET(SIHdr."GST Bill-to State Code");
//                     JsonObject.Add('pos', RecState."State Code (GST Reg. No.)");//state code
//                 end else
//                     if SIHdr."Location State Code" <> '' then begin
//                         Clear(RecState);
//                         RecState.GET(SIHdr."Location State Code");
//                         JsonObject.Add('pos', RecState."State Code (GST Reg. No.)");
//                     end;
//             end;
//         end;

//         //if (ShipToOptions <> ShipToOptions::"Default (Sell-to Address)") AND (SIHdr."Sell-to Country/Region Code" = 'IND') then begin
//         if (SIHdr."Transaction Mode" <> SIHdr."Transaction Mode"::REG) AND (SIHdr."Sell-to Country/Region Code" = 'IND') then begin
//             JsonObject.Add('tolglNm', SIHdr."Ship-to Name");
//             JsonObject.Add('tobnm', SIHdr."Ship-to Address");

//             if SIHdr."Ship-to City" <> '' then
//                 JsonObject.Add('toloc', SIHdr."Ship-to City")
//             else
//                 if SIHdr."Ship-to Address 2" <> '' then
//                     JsonObject.Add('toloc', SIHdr."Ship-to Address 2");


//             if SIHdr."GST Ship-to State Code" <> '' then begin
//                 Clear(RecState);
//                 RecState.GET(SIHdr."GST Ship-to State Code");
//                 JsonObject.Add('tostcd', RecState."State Code (GST Reg. No.)");//state code
//             end else
//                 if SIHdr."GST Bill-to State Code" <> '' then begin
//                     Clear(RecState);
//                     RecState.GET(SIHdr."GST Bill-to State Code");
//                     JsonObject.Add('tostcd', RecState."State Code (GST Reg. No.)");//state code
//                 end;


//             if SIHdr."Ship-to GST Reg. No." <> '' then
//                 JsonObject.Add('togstin', SIHdr."Ship-to GST Reg. No.")
//             else
//                 JsonObject.Add('togstin', SIHdr."Customer GST Reg. No.");
//             if SIHdr."Ship-to Post Code" <> '' then
//                 JsonObject.Add('topin', DelChr(SIHdr."Ship-to Post Code", '=', '-, '))
//             else
//                 if SIHdr."Bill-to Post Code" <> '' then
//                     JsonObject.Add('topin', DelChr(SIHdr."Bill-to Post Code", '=', '-, '))
//                 else
//                     if SIHdr."Sell-to Post Code" <> '' then
//                         JsonObject.Add('topin', DelChr(SIHdr."Sell-to Post Code", '=', '-, '));


//         end else
//             if (SIHdr."Sell-to Country/Region Code" <> 'IND') then begin
//                 SIHdr.TestField("Exit Point");
//                 if SIHdr."Exit Point" <> '' then begin
//                     Clear(RecEntry);
//                     RecEntry.GET(SIHdr."Exit Point");

//                     JsonObject.Add('tolglNm', RecEntry.Description);
//                     JsonObject.Add('tobnm', RecEntry.Description);
//                     JsonObject.Add('toloc', RecEntry.Description);

//                     if RecEntry."State Code" <> '' then begin
//                         Clear(RecState);
//                         RecState.GET(RecEntry."State Code");
//                         JsonObject.Add('tostcd', RecState."State Code (GST Reg. No.)");//state code
//                     end;
//                     if RecEntry."Post code" <> '' then
//                         JsonObject.Add('topin', DelChr(RecEntry."Post code", '=', '-, '));
//                 end


//             end;

//         CalcStatistics.GetPostedsalesInvStatisticsAmount(SIHdr, TotalInclTaxAmount);

//         SIHdr.CalcFields("Amount Including VAT", "Invoice Discount Amount");
//         if (SIHdr."Currency Code" <> 'INR') AND (SIHdr."Currency Code" <> '') AND (SIHdr."Currency Factor" <> 0) then
//             JsonObject.Add('totinvval', TotalInclTaxAmount / SIHdr."Currency Factor")
//         else
//             JsonObject.Add('totinvval', TotalInclTaxAmount);

//         //need to test once
//         GenLedSetup.GET;
//         if SIHdr."Currency Code" <> '' then begin
//             if SIHdr."Currency Code" <> GenLedSetup."LCY Code" then begin
//                 JsonObject.Add('forCur', SIHdr."Currency Code");
//                 JsonObject.Add('invForCur', TotalInclTaxAmount);
//             end;
//         end;

//         Clear(RecLines);
//         RecLines.SetRange("Document No.", SIHdr."No.");
//         if RecLines.FindSet() then begin
//             RecLines.CalcSums("Line Discount Amount");
//             SIHdr.CalcFields("Amount Including VAT", "Invoice Discount Amount");
//             if (SIHdr."Currency Code" <> 'INR') AND (SIHdr."Currency Code" <> '') AND (SIHdr."Currency Factor" <> 0) then
//                 JsonObject.Add('totdisc', (SIHdr."Invoice Discount Amount" + RecLines."Line Discount Amount") / SIHdr."Currency Factor")
//             else
//                 JsonObject.Add('totdisc', SIHdr."Invoice Discount Amount" + RecLines."Line Discount Amount");
//         end else begin
//             if (SIHdr."Currency Code" <> 'INR') AND (SIHdr."Currency Code" <> '') AND (SIHdr."Currency Factor" <> 0) then
//                 JsonObject.Add('totdisc', SIHdr."Invoice Discount Amount" / SIHdr."Currency Factor")
//             else
//                 JsonObject.Add('totdisc', SIHdr."Invoice Discount Amount");
//         end;



//         Clear(RecLines);
//         RecLines.SetRange("Document No.", SIHdr."No.");
//         // RecLines.SetFilter(Type, '<>%1', RecLines.Type::Item);
//         // RecLines.SetFilter(Type, '<>%1,<>%2', RecLines.Type::Item, RecLines.Type::"Charge (Item)"); // added by B
//         RecLines.SetRange(Type, RecLines.Type::"G/L Account");
//         if RecLines.FindSet() then begin
//             RecLines.CalcSums("Amount Including VAT");
//             if (SIHdr."Currency Code" <> 'INR') AND (SIHdr."Currency Code" <> '') AND (SIHdr."Currency Factor" <> 0) then begin
//                 //JsonObject.Add('totothchrg', RecLines."Amount Including VAT" / SIHdr."Currency Factor");
//                 JsonObject.Add('tottxval', (SIHdr."Amount Including VAT" - RecLines."Amount Including VAT") / SIHdr."Currency Factor");
//             end else begin
//                 // JsonObject.Add('totothchrg', RecLines."Amount Including VAT");
//                 JsonObject.Add('tottxval', SIHdr."Amount Including VAT" - RecLines."Amount Including VAT");
//             end;

//         end else begin
//             if (SIHdr."Currency Code" <> 'INR') AND (SIHdr."Currency Code" <> '') AND (SIHdr."Currency Factor" <> 0) then
//                 JsonObject.Add('tottxval', SIHdr."Amount Including VAT" / SIHdr."Currency Factor")
//             else
//                 JsonObject.Add('tottxval', SIHdr."Amount Including VAT")
//         end;

//         //added by B
//         Clear(RecLines);
//         RecLines.SetRange("Document No.", SIHdr."No.");
//         // RecLines.SetFilter(Type, '<>%1', RecLines.Type::Item);
//         //RecLines.SetFilter(Type, '<>%1,<>%2', RecLines.Type::Item, RecLines.Type::"Charge (Item)");
//         RecLines.SetRange(Type, RecLines.Type::"G/L Account");
//         if RecLines.FindSet() then begin
//             RecLines.CalcSums("Amount Including VAT");
//             if (SIHdr."Currency Code" <> 'INR') AND (SIHdr."Currency Code" <> '') AND (SIHdr."Currency Factor" <> 0) then begin
//                 JsonObject.Add('totothchrg', RecLines."Amount Including VAT" / SIHdr."Currency Factor");
//             end else begin
//                 JsonObject.Add('totothchrg', RecLines."Amount Including VAT");

//             end;

//         end;

//         //added by B


//         GSTledgerentry.Reset();
//         GSTledgerentry.SetRange("Document Type", GSTledgerentry."Document Type"::Invoice);
//         GSTledgerentry.SetRange("Transaction Type", GSTledgerentry."Transaction Type"::Sales);
//         GSTledgerentry.SetRange("Document No.", SIHdr."No.");
//         GSTledgerentry.SetFilter("Document Line No.", '<>0');
//         GSTledgerentry.SetRange("GST Component Code", 'IGST');
//         IF GSTledgerentry.FindSet() THEN begin
//             GSTledgerentry.CalcSums("GST Amount");
//             if (SIHdr."Currency Code" <> 'INR') AND (SIHdr."Currency Code" <> '') AND (SIHdr."Currency Factor" <> 0) then
//                 JsonObject.Add('totiamt', ABS(GSTledgerentry."GST Amount") / SIHdr."Currency Factor")
//             else
//                 JsonObject.Add('totiamt', ABS(GSTledgerentry."GST Amount"))
//         end;

//         GSTledgerentry.Reset();
//         GSTledgerentry.SetRange("Document Type", GSTledgerentry."Document Type"::Invoice);
//         GSTledgerentry.SetRange("Transaction Type", GSTledgerentry."Transaction Type"::Sales);
//         GSTledgerentry.SetRange("Document No.", SIHdr."No.");
//         GSTledgerentry.SetFilter("Document Line No.", '<>0');
//         GSTledgerentry.SetRange("GST Component Code", 'CGST');
//         IF GSTledgerentry.FindSet() THEN begin
//             GSTledgerentry.CalcSums("GST Amount");

//             if (SIHdr."Currency Code" <> 'INR') AND (SIHdr."Currency Code" <> '') AND (SIHdr."Currency Factor" <> 0) then
//                 JsonObject.Add('totcamt', ABS(GSTledgerentry."GST Amount") / SIHdr."Currency Factor")
//             else
//                 JsonObject.Add('totcamt', ABS(GSTledgerentry."GST Amount"))
//         end;

//         GSTledgerentry.Reset();
//         GSTledgerentry.SetRange("Document Type", GSTledgerentry."Document Type"::Invoice);
//         GSTledgerentry.SetRange("Transaction Type", GSTledgerentry."Transaction Type"::Sales);
//         GSTledgerentry.SetRange("Document No.", SIHdr."No.");
//         GSTledgerentry.SetFilter("Document Line No.", '<>0');
//         GSTledgerentry.SetRange("GST Component Code", 'SGST');
//         IF GSTledgerentry.FindSet() THEN begin
//             GSTledgerentry.CalcSums("GST Amount");
//             if (SIHdr."Currency Code" <> 'INR') AND (SIHdr."Currency Code" <> '') AND (SIHdr."Currency Factor" <> 0) then
//                 JsonObject.Add('totsamt', ABS(GSTledgerentry."GST Amount") / SIHdr."Currency Factor")
//             else
//                 JsonObject.Add('totsamt', ABS(GSTledgerentry."GST Amount"))
//         end;

//         if SIHdr."Vehicle No." <> '' then begin
//             JsonObject.Add('transId', SIHdr."Transporter ID");
//             JsonObject.Add('transName', SIHdr."Transporter Name");
//         end;

//         if SIHdr."Sell-to Country/Region Code" = 'IND' then
//             JsonObject.Add('subSplyTyp', 'Supply')
//         else
//             JsonObject.Add('subSplyTyp', 'Export');

//         if SIHdr."Transport Method" <> '' then begin
//             Clear(RecTransportMethod);
//             RecTransportMethod.GET(SIHdr."Transport Method");
//             JsonObject.Add('transMode', RecTransportMethod."E-Invoice Code");

//             if RecTransportMethod."E-Invoice Code" = 'ROAD' then begin
//                 if (SIHdr."Vehicle Type" = SIHdr."Vehicle Type"::Regular) OR (SIHdr."Vehicle Type" = SIHdr."Vehicle Type"::" ") then
//                     JsonObject.Add('vehTyp', 'R')
//                 else
//                     if SIHdr."Vehicle Type" = SIHdr."Vehicle Type"::ODC then
//                         JsonObject.Add('vehTyp', '0');
//                 if SIHdr."Vehicle No." <> '' then
//                     JsonObject.Add('vehNo', SIHdr."Vehicle No.");

//             end else begin
//                 JsonObject.Add('transDocNo', SIHdr."Transport Doc No.");
//                 JsonObject.Add('transDocDate', FORMAT(SIHdr."Transport Doc Date", 0, '<Day,2>-<Month,2>-<Year4>'));
//             end;
//         end;

//         //dispatch details-start
//         if SIHdr."Dispatch From GSTIN" <> '' then
//             JsonObject.Add('dgstin', SIHdr."Dispatch From GSTIN");
//         if SIHdr."Dispatch From Trade Name" <> '' then
//             JsonObject.Add('dtrdNm', SIHdr."Dispatch From Trade Name");
//         if SIHdr."Dispatch From Legal Name" <> '' then
//             JsonObject.Add('dlglNm', SIHdr."Dispatch From Legal Name");
//         if SIHdr."Dispatch From Address 1" <> '' then
//             JsonObject.Add('dbnm', SIHdr."Dispatch From Address 1");
//         if SIHdr."Dispatch From Address 2" <> '' then
//             JsonObject.Add('dflno', SIHdr."Dispatch From Address 2");
//         if SIHdr."Dispatch From Location" <> '' then
//             JsonObject.Add('dloc', SIHdr."Dispatch From Location");

//         if SIHdr."Dispatch From State Code" <> '' then begin
//             Clear(RecState);
//             RecState.GET(SIHdr."Dispatch From State Code");
//             JsonObject.Add('dstcd', RecState."State Code (GST Reg. No.)");//state code
//         end;
//         if SIHdr."Dispatch From Pincode" <> '' then
//             JsonObject.Add('dpin', DelChr(SIHdr."Dispatch From Location", '=', '-, '));
//         //dispatch details-end

//         JsonObject.Add('transDist', SIHdr."Distance (Km)");
//         JsonObject.Add('taxSch', 'GST');
//         JsonObject.Add('genIrn', true);
//         if IRNWithEway then
//             JsonObject.Add('genewb', 'Y')
//         else
//             JsonObject.Add('genewb', 'N');
//         JsonObject.Add('signedDataReq', true);
//         Clear(JsonArray);
//         Clear(ItmVal);
//         Clear(RecLines);
//         RecLines.SetRange("Document No.", SIHdr."No.");
//         RecLines.SetRange(Type, RecLines.Type::Item, RecLines.Type::"Charge (Item)");
//         if RecLines.FindSet() then begin
//             repeat
//                 Clear(JsonObjectLines);
//                 if RecLines.Type = RecLines.Type::"Charge (Item)" then begin
//                     JsonObjectLines.Add('hsnCd', DelChr(RecLines."HSN/SAC Code", '=', '.,-/\ '));
//                 end else begin
//                     JsonObjectLines.Add('hsnCd', DelChr(RecLines.HSNCode, '=', '.,-/\ '));
//                 end;
//                 JsonObjectLines.Add('prdNm', RecLines.Description);
//                 JsonObjectLines.Add('prdDesc', RecLines.Description);
//                 JsonObjectLines.Add('num', RecLines."Line No.");

//                 JsonObjectLines.Add('qty', FORMAT(RecLines."Quantity (Base)", 0, '<Precision,2:2><Standard Format,2>'));
//                 if RecLines."Base UOM 2" <> '' then begin
//                     Clear(RecIUOM);
//                     if RecIUOM.GET(RecLines."Base UOM 2") then begin
//                         JsonObjectLines.Add('unit', RecIUOM."E-Invoice Code");
//                     end;
//                 end;

//                 if (SIHdr."Currency Code" <> 'INR') AND (SIHdr."Currency Code" <> '') AND (SIHdr."Currency Factor" <> 0) then
//                     JsonObjectLines.Add('unitPrice', RecLines."Unit Price Base UOM 2" / SIHdr."Currency Factor")
//                 else
//                     JsonObjectLines.Add('unitPrice', RecLines."Unit Price Base UOM 2");

//                 Clear(SVal);
//                 SVal := RecLines."Unit Price Base UOM 2" * RecLines."Quantity (Base)";

//                 if (SIHdr."Currency Code" <> 'INR') AND (SIHdr."Currency Code" <> '') AND (SIHdr."Currency Factor" <> 0) then
//                     SVal := SVal / SIHdr."Currency Factor";


//                 JsonObjectLines.Add('sval', FORMAT(SVal, 0, '<Precision,2:2><Standard Format,2>'));

//                 if (SIHdr."Currency Code" <> 'INR') AND (SIHdr."Currency Code" <> '') AND (SIHdr."Currency Factor" <> 0) then
//                     JsonObjectLines.Add('txval', RecLines.Amount / SIHdr."Currency Factor")
//                 else
//                     JsonObjectLines.Add('txval', RecLines.Amount);


//                 ItmVal := RecLines."Amount Including VAT";


//                 GSTledgerentry.Reset();
//                 GSTledgerentry.SetRange("Document Type", GSTledgerentry."Document Type"::Invoice);
//                 GSTledgerentry.SetRange("Transaction Type", GSTledgerentry."Transaction Type"::Sales);
//                 GSTledgerentry.SetRange("Document No.", SIHdr."No.");
//                 GSTledgerentry.SetRange("Document Line No.", RecLines."Line No.");
//                 GSTledgerentry.SetRange("No.", RecLines."No.");
//                 GSTledgerentry.SetRange("GST Component Code", 'IGST');
//                 IF GSTledgerentry.FindSet() THEN begin
//                     JsonObjectLines.Add('irt', GSTledgerentry."GST %");
//                     ItmVal += ABS(GSTledgerentry."GST Amount");
//                     if (SIHdr."Currency Code" <> 'INR') AND (SIHdr."Currency Code" <> '') AND (SIHdr."Currency Factor" <> 0) then
//                         JsonObjectLines.Add('iamt', ABS(GSTledgerentry."GST Amount") / SIHdr."Currency Factor")
//                     else
//                         JsonObjectLines.Add('iamt', ABS(GSTledgerentry."GST Amount"));
//                 end else
//                     if SIHdr."Sell-to Country/Region Code" <> 'IND' then
//                         JsonObjectLines.Add('irt', 0);

//                 GSTledgerentry.Reset();
//                 GSTledgerentry.SetRange("Document Type", GSTledgerentry."Document Type"::Invoice);
//                 GSTledgerentry.SetRange("Transaction Type", GSTledgerentry."Transaction Type"::Sales);
//                 GSTledgerentry.SetRange("Document No.", SIHdr."No.");
//                 GSTledgerentry.SetRange("Document Line No.", RecLines."Line No.");
//                 GSTledgerentry.SetRange("No.", RecLines."No.");
//                 GSTledgerentry.SetRange("GST Component Code", 'CGST');
//                 IF GSTledgerentry.FindSet() THEN begin
//                     JsonObjectLines.Add('crt', GSTledgerentry."GST %");
//                     ItmVal += ABS(GSTledgerentry."GST Amount");

//                     if (SIHdr."Currency Code" <> 'INR') AND (SIHdr."Currency Code" <> '') AND (SIHdr."Currency Factor" <> 0) then
//                         JsonObjectLines.Add('camt', ABS(GSTledgerentry."GST Amount") / SIHdr."Currency Factor")
//                     else
//                         JsonObjectLines.Add('camt', ABS(GSTledgerentry."GST Amount"));
//                 end;
//                 GSTledgerentry.Reset();
//                 GSTledgerentry.SetRange("Document Type", GSTledgerentry."Document Type"::Invoice);
//                 GSTledgerentry.SetRange("Transaction Type", GSTledgerentry."Transaction Type"::Sales);
//                 GSTledgerentry.SetRange("Document No.", SIHdr."No.");
//                 GSTledgerentry.SetRange("Document Line No.", RecLines."Line No.");
//                 GSTledgerentry.SetRange("No.", RecLines."No.");
//                 GSTledgerentry.SetRange("GST Component Code", 'SGST');
//                 IF GSTledgerentry.FindSet() THEN begin
//                     JsonObjectLines.Add('srt', GSTledgerentry."GST %");
//                     ItmVal += ABS(GSTledgerentry."GST Amount");

//                     if (SIHdr."Currency Code" <> 'INR') AND (SIHdr."Currency Code" <> '') AND (SIHdr."Currency Factor" <> 0) then
//                         JsonObjectLines.Add('samt', ABS(GSTledgerentry."GST Amount") / SIHdr."Currency Factor")
//                     else
//                         JsonObjectLines.Add('samt', ABS(GSTledgerentry."GST Amount"));
//                 end;

//                 if (SIHdr."Currency Code" <> 'INR') AND (SIHdr."Currency Code" <> '') AND (SIHdr."Currency Factor" <> 0) then
//                     ItmVal := ItmVal / SIHdr."Currency Factor";
//                 JsonObjectLines.Add('itmVal', ItmVal);
//                 //Need to test it once
//                 if RecLines.LineCountryOfOrigin <> '' then begin
//                     Clear(RecCountry);
//                     RecCountry.Get(RecLines.LineCountryOfOrigin);
//                     JsonObjectLines.Add('orgCntry', RecCountry."E-Invoice Code");
//                 end;

//                 JsonArray.Add(JsonObjectLines);
//             until RecLines.Next() = 0;
//         end;
//         JsonObject.Add('itemList', JsonArray);
//         JsonObject.WriteTo(JsonText);
//         exit(JsonText);
//     end;

//     procedure GetAPITokenFromResponse(APIResponse: Text; var companyId: Text): Text
//     var
//         JsonObject: JsonObject;
//         JsonArray: JsonArray;
//         JsonToken: JsonToken;
//     begin
//         if JsonObject.ReadFrom(APIResponse) then begin
//             JsonObject.Get('status', JsonToken);
//             if JsonToken.AsValue().AsCode() = 'SUCCESS' then begin
//                 JsonObject.Get('response', JsonToken);
//                 JsonObject := JsonToken.AsObject();
//                 JsonObject.Get('companyid', JsonToken);
//                 companyId := JsonToken.AsValue().AsText();
//                 JsonObject.Get('token', JsonToken);
//                 exit(JsonToken.AsValue().AsText());
//             end else begin
//                 JsonObject.Get('message', JsonToken);
//                 Error(JsonToken.AsValue().AsText());
//             end;
//         end else
//             Error('Something went wrong while connecting Iris server. Please check E-Invoicing Setup');
//     end;

//     local procedure StoreIrisResponse(ResponseText: Text; var SIHdr: Record "Sales Invoice Header")
//     var
//         JsonObject: JsonObject;
//         JsonArray: JsonArray;
//         JsonToken: JsonToken;
//         OutStr: OutStream;
//         InStr: InStream;
//         Dt: DateTime;
//         JsonToken1: JsonToken;
//         MessageDisplayed: Boolean;
//     begin
//         if JsonObject.ReadFrom(ResponseText) then begin
//             if JsonObject.Get('status', JsonToken) then begin
//                 if JsonToken.AsValue().AsCode() = 'SUCCESS' then begin
//                     SIHdr."E-Invoice API Status" := SIHdr."E-Invoice API Status"::Success;
//                     JsonObject.Get('response', JsonToken);
//                     JsonObject := JsonToken.AsObject();

//                     Clear(OutStr);
//                     if JsonObject.Get('qrCode', JsonToken) then begin
//                         if not JsonToken.AsValue().IsNull then begin
//                             SIHdr."E-Invoice QR Code".CreateOutStream(OutStr);
//                             JsonToken.AsValue().WriteTo(OutStr);
//                         end;
//                     end;

//                     if JsonObject.Get('no', JsonToken) then begin
//                         if not JsonToken.AsValue().IsNull then
//                             SIHdr."E-Invoice No." := JsonToken.AsValue().AsText();
//                     end;

//                     if JsonObject.Get('id', JsonToken) then begin
//                         if not JsonToken.AsValue().IsNull then
//                             SIHdr."E-Invoice Id" := JsonToken.AsValue().AsText();
//                     end;


//                     if JsonObject.Get('genBy', JsonToken) then begin
//                         if not JsonToken.AsValue().IsNull then
//                             SIHdr."E-Invoice genBy" := JsonToken.AsValue().AsText();
//                     end;


//                     if JsonObject.Get('genByName', JsonToken) then begin
//                         if not JsonToken.AsValue().IsNull then
//                             SIHdr."E-Invoice GenBy Name" := JsonToken.AsValue().AsText();
//                     end;


//                     if JsonObject.Get('status', JsonToken) then begin
//                         if not JsonToken.AsValue().IsNull then
//                             SIHdr."E-Invoice status" := JsonToken.AsValue().AsText();
//                     end;


//                     if JsonObject.Get('ackNo', JsonToken) then begin
//                         if not JsonToken.AsValue().IsNull then
//                             SIHdr."E-Invoice ACK No." := JsonToken.AsValue().AsText();
//                         SIHdr."Acknowledgement No." := SIHdr."E-Invoice ACK No.";
//                     end;

//                     if JsonObject.Get('ackDt', JsonToken) then begin
//                         if not JsonToken.AsValue().IsNull then begin
//                             Evaluate(dt, JsonToken.AsValue().AsText());
//                             SIHdr."E-Invoice Ack Date" := dt;
//                             SIHdr."Acknowledgement Date" := dt;
//                         end;
//                     end;

//                     if JsonObject.Get('irn', JsonToken) then begin
//                         if not JsonToken.AsValue().IsNull then
//                             SIHdr."E-Invoice IRN" := JsonToken.AsValue().AsText();
//                         SIHdr."IRN Hash" := SIHdr."E-Invoice IRN";
//                     end;


//                     Clear(OutStr);
//                     if JsonObject.Get('signedInvoice', JsonToken) then begin
//                         if not JsonToken.AsValue().IsNull then begin
//                             SIHdr."E-Invoice Signed Invoice".CreateOutStream(OutStr);
//                             JsonToken.AsValue().WriteTo(OutStr);
//                         end;
//                     end;

//                     Clear(OutStr);
//                     JsonObject.Get('signedQrCode', JsonToken);
//                     if not JsonToken.AsValue().IsNull then begin
//                         SIHdr."E-Invoice signedQrCode".CreateOutStream(OutStr);
//                         JsonToken.AsValue().WriteTo(OutStr);
//                     end;

//                     if JsonObject.Get('EwbNo', JsonToken) then begin
//                         if not JsonToken.AsValue().IsNull then
//                             SIHdr."E-Invoice EWB No." := JsonToken.AsValue().AsText();
//                         SIHdr."E-Way Bill No." := SIHdr."E-Invoice EWB No.";
//                     end;

//                     if JsonObject.Get('EwbDt', JsonToken) then begin
//                         if not JsonToken.AsValue().IsNull then begin
//                             Evaluate(dt, JsonToken.AsValue().AsText());
//                             SIHdr."E-Invoice EWB Date" := dt;
//                         end;
//                     end;



//                     if JsonObject.Get('EwbValidTill', JsonToken) then begin
//                         if not JsonToken.AsValue().IsNull then begin
//                             Evaluate(dt, JsonToken.AsValue().AsText());
//                             SIHdr."E-Invoice EWB Valid Till" := dt;
//                         end;
//                     end;
//                     Clear(MessageDisplayed);
//                     if JsonObject.Get('errors', JsonToken) then begin
//                         JsonArray := JsonToken.AsArray();
//                         if JsonArray.Count <> 0 then begin

//                             foreach JsonToken in JsonArray do begin
//                                 if JsonToken.AsObject().Get('msg', JsonToken1) then begin
//                                     SIHdr."E-Invoice API Response" := copystr(JsonToken1.AsValue().AsText(), 1, 499);
//                                     Message(JsonToken1.AsValue().AsText() + '\ Please rectify the error and try to send E-Invoice again if required.');
//                                     MessageDisplayed := true;
//                                 end;
//                             end;
//                         end
//                         else begin
//                             JsonObject.Get('message', JsonToken);
//                             Error(JsonToken.AsValue().AsText());
//                         end;
//                     end;
//                     if not MessageDisplayed then begin
//                         SIHdr."E-Invoice API Response" := 'E-Invoice has been generated successfully.';
//                         Message('E-Invoice has been generated successfully.');
//                     end;

//                     SIHdr.Modify();
//                 end else begin
//                     if JsonObject.Get('errors', JsonToken) then begin
//                         JsonArray := JsonToken.AsArray();
//                         if JsonArray.Count <> 0 then begin
//                             JsonArray.WriteTo(ResponseText);
//                             Message(ResponseText);
//                         end
//                         else begin
//                             JsonObject.Get('message', JsonToken);
//                             Error(JsonToken.AsValue().AsText());
//                         end;
//                     end else begin
//                         JsonObject.Get('message', JsonToken);
//                         Error(JsonToken.AsValue().AsText());
//                     end;
//                 end
//             end else begin
//                 if JsonObject.Get('errors', JsonToken) then begin
//                     JsonArray := JsonToken.AsArray();
//                     if JsonArray.Count <> 0 then begin
//                         JsonArray.WriteTo(ResponseText);
//                         Message(ResponseText);
//                     end
//                     else begin
//                         JsonObject.Get('message', JsonToken);
//                         Error(JsonToken.AsValue().AsText());
//                     end;
//                 end else begin
//                     JsonObject.Get('message', JsonToken);
//                     Error(JsonToken.AsValue().AsText());
//                 end;
//             end;
//         end else
//             Error('Something went wrong while connecting Iris server. Please check E-Invoicing Setup');
//     end;



//     procedure CalculateShipToBillToOptions(var ShipToOptions: Option "Default (Sell-to Address)","Alternate Shipping Address","Custom Address"; var BillToOptions: Option "Default (Customer)","Another Customer","Custom Address"; var SalesHeader: Record "Sales Invoice Header")
//     var
//         ShipToNameEqualsSellToName: Boolean;
//     begin
//         ShipToNameEqualsSellToName :=
//   (SalesHeader."Ship-to Name" = SalesHeader."Sell-to Customer Name") and (SalesHeader."Ship-to Name 2" = SalesHeader."Sell-to Customer Name 2");

//         case true of
//             (SalesHeader."Ship-to Code" = '') and ShipToNameEqualsSellToName and ShipToAddressEqualsSellToAddress(SalesHeader):
//                 ShipToOptions := ShipToOptions::"Default (Sell-to Address)";
//             (SalesHeader."Ship-to Code" = '') and
//           (not ShipToNameEqualsSellToName or not ShipToAddressEqualsSellToAddress(SalesHeader)):
//                 ShipToOptions := ShipToOptions::"Custom Address";
//             SalesHeader."Ship-to Code" <> '':
//                 ShipToOptions := ShipToOptions::"Alternate Shipping Address";
//         end;
//     end;

//     procedure ShipToAddressEqualsSellToAddress(var SalesHeader: Record "Sales Invoice Header"): Boolean
//     begin
//         exit(IsShipToAddressEqualToSellToAddress(SalesHeader, SalesHeader));
//     end;

//     local procedure IsShipToAddressEqualToSellToAddress(SalesHeaderWithSellTo: Record "Sales Invoice Header"; SalesHeaderWithShipTo: Record "Sales Invoice Header"): Boolean
//     var
//         Result: Boolean;
//     begin
//         Result :=
//           (SalesHeaderWithSellTo."Sell-to Address" = SalesHeaderWithShipTo."Ship-to Address") and
//           (SalesHeaderWithSellTo."Sell-to Address 2" = SalesHeaderWithShipTo."Ship-to Address 2") and
//           (SalesHeaderWithSellTo."Sell-to City" = SalesHeaderWithShipTo."Ship-to City") and
//           (SalesHeaderWithSellTo."Sell-to County" = SalesHeaderWithShipTo."Ship-to County") and
//           (SalesHeaderWithSellTo."Sell-to Post Code" = SalesHeaderWithShipTo."Ship-to Post Code") and
//           (SalesHeaderWithSellTo."Sell-to Country/Region Code" = SalesHeaderWithShipTo."Ship-to Country/Region Code") and
//           (SalesHeaderWithSellTo."Sell-to Contact" = SalesHeaderWithShipTo."Ship-to Contact");
//         exit(Result);
//     end;

//     var
//         IRNWithEway: Boolean;
//         OptionText: Label 'Generate IRN,Generate IRN with E-Way';
// }
