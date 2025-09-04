codeunit 60016 "GET Iris Invoice"//T12370-N
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
        HttpContent.GetHeaders(HttpHeadrs);
        HttpHeadrs.Remove('Content-Type');
        HttpHeadrs.Add('Content-Type', 'application/json');
        HttpClient.DefaultRequestHeaders.Add('User-Agent', 'Dynamics 365');
        HttpClient.DefaultRequestHeaders.TryAddWithoutValidation('Content-Type', 'application/json');
        if not IsTokenCall then begin
            HttpClient.DefaultRequestHeaders.TryAddWithoutValidation('companyId', CompanyId);
            HttpClient.DefaultRequestHeaders.TryAddWithoutValidation('X-Auth-Token', Token);
            HttpClient.DefaultRequestHeaders.TryAddWithoutValidation('product', 'ONYX');
            // HttpClient.DefaultRequestHeaders.TryAddWithoutValidation('template', 'STANDARD');
            // HttpClient.DefaultRequestHeaders.TryAddWithoutValidation('id', InvoiceId);
        end;
        if HttpClient.GET(URL, HttpResponse) then begin
            if HttpResponse.IsSuccessStatusCode() then begin
                HttpResponse.Content().ReadAs(ResStream);
                IsSuccess := true;
            end else begin
                HttpResponse.Content().ReadAs(Response);
                IsSuccess := false;
            end;
        end else
            Error('Something went wrong while connecting IRIS server. %1', HttpResponse.ReasonPhrase)
    end;

    procedure GetResponse(Var IsSuccessp: Boolean; var Responsep: Text)
    begin
        IsSuccessp := IsSuccess;
        Responsep := Response;
    end;

    procedure GetResStream(): InStream
    begin
        exit(ResStream)
    end;

    procedure SetWebseriveProperties(URLP: Text; IsTokenCallp: Boolean; Tokenp: Text; CompanyIdp: Text[10])
    begin
        URL := URLP;
        IsTokenCall := IsTokenCallp;
        Token := Tokenp;
        CompanyId := CompanyIdp;
    end;

    var
        URL: Text;
        InvoiceId: Text;
        Response: Text;
        IsSuccess: Boolean;
        IsTokenCall: Boolean;
        Token: Text;
        CompanyId: Text[10];
        ResStream: InStream;
}