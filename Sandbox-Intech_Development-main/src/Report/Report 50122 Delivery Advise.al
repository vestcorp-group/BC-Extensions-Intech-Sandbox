report 50122 "Delivery Advise"// T47724-N Delivery Advise (KM/PSI/110951) R_53010 on Posted Sales Invoice
{
    //stamp
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Delivery Advise Clearance.rdl';
    UsageCategory = Administration;
    //ApplicationArea = all;
    Caption = 'Delivery Advise';

    dataset
    {
        dataitem(TransferHeader; "Transfer Header")
        {
            RequestFilterFields = "No.";

            column(Sell_to_Customer_No_; LocationTo.code) { }
            column(Sell_to_Customer_Name; LocationTo.Name) { }
            column(Sell_to_Address; LocationTo.Address) { }
            column(Sell_to_Address_2; LocationTo."Address 2") { }
            column(Sell_to_City; LocationTo.City) { }
            column(Sell_to_Country_Region_Code; LocationTo."Country/Region Code") { }
            column(No_; "No.") { }
            column(LCYCode; GLSetup."LCY Code") { }
            column(DANoCap; DANoCap) { }
            column(ExporterCodeCap; ExporterCodeCap) { }
            column(ImporterCodeCap; ImporterCodeCap) { }
            column(AgentCodeCap; AgentCodeCap) { }
            column(AgentNameCap; AgentNameCap) { }
            column(RepCardNoCap; RepCardNoCap) { }
            column(ProductDetailsCap; ProductDetailsCap) { }
            column(TypeCap; TypeCap) { }
            column(QuantityCap; QuantityCap) { }
            column(WeightCap; WeightCap) { }
            column(VolumeCap; VolumeCap) { }
            column(DescriptionofGoodsCap; DescriptionofGoodsCap) { }
            column(ContainerNumbersCap; ContainerNumbersCap) { }
            column(PaymentMethodCap; PaymentMethodCap) { }
            column(CDRCashCap; CDRCashCap) { }
            column(CreditACCap; CreditACCap) { }
            column(FTTCap; FTTCap) { }
            column(StanGCap; StanGCap) { }
            column(AlcoholCap; AlcoholCap) { }
            column(DepositCap; DepositCap) { }
            column(BankGCap; BankGCap) { }
            column(OtherCap; OtherCap) { }
            column(RefACNo; RefACNo) { }
            column(CustomsBillTypeCap; CustomsBillTypeCap) { }
            column(ImportCap; ImportCap) { }
            column(TemporaryExitCap; TemporaryExitCap) { }
            column(ExportCap; ExportCap) { }
            column(ImportforReExportCap; ImportforReExportCap) { }
            column(FreeZoneInternalTransferCap; FreeZoneInternalTransferCap) { }
            column(ForCustomsUseCap; ForCustomsUseCap) { }
            column(DestinationCap; DestinationCap) { }
            column(CarrierAgentCap; CarrierAgentCap) { }
            column(ValueCap; ValueCap) { }
            column(Text001; Text001) { }
            column(Text002; Text002) { }
            column(Text003; Text003) { }
            column(Text004; Text004) { }
            column(Text005; Text005) { }
            column(Text006; Text006) { }
            column(Text007; Text007) { }
            column(DeliveryAdviceHeaderCap; DeliveryAdviceHeaderCap) { }
            column(CDRBankCap; CDRBankCap) { }
            column(Checkbox1; Checkbox1) { }
            column(CountryCode; CountryCode) { }
            column(CompanyInfo_Exporter; CompanyInfo."E-Mirsal Code") { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            //Stamp
            column(CompanyInfo_Stamp; CompanyInfo.Stamp) { }
            column(ICStamp; ICCompany.Stamp) { }
            column(PrintStamp; PrintStamp) { }
            column(IsIntercompany; IsIntercompany) { }
            column(PrintFinalDestination; PrintFinalDestination) { }
            column(Customer_Final_Destination; Customer_Final_Destination) { }//"Customer Final Destination"){}
            //Stamp-End
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Address; CompanyInfo.Address) { }
            column(CompanyInfo_Address2; CompanyInfo."Address 2") { }
            column(CompanyInfo_City; CompanyInfo.City) { }
            column(CompanyInfo_Phoneno; CompanyInfo."Phone No.") { }
            //column(CompanyInfo_Country; CompanyInfo."Country/Region Code") { }
            column(CompanyInfo_Email; CompanyInfo."E-Mail") { }
            column(Posting_Date1; "Posting Date") { }
            column(Posting_Date; format("Posting Date", 0, '<Day,2>-<Month Text>-<year4>')) { }
            column(Shipping_Agent_Code; "Shipping Agent Code") { }
            column(CountryCode1; CountryCode1) { }
            column(AgentName; AgentName) { }
            column(CompanyInfo_HomePage; CompanyInfo."Home Page") { }
            column(TRNNo; CompanyInfo."VAT Registration No.") { }
            column(Document_Date; format("Posting Date", 0, '<Day,2>-<Month Text>-<year4>')) { }
            column(Amount_Including_VAT; TotalAMt) { }
            column(GLSetup; BOE) { }
            column(ImporterCode1; ImporterCode1) { }
            column(Exit_Point; BOE) { }
            column(ImporterCode; ImporterCode) { }
            column(ExitPointDesc; ExitPointDesc) { }
            column(Area1; Area1) { }
            column(Sell_to_Post_Code; Area1) { }
            column(TransportMethod; TransportMethod) { }
            column(Pagecaption; Pagecaption) { }
            column(ContainerNo; ContainerNo) { }
            column(TransferToAddr; TransferToAddr) { }
            column(FreeZone_gBln; FreeZone_gBln) { }
            trigger OnAfterGetRecord()
            var
                Location_lRec: Record Location;
                CountryRegion_lRec: Record "Country/Region";
                Transferline_lRec: Record "Transfer Line";
            begin
                TransferToAddr := '';
                // PmttermDesc := '';
                if Location_lRec.Get(TransferHeader."Transfer-to Code") then begin
                    if Location_lRec.Name <> '' then
                        TransferToAddr := '<b>' + Location_lRec.Name + '</b>';
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

                    // FreeZone_gBln := (Location_lRec."Free Zone") ? true : false;
                    if Location_lRec."Free Zone" then
                        FreeZone_gBln := true
                    else
                        FreeZone_gBln := false;

                    if TransportMethodRec.Get(TransferHeader."Transport Method") then TransportMethod := TransportMethodRec.Description;
                    if ExitPointRec.Get(TransferHeader."Entry/Exit Point") then ExitPointDesc := ExitPointRec.Description;
                    If AreaRec.Get(TransferHeader."Area") then Area1 := AreaRec.Text;
                end;
                Transferline_lRec.Reset();
                Transferline_lRec.SetRange("Document No.", TransferHeader."No.");
                if Transferline_lRec.FindSet() then
                    repeat
                        TotalAmt += TransferLine_lRec."Unit Price" * TransferLine_lRec.Quantity;//AS-N
                    until Transferline_lRec.next = 0;

            end;
        }
        dataitem(TransferLine; "Transfer Line")
        {
            DataItemLink = "Document No." = FIELD("No.");
            DataItemLinkReference = TransferHeader;
            DataItemTableView = SORTING("Line No.");

            column(Item_No_; "Item No.") { }
            column(Description; Description) { }

            column(Unit_of_Measure_Code; ItemUOM) { }
            column(Quantity; "Quantity (Base)" / IUOMG."Qty. per Unit of Measure") { }
            column(Quantity1; Quantity) { }
            column(QuantityG; QuantityG) { }
            column(Unit_Cost__LCY_; "Unit Volume") { }
            column(BOEDescription; BOEDescription) { }
            column(Description_2; "Description 2") { }
            column(LineCountryOfOrigin; OriginVar) { }

            column(Net_Weight; totalNetWgt) { }
            column(Gross_Weight; TotalGrossWgt) { }
            column(Item_Category_Code; "Item Category Code") { }
            column(ICC; ICC) { }
            column(TariffNo; TariffNo) { }
            column(ItemNo1; "Line No.") { }
            column(HSNCode; HSCodeVar) { }
            column(UOMVar; PackingText) { }
            column(CountryOfOrigin; CountryOfOrigin1) { }

            trigger OnAfterGetRecord()
            var
                ItemUOM_lRec: Record "Item Unit of Measure";
                ItemL: Record Item;
                TransferLineL: Record "Transfer Line";
                TransferLine2L: Record "Transfer Line";
                CountryRegionCodeL: Record "Country/Region";
                UOMRec2: Record "Unit of Measure";
                VariantRec: Record "Item Variant";
                ItemUOMVariant: Record "Item Unit of Measure";
                Item: Record Item;
                Generic: Record KMP_TblGenericName;
                CountryOrRegion: Record "Country/Region";
                RecVariant: Record "Item Variant";
            begin
                if SalesLineMerge then
                    if Quantity = 0 then
                        CurrReport.Skip();
                Clear(GenericNameVar);
                Clear(OriginVar);
                Clear(HSCodeVar);
                Clear(BaseUOMVar);
                if Item.Get(TransferLine."Item No.") then begin
                    if Generic.Get(Item.GenericName) then
                        GenericNameVar := Generic.Description;
                    if CountryOrRegion.Get(Item."Country/Region of Origin Code") then
                        OriginVar := CountryOrRegion.Name;
                    HSCodeVar := Item."Tariff No.";
                    BaseUOMVar := Item."Base Unit of Measure";
                    if TransferLine."Variant Code" <> '' then begin
                        RecVariant.Get(TransferLine."Item No.", TransferLine."Variant Code");
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

                Clear(CountryOfOrigin1);
                if CountryRegionCodeL.Get(Item."Country/Region of Origin Code") then
                    CountryOfOrigin1 := CountryRegionCodeL.Name;
                Clear(IUOMG);
                if "Unit of Measure Code" <> '' then
                    IUOMG.Get("Item No.", "Unit of Measure Code");
                IUOMG.SetCurrentKey("Item No.", "Qty. per Unit of Measure");
                IUOMG.SetRange("Item No.", "Item No.");

                if "Variant Code" <> '' then begin
                    If IUOMG."Variant Code" = "Variant Code" then begin
                        IUOMG.SetRange("Variant Code", "Variant Code");
                    end else begin
                        IUOMG.SetRange("Variant Code", '');
                    end;
                end else begin
                    if "Unit of Measure Code" <> '' then
                        ItemUOMVariant.Get("Item No.", "Unit of Measure Code");
                    if ItemUOMVariant."Variant Code" <> '' then begin
                        IUOMG.SetRange("Variant Code", ItemUOMVariant."Variant Code");
                    end else begin
                        IUOMG.SetRange("Variant Code", '');
                    end;
                end;

                IUOMG.SetRange("Decimal Allowed", false);//20-10-2022
                If NOT IUOMG.FindFirst() then begin
                    Clear(IUOMG);
                    if "Unit of Measure Code" <> '' then
                        IUOMG.Get("Item No.", "Unit of Measure Code");
                    IUOMG.SetCurrentKey("Item No.", "Qty. per Unit of Measure");
                    IUOMG.SetRange("Item No.", "Item No.");

                    if "Variant Code" <> '' then begin
                        If IUOMG."Variant Code" = "Variant Code" then begin
                            IUOMG.SetRange("Variant Code", "Variant Code");
                        end else begin
                            IUOMG.SetRange("Variant Code", '');
                        end;
                    end else begin
                        if "Unit of Measure Code" <> '' then
                            IUOMG.Get("Item No.", "Unit of Measure Code");
                        if IUOMG."Variant Code" <> '' then begin
                            IUOMG.SetRange("Variant Code", ItemUOMVariant."Variant Code");
                        end else begin
                            IUOMG.SetRange("Variant Code", '');
                        end;
                    end;
                    If IUOMG.FindFirst() then;
                end;
                if CountryOfOrigin1 = '' then
                    if ItemL.Get("Item No.") then begin
                        if CountryRegionCode.Get(ItemL."Country/Region of Origin Code") then CountryOfOrigin1 := CountryRegionCode.Name;
                    end;
                IF HSCodeVar = '' then HSCodeVar := ItemL."Tariff No.";
                if CountryOfOrigin1 = '' then if CountryRegionCodeL.Get(ItemL."Country/Region of Origin Code") then CountryOfOrigin1 := CountryRegionCodeL.Name;
                if ItemCRec.Get(TransferLine."Item No.") then ICC := ItemCRec."Generic Description";
                if Itm.Get(TransferLine."Item No.") then TariffNo := Itm."Tariff No.";
                if UOMRec.Get("Item No.", "Unit of Measure Code") then begin
                    //UOMVar := Format(UOMRec."Net Weight") + ' kg ' + LowerCase("unit of Measure Code");
                end;

                if "Variant Code" <> '' then begin // add by bayas
                    VariantRec.Get("Item No.", "Variant Code");
                    if IUOMG.Code <> '' then begin
                        UOMRec2.Get(IUOMG.Code);
                        ItemUOM := UOMRec2.Description;
                    end else begin
                        ItemUOM := IUOMG.Code;
                    end;
                    if VariantRec."Packing Description" <> '' then begin
                        PackingText := VariantRec."Packing Description";
                        //ItemUOM := SalesLine."Unit of Measure Code";
                    end else begin
                        PackingText := ItemCRec."Description 2";
                        //ItemUOM := IUOMG.Code;
                    end;
                end else begin

                    if IUOMG.Code <> '' then begin
                        UOMRec2.Get(IUOMG.Code);
                        ItemUOM := UOMRec2.Description;
                    end else begin
                        ItemUOM := IUOMG.Code;
                    end;
                    PackingText := ItemCRec."Description 2";

                end;
                Clear(BOEDescription);
                //GetBOENumber(TransferShipmentLine);
                GetBOENumber_lFnc(TransferLine);

                Clear(Quantity);

                if UOMRec2.Get(IUOMG.Code) then;
                if UOMRec2."Decimal Allowed" = false then begin
                    Quantity := Round("Quantity (Base)" / IUOMG."Qty. per Unit of Measure", 1, '>')
                end else begin
                    Quantity := "Quantity (Base)" / IUOMG."Qty. per Unit of Measure";
                end;

                //Supriya
                Clear(QuantityG);
                Clear(NetWeightG);
                Clear(PackingWgt);
                Clear(GrossWeightG);
                Clear(totalNetWgt);
                Clear(TotalGrossWgt);
                Clear(TransferLine2L);

                if not SalesLineMerge then begin
                    TransferLine2L.SetRange("Document No.", "Document No.");
                    TransferLine2L.SetRange("Item No.", "Item No.");
                    TransferLine2L.SetRange("Unit of Measure Code", "Unit of Measure Code");
                    TransferLine2L.SetFilter("Quantity (Base)", '>0');
                    if TransferLine2L.FindSet() then
                        repeat
                            // NetWeightG += TransferLine2L."Net Weight";
                            // GrossWeightG += TransferLine2L."Gross Weight";

                            if UOMRec2."Decimal Allowed" = false then
                                QuantityG += Round(TransferLine2L."Quantity (Base)" / IUOMG."Qty. per Unit of Measure", 1, '>')
                            else
                                QuantityG += TransferLine2L."Quantity (Base)" / IUOMG."Qty. per Unit of Measure";
                        until TransferLine2L.Next() = 0;
                end else begin
                    QuantityG := TransferLine.Quantity;
                    // NetWeightG := TransferLine."Net Weight";
                    // GrossWeightG := TransferLine."Gross Weight";

                end;
                Item.Reset();
                Item.SetRange("No.", TransferLine."Item No.");
                if Item.FindFirst() then begin
                    ItemUOM_lRec.Reset();
                    ItemUOM_lRec.SetRange(Code, TransferLine."Unit of Measure Code");
                    ItemUOM_lRec.SetRange("Item No.", Item."No.");
                    if ItemUOM_lRec.FindSet() then
                        repeat
                            NetWeightG += ItemUOM_lRec."Net Weight";
                            PackingWgt += ItemUOM_lRec."Packing Weight";
                        until ItemUOM_lRec.Next = 0;
                    GrossWeightG := NetWeightG + PackingWgt
                end;
                totalNetWgt := NetWeightG * TransferLine.Quantity;
                TotalGrossWgt := GrossWeightG * TransferLine.Quantity;



                //psp
                if not SalesLineMerge then begin

                    if "Unit of Measure Code" <> '' then
                        IUOMG.Get("Item No.", "Unit of Measure Code");
                    TransferLineL.Reset();
                    TransferLineL.SetRange("Document No.", "Document No.");
                    TransferLineL.SetFilter("Line No.", '<%1', "Line No.");
                    TransferLineL.SetRange("Unit of Measure Code", "Unit of Measure Code");
                    TransferLineL.SetRange("Item No.", "Item No.");

                    if "Variant Code" <> '' then begin
                        If IUOMG."Variant Code" = "Variant Code" then begin
                            IUOMG.SetRange("Variant Code", "Variant Code");
                        end else begin
                            IUOMG.SetRange("Variant Code", '');
                        end;
                    end else begin
                        if "Unit of Measure Code" <> '' then
                            ItemUOMVariant.Get("Item No.", "Unit of Measure Code");
                        if ItemUOMVariant."Variant Code" <> '' then begin
                            IUOMG.SetRange("Variant Code", ItemUOMVariant."Variant Code");
                        end else begin
                            IUOMG.SetRange("Variant Code", '');
                        end;
                    end;

                    if TransferLineL.FindFirst() then
                        CurrReport.Skip();
                    if "Unit of Measure Code" <> '' then
                        IUOMG.Get("Item No.", "Unit of Measure Code");
                    TransferLineL.Reset();
                    TransferLineL.SetRange("Document No.", "Document No.");
                    TransferLineL.SetFilter("Line No.", '>%1', "Line No.");
                    TransferLineL.SetRange("Item No.", "Item No.");
                    TransferLineL.SetFilter(Quantity, '>0');//sup
                    if "Variant Code" <> '' then begin
                        If IUOMG."Variant Code" = "Variant Code" then begin
                            IUOMG.SetRange("Variant Code", "Variant Code");
                        end else begin
                            IUOMG.SetRange("Variant Code", '');
                        end;
                    end else begin
                        if "Unit of Measure Code" <> '' then
                            ItemUOMVariant.Get("Item No.", "Unit of Measure Code");
                        if ItemUOMVariant."Variant Code" <> '' then begin
                            IUOMG.SetRange("Variant Code", ItemUOMVariant."Variant Code");
                        end else begin
                            IUOMG.SetRange("Variant Code", '');
                        end;
                    end;

                    if TransferLineL.FindSet() then begin
                        // "Net Weight" := 0;
                        // "Gross Weight" := 0;
                        repeat
                            if ("Unit of Measure Code" = TransferLineL."Unit of Measure Code") then begin //and ("Location Code" = SalesLineL."Location Code")
                                                                                                          // if ("Unit Price" = SalesLineL."Unit Price") and ("Unit of Measure Code" = SalesLineL."Unit of Measure Code") then begin 
                                if UOMRec2."Decimal Allowed" = false then begin
                                    if "Variant Code" <> '' then begin // add by bayas
                                        VariantRec.Get("Item No.", "Variant Code");
                                        //SalesLineL.Get("Document No.", "Line No.");
                                        if VariantRec."Packing Description" <> '' then begin
                                            Quantity += Round(TransferLineL."Quantity (Base)" / IUOMG."Qty. per Unit of Measure", 1, '>')
                                        end else begin
                                            Quantity += Round(TransferLineL."Quantity (Base)" / IUOMG."Qty. per Unit of Measure", 1, '>')
                                        end;
                                    end else begin
                                        Quantity += Round(TransferLineL."Quantity (Base)" / IUOMG."Qty. per Unit of Measure", 1, '>')
                                    end;
                                    //Quantity += Round(SalesLineL."Quantity (Base)" / IUOMG."Qty. per Unit of Measure", 1, '>')
                                end else begin
                                    if "Variant Code" <> '' then begin // add by bayas
                                        VariantRec.Get("Item No.", "Variant Code");
                                        // SalesLineL.Get("Document No.", "Line No.");
                                        if VariantRec."Packing Description" <> '' then begin
                                            Quantity += TransferLineL."Quantity (Base)" / IUOMG."Qty. per Unit of Measure";
                                        end else begin
                                            Quantity += TransferLineL."Quantity (Base)" / IUOMG."Qty. per Unit of Measure";
                                        end;
                                    end else begin
                                        Quantity += TransferLineL."Quantity (Base)" / IUOMG."Qty. per Unit of Measure";
                                    end;

                                end;

                                // "Amount Including VAT" += SalesLineL."Amount Including VAT";
                                // Amount += SalesLineL.Amount;

                                // GetBOENumber1(SalesLineL);
                                GetBOENumber_lFnc(TransferLine);
                            end;
                        until TransferLineL.Next() = 0;
                    end;
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
                group(Options)
                {
                    field("SalesLine Merge"; SalesLineMerge)
                    {
                        ApplicationArea = All;
                        Caption = 'Line UnMerge';
                    }
                    field(PrintStamp; PrintStamp)
                    {
                        ApplicationArea = all;
                        Caption = 'Print Digital Stamp';
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    labels
    {

        Tel_Lbl = 'Tel:';
        Web_Lbl = 'Web:';
        TRN_Lbl = 'TRN:';
    }
    trigger OnInitReport()
    begin
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture, Stamp);
        GLSetup.Get();
        if CountryRegion.Get(CompanyInfo."Country/Region Code") then CountryCode := CountryRegion.Name;
        // if CountryRegion.Get(CompanyInfo."Country/Region Code") then CompanyInfo_Country := CountryRegion.Name;
    end;

    var
        totalNetWgt: Decimal;
        TotalGrossWgt: Decimal;
        TotalAMt: Decimal;
        CountryOfOrigin1: Text[50];
        CountryCode5: Text[50];
        SalesLineRec: Record "Sales Invoice Line";
        ImporterCode1: Text[30];
        ExitPointDesc: Text[100];
        ExitPointRec: Record "Entry/Exit Point";
        ContainerNo1: Text[30];
        CountryRegion1: Record "Country/Region";
        UOM1: Text[50];
        TransportMethodRec: Record "Transport Method";
        AreaRec: Record "Area";
        TransportMethod: Text[50];
        UOMRec: Record 5404;
        UOMVar: Text[100];
        PackingText: Text[150];
        ItemUOM: Text[50];
        Area1: Text[50];
        ExporterCode: Text[50];
        ImporterCode: Text[50];
        CustomerRec: Record Customer;
        GLSetup: Record "General Ledger Setup";
        CountryRegionCode: Record "Country/Region";
        BOE: Code[20];
        BOEDescription: Text;
        ItemTrackingLines: Record 337;
        ShAgent: Record "Shipping Agent";
        AgentName: Text[100];
        Itm: Record Item;
        TariffNo: Code[20];
        ItemCRec: Record Item;
        ICC: Text[100];
        DANoCap: Label 'D.A.No.:';
        ExporterCodeCap: Label 'Exporter Code:';
        ImporterCodeCap: Label 'Importer Code:';
        AgentNameCap: Label 'Agent Name:';
        AgentCodeCap: Label 'Agent Code:';
        RepCardNoCap: Label 'Rep.Card No.:';
        ProductDetailsCap: Label 'Product Details';
        TypeCap: Label 'Type';
        QuantityCap: Label 'Quantity';
        WeightCap: Label 'Weight  (KG)';
        ContainerNo: Text;
        VolumeCap: Label 'Volume (CBM)';
        DescriptionofGoodsCap: Label 'Description of Goods';
        ContainerNumbersCap: Label 'Container Numbers';
        PaymentMethodCap: Label 'Payment Method (Mark where appropriate)';
        CDRCashCap: Label 'CDR Cash';
        CreditACCap: Label 'Credit A/C*';
        FTTCap: Label 'F T T';
        CDRBankCap: Label 'CDR Bank';
        StanGCap: Label 'Stan G. *';
        AlcoholCap: Label 'Alcohol';
        DepositCap: Label 'Deposit';
        BankGCap: Label 'Bank G. *';
        OtherCap: Label 'Other';
        RefACNo: Label 'Ref. A/C No. *';
        CustomsBillTypeCap: Label 'Customs Bill Type (Mark where appropriate)';
        ImportCap: Label 'Import';
        TemporaryExitCap: Label 'Temporary Exit';
        ExportCap: Label 'Export';
        ImportforReExportCap: Label 'Import for Re-Export';
        FreeZoneInternalTransferCap: Label 'FreeZone Internal Transfer';
        ForCustomsUseCap: Label 'For Customs Use';
        ExitPointCap: Label 'Exit Point:';
        DestinationCap: Label 'Destination:';
        CarrierAgentCap: Label 'Carrier Agent:';
        ValueCap: Label 'Value:';
        Text001: Label 'I/We declare the details given herein to be true & complete';
        Text002: Label '* License Agent Stamp & Signature';
        Text003: Label '* Importers Stamp & Signature';
        Text004: Label '* Applicable only in case of Imports';
        Text005: Label 'The Director,';
        Text006: Label 'Dept. of Ports & Customs';
        Text007: Label 'Please authorise release of the below mentioned goods from our warehouse to:';
        DeliveryAdviceHeaderCap: Label 'DELIVERY ADVICE';
        Checkbox1: Boolean;
        IUOMG: Record "Item Unit of Measure";
        CompanyInfo: Record "Company Information";
        ICCompany: Record "Company Information";
        IsIntercompany: Boolean;
        CountryRegion: Record "Country/Region";
        CountryCode: Text[50];
        //CompanyInfo_Country: Text[100];
        CountryCode1: Text[50];
        Pagecaption: Label 'Page ';
        SalesLineMerge: Boolean;
        PrintShiptoAddress: Boolean;
        blnClrAddress: Boolean;
        PrintStamp: Boolean;
        PrintAgentRepAddress: Boolean;
        PrintFinalDestination: Boolean;
        Customer_Final_Destination: Text;
        QuantityG: Decimal;
        NetWeightG: Decimal;
        GrossWeightG: Decimal;
        PackingWgt: Decimal;

        LocationTo: Record Location;
        OriginVar: Text;
        HSCodeVar: Text;
        BaseUOMVar: Text;
        GenericNameVar: Text;
        TransferToAddr: Text;
        FreeZone_gBln: Boolean;


    /*  local procedure GetBOENumber(SalesInvoiceLine: Record "Sales Invoice Line") //azad
     var
         ValueEntryRelation: Record "Value Entry Relation";
         SignFactor: Integer;
         ValueEntry: Record "Value Entry";
         ItemLedgEntry: Record "Item Ledger Entry";
     begin
         ValueEntryRelation.SETCURRENTKEY("Source RowId");
         ValueEntryRelation.SETRANGE("Source RowId", SalesInvoiceLine.RowID1());
         IF ValueEntryRelation.FIND('-') THEN BEGIN
             //SignFactor := TableSignFactor2(InvoiceRowID);
             REPEAT
                 ValueEntry.GET(ValueEntryRelation."Value Entry No.");
                 IF ValueEntry."Item Ledger Entry Type" IN [ValueEntry."Item Ledger Entry Type"::Purchase, ValueEntry."Item Ledger Entry Type"::Sale] THEN BEGIN
                     ItemLedgEntry.GET(ValueEntry."Item Ledger Entry No.");
                     If BOEDescription = '' then
                         BOEDescription := ItemLedgEntry.CustomBOENumber
                     else
                         if StrPos(BOEDescription, ItemLedgEntry.CustomBOENumber) = 0 then BOEDescription := BOEDescription + ',' + ItemLedgEntry.CustomBOENumber;
                     // TempItemLedgEntry := ItemLedgEntry;
                     // TempItemLedgEntry.Quantity := ValueEntry."Invoiced Quantity";
                     // IF TempItemLedgEntry.Quantity <> 0 THEN
                     //     AddTempRecordToSet(TempItemLedgEntry, SignFactor);
                 END;
             UNTIL ValueEntryRelation.NEXT = 0;
         END;
     end; */

    /* local procedure GetBOENumber1(SalesInvoiceLine: Record "Sales Invoice Line") azad
    var
        ValueEntryRelation: Record "Value Entry Relation";
        SignFactor: Integer;
        ValueEntry: Record "Value Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
    begin
        ValueEntryRelation.SETCURRENTKEY("Source RowId");
        ValueEntryRelation.SETRANGE("Source RowId", SalesInvoiceLine.RowID1());
        IF ValueEntryRelation.FIND('-') THEN BEGIN
            //SignFactor := TableSignFactor2(InvoiceRowID);
            REPEAT
                ValueEntry.GET(ValueEntryRelation."Value Entry No.");
                IF ValueEntry."Item Ledger Entry Type" IN [ValueEntry."Item Ledger Entry Type"::Purchase, ValueEntry."Item Ledger Entry Type"::Sale] THEN BEGIN
                    ItemLedgEntry.GET(ValueEntry."Item Ledger Entry No.");
                    If BOEDescription = '' then
                        BOEDescription := ItemLedgEntry.CustomBOENumber
                    else
                        if StrPos(BOEDescription, ItemLedgEntry.CustomBOENumber) = 0 then BOEDescription := BOEDescription + ',' + ItemLedgEntry.CustomBOENumber;
                    // TempItemLedgEntry := ItemLedgEntry;
                    // TempItemLedgEntry.Quantity := ValueEntry."Invoiced Quantity";
                    // IF TempItemLedgEntry.Quantity <> 0 THEN
                    //     AddTempRecordToSet(TempItemLedgEntry, SignFactor);
                END;
            UNTIL ValueEntryRelation.NEXT = 0;
        END;
    end; */
    local procedure GetBOENumber_lFnc(TransferShipmentLine: Record "Transfer Line")
    var
        ItemLdgrEntry_lRec: Record "Item Ledger Entry";
        LoopVar_lTxt: text;
    begin
        Clear(LoopVar_lTxt);
        ItemLdgrEntry_lRec.Reset;
        ItemLdgrEntry_lRec.SetRange("Document Type", ItemLdgrEntry_lRec."document type"::"Transfer Receipt");
        ItemLdgrEntry_lRec.SetRange("Document No.", TransferShipmentLine."Document No.");
        ItemLdgrEntry_lRec.SetRange("Document Line No.", TransferShipmentLine."Line No.");
        IF ItemLdgrEntry_lRec.FIND('-') THEN BEGIN
            REPEAT
                if ItemLdgrEntry_lRec.CustomBOENumber <> LoopVar_lTxt then begin
                    If BOEDescription = '' then
                        BOEDescription := ItemLdgrEntry_lRec.CustomBOENumber
                    else
                        if StrPos(BOEDescription, ItemLdgrEntry_lRec.CustomBOENumber) = 0 then BOEDescription := BOEDescription + ',' + ItemLdgrEntry_lRec.CustomBOENumber;
                    LoopVar_lTxt := ItemLdgrEntry_lRec.CustomBOENumber;
                end;
            UNTIL ItemLdgrEntry_lRec.NEXT = 0;
        END;
    end;
}
