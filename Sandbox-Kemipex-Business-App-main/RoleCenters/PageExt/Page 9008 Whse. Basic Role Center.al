pageextension 58117 "Shipping and Receiving" extends "Whse. Basic Role Center"//T12370-Full Comment     //T13413-Full UnComment
{
    layout
    {
        //additional customization
        addbefore("User Tasks Activities")
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
        modify("WMS Ship and Receive Activities")
        {
            Visible = false;
        }
        modify(Control52)
        {
            Visible = false;
        }
        modify(Control1907692008)
        {
            Visible = false;
        }
        addbefore(Control1906245608)
        {
            part("Sales Details"; "Consolidated Sales Details")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        modify("T&ransfer Order")
        {
            Visible = false;
        }
        modify("Item &Tracing")
        {
            Visible = false;
        }
        modify("Phys. Inv. Recording")
        {
            Visible = false;
        }
        modify("&Purchase Order")
        {
            Visible = false;
        }
        modify("Warehouse &Bin List")
        {
            Visible = false;
        }
        modify("Physical &Inventory List")
        {
            Visible = false;
        }
        modify("Customer &Labels")
        {
            Visible = false;
        }
        modify(PhysInventoryJournals)
        {
            Visible = false;
        }
        modify("Edit Item Reclassification &Journal")
        {
            Visible = false;
        }
        modify(ItemReclassificationJournals)
        {
            Visible = false;
        }
        modify(PhysInventoryRecordings)
        {
            Visible = false;
        }
        modify("Internal Movements")
        {
            Visible = false;
        }
        modify("Inventory P&ut-away")
        {
            Visible = false;
        }
        modify("Inventory Pi&ck")
        {
            Visible = false;
        }
        modify("Phys. Inv. Order")
        {
            Visible = false;
        }
        modify(BinContents)
        {
            Visible = false;
        }
#pragma warning disable AL0432 // TODO: - will remove once it will be removed from base app
        /* modify(SetupAndExtensions) // hide by B, Because of MS Update
 #pragma warning restore AL0432 // TODO: - will remove once it will be removed from base app
         {
             Visible = false;
         } */
        modify("Sales & Purchases")
        {
            Caption = 'Pre Document';
        }
        modify("Posted Assembly Orders")
        {
            Visible = false;
        }
        modify("Reference Data")
        {
            Visible = false;
        }
        modify(Journals)
        {
            Visible = false;
        }
        modify(Worksheet)
        {
            Visible = false;
        }
        modify("Posted Invt. Picks")
        {
            Visible = false;
        }
        modify("Registered Picks")
        {
            Visible = false;
        }
        modify("Whse. &Shipment")
        {
            Visible = false;
        }
        modify("&Whse. Receipt")
        {
            Visible = false;
        }
        modify("Registered Put-aways")
        {
            Visible = false;
        }
        modify("Registered Movements")
        {
            Visible = false;
        }
        modify("Purchase Quote Archives")
        {
            Visible = false;
        }
        modify("Purchase Return Order Archives")
        {
            Visible = false;
        }
        modify("Posted Invt. Put-aways")
        {
            Visible = false;
        }
        modify("Registered Invt. Movements")
        {
            Visible = false;
        }
        modify("Posted Phys. Invt. Recordings")
        {
            Visible = false;
        }
        modify("Posted Phys. Invt. Orders")
        {
            Visible = false;
        }
        addfirst(sections)
        {
            group(Masters)
            {
                action("Item")
                {
                    RunObject = page "Item List";
                    ApplicationArea = all;
                }
            }
        }
        addbefore(SalesOrders)
        {
            action("Blanket Sales Order")
            {
                ApplicationArea = all;
                RunObject = page "Blanket Sales Orders";
            }
        }
        addafter(SalesOrders)
        {
            action("Sales Invoices")
            {
                ApplicationArea = all;
                RunObject = page "Sales Invoice List";
            }
        }
        addbefore(PurchaseOrders)
        {
            action("Blanket Purchase Orders")
            {
                ApplicationArea = all;
                RunObject = page "Blanket Purchase Orders";
            }
        }
        addafter(PurchaseOrders)
        {
            action("Transfer Order")
            {
                ApplicationArea = all;
            }
        }
        addafter("Posted Sales Shipment")
        {
            action("Warehouse Delivery Instruction")
            {
                ApplicationArea = all;
                RunObject = page "Warehouse Delivery Inst List";
            }
            action("Posted Sales Invoices")
            {
                ApplicationArea = all;
                RunObject = page "Posted Sales Invoices";
            }
        }
        addlast(Sections)
        {
            group("Kemipex Reports")
            {
                action("Shipping and receiving report")
                {
                    RunObject = page KMP_PageReportList;
                    ApplicationArea = All;
                    Caption = 'Reports';
                }
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
                        // RunObject = report "Purchase Cost Report";  //T13413-O
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
                    action("ST03 Stock Aging Report2")
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
                /*  action(Open_SO_Report)
                  {
                      Caption = 'Open Sales Order Report';
                      ApplicationArea = all;
                      RunObject = report Open_Order_report;
                  }
                  action(Open_PO_Report)
                  {
                      Caption = 'Open Purchase Order Report';
                      ApplicationArea = all;
                      RunObject = report Purchase_Line_report;
                  }
                  action(Purchase_receipt_report)
                  {
                      Caption = 'Purchase Receipt Report';
                      ApplicationArea = all;
                      RunObject = report Purchase_reciept_report;
                  }
                  action("ST04 Warehouse Inventory Report")
                  {
                      ApplicationArea = all;
                      RunObject = report ST04_WarehouseInventoryreport;
                  }
                  */
            }
        }
        addlast(Processing)
        {
            action("ST04 Warehouse Inventory")
            {
                Caption = 'ST04 Warehouse Inventory Report';
                ApplicationArea = all;
                RunObject = report ST04_WarehouseInvreportNew;  //T13413-N
                // RunObject = report ST04_WarehouseInventoryreport;   //T13413-O 
            }
            action("Inventory Summary Report")
            {
                ApplicationArea = all;
                RunObject = report KMP_RptItemSummary_New;
            }
            action("ST03 Stock Aging Report")
            {
                ApplicationArea = all;
                RunObject = report "Stock Aging Analysis";
            }
            /*   action("Insert Inventory valuation & Inventory Summary Reports")
               {
                   ApplicationArea = all;
                   RunObject = codeunit InsertDataKmpSalesreportNew;
                   Image = Process;
                   Visible = ActionVisibility;
               }
               */
        }
        moveafter(Item; Customers)
        moveafter(Item; Vendors)
        movebefore("Posted Sales Shipment"; "Posted Purchase Receipts")
        movebefore("Posted Return Receipts"; "Posted Return Shipments")
        movebefore(PurchaseReturnOrders; SalesReturnOrders)
    }
    var
        KmpSalesReports: Record KMP_TblReports;
        ActionVisibility: Boolean;
}