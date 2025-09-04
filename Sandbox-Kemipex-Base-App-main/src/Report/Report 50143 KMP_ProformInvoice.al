
//Report link has added into the sales order page. Action name called as "UN Proforma Invoice". The extension page name is KMP_PageExtSalesHdr
report 50143 KMP_ProformInvoice//T12370-N
{
    UsageCategory = Administration;
    ApplicationArea = All;
    RDLCLayout = './Layouts/KMP_ProformInvoice.rdl';
    Caption = 'UN Proforma Invoice Report';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            RequestFilterFields = "No.";
            column(No_; "No.") { }
            column(Document_Date; "Document Date") { }
            column(Document_Type; "Document Type") { }
            column(Bill_to_Name; "Bill-to Name") { }
            column(CompName; CompanyInformation.Name) { }
            column(CompLogo; CompanyInformation.Picture) { }
            column(AmtinWord_GTxt; AmtinWord_GTxt[1] + ' ' + AmtinWord_GTxt[2]) { }
            column(AmtinWord_GTxtNew; AmtinWord_GTxtNew[1] + ' ' + AmtinWord_GTxtNew[2]) { }
            column(CompAddr1; CompanyInformation.Address) { }
            column(CompAddr2; CompanyInformation."Address 2") { }
            column(Telephone; CompanyInformation."Phone No.") { }
            column(TRNNo; CompanyInformation."VAT Registration No.") { }
            column(IndustrialClassification; CompanyInformation."Industrial Classification") { }
            column(RegistrationNo; CompanyInformation."Registration No.") { }
            column(POBox; CompanyInformation."Post Code") { }
            column(CompCountry; CompanyInformation."Country/Region Code") { }
            column(Sell_to_Country_Region_Code; CountryG.Name) { }
            column(Shipping_Advice; "Shipping Advice") { }
            column(Exit_Point; EntryExitPointRecG.Description) { }
            column(Transport_Method; "Transport Method") { }
            column(PaymentTerms_Desc; PaymentTerms_Desc) { }
            column(Currency_Code; "Currency Code") { }
            column(Location_Code; LocationG.Name) { }
            column(Shipment_Date; "Shipment Date") { }
            column(CustName; "Sales Header"."Sell-to Customer Name") { }
            column(BuyerIdNumber; "Sales Header"."External Document No.") { }
            column(Work_Description; WorkDescG) { }
            column(CountryOfLoading; CountryOfLoadingG.Name) { }
            column(CustAddr_Arr1; CustAddr_Arr[1]) { }
            column(CustAddr_Arr2; CustAddr_Arr[2]) { }
            column(CustAddr_Arr3; CustAddr_Arr[3]) { }
            column(CustAddr_Arr4; CustAddr_Arr[4]) { }
            column(CustAddr_Arr5; CustAddr_Arr[5]) { }
            column(CustAddr_Arr6; CustAddr_Arr[6]) { }
            column(CustAddr_Arr7; CustAddr_Arr[7]) { }
            column(Cust_TRN; Cust_TRN) { }
            column(CustAddrShipto_Arr1; CustAddrShipto_Arr[1]) { }
            column(CustAddrShipto_Arr2; CustAddrShipto_Arr[2]) { }
            column(CustAddrShipto_Arr3; CustAddrShipto_Arr[3]) { }
            column(CustAddrShipto_Arr4; CustAddrShipto_Arr[4]) { }
            column(CustAddrShipto_Arr5; CustAddrShipto_Arr[5]) { }
            column(CustAddrShipto_Arr6; CustAddrShipto_Arr[6]) { }
            column(CustAddrShipto_Arr7; CustAddrShipto_Arr[7]) { }
            column(CustAddrShipto_Arr8; CustAddrShipto_Arr[8]) { }
            column(YourReferenceNo; "Your Reference") { }
            column(Validto; "Due Date") { }
            column(DeliveryTerms; TranSec_Desc) { }
            column(PaymentTerms; PaymentTerms_Desc) { }
            column(TotalIncludingCaption; TotalIncludingCaption) { }
            column(TotalAmt; TotalAmt) { }
            column(TotalAmountAED; TotalAmountAED) { }
            column(TotalVatAmtAED; TotalVatAmtAED) { }
            column(ExchangeRate; ExchangeRate) { }
            Column(BankName; BankName) { }
            Column(IBANNumber; IBANNumber) { }
            Column(SWIFTCode; SWIFTCode) { }
            column(Legalization_Required; "Legalization Required 2") { } //PackingListExtChange
            column(Inspection_Required; "Inspection Required 2") { } //PackingListExtChange
            column(PrintVATremark; PrintVATremark) { }
            column(Inspection_Caption; Inspection_Caption) { }
            column(TotalLineAmt; TotalLineAmt_G) { }
            column(TotalLineDiscount; TotalLineDiscount_G) { }
            column(TotalAmount; TotalAmount_G) { }
            column("Area"; "Area") { }

            dataitem(DataItem3; "Sales Comment Line")
            {
                DataItemLinkReference = "Sales Header";
                DataItemLink = "Document Type" = field("Document Type"), "No." = Field("No.");
                DataItemTableView = where("Document Line No." = filter(0));
                column(Comment; Comment) { }
                column(Line_No_; "Line No.") { }
                column(Document_Line_No_; "Document Line No.") { }
            }

            dataitem("Sales Line"; "Sales Line")
            {
                DataItemLinkReference = "Sales Header";
                DataItemLink = "document Type" = Field("Document Type"), "Document No." = FIELD("No.");
                column(SrNo; SrNo) { }
                column(LineNo; "Line No.") { }
                column(ItemNo; "No.")
                {
                    IncludeCaption = true;
                }
                column(IsItem; IsItem) { }
                column(Description; Description)
                {
                    IncludeCaption = true;
                }
                column(Quantity; "Quantity")
                {
                    IncludeCaption = true;
                }
                column(UnitofMeasureCode; "Base UOM 2") { } //PackingListExtChange
                column(UnitPrice; "Unit Price")
                {
                    IncludeCaption = true;
                }
                column(VatPer; "VAT %")
                {
                    IncludeCaption = true;
                }
                column(VatAmt; "VAT Base Amount" * "VAT %" / 100)
                {
                }
                column(AmountIncludingVAT; "Amount Including VAT")
                {
                    IncludeCaption = true;
                }
                column(SearchDesc; ItemG."Search Description")
                { }
                column(Origin; Origitext)
                { }
                column(HSCode; HSNCode)
                { }
                column(Packing; ItemG."Description 2")
                { }
                column(GenericName; ItemG."Generic Description") { }
                column(HSNCode; HSNCode) { }
                // column(Packing_Net_Weight; "Packing Net Weight") { }
                // column(Packing_Gross_Weight; "Packing Gross Weight") { }
                column(Line_Amount; "Line Amount") { }
                column(Line_Discount_Amount; "Line Discount Amount") { }

                // dataitem(DataItem3; "Sales Comment Line")
                // {
                //     DataItemLink = "Document Type" = field ("Document Type"), "No." = Field ("No.");
                //     DataItemTableView = where ("Document Line No." = filter (0));
                //     column(Comment; Comment) { }
                //     column(Line_No_; "Line No.") { }
                //     column(Document_Line_No_; "Document Line No.") { }
                // }

                // dataitem(DataItem4; Location)
                // {
                //     DataItemLink = Code = field ("Location Code");
                //     column(LocationCountry; DataItem4."Country/Region Code") { }
                // }

                trigger OnPreDataItem()
                begin
                    SrNo := 0;
                end;

                trigger OnAfterGetRecord()
                var
                    SalesLine_Lrec: Record "Sales Line";
                    Check_LRep: Report Check;
                    VatRegNo_Lctxt: Label 'VAT Registration No. %1';
                    DocumentError: Label 'Document must be released';
                begin
                    TotalAmt := 0;
                    TotalVatAmtAED := 0;
                    TotalAmountAED := 0;
                    Clear(ItemG);
                    SalesLine_Lrec.Reset;
                    SalesLine_Lrec.SetRange("Document Type", "Document Type");
                    SalesLine_Lrec.SetRange("Document No.", "No.");
                    if SalesLine_Lrec.FindSet(false) then
                        repeat
                            TotalAmt += SalesLine_Lrec."Amount Including VAT";
                            TotalVatAmtAED += SalesLine_Lrec."VAT Base Amount" * SalesLine_Lrec."VAT %" / 100
                        until SalesLine_Lrec.Next = 0;

                    TotalIncludingCaption := '';
                    ExchangeRate := '';
                    TotalAmountAED := TotalAmt;
                    If "Sales Header"."Currency Factor" <> 0 then begin
                        TotalIncludingCaption := StrSubstNo('Total %1 Amount Payable Incl. VAT', "Currency Code");
                        ExchangeRate := StrSubstNo(' Currency exchange rate for VAT calculation: %1 - %2', "Currency Code", ROUND(1 / "Sales Header"."Currency Factor", 0.00001, '='));
                        TotalVatAmtAED := TotalVatAmtAED / "Sales Header"."Currency Factor";
                        TotalAmountAED := TotalAmt / "Sales Header"."Currency Factor";
                    End ELSe begin
                        TotalIncludingCaption := 'Total Amount Payable Incl. VAT';
                        ExchangeRate := '';
                    End;
                    if "Currency Code" = '' then
                        ExchangeRate := '';
                    Clear(AmtinWord_GTxt);
                    Clear(Check_LRep);
                    Check_LRep.InitTextVariable;
                    Check_LRep.FormatNoText(AmtinWord_GTxt, TotalAmt, "Currency Code");
                    Clear(Check_LRep);
                    SrNo += 1;

                    if ("No." > '') and (Type = Type::Item) then
                        ItemG.Get("No.");
                end;
            }


            trigger OnAfterGetRecord()
            var
                SalesLineRec: Record "Sales Line";
                Check_LRep: Report Check;
                PaymentTerms_LRec: Record "Payment Terms";
                Bank_LRec: Record "Bank Account";
                TranSpec_rec: Record "Transaction Specification";
                Area_Rec: Record "Area";
                Cust_Lrec: Record Customer;
            begin

                WorkDescG := GetWorkDescription();

                Cust_TRN := '';
                PrintVATremark := false;
                Cust_Lrec.Reset();
                IF Cust_Lrec.get("Bill-to Customer No.") then begin
                    Cust_TRN := 'TRN : ' + Cust_Lrec."VAT Registration No.";
                    if (Cust_Lrec."VAT Bus. Posting Group" = 'C-LOCAL') AND CompanyisFZE then
                        PrintVATremark := TRUE;
                end;

                TotalLineAmt_G := 0;
                TotalLineDiscount_G := 0;
                TotalAmount_G := 0;
                SalesLineRec.Reset;
                SalesLineRec.SetRange("Document Type", "Document Type");
                SalesLineRec.SetRange("Document No.", "No.");
                if SalesLineRec.FindSet() then begin
                    repeat
                        TotalLineAmt_G += SalesLineRec."Line Amount";
                        TotalLineDiscount_G += SalesLineRec."Line Discount Amount";
                    until SalesLineRec.Next = 0;
                end;
                TotalAmount_G := TotalLineAmt_G - TotalLineDiscount_G;
                if "Currency Code" = '' then
                    ExchangeRate := '';
                Clear(AmtinWord_GTxtNew);
                Clear(Check_LRep);
                Check_LRep.InitTextVariable;
                Check_LRep.FormatNoText(AmtinWord_GTxtNew, TotalAmount_G, "Currency Code");
                Clear(Check_LRep);
                if CountryOfLoading > '' then
                    CountryOfLoadingG.Get(CountryOfLoading);
                if "Location Code" > '' then
                    LocationG.Get("Location Code");

                if "Sales Header"."Exit Point" > '' then
                    EntryExitPointRecG.Get("Sales Header"."Exit Point");
                CompanyInformation.Get();

                if "Sales Header"."Sell-to Country/Region Code" > '' then
                    CountryG.Get("Sales Header"."Sell-to Country/Region Code");

                Clear(CustAddr_Arr);
                FormatAddr.SalesHeaderBillTo(CustAddr_Arr, "Sales Header");

                Clear(CustAddrShipto_Arr);
                if "Sales Header"."Ship-to Code" <> '' THEN begin
                    CustAddrShipto_Arr[1] := "Sales Header"."Ship-to Name";
                    CustAddrShipto_Arr[2] := "Sales Header"."Ship-to Name 2";
                    CustAddrShipto_Arr[3] := "Sales Header"."Ship-to Contact";
                    CustAddrShipto_Arr[4] := "Sales Header"."Ship-to Address";
                    CustAddrShipto_Arr[5] := "Sales Header"."Ship-to Address 2";
                    CustAddrShipto_Arr[6] := "Sales Header"."Ship-to City";
                    CustAddrShipto_Arr[7] := "Sales Header"."Ship-to Post Code";
                    // CustAddrShipto_Arr[8] := "Sales Header"."Ship-to Country/Region Code";
                    Clear(CountryG);
                    CountryG.Get("Sales Header"."Ship-to Country/Region Code");
                    CustAddrShipto_Arr[8] := CountryG.Name;
                END;

                IF "Document Type" = "Document Type"::Quote then
                    reportText := 'Pro Forma Invoice / Price Quotation'
                else
                    If "Document Type" = "Document Type"::Order then
                        reportText := 'Pro Forma Invoice / Sales Order';


                //Message('%1 %2', "Sales Header"."Document Type", "Sales Header"."No.");
                PaymentTerms_Desc := '';
                If PaymentTerms_LRec.GET("Sales Header"."Payment Terms Code") then
                    PaymentTerms_Desc := PaymentTerms_LRec.Description;

                TranSec_Desc := '';
                IF TranSpec_rec.GET("Sales Header"."Transaction Specification") then
                    TranSec_Desc := TranSpec_rec.Text;
                IF Area_Rec.Get("Sales Header"."Area") then
                    TranSec_Desc := TranSec_Desc + ' ' + Area_Rec.Text;

                //PackingListExtChange
                If Bank_LRec.GET("Sales Header"."Bank on Invoice 2") then begin
                    BankName := Bank_LRec.Name;
                    SWIFTCode := Bank_LRec."SWIFT Code";
                    IBANNumber := Bank_LRec.IBAN;
                ENd; //Else
                     //Error('Bank No. Must not be blank');

                IF "Sales Header"."Seller/Buyer 2" then
                    Inspection_Caption := '* Inspection will be provided by nominated third party at the Buyer’s cost'
                Else
                    Inspection_Caption := '* Inspection will be provided by nominated third party at the Seller’s cost';
            end;
        }
    }

    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             // group(GroupName)
    //             // {
    //             //     field(Name; SourceExpression)
    //             //     {
    //             //         ApplicationArea = All;

    //             //     }
    //             // }
    //         }
    //     }


    // }

    var
        CompanyInformation: Record "Company Information";
        PaymentTerms_Desc: Text[100];
        TranSec_Desc: Text[100];
        AmtinWord_GTxt: array[2] of Text[80];
        CustAddr_Arr: array[8] of Text[90];
        CustAddrShipto_Arr: array[8] of Text[90];
        FormatAddr: Codeunit "Format Address";
        SrNo: Integer;
        TotalAmt: Decimal;
        ExchangeRate: Text;
        TotalAmountAED: Decimal;
        TotalVatAmtAED: Decimal;
        SearchDesc: Text[250];
        TotalIncludingCaption: Text[80];
        BankNo: Code[20];
        BankName: Text[50];
        IBANNumber: Text[50];
        SWIFTCode: Text[20];
        IsItem: Boolean;
        Origitext: Text[50];
        HSNCode: Text[50];
        PackingText: Text[50];
        reportText: Text[100];
        Cust_TRN: Text[50];
        CompanyisFZE: Boolean;
        PrintVATremark: Boolean;
        Inspection_Caption: Text[250];

        TotalLineAmt_G: Decimal;
        TotalLineDiscount_G: Decimal;

        TotalAmount_G: Decimal;
        AmtinWord_GTxtNew: array[2] of Text[80];

        EntryExitPointRecG: Record "Entry/Exit Point";
        CountryG: Record "Country/Region";

        CountryOfLoadingG: Record "Country/Region";
        CustomerShipToAddressNew: Text;

        LocationG: Record Location;

        ItemG: Record Item;

        WorkDescG: Text;
}