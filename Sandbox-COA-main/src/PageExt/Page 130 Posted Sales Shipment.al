pageextension 50505 "Posted Sales Shipment PagExt" extends "Posted Sales Shipment"//T12370-Full Comment
{
    //     layout
    //     {
    //         // Add changes to page layout here
    //     }

    actions
    {
        addafter("&Print")
        {

            action(Packing_List_)
            {
                ApplicationArea = All;
                Caption = 'COA_Shipment';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    SalesShptHdr: Record "Sales Shipment Header";
                begin
                    SalesShptHdr.SetRange("No.", rec."No.");
                    Report.Run(Report::COA_Sales_Shipment_R3, true, true, SalesShptHdr);
                end;
            }


            // addfirst(Reporting)
            // {
            //     action("Print COA")
            //     {
            //         ApplicationArea = All;
            //         Caption = 'COA_Shipment';
            //         Image = Shipment;
            //         //PromotedCategory = Category4;
            //         //Promoted = true;
            //         trigger OnAction()
            //         var
            //             SalesShptHdr: Record "Sales Shipment Header";
            //         begin
            //             SalesShptHdr.SetRange("No.", rec."No.");
            //             Report.Run(Report::COA_Sales_Shipment_R3, true, true, SalesShptHdr);
            //         end;
            //     }

            //Code commented -Hyper care Yaksh Niharika -04/03/2025
            // action("Certificate of Analysis")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Certificate of Analysis';
            //     Image = PrintChecklistReport;
            //     ToolTip = 'Print or preview the certificate of analysis.';
            //     trigger OnAction()
            //     var
            //         SalesShptHdr: Record "Sales Shipment Header";
            //     // LotPostedTestParameter: Record "Posted Lot Testing Parameter"; //AJAY
            //     // LotPostedVariantTestingParameter: Record "Post Lot Var Testing Parameter";
            //     begin //AJAY >>
            //           // LotPostedVariantTestingParameter.RESET;
            //           // LotPostedVariantTestingParameter.SetRange("Source ID", REC."No.");
            //           // IF LotPostedVariantTestingParameter.FindFirst THEN BEGIN
            //         SalesShptHdr.SetRange("No.", rec."No.");
            //         Report.Run(Report::"Certificate of Analysis New", true, true, SalesShptHdr);
            //         // END ELSE begin
            //         //     LotPostedTestParameter.RESET;
            //         //     LotPostedTestParameter.SetRange("Source ID", REC."No.");
            //         //     IF LotPostedTestParameter.FindFirst THEN BEGIN
            //         //         SalesShptHdr.SetRange("No.", rec."No.");
            //         //         Report.Run(Report::"Certificate of Analysis", true, true, SalesShptHdr);
            //         //     end;
            //         // end;
            //     end; //AJAY <<
            // }
            // action("Consolidated COA")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Consolidated COA';
            //     Image = PrintChecklistReport;
            //     ToolTip = 'Generate consolidated certificate of analysis.';
            //     trigger OnAction()
            //     var
            //         SalesShptHdr: Record "Sales Shipment Header";
            //         LotPostedVarintTestParameter: Record "Post Lot Var Testing Parameter"; //AJAY
            //     begin  //AJAY >>
            //            /* LotPostedVarintTestParameter.RESET; //old code is commented  by Alok
            //            LotPostedVarintTestParameter.SetRange("Source ID", REC."No.");
            //            IF NOT LotPostedVarintTestParameter.FindFirst THEN BEGIN
            //                SalesShptHdr.SetRange("No.", rec."No.");
            //                if SalesShptHdr.FindFirst() then begin
            //                    Report.Run(Report::"Consolidated COA_Shipment", true, true, SalesShptHdr)
            //                end;
            //            END ELSE begin
            //                SalesShptHdr.SetRange("No.", rec."No.");
            //                if SalesShptHdr.FindFirst() then begin
            //                    Report.Run(Report::"Consolidated COA_Shipment New", true, true, SalesShptHdr)
            //                end;
            //            end; */
            //         SalesShptHdr.SetRange("No.", rec."No.");
            //         if SalesShptHdr.FindFirst() then begin
            //             Report.Run(Report::"Consolidated COA_Shipment", true, true, SalesShptHdr)
            //         end;
            //     end; //AJAY <<
            // }
            // action("Download Template")
            // {
            //     ApplicationArea = All; //AJAY>>
            //     Caption = 'Download Testing Parameter';
            //     Image = ExportToExcel;
            //     trigger OnAction()
            //     var
            //         ExcelBuffer: Record "Excel Buffer" temporary;
            //         SheetName: Text[100];
            //         ItemLedgerEntry: Record "Item Ledger Entry";
            //         PostedLotTestingParameter: Record "Posted Lot Testing Parameter";
            //         ItemNo: Code[100];
            //         SalesShipmentLine: Record "Sales Shipment Line";
            //         LotPostedVarintTestParameter: Record "Post Lot Var Testing Parameter"; //AJAY
            //         LotPostedVarintTestParameter2: Record "Post Lot Var Testing Parameter"; //AJAY
            //         PostedLotTestingParameter2: Record "Posted Lot Testing Parameter";
            //         TestingParameter: code[20];
            //         Column: Integer;
            //         Row: Integer;
            //         Column2: Integer;
            //         Row2: Integer;
            //         Row3: Integer;
            //         Column3: Integer;
            //         Row5: Integer;
            //     begin //AJAY >>
            //         LotPostedVarintTestParameter.RESET;
            //         LotPostedVarintTestParameter.SetRange("Source ID", Rec."No.");
            //         IF LotPostedVarintTestParameter.FindFirst THEN BEGIN
            //             SalesShipmentLine.RESET;
            //             SalesShipmentLine.SetRange("Document No.", Rec."No.");
            //             IF SalesShipmentLine.FindFirst THEN
            //                 repeat
            //                     ExcelBuffer.DeleteAll();
            //                     IF SalesShipmentLine."Variant Code" <> '' THEN
            //                         SheetName := SalesShipmentLine."No." + '|' + Format(SalesShipmentLine."Line No.") + '|' + SalesShipmentLine."Variant Code"
            //                     ELSE
            //                         SheetName := SalesShipmentLine."No." + '|' + Format(SalesShipmentLine."Line No.");
            //                     EnterCell(1, 1, 'Item No.', '', TRUE, FALSE, FALSE, '@', 1, ExcelBuffer);
            //                     EnterCell(1, 2, 'Variant Code.', '', TRUE, FALSE, FALSE, '@', 1, ExcelBuffer);
            //                     EnterCell(1, 3, 'Batch No.', '', TRUE, FALSE, FALSE, '@', 1, ExcelBuffer);
            //                     EnterCell(1, 4, 'Pallet No.', '', TRUE, FALSE, FALSE, '@', 1, ExcelBuffer);
            //                     EnterCell(1, 5, 'Quantitiy.', '', TRUE, FALSE, FALSE, '@', 1, ExcelBuffer);
            //                     EnterCell(1, 6, 'Manufacturing Date', '', TRUE, FALSE, FALSE, '@', 1, ExcelBuffer);
            //                     EnterCell(1, 7, 'Expiry Date', '', TRUE, FALSE, FALSE, '@', 1, ExcelBuffer);
            //                     EnterCell(1, 8, 'Analysis Date', '', TRUE, FALSE, FALSE, '@', 1, ExcelBuffer);

            //                     Column3 := 8;
            //                     TestingParameter := '';
            //                     LotPostedVarintTestParameter2.Reset;
            //                     LotPostedVarintTestParameter2.SetCurrentKey(Code);
            //                     LotPostedVarintTestParameter2.SetRange("Source ID", SalesShipmentLine."Document No.");
            //                     LotPostedVarintTestParameter2.SetRange("Item No.", SalesShipmentLine."No.");
            //                     LotPostedVarintTestParameter2.SetRange("Variant Code", SalesShipmentLine."Variant Code");
            //                     LotPostedVarintTestParameter2.SetRange("Show in COA", true);
            //                     LotPostedVarintTestParameter2.SetFilter("Actual Value", '<>%1', '');
            //                     IF LotPostedVarintTestParameter2.FindSet THEN
            //                         repeat
            //                             IF TestingParameter <> LotPostedVarintTestParameter2.Code then begin
            //                                 Column3 += 1;
            //                                 EnterCell(1, Column3, LotPostedVarintTestParameter2.Code, '', TRUE, FALSE, FALSE, '@', 1, ExcelBuffer);
            //                             END;
            //                             TestingParameter := LotPostedVarintTestParameter2.Code;
            //                         UNTIL LotPostedVarintTestParameter2.NEXT = 0;

            //                     Row5 := 1;
            //                     ItemLedgerEntry.RESET;
            //                     ItemLedgerEntry.SetCurrentKey("Document Line No.");
            //                     ItemLedgerEntry.SetRange(ItemLedgerEntry."Document Type", ItemLedgerEntry."Document Type"::"Sales Shipment");
            //                     ItemLedgerEntry.SetRange("Document No.", SalesShipmentLine."Document No.");
            //                     ItemLedgerEntry.SetRange("Item No.", SalesShipmentLine."No.");
            //                     ItemLedgerEntry.SetRange("Document Line No.", SalesShipmentLine."Line No.");
            //                     ItemLedgerEntry.SetRange("Variant Code", SalesShipmentLine."Variant Code");
            //                     ItemLedgerEntry.SetFilter(Quantity, '<>%1', 0);
            //                     IF ItemLedgerEntry.FindSet THEN
            //                         repeat
            //                             Row5 += 1;
            //                             EnterCell(Row5, 1, ItemLedgerEntry."Item No.", '', false, FALSE, FALSE, '@', 1, ExcelBuffer);
            //                             EnterCell(Row5, 2, ItemLedgerEntry."Variant Code", '', false, FALSE, FALSE, '@', 1, ExcelBuffer);
            //                             EnterCell(Row5, 3, ItemLedgerEntry.CustomLotNumber, '', false, FALSE, FALSE, '@', 0, ExcelBuffer);
            //                             EnterCell(Row5, 4, '', '', TRUE, FALSE, FALSE, '@', 1, ExcelBuffer);
            //                             EnterCell(Row5, 5, Format(Abs(ItemLedgerEntry.Quantity)), '', false, FALSE, FALSE, '0.00', 0, ExcelBuffer);
            //                             EnterCell(Row5, 6, Format(ItemLedgerEntry."Manufacturing Date 2"), '', false, FALSE, FALSE, 'MM-DD-YYYY', 2, ExcelBuffer);
            //                             EnterCell(Row5, 7, Format(ItemLedgerEntry."Expiration Date"), '', false, FALSE, FALSE, 'MM-DD-YYYY', 2, ExcelBuffer);
            //                             EnterCell(Row5, 8, Format(ItemLedgerEntry."Analysis Date"), '', false, FALSE, FALSE, 'MM-DD-YYYY', 2, ExcelBuffer);
            //                         UNTIL ItemLedgerEntry.Next = 0;

            //                     Row := 2;
            //                     Row2 := 2;
            //                     Column := 9;
            //                     TestingParameter := '';
            //                     LotPostedVarintTestParameter2.Reset;
            //                     LotPostedVarintTestParameter2.SetCurrentKey(Code);
            //                     LotPostedVarintTestParameter2.SetRange("Source ID", SalesShipmentLine."Document No.");
            //                     LotPostedVarintTestParameter2.SetRange("Item No.", SalesShipmentLine."No.");
            //                     LotPostedVarintTestParameter2.SetRange("Variant Code", SalesShipmentLine."Variant Code");
            //                     LotPostedVarintTestParameter2.SetRange("Show in COA", true);
            //                     LotPostedVarintTestParameter2.SetFilter("Actual Value", '<>%1', '');
            //                     IF LotPostedVarintTestParameter2.FindSet THEN
            //                         repeat
            //                             IF TestingParameter <> LotPostedVarintTestParameter2.Code then begin
            //                                 LotPostedVarintTestParameter.Reset;
            //                                 LotPostedVarintTestParameter.SetCurrentKey(Code);
            //                                 LotPostedVarintTestParameter.SetRange("Source ID", SalesShipmentLine."Document No.");
            //                                 LotPostedVarintTestParameter.SetRange("Item No.", SalesShipmentLine."No.");
            //                                 LotPostedVarintTestParameter.SetRange("Variant Code", SalesShipmentLine."Variant Code");
            //                                 LotPostedVarintTestParameter.SetRange("Show in COA", true);
            //                                 LotPostedVarintTestParameter.SetRange(Code, LotPostedVarintTestParameter2.Code);
            //                                 IF LotPostedVarintTestParameter.FindSet THEN
            //                                     repeat
            //                                         EnterCell(Row, Column, LotPostedVarintTestParameter."Actual Value", '', false, FALSE, FALSE, '@', 0, ExcelBuffer);
            //                                         Row += 1;
            //                                         Column2 := Column;
            //                                     UNTIL LotPostedVarintTestParameter.NEXT = 0;
            //                             END;
            //                             TestingParameter := LotPostedVarintTestParameter2.Code;
            //                             Row := Row2;
            //                             Column := Column2 + 1;
            //                         UNTIL LotPostedVarintTestParameter2.NEXT = 0;
            //                     if ItemNo = '' then begin
            //                         ExcelBuffer.CreateNewBook(SheetName);
            //                         ExcelBuffer.WriteSheet('Posted Sales Shipment', CompanyName, UserId);
            //                         ItemNo := SalesShipmentLine."No." + '|' + Format(SalesShipmentLine."Line No.");
            //                     end else begin
            //                         ExcelBuffer.SetCurrent(0, 0);
            //                         ExcelBuffer.SelectOrAddSheet(SheetName);
            //                         ExcelBuffer.WriteSheet('Posted Sales Shipment', CompanyName, UserId);
            //                     end;
            //                 UNTIL SalesShipmentLine.NEXT = 0;
            //         end else begin  ///Old Record print
            //             SalesShipmentLine.RESET;
            //             SalesShipmentLine.SetRange("Document No.", Rec."No.");
            //             IF SalesShipmentLine.FindFirst THEN
            //                 repeat
            //                     ExcelBuffer.DeleteAll();
            //                     IF SalesShipmentLine."Variant Code" <> '' THEN
            //                         SheetName := SalesShipmentLine."No." + '|' + Format(SalesShipmentLine."Line No.") + '|' + SalesShipmentLine."Variant Code"
            //                     ELSE
            //                         SheetName := SalesShipmentLine."No." + '|' + Format(SalesShipmentLine."Line No.");
            //                     EnterCell(1, 1, 'Item No.', '', TRUE, FALSE, FALSE, '@', 1, ExcelBuffer);
            //                     EnterCell(1, 2, 'Variant Code.', '', TRUE, FALSE, FALSE, '@', 1, ExcelBuffer);
            //                     EnterCell(1, 3, 'Batch No.', '', TRUE, FALSE, FALSE, '@', 1, ExcelBuffer);
            //                     EnterCell(1, 4, 'Pallet No.', '', TRUE, FALSE, FALSE, '@', 1, ExcelBuffer);
            //                     EnterCell(1, 5, 'Quantitiy.', '', TRUE, FALSE, FALSE, '@', 1, ExcelBuffer);
            //                     EnterCell(1, 6, 'Manufacturing Date', '', TRUE, FALSE, FALSE, '@', 1, ExcelBuffer);
            //                     EnterCell(1, 7, 'Expiry Date', '', TRUE, FALSE, FALSE, '@', 1, ExcelBuffer);
            //                     EnterCell(1, 8, 'Analysis Date', '', TRUE, FALSE, FALSE, '@', 1, ExcelBuffer);

            //                     Column3 := 8;
            //                     TestingParameter := '';
            //                     PostedLotTestingParameter2.Reset;
            //                     PostedLotTestingParameter2.SetCurrentKey(Code);
            //                     PostedLotTestingParameter2.SetRange("Source ID", SalesShipmentLine."Document No.");
            //                     PostedLotTestingParameter2.SetRange("Item No.", SalesShipmentLine."No.");
            //                     //PostedLotTestingParameter2.SetRange("Variant Code", SalesShipmentLine."Variant Code");
            //                     PostedLotTestingParameter2.SetRange("Show in COA", true);
            //                     PostedLotTestingParameter2.SetFilter("Actual Value", '<>%1', '');
            //                     IF PostedLotTestingParameter2.FindSet THEN
            //                         repeat
            //                             IF TestingParameter <> PostedLotTestingParameter2.Code then begin
            //                                 Column3 += 1;
            //                                 EnterCell(1, Column3, PostedLotTestingParameter2.Code, '', TRUE, FALSE, FALSE, '@', 1, ExcelBuffer);
            //                             END;
            //                             TestingParameter := PostedLotTestingParameter2.Code;
            //                         UNTIL PostedLotTestingParameter2.NEXT = 0;

            //                     Row5 := 1;
            //                     ItemLedgerEntry.RESET;
            //                     ItemLedgerEntry.SetCurrentKey("Document Line No.");
            //                     ItemLedgerEntry.SetRange(ItemLedgerEntry."Document Type", ItemLedgerEntry."Document Type"::"Sales Shipment");
            //                     ItemLedgerEntry.SetRange("Document No.", SalesShipmentLine."Document No.");
            //                     ItemLedgerEntry.SetRange("Item No.", SalesShipmentLine."No.");
            //                     ItemLedgerEntry.SetRange("Document Line No.", SalesShipmentLine."Line No.");
            //                     //ItemLedgerEntry.SetRange("Variant Code", SalesShipmentLine."Variant Code");
            //                     ItemLedgerEntry.SetFilter(Quantity, '<>%1', 0);
            //                     IF ItemLedgerEntry.FindSet THEN
            //                         repeat
            //                             Row5 += 1;
            //                             EnterCell(Row5, 1, ItemLedgerEntry."Item No.", '', false, FALSE, FALSE, '@', 1, ExcelBuffer);
            //                             EnterCell(Row5, 2, ItemLedgerEntry."Variant Code", '', false, FALSE, FALSE, '@', 1, ExcelBuffer);
            //                             EnterCell(Row5, 3, ItemLedgerEntry.CustomLotNumber, '', false, FALSE, FALSE, '@', 0, ExcelBuffer);
            //                             EnterCell(Row5, 4, '', '', TRUE, FALSE, FALSE, '@', 1, ExcelBuffer);
            //                             EnterCell(Row5, 5, Format(ABS(ItemLedgerEntry.Quantity)), '', false, FALSE, FALSE, '0.00', 0, ExcelBuffer);
            //                             EnterCell(Row5, 6, Format(ItemLedgerEntry."Manufacturing Date 2"), '', false, FALSE, FALSE, 'MM-DD-YYYY', 2, ExcelBuffer);
            //                             EnterCell(Row5, 7, Format(ItemLedgerEntry."Expiration Date"), '', false, FALSE, FALSE, 'MM-DD-YYYY', 2, ExcelBuffer);
            //                             EnterCell(Row5, 8, Format(ItemLedgerEntry."Analysis Date"), '', false, FALSE, FALSE, 'MM-DD-YYYY', 2, ExcelBuffer);
            //                         UNTIL ItemLedgerEntry.Next = 0;

            //                     Row := 2;
            //                     Row2 := 2;
            //                     Column := 9;
            //                     TestingParameter := '';
            //                     PostedLotTestingParameter2.Reset;
            //                     PostedLotTestingParameter2.SetCurrentKey(Code);
            //                     PostedLotTestingParameter2.SetRange("Source ID", SalesShipmentLine."Document No.");
            //                     PostedLotTestingParameter2.SetRange("Item No.", SalesShipmentLine."No.");
            //                     //PostedLotTestingParameter2.SetRange("Variant Code", SalesShipmentLine."Variant Code");
            //                     PostedLotTestingParameter2.SetRange("Show in COA", true);
            //                     PostedLotTestingParameter2.SetFilter("Actual Value", '<>%1', '');
            //                     IF PostedLotTestingParameter2.FindSet THEN
            //                         repeat
            //                             IF TestingParameter <> PostedLotTestingParameter2.Code then begin
            //                                 PostedLotTestingParameter.Reset;
            //                                 PostedLotTestingParameter.SetCurrentKey(Code);
            //                                 PostedLotTestingParameter.SetRange("Source ID", SalesShipmentLine."Document No.");
            //                                 PostedLotTestingParameter.SetRange("Item No.", SalesShipmentLine."No.");
            //                                 //PostedLotTestingParameter.SetRange("Variant Code", SalesShipmentLine."Variant Code");
            //                                 PostedLotTestingParameter.SetRange("Show in COA", true);
            //                                 PostedLotTestingParameter.SetRange(Code, PostedLotTestingParameter2.Code);
            //                                 IF LotPostedVarintTestParameter.FindSet THEN
            //                                     repeat
            //                                         EnterCell(Row, Column, PostedLotTestingParameter."Actual Value", '', false, FALSE, FALSE, '@', 0, ExcelBuffer);
            //                                         Row += 1;
            //                                         Column2 := Column;
            //                                     UNTIL PostedLotTestingParameter.NEXT = 0;
            //                             END;
            //                             TestingParameter := PostedLotTestingParameter2.Code;
            //                             Row := Row2;
            //                             Column := Column2 + 1;
            //                         UNTIL PostedLotTestingParameter2.NEXT = 0;
            //                     if ItemNo = '' then begin
            //                         ExcelBuffer.CreateNewBook(SheetName);
            //                         ExcelBuffer.WriteSheet('Posted Sales Shipment', CompanyName, UserId);
            //                         ItemNo := SalesShipmentLine."No." + '|' + Format(SalesShipmentLine."Line No.");
            //                     end else begin
            //                         ExcelBuffer.SetCurrent(0, 0);
            //                         ExcelBuffer.SelectOrAddSheet(SheetName);
            //                         ExcelBuffer.WriteSheet('Posted Sales Shipment', CompanyName, UserId);
            //                     end;
            //                 UNTIL SalesShipmentLine.NEXT = 0;
            //         end;
            //         ExcelBuffer.CloseBook;
            //         ExcelBuffer.SetFriendlyFilename('Posted Sales Shipment');
            //         ExcelBuffer.OpenExcel;
            //     end;
            // } //AJAY<<  

        }
    }

    local procedure EnterCell(_Row: Integer; _Col: Integer; _CellValue: Text[250]; _Comment: text[250]; _Bold: Boolean; _Italic: Boolean; _UnderLine: Boolean; _NumberFormat: Text[30]; _CellType: Option Number,Text,Date,Time; var ExcelBuffer: Record "Excel Buffer")
    var
    begin  //AJAY >>
        ExcelBuffer.INIT;
        ExcelBuffer.VALIDATE("Row No.", _Row);
        ExcelBuffer.VALIDATE("Column No.", _Col);
        ExcelBuffer."Cell Value as Text" := _CellValue;
        ExcelBuffer.Comment := _Comment;
        ExcelBuffer.Bold := _Bold;
        ExcelBuffer.Italic := _Italic;
        ExcelBuffer.Underline := _UnderLine;
        ExcelBuffer.NumberFormat := _NumberFormat;
        ExcelBuffer."Cell Type" := _CellType;
        ExcelBuffer.INSERT(TRUE);
    end;  //AJAY <<

    var
        myInt: Integer;
}