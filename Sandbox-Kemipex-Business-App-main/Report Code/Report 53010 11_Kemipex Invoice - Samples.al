report 53010 "11_Invoice - Samples"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Caption = 'Sample Invoice';
    RDLCLayout = 'Reports/11_Kemipex Invoice - Samples.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(No_; "No.")
            { }
            column(Document_Date; Format("Document Date", 0, '<Day,2>-<Month Text,3>-<year4>'))
            { }
            column(BillTo_gTxt; BillTo_gTxt)
            { }

            column(ShipTo_gTxt; ShipTo_gTxt) { }
            column(Web_gTxt; Web_gTxt)
            { }
            column(CurrencyCode_gCod; CurrencyCode_gCod)
            { }
            column(TotalAmount_gTxt; AmtinWord_GTxt[1] + ' ' + AmtinWord_GTxt[2])
            { }
            column(TotalNetWeight_gDec; Format(TotalNetWeight_gDec, 0, '<Precision,2><sign><Integer Thousand><Decimals>'))
            { }
            column(TotalGrossWeight_gDec; Format(TotalGrossWeight_gDec, 0, '<Precision,2><sign><Integer Thousand><Decimals>'))
            { }
            column(TotalNetWeightPound_gDec; Format(TotalNetWeightPound_gDec, 0, '<Precision,2><sign><Integer Thousand><Decimals>'))
            { }
            column(TotalGrossWeightPound_gDec; Format(TotalGrossWeightPound_gDec, 0, '<Precision,2><sign><Integer Thousand><Decimals>'))
            { }
            // column(PaymentTerms_gTxt; PaymentTerms_gTxt)
            // { }
            column(Comp_Logo; CompanyInformation.Picture)
            {
            }
            column(CompanyInformation_Logo; CompanyInformation.Logo) { }
            column(CompanyInfo_Stamp; CompanyInformation.Stamp)
            {
            }
            column(PrintStamp; PrintStamp) { }
            column(Hide_E_sign; Hide_E_sign) { }
            column(Comp_Name;
            CompanyInformation.Name)
            {
            }
            column(GST; CompanyInformation."Enable GST Caption") { }
            column(CompanyInformation_RegNo; CompanyInformation."Registration No.")
            {
            }
            column(CompanyInformation_LicNo;
            CompanyInformation."Registration No.")
            {
            }
            column(Comp_Addr;
            CompanyInformation.Address)
            {
            }
            column(Comp_Addr2;
            CompanyInformation."Address 2")
            {
            }
            column(comp_city; CompanyInformation.City)
            {

            }
            column(countryDesc; countryDesc)
            { }
            column(Comp_Phoneno;
            CompanyInformation."Phone No.")
            {
            }
            column(Comp_VatRegNo;
            CompanyInformation."VAT Registration No.")
            {
            }
            column(RegNo_CompanyInformation;
            CompanyInformation."Registration No.")
            {
            }
            column(LicNo_CompanyInformation;
            CompanyInformation."Registration No.")
            {
            }
            column(CompanyInformation_RegNoCust;
            CompanyInformation."Registration No.")
            {
            }
            column(Amount_Including_VAT; Format("Amount Including VAT", 0, '<Precision,2><sign><Integer Thousand><Decimals>'))
            { }
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");
                column(SrNo_gInt; SrNo_gInt)
                { }
                column(ItemNo_; "No.")
                { }
                column(Type; Type)
                { }
                column(IsItem; IsItem)
                { }
                column(Description; '<b>' + Description + '</b>')
                { }
                column(Origin_gTxt; Origin_gTxt)
                { }
                column(Item_Generic_Name; "Item Generic Name") { }
                column(HSNCode; HSNCode)
                { }
                column(Quantity; Quantity)
                { }
                column(Net_Weight; Format("Net Weight", 0, '<Precision,2><sign><Integer Thousand><Decimals>'))
                { }
                column(Net_Weight_Txt; Format("Net Weight", 0, '<Precision,2><sign><Integer Thousand><Decimals>'))
                { }
                column(Gross_Weight; Format("Gross Weight", 0, '<Precision,2><sign><Integer Thousand><Decimals>'))
                { }
                column(Gross_Weight_Txt; Format("Gross Weight", 0, '<Precision,2><sign><Integer Thousand><Decimals>'))
                { }
                column(Unit_of_Measure_Code; UOM_gTxt)// "Unit of Measure Code")
                { }
                column(Unit_Price; "Unit Price")
                { }
                column(Amount; "Amount Including VAT")
                { }
                column(CountryOfOrigin; CountryOfOrigin)
                { }
                trigger OnAfterGetRecord()
                var
                    UnitofMeasure_lRec: Record "Unit of Measure";
                    Item_LRec: Record Item;
                    CountryRegRec: Record "Country/Region";

                begin
                    if "Sales Invoice Line".Type = "Sales Invoice Line".Type::" " then
                        CurrReport.Skip();

                    Origin_gTxt := '';
                    UOM_gTxt := '';

                    IsItem := false;
                    // if "Sales Invoice Line".Type <> "Sales Invoice Line".Type::" " then//AS-O
                    if "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then //AS-N
                        SrNo_gInt += 1
                    else
                        SrNo_gInt := 0;



                    if UnitofMeasure_lRec.Get("Sales Invoice Line"."Unit of Measure Code") then
                        UOM_gTxt := UnitofMeasure_lRec.Description;

                    If Item_LRec.GET("No.") THEN BEGIN
                        CountryRegRec.Reset();
                        IF CountryRegRec.Get(Item_LRec."Country/Region of Origin Code") then
                            Origin_gTxt := CountryRegRec.Name;

                        IsItem := true;
                    END;
                end;
            }
            trigger OnAfterGetRecord()
            var
                PaymentTerms_lRec: Record "Payment Terms";
                CountryRegion_lRec: Record "Country/Region";
                GeneralLedgerSetup_lRec: Record "General Ledger Setup";
                Contact_lRec: Record Contact;
                SIL_lRec: Record "Sales Invoice Line";
                // Check_LRep: Report Check;
                Check_LRep: Report Check_IN;
                Check_USA_lRpt: Report "Check_USA2";

                SalesShiptoOption: Enum "Sales Ship-to Options";
                SalesBillToOption: Enum "Sales Bill-to Options";
                SalesHeader_lTemp: Record "Sales Invoice Header";
            begin
                PaymentTerms_gTxt := '';
                clear(PaymentTerms_lRec);
                if "Sales Invoice Header"."Payment Terms Code" <> '' then begin
                    PaymentTerms_lRec.Get("Sales Invoice Header"."Payment Terms Code");
                    PaymentTerms_gTxt := PaymentTerms_lRec.Description;
                end;

                // Clear(TotalAmount_gTxt);
                // Clear(Check_LRep);
                // Check_LRep.InitTextVariable;
                // "Sales Invoice Header".CalcFields("Amount Including VAT");
                // Check_LRep.FormatNoText(AmtinWord_GTxt, "Amount Including VAT", "Currency Code");

                Clear(AmtinWord_GTxt);
                Clear(TotalAmount_gTxt);
                Clear(Check_LRep);
                clear(Check_USA_lRpt);
                clear(CurrencyCode_gCod);
                Check_LRep.InitTextVariable;
                Check_USA_lRpt.InitTextVariable_USversion();
                "Sales Invoice Header".CalcFields("Amount Including VAT");
                clear(GeneralLedgerSetup_lRec);
                GeneralLedgerSetup_lRec.Get();
                if "Sales Invoice Header"."Currency Code" <> '' then
                    CurrencyCode_gCod := "Sales Invoice Header"."Currency Code"
                else
                    CurrencyCode_gCod := GeneralLedgerSetup_lRec."LCY Code";

                // if "Currency Code" = '' then
                //     Check_LRep.FormatNoText(AmtinWord_GTxt, TotalAmt, GLSetup."LCY Code")
                // else
                //     Check_LRep.FormatNoText(AmtinWord_GTxt, TotalAmt, "Currency Code");
                // String := DelChr(AmtinWord_GTxt[1], '<>', '*') + AmtinWord_GTxt[2];
                // String := CopyStr(String, 1, StrLen(String));
                // Clear(Check_LRep);


                if CurrencyCode_gCod = 'INR' then begin
                    // if "Currency Code" = '' then
                    //     Check_LRep.FormatNoText(AmtinWord_GTxt, TotalAmt, GLSetup."LCY Code")
                    // else
                    Check_LRep.FormatNoText(AmtinWord_GTxt, "Amount Including VAT", CurrencyCode_gCod);
                end else begin
                    // if "Currency Code" = '' then
                    //     Check_USA_lRpt.FormatNoText(AmtinWord_GTxt, TotalAmt, CurrReport.Language, GLSetup."LCY Code")
                    // else
                    Check_USA_lRpt.FormatNoText_USversion(AmtinWord_GTxt, "Amount Including VAT", CurrencyCode_gCod);
                end;
                // String := DelChr(AmtinWord_GTxt[1], '<>', '*') + AmtinWord_GTxt[2];
                // String := CopyStr(String, 1, StrLen(String));
                // Clear(Check_LRep);

                BillTo_gTxt := '';
                if "Sales Invoice Header"."Bill-to Name" <> '' then
                    BillTo_gTxt += '<b>' + "Bill-to Name" + '</b>';
                if "Sales Invoice Header"."Bill-to Address" <> '' then
                    BillTo_gTxt += '<br/>' + "Sales Invoice Header"."Bill-to Address";
                if "Sales Invoice Header"."Bill-to Address 2" <> '' then
                    BillTo_gTxt += '<br/>' + "Sales Invoice Header"."Bill-to Address 2";
                if "Sales Invoice Header"."Bill-to City" <> '' then
                    BillTo_gTxt += '<br/>' + "Sales Invoice Header"."Bill-to City";
                if "Sales Invoice Header"."Bill-to Post Code" <> '' then
                    BillTo_gTxt += ' - ' + "Sales Invoice Header"."Bill-to Post Code";
                clear(CountryRegion_lRec);
                if CountryRegion_lRec.Get("Sales Invoice Header"."Ship-to Country/Region Code") then
                    BillTo_gTxt += '<br/>' + CountryRegion_lRec.Name;
                // if "Sales Invoice Header"."Ship-to Contact" <> '' then begin
                //     clear(Contact_lRec);
                //     if Contact_lRec.Get("Sales Invoice Header"."Ship-to Contact") then begin
                //         BillTo_gTxt += '<br/>Tel:' + Contact_lRec."Phone No.";
                //         BillTo_gTxt += '<br/>' + Contact_lRec.Name;
                //         BillTo_gTxt += '<br/>Mob:' + Contact_lRec."Mobile Phone No.";
                //     end;
                // end;
                //AS-010425-NS
                if "Sales Invoice Header"."Bill-to Contact No." <> '' then begin
                    clear(Contact_lRec);
                    if Contact_lRec.Get("Sales Invoice Header"."Bill-to Contact No.") then begin
                        BillTo_gTxt += '<br/>Tel:' + Contact_lRec."Phone No.";
                        BillTo_gTxt += '<br/>' + Contact_lRec.Name;
                        BillTo_gTxt += '<br/>Mob:' + Contact_lRec."Mobile Phone No.";
                    end;
                end;
                //AS-010425-NE

                SalesHeader_lTemp.Reset;
                SalesHeader_lTemp := "Sales Invoice Header";
                CalculateShipBillToOptions(SalesShiptoOption, SalesBillToOption, SalesHeader_lTemp);

                ShipTo_gTxt := '';
                if SalesShiptoOption = SalesShiptoOption::"Default (Sell-to Address)" then begin
                    ShipTo_gTxt := 'Same as Bill To';
                end else begin
                    if "Sales Invoice Header"."Ship-to Name" <> '' then
                        ShipTo_gTxt += '<b>' + "Ship-to Name" + '</b>';
                    if "Sales Invoice Header"."Ship-to Address" <> '' then
                        ShipTo_gTxt += '<br/>' + "Sales Invoice Header"."Ship-to Address";
                    if "Sales Invoice Header"."Ship-to Address 2" <> '' then
                        ShipTo_gTxt += '<br/>' + "Sales Invoice Header"."Ship-to Address 2";
                    if "Sales Invoice Header"."Ship-to City" <> '' then
                        ShipTo_gTxt += '<br/>' + "Sales Invoice Header"."Ship-to City";
                    if "Sales Invoice Header"."Ship-to Post Code" <> '' then
                        ShipTo_gTxt += ' - ' + "Sales Invoice Header"."Ship-to Post Code";
                    clear(CountryRegion_lRec);
                    if CountryRegion_lRec.Get("Sales Invoice Header"."Bill-to Country/Region Code") then
                        ShipTo_gTxt += '<br/>' + CountryRegion_lRec.Name;
                    // if "Sales Invoice Header"."Bill-to Contact No." <> '' then begin
                    //     clear(Contact_lRec);
                    //     if Contact_lRec.Get("Sales Invoice Header"."Bill-to Contact No.") then begin
                    //         ShipTo_gTxt += '<br/>Tel:' + Contact_lRec."Phone No.";
                    //         ShipTo_gTxt += '<br/>' + Contact_lRec.Name;
                    //         ShipTo_gTxt += '<br/>Mob:' + Contact_lRec."Mobile Phone No.";
                    //     end;
                    // end;
                    if "Sales Invoice Header"."Ship-to Contact" <> '' then begin
                        ShipTo_gTxt += '<br/>' + "Sales Invoice Header"."Ship-to Contact";
                        if "Sales Invoice Header"."Ship-to Phone No." <> '' then
                            ShipTo_gTxt += '<br/>Mob:' + "Sales Invoice Header"."Ship-to Phone No.";
                    end;
                    // clear(Contact_lRec);
                    // if Contact_lRec.Get("Sales Invoice Header"."Ship-to Contact") then begin

                    // end;
                    // end;
                end;
                TotalNetWeight_gDec := 0;
                TotalGrossWeight_gDec := 0;
                TotalNetWeightPound_gDec := 0;
                TotalGrossWeightPound_gDec := 0;

                SIL_lRec.Reset();
                SIL_lRec.SetRange("Document No.", "Sales Invoice Header"."No.");
                SIL_lRec.SetFilter(Type, '<> %1', SIL_lRec.Type::" ");
                if SIL_lRec.FindSet() then begin
                    repeat
                        TotalNetWeight_gDec += SIL_lRec."Net Weight";
                        TotalGrossWeight_gDec += SIL_lRec."Gross Weight";
                    until SIL_lRec.Next() = 0;

                    TotalNetWeightPound_gDec := Round(TotalNetWeight_gDec / 0.45359237, 0.01);
                    TotalGrossWeightPound_gDec := Round(TotalGrossWeight_gDec / 0.45359237, 0.01);
                end;

                Clear(GeneralLedgerSetup_gRec);
                CurrencyCode_gCod := '';
                GeneralLedgerSetup_gRec.Get();
                if "Sales Invoice Header"."Currency Code" <> '' then
                    CurrencyCode_gCod := "Sales Invoice Header"."Currency Code"
                else
                    CurrencyCode_gCod := GeneralLedgerSetup_gRec."LCY Code";
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(Option)
                {
                    field(PrintStamp; PrintStamp)
                    {
                        ApplicationArea = all;
                        Caption = 'Print Digital Stamp';
                    }
                    field(Hide_E_sign; Hide_E_sign)
                    {
                        ApplicationArea = all;
                        Caption = 'Hide E-Signature';
                    }


                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    labels
    {
        Tel_Lbl = 'Tel:';
        TRN_Lbl = 'TRN:';
        Origin_Lbl = 'Origin: ';
        HSCode_Lbl = 'HS Code: ';
        Netight_Lbl = 'Net Weight: ';
        GrossWeight_Lbl = 'Gross Weight: ';
    }
    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        CompanyInformation.CalcFields(Picture, Stamp, Logo);

        if CountryRec.Get(CompanyInformation."Country/Region Code") then
            countryDesc := CountryRec.Name;

        Web_gTxt := 'Web : ' + CompanyInformation."Home Page";
    end;

    procedure CalculateShipBillToOptions(var ShipToOptions: Enum "Sales Ship-to Options"; var BillToOptions: Enum "Sales Bill-to Options"; var SalesHeader: Record "Sales Invoice Header")
    var
        ShipToNameEqualsSellToName: Boolean;
    begin
        ShipToNameEqualsSellToName :=
            (SalesHeader."Ship-to Name" = SalesHeader."Sell-to Customer Name") and (SalesHeader."Ship-to Name 2" = SalesHeader."Sell-to Customer Name 2");

        case true of
            (SalesHeader."Ship-to Code" = '') and ShipToNameEqualsSellToName and IsShipToAddressEqualToSellToAddress(SalesHeader, SalesHeader):
                ShipToOptions := ShipToOptions::"Default (Sell-to Address)";
            (SalesHeader."Ship-to Code" = '') and (not ShipToNameEqualsSellToName or not IsShipToAddressEqualToSellToAddress(SalesHeader, SalesHeader)):
                ShipToOptions := ShipToOptions::"Custom Address";
            SalesHeader."Ship-to Code" <> '':
                ShipToOptions := ShipToOptions::"Alternate Shipping Address";
        end;
    end;

    local procedure IsShipToAddressEqualToSellToAddress(SalesHeaderWithSellTo: Record "Sales Invoice Header"; SalesHeaderWithShipTo: Record "Sales Invoice Header"): Boolean
    var
        Result: Boolean;
    begin
        Result :=
          (SalesHeaderWithSellTo."Sell-to Address" = SalesHeaderWithShipTo."Ship-to Address") and
          (SalesHeaderWithSellTo."Sell-to Address 2" = SalesHeaderWithShipTo."Ship-to Address 2") and
          (SalesHeaderWithSellTo."Sell-to City" = SalesHeaderWithShipTo."Ship-to City") and
          (SalesHeaderWithSellTo."Sell-to County" = SalesHeaderWithShipTo."Ship-to County") and
          (SalesHeaderWithSellTo."Sell-to Post Code" = SalesHeaderWithShipTo."Ship-to Post Code") and
          (SalesHeaderWithSellTo."Sell-to Country/Region Code" = SalesHeaderWithShipTo."Ship-to Country/Region Code") and
          (SalesHeaderWithSellTo."Sell-to Phone No." = SalesHeaderWithShipTo."Ship-to Phone No.") and
          (SalesHeaderWithSellTo."Sell-to Contact" = SalesHeaderWithShipTo."Ship-to Contact");

        exit(Result);
    end;

    var

        // TotalNetWeighPound_gDec: Decimal;
        // TotalGrosWeighPound_gDec: Decimal;
        CustomerMgt_gCdu: Codeunit "Customer Mgt.";
        UOM_gTxt: Text;
        GeneralLedgerSetup_gRec: Record "General Ledger Setup";
        Web_gTxt: Text;
        AmtinWord_GTxt: array[2] of Text[80];
        String: Text;
        countryDesc: Text;
        CompanyInformation: Record "Company Information";
        CountryRec: Record "Country/Region";
        SrNo_gInt: Integer;
        BillTo_gTxt: Text;
        ShipTo_gTxt: Text;
        TotalNetWeight_gDec: Decimal;
        TotalGrossWeight_gDec: Decimal;
        TotalNetWeightPound_gDec: Decimal;
        TotalGrossWeightPound_gDec: Decimal;
        PaymentTerms_gTxt: Text;
        TotalAmount_gTxt: Text;
        CurrencyCode_gCod: Code[20];
        Origin_gTxt: Text;
        PrintStamp: Boolean;
        Hide_E_sign: Boolean;
        IsItem: Boolean;
}