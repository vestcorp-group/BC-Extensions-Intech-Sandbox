codeunit 75019 ExportToExcel_INTGEN
{
    // ----------------------------------------------------------------------------------------
    // Intech-Systems - info@intech-systems.com
    // ----------------------------------------------------------------------------------------
    // No                  Date        Author
    // ----------------------------------------------------------------------------------------
    // I-PD003-1260302-01  16/03/12    RaviShah
    //                                 Create Codeunit (Copy from Zinser)
    // I-C0007-1400411-01    11/08/14     Chintan Panchal
    //                       C0007-STANDARD DOCUMENTS AND REPORTS Upgrade to NAV 2013 R2
    // ----------------------------------------------------------------------------------------

    trigger OnRun()
    begin
    end;

    procedure EnterCell(RowNo: Integer;
        ColumnNo: Integer;
        CellValue: Text[250];
        Bold: Boolean;
        Italic: Boolean;
        UnderLine: Boolean)
    begin
        //I-PD003-1260302-01-NS
        TempExcelBuffer.INIT;
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Formula := '';
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Italic := Italic;
        TempExcelBuffer.Underline := UnderLine;
        TempExcelBuffer.INSERT;
        //I-PD003-1260302-01-NE

    end;


    procedure CreateExcelSheet(SheetName: Text[50])
    begin
        //I-PD003-1260302-01-NS
        //TempExcelBuffer.CreateBook;
        //TempExcelBuffer.UpdateBook(SheetName,SheetName,COMPANYNAME,USERID);
        //TempExcelBuffer.GiveUserControl;
        //ERROR('');
        //I-PD003-1260302-01-NE
    end;

    procedure IniExcelBuffer()
    begin

        TempExcelBuffer.DELETEALL; //I-PD003-1260302-01-N
    end;

    procedure OpenExcelSheet_gFnc(FileName_iTxt: Text[250];
        SheetName_iTxt: Text[250];
        AutoFit_iBln: Boolean)
    begin
        //I-PD003-1260302-01-NS
        //TempExcelBuffer.SetAutoFit_gFnc(AutoFit_iBln);
        //TempExcelBuffer.OpenBook(FileName_iTxt,SheetName_iTxt);
        //TempExcelBuffer.CreateSheetnoLineStyle_gFnc(SheetName_iTxt,'',COMPANYNAME,USERID);
        //TempExcelBuffer.GiveUserControl;
        //TempExcelBuffer.CloseBook_gFnc;
        //I-PD003-1260302-01-NE
    End;

    var
        TempExcelBuffer: Record "Excel Buffer";
        row: Integer;
        col: Integer;
}