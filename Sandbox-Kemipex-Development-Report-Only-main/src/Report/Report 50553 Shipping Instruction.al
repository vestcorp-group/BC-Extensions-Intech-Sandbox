report 50553 "Shipping Instruction"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;

    Description = 'HD 10012025';

    RDLCLayout = './Layouts/Shipping Instruction.rdl';

    dataset
    {
        dataitem("Warehouse Delivery Inst Header"; "Warehouse Delivery Inst Header")
        {
            DataItemTableView = sorting("WDI No", "Sales Shipment No.", "Location Code");
            RequestFilterFields = "WDI No", "Sales Shipment No.";
            column(SO_No; "WDI No") { }
            column(LocationAddr_gTxt; LocationAddr_gTxt) { }
            column(LogisticCoordinator_gTxt; LogisticCoordinator_gTxt) { }
            column(LogsticAndShippingAgent_gTxt; LogsticAndShippingAgent_gTxt) { }

            dataitem("Sales Shipment Header"; "Sales Shipment Header")
            {
                DataItemTableView = sorting("No.");
                DataItemLink = "No." = field("Sales Shipment No.");
                // RequestFilterFields = "No.", "Sell-to Customer No.";
                column(company_picture; CompanyInfo_gRec.Picture) { }//AS-020425-O
                column(company_logo; CompanyInfo_gRec.Logo) { } //AS-020425- N
                column(Posting_Date; UpperCase(Format("Posting Date", 0, '<Day,2>-<Month Text,3>-<year4>'))) { }
                column(DO_No; "No.") { }// AS-20-03-2025-O

                column(CompanyAddr_gTxt; CompanyAddr_gTxt) { }
                column(WarehouseAddr_gTxt; WarehouseAddr_gTxt) { }
                column(Requested_Delivery_Date; "Requested Delivery Date") { }

                column(ShippmentAddr_gTxt; ShippmentAddr_gTxt) { }
                column(Notify_Party; "Sales Shipment Header"."Sell-to Customer Name") { }
                column(CustAddr_gTxt; CustAddr_gTxt) { }
                column(Shipper_gTxt; Shipper_gTxt) { }
                column(Incoterms; Incoterms) { }
                column(Loading_Port; "Loading Port") { }
                column(Port_of_Discharge; "Port of Discharge") { }

                column(Shipment_Date; UpperCase(Format("Posting Date", 0, '<Day,2>-<Month Text,3>-<year4>'))) { }
                column(Order_No_; "Order No.") { }
                column(Reference_Invoice_No; Reference_Invoice_No) { }
                column(Shipment_Method_Code; "Shipment Method Code")
                { }
                column(PortOfDischarge_SalesInvoiceHeader; PortOfLoding)
                {
                }
                column(PortOfLoding2; PortOfLoding2) { }
                column(PortOfLoding; PortOfLoding) { }



                dataitem("Sales Shipment Line"; "Sales Shipment Line")
                {

                    DataItemLink = "Document No." = field("Sales Shipment No."), "Location Code" = field("Location Code");
                    DataItemLinkReference = "Warehouse Delivery Inst Header";
                    DataItemTableView = sorting("Document No.");

                    column(SrNo_gInt; SrNo_gInt) { }
                    column(No; "No.") { }
                    column(Description; Description) { }
                    column(Origin; Origintext) { }
                    column(Net_Weight; "Net Weight") { }
                    column(Gross_Weight; "Gross Weight") { }
                    column(Unit_Volume; "Unit Volume") { }
                    column(LineHSNCode; LineHSNCode) { }
                    column("ViscosityIndexImprover"; '') { }
                    column(TotalNetWeight_gDec; TotalNetWeight_gDec) { }
                    column(TotalGrossWeight_gDec; TotalGrossWeight_gDec) { }
                    column(PrimPackUOM_gTxt; PrimPackUOM_gTxt) { }
                    column(PrimPackQty_gDec; PrimPackQty_gDec) { }
                    column(SecondaryPackQty_gDec; SecondaryPackQty_gDec) { }

                    column(ILEPrimPackUOM_gTxt; ILEPrimPackUOM_gTxt) { }
                    column(UnitofMeasureCode; UOMDesc_gTxt) { }
                    column(UNno_gCod; UNno_gCod) { }
                    column(HazClass_gTxt; HazClass_gTxt) { }
                    column(FooterTotalGrossWeight_gDec; FooterTotalGrossWeight_gDec) { }
                    column(FooterTotalNetWeight_gDec; FooterTotalNetWeight_gDec) { }
                    column(Qty_gInt; "Quantity") { }
                    column(Unit_of_Measure; "Unit of Measure") { }
                    column(UOM_gTxt; UOM_gTxt) { }

                    column(PalletGrossWeight_gInt; PalletGrossWeight_gInt) { }
                    column(PalletNetWeight_gInt; PalletNetWeight_gInt) { }
                    column(Genericname_gTxt; Genericname_gTxt) { }

                    trigger OnPreDataItem()
                    begin
                        SrNo_gInt := 0;
                    end;

                    trigger OnAfterGetRecord()
                    var
                        ILE_lRec: Record "Item Ledger Entry";
                        ItemVar_lRec: Record "Item Variant";
                        UOMmaster_lRec: Record "Unit of Measure";
                        ItemUnitofmeasure_lRec: Record "Item Unit of Measure";
                        UnitofMeasure_lRec: Record "Unit of Measure";
                        PackagingLines_lRec: Record "Packaging detail Line";
                        PrimaryLevel_lInt: Integer;
                        PrimaryUOM_lCode: Code[20];
                        GenericName_lRec: Record KMP_TblGenericName;
                    begin
                        SrNo_gInt := SrNo_gInt + 1;
                        Origintext := '';
                        clear(UOMDesc_gTxt);

                        SecondaryPackQty_gDec := Round("Sales Shipment Line".Quantity, 0.01);

                        UOMmaster_lRec.Reset();
                        if UOMmaster_lRec.get("Sales Shipment Line"."Unit of Measure Code") then
                            UOMDesc_gTxt := UOMmaster_lRec.Description
                        else
                            UOMDesc_gTxt := '';

                        // CountryReg_gRec.Reset();
                        // if CountryReg_gRec.get("Sales Shipment Header"."Country of Origin") then ////AS-020425-O
                        //     Origintext := CountryReg_gRec.Name;

                        //AS-020425-NS
                        CountryReg_gRec.Reset();
                        if CountryReg_gRec.get("Sales Shipment Line".CountryOfOrigin) then
                            Origintext := CountryReg_gRec.Name;

                        //AS-020425-NE

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
                            // ILE_lRec.SetFilter(CustomLotNumber, LotNo_gTxt.Replace('<br/>', '|'));
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
                            // ILE_lRec.SetFilter(CustomLotNumber, LotNo_gTxt.Replace('<br/>', '|'));
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




                        if Item_gRec.Get("No.") then
                            if Item_gRec."IMCO Class" <> '' then begin
                                IMOClassMaster_gRec.Get(Item_gRec."IMCO Class");
                                UNno_gCod := IMOClassMaster_gRec.Description;
                                HazClass_gTxt := IMOClassMaster_gRec.Class;
                            end;
                        if Item_gRec.GenericName <> '' then begin
                            GenericName_lRec.Get(Item_gRec.GenericName);
                            Genericname_gTxt := GenericName_lRec.Description;
                        end;
                        // Genericname_gTxt := Item_gRec.GenericName;
                        // if IMOClassMaster_gRec.Get(UNno_gCod) then
                        //     HazClass_gTxt := IMOClassMaster_gRec.Class;
                        // UNno_gCod := Item_gRec."IMCO Class";


                        if ("Sales Shipment Line"."Unit of Measure" <> '') then
                            if UnitofMeasure_gRec.Get("Sales Shipment Line"."Unit of Measure Code") then begin
                                UOM_gTxt := UnitofMeasure_gRec.Description;
                            end;


                        PalletNetWeight_gInt := "Sales Shipment Line"."Net Weight";
                        //PalletGrossWeight_gInt:= "Sales Shipment Line"."Net Weight" + "Sales Shipment Line".


                        TotalNetWeight_gDec += "Sales Shipment Line"."Net Weight";
                        TotalGrossWeight_gDec += "Sales Shipment Line"."Gross Weight";

                        FooterTotalNetWeight_gDec += TotalNetWeight_gDec;
                        FooterTotalGrossWeight_gDec += TotalGrossWeight_gDec;
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    Warehouseinstr_lRec: Record "Warehouse Delivery Inst Header";
                begin
                    // warehouseNo_gcod := '';

                    if "Sales Shipment Header"."Exit Point" <> '' then begin
                        if ExitpointRec.Get("Sales Shipment Header"."Exit Point") then
                            PortOfLoding2 := ExitpointRec.Description;
                    end;

                    AreaRec.Reset();
                    IF AreaRec.Get("Sales Shipment Header"."Area") then
                        PortOfLoding := AreaRec.Text;

                    // PortOfLoding := "Sales Shipment Header".CountryOfLoading;  //22
                    // if CustAltAddrBool then begin
                    //     clear(PortOfLoding);
                    //     IF AreaRec.Get("Sales Shipment Header"."Customer Port of Discharge") then
                    //         PortOfLoding := AreaRec.Text;
                    // end;


                    //Shipper Address
                    Shipper_gTxt := '';
                    if CompanyInfo_gRec.Name <> '' then
                        Shipper_gTxt += '<b>' + CompanyInfo_gRec.Name + '</b>';
                    if CompanyInfo_gRec.Address <> '' then
                        Shipper_gTxt += '<br/>' + CompanyInfo_gRec.Address;
                    if CompanyInfo_gRec."Address 2" <> '' then
                        Shipper_gTxt += '<br/>' + CompanyInfo_gRec."Address 2";
                    if CompanyInfo_gRec.City <> '' then
                        Shipper_gTxt += '<br/>' + CompanyInfo_gRec.City;
                    if CompanyInfo_gRec."Country/Region Code" <> '' then begin
                        if Country_gRec.Get(CompanyInfo_gRec."Country/Region Code") then
                            Shipper_gTxt += ', ' + Country_gRec.Name;
                    end;
                    if CompanyInfo_gRec."Registration No." <> '' then
                        Shipper_gTxt += '<br/>' + 'Trade License No.  ';

                    // Warehouseinstr_lRec.Reset();
                    // Warehouseinstr_lRec.SetRange("Sales Shipment No.", "Sales Shipment Header"."No.");
                    // if Warehouseinstr_lRec.FindFirst() then
                    //     warehouseNo_gcod := Warehouseinstr_lRec."WDI No";


                    //Customer Address
                    CustAddr_gTxt := '';
                    if "Sales Shipment Header"."Sell-to Customer Name" <> '' then
                        CustAddr_gTxt += '<b>' + "Sales Shipment Header"."Sell-to Customer Name" + '</b>';
                    // CustAddr_gTxt += '<br/>' + 'Plot No: ';
                    if "Sales Shipment Header"."Sell-to Address" <> '' then
                        CustAddr_gTxt += '<br/>' + "Sales Shipment Header"."Sell-to Address";
                    if "Sales Shipment Header"."Sell-to Address 2" <> '' then
                        CustAddr_gTxt += '<br/>' + "Sales Shipment Header"."Sell-to Address 2";
                    if "Sales Shipment Header"."Sell-to City" <> '' then
                        CustAddr_gTxt += '<br/>' + "Sales Shipment Header"."Sell-to City";
                    if "Sales Shipment Header"."Sell-to Country/Region Code" <> '' then begin
                        if Country_gRec.Get(CompanyInfo_gRec."Country/Region Code") then
                            CustAddr_gTxt += ', ' + Country_gRec.Name;
                    end;
                    // if "Sales Shipment Header".t<> '' then
                    CustAddr_gTxt += '<br/>' + 'Trade License No. ';

                    // //Logistic Coordinator
                    // if "Sales Shipment Header"."Salesperson Code" <> '' then begin
                    //     if Salesperson_gRec.Get("Sales Shipment Header"."Salesperson Code") then
                    //         LogisticCoordinator_gTxt := Salesperson_gRec.Name + ' at Mob: ' + Salesperson_gRec."Phone No." + '.';
                    // end;
                    // //Location Address
                    // LocationAddr_gRec.Reset();
                    // if LocationAddr_gRec.Get("Location Code") then begin
                    //     LocationAddr_gTxt := '';
                    //     if LocationAddr_gRec.Name <> '' then
                    //         LocationAddr_gTxt += '<b>' + LocationAddr_gRec.Name + '</b>' + '<br/> ';
                    //     if LocationAddr_gRec.Contact <> '' then
                    //         LocationAddr_gTxt += LocationAddr_gRec.Contact + '<br/> ';
                    //     if LocationAddr_gRec.Address <> '' then
                    //         LocationAddr_gTxt += LocationAddr_gRec.Address;
                    //     if LocationAddr_gRec."Address 2" <> '' then
                    //         LocationAddr_gTxt += LocationAddr_gRec."Address 2";
                    //     if LocationAddr_gRec.City <> '' then
                    //         LocationAddr_gTxt += LocationAddr_gRec.City + ', ';
                    //     if LocationAddr_gRec."Country/Region Code" <> '' then begin
                    //         if Country_gRec.Get(CompanyInfo_gRec."Country/Region Code") then
                    //             LocationAddr_gTxt += Country_gRec.Name;
                    //     end;
                    //     if LocationAddr_gRec."Phone No." <> '' then
                    //         LocationAddr_gTxt += '<br/> ' + 'Mob: ' + LocationAddr_gRec."Phone No.";
                    //     if LocationAddr_gRec."Phone No. 2" <> '' then
                    //         LocationAddr_gTxt += '<br/> ' + 'Tel.: ' + LocationAddr_gRec."Phone No. 2";
                    // end;

                    SalesInvLine_gRec.Reset();
                    SalesInvLine_gRec.SetRange("Shipment No.", "No.");
                    if SalesInvLine_gRec.FindLast() then begin
                        Reference_Invoice_No := SalesInvLine_gRec."Document No.";
                    end;

                    //Shipping Details
                    ShippmentAddr_gTxt := '';
                    // if EntryExitPoint_gRec.Get("Sales Shipment Header"."Loading Port") then begin
                    //     if "Sales Shipment Header"."Loading Port" <> '' then
                    ShippmentAddr_gTxt += 'POL: ' + PortOfLoding2;
                    //end;
                    //if EntryExitPoint_gRec.Get("Sales Shipment Header"."Port of Discharge") then begin
                    //    if "Sales Shipment Header"."Port of Discharge" <> '' then
                    ShippmentAddr_gTxt += '<br/>' + 'POD: ' + PortOfLoding;
                    //end;
                    if Format("Sales Shipment Header".Carriage) <> '' then
                        ShippmentAddr_gTxt += '<br/>' + 'Carrier: ' + Format("Sales Shipment Header".Carriage);
                    ShippmentAddr_gTxt += '<br/>' + 'Mixed Product Loading: ';
                    ShippmentAddr_gTxt += '<br/>' + 'Invoice No.: ' + Reference_Invoice_No;
                    ShippmentAddr_gTxt += '<br/>' + 'SO No.: ' + "Sales Shipment Header"."Order No.";
                end;
            }

            trigger OnAfterGetRecord()
            var
                Location_lRec: Record Location;
                ShippingAgent_lRec: Record "Shipping Agent";
            begin
                //Location Address
                LocationAddr_gRec.Reset();
                if LocationAddr_gRec.Get("Location Code") then begin
                    LocationAddr_gTxt := '';
                    if LocationAddr_gRec.Name <> '' then
                        LocationAddr_gTxt += '<b>' + LocationAddr_gRec.Name + '</b>';
                    if LocationAddr_gRec.Contact <> '' then
                        LocationAddr_gTxt += '<br/> ' + LocationAddr_gRec.Contact;
                    if LocationAddr_gRec.Address <> '' then
                        LocationAddr_gTxt += '<br/> ' + LocationAddr_gRec.Address;
                    if LocationAddr_gRec."Address 2" <> '' then
                        LocationAddr_gTxt += '<br/> ' + LocationAddr_gRec."Address 2";
                    if LocationAddr_gRec.City <> '' then
                        LocationAddr_gTxt += '<br/> ' + LocationAddr_gRec.City;
                    if LocationAddr_gRec."Country/Region Code" <> '' then begin
                        if Country_gRec.Get(CompanyInfo_gRec."Country/Region Code") then
                            LocationAddr_gTxt += ', ' + Country_gRec.Name;
                    end;
                    if LocationAddr_gRec."Phone No." <> '' then
                        LocationAddr_gTxt += '<br/> ' + 'Mob: ' + LocationAddr_gRec."Phone No.";
                    if LocationAddr_gRec."Phone No. 2" <> '' then
                        LocationAddr_gTxt += '<br/> ' + 'Tel.: ' + LocationAddr_gRec."Phone No. 2";
                end;
                // //Logistic Coordinator
                if "Warehouse Delivery Inst Header"."Location Code" <> '' then begin
                    if Location_lRec.Get("Warehouse Delivery Inst Header"."Location Code") then begin
                        if Location_lRec."Contact" <> '' then
                            LogisticCoordinator_gTxt := Location_lRec."Contact";
                        if Location_lRec."Phone No." <> '' then
                            LogisticCoordinator_gTxt += ' at Mob: ' + Location_lRec."Phone No." + '.';
                    end;
                end;

                if ShippingAgent_lRec.Get("Shipping Agent") then begin
                    LogsticAndShippingAgent_gTxt := '';
                    if "Warehouse Delivery Inst Header"."Ship Agent Contact Name" <> '' then
                        LogsticAndShippingAgent_gTxt += "Warehouse Delivery Inst Header"."Ship Agent Contact Name" + '<br/> ';
                    if "Warehouse Delivery Inst Header"."Shipping Agent Name" <> '' then
                        LogsticAndShippingAgent_gTxt += '<b>' + "Warehouse Delivery Inst Header"."Shipping Agent Name" + '</b>';

                    if ShippingAgent_lRec.Address <> '' then
                        LogsticAndShippingAgent_gTxt += '<br/> ' + ShippingAgent_lRec.Address;
                    if ShippingAgent_lRec."Address2" <> '' then
                        LogsticAndShippingAgent_gTxt += '<br/> ' + ShippingAgent_lRec."Address2";
                    if ShippingAgent_lRec.City <> '' then
                        LogsticAndShippingAgent_gTxt += '<br/> ' + ShippingAgent_lRec.City;
                    if ShippingAgent_lRec."Country" <> '' then begin
                        if Country_gRec.Get(ShippingAgent_lRec."Country") then
                            LogsticAndShippingAgent_gTxt += ', ' + Country_gRec.Name;
                    end;
                    if "Warehouse Delivery Inst Header"."Ship Agent Phone No" <> '' then
                        LogsticAndShippingAgent_gTxt += '<br/> ' + 'Tel: ' + "Warehouse Delivery Inst Header"."Ship Agent Phone No";
                    if "Warehouse Delivery Inst Header"."Ship Agent Mobile No." <> '' then
                        LogsticAndShippingAgent_gTxt += '<br/> ' + 'Mob: ' + "Warehouse Delivery Inst Header"."Ship Agent Mobile No.";
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

            }
        }

    }
    labels
    {
        ShippingInstruction_gLbl = 'SHIPPING INSTRUCTION';
        SINo_gLbl = 'SI No.';
        Date_gLbl = 'Date:';
    }
    trigger OnPreReport()

    begin
        CompanyInfo_gRec.Get;
        CompanyInfo_gRec.CalcFields(Picture, Logo);

        //Company Information
        CompanyAddr_gTxt := '';
        if CompanyInfo_gRec.Name <> '' then
            CompanyAddr_gTxt += '<b>' + CompanyInfo_gRec.Name + '</b>' + '<br/>';
        if CompanyInfo_gRec.Address <> '' then
            CompanyAddr_gTxt += CompanyInfo_gRec.Address;
        if CompanyInfo_gRec."Address 2" <> '' then
            CompanyAddr_gTxt += CompanyInfo_gRec."Address 2";
        if CompanyInfo_gRec.City <> '' then
            CompanyAddr_gTxt += CompanyInfo_gRec.City;
        if CompanyInfo_gRec."Country/Region Code" <> '' then
            CompanyAddr_gTxt := CompanyAddr_gTxt + ', ' + CompanyInfo_gRec."Country/Region Code" + '<br/> ';
        // if CompanyInfo_gRec."Country/Region Code" <> '' then begin
        //     // if Country_gRec.Get(CompanyInfo_gRec."Country/Region Code") then
        //     //     CompanyAddr_gTxt += Country_gRec.Name + '<br/> ';
        //     CompanyAddr_gTxt += CompanyInfo_gRec."Country/Region Code" + '<br/> ';
        // end;
        if CompanyInfo_gRec."Phone No." <> '' then
            CompanyAddr_gTxt += 'Tel.: ' + CompanyInfo_gRec."Phone No." + '<br/> ';
        if CompanyInfo_gRec."Home Page" <> '' then
            CompanyAddr_gTxt += 'Web: ' + CompanyInfo_gRec."Home Page" + '<br/> ';
        if CompanyInfo_gRec."VAT Registration No." <> '' then
            CompanyAddr_gTxt += 'TRN: ' + CompanyInfo_gRec."VAT Registration No.";


    end;

    var

        LogsticAndShippingAgent_gTxt: Text;
        // warehouseNo_gcod: Code[20];
        CompanyInfo_gRec: Record "Company Information";
        Customer_gRec: Record Customer;
        Item_gRec: Record Item;
        CountryReg_gRec: Record "Country/Region";
        LocationAddr_gRec: Record Location;
        Country_gRec: Record "Country/Region";
        EntryExitPoint_gRec: Record "Entry/Exit Point";
        Salesperson_gRec: Record "Salesperson/Purchaser";
        IMOClassMaster_gRec: Record "IMCO Class Master";
        SalesShipmentLine_gRec: Record "Sales Shipment Line";
        SalesShipmentHeader_gRec: Record "Sales Shipment Header";
        UnitofMeasure_gRec: Record "Unit of Measure";
        SalesInvLine_gRec: Record "Sales Invoice Line";
        CompanyAddr_gTxt: Text;
        WarehouseAddr_gTxt: Text;
        CustAddr_gTxt: Text;
        SrNo_gInt: Integer;
        HSCode_gTXt: Text;
        Origintext: Text[50];
        LocationAddr_gTxt: Text;
        ShippmentAddr_gTxt: Text;
        Shipper_gTxt: Text;
        PrimPackUOM_gTxt: Text;
        PrimPackQty_gDec: Decimal;
        SecondaryPackQty_gDec: Decimal;
        UOMDesc_gTxt: Text;
        ILEPrimPackUOM_gTxt: Text;
        ILEPrimPack_gTxt: Text;
        LogisticCoordinator_gTxt: Text;
        TotalNetWeight_gDec: Decimal;
        TotalGrossWeight_gDec: Decimal;
        FooterTotalNetWeight_gDec: Decimal;
        FooterTotalGrossWeight_gDec: Decimal;

        UNno_gCod: Text;
        HazClass_gTxt: Text;
        UOM_gTxt: Text;
        Qty_gInt: Integer;
        PalletNetWeight_gInt: Decimal;
        PalletGrossWeight_gInt: Decimal;
        Reference_Invoice_No: Text;
        PortOfLoding: Text[50];
        AreaRec: Record "Area";
        CustAltAddrBool: Boolean;
        Genericname_gTxt: Text;
        ExitpointRec: Record 282;
        PortOfLoding2: Text[250];


}