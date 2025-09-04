// codeunit 60013 "Cancel IRN"//T12370-N //T12574-MIG USING ISPL E-Invoice Ext.
// {
//     TableNo = "Sales Cr.Memo Header";
//     Permissions = tabledata "Sales Cr.Memo Header" = RIMD;
//     trigger OnRun()
//     var
//         RecSalesCrMemoHdr: Record "Sales Cr.Memo Header";
//     begin
//         if not Rec.Find then
//             Error('There is nothing to send for E-Invoicing.');

//         RecSalesCrMemoHdr.Copy(Rec);
//         "Code"(RecSalesCrMemoHdr);
//         Rec := RecSalesCrMemoHdr;
//     end;

//     local procedure "Code"(var SCrmemoHdr: Record "Sales Cr.Memo Header")
//     var
//         EInvoiceSetup: Record "E-Invoicing API Setup";
//         IrisAPI: Codeunit "Iris Web service";
//         BodyText: Text;
//         LoginJson: Label '{"email":"%1","password":"%2"}';
//         IsSuccess: Boolean;
//         ResponseText: Text;
//         Token: Text;
//         CompanyId: Text;
//         a: report 90;
//     begin
//         EInvoiceSetup.GET;
//         EInvoiceSetup.TestField("User Id");
//         EInvoiceSetup.TestField(Password);
//         EInvoiceSetup.TestField("Base URL");
//         EInvoiceSetup.TestField("Login URL");
//         EInvoiceSetup.TestField("Cancel IRN URL");
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
//         BodyText := CreateJSONForIRIS(SCrmemoHdr, false);//seding True for demo 

//         // Message(BodyText);//////////////@@@@@@@@@@@@@@@@@@@@@@@ TESTING 

//         Clear(IrisAPI);
//         IrisAPI.SetWebseriveProperties(EInvoiceSetup."Base URL" + EInvoiceSetup."Cancel IRN URL", BodyText, false, Token, CompanyId, true);
//         IrisAPI.Run();
//         IrisAPI.GetResponse(IsSuccess, ResponseText);
//         if IsSuccess then
//             Token := StoreIrisResponse(ResponseText, SCrmemoHdr)
//         else
//             Error(ResponseText);
//     end;

//     procedure CreateJSONForIRIS(var SCrMemoHdr: Record "Sales Cr.Memo Header"; Isdemocall: Boolean): Text
//     var
//         JsonObject: JsonObject;
//         JsonArray: JsonArray;
//         JsonToken: JsonToken;
//         companyInfo: Record "Company Information";
//         JsonText: Text;
//         DemoGSTIN: Label '27AAACI9260R002';
//         DemoGSTIN2: Label '19AAACI9260R002';
//     begin
//         companyInfo.GET;
//         SCrMemoHdr.TestField("E-Invoice IRN");

//         Clear(JsonObject);

//         if Isdemocall then
//             JsonObject.Add('userGstin', DemoGSTIN)
//         else
//             JsonObject.Add('userGstin', companyInfo."GST Registration No.");
//         JsonObject.Add('irn', SCrMemoHdr."E-Invoice IRN");
//         JsonObject.Add('cnlRsn', '1');
//         JsonObject.Add('cnlRem', 'Order cancelled by the Buyer');
//         JsonObject.WriteTo(JsonText);
//         exit(JsonText);
//     end;

//     local procedure GetAPITokenFromResponse(APIResponse: Text; var companyId: Text): Text
//     var
//         JsonObject: JsonObject;
//         JsonArray: JsonArray;
//         JsonToken: JsonToken;
//     begin
//         JsonObject.ReadFrom(APIResponse);
//         JsonObject.Get('status', JsonToken);
//         if JsonToken.AsValue().AsCode() = 'SUCCESS' then begin
//             JsonObject.Get('response', JsonToken);
//             JsonObject := JsonToken.AsObject();
//             JsonObject.Get('companyid', JsonToken);
//             companyId := JsonToken.AsValue().AsText();
//             JsonObject.Get('token', JsonToken);
//             exit(JsonToken.AsValue().AsText());
//         end else begin
//             JsonObject.Get('message', JsonToken);
//             Error(JsonToken.AsValue().AsText());
//         end;
//     end;

//     local procedure StoreIrisResponse(ResponseText: Text; var SCrMemoHdr: Record "Sales Cr.Memo Header"): Text
//     var
//         JsonObject: JsonObject;
//         JsonArray: JsonArray;
//         JsonToken: JsonToken;
//         OutStr: OutStream;
//         InStr: InStream;
//         Dt: DateTime;
//     begin
//         JsonObject.ReadFrom(ResponseText);
//         JsonObject.Get('status', JsonToken);
//         if JsonToken.AsValue().AsCode() = 'SUCCESS' then begin
//             SCrMemoHdr."E-Invoice API Status" := SCrMemoHdr."E-Invoice API Status"::Cancelled;
//             JsonObject.Get('response', JsonToken);
//             JsonObject := JsonToken.AsObject();

//             JsonObject.Get('cancelDate', JsonToken);
//             if not JsonToken.AsValue().IsNull then begin
//                 Evaluate(dt, JsonToken.AsValue().AsText());
//                 SCrMemoHdr."E-Inv. Cancelled Date" := dt;
//                 SCrMemoHdr."Cancel IRN Date" := dt;
//             end;
//             JsonObject.Get('irn', JsonToken);
//             if not JsonToken.AsValue().IsNull then
//                 SCrMemoHdr."Cancel IRN" := JsonToken.AsValue().AsText();

//             SCrMemoHdr.Modify();
//         end else begin
//             if JsonObject.Get('errors', JsonToken) then begin
//                 JsonArray := JsonToken.AsArray();
//                 if JsonArray.Count <> 0 then begin
//                     JsonArray.WriteTo(ResponseText);
//                     Message(ResponseText);
//                 end
//                 else begin
//                     JsonObject.Get('message', JsonToken);
//                     Error(JsonToken.AsValue().AsText());
//                 end;
//             end else begin
//                 JsonObject.Get('message', JsonToken);
//                 Error(JsonToken.AsValue().AsText());
//             end;
//         end;
//     end;

//     var


// }
