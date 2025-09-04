Report 74993 "Update Posting Date Batch"
{
    //UpdatePostingDateBatch
    Permissions = TableData "G/L Entry" = rm,
                  TableData "Cust. Ledger Entry" = rm,
                  TableData "Vendor Ledger Entry" = rm,
                  TableData "Item Ledger Entry" = rm,
                  TableData "Sales Shipment Header" = rm,
                  TableData "Sales Shipment Line" = rm,
                  TableData "Sales Invoice Header" = rm,
                  TableData "Sales Invoice Line" = rm,
                  TableData "Sales Cr.Memo Header" = rm,
                  TableData "Sales Cr.Memo Line" = rm,
                  TableData "Purch. Rcpt. Header" = rm,
                  TableData "Purch. Rcpt. Line" = rm,
                  TableData "Purch. Inv. Header" = rm,
                  TableData "Purch. Inv. Line" = rm,
                  TableData "Purch. Cr. Memo Hdr." = rm,
                  TableData "Purch. Cr. Memo Line" = rm,
                  TableData "Bank Account Ledger Entry" = rm,
                  TableData "Check Ledger Entry" = rm,
                  TableData "Detailed Cust. Ledg. Entry" = rm,
                  TableData "Detailed Vendor Ledg. Entry" = rm,
                  TableData "Posted Assembly Header" = rm,
                  TableData "Transfer Shipment Header" = rm,
                  TableData "Transfer Shipment Line" = rm,
                  TableData "Transfer Receipt Header" = rm,
                  TableData "Transfer Receipt Line" = rm,
                  TableData "Value Entry" = rm,
                  TableData "Capacity Ledger Entry" = rm,
                  TableData "Service Ledger Entry" = rm,
                  TableData "Service Invoice Header" = rm,
                  TableData "Service Invoice Line" = rm,
                  TableData "Return Shipment Header" = rm,
                  TableData "Return Shipment Line" = rm,
                  TableData "Return Receipt Header" = rm,
                  TableData "Return Receipt Line" = rm,
                  TableData "Warehouse Entry" = rm,
                  TableData "TDS Entry" = rm;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Update Posting Date Batch"; "Update Posting Date Batch")
        {
            DataItemTableView = sorting("Document No.") where(Updated = const(false));
            RequestFilterFields = "Document No.", "Posting Date";

            trigger OnAfterGetRecord()
            var
                MopdUpdPostingDateBatch_lRec: Record "Update Posting Date Batch";
            begin
                Curr += 1;
                W.Update(2, Curr);

                TestField("Document No.");
                TestField("Posting Date");
                TestField("New Posting Date");

                UpdateDateRecords_gFnc();

                MopdUpdPostingDateBatch_lRec.Get("Document No.");
                MopdUpdPostingDateBatch_lRec.Updated := true;
                MopdUpdPostingDateBatch_lRec.Modify;
                Commit;
            end;

            trigger OnPostDataItem()
            begin
                W.Close;
            end;

            trigger OnPreDataItem()
            begin
                IF UserId <> 'BCADMIN' then
                    Error('Only BCADMIN user can open this page');

                W.Open('Total #1#################\Current #2###############');
                W.Update(1, Count);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        W: Dialog;
        Curr: Integer;


    local procedure UpdateDateRecords_gFnc()
    var
        PurchInvLine_gRec: Record "Purch. Inv. Line";
        SalesInvLine_gRec: Record "Sales Invoice Line";
        Text50000_gCtx: label 'Please select Update Date.';
        SalesCrMemoLine_lRec: Record "Sales Cr.Memo Line";
        R6650_lRec: Record "Return Shipment Header";
        R6660_lRec: Record "Return Receipt Header";
        R6651_lRec: Record "Return Shipment Line";
        R6661_lRec: Record "Return Receipt Line";
        T5744_lRec: Record "Transfer Shipment Header";
        T5745_lRec: Record "Transfer Shipment Line";
        T5746_lRec: Record "Transfer Receipt Header";
        T5747_lRec: Record "Transfer Receipt Line";
        ServiceLedgerEntry_lRec: Record "Service Ledger Entry";
        ServiceInvoiceHeader_lRec: Record "Service Invoice Header";
        ServiceInvoiceLine_lRec: Record "Service Invoice Line";
        Mod18001: Record "Detailed GST Ledger Entry";
        Mod18005: Record "GST Ledger Entry";
        SOSalesHeader: Record "Sales Header";
        SISalesHeader: Record "Sales Header";
        SROSalesHeader: Record "Sales Header";
        SCMSalesHeader: Record "Sales Header";
        SalesShptHeader: Record "Sales Shipment Header";
        SalesInvHeader: Record "Sales Invoice Header";
        ReturnRcptHeader: Record "Return Receipt Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SOServHeader: Record "Service Header";
        SIServHeader: Record "Service Header";
        SCMServHeader: Record "Service Header";
        ServShptHeader: Record "Service Shipment Header";
        ServInvHeader: Record "Service Invoice Header";
        ServCrMemoHeader: Record "Service Cr.Memo Header";
        IssuedReminderHeader: Record "Issued Reminder Header";
        IssuedFinChrgMemoHeader: Record "Issued Fin. Charge Memo Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        ReturnShptHeader: Record "Return Shipment Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        ProductionOrderHeader: Record "Production Order";
        PostedAssemblyHeader: Record "Posted Assembly Header";
        TransShptHeader: Record "Transfer Shipment Header";
        TransRcptHeader: Record "Transfer Receipt Header";
        PostedWhseRcptLine: Record "Posted Whse. Receipt Line";
        PostedWhseShptLine: Record "Posted Whse. Shipment Line";
        GLEntry: Record "G/L Entry";
        VATEntry: Record "VAT Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
        PhysInvtLedgEntry: Record "Phys. Inventory Ledger Entry";
        ResLedgEntry: Record "Res. Ledger Entry";
        JobLedgEntry: Record "Job Ledger Entry";
        JobWIPEntry: Record "Job WIP Entry";
        JobWIPGLEntry: Record "Job WIP G/L Entry";
        ValueEntry: Record "Value Entry";
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        CheckLedgEntry: Record "Check Ledger Entry";
        ReminderEntry: Record "Reminder/Fin. Charge Entry";
        FALedgEntry: Record "FA Ledger Entry";
        MaintenanceLedgEntry: Record "Maintenance Ledger Entry";
        InsuranceCovLedgEntry: Record "Ins. Coverage Ledger Entry";
        CapacityLedgEntry: Record "Capacity Ledger Entry";
        ServLedgerEntry: Record "Service Ledger Entry";
        GSTLedgerEntry: Record "GST Ledger Entry";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        ServiceTransferShptHeader: Record "Service Transfer Shpt. Header";
        ServiceTransferRcptHeader: Record "Service Transfer Rcpt. Header";
        WarrantyLedgerEntry: Record "Warranty Ledger Entry";
        WhseEntry: Record "Warehouse Entry";
        CostEntry: Record "Cost Entry";
        PurchRcptLine_gRec: Record "Purch. Rcpt. Line";
        ItemLedgerEntry_gRec: Record "Item Ledger Entry";
        WarehouseEntry_gRec: Record "Warehouse Entry";
        PurchCrmemohdr_gRec: Record "Purch. Cr. Memo Hdr.";
        PurchCrmemoLine_gRec: Record "Purch. Cr. Memo Line";
        CapacityLdrEntry_gRec: Record "Capacity Ledger Entry";
        TDSEntry: Record "TDS Entry";
        TCSEntry: Record "TCS Entry";
    begin
        //I-I034-302003-01-NS
        if "Update Posting Date Batch"."New Posting Date" = 0D then
            Error(Text50000_gCtx);


        SalesCrMemoHeader.Reset;
        SalesCrMemoHeader.SetFilter("No.", "Update Posting Date Batch"."Document No.");
        SalesCrMemoHeader.Setrange("Posting Date", "Update Posting Date Batch"."Posting Date");
        if SalesCrMemoHeader.FindFirst then begin
            SalesCrMemoHeader."Posting Date" := "Update Posting Date Batch"."New Posting Date";
            SalesCrMemoLine_lRec.Reset;
            SalesCrMemoLine_lRec.SetRange("Document No.", SalesCrMemoHeader."No.");
            if SalesCrMemoLine_lRec.FindFirst then begin
                repeat
                    if SalesCrMemoLine_lRec."Posting Date" <> 0D then begin
                        SalesCrMemoLine_lRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                        SalesCrMemoLine_lRec.Modify;
                    end;
                until SalesCrMemoLine_lRec.Next = 0;
                SalesCrMemoHeader."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                SalesCrMemoHeader.Modify;
            end;
        end;


        PurchInvHeader.Reset;
        PurchInvHeader.SetFilter("No.", "Update Posting Date Batch"."Document No.");
        PurchInvHeader.Setrange("Posting Date", "Update Posting Date Batch"."Posting Date");
        if PurchInvHeader.FindFirst then begin
            PurchInvHeader."Posting Date" := "Update Posting Date Batch"."New Posting Date";
            PurchInvLine_gRec.SetRange("Document No.", PurchInvHeader."No.");
            if PurchInvLine_gRec.FindFirst then begin
                repeat
                    if PurchInvLine_gRec."Posting Date" <> 0D then
                        PurchInvLine_gRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                    PurchInvLine_gRec.Modify;
                until PurchInvLine_gRec.Next = 0;
                PurchInvHeader."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                PurchInvHeader.Modify;
            end;
        end;

        R6650_lRec.Reset;
        R6650_lRec.SetFilter("No.", "Update Posting Date Batch"."Document No.");
        R6650_lRec.Setrange("Posting Date", "Update Posting Date Batch"."Posting Date");
        if R6650_lRec.FindFirst then begin
            R6650_lRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
            R6650_lRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
            R6650_lRec.Modify;

            R6651_lRec.Reset;
            R6651_lRec.SetRange("Document No.", R6650_lRec."No.");
            if R6651_lRec.FindFirst then begin
                repeat
                    if R6651_lRec."Posting Date" <> 0D then
                        R6651_lRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                    R6651_lRec.Modify;
                until R6651_lRec.Next = 0;
            end;
        end;

        R6660_lRec.Reset;
        R6660_lRec.SetFilter("No.", "Update Posting Date Batch"."Document No.");
        R6660_lRec.Setrange("Posting Date", "Update Posting Date Batch"."Posting Date");
        if R6660_lRec.FindFirst then begin
            R6660_lRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
            R6660_lRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
            R6660_lRec.Modify;

            R6661_lRec.Reset;
            R6661_lRec.SetRange("Document No.", R6660_lRec."No.");
            if R6661_lRec.FindFirst then begin
                repeat
                    if R6661_lRec."Posting Date" <> 0D then
                        R6661_lRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                    R6661_lRec.Modify;
                until R6661_lRec.Next = 0;
            end;
        end;

        PurchRcptHeader.Reset;
        PurchRcptHeader.SetFilter("No.", "Update Posting Date Batch"."Document No.");
        PurchRcptHeader.Setrange("Posting Date", "Update Posting Date Batch"."Posting Date");
        if PurchRcptHeader.FindFirst then begin
            PurchRcptHeader."Posting Date" := "Update Posting Date Batch"."New Posting Date";
            PurchRcptLine_gRec.SetRange("Document No.", PurchRcptHeader."No.");
            if PurchRcptLine_gRec.FindFirst then begin
                repeat
                    if PurchRcptLine_gRec."Posting Date" <> 0D then begin
                        PurchRcptLine_gRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                        PurchRcptLine_gRec.Modify;
                    end;
                until PurchRcptLine_gRec.Next = 0;
            end;
            PurchRcptHeader."Posting Date" := "Update Posting Date Batch"."New Posting Date";
            IF "Update Posting Date Batch"."New Document Date" <> 0D Then begin
                PurchRcptHeader."Document Date" := "Update Posting Date Batch"."New Document Date";
            end;
            PurchRcptHeader.Modify;
        end;

        ItemLedgerEntry_gRec.Reset;
        ItemLedgerEntry_gRec.SetFilter("Document No.", "Update Posting Date Batch"."Document No.");
        ItemLedgerEntry_gRec.Setrange("Posting Date", "Update Posting Date Batch"."Posting Date");
        if ItemLedgerEntry_gRec.FindFirst then begin
            repeat
                ItemLedgerEntry_gRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                ItemLedgerEntry_gRec.Modify;
            until ItemLedgerEntry_gRec.Next = 0;
        end;

        WarehouseEntry_gRec.Reset;
        WarehouseEntry_gRec.SetFilter("Reference No.", "Update Posting Date Batch"."Document No.");
        WarehouseEntry_gRec.SetRange("Registering Date", "Update Posting Date Batch"."Posting Date");
        if WarehouseEntry_gRec.FindSet then begin
            repeat
                WarehouseEntry_gRec."Registering Date" := "Update Posting Date Batch"."New Posting Date";
                WarehouseEntry_gRec.Modify;
            until WarehouseEntry_gRec.Next = 0;
        end;

        SalesInvHeader.Reset;
        SalesInvHeader.SetFilter("No.", "Update Posting Date Batch"."Document No.");
        SalesInvHeader.Setrange("Posting Date", "Update Posting Date Batch"."Posting Date");
        if SalesInvHeader.FindFirst then begin
            SalesInvHeader."Posting Date" := "Update Posting Date Batch"."New Posting Date";
            SalesInvLine_gRec.SetRange("Document No.", SalesInvHeader."No.");
            if SalesInvLine_gRec.FindFirst then begin
                repeat
                    if SalesInvLine_gRec."Posting Date" <> 0D then begin
                        SalesInvLine_gRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                        SalesInvLine_gRec.Modify;
                    end;
                until SalesInvLine_gRec.Next = 0;
                SalesInvHeader."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                SalesInvHeader.Modify;
            end;
        end;

        PurchCrmemohdr_gRec.Reset;
        PurchCrmemohdr_gRec.SetFilter("No.", "Update Posting Date Batch"."Document No.");
        PurchCrmemohdr_gRec.Setrange("Posting Date", "Update Posting Date Batch"."Posting Date");
        if PurchCrmemohdr_gRec.FindFirst then begin
            PurchCrmemohdr_gRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
            PurchCrmemoLine_gRec.SetRange("Document No.", PurchCrmemohdr_gRec."No.");
            if PurchCrmemoLine_gRec.FindFirst then begin
                repeat
                    if PurchCrmemoLine_gRec."Posting Date" <> 0D then begin
                        PurchCrmemoLine_gRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                        PurchCrmemoLine_gRec.Modify;
                    end;
                until PurchCrmemoLine_gRec.Next = 0;
                PurchCrmemohdr_gRec."Document Date" := "Update Posting Date Batch"."New Posting Date";
                PurchCrmemohdr_gRec.Modify;
            end;
        end;

        GLEntry.Reset;
        GLEntry.SetFilter("Document No.", "Update Posting Date Batch"."Document No.");
        GLEntry.Setrange("Posting Date", "Update Posting Date Batch"."Posting Date");
        if GLEntry.FindSet then begin
            repeat
                GLEntry."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                GLEntry.Modify;
            until GLEntry.Next = 0;
        end;

        TDSEntry.Reset;
        TDSEntry.SetFilter("Document No.", "Update Posting Date Batch"."Document No.");
        TDSEntry.Setrange("Posting Date", "Update Posting Date Batch"."Posting Date");
        if TDSEntry.FindFirst then begin
            repeat
                TDSEntry."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                TDSEntry.Modify;
            until TDSEntry.Next = 0;
        end;

        VendLedgEntry.Reset;
        VendLedgEntry.SetFilter("Document No.", "Update Posting Date Batch"."Document No.");
        VendLedgEntry.Setrange("Posting Date", "Update Posting Date Batch"."Posting Date");
        if VendLedgEntry.FindFirst then begin
            repeat
                VendLedgEntry."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                VendLedgEntry.Modify;
            until VendLedgEntry.Next = 0;
        end;

        DtldVendLedgEntry.Reset;
        DtldVendLedgEntry.SetFilter("Document No.", "Update Posting Date Batch"."Document No.");
        DtldVendLedgEntry.Setrange("Posting Date", "Update Posting Date Batch"."Posting Date");
        if DtldVendLedgEntry.FindFirst then begin
            repeat
                DtldVendLedgEntry."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                DtldVendLedgEntry.Modify;
            until DtldVendLedgEntry.Next = 0;
        end;

        CustLedgEntry.Reset;
        CustLedgEntry.SetFilter("Document No.", "Update Posting Date Batch"."Document No.");
        CustLedgEntry.Setrange("Posting Date", "Update Posting Date Batch"."Posting Date");
        if CustLedgEntry.FindFirst then begin
            repeat
                CustLedgEntry."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                CustLedgEntry.Modify;
            until CustLedgEntry.Next = 0;
        end;

        DtldCustLedgEntry.Reset;
        DtldCustLedgEntry.SetFilter("Document No.", "Update Posting Date Batch"."Document No.");
        DtldCustLedgEntry.Setrange("Posting Date", "Update Posting Date Batch"."Posting Date");
        if DtldCustLedgEntry.FindFirst then begin
            repeat
                DtldCustLedgEntry."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                DtldCustLedgEntry.Modify;
            until DtldCustLedgEntry.Next = 0;
        end;

        ValueEntry.Reset;
        ValueEntry.SetCurrentkey("Document No.");
        ValueEntry.SetFilter("Document No.", "Update Posting Date Batch"."Document No.");
        ValueEntry.Setrange("Posting Date", "Update Posting Date Batch"."Posting Date");
        if ValueEntry.FindFirst then begin
            repeat
                ValueEntry."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                ValueEntry.Modify;
            until ValueEntry.Next = 0;
        end;

        CapacityLdrEntry_gRec.Reset;
        CapacityLdrEntry_gRec.SetCurrentkey("Document No.", "Posting Date");
        CapacityLdrEntry_gRec.SetFilter("Document No.", "Update Posting Date Batch"."Document No.");
        CapacityLdrEntry_gRec.Setrange("Posting Date", "Update Posting Date Batch"."Posting Date");
        if CapacityLdrEntry_gRec.FindFirst then begin
            repeat
                CapacityLdrEntry_gRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                CapacityLdrEntry_gRec.Modify;
            until CapacityLdrEntry_gRec.Next = 0;
        end;

        BankAccLedgEntry.Reset;
        BankAccLedgEntry.SetCurrentkey("Document No.", "Posting Date");
        BankAccLedgEntry.SetFilter("Document No.", "Update Posting Date Batch"."Document No.");
        BankAccLedgEntry.Setrange("Posting Date", "Update Posting Date Batch"."Posting Date");
        if BankAccLedgEntry.FindFirst then begin
            repeat
                BankAccLedgEntry."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                BankAccLedgEntry.Modify;
            until BankAccLedgEntry.Next = 0;
        end;

        CheckLedgEntry.Reset;
        CheckLedgEntry.SetCurrentkey("Document No.", "Posting Date");
        CheckLedgEntry.SetFilter("Document No.", "Update Posting Date Batch"."Document No.");
        CheckLedgEntry.Setrange("Posting Date", "Update Posting Date Batch"."Posting Date");
        if CheckLedgEntry.FindFirst then begin
            repeat
                CheckLedgEntry."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                CheckLedgEntry.Modify;
            until CheckLedgEntry.Next = 0;
        end;

        GSTLedgerEntry.Reset;
        GSTLedgerEntry.SetCurrentkey("Document No.", "Posting Date");
        GSTLedgerEntry.SetFilter("Document No.", "Update Posting Date Batch"."Document No.");
        if GSTLedgerEntry.FindFirst then begin
            repeat
                Mod18005.Get(GSTLedgerEntry."Entry No.");
                Mod18005."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                Mod18005.Modify;
            until GSTLedgerEntry.Next = 0;
        end;

        DetailedGSTLedgerEntry.Reset;
        DetailedGSTLedgerEntry.SetCurrentkey("Document No.", "Posting Date");
        DetailedGSTLedgerEntry.SetFilter("Document No.", "Update Posting Date Batch"."Document No.");
        if DetailedGSTLedgerEntry.FindFirst then begin
            repeat
                Mod18001.Get(DetailedGSTLedgerEntry."Entry No.");
                Mod18001."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                Mod18001.Modify;
            until DetailedGSTLedgerEntry.Next = 0;
        end;

        PostedAssemblyHeader.Reset;
        PostedAssemblyHeader.SetFilter("No.", "Update Posting Date Batch"."Document No.");
        PostedAssemblyHeader.Setrange("Posting Date", "Update Posting Date Batch"."Posting Date");
        if PostedAssemblyHeader.FindFirst then begin
            PostedAssemblyHeader."Posting Date" := "Update Posting Date Batch"."New Posting Date";
            PostedAssemblyHeader.Modify;
        end;

        T5744_lRec.Reset;
        T5744_lRec.SetFilter("No.", "Update Posting Date Batch"."Document No.");
        T5744_lRec.Setrange("Posting Date", "Update Posting Date Batch"."Posting Date");
        if T5744_lRec.FindFirst then begin
            T5744_lRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
            T5745_lRec.SetRange("Document No.", T5744_lRec."No.");
            if T5745_lRec.FindFirst then begin
                repeat
                //            IF T5745_lRec."Posting Date" <> 0D THEN BEGIN
                //            T5745_lRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                //          T5745_lRec.MODIFY;
                //END;
                until T5745_lRec.Next = 0;
            end;
            T5744_lRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
            T5744_lRec.Modify;
        end;

        T5746_lRec.Reset;
        T5746_lRec.SetFilter("No.", "Update Posting Date Batch"."Document No.");
        T5746_lRec.Setrange("Posting Date", "Update Posting Date Batch"."Posting Date");
        if T5746_lRec.FindFirst then begin
            T5746_lRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
            T5747_lRec.SetRange("Document No.", T5746_lRec."No.");
            if T5747_lRec.FindFirst then begin
                repeat
                //IF T5747_lRec."Posting Date" <> 0D THEN BEGIN
                //T5747_lRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                //T5747_lRec.MODIFY;
                //END;
                until T5747_lRec.Next = 0;
            end;
            T5746_lRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
            T5746_lRec.Modify;
        end;

        ServiceLedgerEntry_lRec.Reset;
        ServiceLedgerEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
        ServiceLedgerEntry_lRec.SetFilter("Document No.", "Update Posting Date Batch"."Document No.");
        if ServiceLedgerEntry_lRec.FindFirst then begin
            repeat
                if ServiceLedgerEntry_lRec."Posting Date" <> "Update Posting Date Batch"."New Posting Date" then begin
                    ServiceLedgerEntry_lRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                    ServiceLedgerEntry_lRec.Modify;
                end;
            until ServiceLedgerEntry_lRec.Next = 0;
        end;

        ServiceInvoiceHeader_lRec.Reset;
        ServiceInvoiceHeader_lRec.SetFilter("No.", "Update Posting Date Batch"."Document No.");
        ServiceInvoiceHeader_lRec.Setrange("Posting Date", "Update Posting Date Batch"."Posting Date");
        if ServiceInvoiceHeader_lRec.FindFirst then begin
            ServiceInvoiceHeader_lRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
            ServiceInvoiceLine_lRec.SetRange("Document No.", ServiceInvoiceHeader_lRec."No.");
            if ServiceInvoiceLine_lRec.FindFirst then begin
                repeat
                    if ServiceInvoiceLine_lRec."Posting Date" <> 0D then begin
                        ServiceInvoiceLine_lRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                        ServiceInvoiceLine_lRec.Modify;
                    end;
                until ServiceInvoiceLine_lRec.Next = 0;
                ServiceInvoiceHeader_lRec."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                ServiceInvoiceHeader_lRec.Modify;
            end;
        end;

        TCSEntry.Reset;
        TCSEntry.SetFilter("Document No.", "Update Posting Date Batch"."Document No.");
        if TCSEntry.FindFirst then begin
            repeat
                if TCSEntry."Posting Date" <> "Update Posting Date Batch"."New Posting Date" then begin
                    TCSEntry."Posting Date" := "Update Posting Date Batch"."New Posting Date";
                    TCSEntry.Modify;
                end;
            until TCSEntry.Next = 0;
        end;
        //I-I034-302003-01-NE
    end;
}
