// codeunit 50800 PhysInvtJnlMgt//T12370-Full Comment
// {
//     procedure ImportItemJournalFromExcel(JournalTemplateName: code[20]; JournalBatchName: code[20]; JnlDocNo: code[20]; JnlPostingDate: date) //PM JnlDOcNo and JnlPosting Para Added
//     var
//         BaseUOM: Code[10];
//         QtyCalcPerItem: Decimal;
//         QtyCalcPerLot: Decimal;
//         QtyCounted: Decimal;
//         DescriptionFreeText: text;
//         ItemJournalLine2: Record "Item Journal Line";
//         CountingDataSheet: Record "Counting DataSheet";
//         LocationCode: Code[10];
//         Location: Record Location;
//         PostingDate: Date;
//         DocNo: Code[20];
//         JnlTmpName: Code[10];
//         JnlBatchName: Code[10];
//         VersionNo: Option "1","2","3";
//         ItemNo: Code[20];
//         SystemLineNo: Integer;
//         LineNoCount: integer;
//     begin
//         //validation 

//         Rec_ExcelBuffer.DeleteAll();
//         Rows := 0;
//         Columns := 0;
//         FileUploaded := UploadIntoStream('Select File to Upload', '', '', Filename, Instr);

//         if Filename <> '' then
//             Sheetname := Rec_ExcelBuffer.SelectSheetsNameStream(Instr)
//         else
//             exit;

//         Rec_ExcelBuffer.Reset;
//         Rec_ExcelBuffer.OpenBookStream(Instr, Sheetname);
//         Rec_ExcelBuffer.ReadSheet();
//         Commit();

//         Rec_ExcelBuffer.Reset();
//         Rec_ExcelBuffer.SetRange("Column No.", 6);
//         if Rec_ExcelBuffer.FindFirst() then
//             repeat
//                 Rows := Rows + 1;
//             until Rec_ExcelBuffer.Next() = 0;
//         Clear(TotalRows);
//         TotalRows := Rows + 5; //total header is 5
//         // Message('Total Rows : ' + Format(TotalRows));

//         Rec_ExcelBuffer.Reset();
//         Rec_ExcelBuffer.SetRange("Row No.", 6);
//         if Rec_ExcelBuffer.FindFirst() then
//             repeat
//                 Columns := Columns + 1;
//             until Rec_ExcelBuffer.Next() = 0;
//         // Message(Format(Columns));

//         Clear(LocationCode);
//         LocationCode := GetValueAtIndex(1, 2);
//         // found some item with no location when testing
//         // if LocationCode = '' then
//         //     Error('Location Code on B1 is not found!');
//         If Location.Get(LocationCode) then;
//         // Message('location Code is %1', LocationCode);

//         Clear(PostingDate);
//         Evaluate(PostingDate, GetValueAtIndex(2, 2));
//         if PostingDate = 0D then
//             Error('Date on B2 is not found');
//         // Message('Posting Date is %1', PostingDate);

//         Clear(JnlTmpName);
//         Evaluate(JnlTmpName, GetValueAtIndex(3, 2));
//         if JnlTmpName = '' then
//             Error('Journal Template Name on B3 is not found');
//         // Message('Journal Template Name is %1', JnlTmpName);

//         Clear(JnlBatchName);
//         Evaluate(JnlBatchName, GetValueAtIndex(4, 2));
//         if JnlBatchName = '' then
//             Error('Journal Batch Name on B4 is not found');
//         // Message('Journal Template Name is %1', JnlBatchName);

//         Clear(DocNo);
//         Evaluate(DocNo, GetValueAtIndex(5, 2));
//         if DocNo = '' then
//             Error('Document No. on B5 is not found');

//         // Message('Document No. is %1', DocNo);
//         //>>PM
//         if DocNo <> JnlDocNo then
//             Error('Document no. %1 does not match with import sheet document no', JnlDocNo);
//         if PostingDate <> JnlPostingDate then
//             Error('Posting date %1 does not match with import sheet date', JnlPostingDate);
//         //<<PM
//         Clear(CurrVersion);
//         Clear(VersionNo);
//         Evaluate(VersionNo, GetValueAtIndex(3, 14));
//         if Not (VersionNo in [VersionNo::"1", VersionNo::"2", VersionNo::"3"]) then
//             Error('Version No. on J3 is not found or incorrect');
//         PrevVersion := VersionNo;
//         CurrVersion := VersionNo + 1;
//         // Message('Version No. is %1', VersionNo);

//         //Version 
//         //>>PM  to be deleted
//         //Error(Format(VersionNo));
//         //CountDataSheet1.Reset();

//         //CountDataSheet1.SetRange("Journal Batch Name", JournalBatchName);
//         //CountDataSheet1.SetRange("Journal Template Name", JournalTemplateName);

//         //CountDataSheet1.Setfilter("Version No.", '%1', VersionNo);
//         //if CountDataSheet1.FindFirst() then
//         //Error('Data Already Exists For Current version %1', CountDataSheet1);
//         //<<PM to be deleted
//         if CurrVersion > 1 then begin
//             CountingDataSheet.Reset();
//             CountingDataSheet.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.", "Document No.", "Posting Date", "Version No.");
//             CountingDataSheet.SetRange("Journal Template Name", JournalTemplateName);
//             CountingDataSheet.SetRange("Journal Batch Name", JournalBatchName);
//             CountingDataSheet.SetRange("Document No.", DocNo);
//             CountingDataSheet.SetRange("Posting Date", PostingDate);
//             CountingDataSheet.SetRange("Version No.", PrevVersion); //version 0 will never exist
//             if CountingDataSheet.IsEmpty then
//                 Error('Counting Datasheet version %1 does not exist. Please provide version %1 before continue with version %2', PrevVersion, CurrVersion);
//         end;
//         //Modify or Insert
//         for RowNo := 7 to TotalRows do begin
//             // Message('RowNo : %1', RowNo);
//             CountingDataSheet.Init();
//             CountingDataSheet."Journal Template Name" := JournalTemplateName; //journaltemplatename
//             CountingDataSheet."Journal Batch Name" := JournalBatchName; //journalbatchname

//             if GetValueAtIndex(RowNo, 1) <> '' then begin //item no.
//                 ItemNo := GetValueAtIndex(RowNo, 1);
//                 VariantCode := GetValueAtIndex(RowNo, 3);
//                 LineNoCount := 0;
//                 CountingDataSheet."Line No." := 0;
//             end else begin
//                 if GetValueAtIndex(RowNo, 3) <> '' then begin //system line no.
//                     Evaluate(SystemLineNo, GetValueAtIndex(RowNo, 3));

//                     CountingDataSheet."Line No." := SystemLineNo;
//                 end else begin
//                     LineNoCount += 1;
//                     SystemLineNo += 1;
//                     CountingDataSheet."Line No." := SystemLineNo;
//                 end;

//                 CountingDataSheet."Item No." := ItemNo;
//                 CountingDataSheet."Variant Code" := VariantCode;
//                 CountingDataSheet."Posting Date" := PostingDate;
//                 CountingDataSheet."Document No." := DocNo;
//                 CountingDataSheet."Version No." := CurrVersion; //optionstart with 0
//                 CountingDataSheet."Location Code" := LocationCode;

//                 CountingDataSheet."Lot No. 2" := GetValueAtIndex(RowNo, 4); //Lot No.
//                 CountingDataSheet."BOE No." := GetValueAtIndex(RowNo, 5); //BOE No.
//                 if CountingDataSheet."BOE No." <> '' then //PM
//                     CountingDataSheet."Lot No." := CountingDataSheet."Lot No. 2" + '@' + CountingDataSheet."BOE No."
//                 else
//                     CountingDataSheet."Lot No." := CountingDataSheet."Lot No. 2";//PM
//                 CountingDataSheet."Smallest Packing" := GetValueAtIndex(RowNo, 6); //SmallestPacking UOM

//                 if GetValueAtIndex(RowNo, 7) = '' then
//                     CountingDataSheet."Qty. Calc. Smallest Packing" := 0
//                 else
//                     Evaluate(CountingDataSheet."Qty. Calc. Smallest Packing", GetValueAtIndex(RowNo, 7)); //SmallestPacking Qty

//                 if GetValueAtIndex(RowNo, 8) = '' then
//                     CountingDataSheet."Qty. Counted Smallest Packing" := 0 //SmallestPacking Qty Counted
//                 else
//                     Evaluate(CountingDataSheet."Qty. Counted Smallest Packing", GetValueAtIndex(RowNo, 8));

//                 Evaluate(CountingDataSheet."Conversion factor", GetValueAtIndex(RowNo, 9)); //Conversion Factor
//                 Evaluate(CountingDataSheet."Base UOM", GetValueAtIndex(RowNo, 10)); //Base UOM

//                 if GetValueAtIndex(RowNo, 11) = '' then
//                     CountingDataSheet."Qty. Calc. Base UOM" := 0
//                 else
//                     Evaluate(CountingDataSheet."Qty. Calc. Base UOM", GetValueAtIndex(RowNo, 11)); //Qty. Calc Base UOM

//                 if GetValueAtIndex(RowNo, 12) = '' then
//                     CountingDataSheet."Qty. Counted Base UOM" := 0
//                 else
//                     Evaluate(CountingDataSheet."Qty. Counted Base UOM", GetValueAtIndex(RowNo, 12)); //Qty. Counted Base UOM

//                 Evaluate(CountingDataSheet.Remarks, CopyStr(GetValueAtIndex(RowNo, 13), 1, 1024));
//                 //>>PM
//                 Evaluate(CountingDataSheet."Manufacturing Date", GetValueAtIndex(RowNo, 14));
//                 Evaluate(CountingDataSheet."Expiration Period", GetValueAtIndex(RowNo, 15));
//                 //<<PM
//                 if not CountingDataSheet.Insert(true) then
//                     Error('Record already exist for round %1', VersionNo);
//                 //Commit();
//             end;

//         end;

//         Message('Data imported successfully!!');


//     end;

//     local procedure GetValueAtIndex(RowNo: Integer; ColNo: Integer): Text
//     var
//     begin
//         Rec_ExcelBuffer.Reset();
//         IF Rec_ExcelBuffer.Get(RowNo, ColNo) then
//             exit(Rec_ExcelBuffer."Cell Value as Text");
//     end;

//     procedure RegisterCountingDataSheet(JournalTemplateName: code[20]; JournalBatchName: code[20]; DocNo: Code[20]; PostingDate: Date)
//     var
//         ItemJournalLine: Record "Item Journal Line";
//         CountingDataSheet: Record "Counting DataSheet";
//         ItemJournalTemplate: Record "Item Journal Template";
//         CountDataSheet1: Record "Counting DataSheet";
//     begin
//         CountingDataSheet.Reset();
//         CountingDataSheet.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.", "Document No.", "Posting Date", "Version No.");
//         CountingDataSheet.SetRange("Journal Template Name", JournalTemplateName);
//         CountingDataSheet.SetRange("Journal Batch Name", JournalBatchName);
//         CountingDataSheet.SetRange("Document No.", DocNo);
//         CountingDataSheet.SetRange("Posting Date", PostingDate);
//         CountingDataSheet.SetRange("Version No.", 3);
//         IF NOT CountingDataSheet.FindSet() then
//             Error('Counted quantities can not be updated into Physical Inventory Journal because counting process has not been completed.');

//         if Confirm('Do you want to register counted quantities for Physical Inventory Journal posting?', true) then begin
//             ItemJournalLine.Reset();
//             ItemJournalLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
//             ItemJournalLine.SetRange("Journal Template Name", JournalTemplateName);
//             ItemJournalLine.SetRange("Journal Batch Name", JournalBatchName);
//             if ItemJournalLine.FindSet() then
//                 repeat
//                     if CountingDataSheet.Get(JournalTemplateName, JournalBatchName, ItemJournalLine."Line No.", ItemJournalLine."Document No.", ItemJournalLine."Posting Date", 3) then begin
//                         //Validation
//                         if (ItemJournalLine."Location Code" <> CountingDataSheet."Location Code") then
//                             Error('Phys. Invt. Journal Location (%1) is different from Counting Datasheet Location (%2) on Line %3.', ItemJournalLine."Location Code", CountingDataSheet."Location Code", ItemJournalLine."Line No.");

//                         if (ItemJournalLine."Item No." <> CountingDataSheet."Item No.") then
//                             Error('Phys. Invt. Journal Item No. (%1) is different from Counting Datasheet Item No. (%2) on Line %3.', ItemJournalLine."Item No.", CountingDataSheet."Item No.", ItemJournalLine."Line No.");

//                         if (ItemJournalLine."Variant Code" <> CountingDataSheet."Variant Code") then
//                             Error('Phys. Invt. Journal Variant Code (%1) is different from Counting Datasheet Variant Code (%2) on Line %3.', ItemJournalLine."Variant Code", CountingDataSheet."Variant Code", ItemJournalLine."Line No.");

//                         if (ItemJournalLine."Lot No. KMP" <> CountingDataSheet."Lot No.") then
//                             Error('Phys. Invt. Journal Lot No. (%1) is different from Counting Datasheet Lot No. (%2) on Line %3.', ItemJournalLine."Lot No. KMP", CountingDataSheet."Lot No.", ItemJournalLine."Line No.");

//                         //update qty. counted
//                         ItemJournalLine.Validate("Qty. (Phys. Inventory)", CountingDataSheet."Qty. Counted Base UOM");
//                         ItemJournalLine.Modify(true);

//                     end;
//                     if (ItemJournalLine."Lot No. KMP" <> '') and (ItemJournalLine.Quantity <> 0) then
//                         InsertTracking(ItemJournalLine);


//                 until ItemJournalLine.Next() = 0;

//             ItemJournalTemplate.Get(JournalTemplateName);
//             CountingDataSheet.Reset();
//             CountingDataSheet.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.", "Document No.", "Posting Date", "Version No.");
//             CountingDataSheet.SetRange("Journal Template Name", JournalTemplateName);
//             CountingDataSheet.SetRange("Journal Batch Name", JournalBatchName);
//             CountingDataSheet.SetRange("Document No.", DocNo);
//             CountingDataSheet.SetRange("Posting Date", PostingDate);
//             CountingDataSheet.SetRange("Version No.", 3);
//             CountingDataSheet.SetRange("Exist in Batch", false);
//             if CountingDataSheet.FindSet() then
//                 repeat
//                     //insert new line
//                     ItemJournalLine.Init();
//                     ItemJournalLine.Validate("Journal Template Name", CountingDataSheet."Journal Template Name");
//                     ItemJournalLine.Validate("Journal Batch Name", CountingDataSheet."Journal Batch Name");
//                     ItemJournalLine.Validate("Line No.", CountingDataSheet."Line No.");
//                     ItemJournalLine.Validate("Posting Date", CountingDataSheet."Posting Date");
//                     ItemJournalLine.Validate("Document No.", CountingDataSheet."Document No.");
//                     ItemJournalLine.Validate("Item No.", CountingDataSheet."Item No.");
//                     ItemJournalLine.Validate("Variant Code", CountingDataSheet."Variant Code");
//                     ItemJournalLine.Validate("Location Code", CountingDataSheet."Location Code");
//                     ItemJournalLine.Validate(Description, CountingDataSheet.Description);

//                     ItemJournalLine.Validate("Lot No. KMP", CountingDataSheet."Lot No.");
//                     if not Item.Get(ItemJournalLine."Item No.") then
//                         Item.Init();

//                     ItemJournalLine.Validate("Expiration Date", CalcDate(Item."Expiration Calculation", ItemJournalLine."Posting Date"));
//                     ItemJournalLine.Validate("Unit of Measure Code", CountingDataSheet."Base UOM");
//                     ItemJournalLine.Validate("Source Code", ItemJournalTemplate."Source Code");
//                     ItemJournalLine."Phys. Inventory" := true;

//                     ItemJournalLine.Validate("Qty. (Phys. Inventory)", CountingDataSheet."Qty. Counted Base UOM");
//                     //>>PM
//                     ItemJournalLine."Manufacturing Date 2" := CountingDataSheet."Manufacturing Date";
//                     ItemJournalLine."Expiration Period" := CountingDataSheet."Expiration Period";
//                     //<<PM
//                     ItemJournalLine.Insert(true);

//                     if (ItemJournalLine."Lot No. KMP" <> '') and (ItemJournalLine.Quantity <> 0) then
//                         InsertTracking(ItemJournalLine);


//                 until CountingDataSheet.Next() = 0;

//             //>>PM
//             CountDataSheet1.Reset();
//             CountDataSheet1.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.", "Document No.", "Posting Date", "Version No.");
//             CountDataSheet1.SetRange("Journal Template Name", JournalTemplateName);
//             CountDataSheet1.SetRange("Journal Batch Name", JournalBatchName);
//             CountDataSheet1.SetRange("Document No.", DocNo);
//             if CountDataSheet1.FindSet() then
//                 CountDataSheet1.ModifyAll(CountDataSheet1.Status, CountDataSheet1.Status::Registered);
//             //<<PM

//             Message('Data has been updated.');
//         end
//     end;

//     local procedure InsertTracking(var ItemJournalLine: Record "Item Journal Line")
//     var

//         TempReservEntry: Record "Reservation Entry" temporary;
//         CreateReservEntry: Codeunit "Create Reserv. Entry";
//         ReservStatus: Enum "Reservation Status";
//         Item: Record item;
//     begin
//         if (ItemJournalLine."Lot No. KMP" = '') or (ItemJournalLine.Quantity = 0) then
//             exit;

//         IF TempReservEntry.IsTemporary then
//             TempReservEntry.DeleteAll();
//         IF NOT Item.Get(ItemJournalLine."Item No.") then
//             Item.Init();
//         TempReservEntry.Init();
//         TempReservEntry."Entry No." := 1;
//         TempReservEntry."Lot No." := ItemJournalLine."Lot No. KMP";
//         TempReservEntry.Quantity := ItemJournalLine.Quantity;
//         //>>PM
//         TempReservEntry."Manufacturing Date 2" := ItemJournalLine."Manufacturing Date 2";
//         TempReservEntry."Expiry Period 2" := ItemJournalLine."Expiration Period";
//         //<<PM

//         if FORMAT(Item."Expiration Calculation") <> '' then
//             TempReservEntry."Expiration Date" := CalcDate(ItemjournalLine."Expiration Period", ItemJournalLine."Manufacturing Date 2");//PM
//                                                                                                                                        //TempReservEntry."Expiration Date" := CalcDate(Item."Expiration Calculation", ItemJournalLine."Posting Date");//PM
//         TempReservEntry.Insert();

//         Clear(CreateReservEntry);
//         CreateReservEntry.SetDates(0D, TempReservEntry."Expiration Date");

//         /* CreateReservEntry.CreateReservEntryFor(
//                                ItemJournalLine."Source Type", ItemJournalLine."Entry Type",
//                                ItemJournalLine."Journal Template Name", ItemJournalLine."Journal Batch Name",
//                                0, ItemJournalLine."Line No.",
//                                ItemJournalLine."Qty. per Unit of Measure", TempReservEntry.Quantity, TempReservEntry.Quantity * ItemJournalLine."Qty. per Unit of Measure",
//                                TempReservEntry); // from indian team */

//         CreateReservEntry.CreateReservEntryFor(
//          Database::"Item Journal Line",
//          ItemJournalLine."Entry Type".AsInteger(),
//          ItemJournalLine."Journal Template Name",
//          ItemJournalLine."Journal Batch Name", 0,
//          ItemJournalLine."Line No.",
//          ItemJournalLine."Qty. per Unit of Measure",
//          TempReservEntry.Quantity,
//          TempReservEntry.Quantity * ItemJournalLine."Qty. per Unit of Measure", TempReservEntry);

//         CreateReservEntry.CreateEntry(
//           ItemJournalLine."Item No.", ItemJournalLine."Variant Code", ItemJournalLine."Location Code", '', 0D, 0D, 0, ReservStatus::Prospect);

//     end;

//     [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnAfterCopyTrackingFromReservEntry', '', True, true)]
//     procedure FlowManDateExpPeriod(VAR ReservationEntry: Record "Reservation Entry"; FromReservationEntry: Record "Reservation Entry")
//     begin
//         ReservationEntry."Manufacturing Date 2" := FromReservationEntry."Manufacturing Date 2";
//         ReservationEntry."Expiry Period 2" := FromReservationEntry."Expiry Period 2";

//     end;


//     var
//         Rec_ExcelBuffer: Record "Excel Buffer" temporary;
//         Rows: Integer;
//         Columns: Integer;
//         Filename: Text;
//         FileMgmt: Codeunit "File Management";
//         ExcelFile: File;
//         Instr: InStream;
//         Sheetname: Text;
//         FileUploaded: Boolean;
//         RowNo: Integer;
//         ColNo: Integer;
//         ItemJournalLine: Record "Item Journal Line";
//         Item: Record Item;
//         QtyCalcSmallestPackingTxt: Text;
//         TotalRows: integer;
//         CurrVersion: integer;
//         PrevVersion: integer;
//         VariantCode: Code[10];
//         CountDataSheet1: Record "Counting DataSheet";
// }