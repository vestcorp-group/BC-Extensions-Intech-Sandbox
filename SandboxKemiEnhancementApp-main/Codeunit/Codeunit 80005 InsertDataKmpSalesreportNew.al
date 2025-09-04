codeunit 80005 InsertDataKmpSalesreportNew//T12370-Full Comment
{
    trigger OnRun()
    begin
        KmpSalesReports.Reset();
        KmpSalesReports.SetRange(SortOrder, 12);
        if Not KmpSalesReports.FindFirst() then begin
            KmpSalesReports.init;
            KmpSalesReports.SortOrder := 12;
            KmpSalesReports.Name := 'Inv. Valuation Rep';
            KmpSalesReports.Description := 'Inventory Valuation';
            KmpSalesReports.Insert();
            KmpSalesReports.init;
            KmpSalesReports.SortOrder := 12;
            KmpSalesReports.Name := 'Inv. Summary Rep';
            KmpSalesReports.Description := 'Inventory Summary';
            KmpSalesReports.Insert();
            KmpSalesReports.SortOrder := 12;
            KmpSalesReports.Name := 'ST03 Stock Aging Report';
            KmpSalesReports.Description := 'ST03 Stock Aging Report';
            KmpSalesReports.Insert();
        end;

        //KemipexEnhancement2
        /* KmpSalesReports.Reset();
         KmpSalesReports.SetRange(SortOrder, 13);
         if Not KmpSalesReports.FindFirst() then begin
             KmpSalesReports.init;
             KmpSalesReports.SortOrder := 13;
             KmpSalesReports.Name := 'Stock Aging Analysis';
             KmpSalesReports.Description := 'Stock Aging With GRN';
             KmpSalesReports.Insert();
         end;
 */

        KmpSalesReports.Reset();
        if KmpSalesReports.Get('Inventory Summary Report', 1) then
            KmpSalesReports.Delete();
        KmpSalesReports.Reset();
        if KmpSalesReports.Get('Inventory Valuation Rpt', 8) then
            KmpSalesReports.Delete();
        //KemipexEnhancement2
    end;

    var
        KmpSalesReports: Record KMP_TblReports;
}