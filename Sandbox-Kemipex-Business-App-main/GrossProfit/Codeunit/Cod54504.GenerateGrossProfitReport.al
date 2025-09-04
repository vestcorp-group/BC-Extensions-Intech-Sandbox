codeunit 53003 "Generate Gross Profit Report"//T12370-Full Comment //Hypercare 13-02-2025
{

    procedure RunReport(StartDt: Date; EndDt: Date): Text
    var
        GPReport: Report "Gross Profit Report";
        ExportGrossProfit: XmlPort GrossProfit;
        OutStr: OutStream;
        TempBlob: Codeunit "Temp Blob";
        Instr: InStream;
        TypeHelper: Codeunit "Type Helper";
        RecGrossProfit: Record "Gross Profit Report";
    begin
        Clear(GPReport);
        GPReport.UseRequestPage := false;
        GPReport.InitializeReportParameter(StartDt, EndDt, true);
        GPReport.Run();
        Commit();
        Clear(TempBlob);
        Clear(OutStr);
        Clear(Instr);
        Clear(ExportGrossProfit);
        Clear(RecGrossProfit);
        if RecGrossProfit.FindSet() then;
        TempBlob.CreateOutStream(OutStr);
        ExportGrossProfit.SetTableView(RecGrossProfit);
        ExportGrossProfit.SetDestination(OutStr);
        ExportGrossProfit.Export();
        TempBlob.CreateInStream(Instr);//, TEXTENCODING::UTF8
        exit(TypeHelper.ReadAsTextWithSeparator(Instr, TypeHelper.LFSeparator));
    end;
}
