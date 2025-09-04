codeunit 85652 "API Call"
{
    //T13919IC API -NS
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnAfterCreatePurchDocument', '', true, true)]  //Hypercare use later-Anoop-Dhiren
    procedure ICtrackingLineCopy_API(var PurchaseHeader: Record "Purchase Header"; ICInboxPurchaseHeader: Record "IC Inbox Purchase Header")
    var
        ICPartner: Record "IC Partner";
        PartnerTrackingLineL: Record "Tracking Specification";
        ReserEntryL: Record "Reservation Entry";
        SalesHeaderL: Record "Sales Header";
        PurchLine: Record "Purchase Line";
        EntryNoL: Integer;
        SalesShipmentLine: Record "Sales Shipment Line";
        //Createres: Codeunit "Create Reserv. Entry";
        ILE: Record "Item Ledger Entry";
        PostedQCReceiptLine_lRec: Record "Posted QC Rcpt. Line";
        PostedQCReceiptHdr_lRec: Record "Posted QC Rcpt. Header";

        Body_JObject: JsonObject;
        Body_ltext: Text;
        Base64Convert: Codeunit "Base64 Convert";
        OS: OutStream;
        IS: InStream;
        TempBlob: Codeunit "Temp Blob";
        Base64String: Text;
        TenantID_lTxt: text;
        lurl: text;
        ILEurl: text;
        ClientID_lTxt: text;
        SecretKey_lTxt: text;
        TockenURL_lTxt: text;
        Scopes: List of [Text];
        Accesstoken: Text;
        lheaders: HttpHeaders;
        oAuth2: Codeunit OAuth2;
        Body_gcontent: HttpContent;
        ILEBody_gcontent: HttpContent;
        PostQCBody_gcontent: HttpContent;
        gHttpClient: HttpClient;
        ILEgHttpClient: HttpClient;
        PostQCgHttpClient: HttpClient;
        Jtoken: JsonToken;
        subJtoken: JsonToken;
        OutStr: OutStream;
        Instr: InStream;
        TempBlob_lCdu: Codeunit "Temp Blob";
        gheaders: HttpHeaders;
        greqMsg: HttpRequestMessage;
        ILEgreqMsg: HttpRequestMessage;
        PostQCgreqMsg: HttpRequestMessage;
        gResponseMsg: HttpResponseMessage;
        ILEgResponseMsg: HttpResponseMessage;
        PostQCgResponseMsg: HttpResponseMessage;
        JSONResponse: Text;
        ILEJSONResponse: Text;
        PostQCJSONResponse: Text;
        JObject: JsonObject;
        Jarray: Jsonarray;
        ILEJarray: Jsonarray;
        PostQCJarray: Jsonarray;
        ILEJObject: JsonObject;
        PostQCJObject: JsonObject;
        Jsonvalue: JsonValue;
        DocumentNo_Ltxt: Text;
        DocumentLineNo_lInt: Integer;
        SalesShipLocationCode_lTxt: text;
        DoNo_ltxt: Text;
        ILEsubJtoken: JsonToken;
        PostQCsubJtoken: JsonToken;
        ILEJtoken: JsonToken;
        PostQCJtoken: JsonToken;
        i: Integer;
        j: Integer;
        k: Integer;
        CompInfo_lrec: Record "Company Information";
        IleQTy: Decimal;
        IlecustomLotNumber: Text;
        IlesuppbatchNo2: Text;
        resultjtoken: JsonToken;
        IleExpDate: Date;
        IleManfDate2: Date;
        IleExpiryPeriod2: text;
        IleVariantCode: Text;
        Ilecount: Integer;
        IlePostQCNo: Code[20];
        IleEntryNo: Integer;
        ileGRNdate: date;
        PostQCUrl: Text;
        StageQcDetails_lRec: Record "Stage QC Details";
    begin
        CompInfo_lrec.get();
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
            PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
            PurchLine.SetRange("Document No.", PurchaseHeader."No.");
            PurchLine.SetRange(Type, PurchLine.Type::Item);
            if PurchLine.FindSet() then begin
                repeat
                    if ICPartner.Get(ICInboxPurchaseHeader."IC Partner Code") then;
                    if ICPartner."Data Exchange Type" = ICPartner."Data Exchange Type"::API then begin

                        CompInfo_lrec.TestField("IC Tenant ID");
                        CompInfo_lrec.TestField("IC Tenant Name");
                        CompInfo_lrec.TestField("Client ID");
                        CompInfo_lrec.TestField("Secret ID");
                        ICPartner.TestField("API Company ID");
                        lurl := 'https://api.businesscentral.dynamics.com/v2.0/' + CompInfo_lrec."IC Tenant ID" + '/' + CompInfo_lrec."IC Tenant Name" + '/api/ISPL/API/v2.0/companies(' + ICPartner."API Company ID" + ')/apiSalesShipmentLineIC?$filter=orderNo eq ''' + ICInboxPurchaseHeader."No." + ''' and lineNo eq ' + Format(PurchLine."Line No.");

                        ClientID_lTxt := CompInfo_lrec."Client ID";
                        SecretKey_lTxt := CompInfo_lrec."Secret ID";
                        TockenURL_lTxt := StrSubstNo('https://login.microsoftonline.com/%1/oauth2/v2.0/token', CompInfo_lrec."IC Tenant ID");

                        Scopes.Add('https://api.businesscentral.dynamics.com/.default');
                        OAuth2.AcquireTokenWithClientCredentials(ClientID_lTxt, SecretKey_lTxt, TockenURL_lTxt, '', Scopes, Accesstoken);

                        gHttpClient.Clear();
                        Clear(gHttpClient);
                        Clear(greqMsg);
                        Clear(gResponseMsg);


                        lheaders.Clear();
                        Body_gcontent.GetHeaders(lheaders);

                        //Application/Json
                        lheaders.Remove('Content-Type');
                        lheaders.Add('Content-Type', 'application/json');
                        Body_gcontent.GetHeaders(lheaders);


                        greqMsg.SetRequestUri(lurl);
                        greqMsg.Content(Body_gcontent);
                        greqMsg.GetHeaders(lheaders);
                        greqMsg.Method := 'GET';
                        gHttpClient.DefaultRequestHeaders().Add('Authorization', 'Bearer ' + AccessToken);
                        if not gHttpClient.Send(greqMsg, gResponseMsg) then
                            Error('API Authorization token request failed...');

                        JSONResponse := '';
                        gResponseMsg.Content().ReadAs(JSONResponse);

                        Jtoken.ReadFrom(JSONResponse);
                        JObject.ReadFrom(JSONResponse);

                        Clear(DocumentNo_Ltxt);
                        Clear(subJtoken);
                        Clear(DocumentLineNo_lInt);
                        if JObject.Get('error', Jtoken) then
                            Error(JSONResponse);

                        if JObject.Get('value', Jtoken) then begin
                            Jarray := Jtoken.AsArray();

                            // Iterate through the array and extract "entryNo" from each item
                            for i := 0 to Jarray.Count - 1 do begin
                                if Jarray.Get(i, Jtoken) then begin
                                    if Jtoken.AsObject().Get('documentNo', subJtoken) then
                                        DocumentNo_Ltxt := subJtoken.AsValue().AsText();
                                    Clear(subJtoken);
                                    if Jtoken.AsObject().Get('lineNo', subJtoken) then
                                        DocumentLineNo_lInt := subJtoken.AsValue().AsInteger();
                                    Clear(subJtoken);
                                    if Jtoken.AsObject().Get('locationCode', subJtoken) then
                                        SalesShipLocationCode_lTxt := subJtoken.AsValue().AsText();
                                    Clear(subJtoken);

                                    If (DocumentNo_Ltxt <> '') and (DocumentLineNo_lInt <> 0) then begin
                                        ILEurl := 'https://api.businesscentral.dynamics.com/v2.0/' + CompInfo_lrec."IC Tenant ID" + '/' + CompInfo_lrec."IC Tenant Name" + '/api/ISPL/API/v2.0/companies('
                                                    + ICPartner."API Company ID" + ')/apiItemLedgerEntriesIC?$filter=documentNo eq ''' + DocumentNo_Ltxt + ''' and documentType eq '''
                                                        + Format(ILE."Document Type"::"Sales Shipment") + ''' and documentLineNo eq ' + Format(DocumentLineNo_lInt);

                                        Clear(oAuth2);
                                        Clear(Accesstoken);
                                        OAuth2.AcquireTokenWithClientCredentials(ClientID_lTxt, SecretKey_lTxt, TockenURL_lTxt, '', Scopes, Accesstoken);

                                        ilegHttpClient.Clear();
                                        Clear(ilegHttpClient);
                                        Clear(ilegreqMsg);
                                        Clear(ilegResponseMsg);


                                        lheaders.Clear();
                                        ILEBody_gcontent.GetHeaders(lheaders);

                                        //Application/Json
                                        lheaders.Remove('Content-Type');
                                        lheaders.Add('Content-Type', 'application/json');
                                        ILEBody_gcontent.GetHeaders(lheaders);

                                        ILEgreqMsg.SetRequestUri(ILEurl);
                                        ILEgreqMsg.Content(ILEBody_gcontent);
                                        ILEgreqMsg.GetHeaders(lheaders);
                                        ILEgreqMsg.Method := 'GET';
                                        ILEgHttpClient.DefaultRequestHeaders().Add('Authorization', 'Bearer ' + AccessToken);
                                        if not ILEgHttpClient.Send(ILEgreqMsg, ILEgResponseMsg) then
                                            Error('API Authorization token request failed...');

                                        IleJSONResponse := '';
                                        ILEgResponseMsg.Content().ReadAs(IleJSONResponse);

                                        ILEJtoken.ReadFrom(IleJSONResponse);
                                        ILEJObject.ReadFrom(IleJSONResponse);

                                        ILEJObject := ILEJtoken.AsObject();

                                        if ILEJObject.Get('error', ILEJtoken) then
                                            Error(ILEJSONResponse);
                                        Clear(ILEsubJtoken);
                                        if ILEJObject.Get('value', ILEJtoken) then begin
                                            ILEJarray := ILEJtoken.AsArray();
                                            Ilecount := ILEJarray.Count;
                                            // Error('STOP');
                                            for j := 0 to ILEJarray.Count - 1 do begin

                                                if ILEJarray.Get(j, ILEJtoken) then begin
                                                    if ILEJtoken.AsObject().Get('quantity', ILEsubJtoken) then
                                                        IleQTy := ILEsubJtoken.AsValue().AsDecimal();
                                                    Clear(ILEsubJtoken);
                                                    if ILEJtoken.AsObject().Get('customLotNumber', ILEsubJtoken) then
                                                        IlecustomLotNumber := ILEsubJtoken.AsValue().AsText();
                                                    Clear(ILEsubJtoken);
                                                    if ILEJtoken.AsObject().Get('supplierBatchNo2', ILEsubJtoken) then
                                                        IlesuppbatchNo2 := ILEsubJtoken.AsValue().AsText();
                                                    Clear(ILEsubJtoken);
                                                    if ILEJtoken.AsObject().Get('expirationDate', ILEsubJtoken) then
                                                        IleExpDate := ILEsubJtoken.AsValue().AsDate();
                                                    Clear(ILEsubJtoken);
                                                    if ILEJtoken.AsObject().Get('manufacturingDate2', ILEsubJtoken) then
                                                        IleManfDate2 := ILEsubJtoken.AsValue().AsDate();
                                                    Clear(ILEsubJtoken);
                                                    if ILEJtoken.AsObject().Get('expiryPeriod2', ILEsubJtoken) then
                                                        IleExpiryPeriod2 := ILEsubJtoken.AsValue().AsText();
                                                    Clear(ILEsubJtoken);
                                                    if ILEJtoken.AsObject().Get('variantCode', ILEsubJtoken) then
                                                        IleVariantCode := ILEsubJtoken.AsValue().AsText();
                                                    Clear(ILEsubJtoken);
                                                    if ILEJtoken.AsObject().Get('postedQCNo', ILEsubJtoken) then
                                                        IlePostQCNo := ILEsubJtoken.AsValue().AsCode();
                                                    Clear(ILEsubJtoken);
                                                    if ILEJtoken.AsObject().Get('entryNo', ILEsubJtoken) then
                                                        IleEntryNo := ILEsubJtoken.AsValue().AsInteger();
                                                    //Hypercare 06-03-2025
                                                    Clear(ILEsubJtoken);
                                                    if ILEJtoken.AsObject().Get('groupGRNDate', ILEsubJtoken) then
                                                        ileGRNdate := ILEsubJtoken.AsValue().Asdate();
                                                    Clear(ILEsubJtoken);
                                                    //Hypercare 06-03-2025
                                                    if IleQTy <> 0 then begin
                                                        EntryNoL := ReserEntryL.GetLastEntryNo() + 1;
                                                        ReserEntryL.SetSource(Database::"Purchase Line", PurchLine."Document Type".AsInteger(), PurchLine."Document No.", PurchLine."Line No.", '', 0);//30-04-2022-Added As Integer with Enum
                                                        ReserEntryL."Entry No." := EntryNoL;
                                                        // ReserEntryL."Source ID" := PurchLine."Document No.";
                                                        // ReserEntryL."Source Ref. No." := PurchLine."Line No.";
                                                        ReserEntryL.Validate("Item No.", PurchLine."No.");
                                                        ReserEntryL.Validate(Quantity, Abs(IleQTy));
                                                        ReserEntryL.Validate("Quantity (Base)", Abs(IleQTy));
                                                        ReserEntryL."Reservation Status" := ReserEntryL."Reservation Status"::Surplus;
                                                        ReserEntryL."Item Ledger Entry No." := 0;
                                                        ReserEntryL.Validate(CustomLotNumber, IlecustomLotNumber);
                                                        ReserEntryL."Location Code" := SalesShipLocationCode_lTxt;
                                                        ReserEntryL."Lot No." := IlecustomLotNumber;
                                                        ReserEntryL."Supplier Batch No. 2" := IlesuppbatchNo2;
                                                        ReserEntryL."Expiration Date" := IleExpDate;
                                                        ReserEntryL."Group GRN Date" := ileGRNdate;//Hypercare 06-03-2025
                                                        ReserEntryL."Manufacturing Date 2" := IleManfDate2;
                                                        IF IleExpiryPeriod2 <> '' Then
                                                            Evaluate(ReserEntryL."Expiry Period 2", IleExpiryPeriod2);
                                                        ReserEntryL."Variant Code" := IleVariantCode;
                                                        if ReserEntryL.Insert() then;
                                                        PurchLine."Location Code" := SalesShipLocationCode_lTxt;
                                                        PurchLine.Modify();

                                                        Postqcurl := 'https://api.businesscentral.dynamics.com/v2.0/' + CompInfo_lrec."IC Tenant ID" + '/' + CompInfo_lrec."IC Tenant Name" + '/api/ISPL/API/v2.0/companies('
                                                                                                          + ICPartner."API Company ID" + ')/apiPostedQCLines?$filter=posQCno eq ''' + IlePostQCNo + '''';

                                                        // Clear(oAuth2);
                                                        // Clear(Accesstoken);
                                                        // OAuth2.AcquireTokenWithClientCredentials(ClientID_lTxt, SecretKey_lTxt, TockenURL_lTxt, '', Scopes, Accesstoken);
                                                        PostQCgHttpClient.Clear();
                                                        Clear(PostQCgHttpClient);
                                                        Clear(PostQCgreqMsg);
                                                        Clear(PostQCgResponseMsg);

                                                        lheaders.Clear();
                                                        PostQCBody_gcontent.GetHeaders(lheaders);

                                                        //Application/Json
                                                        lheaders.Remove('Content-Type');
                                                        lheaders.Add('Content-Type', 'application/json');
                                                        PostQCBody_gcontent.GetHeaders(lheaders);

                                                        PostQCgreqMsg.SetRequestUri(PostQCurl);
                                                        PostQCgreqMsg.Content(PostQCBody_gcontent);
                                                        PostQCgreqMsg.GetHeaders(lheaders);
                                                        PostQCgreqMsg.Method := 'GET';
                                                        PostQCgHttpClient.DefaultRequestHeaders().Add('Authorization', 'Bearer ' + AccessToken);
                                                        if not PostQCgHttpClient.Send(PostQCgreqMsg, PostQCgResponseMsg) then
                                                            Error('API Authorization token request failed...');

                                                        PostQCJSONResponse := '';
                                                        PostQCgResponseMsg.Content().ReadAs(PostQCJSONResponse);

                                                        PostQCJtoken.ReadFrom(PostQCJSONResponse);
                                                        PostQCJObject.ReadFrom(PostQCJSONResponse);

                                                        PostQCJObject := PostQCJtoken.AsObject();

                                                        if PostQCJObject.Get('error', PostQCJtoken) then
                                                            Error(PostQCJSONResponse);
                                                        Clear(PostQCsubJtoken);
                                                        if PostQCJObject.Get('value', PostQCJtoken) then begin
                                                            PostQCJarray := PostQCJtoken.AsArray();
                                                            // Error('STOP');
                                                            for k := 0 to PostQCJarray.Count - 1 do begin
                                                                Clear(StageQcDetails_lRec);
                                                                StageQcDetails_lRec.Init();
                                                                if PostQCJarray.Get(k, PostQCJtoken) then begin
                                                                    if PostQCJtoken.AsObject().Get('posQCno', PostQCsubJtoken) then
                                                                        StageQcDetails_lRec."No." := PostQCsubJtoken.AsValue().AsCode();
                                                                    Clear(PostQCsubJtoken);
                                                                    if PostQCJtoken.AsObject().Get('postQClineNo', PostQCsubJtoken) then
                                                                        StageQcDetails_lRec."Line No." := PostQCsubJtoken.AsValue().AsInteger();
                                                                    Clear(PostQCsubJtoken);
                                                                    if PostQCJtoken.AsObject().Get('qualityParameterCode', PostQCsubJtoken) then
                                                                        StageQcDetails_lRec."Quality Parameter Code" := PostQCsubJtoken.AsValue().AsCode();
                                                                    Clear(PostQCsubJtoken);
                                                                    if PostQCJtoken.AsObject().Get('vendorCOATextResult', PostQCsubJtoken) then
                                                                        StageQcDetails_lRec."Vendor COA Text Result" := PostQCsubJtoken.AsValue().AsText();
                                                                    Clear(PostQCsubJtoken);
                                                                    if PostQCJtoken.AsObject().Get('vendorCOAValueResult', PostQCsubJtoken) then
                                                                        StageQcDetails_lRec."Vendor COA Value Result" := PostQCsubJtoken.AsValue().AsDecimal();
                                                                    Clear(PostQCsubJtoken);
                                                                    if PostQCJtoken.AsObject().Get('actualText', PostQCsubJtoken) then
                                                                        StageQcDetails_lRec."Actual Text" := PostQCsubJtoken.AsValue().AsText();
                                                                    Clear(PostQCsubJtoken);
                                                                    if PostQCJtoken.AsObject().Get('actualValue', PostQCsubJtoken) then
                                                                        StageQcDetails_lRec."Actual Value" := PostQCsubJtoken.AsValue().AsDecimal();
                                                                    Clear(PostQCsubJtoken);
                                                                    if PostQCJtoken.AsObject().Get('result', PostQCsubJtoken) then
                                                                        Evaluate(StageQcDetails_lRec.Result, PostQCsubJtoken.AsValue().AsText());
                                                                    Clear(PostQCsubJtoken);
                                                                    if PostQCJtoken.AsObject().Get('SampleCollector', PostQCsubJtoken) then
                                                                        StageQcDetails_lRec."Sample Collector ID" := PostQCsubJtoken.AsValue().AsCode();
                                                                    Clear(PostQCsubJtoken);
                                                                    if PostQCJtoken.AsObject().Get('Sampleprovider', PostQCsubJtoken) then
                                                                        StageQcDetails_lRec."Sample Provider ID" := PostQCsubJtoken.AsValue().AsCode();
                                                                    Clear(PostQCsubJtoken);
                                                                    if PostQCJtoken.AsObject().Get('DateofSample', PostQCsubJtoken) then
                                                                        StageQcDetails_lRec."Date of Sample Collection" := PostQCsubJtoken.AsValue().AsDate();
                                                                    Clear(PostQCsubJtoken);
                                                                    //14042025-NS
                                                                    if PostQCJtoken.AsObject().Get('Required', PostQCsubJtoken) then
                                                                        StageQcDetails_lRec.Required := PostQCsubJtoken.AsValue().AsBoolean();
                                                                    Clear(PostQCsubJtoken);
                                                                    //14042025-NE
                                                                    if PostQCJtoken.AsObject().Get('sampleDateandTime', PostQCsubJtoken) then
                                                                        StageQcDetails_lRec."Sample Date and Time" := PostQCsubJtoken.AsValue().AsDateTime();
                                                                    Clear(PostQCsubJtoken);
                                                                    StageQcDetails_lRec."Purchase Order No." := PurchLine."Document No.";
                                                                    StageQcDetails_lRec."Purchase Order Line No." := PurchLine."Line No.";
                                                                    StageQcDetails_lRec."ILE Entry No." := IleEntryNo;
                                                                    StageQcDetails_lRec."ILE Lot No." := IlecustomLotNumber;
                                                                    StageQcDetails_lRec.Insert();
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end else begin //Hypercare 07-03-2025
                        if ICPartner."Data Exchange Type" = ICPartner."Data Exchange Type"::Database then begin

                            SalesShipmentLine.ChangeCompany(ICPartner."Inbox Details");
                            ILE.ChangeCompany(ICPartner."Inbox Details");
                            PostedQCReceiptHdr_lRec.ChangeCompany(ICPartner."Inbox Details");
                            PostedQCReceiptLine_lRec.ChangeCompany(ICPartner."Inbox Details");
                            SalesShipmentLine.SetRange("Order No.", ICInboxPurchaseHeader."No.");
                            SalesShipmentLine.SetRange("Line No.", PurchLine."Line No.");
                            if SalesShipmentLine.FindSet() then begin
                                repeat
                                    ILE.SetRange("Document No.", SalesShipmentLine."Document No.");
                                    ILE.SetRange("Document Type", ILE."Document Type"::"Sales Shipment");
                                    ILE.SetRange("Document Line No.", SalesShipmentLine."Line No.");
                                    if ILE.FindSet() then begin
                                        repeat
                                            EntryNoL := ReserEntryL.GetLastEntryNo() + 1;
                                            ReserEntryL.SetSource(Database::"Purchase Line", PurchLine."Document Type".AsInteger(), PurchLine."Document No.", PurchLine."Line No.", '', 0);//30-04-2022-Added As Integer with Enum
                                            ReserEntryL."Entry No." := EntryNoL;
                                            // ReserEntryL."Source ID" := PurchLine."Document No.";
                                            // ReserEntryL."Source Ref. No." := PurchLine."Line No.";
                                            ReserEntryL.Validate("Item No.", PurchLine."No.");
                                            ReserEntryL.Validate(Quantity, Abs(ILE.Quantity));
                                            ReserEntryL.Validate("Quantity (Base)", Abs(ILE.Quantity));
                                            ReserEntryL."Reservation Status" := ReserEntryL."Reservation Status"::Surplus;
                                            ReserEntryL."Item Ledger Entry No." := 0;
                                            ReserEntryL.Validate(CustomLotNumber, ILE.CustomLotNumber);
                                            ReserEntryL."Location Code" := SalesShipmentLine."Location Code";
                                            ReserEntryL."Lot No." := ILE.CustomLotNumber;
                                            ReserEntryL."Supplier Batch No. 2" := ILE."Supplier Batch No. 2";
                                            ReserEntryL."Expiration Date" := ILE."Expiration Date";
                                            ReserEntryL."Manufacturing Date 2" := ile."Manufacturing Date 2";
                                            ReserEntryL."Expiry Period 2" := ILE."Expiry Period 2";
                                            ReserEntryL."Variant Code" := ILE."Variant Code";
                                            ReserEntryL."Group GRN Date" := ILE."Group GRN Date";
                                            if ReserEntryL.Insert() then;
                                            PurchLine."Location Code" := SalesShipmentLine."Location Code";
                                            PurchLine.Modify();
                                            // PostedQCReceiptHdr_lRec.reset;
                                            PostedQCReceiptHdr_lRec.SetRange("No.", ILE."Posted QC No.");
                                            if PostedQCReceiptHdr_lRec.FindFirst() then begin
                                                // PostedQCReceiptLine_lRec.Reset();
                                                PostedQCReceiptLine_lRec.SetRange("No.", PostedQCReceiptHdr_lRec."No.");
                                                if PostedQCReceiptLine_lRec.FindSet() then
                                                    repeat
                                                        Clear(StageQcDetails_lRec);
                                                        StageQcDetails_lRec.init;
                                                        StageQcDetails_lRec."No." := PostedQCReceiptLine_lRec."No.";
                                                        StageQcDetails_lRec."Line No." := PostedQCReceiptLine_lRec."Line No.";
                                                        StageQcDetails_lRec."Quality Parameter Code" := PostedQCReceiptLine_lRec."Quality Parameter Code";
                                                        StageQcDetails_lRec."Vendor COA Text Result" := PostedQCReceiptLine_lRec."Vendor COA Text Result";
                                                        StageQcDetails_lRec."Vendor COA Value Result" := PostedQCReceiptLine_lRec."Vendor COA Value Result";
                                                        StageQcDetails_lRec."Actual Text" := PostedQCReceiptLine_lRec."Actual Text";
                                                        StageQcDetails_lRec."Actual Value" := PostedQCReceiptLine_lRec."Actual Value";
                                                        StageQcDetails_lRec.Result := PostedQCReceiptLine_lRec.Result;
                                                        StageQcDetails_lRec."Sample Collector ID" := PostedQCReceiptHdr_lRec."Sample Collector ID";
                                                        StageQcDetails_lRec."Sample Provider ID" := PostedQCReceiptHdr_lRec."Sample Provider ID";
                                                        StageQcDetails_lRec."Date of Sample Collection" := PostedQCReceiptHdr_lRec."Date of Sample Collection";
                                                        StageQcDetails_lRec."Purchase Order No." := PurchLine."Document No.";
                                                        StageQcDetails_lRec."Purchase Order Line No." := PurchLine."Line No.";
                                                        StageQcDetails_lRec."ILE Entry No." := ILE."Entry No.";
                                                        StageQcDetails_lRec."ILE Lot No." := ILE.CustomLotNumber;
                                                        StageQcDetails_lRec.Required := PostedQCReceiptLine_lRec.Required; //14042025
                                                        StageQcDetails_lRec."Sample Date and Time" := PostedQCReceiptHdr_lRec."Sample Date and Time";
                                                        StageQcDetails_lRec.Insert();
                                                    until PostedQCReceiptLine_lRec.next = 0;
                                            end;
                                        until ILE.Next() = 0;
                                    end;
                                until SalesShipmentLine.Next() = 0;
                            end;
                        end;
                    end;//Hypercare 07-03-2025
                //Note: Changes for Database Base Intercompany Code in Kemipex Buisness App
                until PurchLine.Next() = 0;
            end;
        end;
        // end;
    end; //ICTransaction Testing Rakshith & Mayank 25-02-2025

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnAfterCreatePurchDocument', '', true, true)]
    local procedure IntercompanyTransfer_CopyTestingParameters_API(var PurchaseHeader: Record "Purchase Header"; ICInboxPurchaseHeader: Record "IC Inbox Purchase Header")
    var
        // ICPartnerL: Record "IC Partner";
        SalesHeaderL: Record "Sales Header";
        // PurcLineL: Record "Purchase Line";
        PartnerTrackingLineL: Record "Tracking Specification";
        ItemLedgerEntryL: Record "Item Ledger Entry";
        SalesShipmentLine: Record "Sales Shipment Line";
        PurchLine: Record "Purchase Line";
        ICPartner: Record "IC Partner";
        ILE: Record "Item Ledger Entry";
        LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
        PostedLotVariantTestingParameterAPI: Record "Post Lot Var Testing Parameter"; //AJAY
        Body_JObject: JsonObject;
        Body_ltext: Text;
        Base64Convert: Codeunit "Base64 Convert";
        OS: OutStream;
        IS: InStream;
        TempBlob: Codeunit "Temp Blob";
        Base64String: Text;
        TenantID_lTxt: text;
        lurl: text;
        ILEurl: text;
        Posloturl: text;
        ClientID_lTxt: text;
        SecretKey_lTxt: text;
        TockenURL_lTxt: text;
        Scopes: List of [Text];
        Accesstoken: Text;
        lheaders: HttpHeaders;
        oAuth2: Codeunit OAuth2;
        Body_gcontent: HttpContent;
        ILEBody_gcontent: HttpContent;
        PoslotBody_gcontent: HttpContent;
        gHttpClient: HttpClient;
        ILEgHttpClient: HttpClient;
        PoslotgHttpClient: HttpClient;
        Jtoken: JsonToken;
        subJtoken: JsonToken;
        OutStr: OutStream;
        Instr: InStream;
        TempBlob_lCdu: Codeunit "Temp Blob";
        gheaders: HttpHeaders;
        greqMsg: HttpRequestMessage;
        ILEgreqMsg: HttpRequestMessage;
        PoslotgreqMsg: HttpRequestMessage;
        gResponseMsg: HttpResponseMessage;
        ILEgResponseMsg: HttpResponseMessage;
        PoslotgResponseMsg: HttpResponseMessage;
        JSONResponse: Text;
        ILEJSONResponse: Text;
        PoslotJSONResponse: Text;
        JObject: JsonObject;
        Jarray: Jsonarray;
        ILEJarray: Jsonarray;
        ILEJObject: JsonObject;
        PoslotJarray: Jsonarray;
        PoslotJObject: JsonObject;
        Jsonvalue: JsonValue;
        DocumentNo_Ltxt: Text;
        DocumentLineNo_lInt: Integer;
        SalesShipLocationCode_lTxt: text;
        DoNo_ltxt: Text;
        ILEJtoken: JsonToken;
        ILEsubJtoken: JsonToken;
        PoslotJtoken: JsonToken;
        PoslotsubJtoken: JsonToken;
        i: Integer;
        j: Integer;
        k: Integer;
        CompInfo_lrec: Record "Company Information";
        IleDocno: Text;
        IlecustomLotNumber: Text;
        IleDocLineno: Integer;
        resultjtoken: JsonToken;
        IleItemNo: Text;
        IleManfDate2: Date;
        IleCusBOENo: text;
        IleVariantCode: Text;
        Ilecount: Integer;
        Item_lRec: Record item;//T51170-N

    begin
        CompInfo_lrec.Get();//Hypercare-27-03-25-N
        If not ICPartner.Get(ICInboxPurchaseHeader."IC Partner Code") then
            exit;
        If ICPartner."Data Exchange Type" <> ICPartner."Data Exchange Type"::API then
            exit;

        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
            PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
            PurchLine.SetRange("Document No.", PurchaseHeader."No.");
            PurchLine.SetRange(Type, PurchLine.Type::Item);
            if PurchLine.FindSet() then begin
                repeat //AJAY >>
                       //T51170-NS
                    Item_lRec.get(PurchLine."No.");
                    if (Item_lRec."COA Applicable") then begin
                        //T51170-NE
                        CompInfo_lrec.TestField("IC Tenant ID");
                        CompInfo_lrec.TestField("IC Tenant Name");
                        CompInfo_lrec.TestField("Client ID");
                        CompInfo_lrec.TestField("Secret ID");
                        ICPartner.TestField("API Company ID");
                        lurl := 'https://api.businesscentral.dynamics.com/v2.0/' + CompInfo_lrec."IC Tenant ID" + '/' + CompInfo_lrec."IC Tenant Name" + '/api/ISPL/API/v2.0/companies(' + ICPartner."API Company ID" + ')/apiSalesShipmentLineIC?$filter=orderNo eq ''' + ICInboxPurchaseHeader."No." + ''' and lineNo eq ' + Format(PurchLine."Line No.");

                        ClientID_lTxt := CompInfo_lrec."Client ID";
                        SecretKey_lTxt := CompInfo_lrec."Secret ID";
                        TockenURL_lTxt := StrSubstNo('https://login.microsoftonline.com/%1/oauth2/v2.0/token', CompInfo_lrec."IC Tenant ID");

                        Scopes.Add('https://api.businesscentral.dynamics.com/.default');
                        OAuth2.AcquireTokenWithClientCredentials(ClientID_lTxt, SecretKey_lTxt, TockenURL_lTxt, '', Scopes, Accesstoken);

                        gHttpClient.Clear();
                        Clear(gHttpClient);
                        Clear(greqMsg);
                        Clear(gResponseMsg);

                        lheaders.Clear();
                        Body_gcontent.GetHeaders(lheaders);

                        //Application/Json
                        lheaders.Remove('Content-Type');
                        lheaders.Add('Content-Type', 'application/json');
                        Body_gcontent.GetHeaders(lheaders);


                        greqMsg.SetRequestUri(lurl);
                        greqMsg.Content(Body_gcontent);
                        greqMsg.GetHeaders(lheaders);
                        greqMsg.Method := 'GET';
                        gHttpClient.DefaultRequestHeaders().Add('Authorization', 'Bearer ' + AccessToken);
                        if not gHttpClient.Send(greqMsg, gResponseMsg) then
                            Error('API Authorization token request failed...');

                        JSONResponse := '';
                        gResponseMsg.Content().ReadAs(JSONResponse);

                        Jtoken.ReadFrom(JSONResponse);
                        JObject.ReadFrom(JSONResponse);

                        Clear(DocumentNo_Ltxt);
                        Clear(subJtoken);
                        Clear(DocumentLineNo_lInt);
                        if JObject.Get('error', Jtoken) then
                            Error(JSONResponse);

                        if JObject.Get('value', Jtoken) then begin
                            Jarray := Jtoken.AsArray();

                            // Iterate through the array and extract "entryNo" from each item
                            for i := 0 to Jarray.Count - 1 do begin
                                if Jarray.Get(i, Jtoken) then begin
                                    if Jtoken.AsObject().Get('documentNo', subJtoken) then
                                        DocumentNo_Ltxt := subJtoken.AsValue().AsText();
                                    Clear(subJtoken);
                                    if Jtoken.AsObject().Get('lineNo', subJtoken) then
                                        DocumentLineNo_lInt := subJtoken.AsValue().AsInteger();
                                    Clear(subJtoken);
                                    if Jtoken.AsObject().Get('locationCode', subJtoken) then
                                        SalesShipLocationCode_lTxt := subJtoken.AsValue().AsText();
                                    Clear(subJtoken);

                                    If (DocumentNo_Ltxt <> '') and (DocumentLineNo_lInt <> 0) then begin
                                        ILEurl := 'https://api.businesscentral.dynamics.com/v2.0/' + CompInfo_lrec."IC Tenant ID" + '/' + CompInfo_lrec."IC Tenant Name" + '/api/ISPL/API/v2.0/companies('
                                                    + ICPartner."API Company ID" + ')/apiItemLedgerEntriesIC?$filter=documentNo eq ''' + DocumentNo_Ltxt + ''' and documentType eq '''
                                                        + Format(ILE."Document Type"::"Sales Shipment") + ''' and documentLineNo eq ' + Format(DocumentLineNo_lInt);
                                        Clear(oAuth2);
                                        Clear(Accesstoken);
                                        OAuth2.AcquireTokenWithClientCredentials(ClientID_lTxt, SecretKey_lTxt, TockenURL_lTxt, '', Scopes, Accesstoken);

                                        ilegHttpClient.Clear();
                                        Clear(ilegHttpClient);
                                        Clear(ilegreqMsg);
                                        Clear(ilegResponseMsg);

                                        lheaders.Clear();
                                        ILEBody_gcontent.GetHeaders(lheaders);

                                        //Application/Json
                                        lheaders.Remove('Content-Type');
                                        lheaders.Add('Content-Type', 'application/json');
                                        ILEBody_gcontent.GetHeaders(lheaders);

                                        ILEgreqMsg.SetRequestUri(ILEurl);
                                        ILEgreqMsg.Content(ILEBody_gcontent);
                                        ILEgreqMsg.GetHeaders(lheaders);
                                        ILEgreqMsg.Method := 'GET';
                                        ILEgHttpClient.DefaultRequestHeaders().Add('Authorization', 'Bearer ' + AccessToken);
                                        if not ILEgHttpClient.Send(ILEgreqMsg, ILEgResponseMsg) then
                                            Error('API Authorization token request failed...');

                                        IleJSONResponse := '';
                                        ILEgResponseMsg.Content().ReadAs(IleJSONResponse);

                                        ILEJtoken.ReadFrom(IleJSONResponse);
                                        ILEJObject.ReadFrom(IleJSONResponse);



                                        ILEJObject := ILEJtoken.AsObject();
                                        Clear(ILEsubJtoken);

                                        if ILEJObject.Get('error', ILEJtoken) then
                                            Error(ILEJSONResponse);
                                        if ILEJObject.Get('value', ILEJtoken) then begin
                                            ILEJarray := ILEJtoken.AsArray();
                                            Ilecount := ILEJarray.Count;
                                            // Error('STOP');
                                            for j := 0 to ILEJarray.Count - 1 do begin
                                                Clear(IleDocno);
                                                Clear(IlecustomLotNumber);
                                                Clear(IleDocLineno);
                                                Clear(IleItemNo);
                                                Clear(IleCusBOENo);
                                                Clear(IleVariantCode);
                                                if ILEJarray.Get(j, ILEJtoken) then begin
                                                    if ILEJtoken.AsObject().Get('documentNo', ILEsubJtoken) then
                                                        IleDocno := ILEsubJtoken.AsValue().AsText();
                                                    Clear(ILEsubJtoken);
                                                    if ILEJtoken.AsObject().Get('customLotNumber', ILEsubJtoken) then
                                                        IlecustomLotNumber := ILEsubJtoken.AsValue().AsText();
                                                    Clear(ILEsubJtoken);
                                                    if ILEJtoken.AsObject().Get('documentLineNo', ILEsubJtoken) then
                                                        IleDocLineno := ILEsubJtoken.AsValue().AsInteger();
                                                    Clear(ILEsubJtoken);
                                                    if ILEJtoken.AsObject().Get('itemNo', ILEsubJtoken) then
                                                        IleItemNo := ILEsubJtoken.AsValue().AsText();
                                                    Clear(ILEsubJtoken);
                                                    if ILEJtoken.AsObject().Get('customBOENumber', ILEsubJtoken) then
                                                        IleCusBOENo := ILEsubJtoken.AsValue().AsText();
                                                    Clear(ILEsubJtoken);
                                                    if ILEJtoken.AsObject().Get('variantCode', ILEsubJtoken) then
                                                        IleVariantCode := ILEsubJtoken.AsValue().AsText();
                                                    Clear(ILEsubJtoken);
                                                    if (IleDocno <> '') then begin
                                                        Posloturl := 'https://api.businesscentral.dynamics.com/v2.0/' + CompInfo_lrec."IC Tenant ID" + '/' + CompInfo_lrec."IC Tenant Name" + '/api/ISPL/API/v2.0/companies('
                                                                                                        + ICPartner."API Company ID" + ')/apiPostLotVarTestParameter?$filter=sourceID eq ''' + IleDocno + ''' and sourceRefNo eq '
                                                                                                            + Format(IleDocLineno) + ' and itemNo eq ''' + IleItemNo + ''' and lotNo eq ''' +
                                                                                                             IlecustomLotNumber + ''' and boeNo eq ''' + IleCusBOENo + ''' and variantCode eq ''' + IleVariantCode + '''';
                                                        Clear(oAuth2);
                                                        Clear(Accesstoken);
                                                        OAuth2.AcquireTokenWithClientCredentials(ClientID_lTxt, SecretKey_lTxt, TockenURL_lTxt, '', Scopes, Accesstoken);

                                                        PoslotgHttpClient.Clear();
                                                        Clear(PoslotgHttpClient);
                                                        Clear(PoslotgreqMsg);
                                                        Clear(PoslotgResponseMsg);

                                                        lheaders.Clear();
                                                        PoslotBody_gcontent.GetHeaders(lheaders);

                                                        //Application/Json
                                                        lheaders.Remove('Content-Type');
                                                        lheaders.Add('Content-Type', 'application/json');
                                                        PoslotBody_gcontent.GetHeaders(lheaders);

                                                        PoslotgreqMsg.SetRequestUri(Posloturl);
                                                        PoslotgreqMsg.Content(PoslotBody_gcontent);
                                                        PoslotgreqMsg.GetHeaders(lheaders);
                                                        PoslotgreqMsg.Method := 'GET';
                                                        PoslotgHttpClient.DefaultRequestHeaders().Add('Authorization', 'Bearer ' + AccessToken);
                                                        if not PoslotgHttpClient.Send(PoslotgreqMsg, PoslotgResponseMsg) then
                                                            Error('API Authorization token request failed...');

                                                        PoslotJSONResponse := '';
                                                        PoslotgResponseMsg.Content().ReadAs(PoslotJSONResponse);

                                                        PoslotJtoken.ReadFrom(PoslotJSONResponse);
                                                        PoslotJObject.ReadFrom(PoslotJSONResponse);

                                                        PoslotJObject := PoslotJtoken.AsObject();
                                                        Clear(PoslotsubJtoken);

                                                        if PoslotJObject.Get('error', PoslotJtoken) then
                                                            Error(ILEJSONResponse);

                                                        if PoslotJObject.Get('value', PoslotJtoken) then begin
                                                            PoslotJarray := PoslotJtoken.AsArray();
                                                            for k := 0 to PoslotJarray.Count - 1 do begin

                                                                if PoslotJarray.Get(k, PoslotJtoken) then begin
                                                                    Clear(PostedLotVariantTestingParameterAPI);
                                                                    if PoslotJtoken.AsObject().Get('sourceID', poslotsubJtoken) then
                                                                        PostedLotVariantTestingParameterAPI."Source ID" := poslotsubJtoken.AsValue().AsText();
                                                                    Clear(poslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('sourceRefNo', poslotsubJtoken) then
                                                                        PostedLotVariantTestingParameterAPI."Source Ref. No." := poslotsubJtoken.AsValue().AsInteger();
                                                                    Clear(poslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('itemNo', poslotsubJtoken) then
                                                                        PostedLotVariantTestingParameterAPI."Item No." := poslotsubJtoken.AsValue().AsText();
                                                                    Clear(poslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('lotNo', poslotsubJtoken) then
                                                                        PostedLotVariantTestingParameterAPI."Lot No." := poslotsubJtoken.AsValue().AsText();
                                                                    Clear(poslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('boeNo', poslotsubJtoken) then
                                                                        PostedLotVariantTestingParameterAPI."BOE No." := poslotsubJtoken.AsValue().AsText();
                                                                    Clear(poslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('code', poslotsubJtoken) then
                                                                        PostedLotVariantTestingParameterAPI."Code" := poslotsubJtoken.AsValue().AsText();
                                                                    Clear(poslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('testingParameter', poslotsubJtoken) then
                                                                        PostedLotVariantTestingParameterAPI."Testing Parameter" := poslotsubJtoken.AsValue().AsText();
                                                                    Clear(poslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('minimum', poslotsubJtoken) then
                                                                        PostedLotVariantTestingParameterAPI."Minimum" := poslotsubJtoken.AsValue().AsDecimal();
                                                                    Clear(poslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('maximum', poslotsubJtoken) then
                                                                        PostedLotVariantTestingParameterAPI."Maximum" := poslotsubJtoken.AsValue().AsDecimal();
                                                                    Clear(poslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('value', poslotsubJtoken) then
                                                                        PostedLotVariantTestingParameterAPI."Value" := poslotsubJtoken.AsValue().AsText();
                                                                    Clear(poslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('actualValue', poslotsubJtoken) then
                                                                        PostedLotVariantTestingParameterAPI."Actual Value" := poslotsubJtoken.AsValue().AsText();
                                                                    Clear(poslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('dataType', poslotsubJtoken) then
                                                                        Evaluate(PostedLotVariantTestingParameterAPI."Data Type", poslotsubJtoken.AsValue().AsText());
                                                                    Clear(poslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('symbol', poslotsubJtoken) then
                                                                        Evaluate(PostedLotVariantTestingParameterAPI.Symbol, poslotsubJtoken.AsValue().AsText());
                                                                    Clear(poslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('ofSpec', poslotsubJtoken) then
                                                                        PostedLotVariantTestingParameterAPI."Of Spec" := PoslotsubJtoken.AsValue().AsBoolean();
                                                                    Clear(poslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('value2', PoslotsubJtoken) then
                                                                        PostedLotVariantTestingParameterAPI.Value2 := PoslotsubJtoken.AsValue().AsText();
                                                                    Clear(PoslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('priority', PoslotsubJtoken) then
                                                                        PostedLotVariantTestingParameterAPI.Priority := PoslotsubJtoken.AsValue().AsInteger();
                                                                    Clear(PoslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('showInCOA', PoslotsubJtoken) then
                                                                        PostedLotVariantTestingParameterAPI."Show in COA" := PoslotsubJtoken.AsValue().AsBoolean();
                                                                    Clear(PoslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('defaultValue', PoslotsubJtoken) then
                                                                        PostedLotVariantTestingParameterAPI."Default Value" := PoslotsubJtoken.AsValue().AsBoolean();
                                                                    Clear(PoslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('testingParameterCode', PoslotsubJtoken) then
                                                                        PostedLotVariantTestingParameterAPI."Testing Parameter Code" := PoslotsubJtoken.AsValue().AsCode();
                                                                    Clear(PoslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('variantCode', PoslotsubJtoken) then
                                                                        PostedLotVariantTestingParameterAPI."Variant Code" := PoslotsubJtoken.AsValue().AsCode();
                                                                    Clear(PoslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('type', PoslotsubJtoken) then
                                                                        Evaluate(PostedLotVariantTestingParameterAPI.Type, PoslotsubJtoken.AsValue().AsText());
                                                                    Clear(PoslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('result', PoslotsubJtoken) then
                                                                        Evaluate(PostedLotVariantTestingParameterAPI.Result, PoslotsubJtoken.AsValue().AsText());
                                                                    Clear(PoslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('vendorCOAValueResult', PoslotsubJtoken) then
                                                                        PostedLotVariantTestingParameterAPI."Vendor COA Value Result" := PoslotsubJtoken.AsValue().AsDecimal();
                                                                    Clear(PoslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('vendorCOATextResult', PoslotsubJtoken) then
                                                                        PostedLotVariantTestingParameterAPI."Vendor COA Text Result" := PoslotsubJtoken.AsValue().AsText();
                                                                    Clear(PoslotsubJtoken);
                                                                    if PoslotJtoken.AsObject().Get('roundingPrecision', PoslotsubJtoken) then
                                                                        PostedLotVariantTestingParameterAPI."Rounding Precision" := PoslotsubJtoken.AsValue().Asdecimal();
                                                                    Clear(PoslotsubJtoken);


                                                                    if LotVariantTestingParameter.Get(PurchLine."Document No.", PurchLine."Line No.", PurchLine."No.", PurchLine."Variant Code", PostedLotVariantTestingParameterAPI."Lot No.", '', PostedLotVariantTestingParameterAPI.Code) then begin
                                                                        // LotVariantTestingParameter.Validate("Actual Value", PostedLotVariantTestingParameterAPI."Actual Value");
                                                                        if LotVariantTestingParameter.Type = LotVariantTestingParameter.Type::Text then
                                                                            LotVariantTestingParameter.Validate("Vendor COA Text Result", PostedLotVariantTestingParameterAPI."Vendor COA Text Result")
                                                                        else
                                                                            LotVariantTestingParameter.Validate("Vendor COA Value Result", PostedLotVariantTestingParameterAPI."Vendor COA Value Result");

                                                                        if LotVariantTestingParameter.Modify() then;
                                                                    end else begin
                                                                        LotVariantTestingParameter.Init();
                                                                        LotVariantTestingParameter.TransferFields(PostedLotVariantTestingParameterAPI);
                                                                        LotVariantTestingParameter."BOE No." := '';
                                                                        LotVariantTestingParameter."Source ID" := PurchLine."Document No.";
                                                                        LotVariantTestingParameter."Source Ref. No." := PurchLine."Line No.";
                                                                        LotVariantTestingParameter."Variant Code" := PurchLine."Variant Code";
                                                                        if LotVariantTestingParameter.Insert() then;
                                                                    end;
                                                                end
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    End;//T51170-N
                until PurchLine.Next() = 0;

            end; //AJAY <<
        end;
    end;



    //T13919IC API -NE



}