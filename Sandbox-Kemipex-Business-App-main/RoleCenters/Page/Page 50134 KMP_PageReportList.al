// pageextension 58160 KemipexReportsExtend extends KMP_PageReportList//T12370-Full Comment
// {
//     layout
//     {
//         // Add changes to page layout here
//     }

//     actions
//     {
//         // Add changes to page actions here
//     }

//     var
//         myInt: Integer;

//     trigger OnOpenPage()
//     var
//         myInt: Integer;
//     begin
//         Insert_and_delete_reportslist();

//     end;

//     local procedure Insert_and_delete_reportslist()
//     var
//         KMP_report_list: Record KMP_TblReports;
//     begin
//         if KMP_report_list.Get('Purchase Receipt Report', 7) then KMP_report_list.Delete();
//         if KMP_report_list.Get('Warehouse Inventory', 3) then KMP_report_list.Delete();
//     end;
// }