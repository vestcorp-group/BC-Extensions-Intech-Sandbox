codeunit 75001 "Verify Email Address"
{
    //VerifyEmail-NS
    [EventSubscriber(ObjectType::Table, Database::"Customer", 'OnBeforeValidateEvent', 'E-Mail', true, true)]
    local procedure "Customer_OnBeforeValidateEvent_E-Mail"
    (
        var Rec: Record "Customer";
        var xRec: Record "Customer";
        CurrFieldNo: Integer
    )
    begin
        VerifyEmailAddress(Rec."E-Mail");
    end;


    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnBeforeValidateEvent', 'E-Mail', true, true)]
    local procedure "Vendor_OnBeforeValidateEvent_E-Mail"
    (
        var Rec: Record "Vendor";
        var xRec: Record "Vendor";
        CurrFieldNo: Integer
    )
    begin
        VerifyEmailAddress(Rec."E-Mail");
    end;


    [EventSubscriber(ObjectType::Table, Database::"Salesperson/Purchaser", 'OnBeforeValidateEvent', 'E-Mail', true, true)]
    local procedure "Salesperson_OnBeforeValidateEvent_E-Mail"
(
    var Rec: Record "Salesperson/Purchaser";
    var xRec: Record "Salesperson/Purchaser";
    CurrFieldNo: Integer
)
    begin
        VerifyEmailAddress(Rec."E-Mail");
    end;

    [EventSubscriber(ObjectType::Table, Database::Location, 'OnBeforeValidateEvent', 'E-Mail', true, true)]
    local procedure "Location_OnBeforeValidateEvent_E-Mail"
(
    var Rec: Record "Location";
    var xRec: Record "Location";
    CurrFieldNo: Integer
)
    begin
        VerifyEmailAddress(Rec."E-Mail");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeValidateEvent', 'Sell-to E-Mail', true, true)]
    local procedure "SalesHEader_OnBeforeValidateEvent_E-Mail"
(
    var Rec: Record "Sales Header";
    var xRec: Record "Sales Header";
    CurrFieldNo: Integer
)
    begin
        VerifyEmailAddress(Rec."Sell-to E-Mail");
    end;


    [EventSubscriber(ObjectType::Table, Database::"Document Sending Profile", 'OnBeforeValidateEvent', 'E-Mail', true, true)]
    local procedure "DocumentSending_OnBeforeValidateEvent_E-Mail"
(
    var Rec: Record "Document Sending Profile";
    var xRec: Record "Document Sending Profile";
    CurrFieldNo: Integer
)
    var
        Email_lTex: Text[80];
    begin
        Email_lTex := Format(Rec."E-Mail Format");
        VerifyEmailAddress(Email_lTex);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Company Information", 'OnBeforeValidateEvent', 'E-Mail', true, true)]
    local procedure "CompanyInformation_OnBeforeValidateEvent_E-Mail"
(
    var Rec: Record "Company Information";
    var xRec: Record "Company Information";
    CurrFieldNo: Integer
)
    begin
        VerifyEmailAddress(Rec."E-Mail");
    end;

    [EventSubscriber(ObjectType::Table, Database::Job, 'OnBeforeValidateEvent', 'Sell-to E-Mail', true, true)]
    local procedure "Job_OnBeforeValidateEvent_E-Mail"
(
    var Rec: Record "Job";
    var xRec: Record "Job";
    CurrFieldNo: Integer
)
    begin
        VerifyEmailAddress(Rec."Sell-to E-Mail");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Ship-to Address", 'OnBeforeValidateEvent', 'E-Mail', true, true)]
    local procedure "ShiptoAddress_OnBeforeValidateEvent_E-Mail"
(
    var Rec: Record "Ship-to Address";
    var xRec: Record "Ship-to Address";
    CurrFieldNo: Integer
)
    begin
        VerifyEmailAddress(Rec."E-Mail");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Order Address", 'OnBeforeValidateEvent', 'E-Mail', true, true)]
    local procedure "OrderAddress_OnBeforeValidateEvent_E-Mail"
(
    var Rec: Record "Order Address";
    var xRec: Record "Order Address";
    CurrFieldNo: Integer
)
    begin
        VerifyEmailAddress(Rec."E-Mail");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Bank Account", 'OnBeforeValidateEvent', 'E-Mail', true, true)]
    local procedure "BankAccount_OnBeforeValidateEvent_E-Mail"
(
    var Rec: Record "Bank Account";
    var xRec: Record "Bank Account";
    CurrFieldNo: Integer
)
    begin
        VerifyEmailAddress(Rec."E-Mail");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Customer Bank Account", 'OnBeforeValidateEvent', 'E-Mail', true, true)]
    local procedure "CustomerBankAccount_OnBeforeValidateEvent_E-Mail"
(
    var Rec: Record "Customer Bank Account";
    var xRec: Record "Customer Bank Account";
    CurrFieldNo: Integer
)
    begin
        VerifyEmailAddress(Rec."E-Mail");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Vendor Bank Account", 'OnBeforeValidateEvent', 'E-Mail', true, true)]
    local procedure "VendorBankAccount_OnBeforeValidateEvent_E-Mail"
(
    var Rec: Record "Vendor Bank Account";
    var xRec: Record "Vendor Bank Account";
    CurrFieldNo: Integer
)
    begin
        VerifyEmailAddress(Rec."E-Mail");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Customer Templ.", 'OnBeforeValidateEvent', 'E-Mail', true, true)]
    local procedure "CustomerTempl_OnBeforeValidateEvent_E-Mail"
(
  var Rec: Record "Customer Templ.";
  var xRec: Record "Customer Templ.";
  CurrFieldNo: Integer
)
    begin
        VerifyEmailAddress(Rec."E-Mail");
    end;


    [EventSubscriber(ObjectType::Table, Database::"Vendor Templ.", 'OnBeforeValidateEvent', 'E-Mail', true, true)]
    local procedure "VendorTempl_OnBeforeValidateEvent_E-Mail"
  (
      var Rec: Record "Vendor Templ.";
      var xRec: Record "Vendor Templ.";
      CurrFieldNo: Integer
  )
    begin
        VerifyEmailAddress(Rec."E-Mail");
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeValidateEvent', 'E-Mail', true, true)]
    local procedure "Contact_OnBeforeValidateEvent_E-Mail"
(
   var Rec: Record "Contact";
   var xRec: Record "Contact";
   CurrFieldNo: Integer
)
    begin
        VerifyEmailAddress(Rec."E-Mail");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Contact Alt. Address", 'OnBeforeValidateEvent', 'E-Mail', true, true)]
    local procedure "Contact Alt. Address_OnBeforeValidateEvent_E-Mail"
(
var Rec: Record "Contact Alt. Address";
var xRec: Record "Contact Alt. Address";
CurrFieldNo: Integer
)
    begin
        VerifyEmailAddress(Rec."E-Mail");
    end;


    [EventSubscriber(ObjectType::Table, Database::Employee, 'OnBeforeValidateEvent', 'E-Mail', true, true)]
    local procedure "Employee_OnBeforeValidateEvent_E-Mail"
 (
 var Rec: Record "Employee";
 var xRec: Record "Employee";
 CurrFieldNo: Integer
 )
    begin
        VerifyEmailAddress(Rec."E-Mail");
    end;


    [EventSubscriber(ObjectType::Table, Database::"Alternative Address", 'OnBeforeValidateEvent', 'E-Mail', true, true)]
    local procedure "Alternative Address_OnBeforeValidateEvent_E-Mail"
 (
 var Rec: Record "Alternative Address";
 var xRec: Record "Alternative Address";
 CurrFieldNo: Integer
 )
    begin
        VerifyEmailAddress(Rec."E-Mail");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Responsibility Center", 'OnBeforeValidateEvent', 'E-Mail', true, true)]
    local procedure "Responsibility Center_OnBeforeValidateEvent_E-Mail"
(
var Rec: Record "Responsibility Center";
var xRec: Record "Responsibility Center";
CurrFieldNo: Integer
)
    begin
        VerifyEmailAddress(Rec."E-Mail");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Service Header", 'OnBeforeValidateEvent', 'E-Mail', true, true)]
    local procedure "Service Header_OnBeforeValidateEvent_E-Mail"
  (
  var Rec: Record "Service Header";
  var xRec: Record "Service Header";
  CurrFieldNo: Integer
  )
    begin
        VerifyEmailAddress(Rec."E-Mail");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Service Contract Header", 'OnBeforeValidateEvent', 'E-Mail', true, true)]
    local procedure "Service Contract Header_OnBeforeValidateEvent_E-Mail"
(
var Rec: Record "Service Contract Header";
var xRec: Record "Service Contract Header";
CurrFieldNo: Integer
)
    begin
        VerifyEmailAddress(Rec."E-Mail");
    end;


    [EventSubscriber(ObjectType::Table, Database::"Filed Service Contract Header", 'OnBeforeValidateEvent', 'E-Mail', true, true)]
    local procedure "Filed Service Contract Header_OnBeforeValidateEvent_E-Mail"
(
var Rec: Record "Filed Service Contract Header";
var xRec: Record "Filed Service Contract Header";
CurrFieldNo: Integer
)
    begin
        VerifyEmailAddress(Rec."E-Mail");
    end;









    procedure VerifyEmailAddress(Var Recipients: Text)
    var
        EmailAct_lCdu: Codeunit "Email Account";
        LastChr_lTxt: Text;
    begin
        IF Recipients = '' then
            Exit;

        Recipients := DELCHR(Recipients, '<>', ' ');    //Trim

        CleanCRLFTAB_gFnc(Recipients);  //NG-N Delete New line and tab Char

        IF STRPOS(Recipients, ';') <> 0 THEN BEGIN  //System doesn't work if the email address end with semi colon  /ex: nileshg@intech-systems.com;
            LastChr_lTxt := COPYSTR(Recipients, STRLEN(Recipients));
            IF LastChr_lTxt = ';' THEN
                Recipients := COPYSTR(Recipients, 1, STRPOS(Recipients, ';') - 1);
        END;

        IF STRPOS(Recipients, ',') <> 0 THEN BEGIN  //System doesn't work if the email address end with Comma  /ex: nileshg@intech-systems.com,
            LastChr_lTxt := COPYSTR(Recipients, STRLEN(Recipients));
            IF LastChr_lTxt = ',' THEN
                Recipients := COPYSTR(Recipients, 1, STRPOS(Recipients, ',') - 1);
        END;


        if Recipients <> '' then
            EmailAct_lCdu.ValidateEmailAddresses(Recipients);
    end;

    procedure CleanCRLFTAB_gFnc(var InputTxt_vTxt: Text[250])
    var
        Ch: Text[3];
    begin
        //DELETE TAB Char
        Ch[1] := 9;  // TAB
        Ch[2] := 13; // CR - Carriage Return
        Ch[3] := 10; // LF - Line Feed
        InputTxt_vTxt := DelChr(InputTxt_vTxt, '=', Ch);
    end;
    //VerifyEmail-NE    
}
