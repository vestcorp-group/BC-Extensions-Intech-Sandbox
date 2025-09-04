report 50114 "Commercial Invoice"
{
    // version Task4
    Caption = 'Commercial Invoice';
    DefaultLayout = RDLC;
    // RDLCLayout = './Layouts/Transfer Commercial Invoice.rdl';
    RDLCLayout = './Layouts/Transfer Order Clearance.rdl';

    dataset
    {
        dataitem("Transfer Header"; "Transfer Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Posting Date";
            column(No_TH; "No.") { }
            // column(PostingDate_TH; "Posting Date") { }
            column(TransferfromName_TH; LocationFrom.Name) { }
            column(TransferfromAddress_TH; LocationFrom.Address) { }
            column(TransferfromAddress2_TH; LocationFrom."Address 2") { }
            column(TransferfromCity_TH; LocationFrom.City) { }
            column(Transfer_from_Post_Code; LocationFrom."Post Code") { }
            column(Transfer_to_Post_Code; LocationTo."Post Code") { }
            column(TrsffromCountryRegionCode_TH; LocationFrom."Country/Region Code") { }
            column(TrFromCountryName; FromCountryName) { }
            column(TransfertoName_TH; LocationTo.Name) { }
            column(TransfertoAddress_TH; LocationTo.Address) { }
            column(TransfertoAddress2_TH; LocationTo."Address 2") { }
            column(TransfertoCity_TH; LocationTo.City) { }
            column(TrsftoCountryRegionCode_TH; LocationTo."Country/Region Code") { }
            column(TrToCountryName; ToCountryName) { }
            column(FromAddressToggle; FromAddressToggle) { }
            column(ToAddressToggle; ToAddressToggle) { }
            column(Name_CI; companyInfo.Name) { }
            column(Address_CI; companyInfo.Address) { }
            column(Address2_CI; companyInfo."Address 2") { }
            column(PostCode_CI; companyInfo."Post Code") { }
            column(City_CI; companyInfo.City) { }
            column(CountryRegion_CI; companyInfo."Country/Region Code") { }
            column(TotalQty; TotalQty) { }
            column(LineUnMerge; LineUnMerge) { }
            column(Order_No_; "No.") { }
            column(Order_Date; "Posting Date") { }
            //New
            column(PostingDate_TH; format("Posting Date", 0, '<Day,2>-<Month Text>-<year4>')) { }
            column(YourReferenceNo; "External Document No.") { }
            column(CompLogo; CompanyInformation.Picture) { }
            column(HideBank_Detail; HideBank_Detail) { }
            column(countryDesc; countryDesc) { }
            column(AmtInclVAT_gTxt; AmtInclVAT_gTxt) { }
            column(TotalAmtInclVAT_gTxt; TotalAmtInclVAT_gTxt) { }
            column(TransferToAddr; TransferToAddr) { }
            column(CompName; CompanyInformation.Name) { }
            column(CompAddr1; CompanyInformation.Address) { }
            column(CompAddr2; CompanyInformation."Address 2") { }
            column(Telephone; CompanyInformation."Phone No.") { }
            column(TRNNo; CompanyInformation."VAT Registration No.") { }
            column(CompanyInformation_City; CompanyInformation.City) { }
            column(Web; CompanyInformation."Home Page") { }
            column(CustAddrShipto_Arr1; CustAddrShipto_Arr[1]) { }
            column(CustAddrShipto_Arr2; CustAddrShipto_Arr[2]) { }
            column(CustAddrShipto_Arr3; CustAddrShipto_Arr[3]) { }
            column(CustAddrShipto_Arr4; CustAddrShipto_Arr[4]) { }
            column(CustAddrShipto_Arr5; CustAddrShipto_Arr[5]) { }
            column(CustAddrShipto_Arr6; CustAddrShipto_Arr[6]) { }
            column(CustAddrShipto_Arr7; CustAddrShipto_Arr[7]) { }
            column(CustAddrShipto_Arr8; CustAddrShipto_Arr[8]) { }
            column(PaymentTerms; PmttermDesc) { }
            column(DeliveryTerms; "Shipment Method Code") { }
            column(PortOfDischarge_SalesInvoiceHeader; AreaDesc)
            {
                /*IncludeCaption = true;*/
            }
            column(PortofLoading_SalesInvoiceHeader; "Entry/Exit Point")
            {
                /*IncludeCaption = true;*/
            }
            column(InsurancePolicy; InsurancePolicy) { }
            Column(BankName; '') { }
            Column(BankAddress2; '') { }
            column(BankCity; '') { }
            column(BankCountry; '') { }
            Column(IBANNumber; '') { }
            Column(SWIFTCode; '') { }
            column(CompanyInfo_Stamp; CompanyInformation.Stamp) { }
            column(CompanyInformation_Address; CompanyInformation.Address) { }
            column(CompanyInformation_Address2; CompanyInformation."Address 2") { }
            column(CompanyInformation_Country; CompanyInformation."Country/Region Code") { }
            column(BankAddress; '') { }
            column(PrintStamp; PrintStamp) { }
            column(Currency_Factor; '') { }
            column(TotalAmt; TotalAmt) { }
            column(SNo; 0) { }
            column(LCYCode; GLSetup."LCY Code") { }
            column(AmtExcVATLCY; 0) { }
            column(VatAmt; '') { }
            column(Currency_Code; '') { }
            //column(Currency_CodeSymbol; "Currency Code") { }
            column(Inspection_Caption; '') { }
            column(TaxDeclaration; '') { }
            column(GST; CompanyInformation."Enable GST Caption") { }
            column(String; String + ' ' + CurrDesc) { }
            column(CurrDesc; CurrDesc) { }
            column(AmtinWord_GTxt; AmtinWord_GTxt[1] + ' ' + AmtinWord_GTxt[2]) { }
            column(Print_copy; Print_copy) { }
            column(RepHdrtext; RepHdrtext) { }
            column(Insurance_Policy_No_; '') { }
            column(AmtIncVATLCY; 0.0) { }
            column(InspectionRequired; InspectionRequired) { }
            column(LegalizationRequired; LegalizationRequired) { }
            column(Duty_Exemption; '') { }
            column(Hide_E_sign; Hide_E_sign) { }

            dataitem("Transfer Line"; "Transfer Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE("Derived From Line No." = CONST(0));
                column(LineNo_TransferLine; "Line No.") { }
                column(SerialNo; SerialNo) { }
                column(ItemNo_TL; "Item No.") { }
                // column(UnitCost_gDec; UnitCost_gDec) { }//AS-O 06-11-24----
                column(UnitCost_gDec; "Unit Price") { }
                column(UnitofMeasure_TL; BaseUOMVar) { }
                column(Description_TL; Description) { }
                column(Variant_Code; "Variant Code") { }
                column(Quantity_TL; "Quantity (Base)") { }
                column(QuantityBase_TL; "Quantity (Base)") { }
                // column(AmtExclVAT_gDec; UnitCost_gDec * "Transfer Line"."Quantity (Base)") { }//AS-O
                column(AmtExclVAT_gDec; "Unit Price" * "Transfer Line".Quantity) { }//AS-N
                // column(AmtInclVAT_gDec; UnitCost_gDec * "Transfer Line"."Quantity (Base)") { }//AS-O
                column(AmtInclVAT_gDec; "Unit Price" * "Transfer Line".Quantity) { }
                column(AlterNateUOMCode; UOMDesc) { }
                column(DecimalAllowed; DecimalAllowed) { }
                column(AlternateUOMQty; "Quantity (Base)" / AlternateQtyUOM) { }
                column(HSCode; HSCodeVar) { }
                column(Origin; OriginVar) { }

                column(Generic_Name; GenericNameVar) { }
                column(TotalAltQty; ("Quantity (Base)" / AlternateQtyUOM)) { }

                column(AltQtytransferline; "Quantity (Base)" / AlternateQtyUOM) { }
                column(LotExist; LotExist) { }
                //New
                column(PINONew; PINONew) { }
                column(PIDateNew; FORMAT(PIDateNew, 0, '<Day,2>/<Month,2>/<Year4>')) { }
                Column(LC_No; '') { } //PackingListExtChange
                column(LC_Date; '') { } //PackingListExtChange
                                        // column(Order_No_; SalesOrderNo) { }

                column(SrNo; SrNo) { }
                column(UnitofMeasureCode_SalesInvoiceLine; '') { } //PackingListExtChange
                // column(String; String + ' ' + CurrDesc) { }
                column(Quantity_SalesInvoiceLine; "Quantity (Base)")
                {
                    IncludeCaption = true;
                }
                column(UnitPrice_SalesInvoiceLine; 0)
                {
                    // IncludeCaption = true;
                }
                column(VatPer; '')
                {
                    // IncludeCaption = true;
                }
                column(VatOOS; VatOOS) { }
                column(AmountIncludingVAT_SalesInvoiceLine; 0)
                {
                    // IncludeCaption = true;
                }
                column(Sorting_No_; 2) { }
                column(Description_SalesInvoiceLine; Description)
                {
                    IncludeCaption = true;
                }
                column(CustAddr_Arr1; CustAddr_Arr[1]) { }
                column(CustAddr_Arr2; CustAddr_Arr[2]) { }
                column(CustAddr_Arr3; CustAddr_Arr[3]) { }
                column(CustAddr_Arr4; CustAddr_Arr[4]) { }
                column(CustAddr_Arr5; CustAddr_Arr[5]) { }
                column(CustAddr_Arr6; CustAddr_Arr[6]) { }
                column(CustAddr_Arr7; CustAddr_Arr[7]) { }
                column(CustAddr_Arr8; CustAddr_Arr[8]) { }
                column(CustTRN; '') { }
                column(IsItem; IsItem) { }
                column(SearchDesc; '') { }
                column(Packing; '') { }
                column(CASNO; '') { }
                column(IUPAC; '') { }
                column(SrNo3; 0) { }
                column(SrNo4; 0) { }
                column(SrNo5; 0) { }
                column(SrNo6; 0) { }
                column(SrNo7; 0) { }

                dataitem("Reservation Entry"; "Reservation Entry")
                {
                    DataItemLink = "Source ID" = FIELD("Document No."),
                                   "Source Ref. No." = FIELD("Line No."),
                                   "Item No." = FIELD("Item No."),
                                   "Location Code" = FIELD("Transfer-to Code");
                    DataItemTableView = SORTING("Entry No.", Positive)
                                        ORDER(Ascending)
                                        WHERE("Source Type" = FILTER(5741));
                    //WHERE("Source Type" = FILTER(5741), "Lot No." = FILTER(<> ''));

                    column(LotNo_R; CustomLotNumber) { }
                    column(Quantity_Base_R; "Quantity (Base)") { }
                    column(AltQtyreservation; "Quantity (Base)" / AlternateQtyUOM) { }
                    column(AltQty1; "Quantity (Base)" / AlternateQtyUOM) { }
                    column(BOE_No; CustomBOENumber) { }
                }
                dataitem(Integer; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        ORDER(Ascending)
                                        WHERE(Number = const(1));

                    column(AlternateUOMQty11; "Transfer Line"."Quantity (Base)" / AlternateQtyUOM) { }
                    column(QuantityBase_TL1; "Transfer Line"."Quantity (Base)") { }
                    // column(AmtInclVAT1_gDec; UnitCost_gDec * "Transfer Line"."Quantity (Base)") { }//AS-O
                    column(AmtInclVAT1_gDec; "Transfer Line"."Unit Price" * "Transfer Line".Quantity) { }
                }

                trigger OnAfterGetRecord()
                var
                    Item: Record Item;
                    Generic: Record KMP_TblGenericName;
                    CountryOrRegion: Record "Country/Region";
                    UnitofMeasure: Record "Unit of Measure";
                    RecVariant: Record "Item Variant";
                    Check_LRep: Report Check;
                begin
                    Clear(Check_LRep);

                    SrNo += 1;
                    //Serial No. Auto Increament
                    SerialNo := SerialNo + 1;
                    Clear(GenericNameVar);
                    Clear(OriginVar);
                    Clear(HSCodeVar);
                    Clear(BaseUOMVar);
                    Clear(UnitCost_gDec);
                    if Item.Get("Transfer Line"."Item No.") then begin
                        if Generic.Get(Item.GenericName) then
                            GenericNameVar := Generic.Description;
                        if CountryOrRegion.Get(Item."Country/Region of Origin Code") then
                            OriginVar := CountryOrRegion.Name;
                        HSCodeVar := Item."Tariff No.";
                        BaseUOMVar := Item."Base Unit of Measure";
                        UnitCost_gDec := Item."Unit Cost";
                        if "Transfer Line"."Variant Code" <> '' then begin
                            RecVariant.Get("Transfer Line"."Item No.", "Transfer Line"."Variant Code");
                            if RecVariant.HSNCode <> '' then begin
                                HSCodeVar := RecVariant.HSNCode;
                            end else begin
                                HSCodeVar := Item."Tariff No.";
                            end;
                            if RecVariant.CountryOfOrigin <> '' then begin
                                OriginVar := RecVariant.CountryOfOrigin;
                            end else begin
                                OriginVar := CountryOrRegion.Name;
                            end;
                        end;
                    end;

                    // TotalAmt += UnitCost_gDec * "Transfer Line"."Quantity (Base)";


                    // Check_LRep.InitTextVariable;
                    // Check_LRep.FormatNoText(AmtinWord_GTxt, TotalAmt, '');
                    // String := DelChr(AmtinWord_GTxt[1], '<>', '*') + AmtinWord_GTxt[2];
                    // String := CopyStr(String, 2, StrLen(String));

                    IsItem := FALSE;
                    //Getting the Minimum Alternate UOM Qty. and its code
                    DecimalAllowed := false;
                    AlternateQtyUOM := 0;
                    UOMCode := '';
                    UOMDesc := '';
                    ItemUnitMeasure.SETRANGE("Item No.", "Item No.");
                    /* if "Variant Code" <> '' then
                        ItemUnitMeasure.SetRange("Variant Code", "Variant Code")
                    else
                        ItemUnitMeasure.SetRange("Variant Code", ''); */

                    if "Variant Code" <> '' then begin
                        If ItemUnitMeasure."Variant Code" = "Variant Code" then begin
                            ItemUnitMeasure.SetRange("Variant Code", "Variant Code");
                        end else begin
                            ItemUnitMeasure.SetRange("Variant Code", '');
                        end
                    end else begin
                        ItemUnitMeasure.SetRange("Variant Code", '');
                    end;

                    IF ItemUnitMeasure.FINDFIRST THEN BEGIN
                        AlternateQtyUOM := ItemUnitMeasure."Qty. per Unit of Measure";
                        UOMCode := ItemUnitMeasure.Code;
                        IF (UnitofMeasure.GET(UOMCode)) and (UnitofMeasure."Decimal Allowed") then
                            DecimalAllowed := true;
                        REPEAT
                            IF AlternateQtyUOM > ItemUnitMeasure."Qty. per Unit of Measure" THEN BEGIN
                                AlternateQtyUOM := ItemUnitMeasure."Qty. per Unit of Measure";
                                UOMCode := ItemUnitMeasure.Code;
                                IF (UnitofMeasure.GET(UOMCode)) and (UnitofMeasure."Decimal Allowed") then
                                    DecimalAllowed := true;
                            END;
                        UNTIL ItemUnitMeasure.NEXT = 0;
                    END;
                    UOMDesc := UnitofMeasure.Description;
                    LotExist := false;
                    ReservationEntryRec.Reset();
                    ReservationEntryRec.SetRange("Source ID", "Document No.");
                    ReservationEntryRec.SetRange("Source Ref. No.", "Line No.");
                    ReservationEntryRec.SetRange("Item No.", "Item No.");
                    ReservationEntryRec.SetRange("Location Code", "Transfer-to Code");
                    if ReservationEntryRec.FindFirst() then
                        LotExist := true;

                end;

                trigger OnPostDataItem()
                var
                    Check_LRep: Report Check;
                begin
                    // Clear(AmtinWord_GTxt);
                    // Clear(Check_LRep);
                    // Check_LRep.InitTextVariable;
                    // Check_LRep.FormatNoText(AmtinWord_GTxt, TotalAmt, '');
                    // String := DelChr(AmtinWord_GTxt[1], '<>', '*') + AmtinWord_GTxt[2];
                    // String := CopyStr(String, 2, StrLen(String));
                end;

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    Clear(AmtinWord_GTxt);
                end;
            }
            dataitem("Transfer Transaction Comments"; "Transfer Transaction Comments")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE("Document Type" = FILTER("Transfer Order"));
                column(RemarksSerial; RemarksSerial) { }
                column(LineNo_TCL; "Line No.") { }
                column(No_TCL; "Document No.") { }
                column(Comment; Comments) { }

                trigger OnAfterGetRecord()
                begin
                    // Assigning Serial No. to Remarks.
                    RemarksSerial := RemarksSerial + 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                transferline: Record "Transfer Line";
                TransferLine_lRec: Record "Transfer Line";
                //New
                TranSpec_rec: Record "Transaction Specification";
                Area_Rec: Record "Area";
                ShipmentNo: Text[20];
                Location_lRec: Record Location;
                CountryRegion_lRec: Record "Country/Region";
                Check_LRep: Report Check;
                Item_lRec: Record Item;
            begin

                AreaDesc := '';
                ExitPtDesc := '';
                SrNo := 0;

                Clear(CustAddrShipto_Arr);
                Clear(CustAddr_Arr);

                CLEAR(TotalAltQty);
                CLEAR(TotalQty);
                if LocationFrom.Get("Transfer-from Code") then;
                if LocationTo.Get("Transfer-to Code") then;

                GLSetup.Get();

                // TranSec_Desc := '';
                // IF TranSpec_rec.GET("Transaction Specification") then
                //     TranSec_Desc := TranSpec_rec.Text;

                if CurrencyRec.Get(GLSetup."LCY Code") then
                    CurrDesc := CurrencyRec.Description;

                TransferLine_lRec.Reset();
                TransferLine_lRec.SetRange("Document No.", "No.");
                if TransferLine_lRec.FindSet() then begin
                    repeat begin
                        Clear(Item_lRec);
                        if Item_lRec.Get(TransferLine_lRec."Item No.") then
                            UnitCost_gDec := Item_lRec."Unit Cost";
                        // if UnitCost_gDec <> 0 then
                        // TotalAmt += UnitCost_gDec * TransferLine_lRec."Quantity (Base)";//AS-O
                        TotalAmt += TransferLine_lRec."Unit Price" * TransferLine_lRec.Quantity;//AS-N
                    end until TransferLine_lRec.Next() = 0;
                end;


                Clear(AmtinWord_GTxt);
                Clear(Check_LRep);
                Check_LRep.InitTextVariable;
                Check_LRep.FormatNoText(AmtinWord_GTxt, TotalAmt, '');
                String := DelChr(AmtinWord_GTxt[1], '<>', '*') + AmtinWord_GTxt[2];
                String := CopyStr(String, 2, StrLen(String));

                AreaRec.Reset();
                IF AreaRec.Get("Transfer Header"."Area") then
                    AreaDesc := AreaRec.Text;

                // IF Area_Rec.Get("Area") And (Area_Rec.Text <> '') then
                //     TranSec_Desc := TranSec_Desc + ', ' + AreaDesc;

                // if ShipmentNo <> '' then
                //     TranSec_Desc := TranSec_Desc + ', ' + ShipmentNo;


                // Getting Country Name for Transfer from and to Addresses.
                IF FromAddressToggle THEN BEGIN
                    CountryRegion.GET(companyInfo."Country/Region Code");
                    FromCountryName := CountryRegion.Name;
                END ELSE BEGIN
                    CountryRegion.GET(LocationFrom."Country/Region Code");
                    FromCountryName := CountryRegion.Name;
                END;

                IF ToAddressToggle THEN BEGIN
                    CountryRegion.GET(companyInfo."Country/Region Code");
                    ToCountryName := CountryRegion.Name;
                END ELSE BEGIN
                    CountryRegion.GET(LocationTo."Country/Region Code");
                    ToCountryName := CountryRegion.Name;
                END;

                transferline.Reset();
                transferline.SETRANGE("Document No.", "No.");
                IF transferline.FindSet() then begin
                    transferline.CalcSums("Quantity (Base)");
                    TotalQty := transferline."Quantity (Base)";
                end;

                IF PostedShowCommercial then
                    RepHdrtext := 'Commercial Invoice'
                else
                    RepHdrtext := 'Tax Invoice';

                TransferToAddr := '';
                PmttermDesc := '';
                if Location_lRec.Get("Transfer Header"."Transfer-to Code") then begin
                    if Location_lRec.Name <> '' then
                        TransferToAddr := Location_lRec.Name;
                    if Location_lRec.Address <> '' then
                        TransferToAddr += '<br/>' + Location_lRec.Address;
                    if Location_lRec."Address 2" <> '' then
                        TransferToAddr += '<br/>' + Location_lRec."Address 2";
                    if Location_lRec.City <> '' then
                        TransferToAddr += '<br/>' + Location_lRec.City;
                    if Location_lRec."Post Code" <> '' then
                        TransferToAddr += ' - ' + Location_lRec."Post Code";
                    if Location_lRec."Country/Region Code" <> '' then
                        if CountryRegion_lRec.Get(Location_lRec."Country/Region Code") then
                            TransferToAddr += '<br/>' + CountryRegion_lRec.Name;

                    if Location_lRec."Payment Details" <> '' then
                        PmttermDesc := Location_lRec."Payment Details";
                end;
            end;

            trigger OnPreDataItem()
            begin
                TotalAmt := 0;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    // field(BankNo; BankNo)
                    // {
                    //     TableRelation = "Bank Account"."No.";
                    //     ApplicationArea = All;
                    //     Visible = false;
                    // }
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
                    // field("Do Not Show G\L"; PostedDoNotShowGL)
                    // {
                    //     ApplicationArea = All;
                    // }

                    // field("Print Customer Invoice"; PostedCustomInvoiceG)
                    // {
                    //     ApplicationArea = ALL;
                    // }
                    // field("SalesLine Merge"; SalesLineMerge)
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'SalesLine UnMerge';
                    // }
                    // field(PrintCustomerAltAdd; PrintCustomerAltAdd)
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Customer Alternate Address';
                    // }
                    // field(Hide_E_sign; Hide_E_sign)
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Hide E-Signature';
                    // }
                    // field(Print_copy; Print_copy)
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Print Copy Document';
                    // }
                    // field("Print Clearance Ship-To Address"; blnClrAddress)
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Print Clearance Ship-To Address';
                    // }
                    field(PrintStamp; PrintStamp)
                    {
                        ApplicationArea = all;
                        Caption = 'Print Digital Stamp';
                    }
                    // field("Print Agent Representative Address"; PrintAgentRepAddress)
                    // {
                    //     ApplicationArea = all;
                    //     Caption = 'Print Agent Representative Address';
                    // }
                }
                // field("Hide From Warehouse"; FromAddressToggle)
                // {
                //     ApplicationArea = All;

                //     trigger OnValidate()
                //     begin
                //         IF ToAddressToggle THEN BEGIN
                //             ERROR('Only One Toggle can be selected');
                //             FromAddressToggle := FALSE
                //         END;
                //     end;
                // }
                // field("Hide To Warehouse"; ToAddressToggle)
                // {
                //     ApplicationArea = All;

                //     trigger OnValidate()
                //     begin
                //         IF FromAddressToggle THEN BEGIN
                //             ERROR('Only One Toggle can be selected');
                //             ToAddressToggle := FALSE
                //         END;
                //     end;
                // }
                // field("Line Merge"; LineUnMerge)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Line UnMerge';
                // }
            }
        }

        actions
        {
        }
    }

    labels
    {
        // Report_Lbl = 'Transfer';
        // Report_Lbl1 = ' Order';
        // Report_Lbl2 = ' (Warehouse to Warehouse)';
        Authority_Lbl = 'Authorized Signatory:';
        Stamp_Lbl = 'Stamp:';
        // Date_Lbl = 'Date:';
        Remarks_Lbl = 'Both parties confirm with their signature that all the products are Delivered/Received in perfect condition. Please explain here if any discrepancy exists.';
        TrFrom_Lbl = 'Transfer From:';
        TrTo_Lbl = 'Transfer To:';
        SerialNo_Lbl = 'SN';
        ItemNo_Lbl = 'Item No.';
        Desc_Lbl = 'Description';
        LotNo_Lbl = 'Lot Number';
        Boe_Lbl = 'BOE Number';
        BaseUOM_Lbl = 'UOM';
        // BaseUOM_Lbl = 'Base UOM';
        UnitPrice_Lbl = 'Unit Price';
        AmtExclVAT_Lbl = 'Amount Excl. VAT';
        VATPer_Lbl = 'VAT %';
        VATPerAmt_Lbl = 'VAT Amount';
        // AmtInclVAT_Lbl = 'Amount Incl. VAT';
        BUOMQ_Lbl = 'Qty';
        // BUOMQ_Lbl = 'Base UOM Qty';
        AlUOM_Lbl = 'Alternate UOM';
        AlUOMQ_Lbl = 'Alternate UOM Qty';
        Total_Lbl = 'Total';
        PosDate_Lbl = 'Posting Date:';
        OrderNo_Lbl = 'Transfer Order No.:';
        RemarkHead_Lbl = 'Remarks:';

        //New
        RepHeader = 'Commercial Invoice';
        Ref_Lbl = 'Invoice No.:';
        Date_Lbl = 'Invoice Date:';
        CustRef_Lbl = 'Customer Ref:';
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

        Custom_Lbl = 'Customs Purpose Only';
        //GK
        NoteHdr_Lbl = 'Transfer of Ownership certificate';
        Note1_Lbl = '"Commercial invoice is only issued for customs clearance purposes; it does not bear any financial implication".';
        Note2_Lbl = '"Goods are transfer to the recipient for processing/ toll manufacturing under toll manufacturing agreement (reference no.)"';
        Note3_Lbl = '"Ownership in the goods shall always remain with Kemipex"';
    }

    trigger OnInitReport()
    begin
        SerialNo := 0;
        RemarksSerial := 1;
        PrintStamp := true;
    end;

    trigger OnPreReport()
    var
        GenLedSetup_lRec: Record "General Ledger Setup";
    begin
        companyInfo.GET;
        GenLedSetup_lRec.GET;


        CompanyInformation.Get;
        CompanyInformation.CalcFields(Picture, Stamp);

        spacePosition := StrPos(CompanyInformation.Name, ' ');
        CompanyFirstWord := CopyStr(CompanyInformation.Name, 1, spacePosition - 1);

        HideBank_Detail := true;


        if CountryRec.Get(CompanyInformation."Country/Region Code") then
            countryDesc := CountryRec.Name;

        if GenLedSetup_lRec."LCY Code" <> '' then begin
            AmtInclVAT_gTxt := StrSubstNo(AmtInclVAT_Lbl, GenLedSetup_lRec."LCY Code");
            TotalAmtInclVAT_gTxt := StrSubstNo(TotalAmtInclVAT_Lbl, GenLedSetup_lRec."LCY Code");
        end else begin
            AmtInclVAT_gTxt := StrSubstNo(AmtInclVAT_Lbl, '');
            TotalAmtInclVAT_gTxt := StrSubstNo(TotalAmtInclVAT_Lbl, '');
        end;
    end;

    var
        GLEntry_lRec: Record "General Ledger Setup";
        SerialNo: Integer;
        CountryRegion: Record "Country/Region";
        FromCountryName: Text[50];
        ToCountryName: Text[50];
        FromAddressToggle: Boolean;
        ToAddressToggle: Boolean;
        companyInfo: Record "Company Information";
        ItemUnitMeasure: Record "Item Unit of Measure";
        AlternateQtyUOM: Decimal;
        UOMCode: Code[20];
        UOMDesc: Text;
        OriginVar: Text;
        HSCodeVar: Text;
        BaseUOMVar: Text;
        Item: Record "Item";
        ReservationEntryRec: Record "Reservation Entry";
        RemarksSerial: Integer;
        TotalQty: Decimal;
        TotalAltQty: Decimal;
        AltQty: Decimal;
        TotalUOMQty: Decimal;
        AltQty1: Decimal;
        GenericNameVar: Text;
        LocationFrom: Record Location;
        LocationTo: Record Location;
        LotExist: Boolean;
        DecimalAllowed: Boolean;
        LineUnMerge: Boolean;
        //New
        CompanyInformation: Record "Company Information";
        spacePosition: Integer;
        CompanyFirstWord: Text[50];
        HideBank_Detail: Boolean;
        countryDesc: text;
        CountryRec: Record "Country/Region";
        CustAddrShipto_Arr: array[8] of Text[100];
        PmttermDesc: Text;
        TranSec_Desc: Text[150];
        AreaRec: Record "Area";
        AreaDesc: Text[100];
        ExitPtDesc: Text[100];
        InsurancePolicy: text[100];
        PINONew: code[20];
        PIDateNew: Date;
        SalesOrderNo: Code[20];
        PrintStamp: Boolean;
        GLSetup: Record "General Ledger Setup";
        SrNo: Integer;
        VatOOS: Boolean;
        CASNO: Text[500];
        IUPAC: Text[1000];
        Print_copy: Boolean;
        RepHdrtext: Text[50];
        PostedShowCommercial: Boolean;
        CustAddr_Arr: array[9] of Text[100];
        IsItem: Boolean;
        InspectionRequired: Boolean;
        LegalizationRequired: Boolean;
        Hide_E_sign: Boolean;
        TransferToAddr: Text;
        UnitCost_gDec: Decimal;
        AmtInclVAT_gTxt: Text;
        TotalAmtInclVAT_gTxt: Text;
        AmtInclVAT_Lbl: TextConst ENU = 'Amount Incl. VAT (%1)';
        TotalAmtInclVAT_Lbl: TextConst ENU = 'Total Amount Including VAT in %1';
        AmtExclVAT_gDec: Decimal;
        AmtInclVAT_gDec: Decimal;
        TotalAmt: Decimal;
        CurrencyRec: Record Currency;
        CurrDesc: Text[50];
        AmtinWord_GTxt: array[2] of Text[100];
        String: Text[100];
}