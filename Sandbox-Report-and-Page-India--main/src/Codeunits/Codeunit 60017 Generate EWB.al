// codeunit 60017 "Generate EWB"//T12370-N //T12574-MIG USING ISPL E-Invoice Ext.
// {
//     TableNo = "Sales Invoice Header";
//     Permissions = tabledata "Sales Invoice Header" = RIMD;
//     trigger OnRun()
//     var
//         RecSalesInvHdr: Record "Sales Invoice Header";
//     begin
//         if not Rec.Find then
//             Error('There is nothing to send for E-Invoicing.');

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
//         //Vehicleformat: Label '^[A-Z]{2}[0-9]{2}[A-Z]{2}[0-9]{4}$';
//         Vehicleformat: Label '^[A-Z]{2}[0-9]{2}$';
//     begin
//         EInvoiceSetup.GET;
//         EInvoiceSetup.TestField("User Id");
//         EInvoiceSetup.TestField(Password);
//         EInvoiceSetup.TestField("Base URL");
//         EInvoiceSetup.TestField("Login URL");
//         EInvoiceSetup.TestField("Generate EWB URL");
//         SIHdr.TestField("Transport Method");
//         if SIHdr."Transport Method" <> '' then begin
//             Clear(RecTransportMethod);
//             RecTransportMethod.GET(SIHdr."Transport Method");
//             RecTransportMethod.TestField("E-Invoice Code");
//             if RecTransportMethod."E-Invoice Code" = 'ROAD' then begin
//                 SIHdr.TestField("Vehicle Type");
//                 //SIHdr.TestField("Vehicle No.");
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
//         IrisAPI.SetWebseriveProperties(EInvoiceSetup."Base URL" + EInvoiceSetup."Generate EWB URL", BodyText, false, Token, CompanyId, true);
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
//         SIHdr.TestField("Transport Method");
//         SIHdr.TestField("IRN Hash");

//         Clear(JsonObject);

//         if Isdemocall then
//             JsonObject.Add('userGstin', DemoGSTIN)
//         else
//             JsonObject.Add('userGstin', companyInfo."GST Registration No.");

//         JsonObject.Add('transId', companyInfo."GST Registration No.");
//         JsonObject.Add('irn', SIHdr."IRN Hash");

//         if SIHdr."Transport Method" <> '' then begin
//             Clear(RecTransportMethod);
//             RecTransportMethod.GET(SIHdr."Transport Method");
//             JsonObject.Add('transMode', RecTransportMethod."E-Invoice Code");
//             JsonObject.Add('transDist', 0);

//             if RecTransportMethod."E-Invoice Code" = 'ROAD' then begin
//                 if (SIHdr."Vehicle Type" = SIHdr."Vehicle Type"::Regular) OR (SIHdr."Vehicle Type" = SIHdr."Vehicle Type"::" ") then
//                     JsonObject.Add('vehTyp', 'R')
//                 else
//                     if SIHdr."Vehicle Type" = SIHdr."Vehicle Type"::ODC then
//                         JsonObject.Add('vehTyp', '0');
//                 if SIHdr."Vehicle No." <> '' then
//                     JsonObject.Add('vehNo', SIHdr."Vehicle No.")
//                 else
//                     JsonObject.Add('vehNo', 'KA12KA1234');//sending hardcoded value for testing
//             end else begin
//                 SIHdr.TestField("Transport Doc No.");
//                 SIHdr.TestField("Transport Doc Date");
//                 JsonObject.Add('transDocNo', SIHdr."Transport Doc No.");
//                 JsonObject.Add('transDocDate', FORMAT(SIHdr."Transport Doc Date", 0, '<Day,2>-<Month,2>-<Year4>'));
//             end;
//         end;

//         if SIHdr."Sell-to Country/Region Code" = 'IND' then
//             JsonObject.Add('subSplyTyp', 'Supply')
//         else
//             JsonObject.Add('subSplyTyp', 'Export');

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


//                  if JsonObject.Get('status', JsonToken) then begin
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
//                     if JsonObject.Get('signedQrCode', JsonToken) then begin
//                         if not JsonToken.AsValue().IsNull then begin
//                             SIHdr."E-Invoice signedQrCode".CreateOutStream(OutStr);
//                             JsonToken.AsValue().WriteTo(OutStr);
//                         end;
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

//     procedure ShipToAddressEqualsSellToAddress(var SalesHeader: Record "Sales Invoice Header"): BooleanMicrosoft Teams

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


// }
