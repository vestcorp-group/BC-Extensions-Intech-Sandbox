Report 53009 "Packing List_New"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PackingList_New.rdl';
    Caption = 'Packing List';
    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            RequestFilterFields = "No.";
            column(CompInfo_gRec_picture; CompInfo_gRec.Picture) { }
            column(Comp_Logo; CompInfo_gRec.Picture)
            {
            }
            column(CompInfo_gRec_Logo; CompInfo_gRec.Logo) { }
            column(CompanyAddr_gTxt; CompanyAddr_gTxt) { }
            column(DO_No; "No.") { }
            column(No_TH; "No.") { }
            column(PrintStamp; PrintStamp)
            {

            }
            column(CompanyInfo_Stamp; CompInfo_gRec.Stamp)
            {

            }
            column(Posting_Date; Format("Posting Date", 0, '<Day,2>-<Month Text,3>-<year4>')) { }
            column(PostingDate_TH; Format("Posting Date", 0, '<Day,2>-<Month Text,3>-<year4>')) { }
            column(WarehouseAddr_gTxt; WarehouseAddr_gTxt) { }
            column(CustomerAddr_gTxt; CustomerAddr_gTxt) { }
            column(Reference_Invoice_No; Reference_Invoice_No) { }
            column(SalesInvoiceDate_gDte; SalesInvoiceDate_gDte) { }
            column(Order_No; "Order No.") { }
            column(Logist_Cordinator_Info; Logist_Cordinator_Info) { }
            column(AuthRep_gTxt; AuthRep_gTxt) { }
            column(Origitext; Origitext) { }
            column(RecParty_gTxt; RecParty_gTxt) { }
            column(QAManager_gTxt; QAManager_gTxt) { }
            column(QAManagerMo_gTxt; QAManagerMo_gTxt) { }
            column(ShipInst_gTxt; ShipInst_gTxt) { }
            column(Shipdate_gDte; Format(Shipdate_gDte)) { }
            column(CustAddrShipto_Arr1; CustAddrShipto_Arr[1]) { }
            column(CustAddrShipto_Arr2; CustAddrShipto_Arr[2]) { }
            column(CustAddrShipto_Arr3; CustAddrShipto_Arr[3]) { }
            column(CustAddrShipto_Arr4; CustAddrShipto_Arr[4]) { }
            column(CustAddrShipto_Arr5; CustAddrShipto_Arr[5]) { }
            column(CustAddrShipto_Arr6; CustAddrShipto_Arr[6]) { }
            column(CustAddrShipto_Arr7; CustAddrShipto_Arr[7]) { }
            column(CustAddrShipto_Arr8; CustAddrShipto_Arr[8]) { }
            column(CustAddr_Arr1; CustAddr_Arr[1]) { }
            column(CustAddr_Arr2; CustAddr_Arr[2]) { }
            column(CustAddr_Arr3; CustAddr_Arr[3]) { }
            column(CustAddr_Arr4; CustAddr_Arr[4]) { }
            column(CustAddr_Arr5; CustAddr_Arr[5]) { }
            column(CustAddr_Arr6; CustAddr_Arr[6]) { }
            column(CustAddr_Arr7; CustAddr_Arr[7]) { }
            column(CustAddr_Arr8; CustAddr_Arr[8]) { }
            column(CustAddr_Arr9; CustAddr_Arr[9]) { }
            column(CustAddr_Arr10; CustAddr_Arr[10]) { }
            column(CompName; CompInfo_gRec.Name) { }
            column(CompAddr1; CompInfo_gRec.Address) { }
            column(CompAddr2; CompInfo_gRec."Address 2") { }
            column(CompanyInformation_City; CompInfo_gRec.City) { }
            column(CompCountry; CountryRegionRec.Name) { }
            column(countryDesc; CompInfo_gRec."Country/Region Code")
            { }
            column(Telephone; CompInfo_gRec."Phone No.") { }
            column(Web; CompInfo_gRec."Home Page") { }
            column(TRNNo; CompInfo_gRec."VAT Registration No.") { }

            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Sales Shipment Header";
                DataItemTableView = where(Type = filter(Type::Item));
                column(SrNo; SrNo) { }
                column(CompInfo_gRec_Pic; CompInfo_gRec.Logo) { }
                column(Document_No_; "Document No.") { }
                column(LineNo; "Line No.") { }
                column(Quantity; Quantity) { }
                column(UnitofMeasureCode; Uomdescription_gTxt) { }
                column(Item_No; "No.") { }
                column(ItemNo_TL; "No.") { }
                column(Description; Description) { }
                column(BOENo_gTxt; BOENo_gTxt) { }
                column(LotNo_gTxt; LotNo_gTxt) { }
                column(NetWeight_gDec; NetWeight_gDec) { }
                column(GrossWeight_gDec; GrossWeight_gDec) { }

                column(totalgrossWeigh_gDec; totalgrossWeigh_gDec) { }
                column(totalnetWeigh_gDec; totalnetWeigh_gDec) { }


                column(PrimPackQty_gDec; PrimPackQty_gDec) { }
                column(PrimPackUOM_gTxt; PrimPackUOM_gTxt) { }
                column(ILEPrimPack_gTxt; ILEPrimPack_gTxt) { }
                column(SecondaryPackQty_gDec; SecondaryPackQty_gDec) { }
                column(SecPackUOM_gTxt; SecPackUOM_gTxt) { }
                column(SecPackQty_gDec; SecPackQty_gDec) { }
                column(Desc_gTxt; Desc_gTxt) { }
                column(ILEGrosswt_gDec; ILEGrosswt_gDec) { }
                column(ILENetwt_gDec; ILENetwt_gDec) { }
                column(ILESecondaryPackQty_gDec; ILESecondaryPackQty_gDec) { }
                column(ILESecondaryPack_gTxt; ILESecondaryPack_gTxt) { }
                column(ILEPrimPackUOM_gTxt; ILEPrimPackUOM_gTxt) { }
                column(ILENetwt_gTxt; ILENetwt_gTxt) { }
                column(ILEGrosswt_gTxt; ILEGrosswt_gTxt) { }
                column(HSCode; HSCodeVar) { }
                column(Origin; OriginVar) { }
                column(Generic_Name; GenericNameVar) { }
                column(Packing; Packing_Txt) { }
                column(SalesExtenalNo_gCod; SalesExtenalNo_gCod) { }
                column(SalesLcNo_gTxt; SalesLcNo_gTxt) { }
                column(SalesLcDate_gDte; SalesLcDate_gDte) { }
                column(PINONew; PINONew) { }
                column(PIDateNew; PIDateNew) { }
                trigger OnPreDataItem()
                begin
                    SrNo := 0;
                end;

                trigger OnAfterGetRecord()
                var
                    ILE_lRec: Record "Item Ledger Entry";
                    Item_lRec: Record Item;
                    IMCO_lRec: Record "IMCO Class Master";
                    ItemVar_lRec: Record "Item Variant";
                    UOMmaster_lRec: Record "Unit of Measure";
                    ILENetwt_lTxt: Text;
                    ILEGrosswt_lTxt: Text;
                    ILEPrimPack_lTxt: Text;
                    Item: Record Item;
                    VariantRec: Record "Item Variant";
                    Generic: Record KMP_TblGenericName;
                    CountryOrRegion: Record "Country/Region";
                    UnitofMeasure_lRec: Record "Unit of Measure";
                    RecVariant: Record "Item Variant";
                    CountryRegionL: Record "Country/Region";
                    SalesInvoice_lRec: Record "Sales Invoice Line";
                    SalesHeader_lRec: Record "Sales Header";
                    salesHeaderArchive: Record "Sales Header Archive";
                    ItemUnitofmeasure_lRec: Record "Item Unit of Measure";
                    ItemLotFilter_lTxt: Text;
                    PackagingLines_lRec: Record "Packaging detail Line";
                    SalesShipline_lRec: Record "Sales Shipment Line";
                    PrimaryLevel_lInt: Integer;
                    PrimaryUOM_lCode: Code[20];
                begin
                    Clear(GenericNameVar);
                    Clear(OriginVar);
                    Clear(HSCodeVar);
                    Clear(BaseUOMVar);
                    clear(Desc_gTxt);
                    clear(BOENo_gTxt);
                    clear(LotNo_gTxt);
                    clear(Uomdescription_gTxt);
                    //T13802-NS
                    Clear(ILESecondaryPack_gTxt);
                    Clear(ILEGrosswt_gTxt);
                    Clear(ILENetwt_gTxt);
                    Clear(ItemLotFilter_lTxt);
                    // Clear(totalgrossWeigh_gDec);
                    // Clear(totalnetWeigh_gDec);
                    //T13802-NE
                    // clear(SaleInvoiceNo_gCod);
                    // clear(SalesInvoiceDate_gDte);
                    SrNo := SrNo + 1;
                    CountryRegRec.Reset();
                    //if CountryRegRec.Get("Sales Shipment Line".LineCountryOfOrigin) then
                    Origitext := CountryRegRec.Name;
                    NetWeight_gDec := "Sales Shipment Line"."Net Weight";
                    GrossWeight_gDec := "Sales Shipment Line"."Gross Weight";
                    PrimPackUOM_gTxt := "Sales Shipment Line"."Unit of Measure";
                    SecondaryPackQty_gDec := "Sales Shipment Line".Quantity;

                    SalesShipline_lRec.Reset();
                    SalesShipline_lRec.SetRange("Document No.", "Sales Shipment Header"."No.");
                    // SalesShipline_lRec.SetRange("Line No.", "Sales Shipment Line"."Line No.");
                    if SalesShipline_lRec.FindSet() then
                        repeat
                            if SalesShipline_lRec.Quantity > 0 then begin
                                totalnetWeigh_gDec += SalesShipline_lRec."Net Weight";
                                totalgrossWeigh_gDec += SalesShipline_lRec."Gross Weight";
                            end;
                        until SalesShipline_lRec.Next = 0;


                    ILE_lRec.Reset();
                    // ILE_lRec.SetRange("Item No.", "Sales Shipment Line"."No.");
                    ILE_lRec.SetRange("Document No.", "Sales Shipment Header"."No.");
                    ILE_lRec.SetRange("Document Line No.", "Sales Shipment Line"."Line No.");
                    if ILE_lRec.Findset() THEN begin
                        repeat
                            ILENetwt_gDec := ILE_lRec."Net Weight 2";
                            ILEGrosswt_gDec := ILE_lRec."Gross Weight 2";
                            ILESecondaryPackQty_gDec := ILE_lRec.Quantity / ILE_lRec."Qty. per Unit of Measure";
                            if BOENo_gTxt = '' then
                                BOENo_gTxt := ILE_lRec.CustomBOENumber
                            else
                                BOENo_gTxt += '<br/>' + ILE_lRec.CustomBOENumber;
                            if LotNo_gTxt = '' then
                                LotNo_gTxt := ILE_lRec.CustomLotNumber
                            else
                                LotNo_gTxt += '<br/>' + ILE_lRec.CustomLotNumber;

                            if ILENetwt_gTxt = '' then
                                ILENetwt_gTxt := Format(ILE_lRec."Net Weight 2") + ' Kg'
                            else
                                ILENetwt_gTxt += '<br/>' + Format(ILE_lRec."Net Weight 2") + ' Kg';
                            if ILEGrosswt_gTxt = '' then
                                ILEGrosswt_gTxt := Format(ILE_lRec."Gross Weight 2") + ' Kg'
                            else
                                ILEGrosswt_gTxt += '<br/>' + Format(ILE_lRec."Gross Weight 2") + ' Kg';

                            if ILESecondaryPack_gTxt = '' then begin
                                ILESecondaryPack_gTxt := Format(Round((ILE_lRec.Quantity / ILE_lRec."Qty. per Unit of Measure"), 0.01) * -1);
                                UOMmaster_lRec.Reset();
                                if UOMmaster_lRec.Get(ILE_lRec."Unit of Measure Code") then
                                    ILESecondaryPack_gTxt += ' ' + UOMmaster_lRec.Description;
                            end else begin
                                ILESecondaryPack_gTxt += '<br/>' + Format(Round((ILE_lRec.Quantity / ILE_lRec."Qty. per Unit of Measure"), 0.01) * -1) + ' ';
                                UOMmaster_lRec.Reset();
                                if UOMmaster_lRec.Get(ILE_lRec."Unit of Measure Code") then
                                    ILESecondaryPack_gTxt += UOMmaster_lRec.Description;
                            end;

                        until ILE_lRec.Next() = 0;
                    end;
                    // if "Sales Shipment Line"."No." <> '' then
                    Clear(PrimPackQty_gDec);
                    Clear(ILEPrimPackUOM_gTxt);
                    Clear(ILEPrimPack_gTxt);
                    if "Sales Shipment Line"."Packaging Code" = '' then begin
                        ILE_lRec.Reset();
                        ILE_lRec.SetRange("Document No.", "Sales Shipment Header"."No.");
                        ILE_lRec.SetRange("Document Line No.", "Sales Shipment Line"."Line No.");
                        ILE_lRec.SetRange("Item No.", "Sales Shipment Line"."No.");
                        ILE_lRec.SetRange("Variant Code", "Sales Shipment Line"."Variant Code");
                        If ILE_lRec.FindSet() then
                            repeat
                                PrimPackQty_gDec += ILE_lRec.Quantity * -1;
                            Until ILE_lRec.Next() = 0;

                        //T13802-NS
                        If ItemVar_lRec.get("Sales Shipment Line"."No.", "Sales Shipment Line"."Variant Code") AND (ItemVar_lRec."Packing Code" <> '') then begin
                            if ItemUnitofmeasure_lRec.Get(ItemVar_lRec."Item No.", ItemVar_lRec."Packing Code") then begin
                                PrimPackQty_gDec := ROUND(PrimPackQty_gDec / ItemUnitofmeasure_lRec."Qty. per Unit of Measure", 0.01, '=');
                                UnitofMeasure_lRec.Get(ItemUnitofmeasure_lRec.Code);
                                ILEPrimPackUOM_gTxt := UnitofMeasure_lRec.Description;
                            end;
                        end else begin
                            if ItemUnitofmeasure_lRec.Get(ItemVar_lRec."Item No.", "Base UOM 2") then begin
                                ILEPrimPackUOM_gTxt := "Base UOM 2";
                                PrimPackQty_gDec := ROUND(PrimPackQty_gDec, 0.01, '=');
                            end;
                        end;

                        ILE_lRec.Reset();
                        ILE_lRec.SetRange("Document No.", "Sales Shipment Header"."No.");
                        ILE_lRec.SetRange("Document Line No.", "Sales Shipment Line"."Line No.");
                        ILE_lRec.SetFilter(CustomLotNumber, LotNo_gTxt.Replace('<br/>', '|'));
                        If ILE_lRec.FindSet() then
                            repeat
                                If ItemVar_lRec.get("Sales Shipment Line"."No.", "Sales Shipment Line"."Variant Code") AND (ItemVar_lRec."Packing Code" <> '') then begin
                                    if ItemUnitofmeasure_lRec.Get(ItemVar_lRec."Item No.", ItemVar_lRec."Packing Code") then begin
                                        If ILEPrimPack_gTxt = '' then Begin
                                            ILEPrimPack_gTxt := Format(ROUND((ILE_lRec.Quantity * -1) / ItemUnitofmeasure_lRec."Qty. per Unit of Measure", 0.01, '='));
                                            If UnitofMeasure_lRec.Get(ItemUnitofmeasure_lRec.Code) then
                                                ILEPrimPack_gTxt += ' ' + UnitofMeasure_lRec.Description;
                                        end
                                        else Begin
                                            ILEPrimPack_gTxt += '<br/>' + Format(ROUND((ILE_lRec.Quantity * -1) / ItemUnitofmeasure_lRec."Qty. per Unit of Measure", 0.01, '='));
                                            If UnitofMeasure_lRec.Get(ItemUnitofmeasure_lRec.Code) then
                                                ILEPrimPack_gTxt += ' ' + UnitofMeasure_lRec.Description;
                                        End;
                                    end;

                                end else begin
                                    if ILEPrimPack_gTxt = '' then begin
                                        if ItemUnitofmeasure_lRec.Get(ItemVar_lRec."Item No.", "Base UOM 2") then begin
                                            ILEPrimPack_gTxt += (Format(ROUND((ILE_lRec.Quantity * -1) / ItemUnitofmeasure_lRec."Qty. per Unit of Measure", 0.01, '=')));
                                            // If UnitofMeasure_lRec.Get("Base UOM 2") then
                                            ILEPrimPack_gTxt += ' ' + "Base UOM 2";
                                        end;
                                    end else begin
                                        if ItemUnitofmeasure_lRec.Get(ItemVar_lRec."Item No.", "Base UOM 2") then begin
                                            ILEPrimPack_gTxt += '<br/>' + (Format(ROUND((ILE_lRec.Quantity * -1) / ItemUnitofmeasure_lRec."Qty. per Unit of Measure", 0.01, '=')));
                                            //  If UnitofMeasure_lRec.Get("Base UOM 2") then
                                            ILEPrimPack_gTxt += ' ' + "Base UOM 2";
                                        end;
                                    end;
                                end;
                            until ILE_lRec.Next() = 0;
                    end else begin
                        //Write code for getting the Primary packing quantity and text with Packaging code functionality.
                        //Code commented for temporary based..packaging extension not deployed in live
                        // PackagingLines_lRec.Reset();
                        // PackagingLines_lRec.SetCurrentKey("Packaging Level");
                        // PackagingLines_lRec.SetAscending("Packaging Level", false);
                        // PackagingLines_lRec.SetRange("Packaging Code", "Sales Shipment Line"."Packaging Code");
                        // if PackagingLines_lRec.FindFirst() then begin
                        //     PrimaryLevel_lInt := PackagingLines_lRec."Packaging Level" - 1;
                        // end;
                        // PackagingLines_lRec.SetRange("Packaging Code");
                        // PackagingLines_lRec.SetRange("Packaging Code", "Sales Shipment Line"."Packaging Code");
                        // PackagingLines_lRec.SetRange("Packaging Level", PrimaryLevel_lInt);
                        // if PackagingLines_lRec.FindFirst() then begin
                        //     PrimaryUOM_lCode := PackagingLines_lRec."Unit of Measure";
                        // end;
                        // ILE_lRec.Reset();
                        // ILE_lRec.SetRange("Document No.", "Sales Shipment Header"."No.");
                        // ILE_lRec.SetRange("Document Line No.", "Sales Shipment Line"."Line No.");
                        // ILE_lRec.SetRange("Item No.", "Sales Shipment Line"."No.");
                        // ILE_lRec.SetRange("Variant Code", "Sales Shipment Line"."Variant Code");
                        // If ILE_lRec.FindSet() then
                        //     repeat
                        //         PrimPackQty_gDec += ILE_lRec.Quantity * -1;
                        //     Until ILE_lRec.Next() = 0;


                        If ItemVar_lRec.get("Sales Shipment Line"."No.", "Sales Shipment Line"."Variant Code") then begin
                            if ItemUnitofmeasure_lRec.Get(ItemVar_lRec."Item No.", PrimaryUOM_lCode) then begin
                                PrimPackQty_gDec := ROUND(PrimPackQty_gDec / ItemUnitofmeasure_lRec."Qty. per Unit of Measure", 0.01, '=');
                                UnitofMeasure_lRec.Get(ItemUnitofmeasure_lRec.Code);
                                ILEPrimPackUOM_gTxt := UnitofMeasure_lRec.Description;
                            end;
                        end;

                        ILE_lRec.Reset();
                        ILE_lRec.SetRange("Document No.", "Sales Shipment Header"."No.");
                        ILE_lRec.SetRange("Document Line No.", "Sales Shipment Line"."Line No.");
                        ILE_lRec.SetFilter(CustomLotNumber, LotNo_gTxt.Replace('<br/>', '|'));
                        If ILE_lRec.FindSet() then
                            repeat
                                If ItemVar_lRec.get("Sales Shipment Line"."No.", "Sales Shipment Line"."Variant Code") then begin
                                    if ItemUnitofmeasure_lRec.Get(ItemVar_lRec."Item No.", PrimaryUOM_lCode) then begin
                                        If ILEPrimPack_gTxt = '' then Begin
                                            ILEPrimPack_gTxt := Format(ROUND((ILE_lRec.Quantity * -1) / ItemUnitofmeasure_lRec."Qty. per Unit of Measure", 0.01, '='));
                                            If UnitofMeasure_lRec.Get(ItemUnitofmeasure_lRec.Code) then
                                                ILEPrimPack_gTxt += ' ' + UnitofMeasure_lRec.Description;
                                        end
                                        else Begin
                                            ILEPrimPack_gTxt += '<br/>' + Format(ROUND((ILE_lRec.Quantity * -1) / ItemUnitofmeasure_lRec."Qty. per Unit of Measure", 0.01, '='));
                                            If UnitofMeasure_lRec.Get(ItemUnitofmeasure_lRec.Code) then
                                                ILEPrimPack_gTxt += ' ' + UnitofMeasure_lRec.Description;
                                        End;
                                    end;
                                end;
                            until ILE_lRec.Next() = 0;
                    end;

                    //T13802-NE
                    //Desc_gTxt += '<b>Item No. ' + "Sales Shipment Line"."No." + '</b>';
                    // if "Sales Shipment Line"."Description 2" <> '' then
                    // Item_lRec.Reset();
                    // Item_lRec.get("Sales Shipment Line"."No.");
                    // Desc_gTxt += '<br/>' + Item_lRec.GenericName;
                    // if Origitext <> '' then
                    //Desc_gTxt += '<br/>' + 'Origin: ' + Origitext;
                    // if Item_lRec."HS Code" <> '' then
                    //Desc_gTxt += '<br/>' + 'HS Code: ' + Item_lRec."HS Code";
                    //if Item_lRec."Net Weight" <> 0 then
                    // Desc_gTxt += '<br/>' + 'Net Weight: ' + Format(Item_lRec."Net Weight");
                    //if Item_lRec."Gross Weight" <> 0 then
                    // Desc_gTxt += '<br/>' + 'Gross Weight: ' + Format(Item_lRec."Gross Weight");
                    // ItemVar_lRec.Reset();
                    // if ItemVar_lRec.get(Item_lRec."No.") then begin
                    // if ItemVar_lRec."Packing Description" <> '' then
                    //     Desc_gTxt += '<br/>' + 'Packing: ' + ItemVar_lRec."Packing Description";
                    // end else
                    //     Desc_gTxt += '<br/>' + 'Packing: ';
                    // if Item_lRec."IMCO Class" <> '' then
                    IMCO_lRec.Reset();
                    if IMCO_lRec.Get(Item_lRec."IMCO Class") then begin
                        Desc_gTxt += '<br/>' + 'UN No.: ' + IMCO_lRec.Description;
                        Desc_gTxt += '<br/>' + 'Haz. Class: ' + IMCO_lRec.Class;
                    end
                    else begin
                        Desc_gTxt += '<br/>' + 'UN No.: ';
                        Desc_gTxt += '<br/>' + 'Haz. Class: ';
                    end;
                    //if "Sales Shipment Line".CustomBOENumber <> '' then
                    Desc_gTxt += '<br/><br/>' + 'Rework: <br/>' + "Sales Shipment Line".CustomBOENumber;

                    if "Variant Code" <> '' then begin // add by bayas
                        VariantRec.Get("No.", "Variant Code");
                        if VariantRec."Packing Description" <> '' then begin
                            Packing_Txt := VariantRec."Packing Description";
                        end else begin
                            Packing_Txt := Item."Description 2";
                        end;
                    end else begin
                        Packing_Txt := Item."Description 2";
                    end;

                    if CustomInvoiceG then begin
                        HSCodeVar := LineHSNCode;
                        if CountryOrRegion.Get(LineCountryOfOrigin) then
                            OriginVar := CountryOrRegion.Name;

                    end else begin
                        if Item.Get("Sales Shipment Line"."No.") then begin
                            if Generic.Get(Item.GenericName) then
                                GenericNameVar := Generic.Description;
                            if CountryOrRegion.Get(Item."Country/Region of Origin Code") then
                                OriginVar := CountryOrRegion.Name;
                            HSCodeVar := Item."Tariff No.";
                            BaseUOMVar := Item."Base Unit of Measure";
                            if "Sales Shipment Line"."Variant Code" <> '' then begin
                                RecVariant.Get("Sales Shipment Line"."No.", "Sales Shipment Line"."Variant Code");
                                if RecVariant.HSNCode <> '' then begin
                                    HSCodeVar := RecVariant.HSNCode;
                                end else begin
                                    HSCodeVar := Item."Tariff No.";
                                end;
                                if RecVariant.CountryOfOrigin <> '' then begin
                                    if CountryOrRegion.Get(RecVariant.CountryOfOrigin) then
                                        OriginVar := CountryOrRegion.Name;
                                end else begin
                                    OriginVar := CountryOrRegion.Name;
                                end;
                            end;
                        end;
                    end;

                    // if CustomInvoiceG then begin
                    //     HSNCode := LineHSNCode;
                    //     if CountryOrRegion.Get(LineCountryOfOrigin) then
                    //         OriginVar := CountryOrRegion.Name;

                    // end;

                    UOMmaster_lRec.Reset();
                    if UOMmaster_lRec.Get("Unit of Measure Code") then
                        Uomdescription_gTxt := UOMmaster_lRec.Description;

                    SalesHeader_lRec.Reset();
                    SalesHeader_lRec.SetRange("No.", "Order No.");
                    if SalesHeader_lRec.FindFirst() then begin
                        if SalesHeader_lRec."External Document No." <> '' then
                            SalesExtenalNo_gCod := SalesHeader_lRec."External Document No.";
                        if SalesHeader_lRec."LC No. 2" <> '' then
                            SalesLcNo_gTxt := SalesHeader_lRec."LC No. 2" + ' / ';
                        if SalesHeader_lRec."LC Date 2" <> 0D then
                            SalesLcDate_gDte := Format(SalesHeader_lRec."LC Date 2", 0, '<Day,2>-<Month Text,3>-<year4>');
                    end;

                    if TempPINumber = '' then
                        if "Sales Shipment Header"."Quote No." <> '' then begin
                            TempPINumber := "Sales Shipment Header"."Quote No.";
                        end;
                    if TempOrderNumber = '' then
                        if "Sales Shipment Header"."Order No." <> '' then begin
                            TempOrderNumber := "Sales Shipment Header"."Order No.";
                            if TempPINumber = '' then begin
                                SalesHeader.Reset();
                                SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                                SalesHeader.SetRange("No.", TempOrderNumber);
                                if SalesHeader.FindFirst() then begin
                                    if SalesHeader."Quote No." <> '' then
                                        TempPINumber := SalesHeader."Quote No.";
                                end
                            end;
                        end;
                    if TempBSONumber = '' then
                        if "Sales Shipment Line"."Blanket Order No." <> '' then begin
                            TempBSONumber := "Sales Shipment Line"."Blanket Order No.";
                            if TempPINumber = '' then begin
                                SalesHeader.Reset();
                                SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::"Blanket Order");
                                SalesHeader.SetRange("No.", TempBSONumber);
                                if SalesHeader.FindFirst() then begin
                                    if SalesHeader."Quote No." <> '' then
                                        TempPINumber := SalesHeader."Quote No.";
                                end;
                            end;
                        end;
                    if TempPINumber <> '' then begin
                        PINONew := TempPINumber;
                        if PIDateNew = '' then begin
                            SalesHeader.Reset();
                            SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Quote);
                            SalesHeader.SetRange("No.", PINONew);
                            if SalesHeader.FindFirst() then
                                PIDateNew := ' / ' + Format(SalesHeader."Document Date", 0, '<Day,2>-<Month Text,3>-<year4>')
                            else begin
                                salesHeaderArchive.Reset();
                                salesHeaderArchive.SetRange("Document Type", salesHeaderArchive."Document Type"::Quote);
                                salesHeaderArchive.SetRange("No.", PINONew);
                                if salesHeaderArchive.FindFirst() then
                                    PIDateNew := ' / ' + Format(salesHeaderArchive."Document Date", 0, '<Day,2>-<Month Text,3>-<year4>');
                            end
                        end;
                    end;


                end;

            }

            trigger OnAfterGetRecord()
            var
                WhseShpHdr_lRec: Record "Warehouse Shipment Header";
                //QCSetup: Record "Quality Control Setup";
                Whsehdr_lRec: Record "Warehouse Delivery Inst Header";
                SalesInvLine_lRec: Record "Sales Invoice Line";
                CountryRegionL: Record "Country/Region";
                Cust_Lrec: record Customer;
                SalesShipmentHeader_lTemp: Record "Sales Shipment Header";
                SalesShiptoOption: Enum "Sales Ship-to Options";
                SalesBillToOption: Enum "Sales Bill-to Options";
                ShipToAdd: Record "Ship-to Address";

            begin
                //Bill to ship to Logic for sales shipment header
                SalesShipmentHeader_lTemp.Reset;
                SalesShipmentHeader_lTemp := "Sales Shipment Header";
                CalculateShipBillToOptions(SalesShiptoOption, SalesBillToOption, SalesShipmentHeader_lTemp);

                if SalesShiptoOption = SalesShiptoOption::"Default (Sell-to Address)" then begin
                    CustAddrShipto_Arr[1] := 'Same as Bill To';
                end else begin
                    CustAddrShipto_Arr[1] := '<b>' + "Ship-to Name" + '</b>';
                    CustAddrShipto_Arr[2] := "Ship-to Address";
                    CustAddrShipto_Arr[3] := "Ship-to Address 2";
                    CustAddrShipto_Arr[4] := "Ship-to City";
                    CustAddrShipto_Arr[8] := "Ship-to Post Code";
                    if CountryRegionL.Get("Ship-to Country/Region Code") then
                        CustAddrShipto_Arr[5] := CountryRegionL.Name;
                    //AW09032020>>
                    if "Ship-to Code" <> '' then begin
                        if ShipToAdd.Get("Sell-to Customer No.", "Ship-to Code") and (ShipToAdd."Phone No." <> '') then
                            CustAddrShipto_Arr[6] := 'Tel: ' + ShipToAdd."Phone No.";
                    end;

                end; //MS-+


                Clear(CustAddr_Arr);
                CustAddr_Arr[1] := "Bill-to Name";
                CustAddr_Arr[2] := "Bill-to Address";
                CustAddr_Arr[3] := "Bill-to Address 2";
                CustAddr_Arr[4] := "Bill-to City" + ',' + "Bill-to Post Code";
                //CustAddrShipTo_Arr[5] := "Bill-to Post Code";
                if CountryRegionL.Get("Bill-to Country/Region Code") then
                    CustAddr_Arr[6] := CountryRegionL.Name;
                Cust_Lrec.Reset();
                if Cust_Lrec.Get("Bill-to Customer No.") and (Cust_Lrec."Phone No." <> '') then
                    CustAddr_Arr[7] := 'Tel: ' + Cust_Lrec."Phone No."
                else
                    if "Sell-to Phone No." <> '' then
                        CustAddr_Arr[7] := 'Tel: ' + "Sell-to Phone No.";
                //end;
                CompressArray(CustAddrShipTo_Arr);
                CompressArray(CustAddr_Arr);

                if PrintAgentRepAddress then begin
                    CustAddr_Arr[1] := "Agent Rep. Name";
                    CustAddr_Arr[2] := "Agent Rep. Address";
                    CustAddr_Arr[3] := "Agent Rep. Address 2";
                    CustAddr_Arr[4] := "Agent Rep. City";
                    CustAddr_Arr[5] := "Agent Rep. Post Code";
                    if CountryRegionL.Get("Agent Rep. Country/Region Code") then
                        CustAddr_Arr[6] := CountryRegionL.Name;
                    // AgentRepRec.Reset();
                    // if AgentRepRec.Get("Agent Rep. Code") and (AgentRepRec."Phone No." <> '') then
                    //     CustAddr_Arr[7] := 'Tel No.: ' + AgentRepRec."Phone No.";
                    CustAddr_Arr[8] := '';
                    CustAddr_Arr[9] := '';
                    CompressArray(CustAddr_Arr);
                    // CustTRN := '';
                end;



                clear(CustomerAddr_gTxt);
                if "Sales Shipment Header"."Ship-to Code" <> '' then begin
                    CustomerAddr_gTxt := '<b>' + "Sales Shipment Header"."Ship-to Name" + '</b><br/>';
                    if "Sales Shipment Header"."Ship-to Address" <> '' then
                        CustomerAddr_gTxt += "Sales Shipment Header"."Ship-to Address";
                    if "Sales Shipment Header"."Ship-to Address 2" <> '' then
                        CustomerAddr_gTxt += '<br/>' + "Sales Shipment Header"."Ship-to Address 2";
                    if "Sales Shipment Header"."Ship-to City" <> '' then
                        CustomerAddr_gTxt += '<br/>' + "Sales Shipment Header"."Ship-to City";
                    if "Sales Shipment Header"."Ship-to County" <> '' then
                        CustomerAddr_gTxt += ', ' + "Sales Shipment Header"."Ship-to County";
                    CustomerAddr_gTxt += '<br/>Trade License No.';
                end else begin
                    Customer_gRec.Reset;
                    if Customer_gRec.Get("Sell-to Customer No.") then begin
                        if Customer_gRec.Name <> '' then
                            CustomerAddr_gTxt := '<b>' + Customer_gRec.Name + '</b><br/>';
                        if Customer_gRec.Address <> '' then
                            CustomerAddr_gTxt += Customer_gRec.Address;
                        if Customer_gRec."Address 2" <> '' then
                            CustomerAddr_gTxt += '<br/>' + Customer_gRec."Address 2";
                        if Customer_gRec.City <> '' then
                            CustomerAddr_gTxt += '<br/>' + Customer_gRec.City;
                        if Customer_gRec.County <> '' then
                            CustomerAddr_gTxt += ', ' + Customer_gRec.County;
                        CustomerAddr_gTxt += '<br/>Trade License No.';
                    end;
                end;

                Whsehdr_lRec.Reset();
                Whsehdr_lRec.SetRange("Sales Shipment No.", "No.");
                if Whsehdr_lRec.FindFirst() then begin
                    ShipInst_gTxt := Whsehdr_lRec."WDI No";
                    Shipdate_gDte := Whsehdr_lRec."WDI Date";
                end;
                SalesInvLine_lRec.Reset();
                SalesInvLine_lRec.SetRange("Shipment No.", "No.");
                if SalesInvLine_lRec.FindFirst() then begin
                    if SalesInvLine_lRec."Document No." <> '' then
                        Reference_Invoice_No := SalesInvLine_lRec."Document No." + ' / ';
                    SalesInvoiceDate_gDte := Format(SalesInvLine_lRec."Posting Date", 0, '<Day,2>-<Month Text,3>-<year4>');


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
                    field(PrintStamp; PrintStamp)
                    {
                        ApplicationArea = all;
                        Caption = 'Print Digital Stamp';
                    }
                    field("Print Customer Invoice"; CustomInvoiceG)
                    {
                        ApplicationArea = ALL;
                    }
                    field("Print Agent Representative Address"; PrintAgentRepAddress)
                    {
                        ApplicationArea = all;
                        Caption = 'Print Agent Representative Address';
                    }
                }
            }
        }
    }
    labels
    {
        Tel_Lbl = 'Tel:';
        Web_Lbl = 'Web:';
        TRN_Lbl = 'TRN:';
        Report_Lbl = 'PACKING LIST';
        Report_Lbl1 = ' Order';
        Report_Lbl2 = ' (Warehouse to Warehouse)';
        Authority_Lbl = 'Authorized Signatory:';
        Stamp_Lbl = 'Stamp:';
        Date_Lbl = 'Date:';
        Remarks_Lbl = 'Both parties confirm with their signature that all the products are Delivered/Received in perfect condition. Please explain here if any discrepancy exists.';
        TrFrom_Lbl = 'Bill To';
        TrTo_Lbl = 'Transfer To:';
        SerialNo_Lbl = 'No.';
        ItemNo_Lbl = 'Item No.';
        Desc_Lbl = 'Description';
        LotNo_Lbl = 'Lot Number';
        Boe_Lbl = 'BOE Number';
        BaseUOM_Lbl = 'UOM';
        BUOMQ_Lbl = 'Quantity';
        AlUOM_Lbl = 'Package Qty.';
        AlUOMQ_Lbl = 'Package Type';
        Total_Lbl = 'Total';
        PosDate_Lbl = 'Date:';
        OrderNo_Lbl = 'Packing Ref.:';
        RemarkHead_Lbl = 'Remarks:';
        DocumentNo_Lbl = 'Ref. No.';
        Origin_Lbl = 'Origin: ';
        HSCode_Lbl = 'HS Code: ';
        Packing_Lbl = 'Packing: ';
        Netight_Lbl = 'Net Weight: ';
        GrossWeight_Lbl = 'Gross Weight: ';
        InvoiceNo_Lbl = 'Invoice No./Date :';
        PINoDate_lbl = 'P/I No./Date :';
        LCNoDate_lbl = 'L/C No./Date :';
        clientPO_lbl = 'Client PO No./Date :';
    }
    trigger OnPreReport()
    begin
        CompInfo_gRec.Get;
        CompInfo_gRec.CalcFields(Picture, Logo, Stamp);
        // if CountryRegionRec.Get(CompInfo_gRec."Country/Region Code") then
        //     countryDesc := CountryRegionRec.Name;
        CompanyAddr_gTxt := '';
        if CompInfo_gRec.Name <> '' then
            CompanyAddr_gTxt := '<b>' + CompInfo_gRec.Name + '</b><br/>';
        if CompInfo_gRec.Address <> '' then
            CompanyAddr_gTxt := CompanyAddr_gTxt + CompInfo_gRec.Address;
        if CompInfo_gRec."Address 2" <> '' then
            CompanyAddr_gTxt := CompanyAddr_gTxt + CompInfo_gRec."Address 2";
        if CompInfo_gRec.City <> '' then
            CompanyAddr_gTxt := CompanyAddr_gTxt + ', ' + CompInfo_gRec.City;
        if CompInfo_gRec.County <> '' then
            CompanyAddr_gTxt := CompanyAddr_gTxt + ', ' + CompInfo_gRec.County;
        if CompInfo_gRec."Phone No." <> '' then
            CompanyAddr_gTxt := CompanyAddr_gTxt + '<br/>Tel.:' + CompInfo_gRec."Phone No.";
        if CompInfo_gRec."Home Page" <> '' then
            CompanyAddr_gTxt := CompanyAddr_gTxt + '<br/>Web:' + CompInfo_gRec."Home Page";
        if CompInfo_gRec."VAT Registration No." <> '' then
            CompanyAddr_gTxt := CompanyAddr_gTxt + '<br/>TRN:' + CompInfo_gRec."VAT Registration No.";
    end;


    procedure CalculateShipBillToOptions(var ShipToOptions: Enum "Sales Ship-to Options"; var BillToOptions: Enum "Sales Bill-to Options"; var SalesHeader: Record "Sales Shipment Header")
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

    local procedure IsShipToAddressEqualToSellToAddress(SalesHeaderWithSellTo: Record "Sales Shipment Header"; SalesHeaderWithShipTo: Record "Sales Shipment Header"): Boolean
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


    var
        totalnetWeigh_gDec: Decimal;
        totalgrossWeigh_gDec: Decimal;

        PrintStamp: Boolean;
        CustomInvoiceG: Boolean;
        countryDesc: text;
        CountryRegionRec: Record "Country/Region";
        SalesHeader: Record "Sales Header";
        TempPINumber: Code[20];
        TempBSONumber: Code[20];
        TempOrderNumber: Code[20];
        PINONew: code[20];
        PIDateNew: Text[20];
        SalesExtenalNo_gCod: Code[35];
        SalesLcNo_gTxt: Text;
        SalesLcDate_gDte: Text;
        SalesInvoiceDate_gDte: Text;
        CustAltAddrRec: Record "Customer Alternet Address";
        CountryRegionL: Record "Country/Region";
        SalesLineMerge: Boolean;
        blnClrAddress: Boolean;
        PrintAgentRepAddress: Boolean;
        CustomerMgt_gCdu: Codeunit "Customer Mgt.";
        CustAddr_Arr: array[10] of Text[100];
        CustAddrShipto_Arr: array[8] of Text[100];
        Packing_Txt: Text[100];
        GenericNameVar: Text;
        OriginVar: Text;
        HSCodeVar: Text;
        BaseUOMVar: Text;
        Item: Record "Item";
        Reference_Invoice_No: Text;
        ShipInst_gTxt: Text;
        Shipdate_gDte: Date;
        QAManager_gTxt: Text;
        QAManagerMo_gTxt: Text;
        RecParty_gTxt: Text;
        CompInfo_gRec: Record "Company Information";
        Desc_gTxt: Text;
        LotNo_gTxt: Text;
        BOENo_gTxt: Text;
        NetWeight_gDec: Decimal;
        GrossWeight_gDec: Decimal;
        ILENetwt_gDec: Decimal;
        ILENetwt_gTxt: Text;
        ILEGrosswt_gDec: Decimal;
        ILEGrosswt_gTxt: Text;
        ILEPrimPackUOM_gTxt: Text;
        // ILEPrimPackQty_gDec: Decimal;
        ILESecondaryPackQty_gDec: Decimal;
        ILEPrimPack_gTxt: Text;
        ILESecondaryPack_gTxt: Text;
        PrimPackUOM_gTxt: Text;
        PrimPackQty_gDec: Decimal;
        SecondaryPackQty_gDec: Decimal;
        SecPackUOM_gTxt: Text;
        SecPackQty_gDec: Decimal;
        Contact_gRec: Record "Contact";
        Customer_gRec: Record "Customer";
        ShippingInstDate_gTxt: Text;
        Logist_Cordinator_Info: Text;
        AuthRep_gTxt: Text;
        WarehouseAddr_gTxt: Text;
        CustomerAddr_gTxt: Text;
        ContactAddr_gTxt: Text;
        CompanyAddr_gTxt: Text;
        Origitext: Text;
        SrNo: Integer;
        CountryRegRec: Record "Country/Region";
        Uomdescription_gTxt: Text;
}