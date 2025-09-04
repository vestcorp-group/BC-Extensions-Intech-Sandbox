codeunit 85655 "API Call for GroupGRNDate"//T14049
{
    TableNo = "Purchase Header";


    // [EventSubscriber(ObjectType::Codeunit, Codeunit::ICInboxOutboxMgt, 'OnAfterCreatePurchDocument', '', true, true)]  //Hypercare use later-Anoop-Dhiren
    // procedure ICtrackingLineCopy_API(var PurchaseHeader: Record "Purchase Header"; ICInboxPurchaseHeader: Record "IC Inbox Purchase Header")
    //procedure APICall(PurchaseHeader: Record "Purchase Header")


    trigger OnRun()
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
        GroupGRNStageQcDetails_lRec: Record "Stagging Group GRN Details";
        FromIle_lRec: Record "Item Ledger Entry";
        FromPurchaseReceiptHeader_lRec: Record "Purch. Rcpt. Header";

        Vendor: Record Vendor;
    begin
        CompInfo_lrec.get();
        //GroupGRNStageQcDetails_lRec.DeleteAll;


        if Rec."Document Type" = rec."Document Type"::Order then begin
            Vendor.get(rec."Buy-from Vendor No.");
            PurchLine.SetRange("Document Type", PurchLine."Document Type"::Order);
            PurchLine.SetRange("Document No.", rec."No.");
            if PurchLine.FindSet() then begin
                repeat

                    if ICPartner.Get(Vendor."IC Partner Code") then;
                    if ICPartner."Data Exchange Type" = ICPartner."Data Exchange Type"::API then begin
                        CompInfo_lrec.TestField("IC Tenant ID");
                        CompInfo_lrec.TestField("IC Tenant Name");
                        CompInfo_lrec.TestField("Client ID");
                        CompInfo_lrec.TestField("Secret ID");
                        ICPartner.TestField("API Company ID");
                        lurl := 'https://api.businesscentral.dynamics.com/v2.0/' + CompInfo_lrec."IC Tenant ID" + '/' + CompInfo_lrec."IC Tenant Name" + '/api/ISPL/API/v2.0/companies(' + ICPartner."API Company ID" + ')/apiSalesShipmentLineIC?$filter=orderNo eq ''' + Rec."Vendor Order No." + ''' and lineNo eq ' + Format(PurchLine."Line No."); //Replace
                        //lurl := 'https://api.businesscentral.dynamics.com/v2.0/' + CompInfo_lrec."IC Tenant ID" + '/' + CompInfo_lrec."IC Tenant Name" + '/api/ISPL/API/v2.0/companies(' + ICPartner."API Company ID" + ')/apiSalesShipmentLine?$filter=orderNo eq ''' + ICInboxPurchaseHeader."No." + ''' and lineNo eq ' + Format(PurchLine."Line No.");

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
                                                    + ICPartner."API Company ID" + ')/apiItemLedgerEntriesICBatch?$filter=documentNo eq ''' + DocumentNo_Ltxt + ''' and documentType eq '''
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
                                                        //comment by Anoop if ReserEntryL.Insert() then;
                                                        PurchLine."Location Code" := SalesShipLocationCode_lTxt;
                                                        //comment by Anoop PurchLine.Modify();
                                                        //Stagging for ILE-FromTo-NS
                                                        FromPurchaseReceiptHeader_lRec.reset;
                                                        FromPurchaseReceiptHeader_lRec.SetRange("Order No.", Rec."No.");
                                                        if FromPurchaseReceiptHeader_lRec.FindFirst() then begin//Need to dicuss single/Multi
                                                            FromIle_lRec.reset;
                                                            FromIle_lRec.SetRange("Document No.", FromPurchaseReceiptHeader_lRec."No.");
                                                            FromIle_lRec.SetRange("Document Line No.", PurchLine."Line No.");
                                                            FromIle_lRec.SetRange("Item No.", PurchLine."No.");
                                                            FromIle_lRec.SetRange(CustomLotNumber, IlecustomLotNumber);
                                                            FromIle_lRec.SetRange("Variant Code", IleVariantCode);
                                                            if FromIle_lRec.FindFirst() then begin
                                                                Clear(GroupGRNStageQcDetails_lRec);

                                                                GroupGRNStageQcDetails_lRec.init;
                                                                GroupGRNStageQcDetails_lRec."From Entry No." := FromIle_lRec."Entry No.";
                                                                GroupGRNStageQcDetails_lRec."From Group GRN Date" := FromIle_lRec."Group GRN Date";
                                                                GroupGRNStageQcDetails_lRec."From Company" := CompanyName;
                                                                GroupGRNStageQcDetails_lRec."GRN No" := FromPurchaseReceiptHeader_lRec."No.";
                                                                GroupGRNStageQcDetails_lRec."Shipment No" := DocumentNo_Ltxt;
                                                                GroupGRNStageQcDetails_lRec."To Entry No." := IleEntryNo;
                                                                GroupGRNStageQcDetails_lRec."To Company" := ICPartner.Name;
                                                                GroupGRNStageQcDetails_lRec."To Group GRN Date" := ileGRNdate;
                                                                GroupGRNStageQcDetails_lRec."Lot No" := IlecustomLotNumber;
                                                                GroupGRNStageQcDetails_lRec."Item No" := PurchLine."No.";
                                                                GroupGRNStageQcDetails_lRec.Insert();
                                                            end;
                                                        end;
                                                        //Stagging for ILE-FromTo-NE
                                                        /* Postqcurl := 'https://api.businesscentral.dynamics.com/v2.0/' + CompInfo_lrec."IC Tenant ID" + '/' + CompInfo_lrec."IC Tenant Name" + '/api/ISPL/API/v2.0/companies('
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
                                                                    StageQcDetails_lRec."Purchase Order No." := PurchLine."Document No.";
                                                                    StageQcDetails_lRec."Purchase Order Line No." := PurchLine."Line No.";
                                                                    StageQcDetails_lRec."ILE Entry No." := IleEntryNo;
                                                                    StageQcDetails_lRec."ILE Lot No." := IlecustomLotNumber;
                                                                    StageQcDetails_lRec.Insert();
                                                                end;
                                                            end;
                                                        end; */
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                        /* end else begin //Hypercare 07-03-2025
                            if ICPartner."Data Exchange Type" = ICPartner."Data Exchange Type"::Database then begin

                                SalesShipmentLine.ChangeCompany(ICPartner."Inbox Details");
                                ILE.ChangeCompany(ICPartner."Inbox Details");
                                PostedQCReceiptHdr_lRec.ChangeCompany(ICPartner."Inbox Details");
                                PostedQCReceiptLine_lRec.ChangeCompany(ICPartner."Inbox Details");
                                //SalesShipmentLine.SetRange("Order No.", ICInboxPurchaseHeader."No.");//old
                                SalesShipmentLine.SetRange("Order No.", PurchaseHeader."No.");
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
                                                            StageQcDetails_lRec."Sample Collector ID" := PostedQCReceiptHdr_lRec."Sample Collector ID";
                                                            StageQcDetails_lRec."Sample Provider ID" := PostedQCReceiptHdr_lRec."Sample Provider ID";
                                                            StageQcDetails_lRec."Date of Sample Collection" := PostedQCReceiptHdr_lRec."Date of Sample Collection";
                                                            StageQcDetails_lRec."Purchase Order No." := PurchLine."Document No.";
                                                            StageQcDetails_lRec."Purchase Order Line No." := PurchLine."Line No.";
                                                            StageQcDetails_lRec."ILE Entry No." := ILE."Entry No.";
                                                            StageQcDetails_lRec."ILE Lot No." := ILE.CustomLotNumber;
                                                            StageQcDetails_lRec.Insert();
                                                        until PostedQCReceiptLine_lRec.next = 0;
                                                end;
                                            until ILE.Next() = 0;
                                        end;
                                    until SalesShipmentLine.Next() = 0;
                                end;
                            end; */
                    end;//Hypercare 07-03-2025
                //Note: Changes for Database Base Intercompany Code in Kemipex Buisness App
                until PurchLine.Next() = 0;
            end;
        end;
        // end;
    end; //ICTransaction Testing Rakshith & Mayank 25-02-2025
}