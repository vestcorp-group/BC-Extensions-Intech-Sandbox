report 50107 "Credit Memo Report"//T12370-N
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/N Sales Cr. Memo.rdl';

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            //DataItemTableView = WHERE ("No." = CONST ('103001'));//103029
            //RequestFilterFields = "No.";
            column(No_SalesInvoiceHeader; "No.")
            {
            }
            column(PostingDate_SalesInvoiceHeader; "Posting Date")
            {
            }
            column(BilltoName_SalesInvoiceHeader; "Bill-to Name")
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
            column(PortofLoading_SalesInvoiceHeader; AreaDesc)
            {
                /*IncludeCaption = true;*/
            }
            column(PortOfDischarge_SalesInvoiceHeader; ExitPtDesc)
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
            column(YourReferenceNo; "External Document No.")
            {
            }
            column(Validto; "Due Date")
            {
            }
            column(DeliveryTerms; "Shipment Method Code")
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
            column(CustTRN; CustTRN)
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
            column(TotalInvAmt; TotalInvAmt)
            {

            }
            column(TotalInvVatAmtAED; TotalInvVatAmtAED)
            {

            }
            column(Applies_to_Doc__No_; "Applies-to Doc. No.")
            {

            }

            dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
            {
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
                column(Quantity_SalesInvoiceLine; Quantity)
                {
                    IncludeCaption = true;
                }
                column(UnitofMeasureCode_SalesInvoiceLine; "Unit of Measure Code")
                {
                }
                column(UnitPrice_SalesInvoiceLine; "Unit Price")
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
                column(Packing; PackingDesc)
                {

                }
                column(NoOfLoads; '')
                {

                }
                //column(No__of_Load;"No. of Load"
                trigger OnAfterGetRecord()
                var
                    Item_LRec: Record Item;
                    CountryRegRec: Record "Country/Region";
                    ItemAttrb: Record "Item Attribute";
                    ItemAttrVal: Record "Item Attribute Value";
                    ItemAttrMap: Record "Item Attribute Value Mapping";
                begin
                    SrNo += 1;
                    IsItem := FALSE;
                    SearchDesc := '';
                    Origitext := '';
                    HSNCode := '';
                    PackingDesc := '';
                    If Item_LRec.GET("No.") THEN BEGIN
                        //SearchDesc := Item_LRec."Search Description";
                        HSNCode := Item_LRec."Tariff No.";
                        PackingDesc := Item_LRec."Description 2";
                        IsItem := TRUE;
                        CountryRegRec.Reset();
                        IF CountryRegRec.Get(Item_LRec."Country/Region of Origin Code") then
                            Origitext := CountryRegRec.Name;
                        ItemAttrb.Reset();
                        ItemAttrb.SetRange(Name, 'Genric Name');
                        IF ItemAttrb.FindSet() then begin
                            ItemAttrMap.Reset();
                            IF ItemAttrMap.Get(27, Item_LRec."No.", ItemAttrb.ID) then begin
                                ItemAttrVal.Reset();
                                IF ItemAttrVal.get(ItemAttrMap."Item Attribute ID", ItemAttrMap."Item Attribute Value ID") then
                                    SearchDesc := ItemAttrVal.Value;
                            end
                        end;


                    End;
                end;
            }
            //Pasted from Shipemt
            dataitem("Sales Comment Line"; "Sales Comment Line")
            {
                DataItemLink = "No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST("Posted Credit Memo"), "Document Line No." = FILTER(0));
                column(Comment_SalesCommentLine; "Sales Comment Line".Comment) { }
                column(LineNo_SalesCommentLine; "Sales Comment Line"."Line No.") { }
                column(DocumentLineNo_SalesCommentLine; "Sales Comment Line"."Document Line No.") { }

                trigger OnPreDataItem()
                begin
                    //if not ShowComment then
                    //    CurrReport.Break;
                end;
            }

            trigger OnAfterGetRecord()
            var
                SalesInvoiceLine_LRec: Record "Sales Invoice Line";
                SalesCrMemoLine_Lrec: Record "Sales Cr.Memo Line";
                Check_LRep: Report Check;
                VatRegNo_Lctxt: Label 'VAT Registration No. %1';
                CustomerRec: Record Customer;
                PmtTrmRec: Record "Payment Terms";
                SalesShipLine: Record "Sales Shipment Line";
                SalesShipHdr: Record "Sales Shipment Header";
                Comment_Lrec: Record "Sales Comment Line";
                SalesInvHdr_Lrec: Record "Sales Invoice Header";
            begin
                AreaDesc := '';
                ExitPtDesc := '';
                Clear(CustAddr_Arr);
                //FormatAddr.SalesInvBillTo(CustAddr_Arr, "Sales Invoice Header");
                FormatAddr.SalesCrMemoBillTo(CustAddr_Arr, "Sales Cr.Memo Header");
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
                    //CustAddrShipto_Arr[8] := "Ship-to County";
                END;


                TotalAmt := 0;
                TotalVatAmtAED := 0;
                TotalAmountAED := 0;
                PartialShip := '';
                CustTRN := '';
                QuoteNo := '';
                Quotedate := 0D;
                TotalInvAmt := 0;
                TotalInvVatAmtAED := 0;
                SalesCrMemoLine_Lrec.Reset;
                SalesCrMemoLine_Lrec.SetRange("Document No.", "No.");
                if SalesCrMemoLine_Lrec.FindSet(false) then
                    repeat
                        TotalAmt += SalesCrMemoLine_Lrec."Amount Including VAT";
                        TotalVatAmtAED += SalesCrMemoLine_Lrec."VAT Base Amount" * SalesCrMemoLine_Lrec."VAT %" / 100;
                    until SalesCrMemoLine_Lrec.Next = 0;

                IF ("Applies-to Doc. Type" = "Applies-to Doc. Type"::Invoice) AND
                    (NOT ("Applies-to Doc. No." = '')) then begin
                    SalesInvoiceLine_LRec.Reset;
                    SalesInvoiceLine_LRec.SetRange("Document No.", "Applies-to Doc. No.");
                    if SalesInvoiceLine_LRec.FindSet(false) then
                        repeat
                            TotalInvAmt += SalesInvoiceLine_LRec."Amount Including VAT";
                            TotalInvVatAmtAED += SalesInvoiceLine_LRec."VAT Base Amount" * SalesInvoiceLine_LRec."VAT %" / 100;
                        until SalesInvoiceLine_LRec.Next = 0;

                    SalesInvoiceLine_LRec.Reset;
                    SalesInvoiceLine_LRec.SetCurrentKey("Document No.", "Line No.");
                    SalesInvoiceLine_LRec.SetRange("Document No.", "Applies-to Doc. No.");
                    SalesInvoiceLine_LRec.SetRange(Type, SalesInvoiceLine_LRec.Type::Item);
                    if SalesInvoiceLine_LRec.FindFirst() then begin
                        SalesShipLine.Reset();
                        IF SalesShipLine.Get(SalesInvoiceLine_LRec."Shipment No.", SalesInvoiceLine_LRec."Shipment Line No.") then begin
                            SalesShipHdr.Reset();
                            SalesShipHdr.get(SalesShipLine."Document No.");
                            QuoteNo := SalesShipHdr."Quote No.";
                            Quotedate := SalesShipHdr."Order Date";
                            LCNumebr := SalesShipHdr."LC No. 2"; //PackingListExtChange
                            LCDate := SalesShipHdr."LC Date 2"; //PackingListExtChange
                            LegalizationRequired := SalesShipHdr."Legalization Required 2"; //PackingListExtChange
                            InspectionRequired := SalesShipHdr."Inspection Required 2"; //PackingListExtChange
                            //IF BankNo <> '' then
                            BankNo := SalesShipHdr."Bank on Invoice 2"; //PackingListExtChange
                            If Bank_LRec.GET(BankNo) then begin
                                BankName := Bank_LRec.Name;
                                SWIFTCode := Bank_LRec."SWIFT Code";
                                IBANNumber := Bank_LRec.IBAN;
                            end
                        end
                        else begin
                            SalesInvHdr_Lrec.Reset();
                            IF SalesInvHdr_Lrec.get("Applies-to Doc. No.") then begin
                                QuoteNo := SalesInvHdr_Lrec."Quote No.";
                                Quotedate := SalesInvHdr_Lrec."Order Date";
                                LCNumebr := SalesInvHdr_Lrec."LC No. 2"; //PackingListExtChange
                                LCDate := SalesInvHdr_Lrec."LC Date 2"; //PackingListExtChange
                                LegalizationRequired := SalesInvHdr_Lrec."Legalization Required 2"; //PackingListExtChange
                                InspectionRequired := SalesInvHdr_Lrec."Inspection Required 2"; //PackingListExtChange
                                //IF BankNo <> '' then
                                BankNo := SalesInvHdr_Lrec."Bank on Invoice 2"; //PackingListExtChange
                                If Bank_LRec.GET(BankNo) then begin
                                    BankName := Bank_LRec.Name;
                                    SWIFTCode := Bank_LRec."SWIFT Code";
                                    IBANNumber := Bank_LRec.IBAN;
                                end;
                            ENd;
                        end;
                    END;
                END;
                //until SalesInvoiceLine_LRec.Next = 0;

                TotalIncludingCaption := '';
                ExchangeRate := '';
                TotalAmountAED := TotalAmt;
                If "Currency Factor" <> 0 then begin
                    TotalIncludingCaption := StrSubstNo('Total Including %1', "Currency Code");
                    ExchangeRate := StrSubstNo('%1: %2', "Currency Code", 1 / "Currency Factor");
                    TotalVatAmtAED := TotalVatAmtAED / "Currency Factor";
                    TotalAmountAED := TotalAmt / "Currency Factor";
                End ELSe
                    TotalIncludingCaption := 'Total Including AED';

                Clear(AmtinWord_GTxt);
                Clear(Check_LRep);
                Check_LRep.InitTextVariable;
                Check_LRep.FormatNoText(AmtinWord_GTxt, TotalAmt, "Currency Code");
                Clear(Check_LRep);
                SrNo := 0;
                CustomerRec.Reset();
                IF CustomerRec.get("Sell-to Customer No.") then begin
                    PartialShip := Format(CustomerRec."Shipping Advice");
                    CustTRN := CustomerRec."VAT Registration No.";
                end;
                //Message('No. %1', "No.");

                PmtTrmRec.Reset();
                IF PmtTrmRec.Get("Payment Terms Code") then
                    PmttermDesc := PmtTrmRec.Description;
                //If ShowComment THEN begin
                Comment_Lrec.Reset();
                Comment_Lrec.SetRange("No.", "No.");
                Comment_Lrec.SETRAnge("Document Type", Comment_Lrec."Document Type"::"Posted Invoice");
                Comment_Lrec.SetRange("Document Line No.", 0);
                ShowComment := Not Comment_Lrec.IsEmpty();
                //end;


                AreaRec.Reset();
                IF AreaRec.Get("Area") then
                    AreaDesc := AreaRec.Text;

                ExitPt.Reset();
                IF ExitPt.Get("Exit Point") then
                    ExitPtDesc := ExitPt.Description;

                IF ShowCommercial then
                    RepHdrtext := 'TAX CREDIT NOTE'
                else
                    RepHdrtext := 'TAX CREDIT NOTE';
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
        Ref_Lbl = 'Ref:';
        Date_Lbl = 'Date :';
        YourReference_Lbl = 'Customer Reference';
        ValidTo_Lbl = 'Due Date';
        DeliveryTerms_Lbl = 'Delivery Terms';
        PaymentTerms_Lbl = 'Payment Terms';
        PartialShipment_Lbl = 'Partial Shipment';
        VatAmt_Lbl = 'VAT Amount';
        TotalPayableinwords_Lbl = 'Total Payable in words';
        ExchangeRate_Lbl = 'Exchange Rate:';
        Terms_Condition_Lbl = 'Reason:';
        Lbl1 = '';
        Lbl2 = '';
        Lbl3 = '';
        Lbl4 = '';
        Lbl5 = '5.';
        Inspection_yes_Lbl = 'Inspection is intended for this order';
        Inspection_no_lbl = 'Inspection is not intended for this order';
        Legalization_yes_Lbl = 'Legalization of the documents are required for this order';
        Legalization_no_Lbl = 'Legalization of the documents are not required for this order';
        BankDetails_Lbl = 'Bank Details';
        BeneficiaryName_Lbl = 'Beneficiary Name:';
        BankName_Lbl = 'Bank Name: ';
        IBANNumber_Lbl = 'IBAN Number:';
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
        OrigInvDet_Lbl = 'Original Invoice detail';
        Originv_Lbl = 'Original Invoice';
        InvAmt_Lbl = 'Invoice Amount';
        RevInvAmt_lbl = 'Revised Invoice Amount';
        DiffAmt_lbl = 'Difference Amount';
        DiffOfVAT_Lbl = 'Differential of VAT';

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
        TotalAmt: Decimal;
        ExchangeRate: Text;
        TotalAmountAED: Decimal;
        TotalVatAmtAED: Decimal;
        SearchDesc: Text[80];
        TotalIncludingCaption: Text[80];
        BankNo: Code[20];
        BankName: Text[50];
        IBANNumber: Text[50];
        SWIFTCode: Text[20];
        IsItem: Boolean;
        HSNCode: Code[20];
        Origitext: Text[50];
        PartialShip: Text[20];
        CustTRN: Text[50];
        PmttermDesc: Text[100];
        QuoteNo: code[20];
        Quotedate: Date;
        LCNumebr: Code[50];
        LCDate: Date;
        ShowComment: Boolean;
        LegalizationRequired: Boolean;
        InspectionRequired: Boolean;
        Bank_LRec: Record "Bank Account";
        ShowCommercial: Boolean;
        RepHdrtext: Text[50];
        //CustTRN: Text[100];
        ExitPt: Record "Entry/Exit Point";

        ExitPtDesc: Text[100];

        AreaRec: Record "Area";
        AreaDesc: Text[100];
        PackingDesc: Text[100];
        TotalInvAmt: Decimal;
        TotalInvVatAmtAED: Decimal;

}

