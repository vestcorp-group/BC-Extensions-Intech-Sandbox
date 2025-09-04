// report 53009 "3_Kemipex Packing List"
// {
//     Caption = 'Kemipex Packing List';
//     DefaultLayout = RDLC;
//     RDLCLayout = 'Reports/PackingList.rdl';
//     UsageCategory = Administration;
//     ApplicationArea = All;

//     dataset
//     {
//         dataitem("Sales Shipment Header"; "Sales Shipment Header")
//         {
//             DataItemTableView = SORTING("No.")
//                                 ORDER(Ascending);
//             RequestFilterFields = "No.", "Posting Date";
//             column(No_TH; "No.") { }
//             column(CountryCode; CountryCode) { }
//             column(PostingDate_TH; "Posting Date") { }
//             column(TransferfromName_TH; LocationFrom.Name) { }
//             column(TransferfromAddress_TH; LocationFrom.Address) { }
//             column(TransferfromAddress2_TH; LocationFrom."Address 2") { }
//             column(TransferfromCity_TH; LocationFrom.City) { }
//             column(Transfer_from_Post_Code; LocationFrom."Post Code") { }
//             column(Transfer_to_Post_Code; LocationTo."Post Code") { }
//             column(TrsffromCountryRegionCode_TH; LocationFrom."Country/Region Code") { }
//             column(TrFromCountryName; FromCountryName) { }
//             column(TransfertoName_TH; LocationTo.Name) { }
//             column(TransfertoAddress_TH; LocationTo.Address) { }
//             column(TransfertoAddress2_TH; LocationTo."Address 2") { }
//             column(TransfertoCity_TH; LocationTo.City) { }
//             column(TrsftoCountryRegionCode_TH; LocationTo."Country/Region Code") { }
//             column(TrToCountryName; ToCountryName) { }
//             column(FromAddressToggle; FromAddressToggle) { }
//             column(ToAddressToggle; ToAddressToggle) { }
//             column(Name_CI; companyInfo.Name) { }
//             column(Address_CI; companyInfo.Address) { }
//             column(Address2_CI; companyInfo."Address 2") { }
//             column(PostCode_CI; companyInfo."Post Code") { }
//             column(City_CI; companyInfo.City) { }
//             column(CountryRegion_CI; companyInfo."Country/Region Code") { }
//             column(TotalQty; TotalQty) { }
//             column(LineUnMerge; LineUnMerge) { }
//             column(CompanyInfo_Exporter; CompanyInfo."E-Mirsal Code") { }
//             column(CompanyInfo_Picture; CompanyInfo.Picture) { }
//             column(CompanyInfo_Stamp; CompanyInfo.Stamp) { }
//             column(CompanyInfo_Name; CompanyInfo.Name) { }
//             column(CompanyInfo_Address; CompanyInfo.Address) { }
//             column(CompanyInfo_Address2; CompanyInfo."Address 2") { }
//             column(CompanyInfo_City; CompanyInfo.City) { }
//             column(CompanyInfo_Phoneno; CompanyInfo."Phone No.") { }
//             column(CompanyInfo_Email; CompanyInfo."E-Mail") { }
//             column(CompanyInfo_HomePage; CompanyInfo."Home Page") { }
//             column(TRNNo; CompanyInfo."VAT Registration No.") { }
//             column(CustAddrShipto_Arr1; CustAddrShipto_Arr[1]) { }
//             column(CustAddrShipto_Arr2; CustAddrShipto_Arr[2]) { }
//             column(CustAddrShipto_Arr3; CustAddrShipto_Arr[3]) { }
//             column(CustAddrShipto_Arr4; CustAddrShipto_Arr[4]) { }
//             column(CustAddrShipto_Arr5; CustAddrShipto_Arr[5]) { }
//             column(CustAddrShipto_Arr6; CustAddrShipto_Arr[6]) { }
//             column(CustAddrShipto_Arr7; CustAddrShipto_Arr[7]) { }
//             column(CustAddrShipto_Arr8; CustAddrShipto_Arr[8]) { }

//             dataitem("Sales Shipment Line"; "Sales Shipment Line")
//             {
//                 DataItemLink = "Document No." = FIELD("No.");
//                 DataItemTableView = SORTING("Document No.", "Line No.")
//                                     ORDER(Ascending);
//                 column(LineNo_TransferLine; "Line No.")
//                 { }
//                 column(UnitofMeasureCode; "Base UOM 2") { }
//                 column(LotNo_gcod; LotNo_gcod)
//                 { }
//                 column(NetWeight_gDec; NetWeight_gDec) { }
//                 column(GrossWeight_gDec; GrossWeight_gDec) { }
//                 column(ILEGrosswt_gDec; ILEGrosswt_gDec) { }
//                 column(ILENetwt_gDec; ILENetwt_gDec) { }
//                 column(ILENetwt_gTxt; ILENetwt_gTxt) { }
//                 column(ILEGrosswt_gTxt; ILEGrosswt_gTxt) { }
//                 column(ILEPrimPackQty_gDec; ILEPrimPackQty_gDec) { }
//                 column(PrimPackQty_gDec; PrimPackQty_gDec) { }
//                 column(ILEPrimPack_gTxt; ILEPrimPack_gTxt) { }
//                 column(ILEPrimPackUOM_gTxt; ILEPrimPackUOM_gTxt) { }

//                 column(SerialNo; SerialNo) { }
//                 column(ItemNo_TL; "No.") { }
//                 column(UnitofMeasure_TL; BaseUOMVar) { }
//                 column(Description_TL; Description) { }
//                 column(Variant_Code; "Variant Code") { }
//                 column(Quantity_TL; "Quantity (Base)") { }
//                 column(QuantityBase_TL; "Quantity (Base)") { }
//                 column(AlterNateUOMCode; UOMDesc) { }
//                 column(DecimalAllowed; DecimalAllowed) { }
//                 column(AlternateUOMQty; "Quantity (Base)" / AlternateQtyUOM) { }
//                 column(HSCode; HSCodeVar) { }
//                 column(Origin; OriginVar) { }
//                 column(Generic_Name; GenericNameVar) { }
//                 column(TotalAltQty; ("Quantity (Base)" / AlternateQtyUOM)) { }
//                 column(AltQtytransferline; "Quantity (Base)" / AlternateQtyUOM) { }
//                 column(LotExist; LotExist) { }
//                 column(Packing; Packing_Txt)
//                 {
//                 }
//                 column(Desc_gTxt; Desc_gTxt) { }

//                 dataitem(Integer; Integer)
//                 {
//                     DataItemTableView = SORTING(Number)
//                                         ORDER(Ascending)
//                                         WHERE(Number = const(1));

//                     column(AlternateUOMQty11; "Sales Shipment Line"."Quantity (Base)" / AlternateQtyUOM) { }
//                     column(QuantityBase_TL1; "Sales Shipment Line"."Quantity (Base)") { }
//                     column(Net_Weight; NetWeight) { }
//                     column(Gross_Weight; GrossWeight) { }
//                 }

//                 trigger OnAfterGetRecord()
//                 var
//                     SalesHdr_lRec: Record "Sales Header";
//                     Item: Record Item;
//                     VariantRec: Record "Item Variant";
//                     Generic: Record KMP_TblGenericName;
//                     CountryOrRegion: Record "Country/Region";
//                     UnitofMeasure: Record "Unit of Measure";
//                     RecVariant: Record "Item Variant";
//                     CountryRegionL: Record "Country/Region";
//                     ShipToAdd: Record "Ship-to Address";
//                     ILE_lRec: Record "Item Ledger Entry";
//                     UOMmaster_lRec: Record "Unit of Measure";
//                     IMCO_lRec: Record "IMCO Class Master";
//                     ItemVar_lRec: Record "Item Variant";
//                 begin
//                     //Serial No. Auto Increament
//                     SerialNo := SerialNo + 1;
//                     Clear(GenericNameVar);
//                     Clear(OriginVar);
//                     Clear(HSCodeVar);
//                     Clear(BaseUOMVar);
//                     Clear(LotNo_gcod);
//                     NetWeight_gDec := "Sales Shipment Line"."Net Weight";
//                     GrossWeight_gDec := "Sales Shipment Line"."Gross Weight";
//                     PrimPackUOM_gTxt := "Sales Shipment Line"."Unit of Measure";
//                     PrimPackQty_gDec := "Sales Shipment Line".Quantity;
//                     ILE_lRec.Reset();
//                     // ILE_lRec.SetRange("Item No.", "Sales Shipment Line"."No.");
//                     ILE_lRec.SetRange("Document No.", "Sales Shipment Header"."No.");
//                     ILE_lRec.SetRange("Document Line No.", "Sales Shipment Line"."Line No.");
//                     if ILE_lRec.Findset() THEN begin
//                         repeat
//                             ILENetwt_gDec := ILE_lRec."Net Weight 2";
//                             ILEGrosswt_gDec := ILE_lRec."Gross Weight 2";
//                             ILEPrimPackQty_gDec := ILE_lRec.Quantity;

//                             if LotNo_gcod = '' then
//                                 LotNo_gcod := ILE_lRec.CustomLotNumber
//                             else
//                                 LotNo_gcod += '<br/>' + ILE_lRec.CustomLotNumber;
//                             if ILENetwt_gTxt = '' then
//                                 ILENetwt_gTxt := Format(ILE_lRec."Net Weight 2")
//                             else
//                                 ILENetwt_gTxt += '<br/>' + Format(ILE_lRec."Net Weight 2");
//                             if ILEGrosswt_gTxt = '' then
//                                 ILEGrosswt_gTxt := Format(ILE_lRec."Gross Weight 2")
//                             else
//                                 ILEGrosswt_gTxt += '<br/>' + Format(ILE_lRec."Gross Weight 2");

//                             if ILEPrimPack_gTxt = '' then begin
//                                 ILEPrimPack_gTxt := Format(ILE_lRec.Quantity);
//                                 UOMmaster_lRec.Reset();
//                                 if UOMmaster_lRec.Get(ILE_lRec."Unit of Measure Code") then
//                                     ILEPrimPack_gTxt += ' ' + UOMmaster_lRec.Description;
//                             end else begin
//                                 ILEPrimPack_gTxt += '<br/>' + Format(ILE_lRec.Quantity) + ' ';
//                                 UOMmaster_lRec.Reset();
//                                 if UOMmaster_lRec.Get(ILE_lRec."Unit of Measure Code") then
//                                     ILEPrimPack_gTxt += UOMmaster_lRec.Description;
//                             end;
//                         until ILE_lRec.Next() = 0;
//                     end;
//                     Desc_gTxt += '<b>Item No. ' + "Sales Shipment Line"."No." + '</b>';
//                     // if "Sales Shipment Line"."Description 2" <> '' then
//                     Item.Reset();
//                     Item.get("Sales Shipment Line"."No.");
//                     Desc_gTxt += '<br/>' + Item.GenericName;

//                     Desc_gTxt += '<br/>' + 'Net Weight: ' + Format(Item."Net Weight");
//                     //if Item."Gross Weight" <> 0 then
//                     Desc_gTxt += '<br/>' + 'Gross Weight: ' + Format(Item."Gross Weight");
//                     ItemVar_lRec.Reset();
//                     if ItemVar_lRec.get(Item."No.") then begin
//                         // if ItemVar_lRec."Packing Description" <> '' then
//                         Desc_gTxt += '<br/>' + 'Packing: ' + ItemVar_lRec."Packing Description";
//                     end else
//                         Desc_gTxt += '<br/>' + 'Packing: ';
//                     // if Item."IMCO Class" <> '' then
//                     IMCO_lRec.Reset();
//                     if IMCO_lRec.Get(Item."IMCO Class") then begin
//                         Desc_gTxt += '<br/>' + 'UN No.: ' + IMCO_lRec.Description;
//                         Desc_gTxt += '<br/>' + 'Haz. Class: ' + IMCO_lRec.Class;
//                     end
//                     else begin
//                         Desc_gTxt += '<br/>' + 'UN No.: ';
//                         Desc_gTxt += '<br/>' + 'Haz. Class: ';
//                     end;
//                     //if "Sales Shipment Line".CustomBOENumber <> '' then
//                     Desc_gTxt += '<br/><br/>' + 'Rework: <br/>' + "Sales Shipment Line".CustomBOENumber;


//                     if Item.Get("Sales Shipment Line"."No.") then begin
//                         if Generic.Get(Item.GenericName) then
//                             GenericNameVar := Generic.Description;
//                         if CountryOrRegion.Get(Item."Country/Region of Origin Code") then
//                             OriginVar := CountryOrRegion.Name;
//                         HSCodeVar := Item."Tariff No.";
//                         BaseUOMVar := Item."Base Unit of Measure";
//                         if "Sales Shipment Line"."Variant Code" <> '' then begin
//                             RecVariant.Get("Sales Shipment Line"."No.", "Sales Shipment Line"."Variant Code");
//                             if RecVariant.HSNCode <> '' then begin
//                                 HSCodeVar := RecVariant.HSNCode;
//                             end else begin
//                                 HSCodeVar := Item."Tariff No.";
//                             end;
//                             if RecVariant.CountryOfOrigin <> '' then begin
//                                 OriginVar := RecVariant.CountryOfOrigin;
//                             end else begin
//                                 OriginVar := CountryOrRegion.Name;
//                             end;
//                         end;
//                     end;

//                     //Getting the Minimum Alternate UOM Qty. and its code
//                     DecimalAllowed := false;
//                     AlternateQtyUOM := 0;
//                     UOMCode := '';
//                     UOMDesc := '';
//                     ItemUnitMeasure.SETRANGE("Item No.", "No.");
//                     /* if "Variant Code" <> '' then
//                         ItemUnitMeasure.SetRange("Variant Code", "Variant Code")
//                     else
//                         ItemUnitMeasure.SetRange("Variant Code", ''); */

//                     if "Variant Code" <> '' then begin
//                         If ItemUnitMeasure."Variant Code" = "Variant Code" then begin
//                             ItemUnitMeasure.SetRange("Variant Code", "Variant Code");
//                         end else begin
//                             ItemUnitMeasure.SetRange("Variant Code", '');
//                         end
//                     end else begin
//                         ItemUnitMeasure.SetRange("Variant Code", '');
//                     end;

//                     //AS-NS 17-01-2025

//                     if "Variant Code" <> '' then begin // add by bayas
//                         VariantRec.Get("No.", "Variant Code");
//                         if VariantRec."Packing Description" <> '' then begin
//                             Packing_Txt := VariantRec."Packing Description";
//                         end else begin
//                             Packing_Txt := Item."Description 2";
//                         end;
//                     end else begin
//                         Packing_Txt := Item."Description 2";
//                     end;

//                     //AS-NE 17-01-2025

//                     IF ItemUnitMeasure.FINDFIRST THEN BEGIN
//                         AlternateQtyUOM := ItemUnitMeasure."Qty. per Unit of Measure";
//                         UOMCode := ItemUnitMeasure.Code;
//                         IF (UnitofMeasure.GET(UOMCode)) and (UnitofMeasure."Decimal Allowed") then
//                             DecimalAllowed := true;
//                         REPEAT
//                             IF AlternateQtyUOM > ItemUnitMeasure."Qty. per Unit of Measure" THEN BEGIN
//                                 AlternateQtyUOM := ItemUnitMeasure."Qty. per Unit of Measure";
//                                 UOMCode := ItemUnitMeasure.Code;
//                                 IF (UnitofMeasure.GET(UOMCode)) and (UnitofMeasure."Decimal Allowed") then
//                                     DecimalAllowed := true;
//                             END;
//                         UNTIL ItemUnitMeasure.NEXT = 0;
//                     END;
//                     UOMDesc := UnitofMeasure.Description;
//                     //LotExist := false;

//                     // ItemLedgerEntry_Rec.Reset();
//                     // ItemLedgerEntry_Rec.SetRange("Document Type", ItemLedgerEntry_Rec."Document Type"::"Sales Shipment");
//                     // ItemLedgerEntry_Rec.SetRange("Document No.", "Sales Shipment Line"."Document No.");
//                     // ItemLedgerEntry_Rec.SetRange("Document Line No.", "Sales Shipment Line"."Line No.");
//                     // if ItemLedgerEntry_Rec.FindSet() then begin
//                     //     LotNo_gcod := ItemLedgerEntry_Rec.CustomLotNumber;
//                     //     LotExist := true;
//                     // end;



//                 end;
//             }


//             trigger OnAfterGetRecord()
//             var
//                 transferline: Record "Transfer Line";
//                 SalesHdr_lRec: Record "Sales Header";
//                 CountryRegionL: Record "Country/Region";
//                 ShipToAdd: Record "Ship-to Address";
//                 FormatAddr: Codeunit "Format Address";
//                 Cust_Lrec: record Customer;
//             begin
//                 CLEAR(TotalAltQty);
//                 CLEAR(TotalQty);


//                 transferline.Reset();
//                 transferline.SETRANGE("Document No.", "No.");
//                 IF transferline.FindSet() then begin
//                     transferline.CalcSums("Quantity (Base)");
//                     TotalQty := transferline."Quantity (Base)";
//                 end;


//                 Clear(CustAddrShipTo_Arr);
//                 CustAddrShipTo_Arr[1] := "Bill-to Name";
//                 CustAddrShipTo_Arr[2] := "Bill-to Address";
//                 CustAddrShipTo_Arr[3] := "Bill-to Address 2";
//                 CustAddrShipTo_Arr[4] := "Bill-to City";
//                 CustAddrShipTo_Arr[5] := "Bill-to Post Code";
//                 if CountryRegionL.Get("Bill-to Country/Region Code") then
//                     CustAddrShipTo_Arr[6] := CountryRegionL.Name;
//                 Cust_Lrec.Reset();
//                 if Cust_Lrec.Get("Bill-to Customer No.") and (Cust_Lrec."Phone No." <> '') then
//                     CustAddrShipTo_Arr[7] := 'Tel: ' + Cust_Lrec."Phone No."
//                 else
//                     if "Sell-to Phone No." <> '' then
//                         CustAddrShipTo_Arr[7] := 'Tel: ' + "Sell-to Phone No.";
//                 //end;
//                 CompressArray(CustAddrShipTo_Arr);
//             end;
//         }
//     }

//     requestpage
//     {
//         SaveValues = true;

//         layout
//         {
//             area(content)
//             {

//             }
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//         Tel_Lbl = 'Tel:';
//         Web_Lbl = 'Web:';
//         TRN_Lbl = 'TRN:';
//         Report_Lbl = 'PACKING LIST';
//         Report_Lbl1 = ' Order';
//         Report_Lbl2 = ' (Warehouse to Warehouse)';
//         Authority_Lbl = 'Authorized Signatory:';
//         Stamp_Lbl = 'Stamp:';
//         Date_Lbl = 'Date:';
//         Remarks_Lbl = 'Both parties confirm with their signature that all the products are Delivered/Received in perfect condition. Please explain here if any discrepancy exists.';
//         TrFrom_Lbl = 'Bill To';
//         TrTo_Lbl = 'Transfer To:';
//         SerialNo_Lbl = 'No.';
//         ItemNo_Lbl = 'Item No.';
//         Desc_Lbl = 'Description';
//         LotNo_Lbl = 'Lot Number';
//         Boe_Lbl = 'BOE Number';
//         BaseUOM_Lbl = 'UOM';
//         BUOMQ_Lbl = 'Quantity';
//         AlUOM_Lbl = 'Package Qty.';
//         AlUOMQ_Lbl = 'Package Type';
//         Total_Lbl = 'Total';
//         PosDate_Lbl = 'Date:';
//         OrderNo_Lbl = 'Packing Ref.:';
//         RemarkHead_Lbl = 'Remarks:';
//         DocumentNo_Lbl = 'Ref. No.: ';
//         Origin_Lbl = 'Origin: ';
//         HSCode_Lbl = 'HS Code: ';
//         Packing_Lbl = 'Packing: ';
//         Netight_Lbl = 'Net Weight: ';
//         GrossWeight_Lbl = 'Gross Weight: ';
//         InvoiceNo_Lbl = 'Invoice No./Date:';
//         PINoDate_lbl = 'P/I No./Date:';
//         LCNoDate_lbl = 'L/C No./Date:';
//         clientPO_lbl = 'Client PO No./Date:';
//     }

//     trigger OnInitReport()
//     begin
//         SerialNo := 0;
//         RemarksSerial := 1;
//         CompanyInfo.GET;
//         CompanyInfo.CALCFIELDS(Picture, Stamp);
//         GLSetup.Get();
//         if CountryRegion.Get(CompanyInfo."Country/Region Code") then CountryCode := CountryRegion.Name;
//     end;

//     trigger OnPreReport()
//     begin
//         companyInfo.GET;
//         CompanyInfo.CALCFIELDS(Picture, Stamp);
//     end;

//     var
//         Desc_gTxt: Text;
//         ILEPrimPackUOM_gTxt: Text;
//         ILEPrimPackQty_gDec: Decimal;
//         ILEPrimPack_gTxt: Text;
//         PrimPackUOM_gTxt: Text;
//         PrimPackQty_gDec: Decimal;
//         NetWeight_gDec: Decimal;
//         GrossWeight_gDec: Decimal;
//         ILENetwt_gDec: Decimal;
//         ILENetwt_gTxt: Text;
//         ILEGrosswt_gDec: Decimal;
//         ILEGrosswt_gTxt: Text;
//         GrossWeight: Decimal;
//         NetWeight: Decimal;
//         LotNo_gcod: Text;
//         Packing_Txt: Text[100];
//         CustAddr_Arr: array[9] of Text[100];
//         CustAddrShipTo_Arr: array[9] of Text[100];
//         CountryCode: Text[50];
//         GLSetup: Record "General Ledger Setup";
//         SerialNo: Integer;
//         CountryRegion: Record "Country/Region";
//         FromCountryName: Text[50];
//         ToCountryName: Text[50];
//         FromAddressToggle: Boolean;
//         ToAddressToggle: Boolean;
//         companyInfo: Record "Company Information";
//         ItemUnitMeasure: Record "Item Unit of Measure";
//         AlternateQtyUOM: Decimal;
//         UOMCode: Code[20];
//         UOMDesc: Text;
//         OriginVar: Text;
//         HSCodeVar: Text;
//         BaseUOMVar: Text;
//         Item: Record "Item";
//         ReservationEntryRec: Record "Reservation Entry";
//         ItemLedgerEntry_Rec: Record "Item Ledger Entry";
//         RemarksSerial: Integer;
//         TotalQty: Decimal;
//         TotalAltQty: Decimal;
//         AltQty: Decimal;
//         TotalUOMQty: Decimal;
//         AltQty1: Decimal;
//         GenericNameVar: Text;
//         LocationFrom: Record Location;
//         LocationTo: Record Location;
//         LotExist: Boolean;
//         DecimalAllowed: Boolean;
//         LineUnMerge: Boolean;
// }

