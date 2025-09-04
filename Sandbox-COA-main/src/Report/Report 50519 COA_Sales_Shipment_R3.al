report 50519 "COA_Sales_Shipment_R3"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'COA_Shipment';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/Layout/COA.rdl';

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            RequestFilterFields = "No.";
            column(Company_Image; CompInfoG.Logo) { }
            column(Image; CompInfoG.Logo) { }
            column(FooterText; FooterTextG) { }
            column(Compnay_Name; CompInfoG.name) { }//T45559-N
            column(Compy_Address_1; CompInfoG.Address) { }
            column(Compy_Address_2; CompInfoG."Address 2") { }
            column(Comp_Tel_No; 'Tel No.: ' + CompInfoG."Phone No.") { }
            column(Comp_TRN; 'TRN No.: ' + CompInfoG."VAT Registration No.") { }
            column(CompCity; CompInfoG.City) { }
            column(CompCountry; CountryRegionRec.Name) { }
            column(LCNo; "LC No. 2") { }

            column(LCDate; Format("LC Date 2", 0, '<day,2>/<Month,2>/<year4>')) { }
            dataitem(SSL; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("No.") where(Quantity = filter(<> 0));
                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemLink = "Document No." = field("Document No."), "Document Line No." = field("Line No.");
                    DataItemTableView = sorting("Document Line No.") where("Document Type" = filter("Sales Shipment"), Quantity = filter(< 0));
                    column(Document_No_; "Document No.") { }
                    column(Document_Line_No_; "Document Line No.") { }
                    column(ShowExpiry; ShowExpiry) { }
                    column(ShowMFGDate_gBln; ShowMFGDate_gBln) { }
                    column(HideTestMethod; HideTestMethod)
                    { }
                    column(Item_No_; "Item No.") { }
                    column(Description; ItemDesc) { }
                    column(SearchDesc; SearchDesc) { }
                    column(CustomLotNumber; CustomLotNumber) { }
                    column(LotNoDate_gTxt; LotNoDate_gTxt) { }
                    column(LotNo_gTxt; LotNo_gTxt) { }
                    column(LotNo_gInt; LotNo_gInt) { }
                    column(CustomBOENumber; CustomBOENumber) { }
                    column(Lot_No_; "Lot No.") { }
                    column(Posted_QC_No_; "Posted QC No.") { }
                    // column(Analysis_date; Format("Analysis Date", 0, '<day,2>-<Month Text>-<year4>')) { } //T13004-O 03-02-2025
                    // column(Expiration_Date; Format(ExpirationDateG, 0, '<Month,2>/<Day,2>/<year4>')) { }
                    column(Expiration_Date; Format(ExpirationDateG, 0, '<Day,2>-<Month Text,3>-<year4>')) { }
                    // column(Manufacturing_Date; Format("Manufacturing Date 2", 0, '<Month,2>/<Day,2>/<year4>')) { }
                    column(Manufacturing_Date; Format("Manufacturing Date 2", 0, '<Day,2>-<Month Text,3>-<year4>')) { }
                    column(SrNoILE; SrNoILE) { }
                    dataitem("Posted QC Rcpt. Header"; "Posted QC Rcpt. Header")
                    {
                        DataItemLink = "No." = field("Posted QC No."), "Item No." = field("Item No."), "Variant Code" = field("Variant Code");
                        DataItemTableView = sorting("No.");
                        // column(No_; "No.") { }
                        column(Analysis_date; Format("QC Date", 0, '<Day,2>-<Month Text>-<year4>')) { } //T13004-N 03-02-2025

                        dataitem("Posted QC Rcpt. Line"; "Posted QC Rcpt. Line")
                        {
                            DataItemLink = "No." = field("No.");
                            column(Type; Type) { }
                            column(Testing_Parameter; Description) { }   //T52121-U  + UOMDesc_gTxt
                            column(Test_Method; "Method Description") { }
                            column(Result; Result) { }
                            // column(Minmum_gDec; Minmum_gDec) { }
                            // column(Maximum_gDec; Maximum_gDec) { }
                            // column(ActualText_gTxt; ActualText_gTxt) { }
                            column(Minimum; Minmum_gDec) { }
                            column(Maximum; Maximum_gDec) { }
                            column(Value; Text_gTxt) { }
                            column(Actual_Value; ActualText_gTxt) { }
                            column(Notes; Notes) { }
                            column(PosQcRcpt_gTxt; PosQcRcpt_gTxt) { }
                            //     column(Test_Method; TestingParameterG."Testing Parameter Code") { }
                            column(Sl_No; SlNoG) { }
                            //     column(Priority; ItemTestingParameterG.Priority) { }
                            //     column(Symbol; Symbol) { }
                            //     column(Lot_No_; "Lot No.") { }

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
                                    // if "COA Min.Value" <> 0 then
                                    //     Minmum_gDec := "COA Min.Value"
                                    // else
                                    Minmum_gDec := "Min.Value";

                                    // if "COA Max.Value" <> 0 then
                                    //     Maximum_gDec := "COA Max.Value"
                                    // else
                                    Maximum_gDec := "Max.Value";

                                    if "Vendor COA Value Result" <> 0 then
                                        ActualText_gTxt := DecimalPlaces_lFnc("Vendor COA Value Result", "Decimal Places")//T52614-N
                                                                                                                          // ActualText_gTxt := Format("Vendor COA Value Result") //T52614-O
                                    else
                                        ActualText_gTxt := '';
                                end;
                                if Type = Type::Minimum then begin
                                    // if "COA Min.Value" <> 0 then
                                    //     Minmum_gDec := "COA Min.Value"
                                    // else
                                    Minmum_gDec := "Min.Value";

                                    // if "COA Max.Value" <> 0 then
                                    //     Maximum_gDec := "COA Max.Value"
                                    // else
                                    Maximum_gDec := "Max.Value";

                                    if "Vendor COA Value Result" <> 0 then
                                        ActualText_gTxt := DecimalPlaces_lFnc("Vendor COA Value Result", "Decimal Places")//T52614-N
                                                                                                                          // ActualText_gTxt := Format("Vendor COA Value Result") //T52614-O
                                    else
                                        ActualText_gTxt := '';
                                end;
                                if Type = Type::Maximum then begin
                                    // if "COA Min.Value" <> 0 then
                                    //     Minmum_gDec := "COA Min.Value"
                                    // else
                                    Minmum_gDec := "Min.Value";

                                    // if "COA Max.Value" <> 0 then
                                    //     Maximum_gDec := "COA Max.Value"
                                    // else
                                    Maximum_gDec := "Max.Value";

                                    if "Vendor COA Value Result" <> 0 then
                                        ActualText_gTxt := DecimalPlaces_lFnc("Vendor COA Value Result", "Decimal Places")//T52614-N
                                                                                                                          // ActualText_gTxt := Format("Vendor COA Value Result") //T52614-O
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

                                // PosQcRcpt_gTxt := Format(SrNoILE) + '.' + Format(LotNo_gInt) + '.' + Format(PosQcRcpt_gInt);
                                PosQcRcpt_gTxt := Format(SrNoILE) + '.' + Format(LotNoNew_gInt) + '.' + Format(PosQcRcpt_gInt);

                            end;


                        }

                    }
                    trigger OnAfterGetRecord()
                    var
                        RecSalesLine: Record "Sales Shipment Line";
                        Item_LRec: Record Item;
                        VariantRec: Record "Item Variant";
                    begin
                        // Clear(SrNoILE);
                        SlNoG := 0;
                        ItemG.Get("Item No.");
                        Clear(SalesShipmentLineG);
                        SalesShipmentLineG.Get("Document No.", "Document Line No.");
                        Clear(ExpirationDateG);
                        if "Expiration Date" > 0D then
                            ExpirationDateG := "Expiration Date"
                        else
                            if ("Manufacturing Date 2" > 0D) and (Format("Expiry Period 2") > '') then
                                ExpirationDateG := CalcDate("Expiry Period 2", "Manufacturing Date 2");//, 0, '<Month Text> <year4>');

                        Clear(ItemDesc);
                        clear(RecSalesLine);
                        RecSalesLine.SetRange("Document No.", "Sales Shipment Header"."No.");
                        RecSalesLine.SetRange("Line No.", "Item Ledger Entry"."Document Line No.");
                        if RecSalesLine.FindFirst() then begin
                            if Strpos(TempItemDesc, RecSalesLine.Description) = 0 then begin
                                TempSl += 1;
                                LotNo_gInt := 0;
                                LotNoNew_gInt := 0;
                                // ItemDesc := RecSalesLine.Description; //Hypercare-25-03-2025-O
                                SrNoILE := TempSl;
                            end;
                            TempItemDesc += RecSalesLine.Description + '|';
                        end;

                        //Hypercare-25-03-2025-NS
                        ItemDesc := ItemG.Description;
                        if "Variant Code" <> '' then begin
                            VariantRec.Get("Item No.", "Variant Code");
                            if VariantRec.Description <> '' then begin
                                ItemDesc := VariantRec.Description
                            end else begin
                                ItemDesc := ItemG.Description;
                            end;
                        end;
                        //Hypercare-25-03-2025-NE

                        If Item_LRec.GET("Item No.") THEN BEGIN
                            SearchDesc := Item_LRec."Generic Description" + ', ' + Item_LRec."Base Unit of Measure";
                        END;

                        LotNoDate_gTxt := CustomLotNumber;

                        // if "Item Ledger Entry"."Item No." = LotNoNewText_gTxt then begin
                        //     LotNo_gInt += 1;
                        //     LotNoNew_gInt += 1;
                        // end else begin
                        //     LotNo_gInt := 0;
                        //     LotNoNew_gInt := 0;
                        // end;
                        LotNo_gInt += 1;
                        LotNoNew_gInt += 1;

                        // LotNo_gTxt := Format(SrNoILE) + '.' + Format(LotNo_gInt);
                        LotNo_gTxt := Format(SrNoILE) + '.' + Format(LotNoNew_gInt);

                        // LotNoDate_gTxt := LotNo_gTxt + ' ' + LotNoDate_gTxt;
                        LotNoNewText_gTxt := "Item Ledger Entry"."Item No.";

                    end;

                    trigger OnPreDataItem()
                    var
                        myInt: Integer;
                    begin
                        // SrNoILE := 0; //DG-20-03-25-O
                        LotNoDate_gTxt := '';
                        LotNoNewText_gTxt := '';
                        // LotNo_gInt := 0;//DG-20-03-25-O
                        LotNo_gTxt := '';
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    if Type <> Type::Item then
                        CurrReport.Skip();
                end;
            }
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");

                trigger OnPreDataItem()
                var
                    Ile: Record "Item Ledger Entry";
                begin
                    if "QC Created" then
                        DocNo_gCod := "Sales Shipment Line"."Document No."
                    else begin
                        ile.Reset();
                        ile.SetRange("Document No.", "Sales Shipment Header"."No.");
                        ile.SetRange("Item No.", "Sales Shipment Line"."No.");
                        ile.SetFilter("Posted QC No.", '<>%1', '');
                        if Ile.FindFirst() then
                            DocNo_gCod := Ile."Posted QC No.";

                    end;

                end;

                // end;

            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                //DG-OS
                // CompInfoG.get();
                // CompInfoG.CalcFields(Picture);
                // FooterTextG := CompanyName + ', ' + CompInfoG.Address + ', ' + CompInfoG."Address 2" + ' Tel:' + CompInfoG."Phone No." + ' Fax:' + CompInfoG."Fax No.";
                // CountryRegionRec.Get(CompInfoG."Country/Region Code");
                //DG-OE

                /* //DG-NS
                Clear(CompInfoG);
                if CompanyFilter <> '' then begin
                    CompInfoG.ChangeCompany(CompanyFilter);
                end;
                CompInfoG.get();
                CompInfoG.CalcFields(Picture, Logo);
                FooterTextG := CompanyName + ', ' + CompInfoG.Address + ', ' + CompInfoG."Address 2" + ' Tel:' + CompInfoG."Phone No." + ' Fax:' + CompInfoG."Fax No.";
                CountryRegionRec.Get(CompInfoG."Country/Region Code");
                //DG-NE */
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
                field(HideTestMethod; HideTestMethod)
                {
                    ApplicationArea = All;
                    Caption = 'Hide Test Method Column';
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
                // field("Disable Expiration Date"; DisableExpDate_gBln)
                // {
                //     ApplicationArea = All;
                // }
            }
        }
        trigger OnOpenPage()
        begin
            ShowExpiry := false;
            // DisableExpDate_gBln := false;
            ShowMFGDate_gBln := false;
        end;
    }
    labels
    {
        LCNo_Lbl = 'LC No.: ';
        LCDate_Lbl = 'LC Date: ';
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
        LotNoNewText_gTxt: Text;
        LotNoNew_gInt: Integer;
        UOMDesc_gTxt: Text;
        CompanyFilter: Text;
        ShowMFGDate_gBln: Boolean;
        // DisableMFGDate_gBln: Boolean;
        // DisableExpDate_gBln: Boolean;
        LotNoDate_gTxt: Text;
        SearchDesc: Text;
        SrNoILE: Integer;
        LotNo_gInt: Integer;
        PosQcRcpt_gInt: Integer;
        LotNo_gTxt: Text;
        PosQcRcpt_gTxt: Text;
        DocNo_gCod: Code[50];
        Minmum_gDec: Decimal;
        Maximum_gDec: Decimal;
        ActualText_gTxt: Text;
        Text_gTxt: Text;
        TestingParameterG: Record "Testing Parameter";
        ItemTestingParameterG: Record "Item Testing Parameter";
        SalesShipmentLineG: Record "Sales Shipment Line";
        // CompInfoG: Record "Company Information"; //T14179-N
        CompInfoG: Record "Staging Company Information";//T14179-N
        ItemG: Record Item;
        SlNoG: Integer;
        FooterTextG: Text;
        ExpirationDateG: Date;
        ShowExpiry: Boolean;
        CountryRegionRec: Record "Country/Region";
        ItemTestingParameterValue: Text;
        ItemDesc: Text;
        TempItemDesc: Text;
        TempSl: Integer;

        HideTestMethod: Boolean;
}