//18-04-2025-N
report 58225 "Blanket Purchase Order Print"//T12370-N
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Reports/Purchase Order preview Copy.rdl';
    ApplicationArea = All;


    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            //DataItemTableView = WHERE ("Document Type" = CONST (Order));//, "No." = CONST ('104008'));
            RequestFilterFields = "No.";

            column(Comp_Name; CompanyInformation.Name) { }
            column(EnableGSTCap; CompanyInformation."Enable GST caption") { }
            column(CompanyInformation_RegNo; CompanyInformation."Registration No.") { }
            // column(GST; CompanyInformation."Enable GST Caption") { }
            column(CompanyInformation_LicNo; CompanyInformation."Registration No.") { }
            column(Comp_Addr; CompanyInformation.Address) { }
            column(Comp_Addr2; CompanyInformation."Address 2") { }
            column(comp_city; CompanyInformation.City) { }
            column(countryDesc; countryDesc) { }
            column(Comp_Logo; CompanyInformation.Picture) { }
            column(Comp_Phoneno; CompanyInformation."Phone No.") { }
            column(Comp_VatRegNo; CompanyInformation."VAT Registration No.") { }
            column(No_; "No.") { }
            column(RegNo_CompanyInformation; CompanyInformation."Registration No.") { }
            column(LicNo_CompanyInformation; CompanyInformation."Registration No.") { }
            column(CompanyInformation_RegNoCust; CompanyInformation."Registration No.") { }
            column(PostingDate_; format("Document Date", 0, '<Day,2>-<Month Text>-<year4>')) { }
            column(VendorOrderNo_; "Vendor Order No.") { }
            column(SupplierRef; "Vendor Order No.") { }
            column(VendorShipmentNo_; "Vendor Shipment No.") { }
            column(PaymentTermsCode; PaymentTermsDesc) { }
            column(TotalAmt; TotalAmt) { }
            column(TotalAmountAED; TotalAmountAED) { }
            column(TotalVatAmtAED; TotalVatAmtAED) { }
            column(ExchangeRate; ExchangeRate) { }
            column(CurrencyFactor; CurrencyFactor) { }
            column(TotalCaption; TotalCaption) { }
            column(VendAddr1; VendAddr[1]) { }
            column(VendAddr2; VendAddr[2]) { }
            column(VendAddr3; VendAddr[3]) { }
            column(VendAddr4; VendAddr[4]) { }
            column(VendAddr5; VendAddr[5]) { }
            column(VendAddr6; VendAddr[6]) { }
            column(VendAddr7; VendAddr[7]) { }
            column(VendAddr8; VendAddr[8]) { }
            column(AmtinWord_GTxt; AmtinWord_GTxt[1] + ' ' + AmtinWord_GTxt[2]) { }
            column(DeliveryTerms; TranSec_Desc) { }
            column(BuyFrom_AddressG; BuyFrom_AddressG) { }
            column(BuyFrom_Address2G; BuyFrom_Address2G) { }
            column(BuyFrom_CityG; BuyFrom_CityG) { }
            column(BuyFrom_PostCodeG; BuyFrom_PostCodeG) { }
            column(BuyFrom_CountryRegionG; BuyFrom_CountryRegionG) { }
            column(Transaction_Type; "Transaction Type") { }
            column(Remarks3rdLine; Remarks3rdLine) { }
            column(Incoterms; 'Incoterm : ' + "Purchase Header"."Shipment Method Code" + ' ' + AreaDesc) { }
            // column() { }
            dataitem("Purchase Line"; "Purchase Line")
            {
                //DataItemTableView = where("Line No." = FILTER(<> 0));
                DataItemTableView = sorting("Document Type") where("No." = FILTER(<> ''));
                DataItemLink = "Document Type" = FIELD("Document Type"), "Document No." = FIELD("No.");

                column(SrNo; SrNo) { }
                column(LineNo_PurchaseLine; "Line No.") { }
                column(No; "No.") { }
                column(Description; Description) { }
                column(Description2; "Description 2") { }
                column(Quantity; "Quantity (Base)") { }
                column(UnitofMeasureCode; "Base UOM") { }
                column(UnitCost; "Unit Price Base UOM") { }
                column(AmountIncludingVAT; "Amount Including VAT")
                {
                    IncludeCaption = true;
                }
                column(VatPer; "VAT %")
                {
                    IncludeCaption = true;
                }
                column(VatAmt; "VAT Base Amount" * "VAT %" / 100) { }
                column(Amount; Amount) { }
                column(SearchDesc; SearchDesc) { }
                column(Origin; Origitext) { }
                column(HSCode; HSNCode) { }
                column(Packing; PackingText) { }
                column(IsItem; IsItem) { }
                column(IsComment; IsComment) { }
                //New
                column(GST; GST) { }
                column(CGST; CGST) { }
                column(IGST; IGST) { }
                column(SGST; SGST) { }
                column(GSTAmount; abs(GSTAmount)) { }
                column(AmountInclGst; abs(AmountInclGst)) { }
                column(AmountExclGST; abs(AmountExclGST)) { }
                column(CGSTamount; abs(CGSTamount)) { }
                column(IGSTamount; abs(IGSTamount)) { }
                column(SGSTAmount; abs(SGSTAmount)) { }
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
                    Check_LRep: Report Check_IN;
                begin
                    IsItem := FALSE;
                    IsComment := Type = Type::" ";
                    SearchDesc := '';
                    Origitext := '';
                    HSNCode := '';
                    PackingText := '';
                    IGSTamount := 0;
                    CGSTamount := 0;
                    SGSTamount := 0;
                    IGSTPct := 0;
                    CGSTPct := 0;
                    SGSTPct := 0;

                    if "Purchase Line".Type <> "Purchase Line".Type::" " then
                        SrNo += 1;
                    if "Purchase Line".Type = "Purchase Line".Type::Item then
                        If Item_LRec.GET("No.") THEN BEGIN
                            // SrNo += 1;
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
                            //PackingText := Item_LRec."Description 2";

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
                            //New
                            AmountExclGST := Quantity * "Direct Unit Cost";
                            CalculateLineGST("Purchase Header", "Purchase Line");
                            GSTAmount := IGSTamount + CGSTamount + SGSTAmount;
                            GST := Format(CGSTPct + SGSTPct + IGSTPct) + '%';
                            /* if GSTAmount > 0 then
                                GST := '18%'
                            else
                                GST := '0%'; */
                            AmountInclGst := GSTAmount + AmountExclGST;
                        End;
                    if "Purchase Line".Type = "Purchase Line".Type::"Fixed Asset" then
                        If FixedAssetLocRec.GET("No.") THEN BEGIN
                            // SrNo += 1;
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
                            AmountExclGST := Quantity * "Direct Unit Cost";
                            CalculateLineGST("Purchase Header", "Purchase Line");
                            GSTAmount := IGSTamount + CGSTamount + SGSTAmount;
                            GST := Format(CGSTPct + SGSTPct + IGSTPct) + '%';
                            /* if GSTAmount > 0 then
                                GST := '18%'
                            else
                                GST := '0%'; */
                            AmountInclGst := GSTAmount + "Purchase Line"."Amount Including VAT";
                        End;
                    if "Purchase Line".Type = "Purchase Line".Type::"G/L Account" then
                        If GlAccLocRec.GET("No.") THEN BEGIN
                            // SrNo += 1;
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
                            AmountExclGST := Quantity * "Direct Unit Cost";
                            CalculateLineGST("Purchase Header", "Purchase Line");
                            GSTAmount := IGSTamount + CGSTamount + SGSTAmount;
                            GST := Format(CGSTPct + SGSTPct + IGSTPct) + '%';
                            /* if GSTAmount > 0 then
                                GST := '18%'
                            else
                                GST := '0%'; */
                            AmountInclGst := GSTAmount + AmountExclGST;
                        End;

                    total := total + AmountInclGst;
                    //AS-12-03-2025-OS

                    // Clear(AmtinWord_GTxt);
                    // Clear(Check_LRep);
                    // Check_LRep.InitTextVariable;
                    // Check_LRep.FormatNoText(AmtinWord_GTxt, total, "Currency Code");

                    //AS-12-03-2025-OE

                    // // chekReport.InitTextVariable();
                    // //  chekReport.FormatNoText(Notext, total, '');
                    // CheckReportNew.InitTextVariable();
                    // CheckReportNew.FormatNoText(Notext, round(total, 0.01), "Purchase Header"."Currency Code");
                    // // AMountInW := DelChr(Notext[1], '<>', '*') + Notext[2];
                    // // AMountInW := CopyStr(String1, 2, StrLen(String1));

                    // // AMountInW := CopyStr(Notext[1], 1, StrPos(Notext[1], '/100') - 1) + ' PAISA ONLY';
                    // AMountInW := Notext[1];
                end;

                trigger OnPreDataItem()
                begin
                    SrNo := 0;
                    Clear(IGST);
                    Clear(GST);
                    Clear(CGST);
                    Clear(SGST);
                    Clear(IGSTPct);
                    Clear(CGSTPct);
                    Clear(SGSTPct);
                    Clear(GSTAmount);
                    Clear(IGSTamount);
                    Clear(CGSTamount);
                    Clear(SGSTAmount);
                    Clear(AmountExclGST);
                end;
            }
            dataitem(Hdrcomment; "Purch. Comment Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Line No." = CONST(0));

                column(DocumentLineNo_Hdrcomment; "Document Line No.") { }
                column(LineNo_Hdrcomment; "Line No.") { }
                column(Comment_Hdrcomment; Comment) { }
            }
            dataitem(LineCmt; "Purch. Comment Line")
            {
                DataItemLink = "Document Type" = FIELD("Document Type"), "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Line No." = filter(<> 0));

                column(DocumentLineNo_LineCmt; "Document Line No.") { }
                column(LineNo_LineCmt; "Line No.") { }
                column(Comment_LineCmt; Comment) { }
            }
            trigger OnAfterGetRecord()
            var
                FormatAddress_LCU: Codeunit "Format Address";
                PurchaseLine_LRec: Record "Purchase Line";
                PaymentTerms_LRec: Record "Payment Terms";
                // Check_LRep: Report Check;
                Check_LRep: Report Check_IN;
                TranSpec_rec: Record "Transaction Specification";
                Area_Rec: Record "Area";
                CountryL: Record "Country/Region";
                ExitEntry_Rec: Record "Entry/Exit Point";

            begin
                Clear(VendAddr);

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

                Clear(Area_Rec);
                AreaDesc := '';
                if Area_Rec.Get("Purchase Header"."Area") then
                    AreaDesc := Area_Rec.Text;

                TotalAmt := 0;
                TotalVatAmtAED := 0;
                TotalAmountAED := 0;
                CurrencyFactor := 0;
                PurchaseLine_LRec.RESET;
                PurchaseLine_LRec.SetRange("Document Type", "Document Type");
                PurchaseLine_LRec.SetRange("Document No.", "No.");
                If PurchaseLine_LRec.FindSet(FALSE) then
                    repeat
                        TotalAmt += PurchaseLine_LRec."Amount Including VAT";
                        TotalVatAmtAED += PurchaseLine_LRec."VAT Base Amount" * PurchaseLine_LRec."VAT %" / 100;

                        GstAmount_gDec += GetGSTAmount(PurchaseLine_LRec.RecordId); // AS-13-03-2025-N
                    until PurchaseLine_LRec.Next = 0;

                TotalAmt := Round(TotalAmt + GstAmount_gDec, 0.01); // AS-13-03-2025-N
                TotalCaption := '';

                if "Purchase Header"."Currency Code" <> '' then
                    TotalCaption := StrSubstNo('Total %1 Amount Payable', "Currency Code")
                else begin
                    Clear(GLSetup_lRec);
                    GLSetup_lRec.Get();
                    TotalCaption := StrSubstNo('Total %1 Amount Payable', GLSetup_lRec."LCY Code");
                end;



                //TotalCaption := StrSubstNo('Total %1 Amount Payable Incl. VAT:', "Currency Code");
                ExchangeRate := '';
                TotalAmountAED := TotalAmt;
                If "Currency Factor" <> 0 then begin
                    // TotalCaption := StrSubstNo('Total %1 Amount Payable', "Currency Code");
                    if CompanyInformation."Enable GST Caption" then
                        ExchangeRate := StrSubstNo(' Currency exchange rate for GST calculation: %1 %2', GLSetup_lRec."LCY Code", ROUND(1 / "Currency Factor", 0.00001, '='))
                    // ExchangeRate := StrSubstNo(' Currency exchange rate for GST calculation: %1 %2', "Currency Code", ROUND(1 / "Currency Factor", 0.00001, '='))
                    else
                        ExchangeRate := StrSubstNo(' Currency exchange rate for VAT calculation: %1 %2', "Currency Code", ROUND(1 / "Currency Factor", 0.00001, '='));

                    TotalVatAmtAED := TotalVatAmtAED / "Currency Factor";
                    TotalAmountAED := TotalAmt / "Currency Factor";
                    CurrencyFactor := ROUND(1 / "Currency Factor", 0.00001, '=');
                End
                ELSe begin
                    // TotalCaption := 'Total AED Amount Payable';
                    ExchangeRate := '';
                End;
                if "Currency Code" = '' then ExchangeRate := '';

                //AS-13-03-2025-OS

                Clear(AmtinWord_GTxt);
                Clear(Check_LRep);
                Check_LRep.InitTextVariable;
                Check_LRep.FormatNoText(AmtinWord_GTxt, TotalAmt, "Currency Code");

                //AS-13-03-2025-OE

                // Clear(Check_LRep);
                SrNo := 0;
                //Message('%1 >> %2', "Document Type", "No.");
                BuyFrom_AddressG := "Buy-from Address";
                BuyFrom_Address2G := "Buy-from Address 2";
                BuyFrom_CityG := "Buy-from City";
                BuyFrom_PostCodeG := "Buy-from Post Code";
                if "Buy-from Country/Region Code" > '' then CountryL.Get("Buy-from Country/Region Code");
                BuyFrom_CountryRegionG := CountryL.Name;

                Remarks3rdLine := '* In case of any deviation from the given ETD above, please inform us at the earliest possible for any required coordination';
                if "Transaction Type" = 'BACKTOBACK' then begin
                    Remarks3rdLine := '';
                end else
                    if "Transaction Type" = 'DIRECTSHIP' then begin
                        Remarks3rdLine := '';
                    end else begin
                        Remarks3rdLine := '* In case of any deviation from the given ETD above, please inform us at the earliest possible for any required coordination';
                    end;

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
        PurchaseOrder_Lbl = 'Purchase Requisition';
        PORef_Lbl = 'P.O. Ref.:';
        Date_Lbl = 'Date :';
        Supplier_Lbl = 'Supplier';
        SupplierRef_Lbl = 'Supplier Ref.';
        PaymentTerms_Lbl = 'Payment Terms';
        DeliveryTerms_Lbl = 'Delivery Terms';
        No_Lbl = 'No.';
        Desc_Lbl = 'Description';
        Qty_Lbl = 'Quantity';
        UOM_Lbl = 'UOM';
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
        CompanyInformation.CalcFields(Picture);

        if CountryRec.Get(CompanyInformation."Country/Region Code") then
            countryDesc := CountryRec.Name;
    end;

    local procedure CalculateLineGST(recPurchHdr: Record "Purchase Header"; recPurchLine: Record "Purchase Line")
    var
        recTaxRates: Record "Tax Rate";
        recTaxConfig: Record "Tax Rate Value";
        recTaxComponent: Record "Tax Component";
        TaxRates: Page "Tax Rates";
        intCGST: Integer;
        intIGST: Integer;
        intSGST: Integer;
        TaxRateID: Text;
        ConfigID: Text;
    Begin
        intCGST := 0;
        intSGST := 0;
        intIGST := 0;

        // if "Purchase Header"."Location State Code" <> '' then
        //     TaxRateID := StrSubstNo('%1|%2|%3|%4|No|No|', recPurchLine."GST Group Code", recPurchLine."HSN/SAC Code", recPurchHdr.State, recPurchHdr."Location State Code")
        // else
        //     TaxRateID := StrSubstNo('%1|%2|%3|%4|No|No|', recPurchLine."GST Group Code", recPurchLine."HSN/SAC Code", recPurchHdr.State, CompanyInformation."State Code");

        recTaxComponent.Reset();
        recTaxComponent.SetRange("Tax Type", 'GST');
        recTaxComponent.FindSet();
        repeat
            case recTaxComponent.Name of
                'IGST':
                    intIGST := recTaxComponent.ID;
                'CGST':
                    intCGST := recTaxComponent.ID;
                'SGST':
                    intSGST := recTaxComponent.ID;
            end;
        until recTaxComponent.Next() = 0;

        ConfigID := StrSubstNo('%1|%2|%3', intIGST, intCGST, intSGST);

        GetLineGSTAmount(recPurchLine, ConfigID, intIGST, intCGST, intSGST);

        // recTaxRates.Reset();
        // recTaxRates.SetRange("Tax Type", 'GST');
        // recTaxRates.SetRange("Tax Rate ID", TaxRateID);
        // recTaxRates.FindFirst();

        // recTaxConfig.Reset();
        // recTaxConfig.SetRange("Config ID", recTaxRates.ID);
        // recTaxConfig.SetRange("Tax Type", 'GST');
        // recTaxConfig.FindSet();
        // repeat
        //     case recTaxConfig."Column ID" of
        //         intIGST:
        //             begin
        //                 IGSTPer := recTaxConfig.Value + '%';
        //             end;
        //         intCGST:
        //             begin
        //                 CGSTPer := recTaxConfig.Value + '%';
        //             end;
        //         intSGST:
        //             begin
        //                 SGSTPer := recTaxConfig.Value + '%';
        //             end;
        //     end;
        // until recTaxConfig.Next() = 0;

        // if IGSTPer <> '0%' then begin
        //     CGSTPer := '';
        //     SGSTPer := '';
        //     CGSTamount := 0;
        //     SGSTAmount := 0;
        //     IGSTamount := decTotGstAmt;
        // end else begin
        //     IGSTPer := '';
        //     IGSTamount := 0;
        //     CGSTamount := decTotGstAmt / 2;
        //     SGSTAmount := decTotGstAmt / 2;
        // end;
    End;

    local procedure GetLineGSTAmount(gPurchLine: Record "Purchase Line"; FilterID: Text; IGSTID: Integer; CGSTID: Integer; SGSTID: Integer)
    var
        lPurchaseLine: Record "Purchase Line";
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
        decTotTaxAmt: Decimal;
    begin
        lPurchaseLine.Get(gPurchLine."Document Type", gPurchLine."Document No.", gPurchLine."Line No.");
        decTotTaxAmt := 0;
        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", lPurchaseLine.RecordId);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        TaxTransactionValue.SetFilter("Value ID", FilterID);
        // if not TaxTransactionValue.IsEmpty() then
        //     TaxTransactionValue.CalcSums(Amount);

        if TaxTransactionValue.FindSet() then
            repeat
                case TaxTransactionValue."Value ID" of
                    IGSTID:
                        begin
                            IGST := Format(TaxTransactionValue.Percent) + '%';
                            IGSTPct := TaxTransactionValue.Percent;
                            IGSTamount := TaxTransactionValue.Amount;
                        end;
                    CGSTID:
                        begin
                            CGST := Format(TaxTransactionValue.Percent) + '%';
                            CGSTPct := TaxTransactionValue.Percent;
                            CGSTamount := TaxTransactionValue.Amount;
                        end;
                    SGSTID:
                        begin
                            SGST := Format(TaxTransactionValue.Percent) + '%';
                            SGSTPct := TaxTransactionValue.Percent;
                            SGSTamount := TaxTransactionValue.Amount;
                        end;
                end;
                decTotTaxAmt += TaxTransactionValue.Amount;
            until TaxTransactionValue.Next() = 0;
        // exit(TaxTransactionValue.Amount);
        //exit(decTotTaxAmt);
    end;

    // AS-13-03-2025-NS

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

    // AS-13-03-2025-NE

    var
        CompanyInformation: Record "Company Information";
        CountryRec: Record "Country/Region";
        VendAddr: array[8] of Text[90];
        GLSetup_lRec: Record "General Ledger Setup";
        SrNo: Integer;
        TotalAmt: Decimal;
        GstAmount_gDec: Decimal;
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
        countryDesc: text;

        GST: text[50];
        IGST: Text;
        SGST: Text;
        CGST: Text;
        IGSTPct: Decimal;
        CGSTPct: Decimal;
        SGSTPct: Decimal;
        AmountInclGst: Decimal;
        AmountExclGST: Decimal;
        GSTAmount: Decimal;
        IGSTamount: Decimal;
        SGSTAmount: Decimal;
        CGSTamount: Decimal;
        total: Decimal;
        AreaDesc: Text;
}
