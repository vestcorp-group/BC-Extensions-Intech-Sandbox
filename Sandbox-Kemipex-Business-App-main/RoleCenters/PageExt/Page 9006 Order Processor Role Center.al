pageextension 58168 salesorderprocessorrole extends "Order Processor Role Center"//T12370-Full Comment      //T13413-Full UnComment
{
    layout
    {
        //Additonal Customization
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
        modify(Control104)
        {
            Visible = false;
        }
        //Hide Trailing Sales Orders Charts
        modify(Control1)
        {
            Visible = false;
        }
        //Hide Sales Order Released not shipped
        modify(Control1901851508)
        {
            Visible = false;
        }
        //Hide Report Inbox
        modify(Control21)
        {
            Visible = false;
        }
        //Hide My Items
        modify(Control1905989608)
        {
            Visible = false;
        }
        //Hide My Customers
        modify(Control1907692008)
        {
            Visible = False;
        }
        modify(Control14)
        {
            Visible = false;
        }
        addafter(Control1901851508)
        {
            part("Consolidated Sales"; "Salesperson Activity Cue")
            {
                ApplicationArea = All;
            }
            /*part("Team Consol. Sales"; "Team Consol. Sales")
            {
                ApplicationArea = All;
            }*/
            part("Sales Order Activities"; "Salesperson Activity Cue 2")
            {
                ApplicationArea = all;
            }
            part("Sales Chart"; SalesFigureChart)
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        modify("Sales &Quote")
        {
            Visible = false;
        }
        modify("Sales &Return Order")
        {
            Visible = false;
        }
        modify("Sales &Credit Memo")
        {
            Visible = false;
        }
        modify("Sales &Invoice")
        {
            Visible = false;
        }
        //Inventory Menu Item Hiding
        modify(PurchaseJournals)
        {
            Visible = false;
        }
        modify("Posted Purchase Credit Memos")
        {
            Visible = false;
        }
        modify("Posted Purchase Invoices")
        {
            Visible = false;
        }
        modify("Posted Purchase Receipts")
        {
            Visible = false;
        }
        modify("Posted Purchase Return Shipments")
        {
            Visible = false;
        }
        modify("Posted Return Receipts")
        {
            Visible = false;
        }
        modify("Posted Transfer Receipts")
        {
            Visible = false;
        }
        modify("Posted Transfer Shipments")
        {
            Visible = false;
        }
        modify("Issued Reminders")
        {
            Visible = false;
        }
        modify("Issued Finance Charge Memos")
        {
            Visible = false;
        }
        //Setup and Extensions Menu
#pragma warning disable AL0432 // TODO: - Will remove once it be removed from base app 30-04-2022
        /* modify(SetupAndExtensions)  // hide by B, Because of MS Update
#pragma warning restore AL0432 // TODO: - Will remove once it be removed from base app 30-04-2022
        {
            Visible = false;
        } */
        //Purchasing menu Hide 
        modify(Action63)
        {
            Visible = false;
        }
        //Sales Menu Items Hiding
        modify(Action61)
        {
            Visible = false;
        }
        modify("Sales Quotes")
        {
            Visible = false;
        }
        modify("Sales Orders - Microsoft Dynamics 365 Sales")
        {
            Visible = false;
        }
        modify("Sales Credit Memos")
        {
            Visible = false;
        }
        modify("Sales Journals")
        {
            Visible = false;
        }
        modify(Action68)
        {
            Visible = false;
        }
        modify(Reminders)
        {
            Visible = false;
        }
        modify("Finance Charge Memos")
        {
            Visible = false;
        }
        modify("Posted Sales Credit Memos")
        {
            Visible = false;
        }
        modify("Posted Sales Invoices")
        {
            Visible = false;
        }
        modify("Posted Sales Return Receipts")
        {
            Visible = false;
        }
        modify("Posted Sales Shipments")
        {
            Visible = false;
        }
        //purchase related posted docs hiding
        modify(Action54)
        {
            Visible = false;
        }
        modify(Action86)
        {
            Visible = false;
        }
        modify(Action87)
        {
            Visible = false;
        }
        modify(Action53)
        {
            Visible = false;
        }
        //Hiding Processing Actions
        modify(Reports)
        {
            Visible = false;
        }
        modify(Tasks)
        {
            Visible = false;
        }
        modify(History)
        {
            Visible = false;
        }
        modify(Action42)
        {
            Visible = false;
        }
        //Hiding Inv. Menu
        modify(Action62)
        {
            Visible = false;
        }
        //hiding sales return orders & sales invoices
        modify("Sales Return Orders")
        {
            Visible = false;
        }
        modify("Sales Invoices")
        {
            Visible = false;
        }
        modify("Blanket Sales Orders")
        {
            Visible = false;
        }
        //adding masters menu
        addfirst(sections)
        {
            group("Masters")
            {
                action(CustAction)
                {
                    Caption = 'Customer';
                    ApplicationArea = All;
                    RunObject = page "Customer List";
                }
                action("Commercial Items")
                {
                    ApplicationArea = All;
                    RunObject = page 58062;
                }
                action("Sample Items")
                {
                    ApplicationArea = All;
                    RunObject = page 58065;
                }
                action("Raw Material Items")
                {
                    ApplicationArea = All;
                    RunObject = page 58064;
                }
            }
        }

        //Kemipex Reports Sections
        addlast(Sections)
        {
            group("Kemipex Reports")
            {
                action("Report")
                {
                    RunObject = page "KMP_PageReportList";
                    ApplicationArea = All;
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
                        RunObject = report KMP_SalesAnalysisReport;
                    }
                    action("Purchase In Transit Report")
                    {
                        ApplicationArea = all;
                        Caption = 'S004 Purchase In Transit Report';
                        RunObject = report "S004Purchase In Transit Report";
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
                        // RunObject = report ST04_WarehouseInventoryreport;    //T13413-O
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
                /*  action("Open Sales Order Report")
                  {
                      Caption = 'Open Sales Order Report';
                      ApplicationArea = All;
                      RunObject = report Open_Order_report;
                  }
                  action("Sales Shipment Line Report")
                  {
                      Caption = 'Sales Shipment Line Report';
                      ApplicationArea = All;
                      RunObject = report "Sales Shipment Line Report";
                  }
                  action("Warehouse Inventory Report")
                  {
                      Caption = 'Warehouse Inventory Report';
                      ApplicationArea = All;
                      RunObject = report "KMP_WarehouseInventory";
                  }
                  action("Inventory Summary")
                  {
                      ApplicationArea = All;
                      RunObject = report "KMP_RptItemSummary_new";
                  }
                  */
            }
        }
        addfirst(Action76)
        {
            action("BSO")
            {
                ApplicationArea = Suite;
                Caption = 'Blanket Sales Orders';
                Image = Reminder;
                // Promoted = true;
                // PromotedCategory = Process;
                RunObject = Page "Blanket Sales Orders";
                ToolTip = 'Use blanket sales orders as a framework for a long-term agreement between you and your customers to sell large quantities that are to be delivered in several smaller shipments over a certain period of time. Blanket orders often cover only one item with predetermined delivery dates. The main reason for using a blanket order rather than a sales order is that quantities entered on a blanket order do not affect item availability and thus can be used as a worksheet for monitoring, forecasting, and planning purposes..';
            }
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
        addfirst(creation)
        {
            action("Blanket Sales Order")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Blanket Sales Order';
                Image = Document;
                //Promoted = false;
                RunObject = page 507;
                RunPageMode = Create;
            }
        }
        addfirst(processing)
        {
            action("Sales Analysis Reports")
            {
                ApplicationArea = All;
                RunObject = report 70104;
            }
            action("Inventory Summary Report")
            {
                ApplicationArea = All;
                RunObject = report 80103;
            }
        }
    }
}