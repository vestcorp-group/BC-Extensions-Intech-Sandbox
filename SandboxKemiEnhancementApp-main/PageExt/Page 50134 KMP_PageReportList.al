pageextension 80016 KMP_pageReportList_ExtNew extends KMP_PageReportList//T12370-Full Comment
{
    layout
    {
        modify(Description)
        {
            trigger OnDrillDown()
            var
            begin
                case Rec.Name of
                    'Product Tracking Report':
                        Report.RunModal(Report::KMP_RptProductTracking, true, true);
                    'Warehouse Inventory':
#pragma warning disable AL0432 // TODO: - Will remove once report will be removed
                        Report.RunModal(Report::KMP_WarehouseInventory, true, true);
#pragma warning restore AL0432 // TODO: - Will remove once report will be removed
                    // 'BPO Summary':
                    //     Report.RunModal(Report::KMP_RptBPOSummary, true, true);
                    'PO Summary':
                        Report.RunModal(Report::KMP_RptPOSummary, true, true);
                    'Purchase Receipt Report':
                        Report.RunModal(Report::KMP_RptPurchaseControl, true, true);
                    'Stock Reservation':
                        Report.RunModal(Report::KMP_StockReservationReport, true, true);
                    'Customer Outstanding':
                        Report.RunModal(Report::KMP_CustomerStatement, true, true);
                    'Inv. Valuation Rep':
                        Report.RunModal(Report::InventoryValuetionRep, true, true);
                    'Inv. Summary Rep':
                        Report.RunModal(Report::KMP_RptItemSummary_New, true, true);
                    'ST03 Stock Aging Report':
                        Report.RunModal(Report::"Stock Aging Analysis", true, true);
                end;
            end;
        }
    }
    actions
    {
        addlast(Processing)
        {
            action("Insert Inventory valuation & Inventory Summary Reports")
            {
                ApplicationArea = all;
                RunObject = codeunit InsertDataKmpSalesreportNew;
                Image = Process;
                Visible = ActionVisibility;
            }
        }
    }
    trigger OnOpenPage()
    begin
        ActionVisibility := false;
        KmpSalesReports.Reset();
        KmpSalesReports.SetFilter(SortOrder, '%1|%2', 1, 8);
        KmpSalesReports.SetFilter(Name, '%1|%2', 'Inventory Summary Report', 'Inventory Valuation Rpt');
        if KmpSalesReports.FindFirst() then
            ActionVisibility := true
        else begin
            KmpSalesReports.Reset();
            KmpSalesReports.SetFilter(SortOrder, '%1|%2', 12, 13);
            if Not KmpSalesReports.FindFirst() then
                ActionVisibility := true
            else
                ActionVisibility := false;
        end;
    end;

    var
        KmpSalesReports: Record KMP_TblReports;
        ActionVisibility: Boolean;
}