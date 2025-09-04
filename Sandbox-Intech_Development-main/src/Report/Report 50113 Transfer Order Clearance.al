report 50113 "Transfer Order Clearance"//T47724-N Commercial Invoice 1 (KM/PSI/110951) R_53007 on Posted Sales Invoice
{

    DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/Transfer Order Clearance.rdl';
    Caption = 'TO Clr.';
    UsageCategory = Administration;
    //ApplicationArea = all;

    dataset
    {
        dataitem("Transfer Header"; "Transfer Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(No_SalesInvoiceHeader; "No.") { }
            column(Tax_Type; '') { }
            column(Hide_E_sign; Hide_E_sign) { }
            column(Print_copy; Print_copy) { }
            column(PostingDate_SalesInvoiceHeader; format("Posting Date", 0, '<Day,2>-<Month Text>-<year4>')) { }
            column(Currency_Factor; '') { }
            column(Currency_Code; '') { }
            column(countryDesc; countryDesc) { }
            column(BilltoName_SalesInvoiceHeader; '') { }
            column(GST; CompanyInformation."Enable GST Caption") { }
            column(CompanyInformation_Address; CompanyInformation.Address) { }
            column(CompanyInformation_Address2; CompanyInformation."Address 2") { }
            column(CompanyInformation_City; CompanyInformation.City) { }
            column(CompanyInformation_Country; CompanyInformation."Country/Region Code") { }
            column(CompName; CompanyInformation.Name) { }
            column(CompLogo; CompanyInformation.Picture) { }
            column(AmtinWord_GTxt; AmtinWord_GTxt[1] + ' ' + AmtinWord_GTxt[2]) { }
            //Stamp
            column(CompanyInfo_Stamp; CompanyInformation.Stamp) { }
            column(PrintStamp; PrintStamp) { }
            //stamp-end
            column(CompAddr1; CompanyInformation.Address) { }
            column(CompAddr2; CompanyInformation."Address 2") { }
            column(Telephone; CompanyInformation."Phone No.") { }

            column(TRNNo; CompanyInformation."VAT Registration No.") { }
            column(Web; CompanyInformation."Home Page") { }
            column(PortofLoading_SalesInvoiceHeader; ExitPtDesc)
            {
                /*IncludeCaption = true;*/
            }
            column(PortOfDischarge_SalesInvoiceHeader; AreaDesc)
            {
                /*IncludeCaption = true;*/
            }
            column(Bill_to_City; '') { }
            column(Order_No_; SalesOrderNo) { }
            column(Ship_to_City; '') { }
            column(CustAddr_Arr1; CustAddr_Arr[1]) { }
            column(CustAddr_Arr2; CustAddr_Arr[2]) { }
            column(CustAddr_Arr3; CustAddr_Arr[3]) { }
            column(CustAddr_Arr4; CustAddr_Arr[4]) { }
            column(CustAddr_Arr5; CustAddr_Arr[5]) { }
            column(CustAddr_Arr6; CustAddr_Arr[6]) { }
            column(CustAddr_Arr7; CustAddr_Arr[7]) { }
            column(CustAddr_Arr8; CustAddr_Arr[8]) { }
            column(LCYCode; GLSetup."LCY Code") { }
            column(CustAddrShipto_Arr1; CustAddrShipto_Arr[1]) { }
            column(CustAddrShipto_Arr2; CustAddrShipto_Arr[2]) { }
            column(CustAddrShipto_Arr3; CustAddrShipto_Arr[3]) { }
            column(CustAddrShipto_Arr4; CustAddrShipto_Arr[4]) { }
            column(CustAddrShipto_Arr5; CustAddrShipto_Arr[5]) { }
            column(CustAddrShipto_Arr6; CustAddrShipto_Arr[6]) { }
            column(CustAddrShipto_Arr7; CustAddrShipto_Arr[7]) { }
            column(CustAddrShipto_Arr8; CustAddrShipto_Arr[8]) { }
            column(YourReferenceNo; "External Document No.") { }
            column(Validto; '') { }
            column(DeliveryTerms; TranSec_Desc) { }
            // column(PaymentTerms; "Sales Invoice Header"."Payment Terms Code")
            // {
            // }
            column(PaymentTerms; PmttermDesc) { }
            column(TotalIncludingCaption; TotalIncludingCaption) { }
            column(TotalAmt; TotalAmt) { }
            column(AmtExcVATLCY; AmtExcVATLCY) { }
            column(TotalAmountAED; TotalAmountAED) { }
            column(CurrDesc; CurrDesc) { }
            column(TotalVatAmtAED; TotalVatAmtAED) { }
            column(ExchangeRate; ExchangeRate) { }
            Column(BankName; BankName) { }

            column(BankAddress; BankAddress) { }
            column(BankAddress2; BankAddress2) { }
            column(BankCity; BankCity) { }
            column(BankCountry; BankCountry) { }
            Column(IBANNumber; IBANNumber) { }
            Column(SWIFTCode; SWIFTCode) { }
            column(Total_UOM; TempUOM.Code) { }
            column(QuoteNo; QuoteNo) { }
            column(Quotedate; Quotedate) { }
            column(AmtIncVATLCY; AmtIncVATLCY) { }
            column(LC_No; '') //PackingListExtChange
            {
            }
            column(LC_Date; '') //PackingListExtChange
            {
            }
            column(PartialShip; PartialShip) { }
            column(CustTRN; CustTRN) { }
            column(ShowComment; ShowComment) { }
            column(LegalizationRequired; LegalizationRequired) { }
            column(InspectionRequired; InspectionRequired) { }
            column(RepHdrtext; RepHdrtext) { }
            column(String; String + ' ' + CurrDesc) { }
            column(Inspection_Caption; '') { }
            column(Show_Exchange_Rate; ShowExchangeRate) { }
            column(SNo; SNo) { }
            column(Order_Date; '') { }
            column(Duty_Exemption; '') { }
            //AW09032020>>
            column(PI_Validity_Date; '') { }
            column(TaxDeclaration; TaxDeclaration) { }
            //AW09032020<<
            //SD Term & Conditions GK 04/09/2020

            column(Insurance_Policy_No_; '') { }
            column(InsurancePolicy; InsurancePolicy) { }
            column(HideBank_Detail; HideBank_Detail) { }
            //SD Term & Conditions GK 04/09/2020
            dataitem("Transfer Line"; "Transfer Line")
            {
                // DataItemTableView = WHERE(Type = filter(> " "));
                DataItemLinkReference = "Transfer Header";
                DataItemLink = "Document No." = FIELD("No.");
                column(SrNo; SrNo)
                {
                }
                column(LineNo_SalesInvoiceLine; "Line No.")
                {
                }
                column(No_SalesInvoiceLine; '')
                {
                    // IncludeCaption = true;
                }
                column(IsItem; IsItem)
                { }

                column(Description_SalesInvoiceLine; Description)
                {
                    IncludeCaption = true;
                }
                column(Quantity_SalesInvoiceLine; "Quantity (Base)")
                {
                    IncludeCaption = true;
                }
                column(UnitofMeasureCode_SalesInvoiceLine; '') //PackingListExtChange
                {
                }
                column(UnitPrice_SalesInvoiceLine; Customeunitprice)
                {
                    // IncludeCaption = true;
                }
                column(VatPer; '')
                {
                    // IncludeCaption = true;
                }
                column(VatAmt; '')
                {
                }
                column(AmountIncludingVAT_SalesInvoiceLine; SalesLineAmountincVat)
                {
                    // IncludeCaption = true;
                }
                column(SearchDesc; SearchDesc)
                {
                }
                column(Origin; Origitext)
                {
                }
                column(HSCode; HSNCode)
                {
                }
                column(Packing; Packing_Txt)
                {
                }
                column(NoOfLoads; '')
                {
                }
                column(LineHSNCodeText; LineHSNCodeText)
                { }
                column(LineCountryOfOriginText; LineCountryOfOriginText)
                { }
                column(Sorting_No_; SortingNo)
                { }
                column(SrNo3; 0) { }
                column(SrNo4; 0) { }
                column(SrNo5; 0) { }
                column(PINONew; PINONew) { }
                column(PIDateNew; FORMAT(PIDateNew, 0, '<Day,2>/<Month,2>/<Year4>')) { }
                column(VatOOS; VatOOS) { }
                column(CASNO; CASNO) { }
                column(IUPAC; IUPAC) { }

                //column(No__of_Load;"No. of Load"
                trigger OnPreDataItem()
                begin
                    //if DoNotShowGL then
                    //  SetFilter(Type, '<>%1', "Sales Invoice Line".Type::"G/L Account");

                end;

                trigger OnAfterGetRecord()
                var
                    Result: Decimal;
                    Item_LRec: Record Item;
                    ItemUnitofMeasureL: Record "Item Unit of Measure";
                    CountryRegRec: Record "Country/Region";
                    ItemAttrb: Record "Item Attribute";
                    ItemAttrVal: Record "Item Attribute Value";
                    ItemAttrMap: Record "Item Attribute Value Mapping";
                    SalesLineL: Record "Sales Invoice Line";
                    SalesHeaderRec: Record "Sales Header";
                    SalesShipHdr: Record "Sales Shipment Header";
                    SalesLineAmt: Decimal;
                    SalesLineAmtIncVat: Decimal;
                    SalesLineVatBaseAmt: Decimal;
                    salesHeaderArchive: Record "Sales Header Archive";
                    SalesHeader: Record "Sales Header";
                    StringProper: Codeunit "String Proper";
                    UOM: Record "Unit of Measure";
                    SalesLineUOM: Text;
                    VATpostingSetupRec: Record "VAT Posting Setup";
                    VariantRec: Record "Item Variant";
                    ItemUOMVariant: Record "Item Unit of Measure";
                    UOMRec: Record "Unit of Measure";
                    SalesInvHeaderRec: Record "Sales Invoice Header";


                begin
                    Clear(SalesLineAmount);
                    Clear(SalesLineAmountincVat);
                    Clear(SalesLineVatBaseAmount);
                    Clear(VatPercentage);
                    Clear(VatOOS);

                    // if VATpostingSetupRec.Get("VAT Bus. Posting Group", "VAT Prod. Posting Group") then;
                    // if VATpostingSetupRec."Out of scope" then VatOOS := true;

                    /* if "Transfer Line".Type = "Transfer Line".Type::"Charge (Item)" then
                        VatOOS := false
                    else begin
                        if VATpostingSetupRec.Get("VAT Bus. Posting Group", "VAT Prod. Posting Group") then;
                        if VATpostingSetupRec."Out of scope" then VatOOS := true;
                    end; */

                    // If "Document No." <> '' then
                    //     SalesInvHeaderRec.get("Document No.");


                    // if "VAT Prod. Posting Group"
                    //GK
                    /* if PostedCustomInvoiceG then begin
                        Customeunitprice := "Transfer Line"."Customer Requested Unit Price";
                        SalesLineAmount := "Transfer Line"."Quantity (Base)" * "Transfer Line"."Customer Requested Unit Price";
                        // SalesLineAmountincVat := (SalesLineAmount * "VAT %" / 100) + SalesLineAmount;
                        SalesLineVatBaseAmount := SalesLineAmount;

                    end
                    else begin
                        Customeunitprice := "Transfer Line"."Unit Price Base UOM 2"; //PackingListExtChange
                        SalesLineAmount := "Transfer Line".Amount;
                        SalesLineAmountincVat := "Transfer Line"."Amount Including VAT";
                        SalesLineVatBaseAmount := "Transfer Line"."VAT Base Amount";
                    end; */
                    //GK

                    // ShowVat in ""
                    // if "Sales Invoice Line"."VAT Prod. Posting Group"=''
                    //psp

                    /* if not SalesLineMerge then begin
                        SalesLineL.Reset();
                        SalesLineL.SetRange("Document No.", "Document No.");
                        SalesLineL.SetFilter("Line No.", '<%1', "Line No.");
                        SalesLineL.SetRange("No.", "No.");
                        SalesLineL.SetRange("Unit of Measure Code", "Unit of Measure Code");
                        SalesLineL.SetRange("Unit Price", "Unit Price");
                        if SalesLineL.FindFirst() then
                            CurrReport.Skip();
                        SalesLineL.Reset();
                        SalesLineL.SetRange("Document No.", "Document No.");
                        SalesLineL.SetFilter("Line No.", '>%1', "Line No.");
                        SalesLineL.SetRange("No.", "No.");
                        if SalesLineL.FindSet() then
                            repeat
                                // if ("Unit Price" = SalesLineL."Unit Price") and ("Unit of Measure Code" = SalesLineL."Unit of Measure Code") and ("Location Code" = SalesLineL."Location Code") then begin
                                if ("Unit Price" = SalesLineL."Unit Price") and ("Unit of Measure Code" = SalesLineL."Unit of Measure Code") then begin
                                    if PostedCustomInvoiceG then begin
                                        Clear(SalesLineAmt);
                                        Clear(SalesLineAmtIncVat);
                                        Clear(SalesLineVatBaseAmt);
                                        SalesLineAmt := SalesLineL."Quantity (Base)" * "Customer Requested Unit Price";
                                        Amount += SalesLineAmt;
                                        SalesLineAmtIncVat := SalesLineAmt + (SalesLineAmt * "VAT %" / 100);
                                        SalesLineAmountincVat += SalesLineAmtIncVat;
                                        SalesLineVatBaseAmt += SalesLineAmt;
                                        SalesLineVatBaseAmount += SalesLineAmt;
                                        "VAT Base Amount" += SalesLineVatBaseAmt;
                                        "Quantity (Base)" += SalesLineL."Quantity (Base)";
                                    end else begin
                                        Clear(SalesLineVatBaseAmount);
                                        "Quantity (Base)" += SalesLineL."Quantity (Base)";
                                        SalesLineAmountincVat += SalesLineL."Amount Including VAT";

                                        Amount += SalesLineL.Amount;
                                        SalesLineVatBaseAmount += Amount;
                                        "VAT Base Amount" += SalesLineL."VAT Base Amount";
                                    end;
                                end;
                            until SalesLineL.Next() = 0;
                    end; */

                    /* if ("Transfer Line".Type = "Transfer Line".Type::Item) AND ("Quantity (Base)" = 0) then
                        CurrReport.Skip();

                    if ("Transfer Line".Type = "Transfer Line".Type::"G/L Account") AND (PostedDoNotShowGL) then
                        CurrReport.Skip();
                    if type = Type::Item then
                        SrNo += 1; */
                    IsItem := FALSE;
                    SearchDesc := '';
                    Origitext := '';
                    CASNO := '';
                    IUPAC := '';
                    PackingDescription := '';
                    // HSNCode := '';
                    SortingNo := 2;
                    Result := 0;

                    /* If Item_LRec.GET("No.") THEN BEGIN
                        //SearchDesc := Item_LRec."Search Description";
                        // HSNCode := Item_LRec."Tariff No.";
                        if "Variant Code" <> '' then begin // add by bayas
                            VariantRec.Get("No.", "Variant Code");
                            if VariantRec."Packing Description" <> '' then begin
                                Packing_Txt := VariantRec."Packing Description";
                            end else begin
                                Packing_Txt := Item_LRec."Description 2";
                            end;
                        end else begin
                            Packing_Txt := Item_LRec."Description 2";
                        end;
                        //Packing_Txt := Item_LRec."Description 2";
                        IsItem := TRUE;
                        SortingNo := 1;
                        CountryRegRec.Reset();
                        IF CountryRegRec.Get(Item_LRec."Country/Region of Origin Code") then
                            Origitext := CountryRegRec.Name;
                        SearchDesc := Item_LRec."Generic Description";
                        if SalesInvHeaderRec."Bill-to Country/Region Code" = 'IND' then begin // These fiels only for Indian Customers
                            CASNO := Item_LRec."CAS No.";
                            IUPAC := Item_LRec."IUPAC Name";
                        end;

                        ItemUnitofMeasureL.Get("No.", "Unit of Measure Code");
                        ItemUnitofMeasureL.Ascending(true);
                        ItemUnitofMeasureL.SetRange("Item No.", Item_LRec."No.");

                        if "Variant Code" <> '' then begin
                            If ItemUnitofMeasureL."Variant Code" = "Variant Code" then begin
                                ItemUnitofMeasureL.SetRange("Variant Code", "Variant Code");
                            end else begin
                                ItemUnitofMeasureL.SetRange("Variant Code", '');
                            end;
                        end else begin
                            ItemUOMVariant.Get("No.", "Unit of Measure Code");
                            if ItemUOMVariant."Variant Code" <> '' then begin
                                ItemUnitofMeasureL.SetRange("Variant Code", ItemUOMVariant."Variant Code");
                            end else begin
                                ItemUnitofMeasureL.SetRange("Variant Code", '');
                            end;
                        end;

                        if ItemUnitofMeasureL.FindFirst() then begin

                            //Result := ROUND("Quantity (Base)" / ItemUnitofMeasureL."Qty. per Unit of Measure", 0.01, '=');

                            SalesLineUOM := ItemUnitofMeasureL.Code;
                            if uom.Get(ItemUnitofMeasureL.Code) then;


                            if (UOM."Decimal Allowed") then begin

                                Result := ROUND("Quantity (Base)" / ItemUnitofMeasureL."Qty. per Unit of Measure", 0.01, '=');

                                if (UOM.Code = 'KG') then
                                    //SalesLineUOM := StringProper.ConvertString(ItemUnitofMeasureL.Code)
                                    SalesLineUOM := uom.Description
                                else
                                    //SalesLineUOM := ItemUnitofMeasureL.Code
                                    SalesLineUOM := uom.Description
                            end

                            else begin
                                Result := ROUND("Quantity (Base)" / ItemUnitofMeasureL."Qty. per Unit of Measure", 1, '>');

                                if Result > 1 then uom.Description := uom.Description + 's';
                                SalesLineUOM := uom.Description;
                            end;

                            if "Allow Loose Qty." then begin
                                Packing_Txt := format(Result) + ' Loose ' + SalesLineUOM + ' of ' + Format(ItemUnitofMeasureL."Net Weight") + 'kg';
                            end else begin
                                if "Variant Code" <> '' then begin // add by bayas
                                    VariantRec.Get("No.", "Variant Code");
                                    if VariantRec."Packing Description" <> '' then begin
                                        PackingDescription := VariantRec."Packing Description";
                                    end else begin
                                        PackingDescription := Item_LRec."Description 2";
                                    end;
                                end else begin
                                    ItemUOMVariant.Get("No.", "Unit of Measure Code");
                                    if ItemUOMVariant."Variant Code" <> '' then begin
                                        VariantRec.Get("No.", ItemUOMVariant."Variant Code");
                                        if VariantRec."Packing Description" <> '' then begin
                                            PackingDescription := VariantRec."Packing Description";
                                        end else begin
                                            PackingDescription := Item_LRec."Description 2";
                                        end;
                                    end else begin
                                        PackingDescription := Item_LRec."Description 2";
                                    end;
                                end;
                                Packing_Txt := format(Result) + ' ' + SalesLineUOM + ' of ' + PackingDescription;
                            end;
                        end;
                    End; */

                    LineHSNCodeText := '';
                    LineCountryOfOriginText := '';

                    // SalesLineL.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                    // SalesLineL.SetRange("Line No.", "Sales Invoice Line"."Line No.");
                    // if SalesLineL.FindFirst() then begin
                    /* IF CountryRegRec.Get(LineCountryOfOrigin) then
                        LineCountryOfOriginText := CountryRegRec.Name;
                    LineHSNCodeText := LineHSNCode; */

                    // end;

                    /* if PostedCustomInvoiceG then begin
                        HSNCode := LineHSNCodeText;
                        Origitext := LineCountryOfOriginText;

                        //AW09032020>>
                        if "Line Generic Name" <> '' then
                            SearchDesc := "Line Generic Name";
                        //AW09032020<<
                        //UK::08062020>>
                    end else begin
                        HSNCode := "Transfer Line".HSNCode;
                        Origitext := "Transfer Line".CountryOfOrigin;
                    end; */
                    //UK::08062020<<
                    //UK::04062020>>
                    //code commented due to reason
                    // SalesHeaderRec.Reset();
                    // SalesHeaderRec.SetRange("No.", "Sales Invoice Line"."Blanket Order No.");
                    // if SalesHeaderRec.FindFirst() then begin     
                    //UK::24062020>>
                    /* if "Transfer Line"."Blanket Order No." <> '' then begin
                        // if PostedCustomInvoiceG then
                        //     PINONew := "Sales Invoice Line"."Blanket Order No." + '-A'
                        // else
                        PINONew := "Transfer Line"."Blanket Order No.";
                        SalesHeader.Reset();
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::"Blanket Order");
                        SalesHeader.SetRange("No.", "Transfer Line"."Blanket Order No.");
                        if SalesHeader.FindFirst() then
                            PIDateNew := SalesHeader."Order Date"
                        else begin
                            salesHeaderArchive.Reset();
                            salesHeaderArchive.SetRange("Document Type", salesHeaderArchive."Document Type"::"Blanket Order");
                            salesHeaderArchive.SetRange("No.", "Transfer Line"."Blanket Order No.");
                            if salesHeaderArchive.FindFirst() then
                                PIDateNew := salesHeaderArchive."Order Date";
                        end;
                    end else begin
                        PINONew := "Transfer Line"."Order No.";
                        SalesHeader.Reset();
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                        SalesHeader.SetRange("No.", "Transfer Line"."Order No.");
                        if SalesHeader.FindFirst() then
                            PIDateNew := SalesHeader."Order Date"
                        else begin
                            salesHeaderArchive.Reset();
                            salesHeaderArchive.SetRange("Document Type", salesHeaderArchive."Document Type"::Order);
                            salesHeaderArchive.SetRange("No.", "Transfer Line"."Order No.");
                            if salesHeaderArchive.FindFirst() then
                                PIDateNew := salesHeaderArchive."Order Date";
                        end;
                    end; */
                    //UK::24062020<<
                    // PIDateNew := "Sales Invoice Header"."Order Date";
                    // end
                    // else begin
                    // PINONew := "Order No.";
                    // PIDateNew := "Sales Invoice Header"."Order Date";
                    // end;
                    /* //UK::04062020<<
                    if SalesShipHdr.Get("Transfer Line"."Shipment No.") then
                        SalesOrderNo := SalesShipHdr."Order No."
                    else
                        SalesOrderNo := "Transfer Line"."Order No.";

                    //UK::03062020>>
                    if PostedCustomInvoiceG then begin
                        HSNCode := "Transfer Line".LineHSNCode;
                        //UK::24062020>>
                        CountryRegRec.Reset();
                        if CountryRegRec.Get("Transfer Line".LineCountryOfOrigin) then
                            Origitext := CountryRegRec.Name;
                    end else begin
                        HSNCode := "Transfer Line".HSNCode;
                        CountryRegRec.Reset();
                        if CountryRegRec.Get("Transfer Line".CountryOfOrigin) then
                            Origitext := CountryRegRec.Name;
                    end;
                    //UK::24062020<<
                    //UK::03062020<< */

                end;
            }
            //Pasted from Shipemt

            dataitem("Sales Remark Archieve"; "Sales Remark Archieve")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST("Posted Invoice"), "Document Line No." = FILTER(0));

                column(Remark; Remark)
                {
                }
                column(SNO1; SNO1)
                {

                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    SNO1 += 1;
                end;

                // trigger OnPreDataItem()
                // var
                // begin

                //     //sh
                //     SNO1 := SerialNo;
                // end;
            }
            //SD Remark
            dataitem("Sales Order Remarks"; "Sales Order Remarks")
            {
                // DataItemLink = "Document No." = field("Remarks Order No.");
                DataItemTableView = Where("Document Type" = filter(Invoice), "Document Line No." = FILTER(0), Comments = FILTER(<> ''));
                column(Remark_Document_Type; "Document Type") { }
                column(Remark_Document_No_; "Document No.") { }
                column(Remark_Document_Line_No_; "Document Line No.") { }
                column(Remark_Line_No_; "Line No.") { }
                column(Remark_Comments; Comments) { }
                column(SrNo6; 0) { }

                trigger OnAfterGetRecord()
                var
                begin
                    // SNo2 += 1;
                    SrNo6 += 1;
                end;

                trigger OnPreDataItem()
                begin
                    SrNo6 := SNO1;
                end;
            }

            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST("Posted Invoice"), "Document Line No." = FILTER(0));
                column(Comment_SalesCommentLine; "Sales Comment Line".Comment) { }
                column(LineNo_SalesCommentLine; "Sales Comment Line"."Line No.") { }
                column(DocumentLineNo_SalesCommentLine; "Sales Comment Line"."Document Line No.") { }
                column(SrNo7; 0) { }
                trigger OnPreDataItem()
                begin
                    //if not ShowComment then
                    //    CurrReport.Break;
                    SrNo7 := SrNo6;
                end;

                trigger OnAfterGetRecord()
                begin
                    SrNo7 += 1;
                end;
            }
            //SD Remark                                                                     

            trigger OnAfterGetRecord()
            var
                SalesInvoiceLine_LRec: Record "Transfer Line";
                Check_LRep: Report Check;
                VatRegNo_Lctxt: Label 'VAT Registration No. %1';
                CustomerRec: Record Customer;
                AgentRepRec: Record "Agent Representative";
                PmtTrmRec: Record "Payment Terms";
                SalesShipLine: Record "Sales Shipment Line";
                SalesShipHdr: Record "Sales Shipment Header";
                Comment_Lrec: Record "Sales Comment Line";
                TranSpec_rec: Record "Transaction Specification";
                Area_Rec: Record "Area";
                SalesInvoiceLine_L: Record "Sales Invoice Line";
                CountryRegionL: Record "Country/Region";
                ShipToAdd: Record "Ship-to Address";
                ClrShipToAdd: Record "Clearance Ship-to Address";
                I: Integer;
                ShipmentHeaderRec2: Record "Sales Shipment Header";
                ShipmentSerialNo: array[20] of Integer;
                ShipmentNo: Text[20];
                ShipmentS: Integer;
            begin
                //PSP

                //if PostedCustomInvoiceG then "No.":="No."+''
                AreaDesc := '';
                ExitPtDesc := '';
                Clear(CustAddr_Arr);
                //FormatAddr.SalesInvBillTo(CustAddr_Arr, "Sales Invoice Header"); //AW-06032020
                //FormatAddr.SalesHeaderBillTo(CustAddr_Arr, "Sales Invoice Header"); //AW-06032020
                GLSetup.Get();
                TranSec_Desc := '';
                IF TranSpec_rec.GET("Transaction Specification") then
                    TranSec_Desc := TranSpec_rec.Text;

                AreaRec.Reset();
                IF AreaRec.Get("Transfer Header"."Area") then
                    AreaDesc := AreaRec.Text;

                /* if PrintCustomerAltAdd then begin
                    Clear(AreaDesc);
                    IF AreaRec.Get("Transfer Header"."Customer Port of Discharge") then
                        AreaDesc := AreaRec.Text;
                end; */
                IF Area_Rec.Get("Area") And (Area_Rec.Text <> '') then
                    TranSec_Desc := TranSec_Desc + ', ' + AreaDesc;

                /* if ("Transfer Header"."VAT Bus. Posting Group" = 'C-DZ') OR ("Transfer Header"."VAT Bus. Posting Group" = 'C-LAT-DG') then
                    TaxDeclaration := 'In accordance with Article 51(5) of the Executive Regulations, the customer has declared that the Goods mentioned in the invoice are not for the purposes of use/consumption in the Designated Zone; and are to be either incorporated, attached or otherwise form part of or are used in the production or sale of another Good located in the Designated Zone which itself is not consumed; or for resale purposes.'; */


                //PartialShipment
                /* if "Transfer Header"."Shipment Term" = "Transfer Header"."Shipment Term"::"Partial Shipment" then begin
                    Clear(I);
                    SalesInvoicelineRec.Reset();
                    SalesInvoicelineRec.SetRange("Document No.", "Transfer Header"."No.");
                    SalesInvoicelineRec.SetFilter("No.", '<>%1', '');
                    if SalesInvoicelineRec.FindSet() then begin
                        I := SalesInvoicelineRec.Count;
                        if I = 1 then begin
                            ShipmentHeaderRec.Reset();
                            if ShipmentHeaderRec.Get(SalesInvoicelineRec."Shipment No.") then
                                ShipmentS := ShipmentHeaderRec."Shipment Count"
                            else
                                ShipmentS := "Transfer Header"."Shipment Count";
                        end
                        else
                            ShipmentS := "Transfer Header"."Shipment Count";
                    end;
                    if ShipmentS = 1 then
                        ShipmentNo := '1st Shipment'
                    else
                        if ShipmentS = 2 then
                            ShipmentNo := '2nd Shipment'
                        else
                            if ShipmentS = 3 then
                                ShipmentNo := '3rd Shipment'
                            else
                                if ShipmentS > 3 then
                                    ShipmentNo := Format(ShipmentS) + 'th Shipment';
                end else
                    if "Transfer Header"."Shipment Term" = "Transfer Header"."Shipment Term"::"One Shipment" then
                        ShipmentNo := Format("Transfer Header"."Shipment Term"); */
                if ShipmentNo <> '' then
                    TranSec_Desc := TranSec_Desc + ', ' + ShipmentNo;

                //PartialShipment

                /*
                CustAddr_Arr[1] := "Sell-to Customer Name";
                CustAddr_Arr[2] := StrSubstNo(VatRegNo_Lctxt, "VAT Registration No.");
                CustAddr_Arr[3] := "Sell-to Address" + ', ' + "Sell-to Address 2";
                CustAddr_Arr[4] := "Sell-to City";*/

                Clear(CustAddrShipto_Arr);
                //MS-
                /* if blnClrAddress then begin
                    CustAddrShipto_Arr[1] := "Clearance Ship-to Name";
                    CustAddrShipto_Arr[2] := "Clearance Ship-to Address";
                    CustAddrShipto_Arr[3] := "Clearance Ship-to Address 2";
                    CustAddrShipto_Arr[4] := "Clearance Ship-to City";
                    CustAddrShipto_Arr[8] := "Clearance Ship-to Post Code";
                    if CountryRegionL.Get("Clear.Ship-to Country/Reg.Code") then
                        CustAddrShipto_Arr[5] := CountryRegionL.Name;
                    //AW09032020>>
                    if "Clearance Ship-to Code" <> '' then begin
                        if ClrShipToAdd.Get("Sell-to Customer No.", "Ship-to Code") and (ClrShipToAdd."Phone No." <> '') then
                            CustAddrShipto_Arr[6] := 'Tel: ' + ClrShipToAdd."Phone No.";
                        // else
                        //     if "Sell-to Phone No." <> '' then
                        //         CustAddrShipto_Arr[7] := 'Tel No.: ' + "Sell-to Phone No.";
                    end;
                    //  else
                    //     if "Sell-to Phone No." <> '' then
                    //         CustAddrShipto_Arr[7] := 'Tel No.: ' + "Sell-to Phone No.";
                    //AW09032020<<
                    //CustAddrShipto_Arr[8] := ;
                end else begin
                    //MS+
                    if "Ship-to Code" <> '' THEN begin
                        CustAddrShipto_Arr[1] := "Ship-to Name";
                        CustAddrShipto_Arr[2] := "Ship-to Name 2";
                        CustAddrShipto_Arr[3] := "Ship-to Address";
                        CustAddrShipto_Arr[4] := "Ship-to Address 2";
                        CustAddrShipto_Arr[5] := "Ship-to City";
                        CustAddrShipto_Arr[6] := "Ship-to Post Code";
                        CountryRegionL.Reset();
                        if CountryRegionL.Get("Ship-to Country/Region Code") then
                            CustAddrShipto_Arr[7] := CountryRegionL.Name;
                        if "Ship-to Code" <> '' then begin
                            if ShipToAdd.Get("Sell-to Customer No.", "Ship-to Code") and (ShipToAdd."Phone No." <> '') then
                                CustAddrShipto_Arr[8] := 'Tel No.: ' + ShipToAdd."Phone No."
                            // else
                            //     if "Sell-to Phone No." <> '' then
                            //         CustAddrShipto_Arr[8] := 'Tel No.: ' + "Sell-to Phone No.";

                        end;
                        //  else
                        //     if "Sell-to Phone No." <> '' then
                        //         CustAddrShipto_Arr[8] := 'Tel No.: ' + "Sell-to Phone No.";
                        CompressArray(CustAddrShipto_Arr);
                    END;
                end; //MS-+ */

                //AW-06032020>>
                /* if PrintCustomerAltAdd = true then begin
                    if CustomerAltAdd.Get("Sell-to Customer No.") then begin
                        CustAddr_Arr[1] := CustomerAltAdd.Name;
                        CustAddr_Arr[2] := CustomerAltAdd.Address;
                        CustAddr_Arr[3] := CustomerAltAdd.Address2;
                        CustAddr_Arr[4] := CustomerAltAdd.City;
                        CustAddr_Arr[5] := CustomerAltAdd.PostCode;
                        CountryRegionL.Reset();
                        if CountryRegionL.Get(CustomerAltAdd."Country/Region Code") then
                            CustAddr_Arr[6] := CountryRegionL.Name;
                        if CustomerAltAdd.Get("Bill-to Customer No.") then
                            if CustomerAltAdd.PhoneNo <> '' then
                                CustAddr_Arr[7] := 'Tel No.: ' + CustomerAltAdd.PhoneNo;
                        if CustomerAltAdd."Customer Registration No." <> '' then
                            CustAddr_Arr[8] := CustomerAltAdd."Customer Registration Type" + ': ' + CustomerAltAdd."Customer Registration No.";
                        CompressArray(CustAddr_Arr);
                    end
                    else begin
                        //if cust alt address not found
                        CustAddr_Arr[1] := "Bill-to Name";
                        CustAddr_Arr[2] := "Bill-to Address";
                        CustAddr_Arr[3] := "Bill-to Address 2";
                        CustAddr_Arr[4] := "Bill-to City";
                        CustAddr_Arr[5] := "Bill-to Post Code";
                        if CountryRegionL.Get("Bill-to Country/Region Code") then
                            CustAddr_Arr[6] := CountryRegionL.Name;
                        CustomerRec.Reset();
                        if CustomerRec.Get("Bill-to Customer No.") then
                            if CustomerRec."Phone No." <> '' then
                                CustAddr_Arr[7] := 'Tel No.: ' + CustomerRec."Phone No."
                            else
                                if "Sell-to Phone No." <> '' then
                                    CustAddr_Arr[7] := 'Tel No.: ' + "Sell-to Phone No.";
                        if "Customer Registration No." <> '' then
                            CustAddr_Arr[8] := "Customer Registration Type" + ': ' + "Customer Registration No.";
                        CompressArray(CustAddr_Arr);
                    end;
                end
                //SJ>>24-02-20
                else begin
                    //if bool false
                    //AW-06032020<<
                    CustAddr_Arr[1] := "Bill-to Name";
                    CustAddr_Arr[2] := "Bill-to Address";
                    CustAddr_Arr[3] := "Bill-to Address 2";
                    CustAddr_Arr[4] := "Bill-to City";
                    CustAddr_Arr[5] := "Bill-to Post Code";
                    if CountryRegionL.Get("Bill-to Country/Region Code") then
                        CustAddr_Arr[6] := CountryRegionL.Name;
                    CustomerRec.Reset();
                    if CustomerRec.Get("Bill-to Customer No.") then
                        if CustomerRec."Phone No." <> '' then
                            CustAddr_Arr[7] := 'Tel No.: ' + CustomerRec."Phone No."
                        else
                            if "Sell-to Phone No." <> '' then
                                CustAddr_Arr[7] := 'Tel No.: ' + "Sell-to Phone No.";
                    if "Customer Registration No." <> '' then
                        CustAddr_Arr[8] := "Customer Registration Type" + ': ' + "Customer Registration No.";
                    CompressArray(CustAddr_Arr);
                end; */

                //>>SK 10-08-22
                /* if PrintAgentRepAddress then begin
                    CustAddr_Arr[1] := "Agent Rep. Name";
                    CustAddr_Arr[2] := "Agent Rep. Address";
                    CustAddr_Arr[3] := "Agent Rep. Address 2";
                    CustAddr_Arr[4] := "Agent Rep. City";
                    CustAddr_Arr[5] := "Agent Rep. Post Code";
                    if CountryRegionL.Get("Agent Rep. Country/Region Code") then
                        CustAddr_Arr[6] := CountryRegionL.Name;
                    AgentRepRec.Reset();
                    if AgentRepRec.Get("Agent Rep. Code") and (AgentRepRec."Phone No." <> '') then
                        CustAddr_Arr[7] := 'Tel No.: ' + AgentRepRec."Phone No.";
                    CustAddr_Arr[8] := '';
                    CustAddr_Arr[9] := '';
                    CompressArray(CustAddr_Arr);
                    CustTRN := '';
                end; */
                //<<SK 10-08-22

                //InsurancPolicy 04132020
                /* if TransactionSpecificationRec.Get("Transfer Header"."Transaction Specification") then begin
                    if TransactionSpecificationRec."Insurance By" = TransactionSpecificationRec."Insurance By"::Seller then begin
                        InsurancePolicy := 'Insurance Policy: ' + "Transfer Header"."Insurance Policy No." + ' Provided by ' + Format(TransactionSpecificationRec."Insurance By");
                    end
                    else
                        if TransactionSpecificationRec."Insurance By" = TransactionSpecificationRec."Insurance By"::Buyer then begin
                            InsurancePolicy := 'Insurance Policy: ' + "Transfer Header"."Insurance Policy No." + ' Provided by ' + Format(TransactionSpecificationRec."Insurance By");
                        end;
                end; */
                //InsurancPolicy 04132020

                TotalAmt := 0;
                TotalVatAmtAED := 0;
                TotalAmountAED := 0;
                PartialShip := '';
                CustTRN := '';
                QuoteNo := '';
                Quotedate := 0D;

                SalesInvoiceLine_LRec.Reset;
                SalesInvoiceLine_LRec.SetRange("Document No.", "No.");
                /* if PostedDoNotShowGL then
                    SalesInvoiceLine_LRec.SetFilter(Type, '<>%1', SalesInvoiceLine_LRec.Type::"G/L Account");
                if SalesInvoiceLine_LRec.FindSet(false) then
                    repeat
                        if PostedCustomInvoiceG then begin
                            TotalAmt += Round((salesInvoiceLine_LRec."Quantity (Base)" * salesInvoiceLine_LRec."Customer Requested Unit Price") + ((salesInvoiceLine_LRec."Quantity (Base)" * salesInvoiceLine_LRec."Customer Requested Unit Price") * SalesInvoiceLine_LRec."VAT %" / 100), 0.01, '=');
                            TotalVatAmtAED += Round((salesInvoiceLine_LRec."Quantity (Base)" * salesInvoiceLine_LRec."Customer Requested Unit Price") * SalesInvoiceLine_LRec."VAT %" / 100, 0.01, '=');
                            AmtExcVATLCY += Round(SalesInvoiceLine_LRec."Quantity (Base)" * SalesInvoiceLine_LRec."Customer Requested Unit Price", 0.01, '=');
                        end
                        else begin
                            TotalAmt += SalesInvoiceLine_LRec."Amount Including VAT";
                            TotalVatAmtAED += SalesInvoiceLine_LRec."VAT Base Amount" * SalesInvoiceLine_LRec."VAT %" / 100;
                            AmtExcVATLCY += SalesInvoiceLine_LRec.Quantity * SalesInvoiceLine_LRec."Unit Price";
                        end;
                    until SalesInvoiceLine_LRec.Next = 0; */
                //Message('%1', AmtExcVATLCY);

                TotalAmt := Round(TotalAmt, 0.01);  //SD::GK 5/25/2020

                //PSP PIno
                SalesInvoiceLine_L.SetRange("Document No.", "No.");
                SalesInvoiceLine_L.SetRange(Type, SalesInvoiceLine_L.Type::Item);
                if SalesInvoiceLine_L.FindFirst() then
                    repeat
                        If QuoteNo = '' then begin
                            QuoteNo := SalesInvoiceLine_L."Blanket Order No.";
                        end else begin
                            if StrPos(QuoteNo, SalesInvoiceLine_L."Blanket Order No.") = 0 then
                                QuoteNo := QuoteNo + ', ' + SalesInvoiceLine_L."Blanket Order No.";
                        end;
                    until SalesInvoiceLine_L.Next() = 0;
                //PSP

                CustomerRec.Reset();
                /* if CustomerRec.Get("Sell-to Customer No.") And (CustomerRec."seller Bank Detail" = false) then begin
                    HideBank_Detail := false;
                    SalesInvoiceLine_LRec.Reset;
                    SalesInvoiceLine_LRec.SetCurrentKey("Document No.", "Line No.");
                    SalesInvoiceLine_LRec.SetRange("Document No.", "Transfer Header"."No.");
                    SalesInvoiceLine_LRec.SetRange(Type, SalesInvoiceLine_LRec.Type::Item);
                    if SalesInvoiceLine_LRec.FindFirst() then begin
                        SalesShipLine.Reset();
                        IF SalesShipLine.Get(SalesInvoiceLine_LRec."Shipment No.", SalesInvoiceLine_LRec."Shipment Line No.") then begin
                            SalesShipHdr.Reset();
                            SalesShipHdr.get(SalesShipLine."Document No.");
                            if QuoteNo = '' then
                                QuoteNo := SalesShipHdr."Order No.";
                            Quotedate := SalesShipHdr."Order Date";
                            LCNumebr := SalesShipHdr."LC No. 2";
                            LCDate := SalesShipHdr."LC Date 2";
                            LegalizationRequired := SalesShipHdr."Legalization Required 2";
                            InspectionRequired := SalesShipHdr."Inspection Required 2";
                            //IF BankNo <> '' then
                            BankNo := SalesShipHdr."Bank on Invoice 2"; //PackingListExtChange
                            If Bank_LRec.GET(BankNo) then begin
                                BankName := Bank_LRec.Name;
                                BankAddress := Bank_LRec.Address;
                                BankAddress2 := Bank_LRec."Address 2";
                                BankCity := Bank_LRec.City;
                                BankCountry := Bank_LRec."Country/Region Code";
                                SWIFTCode := Bank_LRec."SWIFT Code";
                                IBANNumber := Bank_LRec.IBAN;
                            end
                            else begin
                                BankNo := "Bank on Invoice 2"; //PackingListExtChange
                                If Bank_LRec.GET(BankNo) then begin
                                    BankName := Bank_LRec.Name;
                                    SWIFTCode := Bank_LRec."SWIFT Code";
                                    IBANNumber := Bank_LRec.IBAN;
                                end;
                            end;
                        end
                        else begin
                            //QuoteNo := "Order No.";
                            // Quotedate := "Order Date";
                            LCNumebr := "LC No. 2"; //PackingListExtChange
                            LCDate := "LC Date 2"; //PackingListExtChange
                            LegalizationRequired := "Legalization Required 2"; //PackingListExtChange
                            InspectionRequired := "Inspection Required 2"; //PackingListExtChange
                            //IF BankNo <> '' then
                            BankNo := "Bank on Invoice 2"; //PackingListExtChange
                            If Bank_LRec.GET(BankNo) then begin
                                BankName := Bank_LRec.Name;
                                SWIFTCode := Bank_LRec."SWIFT Code";
                                IBANNumber := Bank_LRec.IBAN;
                            end
                        end;
                    END;
                end; */
                //until SalesInvoiceLine_LRec.Next = 0;


                TotalIncludingCaption := '';
                ExchangeRate := '';
                TotalAmountAED := TotalAmt;
                /* If "Currency Factor" <> 0 then begin
                    if CompanyInformation."Enable GST caption" then
                        TotalIncludingCaption := StrSubstNo('Total Including GST %1', "Currency Code")
                    else
                        TotalIncludingCaption := StrSubstNo('Total Including VAT %1', "Currency Code");

                    ExchangeRate := StrSubstNo('%1', 1 / "Currency Factor");
                    TotalVatAmtAED := TotalVatAmtAED / "Currency Factor";
                    TotalAmountAED := TotalAmt / "Currency Factor";
                    AmtIncVATLCY := AmtExcVATLCY / "Currency Factor";
                End Else begin */
                if CompanyInformation."Enable GST caption" then
                    TotalIncludingCaption := 'Total Including GST AED'
                else
                    TotalIncludingCaption := 'Total Including VAT AED';

                // end;

                /* ShowExchangeRate := not ("Currency Code" = '');
                if "Currency Code" > '' then
                    ShowExchangeRate := not ("Currency Code" = GLSetup."LCY Code");

                if "Currency Factor" = 0 then
                    "Currency Factor" := 1;

                if CurrencyRec.get("Currency Code") then
                    CurrDesc := CurrencyRec.Description
                else begin
                    if CurrencyRec.get(GLSetup."LCY Code") then
                        CurrDesc := CurrencyRec.Description;
                end;

                if "Currency Code" = '' then
                    "Currency Code" := GLSetup."LCY Code"; */

                Clear(AmtinWord_GTxt);
                Clear(Check_LRep);
                Check_LRep.InitTextVariable;
                Check_LRep.FormatNoText(AmtinWord_GTxt, TotalAmt, '');
                String := DelChr(AmtinWord_GTxt[1], '<>', '*') + AmtinWord_GTxt[2];
                String := CopyStr(String, 2, StrLen(String));
                Clear(Check_LRep);
                SrNo := 0;
                CustomerRec.Reset();
                /* IF CustomerRec.get("Sell-to Customer No.") then begin
                    PartialShip := Format(CustomerRec."Shipping Advice");
                    if CustomerRec."VAT Registration No." <> '' then begin
                        if CustomerRec."Tax Type" <> '' then begin
                            if "VAT Registration No." <> '' then begin
                                CustTRN := CustomerRec."Tax Type" + ': ' + "VAT Registration No."
                            end else begin
                                CustTRN := '';
                            end;
                        end else begin
                            CustTRN := 'TRN: ' + "VAT Registration No.";
                        end;
                    end;
                end;
                //AW12032020>>
                if PrintCustomerAltAdd = true then begin
                    if CustomerAltAdd.Get("Sell-to Customer No.") then
                        if CustomerAltAdd."Customer TRN" <> '' then
                            CustTRN := 'TRN: ' + CustomerAltAdd."Customer TRN"
                        else
                            CustTRN := '';
                end; */
                //AW12032020<<
                //Message('No. %1', "No.");
                if PrintAgentRepAddress then
                    CustTRN := '';

                PmtTrmRec.Reset();
                /* IF PmtTrmRec.Get("Transfer Header"."Payment Terms Code") then
                    PmttermDesc := PmtTrmRec.Description; */
                //If ShowComment THEN begin
                Comment_Lrec.Reset();
                Comment_Lrec.SetRange("No.", "No.");
                Comment_Lrec.SETRAnge("Document Type", Comment_Lrec."Document Type"::"Posted Invoice");
                Comment_Lrec.SetRange("Document Line No.", 0);
                ShowComment := Not Comment_Lrec.IsEmpty();
                //end;

                // PortOfLoding := "Sales Invoice Header".CountryOfLoading;
                // if PostedCustomInvoiceG then begin
                //     clear(PortOfLoding);
                //     PortOfLoding := "Sales Invoice Header"."Customer Port of Discharge";
                // end;

                /* ExitPt.Reset();
                IF ExitPt.Get("Transfer Header"."Exit Point") then
                    ExitPtDesc := ExitPt.Description; */

                IF PostedShowCommercial then
                    RepHdrtext := 'Commercial Invoice'
                else
                    RepHdrtext := 'Tax Invoice';

                /* IF "Seller/Buyer 2" then
                    Inspection_Caption := 'Inspection will be provided by nominated third party at the Buyer’s cost'
                Else
                    Inspection_Caption := 'Inspection will be provided by nominated third party at the Seller’s cost'; */

                /* SerialNo := 2;

                IF "Transfer Header"."Inspection Required 2" = true then begin //PackingListExtChange
                    SerialNo += 1;
                    SrNo3 := SerialNo;
                end;
                IF "Transfer Header"."Legalization Required 2" = true then begin //PackingListExtChange
                    SerialNo += 1;
                    SrNo4 := SerialNo;
                end;

                if "Transfer Header"."Duty Exemption" = true then begin
                    SerialNo += 1;
                    SrNo5 := SerialNo;
                end; */

                SNO1 := SerialNo;

                //"Sales Invoice Line".SetRange("Document No.", "Sales Invoice Header"."No.");
                //SalesShipHdr.SetRange("No.", "Sales Invoice Line"."Shipment No.");

                // if "Order No." <> '' then
                //     SalesOrderNo := "Order No."
                // else
                //     if "Order No." = '' then begin
                //         // SalesShipHdr.SetRange("No.", "Sales Invoice Line"."Shipment No.");
                //         // if SalesShipHdr.FindFirst() then
                //         //     SalesOrderNo := SalesShipHdr."Order No.";
                //     end;
            end;

        }
        dataitem(Total; Integer)
        {
            column(Total_Currency_Code; TempUOM.Code) { }

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin

                if not TempUOM.FindSet() then
                    CurrReport.Break();
                SETRANGE(Number, 1, TempUOM.COUNT);
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                if Number = 1 then
                    TempUOM.FindFirst()
                else
                    TempUOM.Next(1);
            end;
        }
    }

    /* requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(BankNo; BankNo)
                    {
                        TableRelation = "Bank Account"."No.";
                        ApplicationArea = All;
                        Visible = false;
                    }
                    // field("Legalization Required"; LegalizationRequired)
                    // {
                    //     ApplicationArea = All;
                    // }
                    // field("Inspection Required"; InspectionRequired)
                    // {
                    //     ApplicationArea = All;
                    // }
                    field("Print Commercial Invoice"; PostedShowCommercial)
                    {
                        ApplicationArea = ALL;
                    }
                    field("Do Not Show G\L"; PostedDoNotShowGL)
                    {
                        ApplicationArea = All;
                    }

                    field("Print Customer Invoice"; PostedCustomInvoiceG)
                    {
                        ApplicationArea = ALL;
                    }
                    field("SalesLine Merge"; SalesLineMerge)
                    {
                        ApplicationArea = All;
                        Caption = 'SalesLine UnMerge';
                    }
                    field(PrintCustomerAltAdd; PrintCustomerAltAdd)
                    {
                        ApplicationArea = all;
                        Caption = 'Customer Alternate Address';
                    }
                    field(Hide_E_sign; Hide_E_sign)
                    {
                        ApplicationArea = all;
                        Caption = 'Hide E-Signature';
                    }
                    field(Print_copy; Print_copy)
                    {
                        ApplicationArea = all;
                        Caption = 'Print Copy Document';
                    }
                    field("Print Clearance Ship-To Address"; blnClrAddress)
                    {
                        ApplicationArea = all;
                        Caption = 'Print Clearance Ship-To Address';
                    }
                    field(PrintStamp; PrintStamp)
                    {
                        ApplicationArea = all;
                        Caption = 'Print Digital Stamp';
                    }
                    field("Print Agent Representative Address"; PrintAgentRepAddress)
                    {
                        ApplicationArea = all;
                        Caption = 'Print Agent Representative Address';
                    }
                }
            }
        }

        actions
        {
        }
    } */


    labels
    {

        RepHeader = 'Tax Invoice';
        // Ref_Lbl = 'Ref:';
        Ref_Lbl = 'Invoice No.:';
        Date_Lbl = 'Invoice Date:';
        YourReference_Lbl = 'Customer Reference';
        ValidTo_Lbl = 'Invoice Due Date:';
        DeliveryTerms_Lbl = 'Delivery Terms';
        PaymentTerms_Lbl = 'Payment Terms';
        PartialShipment_Lbl = 'Partial Shipment';
        VatAmt_Lbl = 'VAT Amount';
        TotalPayableinwords_Lbl = 'Total Payable in words';
        ExchangeRate_Lbl = 'Exchange Rate:';
        Terms_Condition_Lbl = 'Remarks:';
        Lbl1 = 'General Sales conditions are provided on the last page of this Commercial Invoice.';
        Lbl2 = 'The beneficiary certify that this Commercial invoice shows the actual price of the goods and Services as described above and no other invoice is issued for this sale.';
        Lbl3 = '';
        Lbl4 = '';
        Lbl5 = '5.';
        Lbl6 = 'The buyer agreed to provide duty exemption documents to the seller, otherwise the selling price should be revised.';
        Inspection_yes_Lbl = 'Inspection is intended for this order';
        Inspection_no_lbl = 'Inspection is not intended for this order';
        Legalization_yes_Lbl = 'One original Invoice and one original certificate of origin will be Legalized by consulate at the seller’s cost.';
        Legalization_no_Lbl = 'Legalization of the documents are not required for this order';
        BankDetails_Lbl = 'Bank Details';
        BeneficiaryName_Lbl = 'Beneficiary Name:';
        BankName_Lbl = 'Bank Name: ';
        HideBank_lbl = 'Bank Information will be provided upon request.';
        IBANNumber_Lbl = 'Account IBAN Number:';
        SwiftCode_Lbl = 'Swift Code:';
        PortofLoading_Lbl = 'Port Of Loading:';
        PortofDischarge_Lbl = 'Port of Discharge:';
        AmountinAed_Lbl = 'Amount in AED';
        VATAmountinAED_Lbl = 'VAT Amount In AED';
        Origin_Lbl = 'Origin:';
        HSCode_Lbl = 'HS Code:';
        Packing_Lbl = 'Packing:';
        NoOfLoads_Lbl = 'No. Of Loads: ';
        BillTo_Lbl = 'Bill To';
        ShipTo_Lbl = 'Ship To';
        TRN_Lbl = 'TRN:';
        Tel_Lbl = 'Tel:';
        Web_Lbl = 'Web:';
        PINo_Lbl = 'P/I No.:';
        PIdate_Lbl = 'P/I Date:';
        LCNumber_Lbl = 'L/C Number:';
        LCDate_Lbl = 'L/C Date:';
        Page_Lbl = 'Page';
        Remark_lbl = 'Remark';
        AlternateAddressCap = 'Customer Alternate Address';
        CASNO_Lbl = 'CAS No.:';
        IUPAC_Lbl = 'IUPAC Name:';

        //GK
        NoteHdr_Lbl = 'Transfer of Ownership certificate';
        Note1_Lbl = '"Commercial invoice is only issued for customs clearance purposes; it does not bear any financial implication".';
        Note2_Lbl = '"Goods are transfer to the recipient for processing/ toll manufacturing under toll manufacturing agreement (reference no.)"';
        Note3_Lbl = '"Ownership in the goods shall always remain with Kemipex"';

    }

    trigger OnPreReport()
    var
    //Bank_LRec: Record "Bank Account";

    begin
        CompanyInformation.Get;
        CompanyInformation.CalcFields(Picture, Stamp);
        // UK::04062020>>
        spacePosition := StrPos(CompanyInformation.Name, ' ');
        CompanyFirstWord := CopyStr(CompanyInformation.Name, 1, spacePosition - 1);

        //UK::04062020<<

        HideBank_Detail := true;


        if CountryRec.Get(CompanyInformation."Country/Region Code") then
            countryDesc := CountryRec.Name;
        //BankNo := 'WWB-EUR';
        // If Bank_LRec.GET(BankNo) then begin
        //     BankName := Bank_LRec.Name;
        //     SWIFTCode := Bank_LRec."SWIFT Code";
        //     IBANNumber := Bank_LRec.IBAN;
        // ENd //Else
        //Error('Bank No. Must not be blank');
        TempUOM.DeleteAll();

    end;

    var
        ShipmentHeaderRec: Record "Sales Shipment Header";
        SalesInvoicelineRec: Record "Sales Invoice Line";
        Customeunitprice: Decimal;
        SalesLineAmount: Decimal;
        SalesLineAmountincVat: Decimal;
        SalesLineVatBaseAmount: Decimal;
        CustomerAltAdd: Record "Customer Alternet Address";
        PrintCustomerAltAdd: Boolean;
        CustomerAltAddres: array[8] of Text[100];
        blnClrAddress: Boolean;
        countryDesc: text;
        CountryRec: Record "Country/Region";
        AmtIncVATLCY: Decimal;
        AmtExcVATLCY: Decimal;
        VATAmtLCY: Decimal;
        SNO1: Integer;
        SNo2: Integer;
        SNo3: Integer;
        GLSetup: Record "General Ledger Setup";
        CurrencyRec: Record Currency;
        CurrDesc: Text[50];
        CompanyInformation: Record "Company Information";
        AmtinWord_GTxt: array[2] of Text[100];
        CustAddr_Arr: array[9] of Text[100];
        CustAddrShipto_Arr: array[8] of Text[100];
        FormatAddr: codeunit "Format Address";
        TransactionSpecificationRec: Record 285;
        InsurancePolicy: text[100];
        SrNo: Integer;
        TotalAmt: Decimal;
        ExchangeRate: Text;
        String: Text[100];
        TotalAmountAED: Decimal;
        TotalVatAmtAED: Decimal;
        SearchDesc: Text[100];
        TotalIncludingCaption: Text[80];
        BankNo: Code[20];
        BankName: Text[50];
        BankAddress: Text[50];
        BankAddress2: Text[50];
        BankCity: Text[30];
        BankCountry: Code[20];
        IBANNumber: Text[50];
        SWIFTCode: Text[20];
        IsItem: Boolean;
        HSNCode: Code[20];
        // PortOfLoding: Text[50];
        Origitext: Text[50];
        PartialShip: Text[20];
        CustTRN: Text[50];
        PmttermDesc: Text;
        QuoteNo: code[500];
        Quotedate: Date;
        LCNumebr: Code[50];
        LCDate: Date;
        ShowComment: Boolean;
        LegalizationRequired: Boolean;
        InspectionRequired: Boolean;
        Bank_LRec: Record "Bank Account";
        PostedShowCommercial: Boolean;
        TempUOM: Record "Unit of Measure" temporary;
        HideBank_Detail: Boolean;
        RepHdrtext: Text[50];
        //CustTRN: Text[100];
        ExitPt: Record "Entry/Exit Point";
        ExitPtDesc: Text[100];
        AreaRec: Record "Area";
        AreaDesc: Text[100];
        TranSec_Desc: Text[150];
        PostedDoNotShowGL: Boolean;
        Inspection_Caption: Text[250];
        Packing_Txt: Text[250];
        LineHSNCodeText: Text[20];
        LineCountryOfOriginText: Text[100];
        PostedCustomInvoiceG: Boolean;
        ShowExchangeRate: Boolean;
        SortingNo: Integer;
        SalesRemarksArchieve: Record "Sales Remark Archieve";
        Remark: Text[500];
        SNo: Integer;
        SalesLineMerge: Boolean;
        SerialNo: Integer;
        SrNo3: Integer;
        SrNo4: Integer;
        SrNo5: Integer;
        SrNo6: Integer;
        SrNo7: Integer;
        PINONew: code[20];
        PIDateNew: Date;
        SalesOrderNo: Code[20];
        // UK::04062020>>

        TaxDeclaration: Text[500]; //added by bayas
        PrintStamp: Boolean;
        PrintAgentRepAddress: Boolean;
        spacePosition: Integer;
        CompanyFirstWord: Text[50];
        //UK::04062020<<
        PackingDescription: Text[100];
        VatOOS: Boolean;
        CASNO: Text[500];
        IUPAC: Text[1000];
        Hide_E_sign: Boolean;
        Print_copy: Boolean;
        VatPercentage: Text;
}

