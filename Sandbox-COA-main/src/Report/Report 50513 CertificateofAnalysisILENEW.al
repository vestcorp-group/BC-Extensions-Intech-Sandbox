//T13827-N
report 50513 "CertificateofAnalysisILENEW"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Certificate of Analysis ILE';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/Layout/CertificateofAnalysis_ILE.rdl';

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            // DataItemLink = "Document No." = field("No.");
            DataItemTableView = sorting("Document Line No.");
            //  where("Document Type" = filter("Sales Shipment"), Quantity = filter(< 0))
            column(Document_No_; "Document No.") { }
            column(Document_Line_No_; "Document Line No.") { }
            column(ShowExpiry; ShowExpiry) { }
            column(HideTestMethod; HideTestMethod)
            {

            }
            column(Posted_QC_No_; "Posted QC No.") { }//AS-010425-N
            column(SrNoILE; SrNoILE)
            { }
            column(SearchDesc; SearchDesc) { }
            column(ShowMFGDate_gBln; ShowMFGDate_gBln) { }
            column(Item_No_; "Item No.")
            { }
            column(PosQcRcpt_gTxt; PosQcRcpt_gTxt) { }
            column(LotNo_gTxt; LotNo_gTxt) { }
            column(Description; ItemDescription) { }
            column(CustomLotNumber; CustomLotNumber) { }
            column(CustomBOENumber; CustomBOENumber) { }
            column(Analysis_date; Format("Analysis Date", 0, '<day,2>-<Month Text>-<year4>')) { }
            // column(Expiration_Date; Format(ExpirationDateG, 0, '<Month,2>/<Day,2>/<year4>')) { }
            column(Expiration_Date; Format(ExpirationDateG, 0, '<Day,2>-<Month Text,3>-<year4>')) { }
            // column(Manufacturing_Date; Format("Manufacturing Date 2", 0, '<Month,2>/<Day,2>/<year4>')) { }
            column(Manufacturing_Date; Format("Manufacturing Date 2", 0, '<Day,2>-<Month Text,3>-<year4>')) { }
            column(Image; CompInfoG.Logo) { }
            column(Compnay_Name; CompInfoG.name) { }
            column(Compy_Address_1; CompInfoG.Address) { }
            column(Compy_Address_2; CompInfoG."Address 2") { }
            column(CompCity; CompInfoG.City) { }
            column(CompCountry; CountryRegionRec.Name) { }

            column(Comp_Tel_No; 'Tel No.: ' + CompInfoG."Phone No.") { }
            column(Comp_TRN; 'TRN: ' + CompInfoG."VAT Registration No.") { }
            column(FooterText; FooterTextG) { }
            column(Company_Image; CompInfoG.Picture) { }

            dataitem("Posted QC Rcpt. Header"; "Posted QC Rcpt. Header")
            {
                DataItemLink = "No." = field("Posted QC No."), "Item No." = field("Item No."), "Variant Code" = field("Variant Code");
                DataItemTableView = sorting("No.");
                // column(Analysis_date; Format("QC Date", 0, '<day,2>-<Month Text>-<year4>')) { } //T13004-N 03-02-2025

                dataitem("Posted QC Rcpt. Line"; "Posted QC Rcpt. Line")
                {
                    DataItemLink = "No." = field("No.");
                    column(Type; Type) { }
                    column(Testing_Parameter; Description) { }  //T52121-U  + UOMDesc_gTxt
                    column(Test_Method; "Method Description") { }
                    column(Result; Result) { }
                    // column(Minmum_gDec; Minmum_gDec) { }
                    // column(Maximum_gDec; Maximum_gDec) { }
                    // column(ActualText_gTxt; ActualText_gTxt) { }
                    column(Notes; Notes) { }
                    column(Minimum; Minmum_gDec) { }
                    column(Maximum; Maximum_gDec) { }
                    column(Value; Text_gTxt) { }
                    column(Actual_Value; ActualText_gTxt) { }
                    //     column(Test_Method; TestingParameterG."Testing Parameter Code") { }
                    column(Sl_No; SlNoG) { }
                    //     column(Priority; ItemTestingParameterG.Priority) { }
                    //     column(Symbol; Symbol) { }
                    //     column(Lot_No_; "Lot No.") { }

                    trigger OnPreDataItem()
                    var
                        myInt: Integer;
                        UnitofMeasure_lRec: Record "Unit of Measure";
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
                                                                                                                  // ActualText_gTxt := Format("Vendor COA Value Result")//T52614-O
                            else
                                ActualText_gTxt := '';
                        end;
                        if Type = Type::Minimum then begin
                            Minmum_gDec := "Min.Value";
                            Maximum_gDec := "Max.Value";
                            if "Vendor COA Value Result" <> 0 then
                                ActualText_gTxt := DecimalPlaces_lFnc("Vendor COA Value Result", "Decimal Places")//T52614-N
                                                                                                                  // ActualText_gTxt := Format("Vendor COA Value Result")//T52614-O
                            else
                                ActualText_gTxt := '';
                        end;
                        if Type = Type::Maximum then begin
                            Minmum_gDec := "Min.Value";
                            Maximum_gDec := "Max.Value";
                            if "Vendor COA Value Result" <> 0 then
                                ActualText_gTxt := DecimalPlaces_lFnc("Vendor COA Value Result", "Decimal Places")//T52614-N
                                                                                                                  // ActualText_gTxt := Format("Vendor COA Value Result")//T52614-O
                            else
                                ActualText_gTxt := '';
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
            }
            // dataitem("Post Lot Var Testing Parameter"; "Post Lot Var Testing Parameter")
            // {
            //     DataItemLink = "Source ID" = field("Document No."), "Source Ref. No." = field("Document Line No."), "Item No." = field("Item No."), "Variant Code" = field("Variant Code"), "Lot No." = field(CustomLotNumber), "BOE No." = field(CustomBOENumber);
            //     DataItemTableView = sorting(Priority) where("Show in COA" = const(true));
            //     // DataItemTableView = sorting(Priority) where("Actual Value" = filter(<> ''));
            //     column(Testing_Parameter; "Testing Parameter") { }
            //     column(Code; Code) { }
            //     column(Minimum; Minimum) { DecimalPlaces = 0 : 5; }
            //     column(Maximum; Maximum) { DecimalPlaces = 0 : 5; }
            //     column(Value; Value2) { }
            //     column(Actual_Value; ItemTestingParameterValue) { }
            //     column(Test_Method; TestingParameterG."Testing Parameter Code") { }
            //     column(Sl_No; SlNoG) { }
            //     column(Priority; ItemTestingParameterG.Priority) { }
            //     column(Symbol; Symbol) { }

            //     trigger OnAfterGetRecord()
            //     var
            //         myInt: Integer;
            //     begin
            //         TestingParameterG.Get(Code);
            //         if not ItemTestingParameterG.Get("Item No.", code) then
            //             if "Testing Parameter" = '' then
            //                 CurrReport.Skip();

            //         // if "Actual Value" = '' then
            //         //     CurrReport.Skip();

            //         if not "Show in COA" then
            //             CurrReport.Skip();

            //         if "Actual Value" <> '' then
            //             ItemTestingParameterValue := "Actual Value"
            //         else
            //             if "Default Value" AND "Show in COA" then
            //                 ItemTestingParameterValue := 'Pass'
            //             else
            //                 if ("Actual Value" = '') AND ("Default Value" = false) then
            //                     CurrReport.Skip();

            //         SlNoG += 1;
            //     end;
            // }
            // dataitem("Company Information"; "Company Information")
            // {
            //     // RequestFilterFields = "No.";
            //     // column(Company_Image; CompInfoG.Picture) { }

            //     // column(FooterText; FooterTextG) { }
            //     // column(Compnay_Name; CompanyName) { }
            //     // column(Compy_Address_1; Address) { }
            //     // column(Compy_Address_2; "Address 2") { }
            //     // column(Comp_Tel_No; 'Tel No.: ' + "Phone No.") { }
            //     // column(Comp_TRN; 'TRN: ' + "VAT Registration No.") { }


            //     trigger OnPreDataItem()
            //     var
            //         myInt: Integer;
            //     begin
            //         // CompInfoG.get();
            //         // CompInfoG.CalcFields(Picture);
            //         // FooterTextG := CompanyName + ', ' + Address + ', ' + "Address 2" + ' Tel:' + "Phone No." + ' Fax:' + "Fax No.";
            //     end;
            // }
            trigger OnAfterGetRecord()
            var
                VariantRec: Record "Item Variant";
            begin
                SlNoG := 0;
                SrNoILE += 1;
                ItemG.Get("Item No.");
                // Clear(SalesShipmentLineG);
                // SalesShipmentLineG.Get("Document No.", "Document Line No.");
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
                Clear(ExpirationDateG);
                if "Expiration Date" > 0D then
                    ExpirationDateG := "Expiration Date"
                else
                    if ("Manufacturing Date 2" > 0D) and (Format("Expiry Period 2") > '') then
                        ExpirationDateG := CalcDate("Expiry Period 2", "Manufacturing Date 2");//, 0, '<Month Text> <year4>');

                LotNo_gInt += 1;

                LotNo_gTxt := Format(SrNoILE) + '.' + Format(LotNo_gInt);
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;

            begin
                SrNoILE := 0;
                // Clear(CompInfoG);
                // if CompanyFilter <> '' then begin
                //     CompInfoG.ChangeCompany(CompanyFilter);
                // end;
                // CompInfoG.get();
                // CompInfoG.CalcFields(Picture, Logo);
                // FooterTextG := CompanyName + ', ' + CompInfoG.Address + ', ' + CompInfoG."Address 2" + ' Tel:' + CompInfoG."Phone No." + ' Fax:' + CompInfoG."Fax No.";
                // CountryRegionRec.Get(CompInfoG."Country/Region Code");
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
                    // TableRelation = Company;//T14179-O
                    TableRelation = "Staging Company Information";//T14179-N
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
        //CompInfoG: Record "Company Information";//T14179-O
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