//18-04-2025-N
report 50137 "Print Preview Purchase Order"//T12370-Full Comment T12946-Code Uncommented
{
    DefaultLayout = RDLC;
    Caption = 'Purchase Order';
    RDLCLayout = 'Layouts/Print Preview Purchase Order.rdl';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            //DataItemTableView = WHERE ("Document Type" = CONST (Order));//, "No." = CONST ('104008'));
            RequestFilterFields = "No.";
            column(Comp_Name;
            CompanyInformation.Name)
            {
            }
            column(Picture_CompanyInformation; CompanyInformation.Picture)
            { }
            column(GST; CompanyInformation."Enable GST Caption") { }
            column(Web_gTxt; Web_gTxt)
            { }
            column(CurrCode_gCod; CurrCode_gCod)
            { }
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
            column(Comp_Logo;
            CompanyInformation.Logo)
            {
            }
            column(Comp_Phoneno; CompanyInformation."Phone No.")
            {
            }
            column(Comp_VatRegNo; CompanyInformation."VAT Registration No.")
            {
            }
            column(GSTCaption; CompanyInformation."Enable GST caption") { }
            column(No_; "No.")
            {
            }
            column(CustTRN; CustTRN)
            {
            }
            column(Buy_from_Vendor_Name; "Buy-from Vendor Name") { }
            column(CustAddrShipto_Arr1; CustAddrShipto_Arr[1])
            {
            }
            column(CustAddrShipto_Arr2; CustAddrShipto_Arr[2])
            {
            }
            column(CustAddrShipto_Arr3; CustAddrShipto_Arr[3])
            {
            }
            column(CustAddrShipto_Arr4; CustAddrShipto_Arr[4])
            {
            }
            column(CustAddrShipto_Arr5; CustAddrShipto_Arr[5])
            {
            }
            column(CustAddrShipto_Arr6; CustAddrShipto_Arr[6])
            {
            }
            column(CustAddrShipto_Arr7; CustAddrShipto_Arr[7])
            {
            }
            column(CustAddrShipto_Arr8; CustAddrShipto_Arr[8])
            {
            }
            column(CustAddr_Arr1; CustAddr_Arr[1])
            {
            }
            column(CustAddr_Arr2; CustAddr_Arr[2])
            {
            }
            column(CustAddr_Arr3; CustAddr_Arr[3])
            {
            }
            column(CustAddr_Arr4; CustAddr_Arr[4])
            {
            }
            column(CustAddr_Arr5; CustAddr_Arr[5])
            {
            }
            column(CustAddr_Arr6; CustAddr_Arr[6])
            {
            }
            column(CustAddr_Arr7; CustAddr_Arr[7])
            {
            }
            column(CustAddr_Arr8; CustAddr_Arr[8])
            {
            }
            column(RegNo_CompanyInformation; CompanyInformation."Registration No.")
            {
            }
            column(LicNo_CompanyInformation; CompanyInformation."Registration No.")
            {
            }
            column(CompanyInformation_RegNoCust; CompanyInformation."Registration No.")
            {
            }
            column(PostingDate_; UpperCase(format("Document Date", 0, '<Day,2>-<Month Text,3>-<year4>')))
            {
            }
            column(VendorOrderNo_;
            "Vendor Order No.")
            {
            }
            column(SupplierRef;
            "Vendor Order No.")
            {
            }
            column(VendorShipmentNo_;
            "Vendor Shipment No.")
            {
            }
            column(PaymentTermsCode;
            PaymentTermsDesc)
            {
            }
            column(TotalAmt;
            TotalAmt)
            {
            }
            column(TotalAmountAED;
            TotalAmountAED)
            {
            }
            column(TotalVatAmtAED;
            TotalVatAmtAED)
            {
            }
            column(ExchangeRate;
            ExchangeRate)
            {
            }
            column(CurrencyFactor;
            CurrencyFactor)
            {
            }
            column(TotalCaption;
            TotalCaption)
            {
            }
            column(VendAddr1;
            VendAddr[1])
            {
            }
            column(VendAddr2;
            VendAddr[2])
            {
            }
            column(VendAddr3;
            VendAddr[3])
            {
            }
            column(VendAddr4;
            VendAddr[4])
            {
            }
            column(VendAddr5;
            VendAddr[5])
            {
            }
            column(VendAddr6;
            VendAddr[6])
            {
            }
            column(VendAddr7;
            VendAddr[7])
            {
            }
            column(VendAddr8;
            VendAddr[8])
            {
            }
            column(AmtinWord_GTxt;
            AmtinWord_GTxt[1] + ' ' + AmtinWord_GTxt[2])
            {
            }
            column(DeliveryTerms;
            TranSec_Desc)
            {
            }
            column(BuyFrom_AddressG;
            BuyFrom_AddressG)
            {
            }
            column(BuyFrom_Address2G;
            BuyFrom_Address2G)
            {
            }
            column(BuyFrom_CityG;
            BuyFrom_CityG)
            {
            }
            column(BuyFrom_PostCodeG;
            BuyFrom_PostCodeG)
            {
            }
            column(BuyFrom_CountryRegionG; BuyFrom_CountryRegionG)
            {
            }
            column(Buy_from_Contact_No_; ContactNo_gTxt)
            { }
            column(Transaction_Type; "Transaction Type")
            {
            }
            column(Remarks3rdLine; Remarks3rdLine)
            {
            }
            column(Insurance_gDec; Insurance_gDec)
            { }
            column(Freight_gDec; Freight_gDec)
            { }
            column(POL_gTxt; POL_gTxt)
            { }
            column(POD_gTxt; POD_gTxt)
            { }
            column(IncoTerms_gTxt; IncoTerms_gTxt)
            { }
            dataitem("Purchase Line"; "Purchase Line")
            {
                //DataItemTableView = where("Line No." = FILTER(<> 0));
                DataItemTableView = sorting("Document Type") where("No." = FILTER(<> ''));
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");

                column(SrNo;
                SrNo)
                { }
                column(LineNo_PurchaseLine;
                "Line No.")
                { }
                column(LineDetails_gTxt; LineDetails_gTxt)
                { }
                column(No; "No.") { }
                column(Type; Type)
                { }
                column(Description; Description) { }
                column(Description2; "Description 2")
                {
                }
                column(GstAmount_gDec; GstAmount_gDec)
                { }
                column(Quantity; "Quantity (Base)")
                {
                }
                column(Quantity_Format; Format("Quantity (Base)", 0, '<Precision,3><sign><Integer Thousand><Decimals>'))
                {

                }
                column(UnitofMeasureCode; "Base UOM")
                {
                }
                column(UnitCost; "Unit Price Base UOM")
                {
                }
                column(AmountIncludingVAT; "Amount Including VAT")
                {
                    IncludeCaption = true;
                }
                column(AmountIncludingTax_gDec; AmountIncludingTax_gDec)
                {
                }
                column(VatPer; "VAT %")
                {
                    IncludeCaption = true;
                }
                column(VatAmt; Round("VAT Base Amount" * "VAT %" / 100, 0.01, '='))
                {
                }
                column(Amount;
                Amount)
                {
                }
                column(SearchDesc;
                SearchDesc)
                {
                }
                column(Origin;
                Origitext)
                {
                }
                column(HSCode;
                HSNCode)
                {
                }
                column(Net_Weight; "Net Weight")
                { }
                column(Gross_Weight; "Gross Weight")
                { }
                column(Packing;
                PackingText)
                {
                }

                column(IsItem;
                IsItem)
                {
                }
                column(IsComment;
                IsComment)
                {
                }
                column(Inspection_gTxt; Inspection)
                { }
                column(Requested_Receipt_Date; "Requested Receipt Date")
                { }
                column(DeliverySchedule_gTxt; DeliverySchedule_gTxt)
                { }
                trigger OnAfterGetRecord()
                var
                    Item_LRec: Record Item;
                    CountryRegRec: Record "Country/Region";
                    ItemAttrb: Record "Item Attribute";
                    ItemAttrVal: Record "Item Attribute Value";
                    ItemAttrMap: Record "Item Attribute Value Mapping";
                    TblGenericName: Record KMP_TblGenericName;
                    VariantRec: Record "Item Variant";
                    VariantDetailsRec: Record "Item Variant Details";
                    FixedAssetLocRec: Record "Fixed Asset";
                    GlAccLocRec: Record "G/L Account";
                begin
                    AmountIncludingTax_gDec := 0;
                    IsItem := FALSE;
                    GstAmount_gDec := 0;
                    IsComment := Type = Type::" ";
                    SearchDesc := '';
                    Origitext := '';
                    HSNCode := '';
                    PackingText := '';
                    Inspection_gTxt := '';
                    DeliverySchedule_gTxt := '';
                    VendorCountryofOrigin := '';
                    LineDetails_gTxt := '';
                    if "Purchase Line".Type = "Purchase Line".Type::Item then
                        If Item_LRec.GET("No.") THEN BEGIN
                            SrNo += 1;
                            //SearchDesc := Item_LRec."Search Description";
                            //HSNCode := Item_LRec."Tariff No.";
                            HSNCode := "Item HS Code";

                            if "Variant Code" <> '' then begin // add by bayas
                                VariantRec.Get("No.", "Variant Code");
                                if VariantRec."Packing Description" <> '' then begin
                                    PackingText := VariantRec."Packing Description";
                                end else begin
                                    PackingText := Item_LRec."Description 2";
                                end;
                            end else begin
                                PackingText := Item_LRec."Description 2";
                            end;

                            IsItem := TRUE;
                            CountryRegRec.Reset();
                            if ShowVendorCOO then begin

                                if "Variant Code" <> '' then begin // add by bayas
                                    VariantRec.Get("No.", "Variant Code");
                                    if VariantRec."Variant Details" <> '' then
                                        VariantDetailsRec.Get("No.", "Variant Code");
                                    if VariantDetailsRec."Vendor Country of Origin" <> '' then begin
                                        VendorCountryofOrigin := VariantDetailsRec."Vendor Country of Origin";
                                    end else begin
                                        VendorCountryofOrigin := Item_LRec."Vendor Country of Origin";
                                    end;
                                end else begin
                                    VendorCountryofOrigin := Item_LRec."Vendor Country of Origin";
                                end;

                                if CountryRegRec.Get(VendorCountryofOrigin) then
                                    Origitext := CountryRegRec.Name;
                            end else begin
                                if CountryRegRec.Get(Item_COO) then
                                    Origitext := CountryRegRec.Name;
                            end;


                            SearchDesc := Item_LRec."Generic Description";

                            if "Unit Price Base UOM" = 0 then begin
                                "Unit Price Base UOM" := "Direct Unit Cost";
                                "Base UOM" := "Unit of Measure Code";
                                "Quantity (Base)" := Quantity;

                            end;
                        End;
                    if "Purchase Line".Type = "Purchase Line".Type::"Fixed Asset" then
                        If FixedAssetLocRec.GET("No.") THEN BEGIN
                            SrNo += 1;
                            HSNCode := '';
                            PackingText := '';
                            IsItem := TRUE;
                            CountryRegRec.Reset();

                            SearchDesc := '';

                            if "Unit Price Base UOM" = 0 then begin
                                "Unit Price Base UOM" := "Direct Unit Cost";
                                "Base UOM" := "Unit of Measure Code";
                                "Quantity (Base)" := Quantity;
                            end;
                        End;
                    if "Purchase Line".Type = "Purchase Line".Type::"G/L Account" then begin
                        If GlAccLocRec.GET("No.") THEN BEGIN
                            SrNo += 1;
                            HSNCode := '';
                            PackingText := '';
                            IsItem := TRUE;
                            CountryRegRec.Reset();

                            SearchDesc := '';

                            if "Unit Price Base UOM" = 0 then begin
                                "Unit Price Base UOM" := "Direct Unit Cost";
                                "Base UOM" := "Unit of Measure Code";
                                "Quantity (Base)" := Quantity;
                            end;
                        End;
                        Insurance_gDec += "Purchase Line".Amount;
                    end;

                    If "Purchase Line".Type = "Purchase Line".Type::"Charge (Item)" then begin
                        Freight_gDec += "Purchase Line".Amount;
                    end;

                    DeliverySchedule_gTxt := Format("Promised Receipt Date", 0, '<Day,2>-<Month Text>-<year4>');

                    //Hypercare-07-03-2025-NS
                    if IsItem then begin
                        If SearchDesc <> '' then begin
                            if LineDetails_gTxt = '' then
                                LineDetails_gTxt := SearchDesc;
                        end;
                        if Origitext <> '' then begin
                            if LineDetails_gTxt = '' then
                                LineDetails_gTxt += 'Origin :  ' + Origitext
                            else
                                LineDetails_gTxt += '<br/> Origin :  ' + Origitext;
                        end;
                        if HSNCode <> '' then begin
                            if LineDetails_gTxt = '' then
                                LineDetails_gTxt += 'HS Code : ' + HSNCode
                            else
                                LineDetails_gTxt += '<br/>HS Code : ' + HSNCode;
                        end;
                        if "Net Weight" <> 0 then begin
                            if LineDetails_gTxt = '' then
                                LineDetails_gTxt += 'Net Weight : ' + Format("Net Weight") + ' Kg'
                            else
                                LineDetails_gTxt += '<br/>Net Weight : ' + Format("Net Weight") + ' Kg';
                        end;
                        if "Gross Weight" <> 0 then begin
                            if LineDetails_gTxt = '' then
                                LineDetails_gTxt += 'Gross Weight : ' + Format("Gross Weight") + ' Kg'
                            else
                                LineDetails_gTxt += '<br/>Gross Weight : ' + Format("Gross Weight") + ' Kg';
                        end;
                        if PackingText <> '' then begin
                            if LineDetails_gTxt = '' then
                                LineDetails_gTxt += 'Packing : ' + PackingText
                            else
                                LineDetails_gTxt += '<br/>Packing : ' + PackingText;
                        end;
                        if "Requested Receipt Date" <> 0D then begin
                            if LineDetails_gTxt = '' then
                                LineDetails_gTxt += 'Delivery Date : ' + Format("Requested Receipt Date")
                            else
                                LineDetails_gTxt += '<br/>Delivery Date : ' + Format("Requested Receipt Date");
                        end;
                        if Inspection <> '' then begin
                            if LineDetails_gTxt = '' then
                                LineDetails_gTxt += 'Inspection : ' + Inspection
                            else
                                LineDetails_gTxt += '<br/>Inspection : ' + Inspection;
                        end;
                    end else begin
                        LineDetails_gTxt := '';
                    end;

                    clear(GstAmount_gDec);
                    GstAmount_gDec := Round(GetGSTAmount("Purchase Line".RecordId), 0.01, '=');
                    // GstPer_gDec := GetGSTPercent("Sales Invoice Line".RecordId);
                    //Hypercare-07-03-2025-NE
                    //  03-04-2025
                    if CompanyInformation."Enable GST Caption" then
                        AmountIncludingTax_gDec := "Purchase Line".Amount + GstAmount_gDec
                    else
                        AmountIncludingTax_gDec := "Purchase Line"."Amount Including VAT";
                end;
                //03-04-2025

                trigger OnPreDataItem()
                begin
                    SrNo := 0;
                end;
            }
            dataitem(Hdrcomment;
            "Purch. Comment Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Line No." = CONST(0));

                column(DocumentLineNo_Hdrcomment;
                "Document Line No.")
                {
                }
                column(LineNo_Hdrcomment;
                "Line No.")
                {
                }
                column(Comment_Hdrcomment;
                Comment)
                {
                }
            }
            dataitem(LineCmt;
            "Purch. Comment Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Line No." = filter(<> 0));

                column(DocumentLineNo_LineCmt;
                "Document Line No.")
                {
                }
                column(LineNo_LineCmt;
                "Line No.")
                {
                }
                column(Comment_LineCmt;
                Comment)
                {
                }
            }
            trigger OnAfterGetRecord()
            var
                Area_lRec: Record "Area";
                EntryExitPoint_lRec: Record "Entry/Exit Point";
                FormatAddress_LCU: Codeunit "Format Address";
                PurchaseLine_LRec: Record "Purchase Line";
                PaymentTerms_LRec: Record "Payment Terms";
                Check_LRep: Report Check_IN;
                TranSpec_rec: Record "Transaction Specification";
                Area_Rec: Record "Area";
                CountryL: Record "Country/Region";
                ExitEntry_Rec: Record "Entry/Exit Point";
                Contact_lRec: Record Contact;
                Vend_lRec: Record Vendor;
                ShipmentMethod_lRec: Record "Shipment Method";
                ShipToAdd: Record "Ship-to Address";
                Check_USA_lRpt: Report Check_USA;
                GeneralLedgerSetup_lRec: Record "General Ledger Setup";
                CheckUSA2_lRpt: Report "Check_USA2";
                PurchaseHdr_lTemp: Record "Purchase Header";
                ShipToOptionsOpt: Enum "Purchase Order Ship-to Options";
                ShipToOptions: Enum "Purchase Order Ship-to Options";
                Loc_lRec: Record Location;
                Cust_lRec: Record Customer;
            begin
                PaymentTerms_gTxt := '';
                POL_gTxt := '';
                POD_gTxt := '';
                IncoTerms_gTxt := '';
                Clear(ShipmentMethod_lRec);
                if ShipmentMethod_lRec.Get("Purchase Header"."Shipment Method Code") then begin
                    //IncoTerms_gTxt := ShipmentMethod_lRec.Description;//Old
                    //DG-OS
                    // IncoTerms_gTxt := ShipmentMethod_lRec.code + ',' + POL_gTxt;
                    // if not (IncoTerms_gTxt <> '') then
                    //     IncoTerms_gTxt := "Purchase Header"."Transaction Specification" + ',' + POL_gTxt;
                    //DG-OE
                end;
                //DG-NS
                if "Purchase Header"."Shipment Method Code" <> '' then
                    IncoTerms_gTxt += "Purchase Header"."Shipment Method Code"
                else
                    IncoTerms_gTxt += "Purchase Header"."Transaction Specification";

                Clear(EntryExitPoint_lRec);
                if "Purchase Header"."Entry Point" <> '' then begin
                    EntryExitPoint_lRec.Get("Purchase Header"."Entry Point");
                    IncoTerms_gTxt += ' , ' + EntryExitPoint_lRec.Description;
                end;
                //DG-NE

                Clear(VendAddr);
                // if (("Purchase Header".Status = "Purchase Header".Status::Open) OR ("Purchase Header".Status = "Purchase Header".Status::"Pending Approval")) then
                //     Error('Purchase order status should be released!'); //T12724
                FormatAddress_LCU.PurchHeaderBuyFrom(VendAddr, "Purchase Header");
                PaymentTermsDesc := '';
                If PaymentTerms_LRec.GET("Payment Terms Code") then PaymentTermsDesc := PaymentTerms_LRec.Description;
                TranSec_Desc := '';
                IF TranSpec_rec.GET("Purchase Header"."Transaction Specification") then TranSec_Desc := TranSpec_rec.Text;
                if "Purchase Header"."Transaction Specification" = 'FCA' then begin
                    IF ExitEntry_Rec.Get("Purchase Header"."Entry Point") then TranSec_Desc := TranSec_Desc + ' ' + ExitEntry_Rec.Description;
                end else
                    if "Purchase Header"."Transaction Specification" = 'FOB' then begin
                        IF ExitEntry_Rec.Get("Purchase Header"."Entry Point") then TranSec_Desc := TranSec_Desc + ' ' + ExitEntry_Rec.Description;
                    end else
                        if "Purchase Header"."Transaction Specification" = 'EXW' then begin
                            IF ExitEntry_Rec.Get("Purchase Header"."Entry Point") then TranSec_Desc := TranSec_Desc + ' ' + ExitEntry_Rec.Description;
                        end else begin
                            IF Area_Rec.Get("Purchase Header"."Area") then TranSec_Desc := TranSec_Desc + ' ' + Area_Rec.Text;
                        end;
                TotalAmt := 0;
                TotalVatAmtAED := 0;
                TotalAmountAED := 0;
                CurrencyFactor := 0;
                PurchaseLine_LRec.RESET;
                PurchaseLine_LRec.SetRange("Document Type", "Document Type");
                PurchaseLine_LRec.SetRange("Document No.", "No.");
                If PurchaseLine_LRec.FindSet(FALSE) then
                    repeat
                        //03-04-2025
                        if CompanyInformation."Enable GST caption" then
                            TotalAmt += PurchaseLine_LRec."Amount" + GetGSTAmount(PurchaseLine_LRec.RecordId)
                        else
                            TotalAmt += PurchaseLine_LRec."Amount Including VAT";
                        //03-04-2025
                        TotalVatAmtAED += PurchaseLine_LRec."VAT Base Amount" * PurchaseLine_LRec."VAT %" / 100 UNTil PurchaseLine_LRec.Next = 0;
                TotalCaption := '';
                //TotalCaption := StrSubstNo('Total %1 Amount Payable Incl. VAT:', "Currency Code");
                ExchangeRate := '';
                TotalAmountAED := TotalAmt;
                If "Currency Factor" <> 0 then begin
                    TotalCaption := StrSubstNo('Total %1 Amount Payable', "Currency Code");
                    if CompanyInformation."Enable GST Caption" then
                        ExchangeRate := StrSubstNo(' Currency exchange rate for GST calculation: %1 %2', "Currency Code", ROUND(1 / "Currency Factor", 0.00001, '='))
                    else
                        ExchangeRate := StrSubstNo(' Currency exchange rate for VAT calculation: %1 %2', "Currency Code", ROUND(1 / "Currency Factor", 0.00001, '='));

                    TotalVatAmtAED := TotalVatAmtAED / "Currency Factor";
                    TotalAmountAED := TotalAmt / "Currency Factor";
                    CurrencyFactor := ROUND(1 / "Currency Factor", 0.00001, '=');
                End
                ELSe begin
                    TotalCaption := 'Total AED Amount Payable';
                    ExchangeRate := '';
                End;
                if "Currency Code" = '' then ExchangeRate := '';
                // Clear(AmtinWord_GTxt);
                // Clear(Check_LRep);
                // Check_LRep.InitTextVariable;
                // Check_LRep.FormatNoText(AmtinWord_GTxt, TotalAmt, "Currency Code");
                // Clear(Check_LRep);

                //Hypercare-21-03-2025-NS
                Clear(AmtinWord_GTxt);
                Clear(Check_LRep);
                clear(Check_USA_lRpt);
                Check_LRep.InitTextVariable;
                CheckUSA2_lRpt.InitTextVariable_USversion();

                clear(GeneralLedgerSetup_lRec);
                CurrencyCode_gCod := '';
                GeneralLedgerSetup_lRec.Get();
                if "Purchase Header"."Currency Code" <> '' then
                    CurrencyCode_gCod := "Purchase Header"."Currency Code"
                else
                    CurrencyCode_gCod := GeneralLedgerSetup_lRec."LCY Code";

                if CurrencyCode_gCod = 'INR' then begin
                    Check_LRep.FormatNoText(AmtinWord_GTxt, TotalAmt, CurrencyCode_gCod);
                end else begin
                    Check_USA_lRpt.FormatNoText(AmtinWord_GTxt, TotalAmt, CurrReport.Language, CurrencyCode_gCod);
                    CheckUSA2_lRpt.FormatNoText_USversion(AmtinWord_GTxt, TotalAmt, CurrencyCode_gCod);
                end;
                //Hypercare-21-03-2025-NE

                SrNo := 0;


                //Message('%1 >> %2', "Document Type", "No.");
                BuyFrom_AddressG := "Buy-from Address";
                BuyFrom_Address2G := "Buy-from Address 2";
                BuyFrom_CityG := "Buy-from City";
                BuyFrom_PostCodeG := "Buy-from Post Code";
                if "Buy-from Country/Region Code" > '' then CountryL.Get("Buy-from Country/Region Code");
                BuyFrom_CountryRegionG := ',' + CountryL.Name;

                //Hypercare
                CustTRN := '';
                Clear(Vend_lRec);
                Clear(CountryL);
                //Hypercare-26-03-25-OS
                // CustAddr_Arr[1] := "Pay-to Name";
                // CustAddr_Arr[2] := "Pay-to Address";
                // CustAddr_Arr[3] := "Pay-to Address 2";
                // CustAddr_Arr[4] := "Pay-to City";
                // CustAddr_Arr[5] := "Pay-to Post Code";
                // if CountryL.Get("Pay-to Country/Region Code") then
                //     CustAddr_Arr[6] := CountryL.Name;
                // Vend_lRec.Reset();
                // if Vend_lRec.Get("Pay-to Vendor No.") then
                //     if Vend_lRec."Phone No." <> '' then
                //         CustAddr_Arr[7] := 'Tel No.: ' + Vend_lRec."Phone No.";
                //Hypercare-26-03-25-OE

                //Hypercare-26-03-25-NS
                CustAddr_Arr[1] := '<b>' + CompanyInformation.Name + '</b>';
                CustAddr_Arr[2] := CompanyInformation.Address;
                CustAddr_Arr[3] := CompanyInformation."Address 2";
                CustAddr_Arr[4] := CompanyInformation.City;
                CustAddr_Arr[5] := CompanyInformation."Post Code";
                if CountryL.Get(CompanyInformation."Country/Region Code") then
                    CustAddr_Arr[6] := CountryL.Name;
                if CompanyInformation."Phone No." <> '' then
                    CustAddr_Arr[7] := '<br/>' + 'Tel No.: ' + CompanyInformation."Phone No.";
                //Hypercare-26-03-25-NE

                // if CustomerRec."VAT Registration No." <> '' then
                // if "Tax Type" <> '' then
                //     CustTRN := Vend_lRec."Tax Type" + ': ' + Vend_lRec."VAT Registration No."
                // else
                CustTRN := 'TRN: ' + Vend_lRec."VAT Registration No.";
                // else
                //     if "Sell-to Phone No." <> '' then
                //         CustAddr_Arr[7] := 'Tel No.: ' + "Sell-to Phone No.";
                // if "Customer Registration No." <> '' then
                //     CustAddr_Arr[8] := "Customer Registration Type" + ': ' + "Customer Registration No.";
                CompressArray(CustAddr_Arr);

                Clear(CustAddrShipto_Arr);
                Clear(ShipToAdd);
                // //if "Ship-to Code" <> '' THEN begin
                // CustAddrShipto_Arr[1] := "Ship-to Name";
                // CustAddrShipto_Arr[2] := "Ship-to Name 2";
                // CustAddrShipto_Arr[3] := "Ship-to Address";
                // CustAddrShipto_Arr[4] := "Ship-to Address 2";
                // CustAddrShipto_Arr[5] := "Ship-to City";
                // CustAddrShipto_Arr[6] := "Ship-to Post Code";
                // CountryL.Reset();
                // if CountryL.Get("Ship-to Country/Region Code") then
                //     CustAddrShipto_Arr[7] := CountryL.Name;
                // if ShipToAdd.Get("Sell-to Customer No.", "Ship-to Code") and (ShipToAdd."Phone No." <> '') then
                //     CustAddrShipto_Arr[8] := 'Tel No.: ' + ShipToAdd."Phone No.";

                // CompressArray(CustAddrShipto_Arr);
                //Hypercare

                //Hypercare-26-03-25-OS

                //Hypercare-26-03-25-OE

                Remarks3rdLine := '* In case of any deviation from the given ETD above, please inform us at the earliest possible for any required coordination';
                if "Transaction Type" = 'BACKTOBACK' then begin
                    Remarks3rdLine := '';
                end else
                    if "Transaction Type" = 'DIRECTSHIP' then begin
                        Remarks3rdLine := '';
                    end else begin
                        Remarks3rdLine := '* In case of any deviation from the given ETD above, please inform us at the earliest possible for any required coordination';
                    end;

                Clear(Area_lRec);
                POD_gTxt := '';
                if "Purchase Header"."Area" <> '' then begin
                    Area_lRec.Get("Purchase Header"."Area");
                    POD_gTxt := Area_lRec.Text;
                end;

                Clear(EntryExitPoint_lRec);
                POL_gTxt := '';
                if "Purchase Header"."Entry Point" <> '' then begin
                    EntryExitPoint_lRec.Get("Purchase Header"."Entry Point");
                    POL_gTxt := EntryExitPoint_lRec.Description;
                end;

                Clear(GeneralLedgerSetup_gRec);
                CurrCode_gCod := '';
                GeneralLedgerSetup_gRec.Get();
                if "Purchase Header"."Currency Code" <> '' then
                    CurrCode_gCod := "Purchase Header"."Currency Code"
                else
                    CurrCode_gCod := GeneralLedgerSetup_gRec."LCY Code";

                Clear(Contact_lRec);
                ContactNo_gTxt := '';
                if "Purchase Header"."Buy-from Contact No." <> '' then begin
                    Contact_lRec.Get("Purchase Header"."Buy-from Contact No.");
                    ContactNo_gTxt := 'Tel: ' + Contact_lRec."Phone No.";
                end;

                Vend_lRec.Reset();
                IF Vend_lRec.get("Buy-from Vendor No.") then begin
                    // PartialShip := Format(Vend_lRec."Shipping Advice");
                    if Vend_lRec."VAT Registration No." <> '' then
                        // if "Tax Type" <> '' then
                        //     VendTRN := Vend_lRec."Tax Type" + ': ' + Vend_lRec."VAT Registration No."
                        // else
                            ContactNo_gTxt += '<br/>TRN: ' + Vend_lRec."VAT Registration No.";
                end;

                PurchaseHdr_lTemp.Reset;
                PurchaseHdr_lTemp := "Purchase Header";
                ShipToOptions := GetShipToOption(PurchaseHdr_lTemp);

                if ShipToOptions = ShipToOptions::"Default (Company Address)" then begin
                    CustAddrShipto_Arr[1] := '<b>' + CompanyInformation.Name + '</b>';
                    if CompanyInformation."Name 2" <> '' then
                        CustAddrShipto_Arr[2] := CompanyInformation."Name 2";
                    if CompanyInformation."Address" <> '' then
                        CustAddrShipto_Arr[3] := CompanyInformation."Address";
                    if CompanyInformation."Address 2" <> '' then
                        CustAddrShipto_Arr[4] := CompanyInformation."Address 2";
                    if CompanyInformation.City <> '' then
                        CustAddrShipto_Arr[5] := CompanyInformation.City;
                    if CompanyInformation."Post Code" <> '' then
                        CustAddrShipto_Arr[6] := CompanyInformation."Post Code";
                    CountryL.Reset();
                    if CountryL.Get(CompanyInformation."Country/Region Code") then
                        if CountryL.Name <> '' then
                            CustAddrShipto_Arr[7] := CountryL.Name;
                    //if ShipToAdd.Get("Sell-to Customer No.", "Ship-to Code") and (ShipToAdd."Phone No." <> '') then
                    if CompanyInformation."Phone No." <> '' then
                        CustAddrShipto_Arr[8] := 'Tel No.: ' + CompanyInformation."Phone No.";
                end else if ShipToOptions = ShipToOptions::Location then begin
                    Clear(Loc_lRec);
                    if Loc_lRec.Get("Purchase Header"."Location Code") then begin
                        CustAddrShipto_Arr[1] := '<b>' + Loc_lRec.Name + '</b>';
                        CustAddrShipto_Arr[2] := Loc_lRec."Name 2";
                        CustAddrShipto_Arr[3] := Loc_lRec.Address;
                        CustAddrShipto_Arr[4] := Loc_lRec."Address 2";
                        CustAddrShipto_Arr[5] := Loc_lRec.City;
                        CustAddrShipto_Arr[6] := Loc_lRec."Post Code";
                        CountryL.Reset();
                        if CountryL.Get(Loc_lRec."Country/Region Code") then
                            CustAddrShipto_Arr[7] := CountryL.Name;
                        if Loc_lRec."Phone No." <> '' then
                            CustAddrShipto_Arr[8] := 'Tel No.: ' + Loc_lRec."Phone No.";
                    end;
                end else if ShipToOptions = ShipToOptions::"Custom Address" then begin
                    CustAddrShipto_Arr[1] := '<b>' + "Ship-to Name" + '</b>';
                    if "Ship-to Name 2" <> '' then
                        CustAddrShipto_Arr[2] := "Ship-to Name 2";
                    if "Ship-to Address" <> '' then
                        CustAddrShipto_Arr[3] := "Ship-to Address";
                    if "Ship-to Address 2" <> '' then
                        CustAddrShipto_Arr[4] := "Ship-to Address 2";
                    if "Ship-to City" <> '' then
                        CustAddrShipto_Arr[5] := "Ship-to City";
                    if "Ship-to Post Code" <> '' then
                        CustAddrShipto_Arr[6] := "Ship-to Post Code";
                    CountryL.Reset();
                    if CountryL.Get("Ship-to Country/Region Code") then
                        if CountryL.Name <> '' then
                            CustAddrShipto_Arr[7] := CountryL.Name;
                    if ShipToAdd.Get("Sell-to Customer No.", "Ship-to Code") and (ShipToAdd."Phone No." <> '') then
                        CustAddrShipto_Arr[8] := 'Tel No.: ' + ShipToAdd."Phone No.";
                end else if ShipToOptions = ShipToOptions::"Customer Address" then begin
                    Clear(Cust_lRec);
                    if Cust_lRec.Get("Purchase Header"."Sell-to Customer No.") then begin
                        CustAddrShipto_Arr[1] := '<b>' + Cust_lRec.Name + '</b>';
                        if Cust_lRec."Name 2" <> '' then
                            CustAddrShipto_Arr[2] := Cust_lRec."Name 2";
                        if Cust_lRec.Address <> '' then
                            CustAddrShipto_Arr[3] := Cust_lRec.Address;
                        if Cust_lRec."Address 2" <> '' then
                            CustAddrShipto_Arr[4] := Cust_lRec."Address 2";
                        if Cust_lRec.City <> '' then
                            CustAddrShipto_Arr[5] := Cust_lRec.City;
                        if Cust_lRec."Post Code" <> '' then
                            CustAddrShipto_Arr[6] := Cust_lRec."Post Code";
                        CountryL.Reset();
                        if CountryL.Get(Cust_lRec."Country/Region Code") then
                            if CountryL.Name <> '' then
                                CustAddrShipto_Arr[7] := CountryL.Name;
                        if Cust_lRec."Phone No." <> '' then
                            CustAddrShipto_Arr[8] := 'Tel No.: ' + Cust_lRec."Phone No.";
                    end;

                end;
                CompressArray(CustAddrShipto_Arr);

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                field(ShowVendorCOO; ShowVendorCOO)
                {
                    ApplicationArea = all;
                    Caption = 'Show Vendor COO';
                }
            }

        }
        actions
        {
        }
    }
    labels
    {
        PurchaseOrder_Lbl = 'Purchase Order Preview';
        PORef_Lbl = 'Ref. No.';//'P.O. Ref.:';
        Date_Lbl = 'Date :';
        Supplier_Lbl = 'Supplier';
        SupplierRef_Lbl = 'Supplier Ref.';
        PaymentTerms_Lbl = 'Payment Terms';
        DeliveryTerms_Lbl = 'Delivery Terms';
        No_Lbl = 'No.';
        Desc_Lbl = 'Description';
        Qty_Lbl = 'Quantity';
        UOM_Lbl = 'UOM';
        BillTo_Lbl = 'Bill To';
        ShipTo_Lbl = 'Ship To';
        UnitPrice_Lbl = 'Unite Price';
        AmtIncVat_Lbl = 'Amount Incl. VAT';
        DeliverySchedule_Lbl = 'Delivery Schedule:';
        OtherTerms_Lbl = 'Other Terms and Conditions:';
        OtherTerms1_Lbl = '1)   Commercial Invoice and Packing list in 2 originals and 1 copy duly signed and stamped by supplier';
        OtherTerms2_Lbl = '2)   Certificate of Origin in 1 original and 1 copy to be provided by Chamber of commerce';
        OtherTerms3_Lbl = '3)   Container batch-wise loading details to be provided';
        OtherTerms4_Lbl = '4)   3 Original Bill of Lading and 3 copies to be provided';
        OtherTerms5_Lbl = '5)   Certificate of Analysis for all batches to be provided';
        OtherTerms6_Lbl = '6)   Legalization of documents are not required for this order';
        OtherTerms7_Lbl = '7)   Photos of loading to be provided';
        Remarks_Lbl = 'Remarks:';
        Origin_Lbl = 'Origin: ';
        HSCode_Lbl = 'HS Code: ';
        Packing_Lbl = 'Packing: ';
        DelDate_Lbl = 'Delivery Date : ';
        Inspection_Lbl = 'Inspection';
        VATAmountinAED_Lbl = 'Total VAT Amount (AED):';
        VatAmt_Lbl = 'VAT Amount';
        Remark_1_LBL = '* Please quote our Purchase Order Ref. on all related documents and correspondences for easy tracking';
        Remark_2_LBL = '* We reserve the right to ask for quality inspection of certain batches by third party at our own cost';
        Remark_3_LBL = '* In case of any deviation from the given ETD above, please inform us at the earliest possible for any required coordination';
        Remark_4_LBL = '* Please confirm receipt of this Purchase Order and provide your acceptance';
        Tel_Lbl = 'Tel:';
        TRN_Lbl = 'TRN:';
    }
    trigger OnPreReport()
    begin
        CompanyInformation.Get;
        CompanyInformation.CalcFields(Picture, Logo);

        if CountryRec.Get(CompanyInformation."Country/Region Code") then
            countryDesc := CountryRec.Name;

        Web_gTxt := 'Web : ' + CompanyInformation."Home Page";
    end;

    //Use this function to get option value for ship to for Purchase order.
    procedure GetShipToOption(PurchaseHeader_lRec: Record "Purchase Header"): Enum "Purchase Order Ship-to Options"
    var
        ShipToOptionsOpt: Enum "Purchase Order Ship-to Options";
        ShipToOptions: Enum "Purchase Order Ship-to Options";
    begin
        case true of
            PurchaseHeader_lRec."Sell-to Customer No." <> '':
                ShipToOptionsOpt := ShipToOptions::"Customer Address";
            PurchaseHeader_lRec."Location Code" <> '':
                ShipToOptionsOpt := ShipToOptions::Location;
            else
                if PurchaseHeader_lRec.ShipToAddressEqualsCompanyShipToAddress() then
                    ShipToOptions := ShipToOptions::"Default (Company Address)"
                else
                    ShipToOptions := ShipToOptions::"Custom Address";
        end;
        exit(ShipToOptionsOpt);
    end;

    procedure GetGSTAmount(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then
            TaxTransactionValue.CalcSums(Amount);

        exit(TaxTransactionValue.Amount);
    end;


    procedure GetGSTPercent(RecID: RecordID): Decimal
    var
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
    begin
        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", RecID);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        if not TaxTransactionValue.IsEmpty() then
            TaxTransactionValue.CalcSums(Percent);

        exit(TaxTransactionValue.Percent);
    end;



    var
        AmountIncludingTax_gDec: Decimal;
        CurrencyCode_gCod: Code[20];
        GstAmount_gDec: Decimal;
        CustTRN: Text[50];
        CustAddr_Arr: array[9] of Text[100];
        CustAddrShipto_Arr: array[8] of Text[100];
        LineDetails_gTxt: Text;
        VendTRN: Text;
        CurrCode_gCod: Code[10];
        GeneralLedgerSetup_gRec: Record "General Ledger Setup";
        ContactNo_gTxt: Text;
        Web_gTxt: Text;
        PaymentTerms_gTxt: Text;
        POL_gTxt: Text;
        POD_gTxt: Text;
        IncoTerms_gTxt: Text;
        Inspection_gTxt: Text;
        DeliverySchedule_gTxt: Text;
        Freight_gDec: Decimal;
        Insurance_gDec: Decimal;
        CompanyInformation: Record "Company Information";
        CountryRec: Record "Country/Region";
        VendAddr: array[8] of Text[90];
        SrNo: Integer;
        TotalAmt: Decimal;
        TotalVatAmtAED: Decimal;
        CurrencyFactor: Decimal;
        TotalCaption: Text[120];
        AmtinWord_GTxt: array[2] of Text[80];
        PaymentTermsDesc: Text;
        SearchDesc: Text[250];
        Origitext: Text[50];
        HSNCode: Text[50];
        PackingText: Text[50];
        IsItem: Boolean;
        IsComment: Boolean;
        ExchangeRate: Text;
        TotalAmountAED: Decimal;
        TranSec_Desc: Text[100];
        BuyFrom_AddressG: Text;
        BuyFrom_Address2G: Text;
        BuyFrom_CityG: Text;
        BuyFrom_PostCodeG: Text;
        BuyFrom_CountryRegionG: Text;
        ShowVendorCOO: Boolean;
        VendorCountryofOrigin: Text[100];
        Remarks3rdLine: Text;
        countryDesc: Text;
}
