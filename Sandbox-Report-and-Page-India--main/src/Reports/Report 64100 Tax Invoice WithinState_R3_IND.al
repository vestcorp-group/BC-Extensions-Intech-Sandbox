report 64100 "Tax Invoice WithinState_R3_IND"//T12370-Full Comment
{
    UsageCategory = Administration;
    ApplicationArea = all;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Tax_Invoice_withinState_R3_IND.rdl';
    Caption = 'Posted Sales Invoice-Tax Invoice(Within State)';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            //DataItemTableView = WHERE ("No." = CONST ('103001'));//103029
            //RequestFilterFields = "No.";
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(No_SalesInvoiceHeader; "No.")
            {
            }
            column(Name; Name)
            {

            }
            column(SalesLineMerge; SalesLineMerge) { }
            column(MergeChargeItem_gBln; MergeChargeItem_gBln) { }
            column(Locationadd_gTxt; Locationadd_gTxt)
            {
            }
            column(HideRemarks; HideRemarks) { }

            column(Due_Date; "Due Date")
            {

            }
            // column(SGSTAmt; SGSTAmt)
            // {

            // }
            column(iGSTAmt; iGSTAmt)
            {

            }
            column(O; O)
            {

            }
            column(D; D)
            {

            }
            column(T; T)
            {

            }
            column(CustomeSatedesc; CustomeSatedesc)
            {

            }
            column(CurrencyCOde; CurrencyCOde)
            {

            }


            column(BankaccountName; BankName_gTxt)
            {

            }
            //PKM
            column(Billname; Billname)
            {

            }

            column(Billadress1; Billadress1)
            {

            }

            column(billadres2; billadres2)
            {

            }

            column(billcity; billcity)
            {

            }
            column(Billteliphone; Billteliphone)
            {

            }
            column(Postcodecaption; Postcodecaption)
            {

            }
            column(ShippName; ShippName)
            {

            }
            column(ShipCaption; ShipCaption)
            {

            }
            // column(Ship_to_Post_Code;)
            column(ShippAdress1; ShippAdress1)
            {

            }

            column(ShippAddress2; ShippAddress2)
            {

            }
            column(ShippCity; ShippCity)
            {

            }
            column(ShippPostcode; ShippPostcode)
            {

            }


            // column(BankaccountAccNo; Bankaccount."Bank Account No.")
            // {

            // }
            // //Commented-Niharika
            // column(BankaccountBranch; Bankaccount."Branch Name")
            // {

            // }
            // column(BankaccountIFAC; Bankaccount."IFSC CODE")
            // {

            // }
            // column(BankaccountSWIFTcode; Bankaccount."SWIFT Code")
            // {

            // }
            // column(cGSTAmt; CGSTAmt)
            // {

            // }
            column(Tax_Type; "Tax Type") { }
            column(Hide_E_sign; Hide_E_sign) { }
            column(Print_copy; Print_copy) { }
            column(PostingDate_SalesInvoiceHeader; "Posting Date")
            { }
            column(Currency_Factor; "Currency Factor")
            { }
            column(Currency_Code; "Currency Code")
            { }
            column(countryDesc; countryDesc)
            { }
            column(BilltoName_SalesInvoiceHeader; "Bill-to Name")
            { }
            column(CompanyInformation_Address; CompanyInformation.Address)
            { }
            column(CompanyInformation_Address2; CompanyInformation."Address 2")
            { }
            column(CompanyInformation_City; CompanyInformation.City + ', Pin Code - ' + CompanyInformation."Post Code")
            {
            }
            column(CompanyInformation_City1; CompanyInformation.City)
            {
            }
            column(CompanyInformation_Country; CompanyInformation."Country/Region Code")
            {
            }
            column(CompName; CompanyInformation.Name)
            {
            }
            column(CompanyInformationGST; 'GST No.: ' + CompanyInformation."GST Registration No.")
            {


            }
            column(CompanyInformation; 'CIN No.: ' + CompanyInformation."Registration No.")
            {

            }
            column(CompanyInfoRegisNoNew; CompanyInformation."Registration No New")
            {

            }
            //bank
            column(CompanyAccNo; CompanyInformation."Bank Account No.")
            {

            }
            column(CompanyBankName; CompanyInformation.Name)
            {

            }
            column(CompanyIFAC; CompanyInformation."Bank Branch No.")
            {

            }

            column(CompanyInformationPANNo; 'PAN No.: ' + CompanyInformation."P.A.N. No.")
            {

            }
            column(CountryRecContryName; CountryRec.Name)
            {

            }
            column(CompanyInformationpostcode; 'Pin - ' + CompanyInformation."Post Code")
            {

            }
            column(CustRecSellPAn; CustRecSell."P.A.N. No.")
            {

            }
            column(CustRecBill; CustRecBill."P.A.N. No.")
            {

            }
            column(ShiptoVar; ShiptoVar)
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
            column(Bill_to_City; "Bill-to City")
            {
            }
            column(Order_No_; SalesOrderNo)
            { }
            column(Ship_to_City; "Ship-to City")
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
            column(CustAddr_Arr4; CustAddr_Arr[4] + ' ' + CustAddr_Arr[5])
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
            column(LCYCode; GLSetup."LCY Code")
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
            column(CustAddrShipto_Arr5; CustAddrShipto_Arr[5] + ' ' + CustAddrShipto_Arr[6])
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
            column(Validto; Format("Due Date", 0, '<Day,2>-<Month Text>-<year4>'))
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
            column(AmtExcVATLCY; AmtExcVATLCY)
            {

            }
            column(TotalAmountAED; TotalAmountAED)
            {

            }
            column(CurrDesc; CurrDesc)
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
            column(Total_UOM; TempUOM.Code)
            {
            }
            column(QuoteNo; QuoteNo)
            {
            }
            column(Quotedate; Quotedate)
            {
            }
            column(AmtIncVATLCY; AmtIncVATLCY)
            {
            }
            column(LC_No; "LC No. 2") //PackingListExtChange
            {
            }
            column(LC_Date; "LC Date 2") //PackingListExtChange
            {
            }
            column(PartialShip; PartialShip)
            {
            }
            column(CustTRN; CustTRN)
            {
            }
            column(CustGSTNo; CustGSTNo)
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
            column(String1; 'Total Amount Including GST ' + string1 + ' ' + CurrDesc)
            {

            }
            column(Inspection_Caption; Inspection_Caption)
            {
            }
            column(Show_Exchange_Rate; ShowExchangeRate)
            { }
            column(SNo; SNo) { }
            column(Order_Date; "Order Date")
            {
            }
            column(Duty_Exemption; "Duty Exemption")
            {
            }
            //AW09032020>>
            column(PI_Validity_Date; Format("PI Validity Date", 0, '<Day,2>-<Month Text>-<year4>'))
            {
            }
            //AW09032020<<
            //SD Term & Conditions GK 04/09/2020
            column(Condition1; text1) { }
            column(Condition2; Text21) { }
            column(Condition31; Text22) { }
            column(Condition32; Condition32) { }
            column(Condition33; Condition33) { }
            column(Condition4; Text23) { }
            column(Condition5; Text24) { }
            column(Condition6; Condition6) { }
            column(Condition7; Text25) { }
            column(Condition8; Condition8) { }
            column(Condition91; Condition91) { }
            column(Condition92; Text26) { }
            column(Condition1011; Text27) { }
            column(Condition1011a; Condition1011a) { }
            column(Condition1011b; Condition1011b) { }
            column(Condition1011c; Condition1011c) { }
            column(Condition1012; Text28) { }
            column(Condition1021; Text29) { }
            column(Condition1021a; Text30) { }
            column(Condition1021b; Text31) { }
            column(Condition103; Condition103) { }
            column(Condition1041; Text32) { }
            column(Condition1041a; Condition1041a) { }
            column(Condition1041b; Condition1041b) { }
            column(Condition1041c; Condition1041c) { }
            column(Condition11; Text33) { }
            column(Condition12; text12) { }
            column(Condition13; Condition13) { }
            column(Insurance_Policy_No_; "Insurance Policy No.") { }
            column(InsurancePolicy; InsurancePolicy) { }
            column(HideBank_Detail; HideBank_Detail) { }
            //07-07-2022-start
            column(IRN_Hash; "IRN Hash")
            {

            }
            column(E_Invoice_QR_Code; "Sales Invoice Header"."QR Code")
            {

            }
            //07-07-2022-end

            //SD Term & Conditions GK 04/09/2020
            dataitem("Sales Invoice Line"; "Sales Invoice Line")
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
                { }
                column(GST_Group_Code; "GST Group Code")
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
                column(UnitPrice_SalesInvoiceLine; NewUnitPrice_gDec)// Customeunitprice)
                {
                    // IncludeCaption = true;
                }
                column(TaxableAmountDiff_gDec; TaxableAmountDiff_gDec)
                { }
                column(VatPer; "VAT %")
                {
                    // IncludeCaption = true;
                }
                column(VatAmt; SalesLineVatBaseAmount * "VAT %" / 100)
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
                column(SGSTAmt; SGSTAmt)
                {

                }
                column(cGSTAmt; CGSTAmt)
                {

                }
                column(Sgst_gDec; Sgst_gDec) { }
                column(Cgst_gDec; Cgst_gDec) { }
                column(NoOfLoads; '')
                {
                }
                column(LineHSNCodeText; LineHSNCodeText)
                { }
                column(LineCountryOfOriginText; LineCountryOfOriginText)
                { }
                column(Sorting_No_; SortingNo)
                { }
                column(SrNo3; SrNo3) { }
                column(SrNo4; SrNo4) { }
                column(SrNo5; SrNo5) { }
                column(PINONew; PINONew) { }
                column(OrderNo; OrderNo)
                {

                }
                column(STPer; STPer)
                {

                }
                column(CTPer; CTPer)
                {

                }
                column(ITPer; ITPer)
                {

                }
                column(AMountInW; AMountInW + ' ' + Notext[2])
                {

                }
                column(TotalValue; TotalValue)
                {

                }
                column(TotalValue1; TotalValue1)
                { }
                column(TotalSgstamt; TotalSgstamt)
                {

                }
                column(TotalCgstamt; TotalCgstamt)
                {

                }
                column(TotalIgstamt; TotalIgstamt)
                {

                }
                column(Line_Amount; "Line Amount")
                {

                }
                column(Amount; Amount_gDec) { }

                column(PIDateNew; PIDateNew) { }
                column(VatOOS; VatOOS) { }
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
                    SL_lRec: Record "Sales Invoice Line";
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





                begin
                    Clear(SalesLineAmount);
                    Clear(SalesLineAmountincVat);
                    Clear(SalesLineVatBaseAmount);
                    Clear(VatPercentage);
                    NewUnitPrice_gDec := 0;
                    TotalFreight_gDec := 0;
                    ItemSumQty_gDec := 0;
                    ChargeSumQty_gDec := 0;
                    OrderNo := "Order No.";
                    // if SalesLineMerge then begin
                    if MergeChargeItem_gBln then begin
                        if "Sales Invoice Line".Type = "Sales Invoice Line".Type::"Charge (Item)" then
                            CurrReport.Skip();
                    end;

                    SGSTAmt := 0;
                    CGSTAmt := 0;
                    IGSTAmt := 0;
                    // end;

                    STPer := 0;
                    CTPer := 0;
                    ITPer := 0;
                    TotalValue := 0;
                    // TotalValue1 := 0;
                    VATAmount := 0;
                    TotGST := 0;
                    // TotalCgstamt := 0;
                    // TotalSgstamt := 0;
                    if "GST Group Code" <> '' then
                        CalculateLineGST("Sales Invoice Header", "Sales Invoice Line");


                    // GSTledgerentry.Reset();
                    // GSTledgerentry.SetRange("Document Type", GSTledgerentry."Document Type"::Invoice);
                    // GSTledgerentry.SetRange("Transaction Type", GSTledgerentry."Transaction Type"::Sales);
                    // GSTledgerentry.SetRange("Document No.", "Document No.");
                    // //GSTledgerentry.SetRange("No.", "No.");
                    // GSTledgerentry.SetRange("Document Line No.", "Line No.");

                    // IF GSTledgerentry.FindSet() THEN
                    //     repeat

                    //         //  Message('%1', GSTledgerentry."GST Amount");
                    //         IF GSTledgerentry."GST Component Code" = 'SGST' THEN begin
                    //             STPer := GSTledgerentry."GST %";
                    //             SGSTAmt += ABS(GSTledgerentry."GST Amount");
                    //         end;

                    //         IF GSTledgerentry."GST Component Code" = 'CGST' THEN begin
                    //             CTPer := GSTledgerentry."GST %";
                    //             CGSTAmt += ABS(GSTledgerentry."GST Amount");
                    //         end;

                    //         IF GSTledgerentry."GST Component Code" = 'IGST' THEN begin
                    //             ITPer := GSTledgerentry."GST %";
                    //             iGSTAmt := ABS(GSTledgerentry."GST Amount");
                    //         end;

                    //         if "Sales Invoice Line".Type = "Sales Invoice Line".Type::"G/L Account" then //added by bayas
                    //             if "Sales Invoice Line"."No." = '440220' then begin
                    //                 SGSTAmt := -ABS(GSTledgerentry."GST Amount");
                    //                 CGSTAmt := -ABS(GSTledgerentry."GST Amount");
                    //             end;

                    //     Until GSTledgerentry.Next() = 0;

                    // if MergeChargeItem_gBln then
                    //     TotGST := iGSTAmt + CGSTAmt + SGSTAmt + FindGSTDifference_lFnc()
                    // else
                    TotGST := iGSTAmt + CGSTAmt + SGSTAmt;

                    // TotalCgstamt := TotalCgstamt + CGSTAmt;
                    // TotalSgstamt := TotalSgstamt + SGSTAmt;
                    // TotalIgstamt := TotalIgstamt + IGSTAmt;



                    // if SalesLineMerge then
                    //     if MergeChargeItem_gBln then
                    //         TotalValue := TotalValue + abs("VAT Base Amount") + abs(TotGST) + TaxableAmountDiff_gDec
                    //     else
                    //         TotalValue := TotalValue + abs("VAT Base Amount") + abs(TotGST);//AS-O 10-03-2025
                    // TotalValue := TotalValue + SalesLineAmtIncVat + abs(TotGST);
                    VATAmount := VATAmount + "VAT Base Amount"; //added by bayas

                    if "Sales Invoice Line".Type = "Sales Invoice Line".Type::"G/L Account" then //added by bayas
                        if "Sales Invoice Line"."No." = '440220' then begin
                            // TotalValue := -Abs(TotalValue);
                        end;


                    GrandTotal := GrandTotal + TotGST + VATAmount;  //added by bayas
                                                                    //GrandTotal := GrandTotal + TotGST + abs("VAT Base Amount"); //hide by bayas

                    // chekReport.InitTextVariable();
                    //  chekReport.FormatNoText(Notext, total, '');

                    //-
                    CheckReportNew.InitTextVariable();
                    //CheckReportNew.FormatNoText(Notext, GrandTotal, '');
                    // CheckReportNew.FormatNoText(Notext, round(GrandTotal, 0.01), "Sales Invoice Header"."Currency Code");
                    CheckReportNew.FormatNoText(Notext, round(TotalValue, 0.01), "Sales Invoice Header"."Currency Code");

                    // AMountInW := DelChr(Notext[1], '<>', '*') + Notext[2];
                    // AMountInW := CopyStr(String1, 2, StrLen(String1));

                    // AMountInW := CopyStr(Notext[1], 1, StrPos(Notext[1], '/100') - 1) + ' PAISA ONLY';
                    AMountInW := Notext[1];



                    if VATpostingSetupRec.Get("VAT Bus. Posting Group", "VAT Prod. Posting Group") then;
                    if VATpostingSetupRec."Out of scope" then VatOOS := true;

                    //T52416-NS

                    if PostedCustomInvoiceG then begin
                        SL_lRec.Reset();
                        SL_lRec.SetRange("Document No.", "Sales Invoice Header"."No.");
                        SL_lRec.SetRange(Type, SL_lRec.Type::"Charge (Item)");
                        if SL_lRec.FindSet() then begin
                            repeat
                                TotalFreight_gDec += SL_lRec."Customer Requested Unit Price";
                                ChargeSumQty_gDec += SL_lRec."Quantity (Base)";
                            until SL_lRec.Next() = 0;
                        end
                    end else begin

                        SL_lRec.Reset();
                        SL_lRec.SetRange("Document No.", "Sales Invoice Header"."No.");
                        SL_lRec.SetRange(Type, "Sales Invoice Line".Type::"Charge (Item)");
                        if SL_lRec.FindSet() then begin
                            repeat
                                TotalFreight_gDec += SL_lRec."Unit Price Base UOM 2";
                                ChargeSumQty_gDec += SL_lRec."Quantity (Base)";
                            until SL_lRec.Next() = 0;
                        end;
                    end;

                    SL_lRec.Reset();
                    SL_lRec.SetRange("Document No.", "Sales Invoice Header"."No.");
                    SL_lRec.SetRange(Type, "Sales Invoice Line".Type::Item);
                    if SL_lRec.FindSet() then begin
                        repeat
                            ItemSumQty_gDec += SL_lRec."Quantity (Base)";
                        until SL_lRec.Next() = 0;
                    end;

                    // T52416 - NE



                    // if  <> 0 then
                    // if "VAT Prod. Posting Group"// SGSTAmt :=  Amount_gDec * igper / 100 
                    //GK

                    // T52416-NS   code commented merging old functionality.

                    if PostedCustomInvoiceG then begin
                        Customeunitprice := "Sales Invoice Line"."Unit Price Base UOM 2";
                        //     NewUnitPrice_gDec := "Sales Invoice Line"."Unit Price Base UOM 2";
                        //     // Customeunitprice := "Sales Invoice Line"."Customer Requested Unit Price";// AS- 10-01-25
                        //     if MergeChargeItem_gBln then
                        //         //     Amount_gDec := "Sales Invoice Line".Amount + FindAmountDiff_lFnc()
                        //         // else
                        Amount_gDec := "Sales Invoice Line".Amount;

                        //     if MergeChargeItem_gBln then begin
                        //         if ("Sales Invoice Line"."Quantity (Base)" * Customeunitprice) <> 0 then begin
                        //             // TaxableAmountDiff_gDec := FindLineAmountDiff_lFnc();
                        //         end;
                        //     end;

                        //     SalesLineAmount := "Sales Invoice Line"."Quantity (Base)" * "Sales Invoice Line"."Customer Requested Unit Price";
                        //     SalesLineAmountincVat := (SalesLineAmount * "VAT %" / 100) + SalesLineAmount;
                        //     SalesLineVatBaseAmount := SalesLineAmount;

                        // end
                        // else begin
                        //     NewUnitPrice_gDec := "Sales Invoice Line"."Unit Price Base UOM 2";
                        //     Customeunitprice := "Sales Invoice Line"."Unit Price Base UOM 2"; //PackingListExtChange

                        //     if MergeChargeItem_gBln then begin
                        //         if ("Sales Invoice Line"."Quantity (Base)" * Customeunitprice) <> 0 then begin
                        //             // TaxableAmountDiff_gDec := FindLineAmountDiff_lFnc();
                        //         end;
                        //     end;

                        //     SalesLineAmount := "Sales Invoice Line".Amount;
                        //     SalesLineAmountincVat := "Sales Invoice Line"."Amount Including VAT";
                        //     SalesLineVatBaseAmount := "Sales Invoice Line"."VAT Base Amount";
                    end;

                    // T52416-NE   code commented merging old functionality.

                    if MergeChargeItem_gBln then begin
                        if ItemSumQty_gDec <> ChargeSumQty_gDec then
                            Error('Sum of  item quantity  and charge Item quantity not match');
                        // AmountExclVATDiff_gDec := FindLineAmountDiff_lFnc();
                        if PostedCustomInvoiceG then begin
                            NewUnitPrice_gDec := "Sales Invoice Line"."Customer Requested Unit Price" + TotalFreight_gDec;
                            // NewLineAmtExclVAT_gDec := "Sales Invoice Line"."Quantity (Base)" * "Sales Invoice Line"."Customer Requested Unit Price" + FindLineAmountDiff_lFnc(); //T52416-N Commented as suggested by YASH
                        end else begin
                            NewUnitPrice_gDec := "Sales Invoice Line"."Unit Price Base UOM 2" + TotalFreight_gDec;
                            // NewLineAmtExclVAT_gDec := "Sales Invoice Line"."Quantity (Base)" * "Sales Invoice Line"."Unit Price Base UOM 2" + FindLineAmountUOMDiff_lFnc();
                        end;

                        // NewUnitPrice_gDec := NewLineAmtExclVAT_gDec / "Sales Invoice Line"."Quantity (Base)";
                    end else begin
                        if PostedCustomInvoiceG then
                            NewUnitPrice_gDec := "Sales Invoice Line"."Customer Requested Unit Price"
                        else
                            NewUnitPrice_gDec := "Sales Invoice Line"."Unit Price Base UOM 2";
                    end;

                    // if SalesLineMerge then begin
                    //     if MergeChargeItem_gBln then
                    //         if "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then
                    //             //         TotalValue := TotalValue + abs("VAT Base Amount") + abs(TotGST) + TaxableAmountDiff_gDec
                    //             // end else
                    //             TotalValue := TotalValue + abs("VAT Base Amount") + abs(TotGST);
                    // end else begin

                    //     if MergeChargeItem_gBln then begin
                    //         if "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then
                    //             //         TotalValue := TotalValue + abs("VAT Base Amount") + abs(TotGST) + TaxableAmountDiff_gDec
                    //             // end else
                    //             TotalValue := TotalValue + abs("VAT Base Amount") + abs(TotGST);
                    //     end;
                    // end;
                    // if MergeChargeItem_gBln then begin
                    //     if ("Sales Invoice Line"."Quantity (Base)" * Customeunitprice) <> 0 then begin
                    //         TaxableAmountDiff_gDec := FindLineAmountDiff_lFnc();
                    //     end;
                    // end;
                    //GK

                    // ShowVat in ""
                    // if "Sales Invoice Line"."VAT Prod. Posting Group"=''
                    //psp
                    if not SalesLineMerge then begin
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

                                // GSTledgerentry.Reset();
                                // GSTledgerentry.SetRange("Document Type", GSTledgerentry."Document Type"::Invoice);
                                // GSTledgerentry.SetRange("Transaction Type", GSTledgerentry."Transaction Type"::Sales);
                                // GSTledgerentry.SetRange("Document No.", SalesLineL."Document No.");
                                // //GSTledgerentry.SetRange("No.", "No.");
                                // GSTledgerentry.SetRange("Document Line No.", SalesLineL."Line No.");

                                // IF GSTledgerentry.FindSet() THEN
                                //     repeat

                                //         //  Message('%1', GSTledgerentry."GST Amount");
                                //         IF GSTledgerentry."GST Component Code" = 'SGST' THEN begin
                                //             STPer := GSTledgerentry."GST %";
                                //             SGSTAmt += ABS(GSTledgerentry."GST Amount");
                                //         end;

                                //         IF GSTledgerentry."GST Component Code" = 'CGST' THEN begin
                                //             CTPer := GSTledgerentry."GST %";
                                //             CGSTAmt += ABS(GSTledgerentry."GST Amount");
                                //         end;

                                //         IF GSTledgerentry."GST Component Code" = 'IGST' THEN begin
                                //             ITPer := GSTledgerentry."GST %";
                                //             iGSTAmt := ABS(GSTledgerentry."GST Amount");
                                //         end;

                                //         if "Sales Invoice Line".Type = "Sales Invoice Line".Type::"G/L Account" then //added by bayas
                                //             if SalesLineL."No." = '440220' then begin
                                //                 SGSTAmt := -ABS(GSTledgerentry."GST Amount");
                                //                 CGSTAmt := -ABS(GSTledgerentry."GST Amount");
                                //             end;

                                //     Until GSTledgerentry.Next() = 0;

                                // TotGST := iGSTAmt + CGSTAmt + SGSTAmt;


                                // if MergeChargeItem_gBln then begin
                                //     TotGST := TotGST + FindGSTDifference_lFnc();
                                //     SGSTAmt := TotGST / 2;
                                //     CGSTAmt := TotGST / 2;
                                // end;

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
                                        Sgst_gDec += SGSTAmt;
                                        Cgst_gDec += CGSTAmt;
                                    end else begin
                                        Clear(SalesLineVatBaseAmount);
                                        "Quantity (Base)" += SalesLineL."Quantity (Base)";
                                        SalesLineAmountincVat += SalesLineL."Amount Including VAT";

                                        Amount += SalesLineL.Amount;
                                        SalesLineVatBaseAmount += Amount;
                                        "VAT Base Amount" += SalesLineL."VAT Base Amount";
                                        Sgst_gDec += SGSTAmt;
                                        Cgst_gDec += CGSTAmt;
                                    end;
                                    // TotalValue := TotalValue + "VAT Base Amount" + abs(TotGST);
                                end;
                            until SalesLineL.Next() = 0;

                        TotalValue := "Sales Invoice Line"."Quantity (Base)" * NewUnitPrice_gDec + (("Sales Invoice Line"."Quantity (Base)" * NewUnitPrice_gDec) * CTPer / 100) + (("Sales Invoice Line"."Quantity (Base)" * NewUnitPrice_gDec) * STPer / 100);
                        TotalValue1 += "Sales Invoice Line"."Quantity (Base)" * NewUnitPrice_gDec + (("Sales Invoice Line"."Quantity (Base)" * NewUnitPrice_gDec) * CTPer / 100) + (("Sales Invoice Line"."Quantity (Base)" * NewUnitPrice_gDec) * STPer / 100);

                        // if not SalesLineMerge then
                        //     TotalValue := TotalValue + "VAT Base Amount" + abs(TotGST);

                        // if MergeChargeItem_gBln then begin
                        //     TotGST := TotGST + FindGSTDifference_lFnc();
                        //     SGSTAmt := TotGST / 2;
                        //     CGSTAmt := TotGST / 2;
                        // end;
                    end;

                    if ("Sales Invoice Line".Type = "Sales Invoice Line".Type::Item) AND ("Quantity (Base)" = 0) then
                        CurrReport.Skip();

                    if ("Sales Invoice Line".Type = "Sales Invoice Line".Type::"G/L Account") AND (PostedDoNotShowGL) then
                        CurrReport.Skip();
                    // if type = Type::Item then
                    SrNo += 1;


                    IsItem := FALSE;
                    SearchDesc := '';
                    Origitext := '';
                    // HSNCode := '';
                    SortingNo := 2;
                    Result := 0;

                    If Item_LRec.GET("No.") THEN BEGIN
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
                        // Packing_Txt := Item_LRec."Description 2";
                        IsItem := TRUE;
                        SortingNo := 1;
                        CountryRegRec.Reset();
                        if ShowCustomerCOO then begin

                            IF CountryRegRec.Get(Item_LRec."Country/Region of Origin Code") then
                                Origitext := CountryRegRec.Name;
                        end
                        else begin
                            if CountryRegRec.Get(Item_LRec."Country/Region of Origin Code") then
                                Origitext := CountryRegRec.Name;
                        end;
                        SearchDesc := Item_LRec."Generic Description";
                        ItemUnitofMeasureL.Ascending(true);
                        ItemUnitofMeasureL.SetRange("Item No.", Item_LRec."No.");
                        if ItemUnitofMeasureL.FindFirst() then begin
                            Result := ROUND("Quantity (Base)" / ItemUnitofMeasureL."Qty. per Unit of Measure", 0.01, '=');

                            SalesLineUOM := ItemUnitofMeasureL.Code;
                            if uom.Get(ItemUnitofMeasureL.Code) then;


                            if (UOM."Decimal Allowed") then
                                if (UOM.Code = 'KG') then
                                    SalesLineUOM := StringProper.ConvertString(ItemUnitofMeasureL.Code)
                                else
                                    SalesLineUOM := ItemUnitofMeasureL.Code
                            else begin
                                if Result > 1 then ItemUnitofMeasureL.Code := ItemUnitofMeasureL.Code + 's';
                                SalesLineUOM := StringProper.ConvertString(ItemUnitofMeasureL.Code);
                            end;

                            if "Allow Loose Qty." then begin
                                if "Variant Code" <> '' then begin // add by bayas
                                    VariantRec.Get("No.", "Variant Code");
                                    if VariantRec."Packing Description" <> '' then begin
                                        Packing_Txt := format(Quantity) + ' Loose ' + "Unit of Measure Code" + ' of ' + VariantRec."Packing Description";
                                    end else begin
                                        Packing_Txt := format(Result) + ' Loose ' + SalesLineUOM + ' of ' + Format(ItemUnitofMeasureL."Net Weight") + 'kg'
                                    end;
                                end else begin
                                    Packing_Txt := format(Result) + ' Loose ' + SalesLineUOM + ' of ' + Format(ItemUnitofMeasureL."Net Weight") + 'kg'
                                end;
                                //Packing_Txt := format(Result) + ' Loose ' + SalesLineUOM + ' of ' + Format(ItemUnitofMeasureL."Net Weight") + 'kg'
                            end else
                                if "Variant Code" <> '' then begin // add by bayas
                                    VariantRec.Get("No.", "Variant Code");
                                    if VariantRec."Packing Description" <> '' then begin
                                        Packing_Txt := format(Quantity) + ' ' + "Unit of Measure Code" + ' of ' + VariantRec."Packing Description";
                                    end else begin
                                        Packing_Txt := format(Result) + ' ' + SalesLineUOM + ' of ' + Item_LRec."Description 2";
                                    end;
                                end else begin
                                    Packing_Txt := format(Result) + ' ' + SalesLineUOM + ' of ' + Item_LRec."Description 2";
                                end;
                            //Packing_Txt := format(Result) + ' ' + SalesLineUOM + ' of ' + Item_LRec."Description 2";
                        end;
                    End;

                    LineHSNCodeText := '';
                    LineCountryOfOriginText := '';

                    // SalesLineL.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                    // SalesLineL.SetRange("Line No.", "Sales Invoice Line"."Line No.");
                    // if SalesLineL.FindFirst() then begin
                    IF CountryRegRec.Get(LineCountryOfOrigin) then
                        LineCountryOfOriginText := CountryRegRec.Name;
                    LineHSNCodeText := LineHSNCode;

                    // end;

                    if PostedCustomInvoiceG then begin
                        HSNCode := LineHSNCodeText;
                        Origitext := LineCountryOfOriginText;

                        //AW09032020>>
                        if "Line Generic Name" <> '' then
                            SearchDesc := "Line Generic Name";
                        //AW09032020<<
                        //UK::08062020>>
                    end else begin
                        HSNCode := "Sales Invoice Line".HSNCode;
                        Origitext := "Sales Invoice Line".CountryOfOrigin;
                    end;
                    //UK::08062020<<
                    //UK::04062020>>
                    //code commented due to reason
                    // SalesHeaderRec.Reset();
                    // SalesHeaderRec.SetRange("No.", "Sales Invoice Line"."Blanket Order No.");
                    // if SalesHeaderRec.FindFirst() then begin     
                    //UK::24062020>>
                    if "Sales Invoice Line"."Blanket Order No." <> '' then begin
                        // if PostedCustomInvoiceG then
                        //     PINONew := "Sales Invoice Line"."Blanket Order No." + '-A'
                        // else
                        PINONew := "Sales Invoice Line"."Blanket Order No.";
                        SalesHeader.Reset();
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::"Blanket Order");
                        SalesHeader.SetRange("No.", "Sales Invoice Line"."Blanket Order No.");
                        if SalesHeader.FindFirst() then
                            PIDateNew := SalesHeader."Order Date"
                        else begin
                            salesHeaderArchive.Reset();
                            salesHeaderArchive.SetRange("Document Type", salesHeaderArchive."Document Type"::"Blanket Order");
                            salesHeaderArchive.SetRange("No.", "Sales Invoice Line"."Blanket Order No.");
                            if salesHeaderArchive.FindFirst() then
                                PIDateNew := salesHeaderArchive."Order Date";
                        end;
                    end else begin
                        PINONew := "Sales Invoice Line"."Order No.";
                        SalesHeader.Reset();
                        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                        SalesHeader.SetRange("No.", "Sales Invoice Line"."Order No.");
                        if SalesHeader.FindFirst() then
                            PIDateNew := SalesHeader."Order Date"
                        else begin
                            salesHeaderArchive.Reset();
                            salesHeaderArchive.SetRange("Document Type", salesHeaderArchive."Document Type"::Order);
                            salesHeaderArchive.SetRange("No.", "Sales Invoice Line"."Order No.");
                            if salesHeaderArchive.FindFirst() then
                                PIDateNew := salesHeaderArchive."Order Date";
                        end;
                    end;
                    //UK::24062020<<
                    // PIDateNew := "Sales Invoice Header"."Order Date";
                    // end
                    // else begin
                    // PINONew := "Order No.";
                    // PIDateNew := "Sales Invoice Header"."Order Date";
                    // end;
                    //UK::04062020<<
                    if SalesShipHdr.Get("Sales Invoice Line"."Shipment No.") then
                        SalesOrderNo := SalesShipHdr."Order No."
                    else
                        SalesOrderNo := "Sales Invoice Line"."Order No.";

                    //UK::03062020>>
                    if PostedCustomInvoiceG then begin
                        HSNCode := "Sales Invoice Line".LineHSNCode;
                        //UK::24062020>>
                        CountryRegRec.Reset();
                        if CountryRegRec.Get("Sales Invoice Line".LineCountryOfOrigin) then
                            Origitext := CountryRegRec.Name;
                    end else begin
                        HSNCode := "Sales Invoice Line".HSNCode;
                        CountryRegRec.Reset();
                        if CountryRegRec.Get("Sales Invoice Line".CountryOfOrigin) then
                            Origitext := CountryRegRec.Name;
                    end;
                    //UK::24062020<<
                    //UK::03062020<<





                    // if MergeChargeItem_gBln then begin
                    //     TotGST := TotGST + FindGSTDifference_lFnc();
                    //     SGSTAmt := TotGST / 2;
                    //     CGSTAmt := TotGST / 2;
                    // end;
                    // if MergeChargeItem_gBln then begin
                    //     TotGST := iGSTAmt + CGSTAmt + SGSTAmt + FindGSTDifference_lFnc();
                    //     CGSTAmt := TotGST / 2;
                    //     SGSTAmt := TotGST / 2;

                    //     if "Sales Invoice Line"."Quantity (Base)" * "Sales Invoice Line"."Unit Price Base UOM 2" <> 0 then begin
                    //         NewUnitPrice_gDec := 0;
                    //         // NewUnitPrice_gDec := (("Sales Invoice Line"."Quantity (Base)" * "Sales Invoice Line"."Unit Price Base UOM 2") + TaxableAmountDiff_gDec) / "Sales Invoice Line"."Quantity (Base)";
                    //         NewUnitPrice_gDec := (("Sales Invoice Line"."Quantity (Base)" * "Sales Invoice Line"."Unit Price Base UOM 2")) / "Sales Invoice Line"."Quantity (Base)";
                    //     end else begin
                    //         NewUnitPrice_gDec := 0;
                    //         // NewUnitPrice_gDec := ("Sales Invoice Line".Amount + FindAmountDiff_lFnc) / "Sales Invoice Line"."Quantity (Base)";
                    //         NewUnitPrice_gDec := ("Sales Invoice Line".Amount) / "Sales Invoice Line"."Quantity (Base)";
                    //     end;
                    // end;
                    SUMAmount += TotalValue;

                    CheckReportNew.InitTextVariable();
                    //CheckReportNew.FormatNoText(Notext, GrandTotal, '');
                    // CheckReportNew.FormatNoText(Notext, round(GrandTotal, 0.01), "Sales Invoice Header"."Currency Code");
                    CheckReportNew.FormatNoText(Notext, round(SUMAmount, 0.01), "Sales Invoice Header"."Currency Code");

                    // AMountInW := DelChr(Notext[1], '<>', '*') + Notext[2];
                    // AMountInW := CopyStr(String1, 2, StrLen(String1));

                    // AMountInW := CopyStr(Notext[1], 1, StrPos(Notext[1], '/100') - 1) + ' PAISA ONLY';
                    AMountInW := Notext[1];

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
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = Where("Document Type" = filter(Invoice));
                column(Remark_Document_Type; "Document Type") { }
                column(Remark_Document_No_; "Document No.") { }
                column(Remark_Document_Line_No_; "Document Line No.") { }
                column(Remark_Line_No_; "Line No.") { }
                column(Remark_Comments; Comments) { }
                column(SrNo6; SrNo6) { }

                trigger OnAfterGetRecord()
                var
                begin
                    // SNo2 += 1;
                    SrNo6 += 1;
                    //  Message('%1', Comments);
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
                column(SrNo7; SrNo7) { }
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
                SalesInvoiceLine_LRec: Record "Sales Invoice Line";
                BankAcc_lRec: Record "Bank Account";
                SwiftCode_lRec: Record "SWIFT Code";
                // Check_LRep: Report Check;
                // Check_LRepGST: Report Check;
                Check_LRep: Report "Reciept Voucher VML";
                Check_LRepGST: Report "Reciept Voucher VML";
                VatRegNo_Lctxt: Label 'VAT Registration No. %1';
                CustomerRec: Record Customer;
                PmtTrmRec: Record "Payment Terms";
                SalesShipLine: Record "Sales Shipment Line";
                SalesShipHdr: Record "Sales Shipment Header";
                Comment_Lrec: Record "Sales Comment Line";
                TranSpec_rec: Record "Transaction Specification";
                Area_Rec: Record "Area";
                SalesInvoiceLine_L: Record "Sales Invoice Line";
                CountryRegionL: Record "Country/Region";
                ShipToAdd: Record "Ship-to Address";
                I: Integer;
                ShipmentHeaderRec2: Record "Sales Shipment Header";
                ShipmentSerialNo: array[20] of Integer;
                ShipmentNo: Text[20];
                ShipmentS: Integer;
                Instr: InStream;//07-07-2022
                TypeHelper: Codeunit "Type Helper";//07-07-2022

                SalesShiptoOption: Enum "Sales Ship-to Options";
                SalesBillToOption: Enum "Sales Bill-to Options";
                SalesHeader_lTemp: Record "Sales Invoice Header";
            begin
                //PM
                if "Bill-to Customer No." = "Sell-to Customer No." then
                    ShiptoVar := true
                else
                    ShiptoVar := false;

                //T52416-NS
                if MergeChargeItem_gBln then
                    if CheckGSTPercentage_lFnc then
                        Error('You can not merge lines as TAX % are not same in all line');
                //T52416-NE

                if CustRecSell.get("Sell-to Customer No.") then;
                if CustRecbill.get("Sell-to Customer No.") then;

                //07-07-2022-start
                Clear(QRCode);
                Clear(Instr);
                //Commented Niharika -OS
                "Sales Invoice Header".CalcFields("QR Code"); //09-01-2025
                // "E-Invoice QR Code".CreateInStream(Instr);
                //Commented Niharika -OE
                // TypeHelper.TryReadAsTextWithSeparator(Instr, TypeHelper.LFSeparator(), QRCode);
                // if StrLen(QrCode) > 4 then
                //     QRCode := CopyStr(QRCode, 2, StrLen(QrCode) - 2);
                //07-07-2022-end

                //-
                HideRemarks := false;
                SOremarks.Reset();
                SOremarks.SetRange("Document Type", SOremarks."Document Type"::Invoice);
                SOremarks.SetRange("Document No.", "Sales Invoice Header"."No.");
                if SOremarks.FindSet() then
                    HideRemarks := true;
                //+

                StateRec.Reset();
                StateRec.SetRange(Code, CustRecBill."State Code");
                if StateRec.FindFirst() then
                    CustomeSatedesc := StateRec.Description;
                if "Currency Code" = '' then
                    CurrencyCOde := 'INR'
                else
                    CurrencyCOde := "Currency Code";

                BankAcc_lRec.Reset();
                BankAcc_lRec.SETRANGE("Print in Sales Document", true);
                if BankAcc_lRec.FindFirst() then begin
                    // if BankAcc_lRec."Print in Sales Document" then begin
                    // repeat
                    SwiftCode_gTxt := '';
                    If SwiftCode_lRec.Get(BankAcc_lRec."SWIFT Code") then
                        SwiftCode_gTxt := SwiftCode_lRec.Name;
                    if BankAcc_lRec."Print in Sales Document" then
                        if BankName_gTxt = '' then
                            BankName_gTxt := 'Bank Name : ' + BankAcc_lRec.Name + '<br/>Account No.: ' + BankAcc_lRec."Bank Account No."
                            + '<br/>IFSC Code : ' + BankAcc_lRec."IFSC Code" + '<br/>Branch Name : ' + BankAcc_lRec."Bank Branch No." + '<br/>Swift Code : ' + BankAcc_lRec."SWIFT Code"
                        else
                            BankName_gTxt += '<br/><br/>Bank Name : ' + BankAcc_lRec.Name + '<br/>Account No.: ' + BankAcc_lRec."Bank Account No."
                                + '<br/>IFSC Code : ' + BankAcc_lRec."IFSC Code" + '<br/>Branch Name : ' + BankAcc_lRec."Bank Branch No." + '<br/>Swift Code : ' + BankAcc_lRec."SWIFT Code";
                    // until BankAcc_lRec.Next() = 0;
                    // end else if BankAcc_lRec.get("Bank on Invoice 2") then begin
                    //     BankName_gTxt := '<b>Bank Details : </b><br/>Bank Name : ' + BankAcc_lRec.Name + '<br/>Account No.: ' + BankAcc_lRec."Bank Account No."
                    //                                    + '<br/>IFSC Code : ' + BankAcc_lRec."Transit No." + '<br/>Branch Name : ' + BankAcc_lRec."Bank Branch No." + '<br/>Swift Code : ' + SwiftCode_gTxt
                end else begin
                    // if not BankAcc_lRec."Print in Sales Document" then begin
                    Bankaccount.Reset();
                    if Bankaccount.get("Bank on Invoice 2") then begin
                        BankName_gTxt := 'Bank Name : ' + Bankaccount.Name + '<br/>Account No.: ' + Bankaccount."Bank Account No."
                                               + '<br/>IFSC Code : ' + Bankaccount."IFSC Code" + '<br/>Branch Name : ' + Bankaccount."Bank Branch No." + '<br/>Swift Code : ' + BankAcc_lRec."SWIFT Code"
                    end;
                    // end;
                end;
                // end;

                if "Invoice Type" = "Invoice Type"::Export then
                    Name := 'Export'
                else
                    Name := 'Tax Invoice';
                if OriginalCopy = true then
                    O := 'ORIGINAL';
                if DuplicateCopy = true then
                    D := 'DUPLICATE';
                if TriplicateCopy = true then
                    D := 'TRIPLICATE';


                if CustomerRecBill.get("Sell-to Customer No.") then;

                //Commented Niharika -OS
                if Billing = true then begin
                    Billname := "Bill-to Name";
                    Billadress1 := "Bill-to Address";
                    billadres2 := "Bill-to Address 2";
                    billcity := "Bill-to City";
                    Billteliphone := "Bill-to Post Code";

                end
                else begin
                    Billname := CustomerRecBill.Name;
                    Billadress1 := CustomerRecBill.Address;
                    billadres2 := CustomerRecBill."Address 2";
                    billcity := CustomerRecBill.City;
                    Billteliphone := CustomerRecBill."Post Code";
                end;


                //04-04-2025 Dhiren-Alok
                CalculateShipBillToOptions(SalesShiptoOption, SalesBillToOption, SalesHeader_lTemp);

                CustAddrShipto_Arr[1] := 'Same as Bill To';

                if SalesShiptoOption = SalesShiptoOption::"Default (Sell-to Address)" then begin
                    ShippName := "Ship-to Name";
                    ShippAdress1 := "Ship-to Address";
                    ShippAddress2 := "Ship-to Address 2";
                    ShippCity := "Ship-to City";
                    ShippPostcode := "Ship-to Post Code";
                    ShipCaption := 'Ship To';
                end
                else begin
                    ShippName := "Bill-to Name";
                    ShippAdress1 := "Bill-to Address";
                    ShippAddress2 := "Bill-to Address 2";
                    ShippCity := "Bill-to City";
                    ShippPostcode := "Bill-to Post Code";
                    ShipCaption := 'Ship To';
                end;
                //04-04-2025 Dhiren-Alok
                //Commented Niharika -OE

                if Billteliphone = '' then
                    Postcodecaption := ''
                else
                    Postcodecaption := 'Post Code: ';







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
                IF AreaRec.Get("Sales Invoice Header"."Area") then
                    AreaDesc := AreaRec.Text;

                if PrintCustomerAltAdd then begin
                    Clear(AreaDesc);
                    IF AreaRec.Get("Sales Invoice Header"."Customer Port of Discharge") then
                        AreaDesc := AreaRec.Text;
                end;
                IF Area_Rec.Get("Area") And (Area_Rec.Text <> '') then
                    TranSec_Desc := TranSec_Desc + ', ' + AreaDesc;

                //PartialShipment
                if "Sales Invoice Header"."Shipment Term" = "Sales Invoice Header"."Shipment Term"::"Partial Shipment" then begin
                    Clear(I);
                    SalesInvoicelineRec.Reset();
                    SalesInvoicelineRec.SetRange("Document No.", "Sales Invoice Header"."No.");
                    SalesInvoicelineRec.SetFilter("No.", '<>%1', '');
                    if SalesInvoicelineRec.FindSet() then begin
                        I := SalesInvoicelineRec.Count;
                        if I = 1 then begin
                            ShipmentHeaderRec.Reset();
                            if ShipmentHeaderRec.Get(SalesInvoicelineRec."Shipment No.") then
                                ShipmentS := ShipmentHeaderRec."Shipment Count"
                            else
                                ShipmentS := "Sales Invoice Header"."Shipment Count";
                        end
                        else
                            ShipmentS := "Sales Invoice Header"."Shipment Count";
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
                    if "Sales Invoice Header"."Shipment Term" = "Sales Invoice Header"."Shipment Term"::"One Shipment" then
                        ShipmentNo := Format("Sales Invoice Header"."Shipment Term");
                if ShipmentNo <> '' then
                    TranSec_Desc := TranSec_Desc + ', ' + ShipmentNo;

                //PartialShipment

                /*
                CustAddr_Arr[1] := "Sell-to Customer Name";
                CustAddr_Arr[2] := StrSubstNo(VatRegNo_Lctxt, "VAT Registration No.");
                CustAddr_Arr[3] := "Sell-to Address" + ', ' + "Sell-to Address 2";
                CustAddr_Arr[4] := "Sell-to City";*/

                Clear(CustAddrShipto_Arr);
                // SKM if "Ship-to Code" <> '' THEN begin
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
                //END;
                //AW-06032020>>
                if PrintCustomerAltAdd = true then begin
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
                end;

                //InsurancPolicy 04132020
                if TransactionSpecificationRec.Get("Sales Invoice Header"."Transaction Specification") then begin
                    if TransactionSpecificationRec."Insurance By" = TransactionSpecificationRec."Insurance By"::Seller then begin
                        InsurancePolicy := 'Insurance Policy: ' + "Sales Invoice Header"."Insurance Policy No." + ' Provided by ' + Format(TransactionSpecificationRec."Insurance By");
                    end
                    else
                        if TransactionSpecificationRec."Insurance By" = TransactionSpecificationRec."Insurance By"::Buyer then begin
                            InsurancePolicy := 'Insurance Policy: ' + "Sales Invoice Header"."Insurance Policy No." + ' Provided by ' + Format(TransactionSpecificationRec."Insurance By");
                        end;
                end;
                //InsurancPolicy 04132020

                TotalAmt := 0;
                TotalVatAmtAED := 0;
                TotalAmountAED := 0;
                PartialShip := '';
                CustTRN := '';
                CustGSTNo := '';

                QuoteNo := '';
                Quotedate := 0D;
                SalesInvoiceLine_LRec.Reset;
                SalesInvoiceLine_LRec.SetRange("Document No.", "No.");
                if PostedDoNotShowGL then
                    SalesInvoiceLine_LRec.SetFilter(Type, '<>%1', SalesInvoiceLine_LRec.Type::"G/L Account");
                if SalesInvoiceLine_LRec.FindSet(false) then
                    repeat
                        // if PostedCustomInvoiceG then begin
                        //     TotalAmt += Round((salesInvoiceLine_LRec."Quantity (Base)" * salesInvoiceLine_LRec."Customer Requested Unit Price") + ((salesInvoiceLine_LRec."Quantity (Base)" * salesInvoiceLine_LRec."Customer Requested Unit Price") * SalesInvoiceLine_LRec."VAT %" / 100), 0.01, '=');
                        //     TotalVatAmtAED += Round((salesInvoiceLine_LRec."Quantity (Base)" * salesInvoiceLine_LRec."Customer Requested Unit Price") * SalesInvoiceLine_LRec."VAT %" / 100, 0.01, '=');
                        //     AmtExcVATLCY += Round(SalesInvoiceLine_LRec."Quantity (Base)" * SalesInvoiceLine_LRec."Customer Requested Unit Price", 0.01, '=');
                        // end
                        // else begin
                        TotalAmt += SalesInvoiceLine_LRec."Amount Including VAT";
                        TotalVatAmtAED += SalesInvoiceLine_LRec."VAT Base Amount" * SalesInvoiceLine_LRec."VAT %" / 100;
                        AmtExcVATLCY += SalesInvoiceLine_LRec.Quantity * SalesInvoiceLine_LRec."Unit Price";
                    // end;
                    until SalesInvoiceLine_LRec.Next = 0;
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
                if CustomerRec.Get("Sell-to Customer No.") And (CustomerRec."seller Bank Detail" = false) then begin
                    HideBank_Detail := false;
                    SalesInvoiceLine_LRec.Reset;
                    SalesInvoiceLine_LRec.SetCurrentKey("Document No.", "Line No.");
                    SalesInvoiceLine_LRec.SetRange("Document No.", "Sales Invoice Header"."No.");
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
                end;
                //until SalesInvoiceLine_LRec.Next = 0;

                Location_gRec.Reset();
                if Location_gRec.Get("Sales Invoice Header"."Location Code") then begin
                    if Location_gRec.Name <> '' then
                        Locationadd_gTxt += '<b>' + Location_gRec.Name + '</b>';
                    if Location_gRec."Name 2" <> '' then
                        Locationadd_gTxt += '<br/>' + Location_gRec."Name 2";
                    if Location_gRec.Address <> '' then
                        Locationadd_gTxt += '<br/>' + Location_gRec.Address;
                    if Location_gRec."Address 2" <> '' then
                        Locationadd_gTxt += '<br/>' + Location_gRec."Address 2";
                    if Location_gRec.City <> '' then
                        Locationadd_gTxt += '<br/>' + Location_gRec.City + '<br/>' + 'Post Code: ' + Location_gRec."Post Code";
                    // if Location_gRec."Country/Region Code" <> '' then
                    //     Locationadd_gTxt += '<br/>' + Location_gRec.County + ' ' + Location_gRec."Country/Region Code";
                    if Location_gRec."GST Registration No." <> '' then
                        Locationadd_gTxt += '<br/>' + 'GST No. - ' + Location_gRec."GST Registration No.";

                end;

                TotalIncludingCaption := '';
                ExchangeRate := '';
                TotalAmountAED := TotalAmt;
                If "Currency Factor" <> 0 then begin
                    TotalIncludingCaption := StrSubstNo('Total Including VAT %1', "Currency Code");
                    ExchangeRate := StrSubstNo('%1', 1 / "Currency Factor");
                    TotalVatAmtAED := TotalVatAmtAED / "Currency Factor";
                    TotalAmountAED := TotalAmt / "Currency Factor";
                    AmtIncVATLCY := AmtExcVATLCY / "Currency Factor";
                End Else
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
                Check_LRep.FormatNoText(AmtinWord_GTxt, TotalAmt, "Sales Invoice Header"."Currency Code");
                String := DelChr(AmtinWord_GTxt[1], '<>', '*') + AmtinWord_GTxt[2];
                String := CopyStr(String, 2, StrLen(String));


                /// SKM 
                Clear(AmtinWord_GTxtGST);
                Clear(Check_LRepGST);
                Check_LRepGST.InitTextVariable();
                Check_LRepGST.FormatNoText(AmtinWord_GTxtGST, TotalAmt + CGSTAmt + SGSTAmt + IGSTAmt, "Sales Invoice Header"."Currency Code");

                String1 := DelChr(AmtinWord_GTxtGST[1], '<>', '*') + AmtinWord_GTxtGST[2];
                String1 := CopyStr(String1, 2, StrLen(String1));
                //pkm
                //String1 := CopyStr(AmtinWord_GTxtGST[1], 2, StrPos(AmtinWord_GTxtGST[1], '/100') - 1) + ' PAISA ONLY';


                //.


                Clear(Check_LRep);
                SrNo := 0;
                CustomerRec.Reset();
                IF CustomerRec.get("Sell-to Customer No.") then begin
                    PartialShip := Format(CustomerRec."Shipping Advice");
                    if CustomerRec."VAT Registration No." <> '' then
                        if "Tax Type" <> '' then
                            CustTRN := CustomerRec."Tax Type" + ': ' + CustomerRec."VAT Registration No."
                        else
                            CustTRN := 'TRN: ' + CustomerRec."VAT Registration No.";
                    CustGSTNo := CustomerRec."GST Registration No.";
                end;
                //AW12032020>>
                if PrintCustomerAltAdd = true then begin
                    if CustomerAltAdd.Get("Sell-to Customer No.") then
                        if CustomerAltAdd."Customer TRN" <> '' then
                            CustTRN := 'TRN: ' + CustomerAltAdd."Customer TRN"
                        else
                            CustTRN := '';

                end;
                //AW12032020<<
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

                // PortOfLoding := "Sales Invoice Header".CountryOfLoading;
                // if PostedCustomInvoiceG then begin
                //     clear(PortOfLoding);
                //     PortOfLoding := "Sales Invoice Header"."Customer Port of Discharge";
                // end;

                ExitPt.Reset();
                IF ExitPt.Get("Sales Invoice Header"."Exit Point") then
                    ExitPtDesc := ExitPt.Description;

                // IF PostedShowCommercial then
                // RepHdrtext := 'Commercial Invoice'
                // else
                RepHdrtext := 'Tax Invoice';

                IF "Seller/Buyer 2" then
                    Inspection_Caption := 'Inspection will be provided by nominated third party at the Buyer’s cost'
                Else
                    Inspection_Caption := 'Inspection will be provided by nominated third party at the Seller’s cost';

                SerialNo := 2;

                IF "Sales Invoice Header"."Inspection Required 2" = true then begin //PackingListExtChange
                    SerialNo += 1;
                    SrNo3 := SerialNo;
                end;
                IF "Sales Invoice Header"."Legalization Required 2" = true then begin //PackingListExtChange
                    SerialNo += 1;
                    SrNo4 := SerialNo;
                end;

                if "Sales Invoice Header"."Duty Exemption" = true then begin
                    SerialNo += 1;
                    SrNo5 := SerialNo;
                end;

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
                    field("Merge Charge(Item)"; MergeChargeItem_gBln)
                    {
                        ApplicationArea = All;
                    }
                    // field("Legalization Required"; LegalizationRequired)
                    // {
                    //     ApplicationArea = All;
                    // }
                    // field("Inspection Required"; InspectionRequired)
                    // {
                    //     ApplicationArea = All;
                    // }
                    // field("Print Commercial Invoice"; PostedShowCommercial)
                    // {
                    //     ApplicationArea = ALL;
                    // }
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
                    field(ShowCustomerCOO; ShowCustomerCOO)
                    {
                        ApplicationArea = all;
                        Caption = 'Show Customer COO';
                    }

                    field(OriginalCopy; OriginalCopy)
                    {
                        ApplicationArea = all;

                    }
                    field(DuplicateCopy; DuplicateCopy)
                    {
                        ApplicationArea = all;

                    }
                    field(TriplicateCopy; TriplicateCopy)
                    {
                        ApplicationArea = all;

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
        Lbl1 = 'General Sales conditions are provided on the second page of this Commercial Invoice.';
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
        Remark_lbl = 'Remark';
        AlternateAddressCap = 'Customer Alternate Address';

        //GK
        GeneralTermsandConditionsofSale_lbl = 'General Terms and Conditions of Sale';
        ScopeofApplication_lbl = 'Scope of Application';
        OfferandAcceptance_lbl = 'Offer and Acceptance';
        Productquality_lbl = 'Product quality, specimens, samples and guarantees';
        Advice_lbl = 'Advice';
        Prices_lab = 'Prices';
        Delivery_lbl = 'Delivery';
        DamagesinTransit_lbl = 'Damages in transit';
        Compiance_lbl = 'Compliance with legal requirements';
        Delay_lbl = 'Delay in Payment';
        BuyerRight_lbl = 'Buyer’s rights regarding defective goods';
        ForceMajeure_lbl = 'Force Majeure';
    }

    trigger OnPreReport()
    var
    //Bank_LRec: Record "Bank Account";

    begin
        SUMAmount := 0;
        CompanyInformation.Get;
        CompanyInformation.CalcFields(Picture);
        // UK::04062020>>
        spacePosition := StrPos(CompanyInformation.Name, ' ');
        CompanyFirstWord := CopyStr(CompanyInformation.Name, 1, spacePosition - 1);

        Text1 := StrSubstNo(Condition1, CompanyInformation.Name, CompanyFirstWord);

        Text12 := StrSubstNo(Condition12, CompanyInformation.Name, CompanyInformation."Registered in", CompanyInformation."License No.", CompanyInformation."Registration No.");
        Text21 := StrSubstNo(Condition2, CompanyFirstWord);
        Text22 := StrSubstNo(Condition31, CompanyFirstWord);
        Text23 := StrSubstNo(Condition4, CompanyFirstWord);
        Text24 := StrSubstNo(Condition5, CompanyFirstWord);
        Text25 := StrSubstNo(Condition7, CompanyFirstWord);
        Text26 := StrSubstNo(Condition92, CompanyFirstWord);
        Text27 := StrSubstNo(Condition1011, CompanyFirstWord);
        Text28 := StrSubstNo(Condition1012, CompanyFirstWord);
        Text29 := StrSubstNo(Condition1021, CompanyFirstWord);
        Text30 := StrSubstNo(Condition1021a, CompanyFirstWord);
        Text31 := StrSubstNo(Condition1021b, CompanyFirstWord);
        Text32 := StrSubstNo(Condition1041, CompanyFirstWord);
        Text33 := StrSubstNo(Condition11, CompanyFirstWord);

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

    // local procedure FindLineAmountDiff_lFnc(): Decimal
    // var
    //     SIL_lRec: Record "Sales Invoice Line";
    //     TotalFreight_lDec: Decimal;
    //     TotalItemAmount_lDec: Decimal;
    //     AmountDiff_lDec: Decimal;
    // begin
    //     TotalFreight_lDec := 0;
    //     TotalItemAmount_lDec := 0;
    //     AmountDiff_lDec := 0;

    //     SIL_lRec.Reset();
    //     SIL_lRec.SetRange("Document No.", "Sales Invoice Header"."No.");
    //     SIL_lRec.SetRange(Type, SIL_lRec.Type::"Charge (Item)");
    //     if SIL_lRec.FindSet() then begin
    //         repeat
    //             TotalFreight_lDec += SIL_lRec."Quantity (Base)" * SIL_lRec."Unit Price Base UOM 2";
    //         until SIL_lRec.Next() = 0;
    //     end;

    //     SIL_lRec.Reset();
    //     SIL_lRec.SetRange("Document No.", "Sales Invoice Header"."No.");
    //     SIL_lRec.SetRange(Type, SIL_lRec.Type::Item);
    //     if SIL_lRec.FindSet() then begin
    //         repeat
    //             TotalItemAmount_lDec += SIL_lRec."Quantity (Base)" * SIL_lRec."Unit Price Base UOM 2";
    //         until SIL_lRec.Next() = 0;
    //     end;

    //     if TotalItemAmount_lDec <> 0 then
    //         AmountDiff_lDec := Round((TotalFreight_lDec * "Sales Invoice Line"."Quantity (Base)" * "Sales Invoice Line"."Unit Price Base UOM 2") / TotalItemAmount_lDec, 0.01, '=');

    //     exit(AmountDiff_lDec);
    // end;

    // T52416-OS

    // local procedure FindAmountDiff_lFnc(): Decimal
    // var
    //     SIL_lRec: Record "Sales Invoice Line";
    //     TotalFreight_lDec: Decimal;
    //     TotalItemAmount_lDec: Decimal;
    //     AmountDiff_lDec: Decimal;
    // begin
    //     TotalFreight_lDec := 0;
    //     TotalItemAmount_lDec := 0;
    //     AmountDiff_lDec := 0;

    //     SIL_lRec.Reset();
    //     SIL_lRec.SetRange("Document No.", "Sales Invoice Header"."No.");
    //     SIL_lRec.SetRange(Type, SIL_lRec.Type::"Charge (Item)");
    //     if SIL_lRec.FindSet() then begin
    //         repeat
    //             TotalFreight_lDec += SIL_lRec.Amount;
    //         until SIL_lRec.Next() = 0;
    //     end;

    //     SIL_lRec.Reset();
    //     SIL_lRec.SetRange("Document No.", "Sales Invoice Header"."No.");
    //     SIL_lRec.SetRange(Type, SIL_lRec.Type::Item);
    //     if SIL_lRec.FindSet() then begin
    //         repeat
    //             TotalItemAmount_lDec += SIL_lRec.Amount;
    //         until SIL_lRec.Next() = 0;
    //     end;

    //     if TotalItemAmount_lDec <> 0 then
    //         AmountDiff_lDec := Round((TotalFreight_lDec * "Sales Invoice Line".Amount) / TotalItemAmount_lDec, 0.01, '=');

    //     exit(AmountDiff_lDec);
    // end;
    // T52416-OE
    // local procedure FindGSTDifference_lFnc(): Decimal
    // var
    //     SL_lRec: Record "Sales Invoice Line";
    //     TotalofFreight_lDec: Decimal;
    //     TotalofItem_lDec: Decimal;
    //     GSTAmountDiff_lDec: Decimal;
    //     CurrLineGST_lDec: Decimal;
    // begin
    //     TotalofFreight_lDec := 0;
    //     TotalofItem_lDec := 0;
    //     GSTAmountDiff_lDec := 0;
    //     CurrLineGST_lDec := 0;

    //     SL_lRec.Reset();
    //     SL_lRec.SetRange("Document No.", "Sales Invoice Header"."No.");
    //     SL_lRec.SetRange(Type, SL_lRec.Type::"Charge (Item)");
    //     if SL_lRec.FindSet() then begin
    //         repeat
    //             Clear(IGSTAmt);
    //             Clear(CGSTAmt);
    //             Clear(SGSTAmt);
    //             STPer := 0;
    //             CTPer := 0;
    //             ITPer := 0;
    //             STPer := 0;
    //             CTPer := 0;
    //             ITPer := 0;
    //             if SL_lRec."GST Group Code" <> '' then
    //                 CalculateLineGST("Sales Invoice Header", SL_lRec);
    //             TotalofFreight_lDec += IGSTAmt + CGSTAmt + SGSTAmt;
    //         until SL_lRec.Next() = 0;
    //     end;

    //     SL_lRec.Reset();
    //     SL_lRec.SetRange("Document No.", "Sales Invoice Header"."No.");
    //     SL_lRec.SetRange(Type, SL_lRec.Type::Item);
    //     if SL_lRec.FindSet() then begin
    //         repeat
    //             Clear(IGSTAmt);
    //             Clear(CGSTAmt);
    //             Clear(SGSTAmt);
    //             STPer := 0;
    //             CTPer := 0;
    //             ITPer := 0;
    //             STPer := 0;
    //             CTPer := 0;
    //             ITPer := 0;
    //             if SL_lRec."GST Group Code" <> '' then
    //                 CalculateLineGST("Sales Invoice Header", SL_lRec);
    //             TotalofItem_lDec += IGSTAmt + CGSTAmt + SGSTAmt;
    //         until SL_lRec.Next() = 0;
    //     end;

    //     if "Sales Invoice Line"."GST Group Code" <> '' then
    //         CalculateLineGST("Sales Invoice Header", "Sales Invoice Line");
    //     CurrLineGST_lDec := IGSTAmt + CGSTAmt + SGSTAmt;

    //     if TotalofItem_lDec <> 0 then
    //         GSTAmountDiff_lDec := Round((TotalofFreight_lDec * CurrLineGST_lDec) / TotalofItem_lDec, 0.01, '=');

    //     exit(GSTAmountDiff_lDec);
    // end;

    // local procedure FindGSTDifference_lFnc(): Decimal
    // var
    //     SL_lRec: Record "Sales Invoice Line";
    //     TotalofFreight_lDec: Decimal;
    //     TotalofItem_lDec: Decimal;
    //     GSTAmountDiff_lDec: Decimal;
    //     CurrLineGST_lDec: Decimal;
    // begin
    //     TotalofFreight_lDec := 0;
    //     TotalofItem_lDec := 0;
    //     GSTAmountDiff_lDec := 0;
    //     CurrLineGST_lDec := 0;

    //     SL_lRec.Reset();
    //     SL_lRec.SetRange("Document No.", "Sales Invoice Header"."No.");
    //     SL_lRec.SetRange(Type, SL_lRec.Type::"Charge (Item)");
    //     if SL_lRec.FindSet() then begin
    //         repeat
    //             Clear(IGSTAmt);
    //             // Clear(GST);
    //             Clear(CGSTAmt);
    //             Clear(SGSTAmt);
    //             STPer := 0;
    //             CTPer := 0;
    //             ITPer := 0;
    //             GSTledgerentry.Reset();
    //             GSTledgerentry.SetRange("Document Type", GSTledgerentry."Document Type"::Invoice);
    //             GSTledgerentry.SetRange("Transaction Type", GSTledgerentry."Transaction Type"::Sales);
    //             GSTledgerentry.SetRange("Document No.", SL_lRec."Document No.");
    //             //GSTledgerentry.SetRange("No.", "No.");
    //             GSTledgerentry.SetRange("Document Line No.", SL_lRec."Line No.");

    //             IF GSTledgerentry.FindSet() THEN
    //                 repeat

    //                     //  Message('%1', GSTledgerentry."GST Amount");
    //                     IF GSTledgerentry."GST Component Code" = 'SGST' THEN begin
    //                         STPer := GSTledgerentry."GST %";
    //                         SGSTAmt += ABS(GSTledgerentry."GST Amount");
    //                     end;

    //                     IF GSTledgerentry."GST Component Code" = 'CGST' THEN begin
    //                         CTPer := GSTledgerentry."GST %";
    //                         CGSTAmt += ABS(GSTledgerentry."GST Amount");
    //                     end;

    //                     IF GSTledgerentry."GST Component Code" = 'IGST' THEN begin
    //                         ITPer := GSTledgerentry."GST %";
    //                         iGSTAmt := ABS(GSTledgerentry."GST Amount");
    //                     end;

    //                 // if SL_lRec.Type = "Sales Invoice Line".Type::"G/L Account" then //added by bayas
    //                 //     if "Sales Invoice Line"."No." = '440220' then begin
    //                 //         SGSTAmt := -ABS(GSTledgerentry."GST Amount");
    //                 //         CGSTAmt := -ABS(GSTledgerentry."GST Amount");
    //                 //     end;

    //                 Until GSTledgerentry.Next() = 0;
    //             // Clear(IGSTAmt);
    //             // // Clear(GST);
    //             // Clear(CGSTAmt);
    //             // Clear(SGSTAmt);
    //             // STPer := 0;
    //             // CTPer := 0;
    //             // ITPer := 0;
    //             // if SL_lRec."GST Group Code" <> '' then
    //             //     CalculateLineGST("Sales Invoice Header", SL_lRec);
    //             TotalofFreight_lDec += IGSTAmt + CGSTAmt + SGSTAmt;
    //         until SL_lRec.Next() = 0;
    //     end;

    //     SL_lRec.Reset();
    //     SL_lRec.SetRange("Document No.", "Sales Invoice Header"."No.");
    //     SL_lRec.SetRange(Type, SL_lRec.Type::Item);
    //     if SL_lRec.FindSet() then begin
    //         repeat
    //             Clear(IGSTAmt);
    //             // Clear(GST);
    //             Clear(CGSTAmt);
    //             Clear(SGSTAmt);
    //             STPer := 0;
    //             CTPer := 0;
    //             ITPer := 0;
    //             GSTledgerentry.Reset();
    //             GSTledgerentry.SetRange("Document Type", GSTledgerentry."Document Type"::Invoice);
    //             GSTledgerentry.SetRange("Transaction Type", GSTledgerentry."Transaction Type"::Sales);
    //             GSTledgerentry.SetRange("Document No.", SL_lRec."Document No.");
    //             //GSTledgerentry.SetRange("No.", "No.");
    //             GSTledgerentry.SetRange("Document Line No.", SL_lRec."Line No.");

    //             IF GSTledgerentry.FindSet() THEN
    //                 repeat

    //                     //  Message('%1', GSTledgerentry."GST Amount");
    //                     IF GSTledgerentry."GST Component Code" = 'SGST' THEN begin
    //                         STPer := GSTledgerentry."GST %";
    //                         SGSTAmt += ABS(GSTledgerentry."GST Amount");
    //                     end;

    //                     IF GSTledgerentry."GST Component Code" = 'CGST' THEN begin
    //                         CTPer := GSTledgerentry."GST %";
    //                         CGSTAmt += ABS(GSTledgerentry."GST Amount");
    //                     end;

    //                     IF GSTledgerentry."GST Component Code" = 'IGST' THEN begin
    //                         ITPer := GSTledgerentry."GST %";
    //                         iGSTAmt := ABS(GSTledgerentry."GST Amount");
    //                     end;

    //                 // if "Sales Invoice Line".Type = "Sales Invoice Line".Type::"G/L Account" then //added by bayas
    //                 //     if "Sales Invoice Line"."No." = '440220' then begin
    //                 //         SGSTAmt := -ABS(GSTledgerentry."GST Amount");
    //                 //         CGSTAmt := -ABS(GSTledgerentry."GST Amount");
    //                 //     end;

    //                 Until GSTledgerentry.Next() = 0;
    //             // Clear(IGSTAmt);
    //             // // Clear(GST);
    //             // Clear(CGSTAmt);
    //             // Clear(SGSTAmt);
    //             // STPer := 0;
    //             // CTPer := 0;
    //             // ITPer := 0;
    //             // if SL_lRec."GST Group Code" <> '' then
    //             //     CalculateLineGST("Sales Invoice Header", SL_lRec);
    //             TotalofItem_lDec += IGSTAmt + CGSTAmt + SGSTAmt;
    //         until SL_lRec.Next() = 0;
    //     end;

    //     // if SL_lRec."GST Group Code" <> '' then
    //     //     CalculateLineGST("Sales Invoice Header", SL_lRec);
    //     Clear(IGSTAmt);
    //     // Clear(GST);
    //     Clear(CGSTAmt);
    //     Clear(SGSTAmt);
    //     GSTledgerentry.Reset();
    //     GSTledgerentry.SetRange("Document Type", GSTledgerentry."Document Type"::Invoice);
    //     GSTledgerentry.SetRange("Transaction Type", GSTledgerentry."Transaction Type"::Sales);
    //     GSTledgerentry.SetRange("Document No.", "Sales Invoice Line"."Document No.");
    //     //GSTledgerentry.SetRange("No.", "No.");
    //     GSTledgerentry.SetRange("Document Line No.", "Sales Invoice Line"."Line No.");

    //     IF GSTledgerentry.FindSet() THEN
    //         repeat

    //             //  Message('%1', GSTledgerentry."GST Amount");
    //             IF GSTledgerentry."GST Component Code" = 'SGST' THEN begin
    //                 STPer := GSTledgerentry."GST %";
    //                 SGSTAmt += ABS(GSTledgerentry."GST Amount");
    //             end;

    //             IF GSTledgerentry."GST Component Code" = 'CGST' THEN begin
    //                 CTPer := GSTledgerentry."GST %";
    //                 CGSTAmt += ABS(GSTledgerentry."GST Amount");
    //             end;

    //             IF GSTledgerentry."GST Component Code" = 'IGST' THEN begin
    //                 ITPer := GSTledgerentry."GST %";
    //                 iGSTAmt := ABS(GSTledgerentry."GST Amount");
    //             end;

    //         Until GSTledgerentry.Next() = 0;

    //     CurrLineGST_lDec := IGSTAmt + CGSTAmt + SGSTAmt;

    //     if TotalofItem_lDec <> 0 then
    //         GSTAmountDiff_lDec := Round((TotalofFreight_lDec * CurrLineGST_lDec) / TotalofItem_lDec, 0.01, '=');

    //     exit(GSTAmountDiff_lDec);
    // end;

    local procedure CheckGSTPercentage_lFnc(): Boolean
    var
        SL_lRec: Record "Sales Invoice Line";
        TempGSTPer_lDec: Decimal;
        GSTPer_lDec: Decimal;
        ItemGST_lBln: Boolean;
    begin
        SL_lRec.Reset();
        SL_lRec.SetRange("Document No.", "Sales Invoice Header"."No.");
        SL_lRec.SetFilter(Type, '<> %1', SL_lRec.Type::" ");
        if SL_lRec.FindSet() then begin
            repeat
                Clear(IGSTAmt);
                // Clear(GST);
                Clear(CGSTAmt);
                Clear(SGSTAmt);
                STPer := 0;
                CTPer := 0;
                ITPer := 0;
                STPer := 0;
                CTPer := 0;
                ITPer := 0;
                GSTPer_lDec := 0;
                if SL_lRec."GST Group Code" <> '' then
                    CalculateLineGST("Sales Invoice Header", SL_lRec);
                GSTPer_lDec := CTPer + STPer + ITPer;

                if TempGSTPer_lDec <> 0 then begin
                    if TempGSTPer_lDec <> GSTPer_lDec then
                        ItemGST_lBln := true;
                    // else
                    //     ItemVAT_lBln := false;
                end;

                if SL_lRec."GST Group Code" <> '' then
                    CalculateLineGST("Sales Invoice Header", SL_lRec);
                TempGSTPer_lDec := CTPer + STPer + ITPer;
            until SL_lRec.Next() = 0;
        end;

        if ItemGST_lBln then
            exit(true)
        else
            exit(false);
    end;

    local procedure CalculateLineGST(recSalesHdr: Record "Sales Invoice Header"; recSaleLine: Record "Sales Invoice Line")
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

        GetLineGSTAmount(recSaleLine, ConfigID, intIGST, intCGST, intSGST);
    End;

    local procedure GetLineGSTAmount(gSalesLine: Record "Sales Invoice Line"; FilterID: Text; IGSTID: Integer; CGSTID: Integer; SGSTID: Integer)
    var
        lSalesLine: Record "Sales Invoice Line";
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
        decTotTaxAmt: Decimal;
    begin
        lSalesLine.Get(gSalesLine."Document No.", gSalesLine."Line No.");
        decTotTaxAmt := 0;
        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", lSalesLine.RecordId);
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
                            // IGST := Format(TaxTransactionValue.Percent) + '%';
                            ITPer := TaxTransactionValue.Percent;
                            IGSTAmt := TaxTransactionValue.Amount;
                        end;
                    CGSTID:
                        begin
                            // CGST := Format(TaxTransactionValue.Percent) + '%';
                            CTPer := TaxTransactionValue.Percent;
                            CGSTAmt := TaxTransactionValue.Amount;
                        end;
                    SGSTID:
                        begin
                            // SGST := Format(TaxTransactionValue.Percent) + '%';
                            STPer := TaxTransactionValue.Percent;
                            SGSTAmt := TaxTransactionValue.Amount;
                        end;
                end;
                decTotTaxAmt += TaxTransactionValue.Amount;
            until TaxTransactionValue.Next() = 0;
    end;

    local procedure CalculateLineGST(recSalesHdr: Record "Sales Header"; recSaleLine: Record "Sales Line")
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

        GetLineGSTAmount(recSaleLine, ConfigID, intIGST, intCGST, intSGST);
    End;

    local procedure GetLineGSTAmount(gSalesLine: Record "Sales Line"; FilterID: Text; IGSTID: Integer; CGSTID: Integer; SGSTID: Integer)
    var
        lSalesLine: Record "Sales Line";
        TaxTransactionValue: Record "Tax Transaction Value";
        GSTSetup: Record "GST Setup";
        decTotTaxAmt: Decimal;
    begin
        lSalesLine.Get(gSalesLine."Document Type", gSalesLine."Document No.", gSalesLine."Line No.");
        decTotTaxAmt := 0;
        if not GSTSetup.Get() then
            exit;

        TaxTransactionValue.SetRange("Tax Record ID", lSalesLine.RecordId);
        TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
        if GSTSetup."Cess Tax Type" <> '' then
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type", GSTSetup."Cess Tax Type")
        else
            TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
        TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
        TaxTransactionValue.SetFilter("Value ID", FilterID);

        if TaxTransactionValue.FindSet() then
            repeat
                case TaxTransactionValue."Value ID" of
                    IGSTID:
                        begin
                            ITPer := TaxTransactionValue.Percent;
                            IGSTAmt := TaxTransactionValue.Amount;
                        end;
                    CGSTID:
                        begin
                            CTPer := TaxTransactionValue.Percent;
                            CGSTAmt := TaxTransactionValue.Amount;
                        end;
                    SGSTID:
                        begin
                            STPer := TaxTransactionValue.Percent;
                            SGSTAmt := TaxTransactionValue.Amount;
                        end;
                end;
                decTotTaxAmt += TaxTransactionValue.Amount;
            until TaxTransactionValue.Next() = 0;
    end;

    var
        ItemSumQty_gDec: Decimal;
        ChargeSumQty_gDec: Decimal;
        TotalFreight_gDec: Decimal;
        NewUnitPrice_gDec: Decimal;
        TaxableAmountDiff_gDec: Decimal;
        MergeChargeItem_gBln: Boolean;
        SUMAmount: Decimal;
        Cgst_gDec: Decimal;
        Sgst_gDec: Decimal;
        Amount_gDec: Decimal;
        OriginalCopy: Boolean;
        QrCode: Text;//07-07-2022
        O: text[50];
        D: text[50];
        T: text[50];
        ShippName: text[150];
        ShipCaption: text[50];

        ShippAdress1: text[150];
        ShippAddress2: text[150];
        ShippCity: Text[100];
        ShippPostcode: text[100];
        Billname: Text[250];
        Locationadd_gTxt: Text;
        Location_gRec: Record Location;
        Billadress1: Text[250];
        billadres2: Text[250];
        billcity: Text[100];
        Billteliphone: text[100];
        Postcodecaption: text[100];
        CustomerRecBill: Record Customer;

        SwiftCode_gTxt: Text;
        BankName_gTxt: Text;


        DuplicateCopy: Boolean;
        TriplicateCopy: Boolean;
        chekReport: Report Check;
        chekReport1: Report Check;
        //CheckReportNew: report Check;
        CheckReportNew: Report "Reciept Voucher VML";

        Notext: array[2] of Text[150];
        AMountInW: text[200];
        ShipmentHeaderRec: Record "Sales Shipment Header";
        SalesInvoicelineRec: Record "Sales Invoice Line";
        Customeunitprice: Decimal;
        SalesLineAmount: Decimal;
        SalesLineAmountincVat: Decimal;
        SalesLineVatBaseAmount: Decimal;
        CustomerAltAdd: Record "Customer Alternet Address";
        PrintCustomerAltAdd: Boolean;
        CustomerAltAddres: array[8] of Text[150];
        countryDesc: text;
        STPer: decimal;
        CTPer: decimal;
        ITPer: decimal;

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
        AmtinWord_GTxt: array[2] of Text[200];
        AmtinWord_GTxtGST: array[2] of Text[200];
        CustAddr_Arr: array[9] of Text[150];
        CustAddrShipto_Arr: array[8] of Text[150];
        FormatAddr: Codeunit "Format Address";
        TransactionSpecificationRec: Record 285;
        InsurancePolicy: text[100];
        SrNo: Integer;
        TotalAmt: Decimal;
        ExchangeRate: Text;
        String: Text[150];
        String1: Text[250];
        TotalAmountAED: Decimal;
        TotalValue: Decimal;
        TotalValue1: Decimal;
        VATAmount: Decimal;
        TotGST: Decimal;
        TotalVatAmtAED: Decimal;
        SearchDesc: Text[80];
        TotalIncludingCaption: Text[80];
        BankNo: Code[20];
        BankName: Text[50];
        BankAddress: Text[50];
        BankAddress2: Text[50];
        ShowCustomerCOO: Boolean;
        BankCity: Text[30];
        BankCountry: Code[20];
        IBANNumber: Text[50];
        SWIFTCode: Text[20];
        IsItem: Boolean;
        HSNCode: Code[20];
        CurrencyCOde: Text[100];
        // PortOfLoding: Text[50];
        Origitext: Text[50];
        PartialShip: Text[20];
        CustTRN: Text[50];
        CustGSTNo: Text[50];
        ShipGSTNo: Text[50];
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
        Name: Text;
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
        Text21: Text[500];
        Text22: Text[400];
        Text23: Text[300];
        Text24: Text[450];
        Text25: Text[400];
        Text26: Text[200];
        Text27: Text[300];
        Text28: Text[350];
        Text29: Text[250];
        Text30: Text[250];
        Text31: Text[250];
        Text32: Text[200];
        Text33: Text[350];
        VatOOS: Boolean;
        CustRecSell: Record Customer;
        CustRecBill: Record Customer;
        ShiptoVar: boolean;


        spacePosition: Integer;
        CompanyFirstWord: Text[50];
        //UK::04062020<<
        Text1: text[500];
        Text12: text[500];
        Condition1: TextConst ENU = 'All supplies and services associated with this Quotation/ Offer Letter/Proforma Invoice, shall be provided exclusively based on these General Terms and Conditions of Sale. These General Terms and Conditions of Sale shall also apply to all future business. Deviation from these General Terms and Conditions of Sale require the explicit written approval of %1 (hereinafter referred to as “%2”).';
        Condition2: TextConst ENU = '%1’s quotations, Offer Letters and Proforma Invoices are not binding offers but must be seen as invitations to the Buyer to submit a binding offer. The contract is concluded after that the Buyer’s order (offer) is received and %1 issues a written approval. In case %1’s acceptance differs from the offer, such acceptance will be treated as a new non-binding offer of %1.';
        Condition31: TextConst ENU = 'Unless otherwise agreed, the quality of the goods is exclusively determined by %1’s product specifications. Identified uses relevant for the goods shall neither represent an agreement on the corresponding contractual quality of the goods nor the designated use under this contract.';
        Condition32: TextConst ENU = 'The properties of specimens and samples are binding only insofar as they have been explicitly agreed to define the quality of the goods.';
        Condition33: TextConst ENU = 'Quality and expiry data as well as other data constitute a guarantee only if they have been agreed and designated as such.';
        Condition4: TextConst ENU = 'Any advice rendered by %1 is given to the best of their knowledge. Any advice and information with respect to suitability and application of the goods shall not relieve the Buyer from undertaking their own investigations and tests.';
        Condition5: TextConst ENU = 'If %1’s prices or terms of payment are generally altered between the date of contract and dispatch, %1 may apply the price or the terms of payment in effect on the day of dispatch. In the event of a price increase, Buyer is entitled to withdraw from the contract by giving notice to %1 within 14 days after notification of the price increase.';
        Condition6: TextConst ENU = 'Delivery shall be affected as agreed on the contract. General Commercial Terms shall be interpreted in accordance with the terms in force on the date the contract is concluded.';
        Condition7: TextConst ENU = 'Notice of claims arising out of damage in transit must be logged by the Buyer directly with the carrier within the period specified in the contract of carriage and %1 shall be provided with a copy thereof.';
        Condition8: TextConst ENU = 'Unless specifically agreed otherwise, the Buyer is responsible for compliance with all laws and regulations regarding import, transport, storage and use of the goods';
        Condition91: TextConst ENU = 'Failure to pay the purchase by the due date constitutes a fundamental breach of contractual obligations.';
        Condition92: TextConst ENU = 'In the event of a default in payment by the Buyer, %1 is entitled to charge interest.';
        Condition1011: TextConst ENU = '%1 must be notified of any defects that are discovered during routine inspection within four weeks of receipt of the goods; other defects must be notified within four weeks after they are discovered but not after:';
        Condition1011a: TextConst ENU = 'The expiry of the shelf life of the products, or,';
        Condition1011b: TextConst ENU = 'The products are applied in the manufacturing process, or,';
        Condition1011c: TextConst ENU = 'It is further sold to a third party.';
        Condition1012: TextConst ENU = 'Notification must be in writing and must precisely describe the nature and extent of the defects. %1 will not be responsible for any defects arising due to incorrect or inappropriate handling of the products, and/or, storage conditions.';
        Condition1021: TextConst ENU = 'If the goods are defective and the Buyer has duly notified %1 in accordance with item 10.1, Buyer has its rights provided that:';
        Condition1021a: TextConst ENU = '%1 has the right to choose whether to remedy the Buyer with replacement of goods with non-defective product or give the buyer an appropriate discount in the purchase price, and';
        Condition1021b: TextConst ENU = 'Such defects are authenticated by an independent test report of a reputed international testing agency nominated by %1.';
        Condition103: TextConst ENU = 'In any case, the Buyer’s claims for defective goods are subject to a period of limitation of one year from receipt of goods.';
        Condition1041: TextConst ENU = 'Subject to clauses 10.1, 10.2 & 10.3 above, %1 shall under no circumstances be liable for:';
        Condition1041a: TextConst ENU = 'Any indirect, special or consequential loss.';
        Condition1041b: TextConst ENU = 'Any loss of anticipated profit or loss of business or';
        Condition1041c: TextConst ENU = 'Any third-party claims against the buyer whether such liability would otherwise arise in contract, tort (including negligence) or breach of statutory duty or otherwise.';
        Condition11: TextConst ENU = '%1 shall not be liable to the Buyer for any loss or damage suffered by the buyer as a direct or indirect result of the supply of goods by %1 being prevented, restricted, hindered or delayed by reason of any circumstances outside the control of %1.';
        Condition12: TextConst ENU = '%1 is registered in %2 with License No. %3 and Registration No. %4';
        Condition13: TextConst ENU = 'The General Terms and Conditions of Sale was reviewed and updated on April 2019 and remains valid until further notification';
        Hide_E_sign: Boolean;
        Print_copy: Boolean;
        VatPercentage: Text;
        GSTledgerentry: Record "Detailed GST Ledger Entry";
        CGSTAmt: Decimal;
        SGSTAmt: Decimal;
        IGSTAmt: Decimal;
        OrderNo: code[20];
        Orderdate: Date;
        GrandTotal: Decimal;
        TotalSgstamt: Decimal;
        TotalCgstamt: Decimal;
        TotalIgstamt: Decimal;
        StateRec: Record State;
        CustomeSatedesc: Text[50];
        Bankaccount: Record "Bank Account";
        HideRemarks: Boolean;
        SOremarks: Record "Sales Order Remarks";


}

