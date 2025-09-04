codeunit 60011 "Iris Web service"//T12370-N
{
    trigger OnRun()
    begin

        InvokeWebservice();
    end;

    local procedure InvokeWebservice()
    var
        HttpClient: HttpClient;
        HttpResponse: HttpResponseMessage;
        HttpHeadrs: HttpHeaders;
        HttpContent: HttpContent;
        ResponseJsonObject: JsonObject;
    begin
        Clear(Response);
        IsSuccess := false;
        HttpClient.SetBaseAddress(URL);
        HttpContent.WriteFrom(BodyText);
        HttpContent.GetHeaders(HttpHeadrs);
        HttpHeadrs.Remove('Content-Type');
        HttpHeadrs.Add('Content-Type', 'application/json');
        HttpClient.DefaultRequestHeaders.Add('User-Agent', 'Dynamics 365');
        HttpClient.DefaultRequestHeaders.TryAddWithoutValidation('Content-Type', 'application/json');
        if not IsTokenCall then begin
            HttpClient.DefaultRequestHeaders.TryAddWithoutValidation('companyId', CompanyId);
            HttpClient.DefaultRequestHeaders.TryAddWithoutValidation('X-Auth-Token', Token);
            HttpClient.DefaultRequestHeaders.TryAddWithoutValidation('product', 'ONYX');

        end;
        if IsCancel then begin
            if HttpClient.Put(URL, HttpContent, HttpResponse) then begin
                if HttpResponse.IsSuccessStatusCode() then begin
                    HttpResponse.Content().ReadAs(Response);
                    IsSuccess := true;
                end else begin
                    HttpResponse.Content().ReadAs(Response);
                    IsSuccess := false;
                end;
            end else
                Error('Something went wrong while connecting IRIS server. %1', HttpResponse.ReasonPhrase);
        end else begin
            if HttpClient.Post(URL, HttpContent, HttpResponse) then begin
                if HttpResponse.IsSuccessStatusCode() then begin
                    HttpResponse.Content().ReadAs(Response);
                    IsSuccess := true;
                end else begin
                    HttpResponse.Content().ReadAs(Response);
                    IsSuccess := false;
                end;
            end else
                Error('Something went wrong while connecting IRIS server. %1', HttpResponse.ReasonPhrase);
        end;

    end;

    procedure GetResponse(Var IsSuccessp: Boolean; var Responsep: Text)
    begin
        IsSuccessp := IsSuccess;
        Responsep := Response;
    end;

    procedure SetWebseriveProperties(URLP: Text; BodyTextP: Text; IsTokenCallp: Boolean; Tokenp: Text; CompanyIdp: Text[10]; IsCancelp: Boolean)
    begin
        URL := URLP;
        BodyText := BodyTextP;
        IsTokenCall := IsTokenCallp;
        Token := Tokenp;
        CompanyId := CompanyIdp;
        IsCancel := IsCancelp;
    end;

    var
        URL: Text;
        BodyText: Text;
        Response: Text;
        IsSuccess: Boolean;
        IsTokenCall: Boolean;
        Token: Text;
        CompanyId: Text[10];
        IsCancel: Boolean;
}