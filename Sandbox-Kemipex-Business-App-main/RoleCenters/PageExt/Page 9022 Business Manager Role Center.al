
pageextension 58039 Managemenactivity extends "Business Manager Role Center"//T12370-Full Comment   //T13413-Full UnComment
{
    layout
    {
        addafter("User Tasks Activities")
        {
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
        modify(Control139)
        {
            Visible = false;
        }
        modify(Control16)
        {
            Visible = false;
        }
        /* modify(Control56)
        {
            Visible = false;
        } */
        modify("Favorite Accounts")
        {
            Visible = false;
        }
        modify(Control55)
        {
            Visible = false;
        }
        modify(Control9)
        {
            Visible = false;
        }

        /*   modify(Control46)
           {
               Visible = false;
           }
           */
        addafter(Control16)
        {
            part(AccountSchedulePart; AccountSchedulePart)
            {
                ApplicationArea = all;
            }
            part("SPChart"; SalesFigureChart)
            {
                ApplicationArea = all;
            }
        }
        addbefore(Control16)
        {
            part("Sales Details"; "Consolidated Sales Details")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        modify("Sales Quote")
        {
            Visible = false;
        }

        modify("Sales Quotes")
        {
            Visible = false;
        }

        modify(Reminders)
        {
            Visible = false;
        }

        modify("Issued Reminders")
        {
            Visible = false;
        }
        modify("Finance Charge Memos")
        {
            Visible = false;
        }
        modify("Income Statement")
        {
            Visible = false;
        }
        modify("Incoming Documents")
        {
            Visible = false;
        }
        modify("Purchase Quote")
        {
            Visible = false;
        }
        modify("Purchase Quotes")
        {
            Visible = false;
        }
        addafter("Issued Reminders")
        {
            /* action(Posted_Doc)
             {
                 Caption = 'Posting User Report';
                 ApplicationArea = all;
                 RunObject = report Posting_User_Report;
             }
             */
        }

        addafter("Blanket Sales Orders")
        {

            action(ArchivedBSO)
            {
                Caption = 'Archived Blanket Sales Orders';

                ApplicationArea = all;
                RunObject = page "Blanket Sales Order Archives";
            }
        }
        addafter("Sales Orders")
        {
            action(ArchivedSO)
            {
                Caption = 'Archived Sales Orders';

                ApplicationArea = all;
                RunObject = page "Sales Order Archives";
            }
        }
        addafter(Report)
        {
            group(PurchaseReports)
            {
                Caption = 'Purchase Reports';

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
                action(PurchaseCostReport2)
                {
                    Caption = 'P003 Purchase Cost Report';
                    ApplicationArea = all;
                    RunObject = report PurchaseCostReport;  //T13413-N
                    // RunObject = report "Purchase Cost Report";   //T13413-O
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
                    // RunObject = report ST04_WarehouseInventoryreport;    //T13413-O
                    RunObject = report ST04_WarehouseInvreportNew;  //T13413-N
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
        addbefore("Item Charges")
        {
            action(CommercialItems)
            {
                Caption = 'Commercial Items';
                ApplicationArea = All;
                RunObject = Page Commercial_Items;
            }
            action(RawMaterialItems)
            {
                Caption = 'Raw Material Items';
                ApplicationArea = All;
                RunObject = Page Raw_Meterial_Items;
            }
            action(SampleItems)
            {
                Caption = 'Sample Items';
                ApplicationArea = All;
                RunObject = Page Sample_Items;
            }
        }
        addafter("Blanket Purchase Orders")
        {
            action(ArchivedBPO)
            {
                Caption = 'Archived Blanket Purchase Orders';

                ApplicationArea = all;
                RunObject = page "Blanket Purch. Order Archives";

            }
        }
        addafter("<Page Purchase Orders>")
        {
            action(ArchivedPO)
            {
                Caption = 'Archived Purchase Orders';
                ApplicationArea = all;
                RunObject = page "Purchase Order Archives";
            }

        }
        addafter("Posted Purchase Return Shipments")
        {

            group("Purchase Reports")
            {
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
                action(PurchaseCostReport)
                {
                    Caption = 'P003 Purchase Cost Report';
                    ApplicationArea = all;
                    RunObject = report PurchaseCostReport;  //T13413-N
                    // RunObject = report "Purchase Cost Report";   //T13413-O
                }


            }
        }
        addafter(Customers)
        {
            action(CommercialItems1)
            {
                Caption = 'Commercial Items';
                ApplicationArea = All;
                RunObject = Page Commercial_Items;
            }
            action(RawMaterialItems1)
            {
                Caption = 'Raw Material Items';
                ApplicationArea = All;
                RunObject = Page Raw_Meterial_Items;
            }
            action(SampleItems1)
            {
                Caption = 'Sample Items';
                ApplicationArea = All;
                RunObject = Page Sample_Items;
            }
        }
    }
}