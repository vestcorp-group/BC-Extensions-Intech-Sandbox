//T13827-N
report 50521 "COA For Posted Qc Rcpt"
{
    // UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'COA For Posted Qc Rcpt';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/Layout/COA For Posted Qc Rcpt.rdl';

    dataset
    {
        dataitem("Posted QC Rcpt. Header"; "Posted QC Rcpt. Header")
        {
            // DataItemLink = "No." = field("Posted QC No."), "Item No." = field("Item No."), "Variant Code" = field("Variant Code");
            DataItemTableView = sorting("No.");
            // column(Analysis_date; Format("QC Date", 0, '<day,2>-<Month Text>-<year4>')) { } //T13004-N 03-02-2025
            column(Document_No_; "No.") { }
            column(Document_Line_No_; "Document Line No.") { }
            column(ShowExpiry; ShowExpiry) { }
            column(HideTestMethod; HideTestMethod)
            {

            }
            column(SrNoILE; SrNoILE)
            { }
            column(SearchDesc; SearchDesc) { }
            column(ShowMFGDate_gBln; ShowMFGDate_gBln) { }
            column(Item_No_; "Item No.")
            { }
            column(PosQcRcpt_gTxt; PosQcRcpt_gTxt) { }
            column(LotNo_gTxt; LotNo_gTxt) { }
            column(Description; ItemDescription) { }
            column(CustomLotNumber; "Vendor Lot No.") { }
            column(CustomBOENumber; CustomBOENumber) { }
            column(Analysis_date; Format("QC Date", 0, '<day,2>-<Month Text>-<year4>')) { }
            column(Expiration_Date; Format(ExpirationDateG, 0, '<day,2>-<Month Text,3>-<year4>')) { }
            column(Manufacturing_Date; Format(MFGDate_gDte, 0, '<day,2>-<Month Text,3>-<year4>')) { }
            column(Image; CompInfoG.Logo) { }
            column(Compnay_Name; CompInfoG.name) { }
            column(Compy_Address_1; CompInfoG.Address) { }
            column(Compy_Address_2; CompInfoG."Address 2") { }
            column(CompCity; CompInfoG.City) { }
            column(CompCountry; CountryRegionRec.Name) { }

            column(Comp_Tel_No; 'Tel No.: ' + CompInfoG."Phone No.") { }
            column(Comp_TRN; 'TRN: ' + CompInfoG."VAT Registration No.") { }
            column(FooterText; FooterTextG) { }
            column(Company_Image; CompInfoG.Logo) { }
            dataitem("Posted QC Rcpt. Line"; "Posted QC Rcpt. Line")
            {
                DataItemLink = "No." = field("No.");
                column(Type; Type) { }
                column(Testing_Parameter; Description) { }   //T52121-U  + UOMDesc_gTxt
                column(Test_Method; "Method Description") { }
                column(Result; Result) { }
                column(Notes; Notes) { }
                column(Minimum; Minmum_gDec) { }
                column(Maximum; Maximum_gDec) { }
                column(Value; Text_gTxt) { }
                column(Actual_Value; ActualText_gTxt) { }
                column(Sl_No; SlNoG) { }

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin
                    PosQcRcpt_gInt := 0;
                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                    UnitofMeasure_lRec: Record "Unit of Measure";
                begin
                    ActualText_gTxt := '';
                    Text_gTxt := '';
                    Minmum_gDec := 0;
                    Maximum_gDec := 0;
                    UOMDesc_gTxt := '';
                    Clear(UnitofMeasure_lRec);
                    if UnitofMeasure_lRec.Get("Unit of Measure Code") then begin
                        if UnitofMeasure_lRec.Description <> '' then
                            UOMDesc_gTxt := ', ' + UnitofMeasure_lRec.Description
                        else
                            UOMDesc_gTxt := ', ' + UnitofMeasure_lRec.Code;
                    end;

                    //T52614-NS
                    if "Posted QC Rcpt. Line"."Decimal Places" <> 0 then
                        CheckDecimalPlace_lFnc("Posted QC Rcpt. Line");
                    //T52614-NE

                    if Type = Type::Range then begin
                        Minmum_gDec := "Min.Value";
                        Maximum_gDec := "Max.Value";
                        if "Vendor COA Value Result" <> 0 then
                            ActualText_gTxt := DecimalPlaces_lFnc("Vendor COA Value Result", "Decimal Places")//T52614-N
                        // ActualText_gTxt := Format("Vendor COA Value Result") //T52614-O
                        else
                            ActualText_gTxt := '';
                    end;
                    if Type = Type::Minimum then begin
                        Minmum_gDec := "Min.Value";
                        Maximum_gDec := "Max.Value";
                        if "Vendor COA Value Result" <> 0 then
                            ActualText_gTxt := DecimalPlaces_lFnc("Vendor COA Value Result", "Decimal Places")//T52614-N
                        // ActualText_gTxt := Format("Vendor COA Value Result") //T52614-O
                        else
                            ActualText_gTxt := '';
                    end;
                    if Type = Type::Maximum then begin
                        Minmum_gDec := "Min.Value";
                        Maximum_gDec := "Max.Value";
                        if "Vendor COA Value Result" <> 0 then
                            ActualText_gTxt := DecimalPlaces_lFnc("Vendor COA Value Result", "Decimal Places")//T52614-N
                        // ActualText_gTxt := Format("Vendor COA Value Result") //T52614-O
                        else
                            ActualText_gTxt := ''
                    end;
                    if Type = Type::Text then begin
                        Text_gTxt := "Text Value";
                        if "Vendor COA Text Result" <> '' then
                            ActualText_gTxt := Format("Vendor COA Text Result")
                        else
                            ActualText_gTxt := '';
                    end;

                    SlNoG += 1;

                    if ("Posted QC Rcpt. Line".Print = false) OR ("Posted QC Rcpt. Line".Required = false) then
                        CurrReport.Skip();

                    PosQcRcpt_gInt += 1;

                    PosQcRcpt_gTxt := Format(SrNoILE) + '.' + Format(LotNo_gInt) + '.' + Format(PosQcRcpt_gInt);

                end;


            }
            trigger OnAfterGetRecord()
            var
                VariantRec: Record "Item Variant";
                QCReservationEntry_lRec: Record "QC Reservation Entry";
                ItemLedgEntry: Record "Item Ledger Entry";
                ItemEntryRelation: Record "Item Entry Relation";
                QCMgt_lCdu: Codeunit "QC Mgt";
            begin
                Clear(TempItemLedgEntry);
                TempItemLedgEntry.Reset();
                TempItemLedgEntry.DeleteAll();

                LotNo_gTxt := '';
                SlNoG := 0;
                SrNoILE += 1;
                ItemG.Get("Item No.");
                ItemDescription := ItemG.Description;
                if "Variant Code" <> '' then begin
                    VariantRec.Get("Item No.", "Variant Code");
                    if VariantRec.Description <> '' then begin
                        ItemDescription := VariantRec.Description
                    end else begin
                        ItemDescription := ItemG.Description;
                    end;
                end;
                SearchDesc := ItemG."Generic Description" + ', ' + ItemG."Base Unit of Measure";//24032025

                if "Posted QC Rcpt. Header"."Document Type" in ["Posted QC Rcpt. Header"."document type"::Production, "Posted QC Rcpt. Header"."document type"::"Sales Order", "Posted QC Rcpt. Header"."Document Type"::"Purchase Pre-Receipt"] then begin
                    QCReservationEntry_lRec.Reset();
                    QCReservationEntry_lRec.SetRange("Posted QC No.", "Posted QC Rcpt. Header"."No.");
                    if ("Posted QC Rcpt. Header"."Vendor Lot No." <> '') and ("Item Tracking" = "Item Tracking"::"Lot No.") then
                        QCReservationEntry_lRec.SetRange("Lot No.", "Posted QC Rcpt. Header"."Vendor Lot No.");
                    if QCReservationEntry_lRec.FindFirst() then begin
                        Clear(ExpirationDateG);
                        if QCReservationEntry_lRec."Expiration Date" > 0D then
                            ExpirationDateG := QCReservationEntry_lRec."Expiration Date";
                        if QCReservationEntry_lRec."Warranty Date" > 0D then
                            MFGDate_gDte := QCReservationEntry_lRec."Warranty Date";

                        if QCReservationEntry_lRec."Item Tracking" = QCReservationEntry_lRec."Item Tracking"::"Lot No." then
                            LotNo_gTxt := QCReservationEntry_lRec."Lot No.";
                        if QCReservationEntry_lRec."Item Tracking" = QCReservationEntry_lRec."Item Tracking"::"Serial No." then
                            LotNo_gTxt := QCReservationEntry_lRec."Serial No.";
                    end;
                end else begin
                    case "Document Type" of
                        "document type"::Purchase:
                            QCMgt_lCdu.CollectItemEntryRelation_gFnc(TempItemLedgEntry, Database::"Purch. Rcpt. Line", 0, "Posted QC Rcpt. Header"."Document No.", '', 0, "Posted QC Rcpt. Header"."Document Line No.", 0, "Posted QC Rcpt. Header"."No.");
                        "document type"::"Sales Return":
                            QCMgt_lCdu.CollectItemEntryRelation_gFnc(TempItemLedgEntry, Database::"Return Receipt Line", 0, "Posted QC Rcpt. Header"."Document No.", '', 0, "Posted QC Rcpt. Header"."Document Line No.", 0, "Posted QC Rcpt. Header"."No.");
                        "document type"::"Transfer Receipt":
                            QCMgt_lCdu.CollectItemEntryRelation_gFnc(TempItemLedgEntry, Database::"Transfer Receipt Line", 0, "Posted QC Rcpt. Header"."Document No.", '', 0, "Posted QC Rcpt. Header"."Document Line No.", 0, "Posted QC Rcpt. Header"."No.");
                        "Document type"::ile:
                            QCMgt_lCdu.Retest_PostedQCCollectItemEntryRelation_gFnc(TempItemLedgEntry, Database::"Item Ledger Entry", 0, "Posted QC Rcpt. Header"."Document No.", '', 0, "Posted QC Rcpt. Header"."Document Line No.", 0, "Posted QC Rcpt. Header"."No.");
                    end;

                    if TempItemLedgEntry.IsEmpty then
                        Error('Item Ledger Entry is not found against the Posted QC Rcpt. Header.');

                    if ("Posted QC Rcpt. Header"."Vendor Lot No." <> '') and ("Item Tracking" = "Item Tracking"::"Lot No.") then begin
                        TempItemLedgEntry.SetRange("Lot No.", "Posted QC Rcpt. Header"."Vendor Lot No.");
                        if TempItemLedgEntry.FindFirst() then begin
                            if TempItemLedgEntry."Expiration Date" > 0D then
                                ExpirationDateG := TempItemLedgEntry."Expiration Date";
                            if TempItemLedgEntry."Warranty Date" > 0D then
                                MFGDate_gDte := TempItemLedgEntry."Warranty Date";
                        end;
                    end;
                end;

                LotNo_gInt += 1;

                LotNo_gTxt := Format(SrNoILE) + '.' + Format(LotNo_gInt);
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;

            begin
                SrNoILE := 0;
                /*  Clear(CompInfoG);
                 if CompanyFilter <> '' then begin
                     CompInfoG.ChangeCompany(CompanyFilter);
                 end;
                 CompInfoG.get();
                 CompInfoG.CalcFields(Picture, Logo);
                 FooterTextG := CompanyName + ', ' + CompInfoG.Address + ', ' + CompInfoG."Address 2" + ' Tel:' + CompInfoG."Phone No." + ' Fax:' + CompInfoG."Fax No.";
                 CountryRegionRec.Get(CompInfoG."Country/Region Code"); */
                //T14179-NS
                Clear(CompInfoG);
                if CompanyFilter <> '' then begin
                    CompInfoG.Get(CompanyFilter);
                end else begin
                    CompInfoG.Get(CurrentCompany);
                end;
                CompInfoG.CalcFields(Picture, Logo);
                FooterTextG := CompanyName + ', ' + CompInfoG.Address + ', ' + CompInfoG."Address 2" + ' Tel:' + CompInfoG."Phone No." + ' Fax:' + CompInfoG."Fax No.";
                CountryRegionRec.Get(CompInfoG."Country/Region Code");
                //T14179-NE
            end;
        }
    }


    requestpage
    {
        layout
        {

            area(Content)
            {
                field(ShowExpiry; ShowExpiry)
                {
                    ApplicationArea = all;
                    Caption = 'Show Expiry';

                }
                field("Show MFG Date"; ShowMFGDate_gBln)
                {
                    ApplicationArea = All;
                }
                field(CompanyFilter; CompanyFilter)
                {
                    ApplicationArea = All;
                    TableRelation = Company;
                    Caption = 'Company Name';
                }
                field(HideTestMethod; HideTestMethod)
                {
                    ApplicationArea = All;
                    Caption = 'Hide Test Method Column';
                }
            }
        }
        trigger OnOpenPage()
        begin
            ShowExpiry := false;
        end;
    }
    //T52614-NS
    local procedure DecimalPlaces_lFnc(DecValue_iDec: Decimal; Places_iInt: Integer): Text
    var
        FormatString: Text;
        VendorCOAValueText_lTxt: Text;
    begin
        VendorCOAValueText_lTxt := '';
        if Places_iInt > 0 then begin
            FormatString := '<Precision,' + Format(Places_iInt + 1) + '>' + '<sign><Integer Thousand>' + '<Decimals,' + Format(Places_iInt + 1) + '>';
            VendorCOAValueText_lTxt := Format(DecValue_iDec, 0, FormatString);
            if StrPos(VendorCOAValueText_lTxt, '*') > 0 then
                VendorCOAValueText_lTxt := 'Please check the Setup or connect with the IT Team.'
        end else
            VendorCOAValueText_lTxt := Format(DecValue_iDec);

        if DecValue_iDec = 0 then
            VendorCOAValueText_lTxt := '';

        exit(VendorCOAValueText_lTxt);

    end;
    //T52614-NE
    var
        UOMDesc_gTxt: Text;
        TempItemLedgEntry: Record "Item Ledger Entry" temporary;
        MFGDate_gDte: Date;
        CustomBOENumber: Text;
        LotNo_gTxt: Text;
        SrNoILE: Integer;
        PosQcRcpt_gTxt: Text;
        // TestingParameterG: Record "Testing Parameter";
        // ItemTestingParameterG: Record "Item Testing Parameter";
        ShowMFGDate_gBln: Boolean;
        LotNo_gInt: Integer;
        PosQcRcpt_gInt: Integer;
        SearchDesc: Text;
        Minmum_gDec: Decimal;
        Maximum_gDec: Decimal;
        ActualText_gTxt: Text;
        Text_gTxt: Text;
        SalesShipmentLineG: Record "Sales Shipment Line";
        // CompInfoG: Record "Company Information";//T14179-N
        CompInfoG: Record "Staging Company Information";//T14179-N
        ItemG: Record Item;
        SlNoG: Integer;
        FooterTextG: Text;
        ExpirationDateG: Date;
        ShowExpiry: Boolean;

        CountryRegionRec: Record "Country/Region";
        ItemTestingParameterValue: Text;
        CompanyFilter: Text;
        HideTestMethod: Boolean;
        ItemDescription: Text;
}