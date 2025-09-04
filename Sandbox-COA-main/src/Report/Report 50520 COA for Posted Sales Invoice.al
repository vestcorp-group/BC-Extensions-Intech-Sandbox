//T13827-N
report 50520 "COA for Posted Sales Invoice"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'COA for Posted Sales Invoice';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/Layout/COA_SIH.rdl';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(Company_Image; CompInfoG.Logo) { }
            column(Image; CompInfoG.Picture) { }
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

            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLinkReference = "Sales Invoice Header";
                DataItemLink = "Document No." = field("No.");
                // DataItemTableView = where(Type = filter(Item));
                dataitem(Integer; Integer)
                {
                    DataItemTableView = sorting(Number) where(Number = filter(> 0));
                    column(Document_No_; TempItemLedgEntry."Document No.") { }
                    column(Document_Line_No_; TempItemLedgEntry."Document Line No.") { }
                    column(ShowExpiry; ShowExpiry) { }
                    column(ShowMFGDate_gBln; ShowMFGDate_gBln) { }
                    column(HideTestMethod; HideTestMethod)
                    { }
                    column(Item_No_; TempItemLedgEntry."Item No.") { }
                    column(Description; ItemDesc) { }
                    column(SearchDesc; SearchDesc) { }
                    column(CustomLotNumber; TempItemLedgEntry.CustomLotNumber) { }
                    column(LotNoDate_gTxt; LotNoDate_gTxt) { }
                    column(LotNo_gTxt; LotNo_gTxt) { }
                    column(LotNo_gInt; LotNo_gInt) { }
                    column(CustomBOENumber; TempItemLedgEntry.CustomBOENumber) { }
                    column(Lot_No_; TempItemLedgEntry."Lot No.") { }
                    column(Posted_QC_No_; TempItemLedgEntry."Posted QC No.") { }
                    // column(Analysis_date; Format("Analysis Date", 0, '<day,2>-<Month Text>-<year4>')) { } //T13004-O 03-02-2025
                    column(Expiration_Date; Format(ExpirationDateG, 0, '<day,2>-<Month Text,3>-<year4>')) { }
                    column(Manufacturing_Date; Format(TempItemLedgEntry."Manufacturing Date 2", 0, '<day,2>-<Month Text,3>-<year4>')) { }
                    column(SrNoILE; SrNoILE) { }

                    dataitem("Posted QC Rcpt. Header"; "Posted QC Rcpt. Header")
                    {
                        // DataItemLink = "No." = field("Posted QC No."), "Item No." = field("Item No."), "Variant Code" = field("Variant Code");
                        DataItemTableView = sorting("No.");
                        // column(No_; "No.") { }
                        column(Analysis_date; Format("QC Date", 0, '<Day,2>-<Month Text>-<year4>')) { } //T13004-N 03-02-2025
                        dataitem("Posted QC Rcpt. Line"; "Posted QC Rcpt. Line")
                        {
                            DataItemLink = "No." = field("No.");
                            column(Type; Type) { }
                            column(Testing_Parameter; Description) { } //+ UOMDesc_gTxt
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
                                                                                                                          // ActualText_gTxt := Format("Vendor COA Value Result")//T52614-O
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

                                PosQcRcpt_gTxt := Format(SrNoILE) + '.' + Format(LotNo_gInt) + '.' + Format(PosQcRcpt_gInt);

                            end;
                        }

                        trigger OnPreDataItem()
                        var
                            myInt: Integer;
                        begin
                            // DataItemLink = "No." = field("Posted QC No."), "Item No." = field("Item No."), "Variant Code" = field("Variant Code");
                            SetRange("No.", TempItemLedgEntry."Posted QC No.");
                            SetRange("Item No.", TempItemLedgEntry."Item No.");
                            SetRange("Variant Code", TempItemLedgEntry."Variant Code");
                        end;
                    }

                    trigger OnAfterGetRecord()
                    var
                        RecSalesLine: Record "Sales Invoice Line";
                        Item_LRec: Record Item;
                        VariantRec: Record "Item Variant";
                    begin
                        // Clear(SrNoILE);
                        if Number = 1 then
                            TempItemLedgEntry.FindSet()
                        else
                            if TempItemLedgEntry.Next() = 0 then
                                CurrReport.Break();


                        SlNoG := 0;
                        Clear(ItemG);
                        if ItemG.Get(TempItemLedgEntry."Item No.") then;
                        Clear(SalesShipmentLineG);
                        if SalesShipmentLineG.Get(TempItemLedgEntry."Document No.", TempItemLedgEntry."Document Line No.") then;
                        Clear(ExpirationDateG);
                        if TempItemLedgEntry."Expiration Date" > 0D then
                            ExpirationDateG := TempItemLedgEntry."Expiration Date"
                        else
                            if (TempItemLedgEntry."Manufacturing Date 2" > 0D) and (Format(TempItemLedgEntry."Expiry Period 2") > '') then
                                ExpirationDateG := CalcDate(TempItemLedgEntry."Expiry Period 2", TempItemLedgEntry."Manufacturing Date 2");//, 0, '<Month Text> <year4>');

                        Clear(ItemDesc);
                        clear(RecSalesLine);
                        RecSalesLine.SetRange("Document No.", "Sales Invoice Header"."No.");
                        // RecSalesLine.SetRange("Line No.", TempItemLedgEntry."Document Line No.");
                        RecSalesLine.SetRange("No.", TempItemLedgEntry."Item No.");
                        if RecSalesLine.FindFirst() then begin
                            if Strpos(TempItemDesc, RecSalesLine.Description) = 0 then begin
                                LotNo_gInt := 0;
                                TempSl += 1;
                                // ItemDesc := RecSalesLine.Description; //Hypercare-25-03-2025-O
                                SrNoILE := TempSl;
                            end;
                            TempItemDesc += RecSalesLine.Description + '|';
                        end;

                        //Hypercare-25-03-2025-NS
                        ItemDesc := ItemG.Description;
                        if TempItemLedgEntry."Variant Code" <> '' then begin
                            VariantRec.Get(TempItemLedgEntry."Item No.", TempItemLedgEntry."Variant Code");
                            if VariantRec.Description <> '' then begin
                                ItemDesc := VariantRec.Description
                            end else begin
                                ItemDesc := ItemG.Description;
                            end;
                        end;
                        //Hypercare-25-03-2025-NE

                        If Item_LRec.GET(TempItemLedgEntry."Item No.") THEN BEGIN
                            SearchDesc := Item_LRec."Generic Description" + ', ' + Item_LRec."Base Unit of Measure";
                        END;

                        LotNoDate_gTxt := TempItemLedgEntry.CustomLotNumber;

                        LotNo_gInt += 1;

                        LotNo_gTxt := Format(SrNoILE) + '.' + Format(LotNo_gInt);

                        // LotNoDate_gTxt := LotNo_gTxt + ' ' + LotNoDate_gTxt;

                    end;

                    trigger OnPreDataItem()
                    var
                        myInt: Integer;
                    begin
                        // SrNoILE := 0;
                        LotNoDate_gTxt := '';
                        // LotNo_gInt := 0;
                        LotNo_gTxt := '';

                        // TempItemLedgEntry.SetFilter("Posted QC No.", '<> %1', '');
                        if TempItemLedgEntry.IsEmpty() then
                            CurrReport.Break();
                        // Error('Posted QC No. not found in Item Ledger Entries against the Sales Invoice No.: %1', "Sales Invoice Header"."No.");
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    ILE_lRec: Record "Item Ledger Entry";
                    Item_lRec: Record Item;
                    ItemTrackingDocMgt: Codeunit "Item Tracking Doc. Management";
                    ItemTrackingMgt: Codeunit "Item Tracking Management";
                    RowID1: Text[250];
                begin
                    // LotNo_gInt := 0;

                    if Type <> Type::Item then
                        CurrReport.Skip();

                    RowID1 := ItemTrackingMgt.ComposeRowID(DATABASE::"Sales Invoice Line", 0, "Document No.", '', 0, "Line No.");
                    ShowItemTrackingForInvoiceLine(RowID1);
                end;
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
    procedure ShowItemTrackingForInvoiceLine(InvoiceRowID: Text[250])
    var

        ItemTrackDcoMgmt_lCdu: Codeunit "Item Tracking Doc. Management";
    begin
        TempItemLedgEntry.Reset();
        TempItemLedgEntry.DeleteAll();
        ItemTrackDcoMgmt_lCdu.RetrieveEntriesFromPostedInvoice(TempItemLedgEntry, InvoiceRowID);
    end;
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
        CompanyFilter: Text;
        TempItemLedgEntry: Record "Item Ledger Entry" temporary;
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
        SalesShipmentLineG: Record "Sales Invoice Line";
        // CompInfoG: Record "Company Information";//T14179-N
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