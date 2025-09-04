// report 70113 "Update Dimension in GL Entry"//T12370-Full Comment
// {
//     UsageCategory = ReportsAndAnalysis;
//     AdditionalSearchTerms = 'Update Value Entry data';
//     ApplicationArea = All;
//     Permissions = TableData "Dimension Set Entry" = rimd, tabledata "Value Entry" = rimd, tabledata "G/L Entry" = rimd;
//     ProcessingOnly = true;
//     dataset
//     {
//         dataitem(SalesInvoiceHeader; "Sales Invoice Header")
//         {
//             RequestFilterFields = "No.";
//             trigger OnAfterGetRecord()
//             begin
//                 UpdateGLEntries();
//                 UpdateValueEntries();
//             end;
//         }
//     }
//     var
//         ValueEntry: Record "Value Entry";
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
//         No: array[10] of Code[20];
//         TableID: array[10] of Integer;
//         GLEntry: Record "G/L Entry";

//     local procedure UpdateValueEntries()
//     begin
//         ValueEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
//         ValueEntry.SETRANGE("Document Date", SalesInvoiceHeader."Posting Date");
//         IF ValueEntry.FINDSET THEN
//             REPEAT
//                 OldDimensionSetID := 0;
//                 NewDimSetID := 0;
//                 TempDimSetEntry.RESET;
//                 TempDimSetEntry.DELETEALL;
//                 TempDimSetEntry0.RESET;
//                 TempDimSetEntry0.DELETEALL;

//                 IF SalesInvoiceHeader."Dimension Set ID" > 0 THEN
//                     DimMgt.GetDimensionSet(TempDimSetEntry0, SalesInvoiceHeader."Dimension Set ID");

//                 TempDimBuf2.RESET;
//                 TempDimBuf2.DELETEALL;
//                 IF TempDimSetEntry0.FINDSET THEN
//                     REPEAT
//                         TempDimBuf2.INIT;
//                         TempDimBuf2."Table ID" := 5802;
//                         TempDimBuf2."Entry No." := 0;
//                         TempDimBuf2."Dimension Code" := TempDimSetEntry0."Dimension Code";
//                         TempDimBuf2."Dimension Value Code" := TempDimSetEntry0."Dimension Value Code";
//                         TempDimBuf2.INSERT;
//                     UNTIL TempDimSetEntry0.NEXT = 0;

//                 TempDimBuf2.RESET;
//                 IF TempDimBuf2.FINDSET THEN BEGIN
//                     REPEAT
//                         DimVal.GET(TempDimBuf2."Dimension Code", TempDimBuf2."Dimension Value Code");
//                         TempDimSetEntry."Dimension Code" := TempDimBuf2."Dimension Code";
//                         TempDimSetEntry."Dimension Value Code" := TempDimBuf2."Dimension Value Code";
//                         TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
//                         TempDimSetEntry.INSERT;
//                     UNTIL TempDimBuf2.NEXT = 0;
//                     NewDimSetID := DimMgt.GetDimensionSetID(TempDimSetEntry);
//                 END;
//                 ValueEntry."Dimension Set ID" := NewDimSetID;
//                 ValueEntry.MODIFY;
//             UNTIL ValueEntry.NEXT = 0;
//     end;

//     local procedure UpdateGLEntries()
//     begin
//         GLEntry.SETRANGE("Document No.", SalesInvoiceHeader."No.");
//         GLEntry.SETRANGE("Document Date", SalesInvoiceHeader."Posting Date");
//         IF GLEntry.FINDSET THEN
//             REPEAT
//                 OldDimensionSetID := 0;
//                 NewDimSetID := 0;
//                 TempDimSetEntry.RESET;
//                 TempDimSetEntry.DELETEALL;
//                 TempDimSetEntry0.RESET;
//                 TempDimSetEntry0.DELETEALL;

//                 IF SalesInvoiceHeader."Dimension Set ID" > 0 THEN
//                     DimMgt.GetDimensionSet(TempDimSetEntry0, SalesInvoiceHeader."Dimension Set ID");

//                 TempDimBuf2.RESET;
//                 TempDimBuf2.DELETEALL;
//                 IF TempDimSetEntry0.FINDSET THEN
//                     REPEAT
//                         TempDimBuf2.INIT;
//                         TempDimBuf2."Table ID" := 17;
//                         TempDimBuf2."Entry No." := 0;
//                         TempDimBuf2."Dimension Code" := TempDimSetEntry0."Dimension Code";
//                         TempDimBuf2."Dimension Value Code" := TempDimSetEntry0."Dimension Value Code";
//                         TempDimBuf2.INSERT;
//                     UNTIL TempDimSetEntry0.NEXT = 0;

//                 TempDimBuf2.RESET;
//                 IF TempDimBuf2.FINDSET THEN BEGIN
//                     REPEAT
//                         DimVal.GET(TempDimBuf2."Dimension Code", TempDimBuf2."Dimension Value Code");
//                         TempDimSetEntry."Dimension Code" := TempDimBuf2."Dimension Code";
//                         TempDimSetEntry."Dimension Value Code" := TempDimBuf2."Dimension Value Code";
//                         TempDimSetEntry."Dimension Value ID" := DimVal."Dimension Value ID";
//                         TempDimSetEntry.INSERT;
//                     UNTIL TempDimBuf2.NEXT = 0;
//                     NewDimSetID := DimMgt.GetDimensionSetID(TempDimSetEntry);
//                 END;
//                 GLEntry."Dimension Set ID" := NewDimSetID;
//                 GLEntry.MODIFY;
//             UNTIL GLEntry.NEXT = 0;
//     end;
// }