//report 50102 change to 50177
report 50178 KMP_PreSalesInvoiceReport//T12370-N
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/KMP_PreSalesInvoiceReport.rdl';
    Caption = 'Sales Invoice';
    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Header")
        {
            //DataItemTableView = WHERE ("No." = CONST ('103001'));//103029
            //RequestFilterFields = "No.";
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(No_SalesInvoiceHeader; "No.")
            {
            }
            column(Des1; Des1)
            {

            }
            column(Bill_to_Name; "Bill-to Name")
            {

            }
            column(Bill_to_Address; "Bill-to Address")
            {

            }
            column(Bill_to_Address_2; "Bill-to Address 2")
            {

            }
            column(Bill_to_Post_Code; "Bill-to Post Code")
            {

            }
            column(Ship_to_Post_Code; "Ship-to Post Code")
            {

            }

            column(Currency_Factor; "Currency Factor")
            {
            }
            column(Currency_Code; "Currency Code")
            {

            }
            column(PostingDate_SalesInvoiceHeader; format("Posting Date", 0, '<Day,2>-<Month Text>-<year4>'))
            {
            }
            column(BilltoName_SalesInvoiceHeader; "Bill-to Name")
            {
            }
            column(Bill_to_City; "Bill-to City")
            {

            }
            column(CompanyInformation_Address; CompanyInformation.Address)
            {

            }
            column(CompanyInformation_RegNo; CompanyInformation."Registration No. Cust.")
            {

            }
            column(CompanyInformation_LicNo; CompanyInformation."License No. Cust.")
            {

            }
            column(CompanyInformation_Address2; CompanyInformation."Address 2")
            {

            }
            column(RegNo_CompanyInformation; CompanyInformation."Registration No.")
            {

            }
            column(LicNo_CompanyInformation; CompanyInformation."License No. Cust.")
            {

            }
            column(CompanyInformation_RegNoCust; CompanyInformation."Registration No. Cust.")
            {

            }
            column(CompanyInformation_City; CompanyInformation.City)
            {

            }
            column(CompanyInformation_Country; CompanyInformation."Country/Region Code")
            {

            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(CompLogo; CompanyInformation.Picture)
            {
            }
            column(AmtinWord_GTxt; AmtinWord_GTxt[1] + ' ' + AmtinWord_GTxt[2])
            {
            }
            column(CompAddr1; CompanyInformation.Address)
            {
            }
            column(CompAddr2; CompanyInformation."Address 2")
            {
            }
            column(Telephone; CompanyInformation."Phone No.")
            {
            }
            column(TRNNo; CompanyInformation."VAT Registration No.")
            {
            }
            column(PortofLoading_SalesInvoiceHeader; ExitPtDesc)
            {
                /*IncludeCaption = true;*/
            }
            column(PortOfDischarge_SalesInvoiceHeader; AreaDesc)
            {
                /*IncludeCaption = true;*/
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
            column(YourReferenceNo; "External Document No.")
            {
            }
            column(Validto; "Due Date")
            {
            }
            column(DeliveryTerms; TranSec_Desc)
            {
            }
            // column(PaymentTerms; "Sales Invoice Header"."Payment Terms Code")
            // {
            // }
            column(PaymentTerms; PmttermDesc)
            {
            }
            column(TotalIncludingCaption; TotalIncludingCaption)
            {

            }
            column(TotalAmt; TotalAmt)
            {

            }
            column(TotalAmountAED; TotalAmountAED)
            {

            }
            column(TotalVatAmtAED; TotalVatAmtAED)
            {

            }
            column(ExchangeRate; ExchangeRate)
            {

            }
            Column(BankName; BankName)
            {

            }
            column(BankAddress; BankAddress)
            {

            }
            column(BankAddress2; BankAddress2)
            {

            }
            column(BankCity; BankCity)
            {

            }
            column(BankCountry; BankCountry)
            {

            }
            Column(IBANNumber; IBANNumber)
            {

            }
            Column(SWIFTCode; SWIFTCode)
            {

            }
            column(QuoteNo; QuoteNo)
            {

            }
            column(Quotedate; Quotedate)
            {

            }
            column(LC_No; LCNumebr)
            {

            }
            column(LC_Date; LCDate)
            {

            }
            column(PartialShip; PartialShip)
            {

            }
            column(LCYCode; GLSetup."LCY Code")
            {

            }
            column(CustTRN; CustTRN)
            {

            }
            column(CurrDesc; CurrDesc)
            {

            }
            column(AmtExcVATLCY; AmtExcVATLCY)
            {

            }
            column(AmtIncVATLCY; AmtIncVATLCY)
            {

            }
            column(ShowComment; ShowComment)
            {

            }
            column(LegalizationRequired; LegalizationRequired)
            {
            }
            column(InspectionRequired; InspectionRequired)
            {
            }
            column(RepHdrtext; RepHdrtext)
            {

            }
            column(String; String + ' ' + CurrDesc)
            {

            }
            column(Inspection_Caption; Inspection_Caption)
            {

            }
            column(Show_Exchange_Rate; ShowExchangeRate)
            { }
            dataitem("Sales Invoice Line"; "Sales Line")
            {
                DataItemTableView = WHERE(Type = filter(> " "));
                DataItemLinkReference = "Sales Invoice Header";
                DataItemLink = "Document No." = FIELD("No.");
                column(SrNo; SrNo)
                {
                }
                column(LineNo_SalesInvoiceLine; "Line No.")
                {
                }
                column(No_SalesInvoiceLine; "No.")
                {
                    IncludeCaption = true;
                }
                column(IsItem; IsItem)
                {

                }
                column(Description_SalesInvoiceLine; Description)
                {
                    IncludeCaption = true;
                }
                column(Quantity_SalesInvoiceLine; "Quantity (Base)")
                {
                    IncludeCaption = true;
                }
                column(UnitofMeasureCode_SalesInvoiceLine; "Base UOM 2") //PackingListExtChange
                {
                }
                column(UnitPrice_SalesInvoiceLine; "Unit Price Base UOM 2") //PackingListExtChange
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
                column(AmountIncludingVAT_SalesInvoiceLine; "Amount Including VAT")
                {
                    IncludeCaption = true;
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
                column(Amount; Amount)
                {

                }

                column(LineHSNCodeText; LineHSNCodeText)
                { }
                column(LineCountryOfOriginText; LineCountryOfOriginText)
                { }
                column(Sorting_No_; SortingNo)
                { }
                trigger OnPreDataItem()
                begin
                    //if DoNotShowGL then
                    //  SetFilter(Type, '<>%1', "Sales Invoice Line".Type::"G/L Account");

                end;

                trigger OnAfterGetRecord()
                var
                    Item_LRec: Record Item;
                    CountryRegRec: Record "Country/Region";
                    ItemAttrb: Record "Item Attribute";
                    ItemAttrVal: Record "Item Attribute Value";
                    ItemAttrMap: Record "Item Attribute Value Mapping";
                    ItemUnitofMeasureL: Record "Item Unit of Measure";
                    SalesLineL: Record "Sales Line";
                    SalesLineRec: Record "Sales Line";
                    SalesInvoiceLine_LRec: Record "Sales Line";
                    Result: Decimal;
                begin
                    //psp
                    if not SalesLineMerge then begin
                        SalesLineL.Reset();
                        SalesLineL.SetRange("Document Type", "Document Type");
                        SalesLineL.SetRange("Document No.", "Document No.");
                        SalesLineL.SetFilter("Line No.", '<%1', "Line No.");
                        SalesLineL.SetRange("No.", "No.");
                        SalesLineL.SetRange("Unit of Measure Code", "Unit of Measure Code");
                        SalesLineL.SetRange("Unit Price", "Unit Price");
                        if SalesLineL.FindFirst() then
                            CurrReport.Skip();
                        SalesLineL.Reset();
                        SalesLineL.SetRange("Document Type", "Document Type");
                        SalesLineL.SetRange("Document No.", "Document No.");
                        SalesLineL.SetFilter("Line No.", '>%1', "Line No.");
                        SalesLineL.SetRange("No.", "No.");
                        if SalesLineL.FindSet() then
                            repeat
                                if ("Unit Price" = SalesLineL."Unit Price") and ("Unit of Measure Code" = SalesLineL."Unit of Measure Code") then begin
                                    "Quantity (Base)" += SalesLineL."Quantity (Base)";
                                    "Amount Including VAT" += SalesLineL."Amount Including VAT";
                                    Amount += SalesLineL.Amount;
                                    "VAT Base Amount" += SalesLineL."VAT Base Amount";
                                end;
                            until SalesLineL.Next() = 0;
                    end;


                    if ("Sales Invoice Line".Type = "Sales Invoice Line".Type::Item) AND ("Quantity (Base)" = 0) then
                        CurrReport.Skip();

                    if ("Sales Invoice Line".Type = "Sales Invoice Line".Type::"G/L Account") AND (DoNotShowGL) then
                        CurrReport.Skip();
                    if type = type::Item then
                        SrNo += 1;
                    IsItem := FALSE;
                    SearchDesc := '';
                    Origitext := '';
                    HSNCode := '';
                    SortingNo := 2;

                    If Item_LRec.GET("No.") THEN BEGIN
                        //SearchDesc := Item_LRec."Search Description";
                        HSNCode := Item_LRec."Tariff No.";
                        Packing_Txt := Item_LRec."Description 2";
                        IsItem := TRUE;
                        SortingNo := 1;
                        CountryRegRec.Reset();
                        IF CountryRegRec.Get(Item_LRec."Country/Region of Origin Code") then
                            Origitext := CountryRegRec.Name;
                        SearchDesc := Item_LRec."Generic Description";
                        ItemUnitofMeasureL.Ascending(true);
                        ItemUnitofMeasureL.SetRange("Item No.", Item_LRec."No.");
                        if ItemUnitofMeasureL.FindFirst() then begin
                            Result := ROUND("Quantity (Base)" / ItemUnitofMeasureL."Qty. per Unit of Measure", 0.01, '=');
                            Packing_Txt := Format(Result) + ' ' + ItemUnitofMeasureL.Code + ' of ' + Item_LRec."Description 2";
                        end;
                    End;

                    LineHSNCodeText := '';
                    LineCountryOfOriginText := '';

                    // SalesLineL.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                    // SalesLineL.SetRange("Line No.", "Sales Invoice Line"."Line No.");
                    // if SalesLineL.FindFirst() then begin
                    LineHSNCodeText := LineHSNCode;
                    // CountryRegRec.Reset();
                    IF CountryRegRec.Get(LineCountryOfOrigin) then
                        LineCountryOfOriginText := CountryRegRec.Name;
                    //LineCountryOfOriginText := SalesLineL.LineCountryOfOrigin;
                    // end;

                    if CustomInvoiceG then begin
                        HSNCode := LineHSNCodeText;
                        Origitext := LineCountryOfOriginText;
                    end;


                end;
            }
            //Pasted from Shipemt
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST("Posted Invoice"), "Document Line No." = FILTER(0));
                column(Comment_SalesCommentLine; "Sales Comment Line".Comment) { }
                column(LineNo_SalesCommentLine; "Sales Comment Line"."Line No.") { }
                column(DocumentLineNo_SalesCommentLine; "Sales Comment Line"."Document Line No.") { }

                trigger OnPreDataItem()
                begin
                    //if not ShowComment then
                    //    CurrReport.Break;

                end;
            }
            dataitem("Sales Remark"; "Sales Remark")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST(Invoice), "Document Line No." = FILTER(0));

                column(Remark; Remark)
                {
                }
                column(SNo; SNo)
                {

                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    SNo += 1;
                end;

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    SNo := 2;
                end;
            }

            trigger OnAfterGetRecord()
            var
                SalesInvoiceLine_LRec: Record "Sales Line";
                Check_LRep: Report Check;
                VatRegNo_Lctxt: Label 'VAT Registration No. %1';
                CustomerRec: Record Customer;
                PmtTrmRec: Record "Payment Terms";
                SalesShipLine: Record "Sales Shipment Line";
                SalesShipHdr: Record "Sales Shipment Header";
                Comment_Lrec: Record "Sales Comment Line";
                TranSpec_rec: Record "Transaction Specification";
                Area_Rec: Record "Area";
                CountryRegionL: Record "Country/Region";
                SalesInvoiceLine_L: Record "Sales Line";
            begin

                if CountryRegionL.Get("Bill-to Country/Region Code") then
                    Des1 := CountryRegionL.Name;

                AreaDesc := '';
                ExitPtDesc := '';
                Clear(CustAddr_Arr);
                //FormatAddr.SalesInvBillTo(CustAddr_Arr, "Sales Invoice Header");

                FormatAddr.SalesHeaderBillTo(CustAddr_Arr, "Sales Invoice Header");

                GLSetup.Get();
                TranSec_Desc := '';
                IF TranSpec_rec.GET("Transaction Specification") then
                    TranSec_Desc := TranSpec_rec.Text;
                IF Area_Rec.Get("Area") then
                    TranSec_Desc := TranSec_Desc + ' ' + Area_Rec.Text;
                /*
                CustAddr_Arr[1] := "Sell-to Customer Name";
                CustAddr_Arr[2] := StrSubstNo(VatRegNo_Lctxt, "VAT Registration No.");
                CustAddr_Arr[3] := "Sell-to Address" + ', ' + "Sell-to Address 2";
                CustAddr_Arr[4] := "Sell-to City";*/

                Clear(CustAddrShipto_Arr);
                if "Ship-to Code" <> '' THEN begin
                    CustAddrShipto_Arr[1] := "Ship-to Name";
                    CustAddrShipto_Arr[2] := "Ship-to Name 2";
                    CustAddrShipto_Arr[3] := "Ship-to Contact";
                    CustAddrShipto_Arr[4] := "Ship-to Address";
                    CustAddrShipto_Arr[5] := "Ship-to Address 2";
                    CustAddrShipto_Arr[6] := "Ship-to City";
                    CustAddrShipto_Arr[7] := "Ship-to Post Code";
                    if ("Ship-to Country/Region Code" > '') and CountryRegionL.Get("Ship-to Country/Region Code") then
                        CustAddrShipto_Arr[8] := CountryRegionL.Name;
                END;


                TotalAmt := 0;
                TotalVatAmtAED := 0;
                TotalAmountAED := 0;
                PartialShip := '';
                CustTRN := '';
                QuoteNo := '';
                Quotedate := 0D;
                SalesInvoiceLine_LRec.Reset;
                SalesInvoiceLine_LRec.SetRange("Document No.", "No.");
                if DoNotShowGL then
                    SalesInvoiceLine_LRec.SetFilter(Type, '<>%1', SalesInvoiceLine_LRec.Type::"G/L Account");
                if SalesInvoiceLine_LRec.FindSet(false) then
                    repeat
                        TotalAmt += SalesInvoiceLine_LRec."Amount Including VAT";
                        TotalVatAmtAED += SalesInvoiceLine_LRec."VAT Base Amount" * SalesInvoiceLine_LRec."VAT %" / 100;
                        AmtExcVATLCY += SalesInvoiceLine_LRec.Quantity * SalesInvoiceLine_LRec."Unit Price";
                    until SalesInvoiceLine_LRec.Next = 0;

                //PSP PIno
                SalesInvoiceLine_L.SetRange("Document Type", "Document Type");
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

                SalesInvoiceLine_LRec.Reset;
                SalesInvoiceLine_LRec.SetCurrentKey("Document No.", "Line No.");
                SalesInvoiceLine_LRec.SetRange("Document No.", "Sales Invoice Header"."No.");
                SalesInvoiceLine_LRec.SetRange(Type, SalesInvoiceLine_LRec.Type::Item);
                if SalesInvoiceLine_LRec.FindFirst() then begin
                    SalesShipLine.Reset();
                    IF SalesShipLine.Get(SalesInvoiceLine_LRec."Shipment No.", SalesInvoiceLine_LRec."Shipment Line No.") then begin
                        SalesShipHdr.Reset();
                        //PSP
                        SalesShipHdr.get(SalesShipLine."Document No.");
                        if QuoteNo = '' then
                            QuoteNo := SalesShipHdr."Order No.";
                        Quotedate := SalesShipHdr."Order Date";
                        LCNumebr := SalesShipHdr."LC No. 2"; //PackingListExtChange
                        LCDate := SalesShipHdr."LC Date 2"; //PackingListExtChange
                        LegalizationRequired := SalesShipHdr."Legalization Required 2"; //PackingListExtChange
                        InspectionRequired := SalesShipHdr."Inspection Required 2"; //PackingListExtChange
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
                    end
                    else begin
                        //QuoteNo := "Order No.";
                        //Quotedate := "Order Date";
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
                //until SalesInvoiceLine_LRec.Next = 0;

                TotalIncludingCaption := '';
                ExchangeRate := '';
                TotalAmountAED := TotalAmt;
                If "Currency Factor" <> 0 then begin
                    TotalIncludingCaption := StrSubstNo('Total Including VAT %1', "Currency Code");
                    ExchangeRate := StrSubstNo('%1: %2', "Currency Code", 1 / "Currency Factor");
                    TotalVatAmtAED := TotalVatAmtAED / "Currency Factor";
                    TotalAmountAED := TotalAmt / "Currency Factor";
                    AmtIncVATLCY := AmtExcVATLCY / "Currency Factor";
                End ELSe
                    TotalIncludingCaption := 'Total Including VAT AED';
                ShowExchangeRate := not ("Currency Code" = '');
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
                    "Currency Code" := GLSetup."LCY Code";


                Clear(AmtinWord_GTxt);
                Clear(Check_LRep);
                Check_LRep.InitTextVariable;
                Check_LRep.FormatNoText(AmtinWord_GTxt, TotalAmt, '');
                String := DelChr(AmtinWord_GTxt[1], '<>', '*') + AmtinWord_GTxt[2];
                String := CopyStr(String, 2, StrLen(String));
                Clear(Check_LRep);
                SrNo := 0;
                CustomerRec.Reset();
                IF CustomerRec.get("Sell-to Customer No.") then begin
                    PartialShip := Format(CustomerRec."Shipping Advice");
                    CustTRN := CustomerRec."VAT Registration No.";
                end;
                //Message('No. %1', "No.");

                PmtTrmRec.Reset();
                IF PmtTrmRec.Get("Sales Invoice Header"."Payment Terms Code") then
                    PmttermDesc := PmtTrmRec.Description;
                //If ShowComment THEN begin
                Comment_Lrec.Reset();
                Comment_Lrec.SetRange("No.", "No.");
                Comment_Lrec.SETRAnge("Document Type", Comment_Lrec."Document Type"::"Posted Invoice");
                Comment_Lrec.SetRange("Document Line No.", 0);
                ShowComment := Not Comment_Lrec.IsEmpty();
                //end;


                AreaRec.Reset();
                IF AreaRec.Get("Sales Invoice Header"."Area") then
                    AreaDesc := AreaRec.Text;

                ExitPt.Reset();
                IF ExitPt.Get("Sales Invoice Header"."Exit Point") then
                    ExitPtDesc := ExitPt.Description;

                IF ShowCommercial then
                    RepHdrtext := 'Commercial Invoice'
                else
                    RepHdrtext := 'Tax Invoice';

                IF "Seller/Buyer 2" then
                    Inspection_Caption := '* Inspection will be provided by nominated third party at the Buyer’s cost'
                Else
                    Inspection_Caption := '* Inspection will be provided by nominated third party at the Seller’s cost';

            end;
        }
    }

    requestpage
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
                    field("Print Commercial Invoice"; ShowCommercial)
                    {
                        ApplicationArea = ALL;
                    }
                    field("Do Not Show G\L"; DoNotShowGL)
                    {
                        ApplicationArea = All;
                    }

                    field("Print Customer Invoice"; CustomInvoiceG)
                    {
                        ApplicationArea = ALL;
                    }
                    field("SalesLine Merge"; SalesLineMerge)
                    {
                        ApplicationArea = All;
                        Caption = 'SalesLine UnMerge';
                    }

                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        RepHeader = 'Tax Invoice';
        Ref_Lbl = 'Invoice No.:';
        Date_Lbl = 'Invoice Date :';
        YourReference_Lbl = 'Customer Reference';
        ValidTo_Lbl = 'Due Date';
        DeliveryTerms_Lbl = 'Delivery Terms';
        PaymentTerms_Lbl = 'Payment Terms';
        PartialShipment_Lbl = 'Partial Shipment';
        VatAmt_Lbl = 'VAT Amount';
        TotalPayableinwords_Lbl = 'Total Payable in words';
        ExchangeRate_Lbl = 'Exchange Rate:';
        Terms_Condition_Lbl = 'Remarks:';
        Lbl1 = 'General Sales conditions are provided on the second page of this Commercial Invoice.';
        Lbl2 = 'The beneficiary certify that this Commercial invoice shows the actual price of the goods and Services as described above and no other invoice is issued for this sale.';
        Lbl3 = '';
        Lbl4 = '';
        Lbl5 = '5.';
        Inspection_yes_Lbl = '* Inspection is intended for this order';
        Inspection_no_lbl = '* Inspection is not intended for this order';
        Legalization_yes_Lbl = '* One original Invoice and one original certificate of origin will be Legalized by consulate at the seller’s cost.';
        Legalization_no_Lbl = '* Legalization of the documents are not required for this order';
        BankDetails_Lbl = 'Bank Details';
        BeneficiaryName_Lbl = 'Beneficiary Name:';
        BankName_Lbl = 'Bank Name: ';
        IBANNumber_Lbl = 'Account IBAN Number:';
        SwiftCode_Lbl = 'Swift Code:';
        PortofLoading_Lbl = 'Port Of Loading:';
        PortofDischarge_Lbl = 'Port of Discharge:';
        AmountinAed_Lbl = 'Amount in AED';
        VATAmountinAED_Lbl = 'VAT Amount In AED';
        Origin_Lbl = 'Origin: ';
        HSCode_Lbl = 'HS Code: ';
        Packing_Lbl = 'Packing: ';
        NoOfLoads_Lbl = 'No. Of Loads: ';
        BillTo_Lbl = 'Bill To';
        ShipTo_Lbl = 'Ship To';
        TRN_Lbl = 'TRN:';
        Tel_Lbl = 'Tel No.:';
        PINo_Lbl = 'P/I No.:';
        PIdate_Lbl = 'P/I Date:';
        LCNumber_Lbl = 'L/C Number:';
        LCDate_Lbl = 'L/C Date:';
        Page_Lbl = 'Page';
    }

    trigger OnPreReport()
    var
    //Bank_LRec: Record "Bank Account";
    begin
        CompanyInformation.Get;
        CompanyInformation.CalcFields(Picture);
        //BankNo := 'WWB-EUR';
        // If Bank_LRec.GET(BankNo) then begin
        //     BankName := Bank_LRec.Name;
        //     SWIFTCode := Bank_LRec."SWIFT Code";
        //     IBANNumber := Bank_LRec.IBAN;
        // ENd //Else
        //Error('Bank No. Must not be blank');

    end;

    var
        CompanyInformation: Record "Company Information";
        AmtinWord_GTxt: array[2] of Text[80];
        CustAddr_Arr: array[8] of Text[90];
        CustAddrShipto_Arr: array[8] of Text[90];
        FormatAddr: Codeunit "Format Address";
        SrNo: Integer;
        CurrDesc: Text[50];
        TotalAmt: Decimal;
        ExchangeRate: Text;
        TotalAmountAED: Decimal;
        CurrencyRec: Record Currency;
        TotalVatAmtAED: Decimal;
        SearchDesc: Text[80];
        TotalIncludingCaption: Text[80];
        BankNo: Code[20];
        AmtIncVATLCY: Decimal;
        VATAmtLCY: Decimal;
        GLSetup: Record "General Ledger Setup";
        AmtExcVATLCY: Decimal;
        BankName: Text[50];
        BankAddress: Text[50];
        BankAddress2: Text[50];
        BankCity: Text[30];
        BankCountry: Code[20];
        IBANNumber: Text[50];
        SWIFTCode: Text[20];
        IsItem: Boolean;
        HSNCode: Code[20];
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
        ShowCommercial: Boolean;
        Des1: Text[50];
        RepHdrtext: Text[50];
        //CustTRN: Text[100];
        ExitPt: Record "Entry/Exit Point";

        ExitPtDesc: Text[100];

        AreaRec: Record "Area";
        AreaDesc: Text[100];
        TranSec_Desc: Text[100];
        DoNotShowGL: Boolean;
        Inspection_Caption: Text[250];
        Packing_Txt: Text[250];

        LineHSNCodeText: Text[20];
        LineCountryOfOriginText: Text[20];
        CustomInvoiceG: Boolean;
        SortingNo: Integer;
        ShowExchangeRate: Boolean;
        SalesRemarksArchieve: Record "Sales Remark Archieve";
        Remark: Text[500];
        String: Text[100];
        SNo: Integer;
        SalesLineMerge: Boolean;
}

