pageextension 58143 PurchCueRole extends "Purchasing Manager Role Center"//T12370-Full Comment      //T13413-Full UnComment
{
    layout
    {
        addfirst(RoleCenter)
        {
            part("Headline"; "Headline RC Prod. Planner")
            {
                ApplicationArea = All;
            }
        }
        addafter(Headline)
        {
            part("Sales Details"; "Consolidated Sales Details")
            {
                ApplicationArea = all;

            }
            part("Purchase Cues"; Procurement_Activities_page)
            {
                ApplicationArea = All;
            }
            part("Approval"; "Team Member Activities")
            {
                ApplicationArea = All;
            }
        }
        addafter(Approval)
        {
            part(Approvals; "Approvals Activities")
            {
                ApplicationArea = all;
            }
            // part("Power BI"; "Power BI Report Spinner Part")
            // {
            //     ApplicationArea = All;
            // }
            group(Notification)
            {
                ShowCaption = false;
                part("Notification Cue"; "Notification Cue")
                {
                    ApplicationArea = All;
                    Caption = 'Notifications';
                }
            }
        }
    }
    actions
    {
        modify("Purchase Quote Archives")
        {
            Visible = false;
        }
        modify(Contacts)
        {
            Visible = false;
        }
        modify("Purchase Return Order Archives")
        {
            Visible = false;
        }
        modify("Transfer Orders")
        {
            Visible = false;
        }
        modify("Purchase Journals")
        {
            Visible = false;
        }
        modify(Group1)
        {
            Visible = false;
        }
        modify(Group3)
        {
            Visible = false;
        }
        modify(Group2)
        {
            Visible = false;
        }
        modify(Group4)
        {
            Visible = false;
        }
        modify(Group8)
        {
            Visible = false;
        }
        modify(Group11)
        {
            Visible = false;
        }
        modify("Return Orders")
        {
            Visible = false;
        }
        modify(Invoices)
        {
            Visible = false;
        }
        modify("Certificates of Supply")
        {
            Visible = false;
        }
        modify(Quotes)
        {
            Visible = false;
        }
        modify("Posted Purchase Invoices")
        {
            Visible = true;
        }
        modify("Posted Credit Memos")
        {
            Visible = true;
        }
        modify("Credit Memos")
        {
            Visible = false;
        }
        addfirst(Processing)
        {

            action(Open_PO_Report)
            {
                Caption = 'P001 Open Purchase Order Report';
                ApplicationArea = all;
                RunObject = report Purchase_Line_report;
            }
            action(Purchase_receipt_report)
            {
                Caption = 'P002 Purchase Receipt Report';
                ApplicationArea = all;
                RunObject = report Purchase_reciept_report;
            }
            action(PurchaseCostReport)
            {
                Caption = 'P003 Purchase Cost Report';
                ApplicationArea = all;
                RunObject = report PurchaseCostReport;     //T13413-N
                // RunObject = report "Purchase Cost Report";   //T13413-O
            }
            action(BPOSummary2)
            {
                Caption = 'P004 BPO Summary Report';
                ApplicationArea = all;
                RunObject = report "BPO Summary Report";
            }
            action(Open_SO_Report)
            {
                Caption = 'S001 Open Sales Order Report';
                ApplicationArea = all;
                RunObject = report Open_Sales_Order_report;
            }
            action(Sales_Shipment_Line_report)
            {
                Caption = 'S002 Sales Shipment Line Report';
                ApplicationArea = all;
                RunObject = report "Sales Shipment Line Report";
            }

            /*    action("Inventory Summary")
                {
                    ApplicationArea = All;
                    RunObject = report "KMP_RptItemSummary";
                }
                */
            action("ST03 Stock Aging")
            {
                ApplicationArea = All;
                RunObject = report "Stock Aging Analysis";
            }
            action("ST04 Warehouse Inventory")
            {
                Caption = 'ST04 Warehouse Inventory Report';
                ApplicationArea = All;
                RunObject = report ST04_WarehouseInvreportNew;   //T13413-N
                // RunObject = report ST04_WarehouseInventoryreport;   //T13413-O
            }
        }
        addlast(Sections)
        {
            group("Kemipex Reports")
            {
                action("Reports")
                {
                    RunObject = page "KMP_PageReportList";
                    ApplicationArea = All;
                }
                group(PurchaseReports)
                {
                    Caption = 'Purchase Reports';

                    action(Open_PO_Report2)
                    {
                        Caption = 'P001 Open Purchase Order Report';
                        ApplicationArea = all;
                        RunObject = report Purchase_Line_report;
                    }
                    action(Purchase_receipt_report2)
                    {
                        Caption = 'P002 Purchase Receipt Report';
                        ApplicationArea = all;
                        RunObject = report Purchase_reciept_report;
                    }
                    action(PurchaseCostReport2)
                    {
                        Caption = 'P003 Purchase Cost Report';
                        ApplicationArea = all;
                        RunObject = report PurchaseCostReport;      //T13413-N
                        // RunObject = report "Purchase Cost Report";      //T13413-O
                    }
                    action(BPOSummary)
                    {
                        Caption = 'P004 BPO Summary Report';
                        ApplicationArea = all;
                        RunObject = report "BPO Summary Report";
                    }
                }
                group(SalesReports)
                {
                    Caption = 'Sales Reports';
                    action(Open_SO_Report2)
                    {
                        Caption = 'S001 Open Sales Order Report';
                        ApplicationArea = all;
                        RunObject = report Open_Sales_Order_report;
                    }

                    action(Sales_Shipment_Line_report2)
                    {
                        Caption = 'S002 Sales Shipment Line Report';
                        ApplicationArea = all;
                        RunObject = report "Sales Shipment Line Report";
                    }
                    action("Sales Analysis Report")
                    {
                        Caption = 'S003 Sales Analysis Report';
                        ApplicationArea = all;
                        RunObject = report 70104;
                    }
                    action("Purchase In Transit Report")
                    {
                        ApplicationArea = all;
                        Caption = 'S004 Purchase In Transit Report';
                        RunObject = report 58219;
                    }
                }
                group(InventoryReports)
                {
                    Caption = 'Inventory Reports';
                    action("ST03 Stock Aging Report")
                    {
                        Caption = 'ST03 Stock Aging Report';
                        ApplicationArea = all;
                        RunObject = report "Stock Aging Analysis";
                    }
                    action("ST04 Warehouse Inventory Report")
                    {
                        Caption = 'ST04 Warehouse Inventory Report';
                        ApplicationArea = all;
                        RunObject = report ST04_WarehouseInvreportNew;   //T13413-N
                        // RunObject = report ST04_WarehouseInventoryreport;   //T13413-O
                    }
                    action("ST05 Sample Inventory Summary")
                    {
                        Caption = 'ST05 Sample Inventory Summary';
                        ApplicationArea = all;
                        RunObject = report Summ_sampleInventoryReport;
                    }
                    action("ST06 Sample Inventory Detailed")
                    {
                        Caption = 'ST06 Sample Inventory Detailed';
                        ApplicationArea = all;
                        RunObject = report Det_SampleInventoryReport;
                    }
                }

            }
        }
        addfirst(Sections)
        {
            group("Masters")
            {
                action("Customer")
                {
                    ApplicationArea = All;
                    RunObject = page "Customer List";
                }
            }
            group("Sales")
            {
                action("Blanket Sales Order")
                {
                    ApplicationArea = All;
                    RunObject = page "Blanket Sales Orders";
                }
                action("Blanket Sales Order Archives")
                {
                    ApplicationArea = All;
                    RunObject = page 6622;
                }
                action("Sales Order")
                {
                    ApplicationArea = All;
                    RunObject = page "Sales Order List";
                }
                action("Sales Order Archives")
                {
                    ApplicationArea = All;
                    RunObject = page "Sales Order Archives";
                }
                action("Sales Shipment")
                {
                    ApplicationArea = All;
                    RunObject = page "Posted Sales Shipments";
                }
                action("Posted Sales Invoice")
                {
                    ApplicationArea = All;
                    RunObject = page 143;
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = All;
                    RunObject = page "Posted Sales Credit Memos";
                }
            }
        }
        moveafter("Blanket Orders"; Orders)
        addafter("Blanket Orders")
        {
            action("Blanket Purchase Order Archives")
            {
                ApplicationArea = All;
                RunObject = page 6625;
            }
        }
        addafter(Orders)
        {
            action("Purch. Order Archives")
            {
                Caption = 'Purchase Order Archives';
                ApplicationArea = All;
                RunObject = page 9347;
            }
        }
        movebefore(Customer; Vendors)
        moveafter("Purch. Order Archives"; "Posted Purchase Invoices")
        moveafter("Posted Purchase Invoices"; "Posted Credit Memos")
        moveafter(Customer; Items)
    }
    var
        myInt: Integer;
}




/*
             group(PurchaseReports)
             {
                 Caption = 'Purchase Reports';

                 action(Open_PO_Report2)
                 {
                     Caption = 'P001 Open Purchase Order Report';
                     ApplicationArea = all;
                     RunObject = report Purchase_Line_report;
                 }
                 action(Purchase_receipt_report2)
                 {
                     Caption = 'P002 Purchase Receipt Report';
                     ApplicationArea = all;
                     RunObject = report Purchase_reciept_report;
                 }
                 action(PurchaseCostReport2)
                 {
                     Caption = 'P003 Purchase Cost Report';
                     ApplicationArea = all;
                     RunObject = report "Purchase Cost Report";
                 }
             }
             group(SalesReports)
             {
                 Caption = 'Sales Reports';

                 action(Open_SO_Report2)
                 {
                     Caption = 'S001 Open Sales Order Report';
                     ApplicationArea = all;

                     RunObject = report Open_Order_report;
                 }

                 action(Sales_Shipment_Line_report2)
                 {

                     Caption = 'S002 Sales Shipment Line Report';
                     ApplicationArea = all;
                     RunObject = report "Sales Shipment Line Report";
                 }
             }
             group(InventoryReports)
             {
                 Caption = 'Inventory Reports';
                 action("ST04 Warehouse Inventory Report2")
                 {
                     Caption = 'ST04 Warehouse Inventory Report';
                     ApplicationArea = all;
                     RunObject = report ST04_WarehouseInventoryreport;
                 }
                 action("ST03 Stock Aging Report")
                 {
                     Caption = 'ST03 Stock Aging Report';
                     ApplicationArea = all;
                     RunObject = report "Stock Aging Analysis";
                 }
             }
             /*   action("Open Sales Order Report")
                {
                    Caption = 'Open Sales Order Report';
                    ApplicationArea = All;
                    RunObject = report Open_Order_report;
                }
                action("Open Purchase Order Report")
                {
                    Caption = 'Open Purchase Order Report';
                    ApplicationArea = All;
                    RunObject = report 58053;
                }
                action("Purchase Reciept Report")
                {
                    Caption = 'Purchase Reciept Report';
                    ApplicationArea = All;
                    RunObject = report 58115;
                }
                action("Sales Shipment Line Report")
                {
                    Caption = 'Sales Shipment Line Report';
                    ApplicationArea = All;
                    RunObject = report "Sales Shipment Line Report";
                }
                action("ST04 Warehouse Inventory Report")
                {
                    Caption = 'ST04 Warehouse Inventory Report';
                    ApplicationArea = All;
                    RunObject = report ST04_WarehouseInventoryreport;
                }
                */
