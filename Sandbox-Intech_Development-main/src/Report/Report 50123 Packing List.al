// report 50123 "Packing List"//T47724-N Packing List 7 (KM/DO/111926) R_53005 on Posted Sales Shipment
// {
//     //Stamp
//     DefaultLayout = RDLC;
//     RDLCLayout = 'Layouts/Packing LIst Transfer.rdl';
//     Caption = 'Packing List';
//     //Description = 'Transfer Shipment Layout';
//     UsageCategory = Administration;
//     ApplicationArea = all;

//     dataset
//     {
//         dataitem("Transfer Header"; "Transfer Header")
//         {
//             //DataItemTableView = where("No." = '102040');
//             //DataItemTableView = where ("No." = const ('102040'));
//             column(Print_copy; Print_copy) { }
//             column(SalesLineMerge; SalesLineMerge) { }
//             column(Tax_Type; '') { }
//             column(No_SalesShipmentHeader; "Transfer Header"."No.") { }
//             column(PostingDate_SalesShipmentHeader; Format("Transfer Header"."Posting Date", 0, '<Day,2> <Month Text> <Year4>')) { }
//             column(OrderNo_SalesShipmentHeader; '') { }
//             column(Hide_E_sign; Hide_E_sign) { }
//             column(ReportCapation; ReportCapation) { }
//             column(ShowComment; ShowComment) { }
//             column(ShowDeliveryNote; ShowDeliveryNote) { }
//             column(CompName; CompanyInformation.Name) { }
//             column(CompLogo; CompanyInformation.Picture) { }
//             //Stamp
//             column(CompanyInfo_Stamp; CompanyInformation.Stamp)
//             {

//             }
//             column(PrintStamp; PrintStamp)
//             {

//             }
//             //stamp-end
//             column(CompAddr1; CompanyInformation.Address) { }
//             column(CompAddr2; CompanyInformation."Address 2") { }
//             column(CompCity; CompanyInformation.City) { }
//             column(CompCountry; CountryRec.Name) { }
//             column(Telephone; CompanyInformation."Phone No.") { }
//             column(Web; CompanyInformation."Home Page") { }
//             column(External_Document_No_; "External Document No.") { }
//             column(TRNNo; CompanyInformation."VAT Registration No.") { }
//             column(CustAddr_Arr1; CustAddr_Arr[1]) { }
//             column(CustAddr_Arr2; CustAddr_Arr[2]) { }
//             column(CustAddr_Arr3; CustAddr_Arr[3]) { }
//             column(CustAddr_Arr4; CustAddr_Arr[4]) { }
//             column(CustAddr_Arr5; CustAddr_Arr[5]) { }
//             column(CustAddr_Arr6; CustAddr_Arr[6]) { }
//             column(CustAddr_Arr7; CustAddr_Arr[7]) { }
//             column(CustAddr_Arr8; CustAddr_Arr[8]) { }
//             column(CustAddr_Arr9; CustAddr_Arr[9]) { }
//             column(CustAddrShipTo_Arr; CustAddrShipTo_Arr[1]) { }
//             column(CustAddrShipTo_Arr2; CustAddrShipTo_Arr[2]) { }
//             column(CustAddrShipTo_Arr3; CustAddrShipTo_Arr[3]) { }
//             column(CustAddrShipTo_Arr4; CustAddrShipTo_Arr[4]) { }
//             column(CustAddrShipTo_Arr5; CustAddrShipTo_Arr[5]) { }
//             column(CustAddrShipTo_Arr6; CustAddrShipTo_Arr[6]) { }
//             column(CustAddrShipTo_Arr7; CustAddrShipTo_Arr[7]) { }
//             column(CustAddrShipTo_Arr8; CustAddrShipTo_Arr[8]) { }
//             column(Ship_to_Code; '') { }
//             column(Order_No_; '') { }
//             column(Order_Date; '') { } //FORMAT("Order Date", 0, '<Day,2> <Month Text> <Year4>')
//             column(LCNumber; '') { } //PackingListExtChange "Transfer Header"."LC No. 2"
//             Column(LCDate; '') { } //PackingListExtChange Format("Transfer Header"."LC Date 2", 0, '<Day,2> <Month Text> <Year4>')
//             column(CustTRN; CustTRN) { }
//             column(TotalNetWeight; TotalNetWeight) { }
//             column(TotalGrossWeight; TotalGrossWeight) { }
//             column(Sell_to_Customer_No_; '') //"Sell-to Customer No."
//             { }
//             column(Bill_to_Customer_No_; '')
//             { }
//             //>>SJ-24-02-20
//             column("Customer_ALternate_Address"; CustAltAddrBool)
//             { }
//             column(Duty_Exemption; '') { } //"Duty Exemption"
//             //AW09032020>>
//             column(PI_Validity_Date; '') { } //Format("PI Validity Date", 0, '<Day,2> <Month Text> <Year4>')
//             //AW09032020>>
//             //<<SJ-24-02-20

//             dataitem("Transfer Line"; "Transfer Line")
//             {
//                 DataItemLink = "Document No." = FIELD("No.");
//                 DataItemTableView = where("Quantity (Base)" = filter('>=0'));
//                 column(LineNo_SalesShipmentLine; "Transfer Line"."Line No.") { }
//                 column(SrNo; SrNo) { }
//                 column(No_SalesShipmentLine; '') { } //"Transfer Line"."No."
//                 column(Description_SalesShipmentLine; "Transfer Line".Description)
//                 {
//                     IncludeCaption = TRUE;
//                 }
//                 column(Quantity_SalesShipmentLine; "Transfer Line".Quantity)
//                 {
//                     IncludeCaption = TRUE;
//                 }
//                 column(SalesLineBaseUOM; '') { }
//                 column(UnitofMeasureCode_SalesShipmentLine; "Transfer Line"."Unit of Measure Code") { }
//                 column(LocationCode_SalesShipmentLine; '') { } //"Location Code"
//                 column(GrossWeight_SalesShipmentLine; Round(GrossWeightLine, 1, '<'))
//                 {
//                     //IncludeCaption = TRUE;
//                 }
//                 column(NetWeight_SalesShipmentLine; Round(NetWeightLine, 1, '<'))
//                 {
//                     // IncludeCaption = TRUE;

//                 }
//                 column(Gross_Weight; Round("Gross Weight", 1, '<'))
//                 {
//                 }
//                 column(Net_Weight; Round("Net Weight", 1, '<'))
//                 {
//                 }
//                 // column(Packing_Gross_Weight; "Packing Gross Weight")
//                 // {
//                 //     IncludeCaption = true;
//                 // }
//                 // column(Packing_Net_Weight; "Packing Net Weight")
//                 // {
//                 // }
//                 column(SearchDesc; SearchDesc) { }
//                 column(Origin; Origitext) { }
//                 column(HSCode; HSNCode) { }
//                 column(Packing; PackingTxt) { }
//                 column(Quantity__Base_; "Quantity (Base)") { }
//                 column(ShipmentLineAltQty; ShipmentLineAltQty) { DecimalPlaces = 0 : 3; }
//                 column(NoOfLoads; 'No of Loads- Value') { }
//                 column(ShipmentType; 'Shipment Type - Value') { }
//                 column(SalesQty; SalesQty) { }
//                 column(SalesUOM; SalesUOM) { }
//                 column(SrNo1; SrNo1) { }
//                 column(SrNo2; SrNo2) { }
//                 column(SrNo4; SrNo4) { }
//                 column(PINONew; PINONew) { }
//                 column(PIDATENew; FORMAT(PIDATENew, 0, '<Day,2> <Month Text> <Year4>')) { }
//                 column(IMCO_Code; ImcoCodeText) { }
//                 dataitem("Item Ledger Entry"; "Item Ledger Entry")
//                 {
//                     //DataItemLink = "Document No." = FIELD ("Document No."), "Document Line No." = field ("Line No."), "Posting Date" = FIELD ("Posting Date");

//                     //Supriya >>
//                     //DataItemLink = "Document No." = FIELD("Document No."), "Item No." = field("No.");
//                     //DataItemLink = "Document No." = FIELD("Document No."), "Item No." = field("No."), "Document Line No." = field("Line No.");
//                     //Supriya <<

//                     //DataItemLinkReference = "Sales Shipment Line";
//                     column(DocumentNo_ItemLedgerEntry; "Item Ledger Entry"."Document No.") { }
//                     column(Quantity; Quantity) { }
//                     column(ILEBaseQty; ILEBaseQty) { }
//                     column(SrNo_ILE; SrNo) { }
//                     column(DocumentLineNo_ItemLedgerEntry; "Item Ledger Entry"."Document Line No.") { }
//                     column(Description_ItemLedgerEntry; "Item Ledger Entry".Description)
//                     {
//                         IncludeCaption = true;
//                     }
//                     column(ItemDesc; ItemDesc) { }
//                     column(LotNo_ItemLedgerEntry; "Item Ledger Entry".CustomLotNumber)
//                     {
//                         IncludeCaption = true;
//                     }
//                     column(Quantity_ItemLedgerEntry; ILQty)
//                     {
//                         DecimalPlaces = 0 : 3;
//                     }
//                     column(UnitofMeasureCode_ItemLedgerEntry; ILEUOM) { }
//                     column(Supplier_Batch_No_ItemLedgerEntry; "Item Ledger Entry".CustomBOENumber) { }
//                     column(packing_ILE; PackingTxt2) { }
//                     column(Unit_of_Measure_Code; "Unit of Measure Code") { }


//                     trigger OnPreDataItem()
//                     begin
//                         SetCurrentKey("Document No.", "Document Line No.", "Lot No.");
//                         SrNo := 0;
//                     end;

//                     trigger OnAfterGetRecord()
//                     var
//                         Item_LRec: Record Item;
//                         ItemUOM_lRec: Record "Item Unit of Measure";
//                         SalesInvLineL: Record "Transfer Line";
//                         UOMRec: Record "Unit of Measure";
//                         ItemUOMVariant: Record "Item Unit of Measure";
//                     begin

//                         If Item_LRec.GET("Item No.") then begin

//                             //ItemDesc := Item_LRec.Description;
//                             // UOMRec.Get(Item_LRec."Base Unit of Measure");
//                             // if UOMRec."Decimal Allowed" then
//                             //     Quantity := Round(Quantity, 0.001)
//                             // else
//                             //     Quantity := Round(Quantity, 1);
//                         end;

//                         ILEUOM := '';
//                         ILQty := 0;
//                         "Item Ledger Entry".Quantity := Abs("Item Ledger Entry".Quantity);
//                         if ItemUOM_lRec.Get("Item No.", "Unit of Measure Code") then;
//                         ItemUOM_lRec.Reset();
//                         ItemUOM_lRec.SetCurrentKey("Item No.", "Qty. per Unit of Measure");
//                         ItemUOM_lRec.SetRange("Item No.", "Item Ledger Entry"."Item No.");

//                         if "Variant Code" <> '' then begin
//                             If ItemUOM_lRec."Variant Code" = "Variant Code" then begin
//                                 ItemUOM_lRec.SetRange("Variant Code", "Variant Code");
//                             end else begin
//                                 ItemUOM_lRec.SetRange("Variant Code", '');
//                             end;
//                         end else begin
//                             ItemUOMVariant.Get("Item Ledger Entry"."Item No.", "Unit of Measure Code");
//                             if ItemUOMVariant."Variant Code" <> '' then begin
//                                 ItemUOM_lRec.SetRange("Variant Code", ItemUOMVariant."Variant Code");
//                             end else begin
//                                 ItemUOM_lRec.SetRange("Variant Code", '');
//                             end;
//                         end;

//                         //ItemUOM_lRec.SetFilter(Code, '<>%1', "Sales Shipment Line"."Base UOM 2");

//                         IF ItemUOM_lRec.FindFirst() then begin
//                             UOMRec.Get(ItemUOM_lRec.Code);
//                             ILEUOM := UOMRec.Description;

//                             //ILQty := ROUND("Quantity (Base)" / ItemUnitofMeasureL."Qty. per Unit of Measure", 1, '>'); refer from another function
//                             ILQty := ROUND("Item Ledger Entry".Quantity / ItemUOM_lRec."Qty. per Unit of Measure", 1, '>'); // Round Function Added by B
//                             AltqtyFactor := ItemUOM_lRec."Qty. per Unit of Measure";
//                             AltUOM2 := UOMRec.Description;

//                             // if ItemUOM_lRec."Qty. per Unit of Measure" < 1 then begin
//                             //     ILEUOM := ItemUOM_lRec.Code;
//                             //     ILQty := "Item Ledger Entry".Quantity / ItemUOM_lRec."Qty. per Unit of Measure";
//                             //     AltqtyFactor := ItemUOM_lRec."Qty. per Unit of Measure";
//                             //     AltUOM2 := ItemUOM_lRec.Code;
//                             // end else
//                             //     if ItemUOM_lRec."Qty. per Unit of Measure" > 1 then begin
//                             //         // ItemUOM_lRec.Reset();
//                             //         // ItemUOM_lRec.SetCurrentKey("Item No.", "Qty. per Unit of Measure");
//                             //         // ItemUOM_lRec.SetRange("Item No.", "Item Ledger Entry"."Item No.");
//                             //         // ItemUOM_lRec.SetFilter("Qty. per Unit of Measure", '>1');
//                             //         // if ItemUOM_lRec.FindFirst() then 
//                             //         // begin
//                             //         ILEUOM := ItemUOM_lRec.Code;
//                             //         ILQty := "Item Ledger Entry".Quantity / ItemUOM_lRec."Qty. per Unit of Measure";
//                             //         AltqtyFactor := ItemUOM_lRec."Qty. per Unit of Measure";
//                             //         AltUOM2 := ItemUOM_lRec.Code;
//                             //         // end
//                             //     end

//                             //     else
//                             //         if ItemUOM_lRec."Qty. per Unit of Measure" = 1 then begin
//                             //             ILEUOM := ItemUOM_lRec.Code;
//                             //             ILQty := "Item Ledger Entry".Quantity / ItemUOM_lRec."Qty. per Unit of Measure";
//                             //             AltqtyFactor := ItemUOM_lRec."Qty. per Unit of Measure";
//                             //             AltUOM2 := ItemUOM_lRec.Code;

//                             //         end;

//                         end
//                         else begin
//                             UOMRec.Get("Item Ledger Entry"."Unit of Measure Code");
//                             ILEUOM := UOMRec.Description;
//                             //ILEUOM := "Item Ledger Entry"."Unit of Measure Code";
//                             ILQty := "Item Ledger Entry".Quantity;
//                             AltqtyFactor := ItemUOM_lRec."Qty. per Unit of Measure";
//                             AltUOM2 := Item_LRec."Base Unit of Measure";

//                         end;

//                         PackingTxt2 := Item_LRec."Description 2";
//                         if Item_LRec."Base Unit of Measure" = 'MT' then begin
//                             Quantity := Quantity * 1000;
//                         end;

//                         SrNo += 1;
//                         ItemDesc := '';
//                         PackingTxt2 := '';


//                         if SalesInvLineL.Get("Document No.", "Document Line No.") then
//                             ItemDesc := SalesInvLineL.Description;
//                     end;
//                 }
//                 dataitem(Integer; Integer)
//                 {
//                     DataItemTableView = SORTING(Number)
//                                         ORDER(Ascending)
//                                         WHERE(Number = const(1));
//                     column(AltUOMTotalqty; AltUOMTotalqty) { DecimalPlaces = 0 : 3; }
//                     column(TotalBaseQty; TotalBaseQty)
//                     { }
//                     column(TotalUOM2; '') { } //"Transfer Line"."Base UOM 2"
//                     column(AltUOM2; AltUOM2) { }
//                     column(AltqtyFactor; AltqtyFactor) { }
//                     column(TotalLbl; TotalLbl) { }
//                     trigger OnAfterGetRecord()

//                     var
//                         myInt: Integer;
//                         UOM: Record "Unit of Measure";
//                         ShipmentLineRec: record "Transfer Line";
//                         BaseUOML: Boolean;
//                     begin
//                         if not SalesLineMerge then begin
//                             AltUOMTotalqty := 0;
//                             TotalBaseQty := 0;
//                             // if "Sales Shipment Line"."Base UOM 2" = 'MT' then begin
//                             //     "Sales Shipment Line"."Base UOM 2" := 'KG';
//                             //     BaseUOML := true;
//                             // end;
//                             ShipmentLineRec.Reset();
//                             ShipmentLineRec.SetRange("Document No.", "Transfer Line"."Document No.");
//                             //ShipmentLineRec.SetRange("No.", "Transfer Line"."No.");
//                             ShipmentLineRec.SetFilter("Line No.", '<%1', "Transfer Line"."Line No.");
//                             ShipmentLineRec.SetRange("Unit of Measure Code", "Transfer Line"."Unit of Measure Code");
//                             //ShipmentLineRec.SetRange("Unit Price", "Transfer Line"."Unit Price");
//                             if not ShipmentLineRec.FindFirst() then begin
//                                 TotalLbl := 'Total';
//                                 if UOM.Get(AltUOM2) then;
//                                 if (UOM."Decimal Allowed") then
//                                     AltUOMTotalqty := Round("Transfer Line"."Quantity (Base)" / AltqtyFactor, 0.01, '=')
//                                 else
//                                     AltUOMTotalqty := Round("Transfer Line"."Quantity (Base)" / AltqtyFactor, 1, '>');

//                                 if BaseUOML then begin
//                                     //"Sales Shipment Line"."Base UOM 2" := 'KG';
//                                     TotalBaseQty := "Transfer Line"."Quantity (Base)" * 1000;
//                                 end
//                                 else
//                                     TotalBaseQty := "Transfer Line"."Quantity (Base)"
//                             end
//                         end else begin
//                             TotalLbl := 'Total';
//                             if UOM.Get(AltUOM2) then;
//                             if (UOM."Decimal Allowed") then
//                                 AltUOMTotalqty := Round("Transfer Line"."Quantity (Base)" / AltqtyFactor, 0.01, '=')
//                             else
//                                 AltUOMTotalqty := Round("Transfer Line"."Quantity (Base)" / AltqtyFactor, 1, '>');

//                             //     if "Transfer Line"."Base UOM 2" = 'MT' then begin
//                             //         "Transfer Line"."Base UOM 2" := 'KG';
//                             //         TotalBaseQty := "Transfer Line"."Quantity (Base)" * 1000;
//                             //     end
//                             //     else
//                             //         TotalBaseQty := "Transfer Line"."Quantity (Base)"
//                             // end;
//                         end;
//                     end;
//                 }

//                 trigger OnPreDataItem()
//                 begin
//                     SetFilter("Quantity (Base)", '<>0');
//                     //SetFilter(Type,'%1', Type::Item);
//                 end;

//                 trigger OnAfterGetRecord()
//                 var
//                     SalesHeaderRec: Record "Sales Header";
//                     salesHeaderArchive: Record "Sales Header Archive";
//                     salesHeader: Record "Sales Header";
//                     Item_LRec: Record Item;
//                     CountryRegRec: Record "Country/Region";
//                     ItemUnitofMeasureL: Record "Item Unit of Measure";
//                     ShipmentLineRec: Record "Transfer Line";
//                     UOMRec: Record "Unit of Measure";
//                     TemP: Decimal;
//                     Stringproper: Codeunit "String Proper";
//                     IMCOMasterRec: Record "IMCO Class Master";
//                     ItemUOMVariant: Record "Item Unit of Measure";
//                     ILE: Record "Item Ledger Entry";
//                 begin
//                     Clear(ImcoCodeText);


//                     SrNo += 1;
//                     // HSNCode := '';
//                     Origitext := '';
//                     PackingTxt := '';
//                     //If Item_LRec.GET("No.") THEN;

//                     // if IMCOMasterRec.Get("IMCO Class") then begin
//                     //     ImcoCodeText := "IMCO Class" + ' ' + IMCOMasterRec.Description;
//                     // end;
//                     ILEBaseQty := 0;
//                     if not SalesLineMerge then begin

//                         // ShipmentLineRec.Reset();
//                         // ShipmentLineRec.SetRange("Document No.", "Document No.");
//                         // ShipmentLineRec.SetRange("No.", "No.");
//                         // ShipmentLineRec.SetFilter("Line No.", '<%1', "Line No.");
//                         // ShipmentLineRec.SetRange("Unit of Measure Code", "Unit of Measure Code");
//                         // ShipmentLineRec.SetRange("Unit Price", "Unit Price");
//                         // if ShipmentLineRec.FindFirst() then begin
//                         //     CurrReport.Skip();
//                         //     // srno4 -= 1;
//                         // end;

//                         ILE.SetRange("Document No.", "Document No.");
//                         //ILE.SetRange("Item No.", "No.");
//                         ILE.SetRange("Document Line No.", "Line No.");
//                         If ILE.FindFirst() then
//                             ILEBaseQty := ILE.Quantity;

//                         ShipmentLineRec.Reset();
//                         ShipmentLineRec.SetRange("Document No.", "Document No.");
//                         //ShipmentLineRec.SetRange("No.", "No.");
//                         ShipmentLineRec.SetFilter("Line No.", '>%1', "Line No.");
//                         ShipmentLineRec.SetFilter("Quantity (Base)", '>0');
//                         if ShipmentLineRec.FindFirst() then begin
//                             repeat
//                                 if ("Unit of Measure Code" = ShipmentLineRec."Unit of Measure Code") then begin // ("Unit Price" = ShipmentLineRec."Unit Price") and
//                                     "Quantity (Base)" += ShipmentLineRec."Quantity (Base)";
//                                     "Net Weight" += ShipmentLineRec."Net Weight";
//                                     "Gross Weight" += ShipmentLineRec."Gross Weight";
//                                 end;

//                                 ILE.Reset();
//                                 ILE.SetRange("Document No.", "Document No.");
//                                 //ILE.SetRange("Item No.", "No.");
//                                 ILE.SetRange("Document Line No.", ShipmentLineRec."Line No.");
//                                 If ILE.FindSet() then
//                                     repeat
//                                         ILEBaseQty += ILE.Quantity;
//                                     until ILE.Next() = 0;
//                             until ShipmentLineRec.Next() = 0;
//                         end;
//                     end;

//                     clear(NetWeightLine);
//                     clear(GrossWeightLine);
//                     ShipmentLineRec.Reset();
//                     ShipmentLineRec.SetRange("Document No.", "Document No.");
//                     //ShipmentLineRec.SetRange("No.", "No.");
//                     ShipmentLineRec.SetFilter("Quantity (Base)", '>0');
//                     if ShipmentLineRec.FindSet() then begin
//                         repeat
//                             NetWeightLine += ShipmentLineRec."Net Weight";
//                             GrossWeightLine += ShipmentLineRec."Gross Weight";
//                         until ShipmentLineRec.Next() = 0;
//                     end;

//                     //   srno4 += 1;
//                     srno4 += 1;
//                     //ItemUnitofMeasureL.Get("No.", "Unit of Measure Code");
//                     ItemUnitofMeasureL.SetCurrentKey("Qty. per Unit of Measure");
//                     //ItemUnitofMeasureL.SetRange("Item No.", "No.");

//                     if "Variant Code" <> '' then begin
//                         If ItemUnitofMeasureL."Variant Code" = "Variant Code" then begin
//                             ItemUnitofMeasureL.SetRange("Variant Code", "Variant Code");
//                         end else begin
//                             ItemUnitofMeasureL.SetRange("Variant Code", '');
//                         end;
//                     end else begin
//                         //temUOMVariant.Get("No.", "Unit of Measure Code");
//                         if ItemUOMVariant."Variant Code" <> '' then begin
//                             ItemUnitofMeasureL.SetRange("Variant Code", ItemUOMVariant."Variant Code");
//                         end else begin
//                             ItemUnitofMeasureL.SetRange("Variant Code", '');
//                         end;
//                     end;

//                     ItemUnitofMeasureL.SetFilter(Code, '<>%1', Item_LRec."Base Unit of Measure");
//                     if ItemUnitofMeasureL.FindFirst() then begin
//                         if ItemUnitofMeasureL."Qty. per Unit of Measure" < 1 then begin
//                             ShipmentLineAltQty := ROUND("Quantity (Base)" / ItemUnitofMeasureL."Qty. per Unit of Measure", 1, '>');
//                             // PackingTxt := format(ShipmentLineAltQty) + ' ' + ItemUnitofMeasureL.Code + ' of ' + Item_LRec."Description 2";
//                         end
//                         else
//                             if ItemUnitofMeasureL."Qty. per Unit of Measure" > 1 then begin
//                                 //ItemUnitofMeasureL.Get("No.", "Unit of Measure Code");
//                                 ItemUnitofMeasureL.Reset();
//                                 ItemUnitofMeasureL.SetCurrentKey("Qty. per Unit of Measure");
//                                 //ItemUnitofMeasureL.SetRange("Item No.", "Transfer Line"."No.");

//                                 if "Variant Code" <> '' then begin
//                                     If ItemUnitofMeasureL."Variant Code" = "Variant Code" then begin
//                                         ItemUnitofMeasureL.SetRange("Variant Code", "Variant Code");
//                                     end else begin
//                                         ItemUnitofMeasureL.SetRange("Variant Code", '');
//                                     end;
//                                 end else begin
//                                     //ItemUOMVariant.Get("No.", "Unit of Measure Code");
//                                     if ItemUOMVariant."Variant Code" <> '' then begin
//                                         ItemUnitofMeasureL.SetRange("Variant Code", ItemUOMVariant."Variant Code");
//                                     end else begin
//                                         ItemUnitofMeasureL.SetRange("Variant Code", '');
//                                     end;
//                                 end;


//                                 ItemUnitofMeasureL.SetFilter("Qty. per Unit of Measure", '>1');
//                                 if ItemUnitofMeasureL.FindFirst() then begin
//                                     ShipmentLineAltQty := ROUND("Quantity (Base)" / ItemUnitofMeasureL."Qty. per Unit of Measure", 0.01, '=');
//                                     // PackingTxt := format(ShipmentLineAltQty) + ' ' + ItemUnitofMeasureL.Code + ' of ' + Item_LRec."Description 2";
//                                 end;
//                             end
//                             else
//                                 if ItemUnitofMeasureL."Qty. per Unit of Measure" = 1 then begin
//                                     ShipmentLineAltQty := "Quantity (Base)";
//                                 end;


//                     end else begin
//                         ShipmentLineAltQty := "Quantity (Base)";
//                     end;



//                     //HSNCode := "Transfer Line".HSNCode; // hide by bayas - Item_LRec."Tariff No.";
//                     SearchDesc := Item_LRec."Generic Description";

//                     // IF "Sales Shipment Line"."Base UOM 2" = 'MT' then begin //PackingListExtChange
//                     //     SalesQty := "Sales Shipment Line"."Quantity (Base)" * 1000;
//                     //     SalesUOM := 'KG';
//                     //     // Packing_GrossWt := "Sales Shipment Line"."Packing Gross Weight" * 1000; //PackingListExtChange
//                     // end
//                     // Else begin
//                     //     SalesQty := "Sales Shipment Line"."Quantity (Base)";
//                     //     SalesUOM := "Sales Shipment Line"."Base UOM 2"; //PackingListExtChange

//                     //     // Packing_GrossWt := "Sales Shipment Line"."Packing Gross Weight"; //PackingListExtChange
//                     // End;



//                     //UK::03062020>>
//                     if PostedCustomInvoiceG then begin
//                         // code commented due to reason>>
//                         // HSNCode := LineHSNCode;
//                         // IF CountryRegRec.Get(LineCountryOfOrigin) then
//                         //     Origitext := CountryRegRec.Name;
//                         // code commented due to reason<<
//                         //HSNCode := LineHSNCode;
//                         //UK::24062020>>
//                         CountryRegRec.Reset();
//                         // if CountryRegRec.get("Transfer Line".LineCountryOfOrigin) then
//                         //     Origitext := CountryRegRec.Name;
//                         //AW09032020>>
//                         // if "Line Generic Name" <> '' then
//                         //     SearchDesc := "Line Generic Name";
//                         //AW09032020<<
//                     end else begin
//                         HSNCode := HSNCode;
//                         CountryRegRec.Reset();
//                         // if CountryRegRec.get("Sales Shipment Line".CountryOfOrigin) then
//                         //     Origitext := CountryRegRec.Name;
//                         //UK::24062020<<
//                     end;
//                     //UK::03062020<<
//                     //Sh
//                     //UK::17062020>>
//                     // SalesHeaderRec.Reset();
//                     // SalesHeaderRec.SetRange("No.", "Sales Shipment Line"."Blanket Order No.");
//                     // if SalesHeaderRec.FindFirst() then begin
//                     //UK::24062020>>
//                     // if "Sales Shipment Line"."Blanket Order No." <> '' then begin
//                     //     // if PostedCustomInvoiceG then
//                     //     //     PINONew := "Sales Shipment Line"."Blanket Order No." + '-A'
//                     //     // else
//                     //     PINONew := "Sales Shipment Line"."Blanket Order No.";
//                     //     salesHeader.Reset();
//                     //     salesHeader.SetRange("Document Type", salesHeader."Document Type"::"Blanket Order");
//                     //     salesHeader.SetRange("No.", "Sales Shipment Line"."Blanket Order No.");
//                     //     if salesHeader.FindFirst() then
//                     //         PIDATENew := salesHeader."Order Date"
//                     //     else begin
//                     //         salesHeaderArchive.Reset();
//                     //         salesHeaderArchive.SetRange("Document Type", salesHeaderArchive."Document Type"::"Blanket Order");
//                     //         salesHeaderArchive.SetRange("No.", "Sales Shipment Line"."Blanket Order No.");
//                     //         if salesHeaderArchive.FindFirst() then
//                     //             PIDateNew := salesHeaderArchive."Order Date";
//                     //     end;
//                     // end else begin
//                     //     PINONew := "Sales Shipment Line"."Order No.";
//                     //     salesHeader.Reset();
//                     //     salesHeader.SetRange("Document Type", salesHeader."Document Type"::Order);
//                     //     salesHeader.SetRange("No.", "Sales Shipment Line"."Order No.");
//                     //     if salesHeader.FindFirst() then
//                     //         PIDATENew := salesHeader."Order Date"
//                     //     else begin
//                     //         salesHeaderArchive.Reset();
//                     //         salesHeaderArchive.SetRange("Document Type", salesHeaderArchive."Document Type"::Order);
//                     //         salesHeaderArchive.SetRange("No.", "Sales Shipment Line"."Order No.");
//                     //         if salesHeaderArchive.FindFirst() then
//                     //             PIDateNew := salesHeaderArchive."Order Date";
//                     //     end;
//                     // end;
//                     //UK::24062020<<
//                     // end
//                     // else begin
//                     //     PINONew := "Order No.";
//                     //     PIDATENew := "Sales Shipment Header"."Order Date";
//                     // end;
//                     //UK::17062020<<


//                 End;
//             }
//             dataitem("Sales Comment Line"; "Sales Comment Line")
//             {
//                 DataItemLink = "No." = FIELD("No.");
//                 DataItemTableView = SORTING("Document Type", "No.", "Document Line No.", "Line No.") WHERE("Document Type" = CONST(Shipment), "Document Line No." = FILTER(0));
//                 column(Comment_SalesCommentLine; "Sales Comment Line".Comment) { }
//                 column(LineNo_SalesCommentLine; "Sales Comment Line"."Line No.") { }
//                 column(DocumentLineNo_SalesCommentLine; "Sales Comment Line"."Document Line No.") { }

//                 column(SrNo3; SrNo3)
//                 { }
//                 trigger OnPreDataItem()
//                 begin
//                     if not ShowComment then
//                         CurrReport.Break;
//                 end;

//                 trigger OnAfterGetRecord()
//                 begin
//                     SrNo3 += 1;
//                 end;
//             }
//             dataitem("Sales Order Remarks"; "Sales Order Remarks")
//             {
//                 //DataItemLink = "Document No." = field("Remarks Order No.");
//                 DataItemTableView = Where("Document Type" = const(Shipment), "Document Line No." = FILTER(0), Comments = FILTER(<> ''));

//                 column(Remark_Document_Type; "Document Type") { }
//                 column(Remark_Document_No_; "Document No.") { }
//                 column(Remark_Document_Line_No_; "Document Line No.") { }
//                 column(Remark_Line_No_; "Line No.") { }
//                 column(Remark_Comments; Comments) { }
//                 column(SNO; SNO) { }
//                 trigger OnPreDataItem()
//                 var
//                 begin
//                     SNO := SrNo3;
//                 end;

//                 trigger OnAfterGetRecord()
//                 var
//                 begin
//                     SNO += 1;
//                 end;
//             }
//             trigger OnAfterGetRecord()
//             var
//                 FormatAddr: Codeunit "Format Address";
//                 Comment_Lrec: Record "Sales Comment Line";
//                 Cust: Record Customer;
//                 SalesHeaderRec: Record "Sales Header";
//                 ShipToAdd: Record "Ship-to Address";
//                 ClrShipToAdd: Record "Clearance Ship-to Address";
//                 CustomerRec: Record Customer;
//                 ItemUnitofMeasureL: Record "Item Unit of Measure";
//                 ShipmentLineRec: Record "Transfer Line";
//             begin
//                 ShipmentLineRec.SetRange("Document No.", "No.");
//                 ShipmentLineRec.SetFilter("Quantity (Base)", '>0');
//                 if ShipmentLineRec.FindSet() then begin
//                     repeat
//                         TotalNetWeight += Round(ShipmentLineRec."Net Weight", 1, '<');
//                         TotalGrossWeight += Round(ShipmentLineRec."Gross Weight", 1, '<');
//                     until ShipmentLineRec.Next() = 0;
//                 end;

//                 Clear(CustAddr_Arr);
//                 //FormatAddr.SalesShptSellTo(CustAddr_Arr, "Sales Shipment Header");

//                 Clear(CustAddrShipTo_Arr);
//                 // FormatAddr.SalesShptShipTo(CustAddrShipTo_Arr, "Sales Shipment Header");
//                 //MS-
//                 // if blnClrAddress then begin
//                 //     CustAddrShipto_Arr[1] := "Clearance Ship-to Name";
//                 //     CustAddrShipto_Arr[2] := "Clearance Ship-to Address";
//                 //     CustAddrShipto_Arr[3] := "Clearance Ship-to Address 2";
//                 //     CustAddrShipto_Arr[4] := "Clearance Ship-to City";
//                 //     CustAddrShipto_Arr[8] := "Clearance Ship-to Post Code";
//                 //     if CountryRegionL.Get("Clear.Ship-to Country/Reg.Code") then
//                 //         CustAddrShipto_Arr[5] := CountryRegionL.Name;
//                 //     //AW09032020>>
//                 //     if "Clearance Ship-to Code" <> '' then begin
//                 //         if ClrShipToAdd.Get("Sell-to Customer No.", "Ship-to Code") and (ClrShipToAdd."Phone No." <> '') then
//                 //             CustAddrShipto_Arr[6] := 'Tel: ' + ClrShipToAdd."Phone No.";
//                 //         // else
//                 //         //     if "Sell-to Phone No." <> '' then
//                 //         //         CustAddrShipto_Arr[7] := 'Tel No.: ' + "Sell-to Phone No.";
//                 //     end;
//                 //     //  else
//                 //     //     if "Sell-to Phone No." <> '' then
//                 //     //         CustAddrShipto_Arr[7] := 'Tel No.: ' + "Sell-to Phone No.";
//                 //     //AW09032020<<
//                 //     //CustAddrShipto_Arr[8] := ;
//                 // end
//                 // else begin
//                 //     //MS+
//                 //     CustAddrShipTo_Arr[1] := "Ship-to Name";
//                 //     CustAddrShipTo_Arr[2] := "Ship-to Address";
//                 //     CustAddrShipTo_Arr[3] := "Ship-to Address 2";
//                 //     CustAddrShipTo_Arr[4] := "Ship-to City";
//                 //     CustAddrShipTo_Arr[5] := "Ship-to Post Code";
//                 //     if CountryRegionL.Get("Ship-to Country/Region Code") then
//                 //         CustAddrShipTo_Arr[6] := CountryRegionL.Name;
//                 //     //AW09032020>>
//                 //     if "Ship-to Code" <> '' then begin
//                 //         if ShipToAdd.Get("Sell-to Customer No.", "Ship-to Code") and (ShipToAdd."Phone No." <> '') then
//                 //             CustAddrShipto_Arr[7] := 'Tel No.: ' + ShipToAdd."Phone No."
//                 //         // else
//                 //         //     if "Sell-to Phone No." <> '' then
//                 //         //         CustAddrShipto_Arr[7] := 'Tel No.: ' + "Sell-to Phone No.";

//                 //     end;
//                 //     //  else
//                 //     //     if "Sell-to Phone No." <> '' then
//                 //     //         CustAddrShipto_Arr[7] := 'Tel No.: ' + "Sell-to Phone No.";
//                 //     //AW09032020<<
//                 // end; //MS-+
//                 // CompressArray(CustAddrShipTo_Arr);

//                 // CustTRN := '';
//                 // Cust.Reset;
//                 // Cust.get("Sales Shipment Header"."Sell-to Customer No.");

//                 // if Cust."VAT Registration No." <> '' then begin
//                 //     if Cust."Tax Type" <> '' then begin
//                 //         if "VAT Registration No." <> '' then begin
//                 //             CustTRN := Cust."Tax Type" + ': ' + "VAT Registration No."
//                 //         end else begin
//                 //             CustTRN := '';
//                 //         end;
//                 //     end else begin
//                 //         CustTRN := 'TRN: ' + "VAT Registration No.";
//                 //     end;
//                 // end;


//                 // //CustTRN := 'TRN : ' + Cust."VAT Registration No.";
//                 // SrNo := 0;
//                 // //Message('Shipment no. :%1', "No.");
//                 // //Code to Hide Comment
//                 // If ShowComment THEN begin
//                 //     Comment_Lrec.Reset();
//                 //     Comment_Lrec.SetRange("No.", "No.");
//                 //     Comment_Lrec.SETRAnge("Document Type", Comment_Lrec."Document Type"::Shipment);
//                 //     Comment_Lrec.SetRange("Document Line No.", 0);
//                 //     ShowComment := Not Comment_Lrec.IsEmpty();
//                 // end;
//                 // //AW
//                 // Clear(CustAltAddr_Arr);
//                 // //AW-06032020>>
//                 // if CustAltAddrBool = true then begin
//                 //     if CustAltAddrRec.Get("Bill-to Customer No.") then begin
//                 //         // FormatAddr.FormatAddr(CustAltAddr_Arr, CustAltAddrRec.Name, '', CustAltAddrRec.Contact, CustAltAddrRec.Address, CustAltAddrRec.Address2, CustAltAddrRec.City, CustAltAddrRec.PostCode, CustAltAddrRec.County, CustAltAddrRec."Country/Region Code");
//                 //         CustAddr_Arr[1] := CustAltAddrRec.Name;
//                 //         CustAddr_Arr[2] := CustAltAddrRec.Address;
//                 //         CustAddr_Arr[3] := CustAltAddrRec.Address2;
//                 //         CustAddr_Arr[4] := CustAltAddrRec.City;
//                 //         CustAddr_Arr[5] := CustAltAddrRec.PostCode;
//                 //         if CountryRegionL.Get(CustAltAddrRec."Country/Region Code") then
//                 //             CustAddr_Arr[6] := CountryRegionL.Name;
//                 //         if CustAltAddrRec.Get("Bill-to Customer No.") then
//                 //             if CustAltAddrRec.PhoneNo <> '' then
//                 //                 CustAddr_Arr[7] := 'Tel No.: ' + CustAltAddrRec.PhoneNo;
//                 //         // if "Customer Registration No." <> '' then

//                 //         if CustAltAddrRec."Customer Registration No." <> '' then
//                 //             CustAddr_Arr[8] := CustAltAddrRec."Customer Registration Type" + ': ' + CustAltAddrRec."Customer Registration No.";
//                 //         if CustAltAddrRec."Customer TRN" <> '' then
//                 //             CustAddr_Arr[9] := 'TRN: ' + CustAltAddrRec."Customer TRN"
//                 //         else
//                 //             CustAddr_Arr[9] := CustTRN;
//                 //         CompressArray(CustAddr_Arr);
//                 //     end
//                 //     else begin
//                 //         //if cust alt address not found
//                 //         CustAddr_Arr[1] := "Bill-to Name";
//                 //         CustAddr_Arr[2] := "Bill-to Address";
//                 //         CustAddr_Arr[3] := "Bill-to Address 2";
//                 //         CustAddr_Arr[4] := "Bill-to City";
//                 //         CustAddr_Arr[5] := "Bill-to Post Code";
//                 //         if CountryRegionL.Get("Bill-to Country/Region Code") then
//                 //             CustAddr_Arr[6] := CountryRegionL.Name;
//                 //         CustomerRec.Reset();
//                 //         if CustomerRec.Get("Bill-to Customer No.") and (CustomerRec."Phone No." <> '') then
//                 //             CustAddr_Arr[7] := 'Tel No.: ' + CustomerRec."Phone No."
//                 //         else
//                 //             if "Sell-to Phone No." <> '' then
//                 //                 CustAddr_Arr[7] := 'Tel No.: ' + "Sell-to Phone No.";
//                 //         if "Customer Registration No." <> '' then
//                 //             CustAddr_Arr[8] := "Customer Registration Type" + ': ' + "Customer Registration No.";
//                 //         if CustTRN <> '' then
//                 //             CustAddr_Arr[9] := CustTRN;
//                 //         CompressArray(CustAddr_Arr);
//                 //     end;
//                 // end
//                 // //SJ>>24-02-20
//                 // else begin
//                 //     //if bool false
//                 //     //AW-06032020<<
//                 //     CustAddr_Arr[1] := "Bill-to Name";
//                 //     CustAddr_Arr[2] := "Bill-to Address";
//                 //     CustAddr_Arr[3] := "Bill-to Address 2";
//                 //     CustAddr_Arr[4] := "Bill-to City";
//                 //     CustAddr_Arr[5] := "Bill-to Post Code";
//                 //     if CountryRegionL.Get("Bill-to Country/Region Code") then
//                 //         CustAddr_Arr[6] := CountryRegionL.Name;
//                 //     CustomerRec.Reset();
//                 //     if CustomerRec.Get("Bill-to Customer No.") and (CustomerRec."Phone No." <> '') then
//                 //         CustAddr_Arr[7] := 'Tel No.: ' + CustomerRec."Phone No."
//                 //     else
//                 //         if "Sell-to Phone No." <> '' then
//                 //             CustAddr_Arr[7] := 'Tel No.: ' + "Sell-to Phone No.";
//                 //     if "Customer Registration No." <> '' then
//                 //         CustAddr_Arr[8] := "Customer Registration Type" + ': ' + "Customer Registration No.";
//                 //     if CustTRN <> '' then
//                 //         CustAddr_Arr[9] := CustTRN;
//                 //     CompressArray(CustAddr_Arr);

//                 // end;
//                 // //SJ<<24-02-20 
//                 // //AW
//                 // SalesHeaderRec.Reset();
//                 // if SalesHeaderRec.Get(SalesHeaderRec."Document Type"::Order, "Order No.") then
//                 //     SalesOrderDate := SalesHeaderRec."Order Date";

//                 // SerialNo := 0;
//                 // if ShowDeliveryNote then begin
//                 //     SerialNo += 1;
//                 //     SrNo1 := SerialNo;
//                 // end;
//                 // if "Duty Exemption" then begin
//                 //     // SerialNo += 1;
//                 //     // SrNo2 := SerialNo;
//                 // end;
//                 SrNo3 := SerialNo;
//             end;
//         }
//     }

//     requestpage
//     {
//         layout
//         {
//             area(content)
//             {
//                 group(Options)
//                 {
//                     field("Show Delivery Note"; ShowDeliveryNote)
//                     {
//                         ApplicationArea = All;
//                     }
//                     field("Show Comment"; ShowComment)
//                     {
//                         ApplicationArea = All;
//                     }
//                     field("Print Customer Invoice"; PostedCustomInvoiceG)
//                     {
//                         ApplicationArea = ALL;
//                     }
//                     field(CustAltAddrBool; CustAltAddrBool)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'Customer Alternate Address';
//                     }
//                     field(Hide_E_sign; Hide_E_sign)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Hide E-Signature';
//                     }
//                     field(Print_copy; Print_copy)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Print Copy Document';
//                     }
//                     field("Print Clearance Ship-To Address"; blnClrAddress)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Print Clearance Ship-To Address';
//                     }
//                     field("SalesLine Merge"; SalesLineMerge)
//                     {
//                         ApplicationArea = All;
//                         Caption = 'SalesLine UnMerge';
//                     }
//                     field(PrintStamp; PrintStamp)
//                     {
//                         ApplicationArea = all;
//                         Caption = 'Print Digital Stamp';
//                     }
//                 }
//             }
//         }


//         actions
//         {
//         }
//     }

//     labels
//     {
//         DocumentNo_Lbl = 'Packing Ref.: ';
//         documentDateLbl = 'Date: ';
//         Customerref = 'Customer Ref.:';
//         SalesOrderNo_Lbl = 'Sales Order No.';
//         SrNo_Lbl = 'No.';
//         Remark_lbl = 'Remarks';
//         Tel_Lbl = 'Tel:';
//         Web_Lbl = 'Web:';
//         Warehouse_Lbl = 'Warehouse';
//         BatchDetails_Lbl = 'Batch Details';
//         Comments_Lbl = 'Remarks';
//         Receivedby_Lbl = 'Received by';
//         ConsigneeSignatory_Lbl = 'Signature';
//         Stamp_Lbl = 'Stamp';
//         Date_Lbl = 'Date:';
//         UOM_Lbl = 'UOM';
//         Origin_Lbl = 'Origin: ';
//         HSCode_Lbl = 'HS Code: ';
//         Packing_Lbl = 'Packing: ';
//         NoOfLoads_Lbl = 'No. Of Loads: ';
//         Netwt_Lbl = 'Net Weight (kg):';
//         Grs_Wt_Lbl = 'Gross Weight (kg): ';
//         TotalNetWgtLbl = 'Total Net Weight (kg):';
//         TotalGrsWgtLbt = 'Total Gross Weight (kg):';
//         Total_Lbl = 'Total';
//         BillofMat_Lbl = 'BOE';

//         LotNo_ItemLedgerEntryCaption_Lbl = 'Lot No.';
//         Packing_Drm_lbl = 'Packing';
//         Qty_Lbl = 'Quantity';
//         PINo_Lbl = 'P/I No.:';
//         PIdate_Lbl = 'P/I Date:';
//         LCNumber_Lbl = 'L/C Number:';
//         LCDate_Lbl = 'L/C Date:';
//         TRN_Lbl = 'TRN:';
//         Page_Lbl = 'Page';
//         IMCOCode = 'IMCO Class: ';
//         CustAltAddr = 'Customer Alternate Address';
//         Fix_Remark_lbl = 'The buyer agreed to provide duty exemption documents to the seller, otherwise the selling price should be revised.';

//     }

//     trigger OnPreReport()
//     var
//         DeliveryNote_LCtxt: Label 'DELIVERY NOTE';
//         PackingList_LCtxt: Label 'PACKING LIST';
//     // StringProper: Codeunit "String Proper";
//     begin
//         CompanyInformation.Get;
//         CompanyInformation.CalcFields(Picture, Stamp);
//         CountryRec.Get(CompanyInformation."Country/Region Code");
//         // CompanyCity := StringProper.ConvertString(CompanyInformation.City);

//         ReportCapation := PackingList_LCtxt;
//         if ShowDeliveryNote then
//             ReportCapation := DeliveryNote_LCtxt;
//     end;

//     var
//         CompanyInformation: Record "Company Information";
//         ReportCapation: Text[50];
//         ShowDeliveryNote: Boolean;
//         PostedCustomInvoiceG: Boolean;
//         ShowComment: Boolean;
//         CustAddr_Arr: array[9] of Text[100];
//         CustAddrShipTo_Arr: array[8] of Text[100];
//         SrNo: Integer;
//         ItemDesc: Text[100];
//         LastLotNo: Code[30];
//         HSNCode: Code[20];
//         Origitext: Text[50];
//         CustTRN: Text[100];
//         SearchDesc: Text[100];
//         ILEUOM: Text[50];
//         ILQty: Decimal;
//         SalesUOM: Text[50];
//         SalesQty: Decimal;
//         Packing_GrossWt: Decimal;
//         PackingTxt: Text[100];
//         PackingTxt2: Text[100];
//         AltUOM2: Code[20];
//         SNO: Integer;
//         SalesOrderDate: Date;
//         CustAltAddrRec: Record "Customer Alternet Address";
//         CustAltAddr_Arr: array[8] of Text[100];
//         CustAltAddrBool: Boolean;
//         blnClrAddress: Boolean;
//         CountryRegionL: Record "Country/Region";
//         SerialNo: Integer;
//         SrNo1: Integer;
//         SrNo2: Integer;
//         SrNo3: Integer;
//         SrNo4: Integer;
//         PINONew: Code[20];
//         Hide_E_sign: Boolean;
//         PIDATENew: date;
//         Print_copy: Boolean;
//         ShipmentLineAltQty: Decimal;
//         AltqtyFactor: Decimal;
//         TotalNetWeight: Decimal;
//         TotalGrossWeight: Decimal;
//         CountryRec: Record "Country/Region";
//         CompanyCity: Text;
//         LotBaseQTy: Decimal;
//         TotalBaseQty: Decimal;
//         TotalUOM: Code[20];
//         TotalLbl: Text;
//         ILEBaseQty: Decimal;
//         SalesLineMerge: Boolean;
//         ImcoCodeText: Text;
//         PrintStamp: Boolean;
//         AltUOMTotalqty: Decimal;
//         NetWeightLine: Decimal;
//         GrossWeightLine: Decimal;

//     // procedure GetLowestUOM(ItemCode: Code[20]) LowestUOM: Code[20]
//     // var
//     //     ItemUOM: Record "Item Unit of Measure";
//     // begin
//     //     ItemUOM.Reset();
//     //     ItemUOM.Get(ItemCode);
//     //     ItemUOM.SetCurrentKey("Qty. per Unit of Measure");
//     //     if ItemUOM.FindFirst() then LowestUOM := ItemUOM.Code;
//     //     exit(LowestUOM);
//     // end;
// }
