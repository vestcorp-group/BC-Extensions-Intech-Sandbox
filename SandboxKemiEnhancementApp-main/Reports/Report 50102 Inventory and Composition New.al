// report 70000 Inventory_age_value4 //T12573-N
// {
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;
//     DefaultLayout = RDLC;
//     Permissions = tabledata "Item Ledger Entry" = rm;
//     RDLCLayout = './Layouts/Inventory Age Composition and Valuation3.rdl';
//     Caption = 'Inventory Age Composition and Valuation GRN Date';

//     dataset
//     {
//         dataitem(Location; Location)
//         {
//             column(Code; Code)
//             {
//             }
//             dataitem(Item; Item)
//             {
//                 DataItemLinkReference = Location;
//                 DataItemLink = "Location Filter" = field(Code);
//                 DataItemTableView = SORTING("No.") WHERE("Inventory Posting Group" = FILTER('<>SAMPLE'));
//                 RequestFilterFields = "No.";

//                 column(Company; CurrentCompany)
//                 {
//                 }
//                 column(No_; "No.")
//                 {
//                 }
//                 column(DescriptionI; Description)
//                 {
//                 }
//                 column(Base_Unit_of_Measure; "Base Unit of Measure")
//                 {
//                 }
//                 column(Inventory_Posting_Group; "Inventory Posting Group")
//                 {
//                 }
//                 column(Inventory; Inventory)
//                 {
//                 }
//                 dataitem("Item Variant"; "Item Variant")
//                 {
//                     DataItemLink = "Item No." = field("No.");
//                     column(DescriptionV; Description)
//                     {
//                     }
//                     column(Code_ItemVariant; "Code")
//                     {
//                     }
//                     column(InventoryQty; InventoryQty)
//                     {
//                         DecimalPlaces = 0 : 3;
//                     }
//                     column(ExpectedCost; ExpectedCost)
//                     {
//                     }
//                     column(ActualCost; ActualCost)
//                     {
//                     }
//                     column(LandedUnitCost; LandedUnitCost)
//                     {
//                     }
//                     column(Bracket90D_Qty; Bracket90D_Qty)
//                     {
//                     }
//                     column(bracket180D_Qty; bracket180D_Qty)
//                     {
//                     }
//                     column(bracket360D_qty; bracket360D_qty)
//                     {
//                     }
//                     column(bracket720D_qty; bracket720D_qty)
//                     {
//                     }
//                     column(bracket30D_Qty; bracket30D_Qty)
//                     {
//                     }
//                     column(bracket30D_Value; bracket30D_Value)
//                     {
//                     }
//                     column(Bracket90D_Value; Bracket90D_Value)
//                     {
//                     }
//                     column(bracket180D_Value; bracket180D_Value)
//                     {
//                     }
//                     column(bracket360D_Value; bracket360D_Value)
//                     {
//                     }
//                     column(bracket720D_Value; bracket720D_Value)
//                     {
//                     }
//                     column(BracketMorethan720DQty; BracketMorethan720DQty)
//                     {
//                     }
//                     column(bracketMorethan720D_Value; bracketMorethan720D_Value)
//                     {
//                     }
//                     column(AsonDate; AsonDate)
//                     {
//                     }
//                     column(TotalCost; TotalCost)
//                     {
//                     }
//                     trigger OnAfterGetRecord()
//                     var
//                         ValueEntry: Record "Value Entry";
//                         ILE: record "Item Ledger Entry";
//                         itemapplication: Record "Item Application Entry";
//                     begin
//                         Clear(ValueEntry);
//                         Clear(ActualCost);
//                         Clear(ExpectedCost);
//                         Clear(TotalCost);
//                         Clear(InventoryQty);
//                         Clear(LandedUnitCost);
//                         Clear(bracket180D_Qty);
//                         Clear(Bracket90D_Qty);
//                         Clear(bracket30D_Qty);
//                         Clear(bracket360D_qty);
//                         Clear(bracket720D_qty);
//                         Clear(BracketMorethan720DQty);
//                         Clear(bracket30D_Value);
//                         Clear(Bracket90D_Value);
//                         Clear(bracket180D_Value);
//                         Clear(bracket360D_Value);
//                         Clear(bracket720D_Value);
//                         Clear(bracketMorethan720D_Value);

//                         ItemLedgerEntry_gRec.Reset();
//                         ItemLedgerEntry_gRec.SetRange("Item No.", Item."No.");
//                         ItemLedgerEntry_gRec.SetRange("Location Code", Location.Code);
//                         ItemLedgerEntry_gRec.SetFilter("Group GRN Date", '..%1', AsonDate);
//                         ItemLedgerEntry_gRec.SetFilter("Posting Date", '..%1', AsonDate);
//                         ItemLedgerEntry_gRec.CalcSums(Quantity);

//                         ValueEntry.SetFilter("Group GRN Date", '..%1', AsonDate);
//                         ValueEntry.SetFilter("Posting Date", '..%1', AsonDate);
//                         ValueEntry.SetRange("Item No.", Item."No.");
//                         ValueEntry.SetRange("Variant Code", "Item Variant".Code);
//                         ValueEntry.SetRange("Location Code", Location.Code);
//                         ValueEntry.CalcSums("Cost Amount (Expected)");
//                         ExpectedCost := ValueEntry."Cost Amount (Expected)";
//                         ValueEntry.CalcSums("Cost Amount (Actual)");
//                         ActualCost := ValueEntry."Cost Amount (Actual)";
//                         TotalCost := ExpectedCost + ActualCost;

//                         if (ItemLedgerEntry_gRec.Quantity = 0) and (ExpectedCost = 0) and (ActualCost = 0) then
//                             CurrReport.Skip();

//                         ILE.Reset();
//                         ILE.SetFilter("Group GRN Date", '..%1', AsonDate);
//                         ILE.SetFilter("Posting Date", '..%1', AsonDate);
//                         ILE.SetRange("Item No.", Item."No.");
//                         ILE.SetRange("Variant Code", "Item Variant".Code);
//                         ILE.SetRange("Location Code", Location.Code);
//                         ILE.CalcSums(Quantity);
//                         InventoryQty := ILE.Quantity;
//                         ILE.SetRange(Positive, true);
//                         ILE.SetRange("Item No.", item."No."); //AJAY
//                         ILE.SetRange("Variant Code", "Item Variant".Code);
//                         ILE.SetRange("Location Code", Location.Code);
//                         if ILE.FindSet() then
//                             repeat
//                                 if (ile."Group GRN Date" > bracket30D) then begin
//                                     itemapplication.Reset();
//                                     itemapplication.SetRange("Inbound Item Entry No.", ILE."Entry No.");
//                                     itemapplication.SetFilter("posting date", '..%1', AsonDate);
//                                     itemapplication.CalcSums(Quantity);
//                                     bracket30D_Qty += itemapplication.Quantity;
//                                 end;
//                                 if (ile."Group GRN Date" > bracket90D) and (ile."Group GRN Date" <= bracket30D) then begin
//                                     itemapplication.Reset();
//                                     itemapplication.SetRange("Inbound Item Entry No.", ILE."Entry No.");
//                                     itemapplication.SetFilter("posting date", '..%1', AsonDate);
//                                     itemapplication.CalcSums(Quantity);
//                                     bracket90D_Qty += itemapplication.Quantity;
//                                 end;
//                                 if (ile."Group GRN Date" > bracket180D) and (ile."Group GRN Date" <= Bracket90D) then begin
//                                     itemapplication.Reset();
//                                     itemapplication.SetRange("Inbound Item Entry No.", ILE."Entry No.");
//                                     itemapplication.SetFilter("posting date", '..%1', AsonDate);
//                                     itemapplication.CalcSums(Quantity);
//                                     bracket180D_Qty += itemapplication.Quantity;
//                                 end;
//                                 if (ile."Group GRN Date" > bracket360D) and (ile."Group GRN Date" <= bracket180D) then begin
//                                     itemapplication.Reset();
//                                     itemapplication.SetRange("Inbound Item Entry No.", ILE."Entry No.");
//                                     itemapplication.SetFilter("Posting Date", '..%1', AsonDate);
//                                     itemapplication.CalcSums(Quantity);
//                                     bracket360D_Qty += itemapplication.Quantity;
//                                 end;
//                                 if (ile."Group GRN Date" > bracket720D) and (ile."Group GRN Date" <= bracket360D) then begin
//                                     itemapplication.Reset();
//                                     itemapplication.SetRange("Inbound Item Entry No.", ILE."Entry No.");
//                                     itemapplication.SetFilter("Posting Date", '..%1', AsonDate);
//                                     itemapplication.CalcSums(Quantity);
//                                     bracket720D_Qty += itemapplication.Quantity;
//                                 end;
//                                 if ile."Group GRN Date" <= bracket720D then begin
//                                     itemapplication.Reset();
//                                     itemapplication.SetRange("Inbound Item Entry No.", ILE."Entry No.");
//                                     itemapplication.SetFilter("Posting Date", '..%1', AsonDate);
//                                     itemapplication.CalcSums(Quantity);
//                                     BracketMorethan720DQty += itemapplication.Quantity;
//                                 end;
//                             until ILE.Next() = 0;
//                         if (TotalCost <> 0) and (InventoryQty <> 0) then LandedUnitCost := TotalCost / InventoryQty;
//                         if not Show_0_qty then begin
//                             if (InventoryQty = 0) and (ExpectedCost = 0) and (ActualCost = 0) then CurrReport.Skip();
//                         end;
//                         bracket30D_Value := LandedUnitCost * bracket30D_Qty;
//                         Bracket90D_Value := LandedUnitCost * Bracket90D_Qty;
//                         Bracket180D_Value := LandedUnitCost * bracket180D_Qty;
//                         Bracket360D_Value := LandedUnitCost * Bracket360D_Qty;
//                         Bracket720D_Value := LandedUnitCost * Bracket720D_Qty;
//                         bracketMorethan720D_Value := LandedUnitCost * BracketMorethan720DQty;
//                     end;

//                     trigger OnPreDataItem()
//                     var
//                         myInt: Integer;
//                     begin
//                         Clear(ActualCost);
//                         Clear(ExpectedCost);
//                         Clear(TotalCost);
//                         Clear(InventoryQty);
//                         Clear(LandedUnitCost);
//                         Clear(bracket180D_Qty);
//                         Clear(Bracket90D_Qty);
//                         Clear(bracket30D_Qty);
//                         Clear(bracket360D_qty);
//                         Clear(bracket720D_qty);
//                         Clear(BracketMorethan720DQty);
//                         Clear(bracket30D_Value);
//                         Clear(Bracket90D_Value);
//                         Clear(bracket180D_Value);
//                         Clear(bracket360D_Value);
//                         Clear(bracket720D_Value);
//                         Clear(bracketMorethan720D_Value);
//                         ItemLedgerEntry_gRec.Reset();
//                         ItemLedgerEntry_gRec.SetRange("Item No.", Item."No.");
//                         if not ItemLedgerEntry_gRec.FindFirst() then CurrReport.Skip();
//                     end;
//                 }
//                 dataitem(Integer; Integer)
//                 {
//                     MaxIteration = 1;
//                     DataItemTableView = where(Number = const(1));

//                     column(InventoryQty2; InventoryQty)
//                     {
//                         DecimalPlaces = 0 : 3;
//                     }
//                     column(ExpectedCost2; ExpectedCost)
//                     {
//                     }
//                     column(ActualCost2; ActualCost)
//                     {
//                     }
//                     column(LandedUnitCost2; LandedUnitCost)
//                     {
//                     }
//                     column(Bracket90D_Qty2; Bracket90D_Qty)
//                     {
//                     }
//                     column(bracket180D_Qty2; bracket180D_Qty)
//                     {
//                     }
//                     column(bracket360D_qty2; bracket360D_qty)
//                     {
//                     }
//                     column(bracket720D_qty2; bracket720D_qty)
//                     {
//                     }
//                     column(bracket30D_Qty2; bracket30D_Qty)
//                     {
//                     }
//                     column(bracket30D_Value2; bracket30D_Value)
//                     {
//                     }
//                     column(Bracket90D_Value2; Bracket90D_Value)
//                     {
//                     }
//                     column(bracket180D_Value2; bracket180D_Value)
//                     {
//                     }
//                     column(bracket360D_Value2; bracket360D_Value)
//                     {
//                     }
//                     column(bracket720D_Value2; bracket720D_Value)
//                     {
//                     }
//                     column(BracketMorethan720DQty2; BracketMorethan720DQty)
//                     {
//                     }
//                     column(bracketMorethan720D_Value2; bracketMorethan720D_Value)
//                     {
//                     }
//                     column(AsonDate2; AsonDate)
//                     {
//                     }
//                     column(TotalCost2; TotalCost)
//                     {
//                     }
//                     column(Description2_gTxt; Description2_gTxt)
//                     {
//                     }
//                     trigger OnAfterGetRecord()
//                     var
//                         ValueEntry: Record "Value Entry";
//                         ILE: record "Item Ledger Entry";
//                         itemapplication: Record "Item Application Entry";
//                     begin
//                         Clear(ValueEntry);
//                         Clear(ActualCost);
//                         Clear(ExpectedCost);
//                         Clear(TotalCost);
//                         Clear(InventoryQty);
//                         Clear(LandedUnitCost);
//                         Clear(bracket180D_Qty);
//                         Clear(Bracket90D_Qty);
//                         Clear(bracket30D_Qty);
//                         Clear(bracket360D_qty);
//                         Clear(bracket720D_qty);
//                         Clear(BracketMorethan720DQty);
//                         Clear(bracket30D_Value);
//                         Clear(Bracket90D_Value);
//                         Clear(bracket180D_Value);
//                         Clear(bracket360D_Value);
//                         Clear(bracket720D_Value);
//                         Clear(bracketMorethan720D_Value);
//                         Clear(Description2_gTxt);

//                         ItemLedgerEntry_gRec.Reset();
//                         ItemLedgerEntry_gRec.SetRange("Item No.", Item."No.");
//                         ItemLedgerEntry_gRec.SetRange("Location Code", Location.Code);
//                         ItemLedgerEntry_gRec.SetFilter("Group GRN Date", '..%1', AsonDate);
//                         ItemLedgerEntry_gRec.SetFilter("Posting Date", '..%1', AsonDate);
//                         ItemLedgerEntry_gRec.CalcSums(Quantity);

//                         ValueEntry.SetFilter("Group GRN Date", '..%1', AsonDate);
//                         ValueEntry.SetFilter("Posting Date", '..%1', AsonDate);
//                         ValueEntry.SetRange("Item No.", Item."No.");
//                         ValueEntry.SetRange("Location Code", Location.code);
//                         ValueEntry.SetFilter("Variant Code", '%1', '');
//                         ValueEntry.CalcSums("Cost Amount (Expected)");
//                         ExpectedCost := ValueEntry."Cost Amount (Expected)";
//                         ValueEntry.CalcSums("Cost Amount (Actual)");
//                         ActualCost := ValueEntry."Cost Amount (Actual)";
//                         TotalCost := ExpectedCost + ActualCost;

//                         if (ItemLedgerEntry_gRec.Quantity = 0) and (ExpectedCost = 0) and (ActualCost = 0) then
//                             CurrReport.Skip();

//                         ILE.Reset();
//                         ILE.SetFilter("Group GRN Date", '..%1', AsonDate);
//                         ILE.SetFilter("Posting Date", '..%1', AsonDate);
//                         ILE.SetRange("Item No.", Item."No.");
//                         ILE.SetRange("Location Code", Location.code);
//                         ILE.SetFilter("Variant Code", '%1', '');
//                         ILE.CalcSums(Quantity);
//                         InventoryQty := ILE.Quantity;
//                         ILE.reset;
//                         ILE.SetRange(Positive, true);
//                         ILE.SetFilter("Group GRN Date", '..%1', AsonDate);
//                         //ILE.SetFilter("Posting Date", '..%1', AsonDate);
//                         ILE.SetRange("Item No.", item."No."); //AJAY
//                         ILE.SetRange("Location Code", Location.code);
//                         ILE.SetFilter("Variant Code", '%1', '');
//                         if ILE.FindSet() then
//                             repeat
//                                 Description2_gTxt := ILE.Description;
//                                 if (ile."Group GRN Date" > bracket30D) then begin
//                                     itemapplication.Reset();
//                                     itemapplication.SetRange("Inbound Item Entry No.", ILE."Entry No.");
//                                     itemapplication.SetFilter("posting date", '..%1', AsonDate);
//                                     itemapplication.CalcSums(Quantity);
//                                     bracket30D_Qty += itemapplication.Quantity;
//                                 end;
//                                 if (ile."Group GRN Date" > bracket90D) and (ile."Group GRN Date" <= bracket30D) then begin
//                                     itemapplication.Reset();
//                                     itemapplication.SetRange("Inbound Item Entry No.", ILE."Entry No.");
//                                     itemapplication.SetFilter("posting date", '..%1', AsonDate);
//                                     itemapplication.CalcSums(Quantity);
//                                     bracket90D_Qty += itemapplication.Quantity;
//                                 end;
//                                 if (ile."Group GRN Date" > bracket180D) and (ile."Group GRN Date" <= Bracket90D) then begin
//                                     itemapplication.Reset();
//                                     itemapplication.SetRange("Inbound Item Entry No.", ILE."Entry No.");
//                                     itemapplication.SetFilter("posting date", '..%1', AsonDate);
//                                     itemapplication.CalcSums(Quantity);
//                                     bracket180D_Qty += itemapplication.Quantity;
//                                 end;
//                                 if (ile."Group GRN Date" > bracket360D) and (ile."Group GRN Date" <= bracket180D) then begin
//                                     itemapplication.Reset();
//                                     itemapplication.SetRange("Inbound Item Entry No.", ILE."Entry No.");
//                                     itemapplication.SetFilter("Posting Date", '..%1', AsonDate);
//                                     itemapplication.CalcSums(Quantity);
//                                     bracket360D_Qty += itemapplication.Quantity;
//                                 end;
//                                 if (ile."Group GRN Date" > bracket720D) and (ile."Group GRN Date" <= bracket360D) then begin
//                                     itemapplication.Reset();
//                                     itemapplication.SetRange("Inbound Item Entry No.", ILE."Entry No.");
//                                     itemapplication.SetFilter("Posting Date", '..%1', AsonDate);
//                                     itemapplication.CalcSums(Quantity);
//                                     bracket720D_Qty += itemapplication.Quantity;
//                                 end;
//                                 if ile."Group GRN Date" <= bracket720D then begin
//                                     itemapplication.Reset();
//                                     itemapplication.SetRange("Inbound Item Entry No.", ILE."Entry No.");
//                                     itemapplication.SetFilter("Posting Date", '..%1', AsonDate);
//                                     itemapplication.CalcSums(Quantity);
//                                     BracketMorethan720DQty += itemapplication.Quantity;
//                                 end;
//                             until ILE.Next() = 0;
//                         if (TotalCost <> 0) and (InventoryQty <> 0) then LandedUnitCost := TotalCost / InventoryQty;
//                         if not Show_0_qty then begin
//                             if (InventoryQty = 0) and (ExpectedCost = 0) and (ActualCost = 0) then CurrReport.Skip();
//                         end;
//                         bracket30D_Value := LandedUnitCost * bracket30D_Qty;
//                         Bracket90D_Value := LandedUnitCost * Bracket90D_Qty;
//                         Bracket180D_Value := LandedUnitCost * bracket180D_Qty;
//                         Bracket360D_Value := LandedUnitCost * Bracket360D_Qty;
//                         Bracket720D_Value := LandedUnitCost * Bracket720D_Qty;
//                         bracketMorethan720D_Value := LandedUnitCost * BracketMorethan720DQty;
//                     end;

//                     trigger OnPreDataItem()
//                     var
//                         myInt: Integer;
//                     begin
//                         Clear(ActualCost);
//                         Clear(ExpectedCost);
//                         Clear(TotalCost);
//                         Clear(InventoryQty);
//                         Clear(LandedUnitCost);
//                         Clear(bracket180D_Qty);
//                         Clear(Bracket90D_Qty);
//                         Clear(bracket30D_Qty);
//                         Clear(bracket360D_qty);
//                         Clear(bracket720D_qty);
//                         Clear(BracketMorethan720DQty);
//                         Clear(bracket30D_Value);
//                         Clear(Bracket90D_Value);
//                         Clear(bracket180D_Value);
//                         Clear(bracket360D_Value);
//                         Clear(bracket720D_Value);
//                         Clear(bracketMorethan720D_Value);
//                         ItemLedgerEntry_gRec.Reset();
//                         ItemLedgerEntry_gRec.SetRange("Item No.", Item."No.");
//                         if not ItemLedgerEntry_gRec.FindFirst() then CurrReport.Skip();
//                     end;
//                 }
//                 trigger OnPreDataItem()
//                 var
//                 begin
//                     //Item.SetFilter("Inventory Posting Group", '<>Sample');
//                     IF ItemCodeFilter <> '' THEN begin
//                         IF TextManagement.MakeTextFilter(ItemCodeFilter) = 0 THEN Item.SetFilter("No.", ItemCodeFilter);
//                     End;
//                     //if ItemCategoryFilter <> '' then begin
//                     //IF TextManagement.MakeTextFilter(ItemCategoryFilter) = 0 THEN
//                     //Item.SetFilter("Item Category Code", ItemCategoryFilter);
//                     //end;
//                     IF InventoryPostingGroup <> '' then Item.SetFilter("Inventory Posting Group", InventoryPostingGroup);
//                     bracket30D := CalcDate('-30D', AsonDate);
//                     Bracket90D := CalcDate('-90D', AsonDate);
//                     bracket180D := CalcDate('-180D', AsonDate);
//                     bracket360D := CalcDate('-360D', AsonDate);
//                     bracket720D := CalcDate('-720D', AsonDate);
//                 end;

//                 trigger OnPostDataItem()
//                 var
//                     ile: Record "Item Ledger Entry";
//                 begin
//                     ile.Reset();
//                     ile.SetFilter("Remaining Quantity", '<>0');
//                     ile.SetFilter("Group GRN Date", '0D');
//                     if ile.FindSet() then
//                         repeat
//                             ile."Group GRN Date" := ile."Posting Date";
//                             ile.Modify();
//                         until ile.Next = 0;
//                 end;

//                 trigger OnAfterGetRecord()
//                 var
//                     ItemVariant_lRec: Record "Item Variant";
//                 begin
//                     ItemVariant_lRec.Reset();
//                     ItemVariant_lRec.SetRange("Item No.", "No.");
//                     if not ItemVariant_lRec.FindFirst() then CurrReport.Skip();
//                 end;
//             }
//             dataitem(Item_WOV; Item)
//             {
//                 DataItemLinkReference = Location;
//                 DataItemLink = "Location Filter" = field(Code);
//                 DataItemTableView = SORTING("No.") WHERE("Inventory Posting Group" = FILTER('<>SAMPLE'));
//                 RequestFilterFields = "No.";

//                 column(Company1; CurrentCompany)
//                 {
//                 }
//                 column(No_1; "No.")
//                 {
//                 }
//                 column(Description1; Description)
//                 {
//                 }
//                 column(Base_Unit_of_Measure1; "Base Unit of Measure")
//                 {
//                 }
//                 column(Inventory_Posting_Group1; "Inventory Posting Group")
//                 {
//                 }
//                 column(Inventory1; Inventory)
//                 {
//                 }
//                 column(InventoryQty1; InventoryQty)
//                 {
//                     DecimalPlaces = 0 : 3;
//                 }
//                 column(ExpectedCost1; ExpectedCost)
//                 {
//                 }
//                 column(ActualCost1; ActualCost)
//                 {
//                 }
//                 column(LandedUnitCost1; LandedUnitCost)
//                 {
//                 }
//                 column(Bracket90D_Qty1; Bracket90D_Qty)
//                 {
//                 }
//                 column(bracket180D_Qty1; bracket180D_Qty)
//                 {
//                 }
//                 column(bracket360D_qty1; bracket360D_qty)
//                 {
//                 }
//                 column(bracket720D_qty1; bracket720D_qty)
//                 {
//                 }
//                 column(bracket30D_Qty1; bracket30D_Qty)
//                 {
//                 }
//                 column(bracket30D_Value1; bracket30D_Value)
//                 {
//                 }
//                 column(Bracket90D_Value1; Bracket90D_Value)
//                 {
//                 }
//                 column(bracket180D_Value1; bracket180D_Value)
//                 {
//                 }
//                 column(bracket360D_Value1; bracket360D_Value)
//                 {
//                 }
//                 column(bracket720D_Value1; bracket720D_Value)
//                 {
//                 }
//                 column(BracketMorethan720DQty1; BracketMorethan720DQty)
//                 {
//                 }
//                 column(bracketMorethan720D_Value1; bracketMorethan720D_Value)
//                 {
//                 }
//                 column(AsonDate1; AsonDate)
//                 {
//                 }
//                 column(TotalCost1; TotalCost)
//                 {
//                 }
//                 trigger OnAfterGetRecord()
//                 var
//                     ValueEntry: Record "Value Entry";
//                     ILE: record "Item Ledger Entry";
//                     itemapplication: Record "Item Application Entry";
//                     itemVariant_lRec: Record "Item Variant";
//                 begin
//                     Clear(ValueEntry);
//                     Clear(ActualCost);
//                     Clear(ExpectedCost);
//                     Clear(TotalCost);
//                     Clear(InventoryQty);
//                     Clear(LandedUnitCost);
//                     Clear(bracket180D_Qty);
//                     Clear(Bracket90D_Qty);
//                     Clear(bracket30D_Qty);
//                     Clear(bracket360D_qty);
//                     Clear(bracket720D_qty);
//                     Clear(BracketMorethan720DQty);
//                     Clear(bracket30D_Value);
//                     Clear(Bracket90D_Value);
//                     Clear(bracket180D_Value);
//                     Clear(bracket360D_Value);
//                     Clear(bracket720D_Value);
//                     Clear(bracketMorethan720D_Value);
//                     itemVariant_lRec.Reset();
//                     itemVariant_lRec.SetRange("Item No.", Item_WOV."No.");
//                     if itemVariant_lRec.FindFirst()
//                     then
//                         CurrReport.Skip();
//                     ItemLedgerEntry_gRec.Reset();
//                     ItemLedgerEntry_gRec.SetRange("Item No.", Item_WOV."No.");
//                     if not ItemLedgerEntry_gRec.FindFirst()
//                     then
//                         CurrReport.Skip();
//                     ItemLedgerEntry_gRec.Reset();
//                     ItemLedgerEntry_gRec.SetRange("Item No.", Item_WOV."No.");
//                     ItemLedgerEntry_gRec.SetRange("Location Code", Location.Code);
//                     ItemLedgerEntry_gRec.SetFilter("Group GRN Date", '..%1', AsonDate);
//                     ItemLedgerEntry_gRec.SetFilter("Posting Date", '..%1', AsonDate);
//                     ItemLedgerEntry_gRec.CalcSums(Quantity);


//                     ValueEntry.SetFilter("Group GRN Date", '..%1', AsonDate);
//                     ValueEntry.SetFilter("Posting Date", '..%1', AsonDate);
//                     ValueEntry.SetRange("Item No.", Item_WOV."No.");
//                     ValueEntry.SetRange("Location Code", Location.code);
//                     ValueEntry.CalcSums("Cost Amount (Expected)");
//                     ExpectedCost := ValueEntry."Cost Amount (Expected)";
//                     ValueEntry.CalcSums("Cost Amount (Actual)");
//                     ActualCost := ValueEntry."Cost Amount (Actual)";
//                     TotalCost := ExpectedCost + ActualCost;

//                     if (ItemLedgerEntry_gRec.Quantity = 0) and (ExpectedCost = 0) and (ActualCost = 0) then
//                         CurrReport.Skip();

//                     ILE.Reset();
//                     ILE.SetFilter("Group GRN Date", '..%1', AsonDate);
//                     ILE.SetFilter("Posting Date", '..%1', AsonDate);
//                     ILE.SetRange("Item No.", Item_WOV."No.");
//                     ILE.SetRange("Location Code", Location.code);
//                     ILE.CalcSums(Quantity);
//                     InventoryQty := ILE.Quantity;
//                     ILE.SetRange(Positive, true);
//                     ILE.SetRange("Item No.", Item_WOV."No."); //AJAY
//                     //ILE.SetRange("Variant Code", "Item Variant".Code);
//                     ILE.SetRange("Location Code", Location.code);
//                     if ILE.FindSet() then
//                         repeat
//                             if (ile."Group GRN Date" > bracket30D) and (ILE."Group GRN Date" <= AsonDate) then begin
//                                 itemapplication.Reset();
//                                 itemapplication.SetRange("Inbound Item Entry No.", ILE."Entry No.");
//                                 //itemapplication.SetFilter("posting date", '..%1', AsonDate);
//                                 itemapplication.CalcSums(Quantity);
//                                 bracket30D_Qty += itemapplication.Quantity;
//                             end;
//                             if (ile."Group GRN Date" > bracket90D) and (ile."Group GRN Date" <= bracket30D) then begin
//                                 itemapplication.Reset();
//                                 itemapplication.SetRange("Inbound Item Entry No.", ILE."Entry No.");
//                                 itemapplication.SetFilter("posting date", '..%1', AsonDate);
//                                 itemapplication.CalcSums(Quantity);
//                                 bracket90D_Qty += itemapplication.Quantity;
//                             end;
//                             if (ile."Group GRN Date" > bracket180D) and (ile."Group GRN Date" <= Bracket90D) then begin
//                                 itemapplication.Reset();
//                                 itemapplication.SetRange("Inbound Item Entry No.", ILE."Entry No.");
//                                 itemapplication.SetFilter("posting date", '..%1', AsonDate);
//                                 itemapplication.CalcSums(Quantity);
//                                 bracket180D_Qty += itemapplication.Quantity;
//                             end;
//                             if (ile."Group GRN Date" > bracket360D) and (ile."Group GRN Date" <= bracket180D) then begin
//                                 itemapplication.Reset();
//                                 itemapplication.SetRange("Inbound Item Entry No.", ILE."Entry No.");
//                                 itemapplication.SetFilter("Posting Date", '..%1', AsonDate);
//                                 itemapplication.CalcSums(Quantity);
//                                 bracket360D_Qty += itemapplication.Quantity;
//                             end;
//                             if (ile."Group GRN Date" > bracket720D) and (ile."Group GRN Date" <= bracket360D) then begin
//                                 itemapplication.Reset();
//                                 itemapplication.SetRange("Inbound Item Entry No.", ILE."Entry No.");
//                                 itemapplication.SetFilter("Posting Date", '..%1', AsonDate);
//                                 itemapplication.CalcSums(Quantity);
//                                 bracket720D_Qty += itemapplication.Quantity;
//                             end;
//                             if ile."Group GRN Date" <= bracket720D then begin
//                                 itemapplication.Reset();
//                                 itemapplication.SetRange("Inbound Item Entry No.", ILE."Entry No.");
//                                 itemapplication.SetFilter("Posting Date", '..%1', AsonDate);
//                                 itemapplication.CalcSums(Quantity);
//                                 BracketMorethan720DQty += itemapplication.Quantity;
//                             end;
//                         until ILE.Next() = 0;
//                     if (TotalCost <> 0) and (InventoryQty <> 0) then LandedUnitCost := TotalCost / InventoryQty;
//                     if not Show_0_qty then begin
//                         if (InventoryQty = 0) and (ExpectedCost = 0) and (ActualCost = 0) then CurrReport.Skip();
//                     end;
//                     bracket30D_Value := LandedUnitCost * bracket30D_Qty;
//                     Bracket90D_Value := LandedUnitCost * Bracket90D_Qty;
//                     Bracket180D_Value := LandedUnitCost * bracket180D_Qty;
//                     Bracket360D_Value := LandedUnitCost * Bracket360D_Qty;
//                     Bracket720D_Value := LandedUnitCost * Bracket720D_Qty;
//                     bracketMorethan720D_Value := LandedUnitCost * BracketMorethan720DQty;
//                 end;

//                 trigger OnPreDataItem()
//                 var
//                 begin
//                     Clear(ActualCost);
//                     Clear(ExpectedCost);
//                     Clear(TotalCost);
//                     Clear(InventoryQty);
//                     Clear(LandedUnitCost);
//                     Clear(bracket180D_Qty);
//                     Clear(Bracket90D_Qty);
//                     Clear(bracket30D_Qty);
//                     Clear(bracket360D_qty);
//                     Clear(bracket720D_qty);
//                     Clear(BracketMorethan720DQty);
//                     Clear(bracket30D_Value);
//                     Clear(Bracket90D_Value);
//                     Clear(bracket180D_Value);
//                     Clear(bracket360D_Value);
//                     Clear(bracket720D_Value);
//                     Clear(bracketMorethan720D_Value);

//                     Item_WOV.CopyFilters(Item);
//                     //Item.SetFilter("Inventory Posting Group", '<>Sample');
//                     IF ItemCodeFilter <> '' THEN begin
//                         IF TextManagement.MakeTextFilter(ItemCodeFilter) = 0 THEN Item_WOV.SetFilter("No.", ItemCodeFilter);
//                     End;
//                     //if ItemCategoryFilter <> '' then begin
//                     //IF TextManagement.MakeTextFilter(ItemCategoryFilter) = 0 THEN
//                     //Item.SetFilter("Item Category Code", ItemCategoryFilter);
//                     //end;
//                     IF InventoryPostingGroup <> '' then Item_WOV.SetFilter("Inventory Posting Group", InventoryPostingGroup);
//                     bracket30D := CalcDate('-30D', AsonDate);
//                     Bracket90D := CalcDate('-90D', AsonDate);
//                     bracket180D := CalcDate('-180D', AsonDate);
//                     bracket360D := CalcDate('-360D', AsonDate);
//                     bracket720D := CalcDate('-720D', AsonDate);
//                 end;

//                 trigger OnPostDataItem()
//                 var
//                     ile: Record "Item Ledger Entry";
//                 begin
//                     // ile.Reset();
//                     // ile.SetFilter("Remaining Quantity", '<>0');
//                     // ile.SetFilter("Group GRN Date", '0D');
//                     // if ile.FindSet() then
//                     //     repeat
//                     //         ile."Group GRN Date" := ile."Posting Date";
//                     //         ile.Modify();
//                     //     until ile.Next = 0;
//                 end;
//             }
//         }
//     }
//     requestpage
//     {
//         //SaveValues = true;
//         layout
//         {
//             area(Content)
//             {
//                 field(AsonDate; AsonDate)
//                 {
//                     Caption = 'As on ';
//                     ApplicationArea = all;
//                 }
//                 field(Show_0_qty; Show_0_qty)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Show Items With 0 Qty.';
//                 }
//                 field("Inventory Posting Group"; InventoryPostingGroup)
//                 //TableRelation = "Inventory Posting Group";
//                 {
//                     ApplicationArea = all;
//                     TableRelation = "Inventory Posting Group";
//                 }
//             }
//         }
//     }
//     trigger OnInitReport()
//     begin
//         InventoryPostingGroup := 'PD';
//     end;

//     trigger OnPreReport()
//     var
//     begin
//         ItemCategoryFilter := Item.GetFilter("Item Category Code");
//         //InventoryPostingFilter := InventoryPostingGroup;
//         ItemCodeFilter := Item.GetFilter("No.");
//     end;

//     procedure CalcValue()
//     begin
//     end;

//     var
//         ExpectedCost: Decimal;
//         ActualCost: Decimal;
//         TotalCost: Decimal;
//         AsonDate: Date;
//         InventoryQty: Decimal;
//         LandedUnitCost: Decimal;
//         Show_0_qty: Boolean;
//         Company: Record Company;
//         TextManagement: Codeunit TextManagement;
//         Total_inventoryValue: Decimal;
//         bracket30D: Date;
//         Bracket90D: Date;
//         bracket180D: Date;
//         bracket360D: Date;
//         bracket720D: Date;
//         bracket30D_Qty: Decimal;
//         Bracket90D_Qty: Decimal;
//         bracket180D_Qty: Decimal;
//         ItemCodeFilter: Text[100];
//         bracket360D_qty: Decimal;
//         bracket720D_qty: Decimal;
//         ItemCategoryFilter: Text[100];
//         BracketMorethan720DQty: Decimal;
//         bracket30D_Value: Decimal;
//         Bracket90D_Value: Decimal;
//         bracket180D_Value: Decimal;
//         bracket360D_Value: Decimal;
//         bracket720D_Value: Decimal;
//         bracketMorethan720D_Value: Decimal;
//         InventoryPostingGroup: Code[250];
//         ItemLedgerEntry_gRec: Record "Item Ledger Entry";
//         Description2_gTxt: Text;
// }
