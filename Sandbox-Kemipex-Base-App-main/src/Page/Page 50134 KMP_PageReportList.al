page 50134 KMP_PageReportList//T12370-Full Comment
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = KMP_TblReports;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTableView = sorting(SortOrder);
    Caption = 'Kemipex Reports';
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                }

                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var

                    begin
                        case rec.Name of

                            // 'Product Tracking Report':
                            //     Report.RunModal(Report::KMP_RptProductTracking, true, true);//AS-27-11-2024
                            // 'BPO Summary':
                            //     Report.RunModal(Report::KMP_RptBPOSummary, true, true);
                            'PO Summary':
                                Report.RunModal(Report::KMP_RptPOSummary, true, true);
                            'Purchase Receipt Report':
                                Report.RunModal(Report::KMP_RptPurchaseControl, true, true);
                            /* 'Inventory Valuation Rpt':
                                Report.RunModal(Report::KMP_RptInventoryValuation, true, true); */

                            //T13386-NS
                            'Stock Reservation':
                                Report.RunModal(Report::KMP_StockReservationReport, true, true);//AS-27-11-2024 //T13386-NE
                            'Customer Outstanding':
                                Report.RunModal(Report::KMP_CustomerStatement, true, true);
                        end;
                    end;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Copy Reports List")
            {
                ApplicationArea = All;
                Caption = 'Copy Report List';
                Image = Create;
                trigger OnAction()
                begin
                    rec.CreateReportsList();
                end;
            }

            action("Clear Record List")
            {
                ApplicationArea = All;
                Caption = 'Clear Record List';
                Image = Delete;
                trigger OnAction()
                var
                    KMP_TblReportsL: Record KMP_TblReports;
                begin
                    if KMP_TblReportsL.FindSet() then
                        KMP_TblReportsL.DeleteAll();
                end;
            }
        }
    }
}