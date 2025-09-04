Report 50552 "Delivery Order"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Delivery Order.rdl';
    Description = 'PC 10012025';

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            RequestFilterFields = "No.";
            column(CompInfo_gRec_picture; CompInfo_gRec.Picture) { }
            column(CompInfo_gRec_Logo; CompInfo_gRec.Logo) { }
            column(CompanyAddr_gTxt; CompanyAddr_gTxt) { }
            column(DO_No; "No.") { }
            column(Posting_Date; "Posting Date") { }
            column(WarehouseAddr_gTxt; WarehouseAddr_gTxt) { }
            column(CustomerAddr_gTxt; CustomerAddr_gTxt) { }
            column(Reference_Invoice_No; Reference_Invoice_No) { }
            column(Order_No; "Order No.") { }
            column(Logist_Cordinator_Info; Logist_Cordinator_Info) { }
            column(AuthRep_gTxt; AuthRep_gTxt) { }
            column(Origitext; Origitext) { }
            column(RecParty_gTxt; RecParty_gTxt) { }
            column(QAManager_gTxt; QAManager_gTxt) { }
            column(QAManagerMo_gTxt; QAManagerMo_gTxt) { }
            column(ShipInst_gTxt; ShipInst_gTxt) { }
            column(Shipdate_gDte; Format(Shipdate_gDte)) { }

            column(HSCode; HSCodeVar) { }
            column(Origin; OriginVar) { }
            column(Generic_Name; GenericNameVar) { }
            column(Packing; Packing_Txt) { }

            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Sales Shipment Header";
                DataItemTableView = where(Type = filter(Type::Item));

                column(SrNo; SrNo) { }
                column(LineNo; "Line No.") { }
                column(Quantity; Quantity) { }
                column(UnitofMeasureCode; UOMDesc_gTxt) { }
                column(Item_No; "No.") { }
                column(Description; Description) { }
                column(BOENo_gTxt; BOENo_gTxt) { }
                column(LotNo_gTxt; LotNo_gTxt) { }
                column(NetWeight_gDec; NetWeight_gDec) { }
                column(GrossWeight_gDec; GrossWeight_gDec) { }
                column(totalgrossWeigh_gDec; totalgrossWeigh_gDec) { }
                column(totalnetWeigh_gDec; totalnetWeigh_gDec) { }
                column(PrimPackUOM_gTxt; PrimPackUOM_gTxt) { }
                column(PrimPackQty_gDec; PrimPackQty_gDec) { }
                column(SecondaryPackQty_gDec; SecondaryPackQty_gDec) { }
                column(SecPackUOM_gTxt; SecPackUOM_gTxt) { }
                column(SecPackQty_gDec; SecPackQty_gDec) { }
                column(Desc_gTxt; Desc_gTxt) { }
                column(ILEGrosswt_gDec; ILEGrosswt_gDec) { }
                column(ILENetwt_gDec; ILENetwt_gDec) { }
                column(ILEPrimPackQty_gDec; ILEPrimPackQty_gDec) { }
                column(ILESecondaryPackQty_gDec; ILESecondaryPackQty_gDec) { }
                column(ILEPrimPack_gTxt; ILEPrimPack_gTxt) { }
                column(ILESecondaryPack_gTxt; ILESecondaryPack_gTxt) { }
                column(ILEPrimPackUOM_gTxt; ILEPrimPackUOM_gTxt) { }
                column(ILENetwt_gTxt; ILENetwt_gTxt) { }
                column(ILEGrosswt_gTxt; ILEGrosswt_gTxt) { }
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
                    Generic: Record KMP_TblGenericName;
                    CountryOrRegion: Record "Country/Region";
                    RecVariant: Record "Item Variant";
                    ItemUnitofmeasure_lRec: Record "Item Unit of Measure";
                    UnitofMeasure_lRec: Record "Unit of Measure";
                    SalesShipline_lRec: Record "Sales Shipment Line";

                    ILENetwt_lTxt: Text;
                    ILEGrosswt_lTxt: Text;
                    ILEPrimPack_lTxt: Text;
                    PackagingLines_lRec: Record "Packaging detail Line";
                    PrimaryLevel_lInt: Integer;
                    PrimaryUOM_lCode: Code[20];
                begin
                    clear(Desc_gTxt);
                    clear(BOENo_gTxt);
                    clear(LotNo_gTxt);
                    clear(UOMDesc_gTxt);
                    Clear(GenericNameVar);
                    Clear(OriginVar);
                    Clear(HSCodeVar);
                    Clear(BaseUOMVar);
                    clear(Desc_gTxt);
                    clear(BOENo_gTxt);
                    clear(LotNo_gTxt);
                    // clear(Uomdescription_gTxt);
                    //T13802-NS
                    Clear(ILESecondaryPack_gTxt);
                    Clear(ILEGrosswt_gTxt);
                    Clear(ILENetwt_gTxt);
                    // Clear(totalgrossWeigh_gDec);
                    // Clear(totalnetWeigh_gDec);
                    // Clear(ItemLotFilter_lTxt);
                    SrNo := SrNo + 1;
                    CountryRegRec.Reset();
                    //if CountryRegRec.Get("Sales Shipment Line".LineCountryOfOrigin) then
                    Origitext := CountryRegRec.Name;
                    NetWeight_gDec := "Sales Shipment Line"."Net Weight";
                    GrossWeight_gDec := "Sales Shipment Line"."Gross Weight";
                    PrimPackUOM_gTxt := "Sales Shipment Line"."Unit of Measure";
                    // PrimPackQty_gDec := "Sales Shipment Line".Quantity;
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

                            // if ILEPrimPack_gTxt = '' then begin
                            //     ILEPrimPack_gTxt := Format(ILE_lRec.Quantity * -1);
                            //     UOMmaster_lRec.Reset();
                            //     if UOMmaster_lRec.Get(ILE_lRec."Unit of Measure Code") then
                            //         ILEPrimPack_gTxt += ' ' + UOMmaster_lRec.Description;
                            // end else begin
                            //     ILEPrimPack_gTxt += '<br/>' + Format(ILE_lRec.Quantity * -1) + ' ';
                            //     UOMmaster_lRec.Reset();
                            //     if UOMmaster_lRec.Get(ILE_lRec."Unit of Measure Code") then
                            //         ILEPrimPack_gTxt += UOMmaster_lRec.Description;
                            // end;

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
                        PackagingLines_lRec.Reset();
                        PackagingLines_lRec.SetCurrentKey("Packaging Level");
                        PackagingLines_lRec.SetAscending("Packaging Level", false);
                        PackagingLines_lRec.SetRange("Packaging Code", "Sales Shipment Line"."Packaging Code");
                        if PackagingLines_lRec.FindFirst() then begin
                            PrimaryLevel_lInt := PackagingLines_lRec."Packaging Level" - 1;
                        end;
                        PackagingLines_lRec.SetRange("Packaging Code");
                        PackagingLines_lRec.SetRange("Packaging Code", "Sales Shipment Line"."Packaging Code");
                        PackagingLines_lRec.SetRange("Packaging Level", PrimaryLevel_lInt);
                        if PackagingLines_lRec.FindFirst() then begin
                            PrimaryUOM_lCode := PackagingLines_lRec."Unit of Measure";
                        end;
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
                    Item_lRec.Reset();
                    if Item_lRec.get("Sales Shipment Line"."No.") then;
                    // Desc_gTxt += '<br/>' + Item_lRec.GenericName;
                    // if Origitext <> '' then
                    // Desc_gTxt += '<br/>' + 'Origin: ' + Origitext;
                    // if Item_lRec."HS Code" <> '' then
                    // Desc_gTxt += '<br/>' + 'HS Code: ' + Item_lRec."HS Code";
                    //if Item_lRec."Net Weight" <> 0 then
                    // Desc_gTxt += '<br/>' + 'Net Weight: ' + Format(Item_lRec."Net Weight");
                    //if Item_lRec."Gross Weight" <> 0 then
                    // Desc_gTxt += '<br/>' + 'Gross Weight: ' + Format(Item_lRec."Gross Weight");
                    // ItemVar_lRec.Reset();
                    // if ItemVar_lRec.get(Item_lRec."No.") then begin
                    //     // if ItemVar_lRec."Packing Description" <> '' then
                    //     // Desc_gTxt += '<br/>' + 'Packing: ' + ItemVar_lRec."Packing Description";
                    // end else
                    // Desc_gTxt += '<br/>' + 'Packing: ';
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
                    // Desc_gTxt += '<br/><br/>' + 'Rework: <br/>' + "Sales Shipment Line".CustomBOENumber;
                    UOMmaster_lRec.Reset();
                    if UOMmaster_lRec.get("Sales Shipment Line"."Unit of Measure Code") then
                        UOMDesc_gTxt := UOMmaster_lRec.Description
                    else
                        UOMDesc_gTxt := '';

                    if "Variant Code" <> '' then begin // add by bayas
                        ItemVar_lRec.Get("No.", "Variant Code");
                        if ItemVar_lRec."Packing Description" <> '' then begin
                            Packing_Txt := ItemVar_lRec."Packing Description";
                        end else begin
                            Packing_Txt := Item_lRec."Description 2";
                        end;
                    end else begin
                        Packing_Txt := Item_lRec."Description 2";
                    end;



                    if Item_lRec.Get("Sales Shipment Line"."No.") then begin
                        if Generic.Get(Item_lRec.GenericName) then
                            GenericNameVar := Generic.Description;
                        if CountryOrRegion.Get(Item_lRec."Country/Region of Origin Code") then
                            OriginVar := CountryOrRegion.Name;
                        HSCodeVar := Item_lRec."Tariff No.";
                        BaseUOMVar := Item_lRec."Base Unit of Measure";
                        if "Sales Shipment Line"."Variant Code" <> '' then begin
                            RecVariant.Get("Sales Shipment Line"."No.", "Sales Shipment Line"."Variant Code");
                            if RecVariant.HSNCode <> '' then begin
                                HSCodeVar := RecVariant.HSNCode;
                            end else begin
                                HSCodeVar := Item_lRec."Tariff No.";
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

            }

            trigger OnAfterGetRecord()
            var
                WhseShpHdr_lRec: Record "Warehouse Shipment Header";
                QCSetup: Record "Quality Control Setup";
                Whsehdr_lRec: Record "Warehouse Delivery Inst Header";
                SalesInvLine_lRec: Record "Sales Invoice Line";
                SalesShipline_lRec: Record "Sales Shipment Line";
                location: Record "Location";
                QltyAsswarehouseEmplyee: Record "Quality Assurance Employee";
                User_lRec: Record User;
                UserSetup_lRec: Record "User Setup";
            begin
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
                if "Sales Shipment Header"."Location Code" <> '' then begin
                    location.Reset();
                    location.SetRange("Code", "Sales Shipment Header"."Location Code");
                    if location.FindFirst() then begin
                        QltyAsswarehouseEmplyee.Reset();
                        QltyAsswarehouseEmplyee.SetRange("Location Code", location.Code);
                        QltyAsswarehouseEmplyee.SetRange(Default, true);
                        if QltyAsswarehouseEmplyee.FindFirst() then begin
                            User_lRec.Reset();
                            User_lRec.SetRange("User Name", QltyAsswarehouseEmplyee."User ID");
                            if User_lRec.FindFirst() then
                                QAManager_gTxt := User_lRec."Full Name";
                            UserSetup_lRec.Reset();
                            if UserSetup_lRec.Get(QltyAsswarehouseEmplyee."User ID") then
                                QAManagerMo_gTxt := UserSetup_lRec."Phone No.";

                        end;
                    end;
                end else begin
                    SalesShipline_lRec.Reset();
                    SalesShipline_lRec.SetRange("Document No.", "Sales Shipment Header"."No.");
                    SalesShipline_lRec.SetFilter("Location Code", '<>%1', '');
                    if SalesShipline_lRec.FindFirst() then begin
                        location.Reset();
                        location.SetRange("Code", SalesShipline_lRec."Location Code");
                        if location.FindFirst() then begin
                            QltyAsswarehouseEmplyee.Reset();
                            QltyAsswarehouseEmplyee.SetRange("Location Code", location.Code);
                            QltyAsswarehouseEmplyee.SetRange(Default, true);
                            if QltyAsswarehouseEmplyee.FindFirst() then begin
                                User_lRec.Reset();
                                User_lRec.SetRange("User Name", QltyAsswarehouseEmplyee."User ID");
                                if User_lRec.FindFirst() then
                                    QAManager_gTxt := User_lRec."Full Name";

                                UserSetup_lRec.Reset();
                                if UserSetup_lRec.Get(QltyAsswarehouseEmplyee."User ID") then
                                    QAManagerMo_gTxt := UserSetup_lRec."Phone No.";
                            end;
                        end;
                    end;
                end;
                // QCSetup.Reset();
                // if QCSetup.Get() then begin
                //     QAManager_gTxt := QCSetup."QA Manager";
                //     QAManagerMo_gTxt := QCSetup."QA Mobile number";
                // end;
                Whsehdr_lRec.Reset();
                Whsehdr_lRec.SetRange("Sales Shipment No.", "No.");
                if Whsehdr_lRec.FindFirst() then begin
                    ShipInst_gTxt := Whsehdr_lRec."WDI No";
                    Shipdate_gDte := Whsehdr_lRec."WDI Date";
                end;
                SalesInvLine_lRec.Reset();
                SalesInvLine_lRec.SetRange("Shipment No.", "No.");
                if SalesInvLine_lRec.FindLast() then begin
                    Reference_Invoice_No := SalesInvLine_lRec."Document No.";
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
                }
            }
        }
    }
    labels
    {
        Origin_Lbl = 'Origin: ';
        HSCode_Lbl = 'HS Code: ';
        Packing_Lbl = 'Packing: ';
        Netight_Lbl = 'Net Weight: ';
        GrossWeight_Lbl = 'Gross Weight: ';
    }
    trigger OnPreReport()
    begin
        CompInfo_gRec.Get;
        CompInfo_gRec.CalcFields(Picture, Logo);
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


    var
        totalnetWeigh_gDec: Decimal;
        totalgrossWeigh_gDec: Decimal;
        SecondaryPackQty_gDec: Decimal;
        ILESecondaryPackQty_gDec: Decimal;
        UOMDesc_gTxt: Text;
        GenericNameVar: Text;
        OriginVar: Text;
        HSCodeVar: Text;
        BaseUOMVar: Text;
        Packing_Txt: Text;
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
        ILEPrimPackQty_gDec: Decimal;
        ILEPrimPack_gTxt: Text;
        ILESecondaryPack_gTxt: Text;
        PrimPackUOM_gTxt: Text;
        PrimPackQty_gDec: Decimal;
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
}