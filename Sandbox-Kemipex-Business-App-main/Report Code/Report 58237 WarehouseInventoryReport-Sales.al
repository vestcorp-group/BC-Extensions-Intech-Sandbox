// report 58237 "WarehouseInventoryreport-Sales"//T12370-Full Comment
// {
//     UsageCategory = Administration;
//     ApplicationArea = All;
//     Caption = 'ST04 Warehouse Inventory Report - Sales';
//     DefaultLayout = RDLC;
//     RDLCLayout = 'Reports/ST04 WarehouseInventoryreport-Sales.rdl';

//     //RDLCLayout = 'Reports/Warehouse/Test_KMP_WarehouseInventory.rdl';
//     dataset
//     {
//         dataitem(ItemLedEntryTemp; "Item Ledger Entry")
//         {
//             UseTemporary = true;

//             column(Location_Code_;
//             "Location Code")
//             {
//             }
//             column(Company_Name_;
//             CompanyShortNameG."Short Name")
//             {
//             }
//             // column(Of_Spec; "Of Spec") // Avinash: Commented because COA not moved to Live Yet.
//             // { }
//             column(Item_No_;
//             "Item No.")
//             {
//             }
//             column(Group_GRN_Date; "Group GRN Date") { }
//             column(Item_Desc_; itemg.Description)
//             {
//             }
//             column(ItemSearchDesc; ItemSearchDesc)
//             {
//             }
//             column(ItemInventoryPostingGroup; ItemG."Inventory Posting Group")
//             {
//             }
//             column(Unit_of_Measure_Code; ItemG."Base Unit of Measure")
//             {
//             }
//             // column(QtyOnHandInAltUOM; ItemUnitOfMesureG."Qty. per Unit of Measure" * ItemLedEntryTemp."Remaining Quantity")
//             // { }
//             //Made changes on 25-Jul-2019, as per Manish...below formula should be divided by instead of multiply
//             column(QtyOnHandInAltUOM; ItemLedEntryTemp."Remaining Quantity" / ItemUnitOfMesureG."Qty. per Unit of Measure")
//             {
//             }
//             column(Alternate_UOM_; ItemUnitOfMesureG.Code)
//             {
//             }
//             column(Quantity; Quantity)
//             {
//             }
//             // column(Reserved_Quantity; ItemLedEntryG."Reserved Quantity")
//             // { }
//             // column(UOM_Reserved_; ReservedUOMG)
//             // { }
//             // column(UOM_Reserved_; ItemLedEntryG."Reserved Quantity" / ItemUnitOfMesureG."Qty. per Unit of Measure")
//             // { }
//             column(Curent_Available_Stock_; "Remaining Quantity")
//             {
//             }
//             // column(Account_Name_; AccountNameG)
//             // { }
//             // column(Creation_Date_; ReservationDateG)
//             // { }
//             column(Posting_Date; "Posting Date")
//             {
//             }
//             column(Lot_No_; CustomLotNumber)
//             {
//             }
//             column(Country_Region_Code; Country_Region_Code)
//             {
//             }
//             column(Job_No_; "Job No.")
//             {
//             }
//             column("BOE_No_"; CustomBOENumber)
//             {
//             }
//             column(HS_Code_; HS_Code)
//             {
//             }
//             column(Expiration_Date; "Expiration Date")
//             {
//             }
//             column(ExpiryDays; ExpiryDaysG)
//             {
//             }
//             column(Entry_Type; "Entry Type")
//             {
//             }
//             column(Storage_Days_; StorageDaysG)
//             {
//             }
//             column(Inventory_Aging_; InventoryAgingG)
//             {
//             }
//             column(CompanyAddr1Value; CompanyAddrG[2])
//             {
//             }
//             column(CompanyAddr2Value; CompanyAddrG[3])
//             {
//             }
//             column(CompanyAddr3Value; CompanyAddrG[1])
//             {
//             }
//             // column(SONo; SONoG)
//             // { }
//             column(AsOfDate; StartDateG)
//             {
//             }
//             column(CompanyName_Filter; CompanyName_Filter)
//             {
//             }
//             column(Remaining_Quantity; "Remaining Quantity")
//             {
//             }
//             column(Entry_No_; "Entry No.")
//             {
//             }
//             column(Variant_Code; "Variant Code")
//             {
//             }
//             column(PackingDescription; PackingDescription)
//             {
//             }
//             dataitem(ReservationEntry; "Reservation Entry")
//             {
//                 DataItemTableView = where("Source Type" = CONST(32), "Reservation Status" = CONST(Reservation));
//                 DataItemLinkReference = ItemLedEntryTemp;
//                 DataItemLink = "Source Ref. No." = field("Applies-to Entry");

//                 dataitem(ReservationEntry2;
//                 "Reservation Entry")
//                 {
//                     DataItemTableView = where(Positive = filter(false));
//                     DataItemLinkReference = ReservationEntry;
//                     DataItemLink = "Entry No." = field("Entry No.");

//                     column(Reserved_Quantity; Abs("Quantity (Base)"))
//                     {
//                     }
//                     column(UOM_Reserved_;
//                     Abs("Quantity (Base)") / ItemUnitOfMesureG."Qty. per Unit of Measure")
//                     {
//                     }
//                     column(Account_Name_; AccountNameG)
//                     {
//                     }
//                     column(Creation_Date_; "Creation Date")
//                     {
//                     }
//                     column(SONo; SONoG)
//                     {
//                     }
//                     trigger OnPreDataItem()
//                     var
//                         myInt: Integer;
//                     begin
//                         ReservationEntry2.ChangeCompany(ItemLedEntryTemp.Description);
//                     end;

//                     trigger OnAfterGetRecord()
//                     var
//                         SalesLineL: Record "Sales Line";
//                         PurchaseLineL: Record "Purchase Line";
//                         CustomerL: Record Customer;
//                         VendorL: Record Vendor;
//                     begin
//                         CustomerL.ChangeCompany(ItemLedEntryTemp.Description);
//                         VendorL.ChangeCompany(ItemLedEntryTemp.Description);
//                         SalesLineL.ChangeCompany(ItemLedEntryTemp.Description);
//                         PurchaseLineL.ChangeCompany(ItemLedEntryTemp.Description);
//                         CASE "Source Type" OF
//                             DATABASE::"Sales Line":
//                                 BEGIN
//                                     SalesLineL.GET("Source Subtype", "Source ID", "Source Ref. No.");
//                                     CustomerL.get(SalesLineL."Sell-to Customer No.");
//                                     AccountNameG := CustomerL."Search Name";
//                                     ReservedUOMG := SalesLineL."Unit of Measure Code";
//                                     SONoG := "Source ID";
//                                     ReservationDateG := "Creation Date";
//                                 END;
//                             DATABASE::"Purchase Line":
//                                 BEGIN
//                                     PurchaseLineL.GET("Source Subtype", "Source ID", "Source Ref. No.");
//                                     VendorL.Get(PurchaseLineL."Buy-from Vendor No.");
//                                     AccountNameG := VendorL."Search Name";
//                                     ReservedUOMG := PurchaseLineL."Unit of Measure Code";
//                                 END;
//                         END;
//                     end;
//                 }
//                 trigger OnPreDataItem()
//                 var
//                     myInt: Integer;
//                 begin
//                     ReservationEntry.ChangeCompany(ItemLedEntryTemp.Description);
//                 end;
//             }
//             trigger OnPreDataItem()
//             begin
//                 ItemLedEntryTemp.FindFirst();
//             end;

//             trigger OnAfterGetRecord()
//             var
//                 PurchRcptHeaderL: Record "Purch. Rcpt. Header";
//                 SalesShipmentHeaderL: Record "Sales Shipment Header";
//                 VariantRec: Record "Item Variant";
//             begin
//                 Clear(ExpiryDaysG);
//                 if "Expiration Date" > 0D then begin
//                     EVALUATE(ExpiryDaysG, FORMAT("Expiration Date" - WorkDate));
//                 end
//                 else
//                     ExpiryDaysG := 0;
//                 if CompanyShortNameG.Get(ItemLedEntryTemp.Description) then;
//                 Clear(ReservationEntryG);
//                 Clear(StorageDaysG);
//                 Clear(InventoryAgingG);
//                 clear(SONoG);
//                 Clear(AccountNameG);
//                 Clear(ReservedUOMG);
//                 Clear(ReservationDateG);
//                 Clear(PackingDescription);
//                 ItemG.ChangeCompany(ItemLedEntryTemp.Description);
//                 ItemLedEntryG.ChangeCompany(ItemLedEntryTemp.Description);
//                 if ItemLedEntryG.Get(ItemLedEntryTemp."Applies-to Entry") then;
//                 ItemLedEntryG.CalcFields("Reserved Quantity");
//                 ItemG.Get(ItemLedEntryTemp."Item No.");
//                 ItemUnitOfMesureG.SetCurrentKey("Item No.", "Qty. per Unit of Measure");
//                 ItemUnitOfMesureG.SetRange("Item No.", ItemG."No.");
//                 if ItemUnitOfMesureG.FindFirst() then;
//                 if "Group GRN Date" <> 0D then StorageDaysG := StartDateG - "Group GRN Date";

//                 if "Variant Code" <> '' then begin // add by bayas
//                     VariantRec.Get("Item No.", "Variant Code");
//                     if VariantRec.Blocked1 = true then begin
//                         ItemSearchDesc := ItemG.Description + ' - RAW';
//                     end else
//                         if VariantRec.Description <> '' then begin
//                             ItemSearchDesc := VariantRec.Description;
//                         end else begin
//                             ItemSearchDesc := ItemG.Description;
//                         end;

//                     if VariantRec.CountryOfOrigin <> '' then begin
//                         Country_Region_Code := VariantRec.CountryOfOrigin;
//                     end else begin
//                         Country_Region_Code := ItemG."Country/Region of Origin Code";
//                     end;

//                     if VariantRec.HSNCode <> '' then begin
//                         HS_Code := VariantRec.HSNCode;
//                     end else begin
//                         HS_Code := ItemG."Tariff No.";
//                     end;

//                     if VariantRec."Packing Description" <> '' then begin
//                         PackingDescription := VariantRec."Packing Description";
//                     end else begin
//                         PackingDescription := itemg."Description 2";
//                     end;

//                 end else begin
//                     if ItemG."Sales Blocked" = true then begin
//                         ItemSearchDesc := 'Raw Material';
//                     end else
//                         if ItemG."Inventory Posting Group" = 'RAW' then begin
//                             ItemSearchDesc := 'Raw Material';
//                         end else begin
//                             ItemSearchDesc := itemg.Description;
//                         end;

//                     PackingDescription := itemg."Description 2";
//                     Country_Region_Code := ItemG."Country/Region of Origin Code";
//                     HS_Code := ItemG."Tariff No.";
//                 end;

//                 /* if StorageDaysG >= 180 then
//                      InventoryAgingG := '180-365 Days'
//                  else
//                      if StorageDaysG >= 90 then
//                          InventoryAgingG := '90-180 Days'
//                      else
//                          InventoryAgingG := '30-90 Days';*/

//                 // case "Source Type" of
//                 //     "Source Type"::Vendor:
//                 //         begin
//                 //             VendorL.Get("Source No.");
//                 //             //AccountNameG := VendorL.Name + ' ' + VendorL."Name 2";
//                 //             AccountNameG := VendorL."Search Name";
//                 //         end;
//                 //     "Source Type"::Customer:
//                 //         begin
//                 //             CustomerL.get("Source No.");
//                 //             //AccountNameG := CustomerL.Name + ' ' + CustomerL."Name 2";
//                 //             AccountNameG := CustomerL."Search Name";
//                 //         end;
//                 // end;
//                 case "Entry Type" of
//                     "Entry Type"::Sale:
//                         begin
//                             case "Document Type" of
//                                 "Document Type"::"Sales Shipment":
//                                     begin
//                                         SalesShipmentHeaderL.ChangeCompany(ItemLedEntryTemp.Description);
//                                         SalesShipmentHeaderL.get("Document No.");
//                                         // CustomBOENumberG := SalesShipmentHeaderL.CustomBOENumber;
//                                     end;
//                             end;
//                         end;
//                     "Entry Type"::Purchase:
//                         begin
//                             case "Document Type" of
//                                 "Document Type"::"Purchase Receipt":
//                                     begin
//                                         PurchRcptHeaderL.ChangeCompany(ItemLedEntryTemp.Description);
//                                         PurchRcptHeaderL.get("Document No.");
//                                         CustomBOENumberG := PurchRcptHeaderL.CustomBOENumber;
//                                     end;
//                             end;
//                         end;
//                 end;
//             end;
//         }
//     }
//     requestpage
//     {
//         SaveValues = true;
//         layout
//         {
//             area(Content)
//             {
//                 group(Filters)
//                 {
//                     field("As On Date"; StartDateG)
//                     {
//                         ApplicationArea = All;
//                     }
//                     field("Item No."; ItemNoG)
//                     {
//                         ApplicationArea = all;
//                         //TableRelation = Item;
//                         TableRelation = Item where("Inventory Posting Group" = filter(<> 'SAMPLE'));
//                     }
//                     field(Warehouse; WarehouseFilter)
//                     {
//                         ApplicationArea = all;
//                         TableRelation = Location;
//                     }
//                     // field("Location code"; LocationCodeG)
//                     // {
//                     //     ApplicationArea = all;
//                     //     TableRelation = Location;
//                     // }
//                     field("Company Name"; CompanyNameG)
//                     {
//                         ApplicationArea = all;
//                         TableRelation = Company;
//                     }
//                     field("Inventory Posting Group"; ItemInventoryPostGrpG)
//                     {
//                         ApplicationArea = all;
//                         TableRelation = "Inventory Posting Group";
//                     }
//                     field(Lot_filter; Lot_filter)
//                     {
//                         Caption = 'Lot No.';
//                         ApplicationArea = all;
//                     }
//                     field(BOE_filter; BOE_filter)
//                     {
//                         Caption = 'Bill of Entry No.';
//                         ApplicationArea = all;
//                     }
//                 }
//             }
//         }

//         trigger OnOpenPage()
//         var

//         begin
//             StartDateG := WorkDate();
//         end;
//     }
//     /*local procedure InsertTempRecord(var ItemLedEntryP: Record "Item Ledger Entry")
//       var
//           myInt: Integer;
//       begin
//           EntryNoG += 1;
//           ItemLedEntryTemp.Init();
//           ItemLedEntryTemp := ItemLedEntryP;
//           ItemLedEntryTemp."Entry No." := EntryNoG;
//           ItemLedEntryTemp.Description := ItemLedEntryP.CurrentCompany();
//           ItemLedEntryTemp."Applies-to Entry" := ItemLedEntryP."Entry No.";
//           ItemLedEntryTemp.Insert();
//       end;*/
//     // Avinash: Commented because of logic change in printing the Qty on Hand Base UOM
//     local procedure InsertTempRecord(var ItemLedEntryP: Record "Item Ledger Entry")
//     var
//         ItemApplnEntryL: Record "Item Application Entry";
//         AppliedQtyL: Decimal;
//     begin
//         EntryNoG += 1;
//         ItemApplnEntryL.ChangeCompany(ItemLedEntryP.CurrentCompany());
//         ItemApplnEntryL.SETCURRENTKEY("Inbound Item Entry No.", "Outbound Item Entry No.", "Cost Application");
//         ItemApplnEntryL.SETRANGE("Inbound Item Entry No.", ItemLedEntryP."Entry No.");
//         // ItemApplnEntryL.SETFILTER("Outbound Item Entry No.", '<>%1', 0);
//         ItemApplnEntryL.SETFILTER("Posting Date", '<=%1', StartDateG);
//         // ItemApplnEntryL.SETRANGE("Cost Application", false);
//         if ItemApplnEntryL.FindSet(false, false) then
//             repeat
//                 AppliedQtyL += (ItemApplnEntryL.Quantity);
//             until ItemApplnEntryL.Next() = 0;
//         ItemLedEntryTemp.Init();
//         ItemLedEntryTemp := ItemLedEntryP;
//         ItemLedEntryTemp."Entry No." := EntryNoG;
//         ItemLedEntryTemp."Remaining Quantity" := AppliedQtyL; //ItemLedEntryP.Quantity - AppliedQtyL;
//         ItemLedEntryTemp.Description := ItemLedEntryP.CurrentCompany();
//         ItemLedEntryTemp."Applies-to Entry" := ItemLedEntryP."Entry No.";
//         if ItemLedEntryTemp."Remaining Quantity" > 0 then // Avinash: Added this coz no need to show if the remaining qty is zero
//             ItemLedEntryTemp.Insert();
//     end;

//     trigger OnPreReport()
//     var
//         ItemL: Record Item;
//         RecShortName: Record "Company Short Name";//20MAY2022
//     begin
//         IF StartDateG = 0D then StartDateG := Today();
//         // Error(PostingDateErr);
//         // if ItemNoG = '' then
//         //     Error(ItemNoErr);
//         CompanyInfoG.Get();
//         FormatAddrG.Company(CompanyAddrG, CompanyInfoG);
//         Clear(ItemLedEntryTemp);
//         Clear(EntryNoG);
//         if CompanyNameG > '' then CompanyG.SetRange(Name, CompanyNameG);
//         CompanyG.FindSet();
//         repeat
//             Clear(RecShortName);//20MAY2022-start
//             RecShortName.SetRange(Name, CompanyG.Name);
//             RecShortName.SetRange("Block in Reports", true);
//             if not RecShortName.FindFirst() then begin

//                 ItemLedEntryG.ChangeCompany(CompanyG.Name);
//                 ItemLedEntryG.SetCurrentKey("Posting Date", "Item No.");
//                 ItemLedEntryG.SetFilter("Posting Date", '<=%1', StartDateG);
//                 ItemLedEntryG.SetFilter("Location Code", WarehouseFilter);
//                 ItemLedEntryG.SetFilter(CustomLotNumber, Lot_filter);
//                 ItemLedEntryG.SetFilter(CustomBOENumber, BOE_filter);

//                 //ItemLedEntryG.SetFilter("Remaining Quantity", '>%1', 0);
//                 ItemLedEntryG.SetRange(Positive, true);
//                 if ItemNoG > '' then ItemLedEntryG.SetRange("Item No.", ItemNoG);
//                 if ItemLedEntryG.FindSet() then
//                     repeat // InsertTempRecord(ItemLedEntryG)
//                         ItemL.Get(ItemLedEntryG."Item No.");
//                         If (ItemInventoryPostGrpG = '') then
//                             InsertTempRecord(ItemLedEntryG)
//                         else
//                             if (ItemL."Inventory Posting Group" = ItemInventoryPostGrpG) then InsertTempRecord(ItemLedEntryG)
//                             until ItemLedEntryG.Next() = 0;

//             end;
//         until CompanyG.Next() = 0;
//         if CompanyNameG > '' then
//             CompanyName_Filter := CompanyNameG
//         else
//             CompanyName_Filter := 'Group of Companies';
//     end;

//     var
//         ItemLedEntryG: Record "Item Ledger Entry";
//         CompanyInfoG: Record "Company Information";
//         CompanyShortNameG: Record "Company Short Name";
//         ItemUnitOfMesureG: Record "Item Unit of Measure";
//         CompanyG: Record Company;
//         ItemG: Record item;
//         ReservationEntryG: Record "Reservation Entry";
//         FormatAddrG: Codeunit "Format Address";
//         StartDateG: Date;
//         EndDateG: Date;
//         ReservationDateG: Date;
//         ItemNoG: Code[20];
//         ItemInventoryPostGrpG: Code[20];
//         LocationCodeG: Code[20];
//         SONoG: Code[20];
//         ReservedUOMG: Code[20];
//         ReservationNoG: Code[20];
//         AccountNameG: Text;
//         CustomBOENumberG: Text;
//         CompanyNameG: Text;
//         ExpiryDaysG: Integer;
//         StorageDaysG: Decimal;
//         InventoryAgingG: Text;
//         EntryNoG: Integer;
//         CompanyAddrG: array[8] of Text[100];
//         PostingDateErr: Label 'Please enter the Posting date to filter';
//         ItemNoErr: Label 'Item No. is mandatory. Please select the Item';
//         CompanyName_Filter: Text;
//         WarehouseFilter: Text;
//         BOE_filter: Text[20];
//         Lot_filter: Text[50];
//         PackingDescription: Text[100];
//         ItemSearchDesc: Text[100];
//         Country_Region_Code: Text[10];
//         HS_Code: Text[20];

// }
