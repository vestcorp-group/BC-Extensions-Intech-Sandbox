// report 70112 "Update Dimension in PSI"//T12370-Full Comment
// {
//     UsageCategory = ReportsAndAnalysis;
//     AdditionalSearchTerms = 'Update PSI data';
//     ApplicationArea = All;
//     Permissions = TableData "Dimension Set Entry" = rimd, tabledata "Sales Invoice Line" = rimd, tabledata "Sales Invoice Header" = rimd;
//     ProcessingOnly = true;
//     dataset
//     {
//         dataitem(SalesInvoiceHeader; "Sales Invoice Header")
//         {

//             RequestFilterFields = "No.";
//             trigger OnAfterGetRecord()
//             begin
//                 SalesHeader_Rec.SETRANGE("No.", SalesInvoiceHeader."No.");
//                 IF SalesHeader_Rec.FINDFIRST THEN BEGIN
//                     OldDimensionSetID := 0;
//                     NewDimSetID := 0;
//                     TempDimSetEntry.RESET;
//                     TempDimSetEntry.DELETEALL;

//                     TempDimSetEntry0.RESET;
//                     TempDimSetEntry0.DELETEALL;

//                     IF "Dimension Set ID" > 0 THEN
//                         DimMgt.GetDimensionSet(TempDimSetEntry0, SalesHeader_Rec."Dimension Set ID");

//                     TempDimBuf2.RESET;
//                     TempDimBuf2.DELETEALL;
//                     IF TempDimSetEntry0.FINDSET THEN
//                         REPEAT
//                             TempDimBuf2.INIT;
//                             TempDimBuf2."Table ID" := 112;
//                             TempDimBuf2."Entry No." := 0;
//                             TempDimBuf2."Dimension Code" := TempDimSetEntry0."Dimension Code";
//                             TempDimBuf2."Dimension Value Code" := TempDimSetEntry0."Dimension Value Code";
//                             TempDimBuf2.INSERT;
//                         UNTIL TempDimSetEntry0.NEXT = 0;
//                     TableID[1] := 13;
//                     No[1] := SalesHeader_Rec."Salesperson Code";

//                     DefaultDim.SETRANGE("Table ID", TableID[1]);
//                     DefaultDim.SETRANGE("No.", No[1]);
//                     IF DefaultDim.FINDSET THEN
//                         REPEAT
//                             IF DefaultDim."Dimension Value Code" <> '' THEN BEGIN
//                                 TempDimBuf2.SETRANGE("Dimension Code", DefaultDim."Dimension Code");
//                                 IF NOT TempDimBuf2.FINDFIRST THEN BEGIN
//                                     TempDimBuf2.INIT;
//                                     TempDimBuf2."Table ID" := DefaultDim."Table ID";
//                                     TempDimBuf2."Entry No." := 0;
//                                     TempDimBuf2."Dimension Code" := DefaultDim."Dimension Code";
//                                     TempDimBuf2."Dimension Value Code" := DefaultDim."Dimension Value Code";
//                                     TempDimBuf2.INSERT;
//                                 END
//                                 ELSE BEGIN
//                                     TempDimBuf2."Dimension Code" := DefaultDim."Dimension Code";
//                                     TempDimBuf2."Dimension Value Code" := DefaultDim."Dimension Value Code";
//                                     TempDimBuf2.MODIFY;
//                                 END;
//                             END;
//                         UNTIL DefaultDim.NEXT = 0;
//                     TempDimBuf2.RESET;
//                     IF TempDimBuf2.FINDSET THEN BEGIN
//                         REPEAT
//                             DimVal.GET(TempDimBuf2."Dimension Code", TempDimBuf2."Dimension Value Code");
//                             TempDimSetEntry."Dimension Code" := TempDimBuf2."Dimension Code";
//                             TempDimSetEntry."Dimension Value Code" := TempDimBuf2."Dimension Value Code";
//                             TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
//                             TempDimSetEntry.INSERT;
//                         UNTIL TempDimBuf2.NEXT = 0;
//                         NewDimSetID := DimMgt.GetDimensionSetID(TempDimSetEntry);
//                     END;

//                     IF (OldDimensionSetID <> NewDimSetID) THEN BEGIN
//                         SalesHeader_Rec."Dimension Set ID" := NewDimSetID;
//                         SalesHeader_Rec.MODIFY;

//                         IF NewDimSetID = OldDimensionSetID THEN
//                             EXIT;

//                         SalesLine.RESET;
//                         SalesLine.SETRANGE("Document No.", SalesHeader_Rec."No.");
//                         SalesLine.LOCKTABLE;
//                         IF SalesLine.FIND('-') THEN
//                             REPEAT
//                                 //   NewDimSetIDSalesLine := DimMgt.GetDeltaDimSetID(SalesLine."Dimension Set ID", NewDimSetID, OldDimensionSetID);
//                                 // IF SalesLine."Dimension Set ID" <> NewDimSetIDSalesLine THEN BEGIN
//                                 SalesLine."Dimension Set ID" := SalesHeader_Rec."Dimension Set ID";

//                                 DimMgt.UpdateGlobalDimFromDimSetID(
//                                   SalesLine."Dimension Set ID", SalesLine."Shortcut Dimension 1 Code", SalesLine."Shortcut Dimension 2 Code");
//                                 SalesLine.MODIFY;
//                             // END;
//                             UNTIL SalesLine.NEXT = 0;
//                     END;
//                 END;
//             end;
//         }
//     }
//     var
//         DefaultDim: Record "Default Dimension";
//         DimVal: Record "Dimension Value";
//         OldDimensionSetID: Integer;
//         DimMgt: Codeunit DimensionManagement;
//         SalesLine: Record "Sales Invoice Line";
//         NewDimSetID: Integer;
//         TempDimSetEntry0: Record "Dimension Set Entry" temporary;
//         TempDimBuf2: Record "Dimension Buffer" temporary;
//         TempDimSetEntry: Record "Dimension Set Entry" temporary;
//         NewDimSetIDSalesLine: Integer;
//         SalesHeader_Rec: Record "Sales Invoice Header";
//         No: array[10] of Code[20];
//         TableID: array[10] of Integer;
// }