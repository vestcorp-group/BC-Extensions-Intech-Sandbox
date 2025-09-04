TableExtension 50114 Excel_Buffer_50114 extends "Excel Buffer"
{
    Description = 'T47866';
    procedure CreateBookAndOpenExcel_gFnc(FileName: Text; SheetName: Text[250]; ReportHeader: Text; CompanyName2: Text; UserID2: Text)
    begin
        CreateNewBook(SheetName);
        WriteSheet(ReportHeader, CompanyName(), UserId());
        CloseBook();
        OpenExcel();
        ERROR('');
    end;
}
