report 53015 "53010 Posted Delivery Adv Clr."//T12370-Full Comment 53010- 53015 //T13538
{
    //stamp
    DefaultLayout = RDLC;
    RDLCLayout = 'Sales Print Layout/RDL/53010 Posted Delivery Advice Clearance.rdl';
    UsageCategory = Administration;
    // ApplicationArea = all;
    Caption = 'Posted Delivery Adv Clr.';

    dataset
    {
        dataitem(SalesHeader;
        "Sales Invoice Header")
        {
            RequestFilterFields = "No.";

            column(Sell_to_Customer_No_; "Bill-to Customer No.")
            {
            }
            column(Sell_to_Customer_Name; "Bill-to Name")
            {
            }
            column(Sell_to_Address; "Bill-to Address")
            {
            }
            column(Sell_to_Address_2; "Bill-to Address 2")
            {
            }
            column(Sell_to_City; "Bill-to City")
            {
            }
            column(Sell_to_Country_Region_Code; "Bill-to Country/Region Code")
            {
            }
            column(No_; "No.")
            {
            }
            column(DANoCap; DANoCap)
            {
            }
            column(ExporterCodeCap; ExporterCodeCap)
            {
            }
            column(ImporterCodeCap; ImporterCodeCap)
            {
            }
            column(AgentCodeCap; AgentCodeCap)
            {
            }
            column(AgentNameCap; AgentNameCap)
            {
            }
            column(RepCardNoCap;
            RepCardNoCap)
            {
            }
            column(ProductDetailsCap;
            ProductDetailsCap)
            {
            }
            column(TypeCap;
            TypeCap)
            {
            }
            column(QuantityCap;
            QuantityCap)
            {
            }
            column(WeightCap;
            WeightCap)
            {
            }
            column(VolumeCap;
            VolumeCap)
            {
            }
            column(DescriptionofGoodsCap;
            DescriptionofGoodsCap)
            {
            }
            column(ContainerNumbersCap;
            ContainerNumbersCap)
            {
            }
            column(PaymentMethodCap;
            PaymentMethodCap)
            {
            }
            column(CDRCashCap;
            CDRCashCap)
            {
            }
            column(CreditACCap;
            CreditACCap)
            {
            }
            column(FTTCap;
            FTTCap)
            {
            }
            column(StanGCap;
            StanGCap)
            {
            }
            column(AlcoholCap;
            AlcoholCap)
            {
            }
            column(DepositCap;
            DepositCap)
            {
            }
            column(BankGCap;
            BankGCap)
            {
            }
            column(OtherCap;
            OtherCap)
            {
            }
            column(RefACNo;
            RefACNo)
            {
            }
            column(CustomsBillTypeCap;
            CustomsBillTypeCap)
            {
            }
            column(ImportCap;
            ImportCap)
            {
            }
            column(TemporaryExitCap;
            TemporaryExitCap)
            {
            }
            column(ExportCap;
            ExportCap)
            {
            }
            column(ImportforReExportCap;
            ImportforReExportCap)
            {
            }
            column(FreeZoneInternalTransferCap;
            FreeZoneInternalTransferCap)
            {
            }
            column(ForCustomsUseCap;
            ForCustomsUseCap)
            {
            }
            column(DestinationCap;
            DestinationCap)
            {
            }
            column(CarrierAgentCap;
            CarrierAgentCap)
            {
            }
            column(ValueCap;
            ValueCap)
            {
            }
            column(Text001;
            Text001)
            {
            }
            column(Text002;
            Text002)
            {
            }
            column(Text003;
            Text003)
            {
            }
            column(Text004;
            Text004)
            {
            }
            column(Text005;
            Text005)
            {
            }
            column(Text006;
            Text006)
            {
            }
            column(Text007;
            Text007)
            {
            }
            column(DeliveryAdviceHeaderCap;
            DeliveryAdviceHeaderCap)
            {
            }
            column(CDRBankCap;
            CDRBankCap)
            {
            }
            column(Checkbox1;
            Checkbox1)
            {
            }
            column(CountryCode;
            CountryCode)
            {
            }
            column(CompanyInfo_Exporter;
            CompanyInfo."E-Mirsal Code")
            {
            }
            column(CompanyInfo_Picture;
            CompanyInfo.Picture)
            {
            }
            //Stamp
            column(CompanyInfo_Stamp; CompanyInfo.Stamp)
            {

            }
            column(ICStamp; ICCompany.Stamp)
            {

            }
            column(PrintStamp; PrintStamp)
            {

            }
            column(IsIntercompany; IsIntercompany)
            {

            }
            column(PrintFinalDestination; PrintFinalDestination)
            {

            }
            column(Customer_Final_Destination; Customer_Final_Destination)//"Customer Final Destination")
            {

            }
            //Stamp-End
            column(CompanyInfo_Name;
            CompanyInfo.Name)
            {
            }
            column(CompanyInfo_Address;
            CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2;
            CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_City;
            CompanyInfo.City)
            {
            }
            column(CompanyInfo_Phoneno;
            CompanyInfo."Phone No.")
            {
            }
            //column(CompanyInfo_Country; CompanyInfo."Country/Region Code") { }
            column(CompanyInfo_Email;
            CompanyInfo."E-Mail")
            {
            }
            column(Posting_Date1;
            "Posting Date")
            {
            }
            column(Posting_Date;
            format("Posting Date", 0, '<Day,2>-<Month Text>-<year4>'))
            {
            }
            column(Shipping_Agent_Code;
            "Shipping Agent Code")
            {
            }
            column(CountryCode1;
            CountryCode1)
            {
            }
            column(AgentName;
            AgentName)
            {
            }
            column(CompanyInfo_HomePage;
            CompanyInfo."Home Page")
            {
            }
            column(TRNNo; CompanyInfo."VAT Registration No.") { }
            column(Document_Date;
            format("Document Date", 0, '<Day,2>-<Month Text>-<year4>'))
            {
            }
            column(Amount_Including_VAT;
            "Amount Including VAT")
            {
            }
            column(GLSetup;
            "Currency Code")
            {
            }
            column(ImporterCode1;
            ImporterCode1)
            {
            }
            column(Exit_Point;
            "Exit Point")
            {
            }
            column(ImporterCode;
            ImporterCode)
            {
            }
            column(ExitPointDesc;
            ExitPointDesc)
            {
            }
            column(Area1;
            Area1)
            {
            }
            column(Sell_to_Post_Code;
            "Bill-to Post Code")
            {
            }
            column(TransportMethod;
            TransportMethod)
            {
            }
            column(Pagecaption;
            Pagecaption)
            {
            }
            column(ContainerNo;
            ContainerNo)
            {
            }
            trigger OnAfterGetRecord()
            var
                SalesLineRec1: Record "Sales Invoice Line";
                RecCustomer: Record Customer;
                AgentRepRec: Record "Agent Representative";
                ICPartner: Record "IC Partner";
                RecAre: Record "Area";
                CountryRegionL: Record "Country/Region";
                CountryRegionLName: Text[100];
            begin
                //Stamp
                Clear(IsIntercompany);
                Clear(ICCompany);
                Clear(RecCustomer);
                RecCustomer.GET("Sell-to Customer No.");
                If RecCustomer."IC Partner Code" <> '' then begin
                    clear(ICPartner);
                    ICPartner.GET(RecCustomer."IC Partner Code");
                    //if ICPartner."Inbox Type" = ICPartner."Inbox Type"::Database then begin
                    if (ICPartner."Inbox Type" = ICPartner."Inbox Type"::Database) and (ICPartner."Inbox Details" <> '') and (ICPartner."Data Exchange Type" = ICPartner."Data Exchange Type"::Database) then begin//T13716-N
                        if ICPartner."Inbox Details" <> '' then begin
                            ICCompany.ChangeCompany(ICPartner."Inbox Details");
                            ICCompany.GET;
                            ICCompany.CalcFields(Stamp);
                            IsIntercompany := true;
                        end;
                    end;
                end;
                //-end
                if PrintShiptoAddress then begin
                    "Bill-to Address" := "Ship-to Address";
                    "Bill-to Address 2" := "Ship-to Address 2";
                    "Bill-to City" := "Ship-to City";
                    "Bill-to Country/Region Code" := "Ship-to Country/Region Code";
                    "Bill-to Name" := "Ship-to Name";
                    "Bill-to Post Code" := "Ship-to Post Code";

                end;

                //MS-
                if blnClrAddress then begin
                    "Bill-to Address" := "Clearance Ship-to Address";
                    "Bill-to Address 2" := "Clearance Ship-to Address 2";
                    "Bill-to City" := "Clearance Ship-to City";
                    "Bill-to Country/Region Code" := "Clear.Ship-to Country/Reg.Code";
                    "Bill-to Name" := "Clearance Ship-to Name";
                    "Bill-to Post Code" := "Clearance Ship-to Post Code";
                end;
                //MS+


                if ShAgent.Get(SalesHeader."Shipping Agent Code") then AgentName := ShAgent.Name;
                if TransportMethodRec.Get(SalesHeader."Transport Method") then TransportMethod := TransportMethodRec.Description;
                If AreaRec.Get(SalesHeader."Area") then Area1 := AreaRec.Text;
                if "Currency Code" = '' then "Currency Code" := GLSetup."LCY Code";
                if CountryRegion1.Get(SalesHeader."Bill-to Country/Region Code") then CountryCode1 := CountryRegion1.Name;
                if ExitPointRec.Get(SalesHeader."Exit Point") then ExitPointDesc := ExitPointRec.Description;
                if CustomerRec.Get(SalesHeader."Bill-to Customer No.") then ImporterCode1 := CustomerRec."E-Mirsal Code";
                SalesLineRec1.SetRange("Document No.", "No.");
                SalesLineRec1.SetRange(Type, SalesLineRec1.Type::Item); //PSP
                if SalesLineRec1.FindFirst() then
                    repeat
                        If ContainerNo = '' then
                            ContainerNo := SalesLineRec1."Container No. 2"
                        else //if StrPos(ContainerNo, SalesLineRec1."Container No.") = 0 then
                            if SalesLineRec1."Container No. 2" <> '' then ContainerNo := ContainerNo + ',' + SalesLineRec1."Container No. 2";
                    until SalesLineRec1.Next() = 0;

                //31-08-2022-start
                if "Customer Final Destination" <> '' then begin
                    RecAre.Get("Customer Final Destination");
                    Customer_Final_Destination := RecAre."Text";
                end;
                //31-08-2022-end
                //>>SK 10-08-22
                if PrintAgentRepAddress then begin
                    "Bill-to Name" := "Agent Rep. Name";
                    "Bill-to Address" := "Agent Rep. Address";
                    "Bill-to Address 2" := "Agent Rep. Address 2";
                    "Bill-to City" := "Agent Rep. City";
                    "Bill-to Post Code" := "Agent Rep. Post Code";
                    "Bill-to Country/Region Code" := "Agent Rep. Country/Region Code";
                    if CountryRegionL.Get("Agent Rep. Country/Region Code") then
                        CountryRegionLName := CountryRegionL.Name;
                    if CountryRegion1.Get(SalesHeader."Agent Rep. Country/Region Code") then CountryCode1 := CountryRegion1.Name;
                    //AgentRepRec.Reset();
                    //if AgentRepRec.Get("Agent Rep. Code") and (AgentRepRec."Phone No." <> '') then
                    //    "Bill-to Contact No." := 'Tel No.: ' + AgentRepRec."Phone No.";

                end;
                //<<SK 10-08-22

            end;
        }
        dataitem(SalesLine;
        "Sales Invoice Line")
        {
            DataItemLink = "Document No." = FIELD("No.");
#pragma warning disable AL0655 // TODO: - Will removed once it will be removed by base App-30-04-2022
            DataItemLinkReference = SalesHeader;
#pragma warning restore AL0655 // TODO: - Will removed once it will be removed by base App-30-04-2022            //DataItemTableView = SORTING("Document No.", "Line No.") where(type = filter(<> " "));
            DataItemTableView = SORTING("Line No.");

            column(Item_No_;
            "No.")
            {
            }
            column(Description;
            Description)
            {
            }
            //column(Unit_of_Measure_Code; IUOMG.Code)
            column(Unit_of_Measure_Code; ItemUOM)
            {
            }
            column(Quantity;
            "Quantity (Base)" / IUOMG."Qty. per Unit of Measure")
            {
            }
            column(Quantity1; Quantity)
            {
            }
            column(QuantityG; QuantityG)
            { }
            column(Unit_Cost__LCY_;
            "Unit Cost (LCY)")
            {
            }
            column(BOEDescription;
            BOEDescription)
            {
            }
            column(Description_2;
            "Description 2")
            {
            }
            column(LineCountryOfOrigin;
            LineCountryOfOrigin)
            {
            }
            // column(Net_Weight;
            // "Net Weight")
            // {
            // }
            // column(Gross_Weight;
            // "Gross Weight")
            // {
            // }
            column(Net_Weight; NetWeightG)
            {
            }
            column(Gross_Weight; GrossWeightG)
            {
            }
            column(Item_Category_Code;
            "Item Category Code")
            {
            }
            column(ICC;
            ICC)
            {
            }
            column(TariffNo;
            HSNCode)
            {
            }
            column(ItemNo1;
            "Line No.")
            {
            }
            column(HSNCode;
            HSNCode)
            {
            }
            column(UOMVar; PackingText)
            {
            }
            column(CountryOfOrigin;
            CountryOfOrigin1)
            {
            }

            trigger OnAfterGetRecord()
            var
                ItemL: Record Item;
                SalesLineL: Record "Sales Invoice Line";
                SalesLine2L: Record "Sales Invoice Line";
                CountryRegionCodeL: Record "Country/Region";
                UOMRec2: Record "Unit of Measure";
                VariantRec: Record "Item Variant";
                ItemUOMVariant: Record "Item Unit of Measure";
            begin
                if SalesLineMerge then
                    if Quantity = 0 then
                        CurrReport.Skip();

                Clear(CountryOfOrigin1);
                if CountryRegionCodeL.Get(CountryOfOrigin) then CountryOfOrigin1 := CountryRegionCodeL.Name;
                Clear(IUOMG);
                if "Unit of Measure Code" <> '' then
                    IUOMG.Get("No.", "Unit of Measure Code");
                IUOMG.SetCurrentKey("Item No.", "Qty. per Unit of Measure");
                IUOMG.SetRange("Item No.", "No.");

                if "Variant Code" <> '' then begin
                    If IUOMG."Variant Code" = "Variant Code" then begin
                        IUOMG.SetRange("Variant Code", "Variant Code");
                    end else begin
                        IUOMG.SetRange("Variant Code", '');
                    end;
                end else begin
                    if "Unit of Measure Code" <> '' then
                        ItemUOMVariant.Get("No.", "Unit of Measure Code");
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
                        IUOMG.Get("No.", "Unit of Measure Code");
                    IUOMG.SetCurrentKey("Item No.", "Qty. per Unit of Measure");
                    IUOMG.SetRange("Item No.", "No.");

                    if "Variant Code" <> '' then begin
                        If IUOMG."Variant Code" = "Variant Code" then begin
                            IUOMG.SetRange("Variant Code", "Variant Code");
                        end else begin
                            IUOMG.SetRange("Variant Code", '');
                        end;
                    end else begin
                        if "Unit of Measure Code" <> '' then
                            IUOMG.Get("No.", "Unit of Measure Code");
                        if IUOMG."Variant Code" <> '' then begin
                            IUOMG.SetRange("Variant Code", ItemUOMVariant."Variant Code");
                        end else begin
                            IUOMG.SetRange("Variant Code", '');
                        end;
                    end;
                    If IUOMG.FindFirst() then;
                end;
                if CountryOfOrigin1 = '' then
                    if ItemL.Get("No.") then begin
                        if CountryRegionCode.Get(ItemL."Country/Region of Origin Code") then CountryOfOrigin1 := CountryRegionCode.Name;
                    end;
                IF HSNCode = '' then HSNCode := ItemL."Tariff No.";
                if CountryOfOrigin1 = '' then if CountryRegionCodeL.Get(ItemL."Country/Region of Origin Code") then CountryOfOrigin1 := CountryRegionCodeL.Name;
                if ItemCRec.Get(SalesLine."No.") then ICC := ItemCRec."Generic Description";
                if Itm.Get(SalesLine."No.") then TariffNo := Itm."Tariff No.";
                if UOMRec.Get("No.", "Unit of Measure Code") then begin
                    //UOMVar := Format(UOMRec."Net Weight") + ' kg ' + LowerCase("unit of Measure Code");
                end;

                if "Variant Code" <> '' then begin // add by bayas
                    VariantRec.Get("No.", "Variant Code");
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
                GetBOENumber(SalesLine);
                // ItemLedgeEntries.Reset();
                // ItemLedgeEntries.SetRange("Document Type", ItemLedgeEntries."Document Type"::"Sales Invoice");
                // ItemLedgeEntries.SetRange("Document No.", "Document No.");
                // ItemLedgeEntries.SetRange("Document Line No.", "Line No.");
                // //ItemTrackingLines.SetSourceFilter(Database::"Sales Invoice Line", Type, "Document No.", "Line No.", true);
                // if ItemLedgeEntries.FindFirst() then begin
                //     repeat
                //         If BOEDescription = '' then
                //             BOEDescription := ItemLedgeEntries.CustomBOENumber
                //         else
                //             if StrPos(BOEDescription, ItemLedgeEntries.CustomBOENumber) = 0 then
                //                 BOEDescription := BOEDescription + ',' + ItemLedgeEntries.CustomBOENumber;
                //     until ItemLedgeEntries.Next() = 0;
                // end;
                Clear(Quantity);

                if UOMRec2.Get(IUOMG.Code) then;
                if UOMRec2."Decimal Allowed" = false then begin
                    /* if "Variant Code" <> '' then begin // add by bayas
                        VariantRec.Get("No.", "Variant Code");
                        SalesLineL.Get("Document No.", "Line No.");
                        if VariantRec."Packing Description" <> '' then begin
                            Quantity := SalesLineL.Quantity;
                        end else begin
                            Quantity := Round("Quantity (Base)" / IUOMG."Qty. per Unit of Measure", 1, '>')
                        end;
                    end else begin
                        Quantity := Round("Quantity (Base)" / IUOMG."Qty. per Unit of Measure", 1, '>')
                    end; */
                    Quantity := Round("Quantity (Base)" / IUOMG."Qty. per Unit of Measure", 1, '>')
                end else begin
                    /* if "Variant Code" <> '' then begin // add by bayas
                        VariantRec.Get("No.", "Variant Code");
                        SalesLineL.Get("Document No.", "Line No.");
                        if VariantRec."Packing Description" <> '' then begin
                            Quantity := SalesLineL.Quantity;
                        end else begin
                            Quantity := "Quantity (Base)" / IUOMG."Qty. per Unit of Measure";
                        end;
                    end else begin
                        Quantity := "Quantity (Base)" / IUOMG."Qty. per Unit of Measure";
                    end; */
                    Quantity := "Quantity (Base)" / IUOMG."Qty. per Unit of Measure";
                end;

                //Supriya
                Clear(QuantityG);
                Clear(NetWeightG);
                Clear(GrossWeightG);
                Clear(SalesLine2L);
                if not SalesLineMerge then begin
                    SalesLine2L.SetRange("Document No.", "Document No.");
                    SalesLine2L.SetRange("No.", "No.");
                    SalesLine2L.SetRange("Unit of Measure Code", "Unit of Measure Code");
                    SalesLine2L.SetFilter("Quantity (Base)", '>0');
                    //SalesLine2L.SetRange("Unit Price", "Unit Price");
                    if SalesLine2L.FindSet() then
                        repeat
                            NetWeightG += SalesLine2L."Net Weight";
                            GrossWeightG += SalesLine2L."Gross Weight";

                            if UOMRec2."Decimal Allowed" = false then
                                QuantityG += Round(SalesLine2L."Quantity (Base)" / IUOMG."Qty. per Unit of Measure", 1, '>')
                            else
                                QuantityG += SalesLine2L."Quantity (Base)" / IUOMG."Qty. per Unit of Measure";
                        until SalesLine2L.Next() = 0;
                end else begin
                    QuantityG := SalesLine.Quantity;
                    NetWeightG := SalesLine."Net Weight";
                    GrossWeightG := SalesLine."Gross Weight";
                end;

                //psp
                if not SalesLineMerge then begin

                    if "Unit of Measure Code" <> '' then
                        IUOMG.Get("No.", "Unit of Measure Code");
                    SalesLineL.Reset();
                    SalesLineL.SetRange("Document No.", "Document No.");
                    SalesLineL.SetFilter("Line No.", '<%1', "Line No.");
                    SalesLineL.SetRange("Unit of Measure Code", "Unit of Measure Code");
                    // SalesLineL.SetRange("Location Code", "Location Code");
                    //SalesLineL.SetRange("Unit Price", "Unit Price");
                    SalesLineL.SetRange("No.", "No.");

                    if "Variant Code" <> '' then begin
                        If IUOMG."Variant Code" = "Variant Code" then begin
                            IUOMG.SetRange("Variant Code", "Variant Code");
                        end else begin
                            IUOMG.SetRange("Variant Code", '');
                        end;
                    end else begin
                        if "Unit of Measure Code" <> '' then
                            ItemUOMVariant.Get("No.", "Unit of Measure Code");
                        if ItemUOMVariant."Variant Code" <> '' then begin
                            IUOMG.SetRange("Variant Code", ItemUOMVariant."Variant Code");
                        end else begin
                            IUOMG.SetRange("Variant Code", '');
                        end;
                    end;

                    if SalesLineL.FindFirst() then CurrReport.Skip();
                    if "Unit of Measure Code" <> '' then
                        IUOMG.Get("No.", "Unit of Measure Code");
                    SalesLineL.Reset();
                    SalesLineL.SetRange("Document No.", "Document No.");
                    SalesLineL.SetFilter("Line No.", '>%1', "Line No.");
                    SalesLineL.SetRange("No.", "No.");
                    SalesLineL.SetFilter(Quantity, '>0');//sup
                    if "Variant Code" <> '' then begin
                        If IUOMG."Variant Code" = "Variant Code" then begin
                            IUOMG.SetRange("Variant Code", "Variant Code");
                        end else begin
                            IUOMG.SetRange("Variant Code", '');
                        end;
                    end else begin
                        if "Unit of Measure Code" <> '' then
                            ItemUOMVariant.Get("No.", "Unit of Measure Code");
                        if ItemUOMVariant."Variant Code" <> '' then begin
                            IUOMG.SetRange("Variant Code", ItemUOMVariant."Variant Code");
                        end else begin
                            IUOMG.SetRange("Variant Code", '');
                        end;
                    end;

                    if SalesLineL.FindSet() then begin
                        // "Net Weight" := 0;
                        // "Gross Weight" := 0;
                        repeat
                            if ("Unit Price" = SalesLineL."Unit Price") and ("Unit of Measure Code" = SalesLineL."Unit of Measure Code") then begin //and ("Location Code" = SalesLineL."Location Code")

                                if UOMRec2."Decimal Allowed" = false then begin
                                    if "Variant Code" <> '' then begin // add by bayas
                                        VariantRec.Get("No.", "Variant Code");
                                        //SalesLineL.Get("Document No.", "Line No.");
                                        if VariantRec."Packing Description" <> '' then begin
                                            Quantity += Round(SalesLineL."Quantity (Base)" / IUOMG."Qty. per Unit of Measure", 1, '>')
                                        end else begin
                                            Quantity += Round(SalesLineL."Quantity (Base)" / IUOMG."Qty. per Unit of Measure", 1, '>')
                                        end;
                                    end else begin
                                        Quantity += Round(SalesLineL."Quantity (Base)" / IUOMG."Qty. per Unit of Measure", 1, '>')
                                    end;
                                    //Quantity += Round(SalesLineL."Quantity (Base)" / IUOMG."Qty. per Unit of Measure", 1, '>')
                                end else begin
                                    if "Variant Code" <> '' then begin // add by bayas
                                        VariantRec.Get("No.", "Variant Code");
                                        // SalesLineL.Get("Document No.", "Line No.");
                                        if VariantRec."Packing Description" <> '' then begin
                                            Quantity += SalesLineL."Quantity (Base)" / IUOMG."Qty. per Unit of Measure";
                                        end else begin
                                            Quantity += SalesLineL."Quantity (Base)" / IUOMG."Qty. per Unit of Measure";
                                        end;
                                    end else begin
                                        Quantity += SalesLineL."Quantity (Base)" / IUOMG."Qty. per Unit of Measure";
                                    end;
                                    //Quantity += SalesLineL."Quantity (Base)" / IUOMG."Qty. per Unit of Measure";
                                end;

                                "Amount Including VAT" += SalesLineL."Amount Including VAT";
                                Amount += SalesLineL.Amount;
                                // "Net Weight" += SalesLineL."Net Weight";
                                // "Gross Weight" += SalesLineL."Gross Weight";
                                GetBOENumber1(SalesLineL);
                            end;
                        until SalesLineL.Next() = 0;
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
                        Caption = 'SalesLine UnMerge';
                    }
                    field(PrintShiptoAddress; PrintShiptoAddress)
                    {
                        ApplicationArea = all;
                        Caption = 'Print Ship to Address';
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
                    field(PrintFinalDestination; PrintFinalDestination)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Final Destination';
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

    local procedure GetBOENumber(SalesInvoiceLine: Record "Sales Invoice Line")
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
    end;

    local procedure GetBOENumber1(SalesInvoiceLine: Record "Sales Invoice Line")
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
    end;
}
