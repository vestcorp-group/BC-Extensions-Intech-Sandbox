Report 74988 "Update Dimension Batch"
{
    //UpdateDimensionBatch
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
                  TableData "Value Entry" = rm,
                  TableData "Capacity Ledger Entry" = rm,
                  TableData "Return Shipment Header" = rm,
                  TableData "Return Shipment Line" = rm,
                  TableData "Return Receipt Header" = rm,
                  TableData "Return Receipt Line" = rm,
                  TableData "Warehouse Entry" = rm;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Update Dimension Batch"; "Update Dimension Batch")
        {
            DataItemTableView = sorting("Document No.") where(Updated = const(false));
            RequestFilterFields = "Document No.", "Posting Date";
            column(ReportForNavId_33027920; 33027920)
            {
            }

            trigger OnAfterGetRecord()
            var
                ModUpdateDimensionBatch_lRec: Record "Update Dimension Batch";
            begin
                Curr += 1;
                W.Update(2, Curr);

                "Update Dimension Batch".TestField("Document No.");
                "Update Dimension Batch".TestField("Posting Date");
                DocNoDateWiseDimUpd_gFnc("Document No.", "Posting Date");

                ModUpdateDimensionBatch_lRec.Get("Document No.");
                ModUpdateDimensionBatch_lRec.Updated := true;
                ModUpdateDimensionBatch_lRec.Modify;
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
                W.Update(1, "Update Dimension Batch".Count);
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

    trigger OnPreReport()
    begin
        GenLedSetup_gRec.Get;
    end;

    var
        W: Dialog;
        Curr: Integer;
        GenLedSetup_gRec: Record "General Ledger Setup";


    procedure DocNoDateWiseDimUpd_gFnc(DocNo_iCod: Code[20]; PostingDate_iDte: Date)
    var
        CustLedgerEntry_lRec: Record "Cust. Ledger Entry";
        DCLE_lRec: Record "Detailed Cust. Ledg. Entry";
        VendLedEntry_lRec: Record "Vendor Ledger Entry";
        DVLE_lRec: Record "Detailed Vendor Ledg. Entry";
        GLEntry_lRec: Record "G/L Entry";
        VATEntry_lRec: Record "VAT Entry";
        TDSEntry_lRec: Record "TDS Entry";
        TCSEntry_lRec: Record "TCS Entry";
        ReminderEntry_lRec: Record "Reminder/Fin. Charge Entry";
        ValueEntry_lRec: Record "Value Entry";
        ILE_lRec: Record "Item Ledger Entry";
        BankActLedEnty_lRec: Record "Bank Account Ledger Entry";
        ChkLedEntry_lRec: Record "Check Ledger Entry";
        FALedEntry_lRec: Record "FA Ledger Entry";
        MaintenanceLedgEntry_lRec: Record "Maintenance Ledger Entry";
        CapacityLedgEntry_lRec: Record "Capacity Ledger Entry";
        SalesShptHeader_lRec: Record "Sales Shipment Header";
        SalesInvHeader_lRec: Record "Sales Invoice Header";
        ReturnRcptHeader_lRec: Record "Return Receipt Header";
        SalesCrMemoHeader_lRec: Record "Sales Cr.Memo Header";
        ServShptHeader_lRec: Record "Service Shipment Header";
        ServInvHeader_lRec: Record "Service Invoice Header";
        ServCrMemoHeader_lRec: Record "Service Cr.Memo Header";
        IssuedReminderHeader_lRec: Record "Issued Reminder Header";
        IssuedFinChrgMemoHeader_lRec: Record "Issued Fin. Charge Memo Header";
        PurchRcptHeader_lRec: Record "Purch. Rcpt. Header";
        PurchInvHeader_lRec: Record "Purch. Inv. Header";
        ReturnShptHeader_lRec: Record "Return Shipment Header";
        PurchCrMemoHeader_lRec: Record "Purch. Cr. Memo Hdr.";
        ProductionOrderHeader_lRec: Record "Production Order";
        PostedAssemblyHeader_lRec: Record "Posted Assembly Header";
        TransShptHeader_lRec: Record "Transfer Shipment Header";
        TransRcptHeader_lRec: Record "Transfer Receipt Header";
        SalesShptLine_lRec: Record "Sales Shipment Line";
        SalesInvLine_lRec: Record "Sales Invoice Line";
        ReturnRcptLine_lRec: Record "Return Receipt Line";
        SalesCrMemoLine_lRec: Record "Sales Cr.Memo Line";
        ServShptLine_lRec: Record "Service Shipment Line";
        ServInvLine_lRec: Record "Service Invoice Line";
        ServCrMemoLine_lRec: Record "Service Cr.Memo Line";
        PurchRcptLine_lRec: Record "Purch. Rcpt. Line";
        PurchInvLine_lRec: Record "Purch. Inv. Line";
        ReturnShptLine_lRec: Record "Return Shipment Line";
        PurchCrMemoLine_lRec: Record "Purch. Cr. Memo Line";
        ProductionOrderLine_lRec: Record "Prod. Order Line";
        PostedAssemblyLine_lRec: Record "Posted Assembly Line";
        TransShptLine_lRec: Record "Transfer Shipment Line";
        TransRcptLine_lRec: Record "Transfer Receipt Line";
        JobLedgEntry_lRec: Record "Job Ledger Entry";
        JobWIPEntry_lRec: Record "Job WIP Entry";
        JobWIPGLEntry_lRec: Record "Job WIP G/L Entry";
        ServLedgerEntry_lRec: Record "Service Ledger Entry";
        WarrantyLedgerEntry_lRec: Record "Warranty Ledger Entry";
    begin
        if DocNo_iCod = '' then
            Error('Document No. cannot be blank');

        if PostingDate_iDte = 0D then
            Error('Posting Date cannot be blank');

        //Update Dimension Customer Led Entry
        CustLedgerEntry_lRec.Reset;
        CustLedgerEntry_lRec.SetRange("Document No.", DocNo_iCod);
        CustLedgerEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        if CustLedgerEntry_lRec.FindSet() then begin
            repeat
                UpdDim_lFnc(CustLedgerEntry_lRec."Dimension Set ID", CustLedgerEntry_lRec."Global Dimension 1 Code", CustLedgerEntry_lRec."Global Dimension 2 Code");
                CustLedgerEntry_lRec.Modify;

                DCLE_lRec.Reset;
                DCLE_lRec.SetRange("Cust. Ledger Entry No.", CustLedgerEntry_lRec."Entry No.");
                DCLE_lRec.ModifyAll("Initial Entry Global Dim. 1", CustLedgerEntry_lRec."Global Dimension 1 Code");
                DCLE_lRec.ModifyAll("Initial Entry Global Dim. 2", CustLedgerEntry_lRec."Global Dimension 2 Code");
            until CustLedgerEntry_lRec.Next = 0;
        end;

        //Update Dimension Vendor Led Entry
        VendLedEntry_lRec.Reset;
        VendLedEntry_lRec.SetRange("Document No.", DocNo_iCod);
        VendLedEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        if VendLedEntry_lRec.FindSet() then begin
            repeat
                UpdDim_lFnc(VendLedEntry_lRec."Dimension Set ID", VendLedEntry_lRec."Global Dimension 1 Code", VendLedEntry_lRec."Global Dimension 2 Code");
                VendLedEntry_lRec.Modify;

                DVLE_lRec.Reset;
                DVLE_lRec.SetRange("Vendor Ledger Entry No.", VendLedEntry_lRec."Entry No.");
                DVLE_lRec.ModifyAll("Initial Entry Global Dim. 1", VendLedEntry_lRec."Global Dimension 1 Code");
                DVLE_lRec.ModifyAll("Initial Entry Global Dim. 2", VendLedEntry_lRec."Global Dimension 2 Code");
            until VendLedEntry_lRec.Next = 0;
        end;

        //Update Dimension G/L Entry
        GLEntry_lRec.Reset;
        GLEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
        GLEntry_lRec.SetRange("Document No.", DocNo_iCod);
        GLEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        if GLEntry_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(GLEntry_lRec."Dimension Set ID", GLEntry_lRec."Global Dimension 1 Code", GLEntry_lRec."Global Dimension 2 Code");
                GLEntry_lRec.Modify;
            until GLEntry_lRec.Next = 0;
        end;

        //Update Dimension TDS Entry
        // TDSEntry_lRec.Reset;
        // TDSEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
        // TDSEntry_lRec.SetRange("Document No.", DocNo_iCod);
        // TDSEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        // if TDSEntry_lRec.FindSet then begin
        //     repeat
        //         UpdDim_lFnc(TDSEntry_lRec."Dimension Set ID", TDSEntry_lRec."Global Dimension 1 Code", TDSEntry_lRec."Global Dimension 2 Code");
        //         TDSEntry_lRec.Modify;
        //     until TDSEntry_lRec.Next = 0;
        // end;

        //Update Dimension TCS Entry
        // TCSEntry_lRec.Reset;
        // TCSEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
        // TCSEntry_lRec.SetRange("Document No.", DocNo_iCod);
        // TCSEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        // if TCSEntry_lRec.FindSet then begin
        //     repeat
        //         UpdDim_lFnc(TCSEntry_lRec."Dimension Set ID", TCSEntry_lRec."Global Dimension 1 Code", TCSEntry_lRec."Global Dimension 2 Code");
        //         TCSEntry_lRec.Modify;
        //     until TCSEntry_lRec.Next = 0;
        // end;

        // //Tax Entry
        // TaxEntry_lRec.RESET;
        // TaxEntry_lRec.SETCURRENTKEY("Document No.","Posting Date");
        // TaxEntry_lRec.SETRANGE("Document No.",DocNo_iCod);
        // TaxEntry_lRec.SETRANGE("Posting Date",PostingDate_iDte);
        // IF TaxEntry_lRec.FINDSET THEN BEGIN
        //  REPEAT
        //    UpdDim_lFnc(TaxEntry_lRec."Dimension Set ID",TaxEntry_lRec."Global Dimension 1 Code",TaxEntry_lRec."Global Dimension 2 Code");
        //    TaxEntry_lRec.MODIFY;
        //  UNTIL TaxEntry_lRec.NEXT = 0;
        // END;

        //Job Ledger Entry
        JobLedgEntry_lRec.Reset;
        JobLedgEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
        JobLedgEntry_lRec.SetRange("Document No.", DocNo_iCod);
        JobLedgEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        if JobLedgEntry_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(JobLedgEntry_lRec."Dimension Set ID", JobLedgEntry_lRec."Global Dimension 1 Code", JobLedgEntry_lRec."Global Dimension 2 Code");
                JobLedgEntry_lRec.Modify;
            until JobLedgEntry_lRec.Next = 0;
        end;

        //Job WIP Entry
        JobWIPEntry_lRec.Reset;
        JobWIPEntry_lRec.SetRange("Document No.", DocNo_iCod);
        JobWIPEntry_lRec.SetRange("WIP Posting Date", PostingDate_iDte);
        if JobWIPEntry_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(JobWIPEntry_lRec."Dimension Set ID", JobWIPEntry_lRec."Global Dimension 1 Code", JobWIPEntry_lRec."Global Dimension 2 Code");
                JobWIPEntry_lRec.Modify;
            until JobWIPEntry_lRec.Next = 0;
        end;

        //Job WIP GL Entry
        JobWIPGLEntry_lRec.Reset;
        JobWIPGLEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
        JobWIPGLEntry_lRec.SetRange("Document No.", DocNo_iCod);
        JobWIPGLEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        if JobWIPGLEntry_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(JobWIPGLEntry_lRec."Dimension Set ID", JobWIPGLEntry_lRec."Global Dimension 1 Code", JobWIPGLEntry_lRec."Global Dimension 2 Code");
                JobWIPGLEntry_lRec.Modify;
            until JobWIPGLEntry_lRec.Next = 0;
        end;

        //Update ILE
        ILE_lRec.Reset;
        ILE_lRec.SetCurrentkey("Document No.", "Posting Date");
        ILE_lRec.SetRange("Document No.", DocNo_iCod);
        ILE_lRec.SetRange("Posting Date", PostingDate_iDte);
        if ILE_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(ILE_lRec."Dimension Set ID", ILE_lRec."Global Dimension 1 Code", ILE_lRec."Global Dimension 2 Code");
                ILE_lRec.Modify;
            until ILE_lRec.Next = 0;
        end;

        //Update Dimension Value Entry
        ValueEntry_lRec.Reset;
        ValueEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
        ValueEntry_lRec.SetRange("Document No.", DocNo_iCod);
        ValueEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        if ValueEntry_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(ValueEntry_lRec."Dimension Set ID", ValueEntry_lRec."Global Dimension 1 Code", ValueEntry_lRec."Global Dimension 2 Code");
                ValueEntry_lRec.Modify;
            until ValueEntry_lRec.Next = 0;
        end;

        //Update Dimension Bank Act Led Entry
        BankActLedEnty_lRec.Reset;
        BankActLedEnty_lRec.SetCurrentkey("Document No.", "Posting Date");
        BankActLedEnty_lRec.SetRange("Document No.", DocNo_iCod);
        BankActLedEnty_lRec.SetRange("Posting Date", PostingDate_iDte);
        if BankActLedEnty_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(BankActLedEnty_lRec."Dimension Set ID", BankActLedEnty_lRec."Global Dimension 1 Code", BankActLedEnty_lRec."Global Dimension 2 Code");
                BankActLedEnty_lRec.Modify;
            until BankActLedEnty_lRec.Next = 0;
        end;

        //Update Dimension FA Led Entry
        FALedEntry_lRec.Reset;
        FALedEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
        FALedEntry_lRec.SetRange("Document No.", DocNo_iCod);
        FALedEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        if FALedEntry_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(FALedEntry_lRec."Dimension Set ID", FALedEntry_lRec."Global Dimension 1 Code", FALedEntry_lRec."Global Dimension 2 Code");
                FALedEntry_lRec.Modify;
            until FALedEntry_lRec.Next = 0;
        end;

        //Update Dimension Maintenance Ledg Entry Entry
        MaintenanceLedgEntry_lRec.Reset;
        MaintenanceLedgEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
        MaintenanceLedgEntry_lRec.SetRange("Document No.", DocNo_iCod);
        MaintenanceLedgEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        if MaintenanceLedgEntry_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(MaintenanceLedgEntry_lRec."Dimension Set ID", MaintenanceLedgEntry_lRec."Global Dimension 1 Code", MaintenanceLedgEntry_lRec."Global Dimension 2 Code");
                MaintenanceLedgEntry_lRec.Modify;
            until MaintenanceLedgEntry_lRec.Next = 0;
        end;

        //Update Dimension Cap Ledg Entry Entry
        CapacityLedgEntry_lRec.Reset;
        CapacityLedgEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
        CapacityLedgEntry_lRec.SetRange("Document No.", DocNo_iCod);
        CapacityLedgEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        if CapacityLedgEntry_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(CapacityLedgEntry_lRec."Dimension Set ID", CapacityLedgEntry_lRec."Global Dimension 1 Code", CapacityLedgEntry_lRec."Global Dimension 2 Code");
                CapacityLedgEntry_lRec.Modify;
            until CapacityLedgEntry_lRec.Next = 0;
        end;

        //Update Dimension RG23D Entry
        // RG23D_lRec.Reset;
        // RG23D_lRec.SetCurrentkey("Document No.", "Posting Date");
        // RG23D_lRec.SetRange("Document No.", DocNo_iCod);
        // RG23D_lRec.SetRange("Posting Date", PostingDate_iDte);
        // if RG23D_lRec.FindSet then begin
        //     repeat
        //         UpdDim_lFnc(RG23D_lRec."Dimension Set ID", RG23D_lRec."Shortcut Dimension 1 Code", RG23D_lRec."Shortcut Dimension 2 Code");
        //         RG23D_lRec.Modify;
        //     until RG23D_lRec.Next = 0;
        // end;

        //Update Dimension Sales Shipment Header
        SalesShptHeader_lRec.Reset;
        SalesShptHeader_lRec.SetCurrentkey("No.", "Posting Date");
        SalesShptHeader_lRec.SetRange("No.", DocNo_iCod);
        SalesShptHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if SalesShptHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(SalesShptHeader_lRec."Dimension Set ID", SalesShptHeader_lRec."Shortcut Dimension 1 Code", SalesShptHeader_lRec."Shortcut Dimension 2 Code");
                SalesShptHeader_lRec.Modify;
                SalesShptLine_lRec.SetRange("Document No.", SalesShptHeader_lRec."No.");
                if SalesShptLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(SalesShptLine_lRec."Dimension Set ID", SalesShptLine_lRec."Shortcut Dimension 1 Code", SalesShptLine_lRec."Shortcut Dimension 2 Code");
                        SalesShptLine_lRec.Modify;
                    until SalesShptLine_lRec.Next = 0;
                end;
            until SalesShptHeader_lRec.Next = 0;
        end;

        //Update Dimension Sales Invoice Header
        SalesInvHeader_lRec.Reset;
        SalesInvHeader_lRec.SetCurrentkey("No.", "Posting Date");
        SalesInvHeader_lRec.SetRange("No.", DocNo_iCod);
        SalesInvHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if SalesInvHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(SalesInvHeader_lRec."Dimension Set ID", SalesInvHeader_lRec."Shortcut Dimension 1 Code", SalesInvHeader_lRec."Shortcut Dimension 2 Code");
                SalesInvHeader_lRec.Modify;
                SalesInvLine_lRec.SetRange("Document No.", SalesInvHeader_lRec."No.");
                if SalesInvLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(SalesInvLine_lRec."Dimension Set ID", SalesInvLine_lRec."Shortcut Dimension 1 Code", SalesInvLine_lRec."Shortcut Dimension 2 Code");
                        SalesInvLine_lRec.Modify;
                    until SalesInvLine_lRec.Next = 0;
                end;
            until SalesInvHeader_lRec.Next = 0;
        end;

        //Update Dimension Return Receipt Header
        ReturnRcptHeader_lRec.Reset;
        ReturnRcptHeader_lRec.SetCurrentkey("No.", "Posting Date");
        ReturnRcptHeader_lRec.SetRange("No.", DocNo_iCod);
        ReturnRcptHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if ReturnRcptHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(ReturnRcptHeader_lRec."Dimension Set ID", ReturnRcptHeader_lRec."Shortcut Dimension 1 Code", ReturnRcptHeader_lRec."Shortcut Dimension 2 Code");
                ReturnRcptHeader_lRec.Modify;
                ReturnRcptLine_lRec.SetRange("Document No.", ReturnRcptHeader_lRec."No.");
                if ReturnRcptLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(ReturnRcptLine_lRec."Dimension Set ID", ReturnRcptLine_lRec."Shortcut Dimension 1 Code", ReturnRcptLine_lRec."Shortcut Dimension 2 Code");
                        ReturnRcptLine_lRec.Modify;
                    until ReturnRcptLine_lRec.Next = 0;
                end;
            until ReturnRcptHeader_lRec.Next = 0;
        end;

        //Update Dimension Sales Cr. Memo Header
        SalesCrMemoHeader_lRec.Reset;
        SalesCrMemoHeader_lRec.SetCurrentkey("No.", "Posting Date");
        SalesCrMemoHeader_lRec.SetRange("No.", DocNo_iCod);
        SalesCrMemoHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if SalesCrMemoHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(SalesCrMemoHeader_lRec."Dimension Set ID", SalesCrMemoHeader_lRec."Shortcut Dimension 1 Code", SalesCrMemoHeader_lRec."Shortcut Dimension 2 Code");
                SalesCrMemoHeader_lRec.Modify;
                SalesCrMemoLine_lRec.SetRange("Document No.", SalesCrMemoHeader_lRec."No.");
                if SalesCrMemoLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(SalesCrMemoLine_lRec."Dimension Set ID", SalesCrMemoLine_lRec."Shortcut Dimension 1 Code", SalesCrMemoLine_lRec."Shortcut Dimension 2 Code");
                        SalesCrMemoLine_lRec.Modify;
                    until SalesCrMemoLine_lRec.Next = 0;
                end;
            until SalesCrMemoHeader_lRec.Next = 0;
        end;

        //Update Dimension Service Cr. Memo Header
        ServCrMemoHeader_lRec.Reset;
        ServCrMemoHeader_lRec.SetCurrentkey("No.", "Posting Date");
        ServCrMemoHeader_lRec.SetRange("No.", DocNo_iCod);
        ServCrMemoHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if ServCrMemoHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(ServCrMemoHeader_lRec."Dimension Set ID", ServCrMemoHeader_lRec."Shortcut Dimension 1 Code", ServCrMemoHeader_lRec."Shortcut Dimension 2 Code");
                ServCrMemoHeader_lRec.Modify;
                ServCrMemoLine_lRec.SetRange("Document No.", ServCrMemoHeader_lRec."No.");
                if ServCrMemoLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(ServCrMemoLine_lRec."Dimension Set ID", ServCrMemoLine_lRec."Shortcut Dimension 1 Code", ServCrMemoLine_lRec."Shortcut Dimension 2 Code");
                        ServCrMemoLine_lRec.Modify;
                    until ServCrMemoLine_lRec.Next = 0;
                end;
            until ServCrMemoHeader_lRec.Next = 0;
        end;

        //Update Dimension Service Shipment Header
        ServShptHeader_lRec.Reset;
        ServShptHeader_lRec.SetCurrentkey("No.", "Posting Date");
        ServShptHeader_lRec.SetRange("No.", DocNo_iCod);
        ServShptHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if ServShptHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(ServShptHeader_lRec."Dimension Set ID", ServShptHeader_lRec."Shortcut Dimension 1 Code", ServShptHeader_lRec."Shortcut Dimension 2 Code");
                ServShptHeader_lRec.Modify;
                ServShptLine_lRec.SetRange("Document No.", ServShptHeader_lRec."No.");
                if ServShptLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(ServShptLine_lRec."Dimension Set ID", ServShptLine_lRec."Shortcut Dimension 1 Code", ServShptLine_lRec."Shortcut Dimension 2 Code");
                        ServShptLine_lRec.Modify;
                    until ServShptLine_lRec.Next = 0;
                end;
            until ServShptHeader_lRec.Next = 0;
        end;

        //Update Dimension Service Invoice Header
        ServInvHeader_lRec.Reset;
        ServInvHeader_lRec.SetCurrentkey("No.", "Posting Date");
        ServInvHeader_lRec.SetRange("No.", DocNo_iCod);
        ServInvHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if ServInvHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(ServInvHeader_lRec."Dimension Set ID", ServInvHeader_lRec."Shortcut Dimension 1 Code", ServInvHeader_lRec."Shortcut Dimension 2 Code");
                ServInvHeader_lRec.Modify;
                ServInvLine_lRec.SetRange("Document No.", ServInvHeader_lRec."No.");
                if ServInvLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(ServInvLine_lRec."Dimension Set ID", ServInvLine_lRec."Shortcut Dimension 1 Code", ServInvLine_lRec."Shortcut Dimension 2 Code");
                        ServInvLine_lRec.Modify;
                    until ServInvLine_lRec.Next = 0;
                end;
            until ServInvHeader_lRec.Next = 0;
        end;

        //Service Leagder Entry
        ServLedgerEntry_lRec.Reset;
        ServLedgerEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
        ServLedgerEntry_lRec.SetRange("Document No.", DocNo_iCod);
        ServLedgerEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        if ServLedgerEntry_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(ServLedgerEntry_lRec."Dimension Set ID", ServLedgerEntry_lRec."Global Dimension 1 Code", ServLedgerEntry_lRec."Global Dimension 2 Code");
                ServLedgerEntry_lRec.Modify;
            until ServLedgerEntry_lRec.Next = 0;
        end;

        //Warranty Ledger Entry
        WarrantyLedgerEntry_lRec.Reset;
        WarrantyLedgerEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
        WarrantyLedgerEntry_lRec.SetFilter("Document No.", DocNo_iCod);
        WarrantyLedgerEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        if WarrantyLedgerEntry_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(WarrantyLedgerEntry_lRec."Dimension Set ID", WarrantyLedgerEntry_lRec."Global Dimension 1 Code", WarrantyLedgerEntry_lRec."Global Dimension 2 Code");
                WarrantyLedgerEntry_lRec.Modify;
            until WarrantyLedgerEntry_lRec.Next = 0;
        end;

        //Update Dimension Issued Reminder Header
        IssuedReminderHeader_lRec.Reset;
        IssuedReminderHeader_lRec.SetCurrentkey("No.", "Posting Date");
        IssuedReminderHeader_lRec.SetRange("No.", DocNo_iCod);
        IssuedReminderHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if IssuedReminderHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(IssuedReminderHeader_lRec."Dimension Set ID", IssuedReminderHeader_lRec."Shortcut Dimension 1 Code", IssuedReminderHeader_lRec."Shortcut Dimension 2 Code");
                IssuedReminderHeader_lRec.Modify;
            until IssuedReminderHeader_lRec.Next = 0;
        end;

        //Update Dimension Issued Fin. Chrg. Memo Header
        IssuedFinChrgMemoHeader_lRec.Reset;
        IssuedFinChrgMemoHeader_lRec.SetCurrentkey("No.", "Posting Date");
        IssuedFinChrgMemoHeader_lRec.SetRange("No.", DocNo_iCod);
        IssuedFinChrgMemoHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if IssuedFinChrgMemoHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(IssuedFinChrgMemoHeader_lRec."Dimension Set ID", IssuedFinChrgMemoHeader_lRec."Shortcut Dimension 1 Code", IssuedFinChrgMemoHeader_lRec."Shortcut Dimension 2 Code");
                IssuedFinChrgMemoHeader_lRec.Modify;
            until IssuedFinChrgMemoHeader_lRec.Next = 0;
        end;

        //Update Dimension Purchase Receipt Header
        PurchRcptHeader_lRec.Reset;
        PurchRcptHeader_lRec.SetCurrentkey("No.", "Posting Date");
        PurchRcptHeader_lRec.SetRange("No.", DocNo_iCod);
        PurchRcptHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if PurchRcptHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(PurchRcptHeader_lRec."Dimension Set ID", PurchRcptHeader_lRec."Shortcut Dimension 1 Code", PurchRcptHeader_lRec."Shortcut Dimension 2 Code");
                PurchRcptHeader_lRec.Modify;
                PurchRcptLine_lRec.SetRange("Document No.", PurchRcptHeader_lRec."No.");
                if PurchRcptLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(PurchRcptLine_lRec."Dimension Set ID", PurchRcptLine_lRec."Shortcut Dimension 1 Code", PurchRcptLine_lRec."Shortcut Dimension 2 Code");
                        PurchRcptLine_lRec.Modify;
                    until PurchRcptLine_lRec.Next = 0;
                end;
            until PurchRcptHeader_lRec.Next = 0;
        end;

        //Update Dimension Purchase Invoice Header
        PurchInvHeader_lRec.Reset;
        PurchInvHeader_lRec.SetCurrentkey("No.", "Posting Date");
        PurchInvHeader_lRec.SetRange("No.", DocNo_iCod);
        PurchInvHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if PurchInvHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(PurchInvHeader_lRec."Dimension Set ID", PurchInvHeader_lRec."Shortcut Dimension 1 Code", PurchInvHeader_lRec."Shortcut Dimension 2 Code");
                PurchInvHeader_lRec.Modify;
                PurchInvLine_lRec.SetRange("Document No.", PurchInvHeader_lRec."No.");
                if PurchInvLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(PurchInvLine_lRec."Dimension Set ID", PurchInvLine_lRec."Shortcut Dimension 1 Code", PurchInvLine_lRec."Shortcut Dimension 2 Code");
                        PurchInvLine_lRec.Modify;
                    until PurchInvLine_lRec.Next = 0;
                end;
            until PurchInvHeader_lRec.Next = 0;
        end;

        //Update Dimension Purchase Invoice Header
        ReturnShptHeader_lRec.Reset;
        ReturnShptHeader_lRec.SetCurrentkey("No.", "Posting Date");
        ReturnShptHeader_lRec.SetRange("No.", DocNo_iCod);
        ReturnShptHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if ReturnShptHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(ReturnShptHeader_lRec."Dimension Set ID", ReturnShptHeader_lRec."Shortcut Dimension 1 Code", ReturnShptHeader_lRec."Shortcut Dimension 2 Code");
                ReturnShptHeader_lRec.Modify;
                ReturnShptLine_lRec.SetRange("Document No.", ReturnShptHeader_lRec."No.");
                if ReturnShptLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(ReturnShptLine_lRec."Dimension Set ID", ReturnShptLine_lRec."Shortcut Dimension 1 Code", ReturnShptLine_lRec."Shortcut Dimension 2 Code");
                        ReturnShptLine_lRec.Modify;
                    until ReturnShptLine_lRec.Next = 0;
                end;
            until ReturnShptHeader_lRec.Next = 0;
        end;

        //Update Dimension Purchase Cr. Memo Header
        PurchCrMemoHeader_lRec.Reset;
        PurchCrMemoHeader_lRec.SetCurrentkey("No.", "Posting Date");
        PurchCrMemoHeader_lRec.SetRange("No.", DocNo_iCod);
        PurchCrMemoHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if PurchCrMemoHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(PurchCrMemoHeader_lRec."Dimension Set ID", PurchCrMemoHeader_lRec."Shortcut Dimension 1 Code", PurchCrMemoHeader_lRec."Shortcut Dimension 2 Code");
                PurchCrMemoHeader_lRec.Modify;
                PurchCrMemoLine_lRec.SetRange("Document No.", PurchCrMemoHeader_lRec."No.");
                if PurchCrMemoLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(PurchCrMemoLine_lRec."Dimension Set ID", PurchCrMemoLine_lRec."Shortcut Dimension 1 Code", PurchCrMemoLine_lRec."Shortcut Dimension 2 Code");
                        PurchCrMemoLine_lRec.Modify;
                    until PurchCrMemoLine_lRec.Next = 0;
                end;
            until PurchCrMemoHeader_lRec.Next = 0;
        end;

        //Update Dimension Posted Assembly Header
        PostedAssemblyHeader_lRec.Reset;
        PostedAssemblyHeader_lRec.SetCurrentkey("No.", "Posting Date");
        PostedAssemblyHeader_lRec.SetRange("No.", DocNo_iCod);
        PostedAssemblyHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if PostedAssemblyHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(PostedAssemblyHeader_lRec."Dimension Set ID", PostedAssemblyHeader_lRec."Shortcut Dimension 1 Code", PostedAssemblyHeader_lRec."Shortcut Dimension 2 Code");
                PostedAssemblyHeader_lRec.Modify;
                PostedAssemblyLine_lRec.SetRange("Document No.", PostedAssemblyHeader_lRec."No.");
                if PostedAssemblyLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(PostedAssemblyLine_lRec."Dimension Set ID", PostedAssemblyLine_lRec."Shortcut Dimension 1 Code", PostedAssemblyLine_lRec."Shortcut Dimension 2 Code");
                        PostedAssemblyLine_lRec.Modify;
                    until PostedAssemblyLine_lRec.Next = 0;
                end;
            until PostedAssemblyHeader_lRec.Next = 0;
        end;

        //Update Dimension Transfer Shipment Header
        TransShptHeader_lRec.Reset;
        TransShptHeader_lRec.SetCurrentkey("No.", "Posting Date");
        TransShptHeader_lRec.SetRange("No.", DocNo_iCod);
        TransShptHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if TransShptHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(TransShptHeader_lRec."Dimension Set ID", TransShptHeader_lRec."Shortcut Dimension 1 Code", TransShptHeader_lRec."Shortcut Dimension 2 Code");
                TransShptHeader_lRec.Modify;
                TransShptLine_lRec.SetRange("Document No.", TransShptHeader_lRec."No.");
                if TransShptLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(TransShptLine_lRec."Dimension Set ID", TransShptLine_lRec."Shortcut Dimension 1 Code", TransShptLine_lRec."Shortcut Dimension 2 Code");
                        TransShptLine_lRec.Modify;
                    until TransShptLine_lRec.Next = 0;
                end;
            until TransShptHeader_lRec.Next = 0;
        end;

        //Update Dimension Transfer Receipt Header
        TransRcptHeader_lRec.Reset;
        TransRcptHeader_lRec.SetCurrentkey("No.", "Posting Date");
        TransRcptHeader_lRec.SetRange("No.", DocNo_iCod);
        TransRcptHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if TransRcptHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(TransRcptHeader_lRec."Dimension Set ID", TransRcptHeader_lRec."Shortcut Dimension 1 Code", TransRcptHeader_lRec."Shortcut Dimension 2 Code");
                TransRcptHeader_lRec.Modify;
                TransRcptLine_lRec.SetRange("Document No.", TransRcptHeader_lRec."No.");
                if TransRcptLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(TransRcptLine_lRec."Dimension Set ID", TransRcptLine_lRec."Shortcut Dimension 1 Code", TransRcptLine_lRec."Shortcut Dimension 2 Code");
                        TransRcptLine_lRec.Modify;
                    until TransRcptLine_lRec.Next = 0;
                end;
            until TransRcptHeader_lRec.Next = 0;
        end;
    end;


    procedure UpdDim_lFnc(var OldDimSetID_vInt: Integer; var FieldGD1_vCod: Code[20]; var FieldGD2_vCod: Code[20])
    var
        DimChngMgt_lCdu: Codeunit "INTGEN_Dimension Changes Mgt";
        TmpDimSetID_lRecTmp: Record "Dimension Set Entry" temporary;
    begin
        TmpDimSetID_lRecTmp.Reset;
        TmpDimSetID_lRecTmp.DeleteAll;

        Clear(DimChngMgt_lCdu);
        DimChngMgt_lCdu.FillDimSetEntry_gFnc(OldDimSetID_vInt, TmpDimSetID_lRecTmp);

        if "Update Dimension Batch"."Shortcut Dimension 1 Code" <> '' then
            DimChngMgt_lCdu.UpdateDimSetEntry_gFnc(TmpDimSetID_lRecTmp, GenLedSetup_gRec."Global Dimension 1 Code", "Update Dimension Batch"."Shortcut Dimension 1 Code");

        if "Update Dimension Batch"."Shortcut Dimension 2 Code" <> '' then
            DimChngMgt_lCdu.UpdateDimSetEntry_gFnc(TmpDimSetID_lRecTmp, GenLedSetup_gRec."Global Dimension 2 Code", "Update Dimension Batch"."Shortcut Dimension 2 Code");

        if "Update Dimension Batch"."Shortcut Dimension 3 Code" <> '' then
            DimChngMgt_lCdu.UpdateDimSetEntry_gFnc(TmpDimSetID_lRecTmp, GenLedSetup_gRec."Shortcut Dimension 3 Code", "Update Dimension Batch"."Shortcut Dimension 3 Code");

        if "Update Dimension Batch"."Shortcut Dimension 4 Code" <> '' then
            DimChngMgt_lCdu.UpdateDimSetEntry_gFnc(TmpDimSetID_lRecTmp, GenLedSetup_gRec."Shortcut Dimension 4 Code", "Update Dimension Batch"."Shortcut Dimension 4 Code");

        if "Update Dimension Batch"."Shortcut Dimension 5 Code" <> '' then
            DimChngMgt_lCdu.UpdateDimSetEntry_gFnc(TmpDimSetID_lRecTmp, GenLedSetup_gRec."Shortcut Dimension 5 Code", "Update Dimension Batch"."Shortcut Dimension 5 Code");

        if "Update Dimension Batch"."Shortcut Dimension 6 Code" <> '' then
            DimChngMgt_lCdu.UpdateDimSetEntry_gFnc(TmpDimSetID_lRecTmp, GenLedSetup_gRec."Shortcut Dimension 6 Code", "Update Dimension Batch"."Shortcut Dimension 6 Code");

        if "Update Dimension Batch"."Shortcut Dimension 7 Code" <> '' then
            DimChngMgt_lCdu.UpdateDimSetEntry_gFnc(TmpDimSetID_lRecTmp, GenLedSetup_gRec."Shortcut Dimension 7 Code", "Update Dimension Batch"."Shortcut Dimension 7 Code");

        if "Update Dimension Batch"."Shortcut Dimension 8 Code" <> '' then
            DimChngMgt_lCdu.UpdateDimSetEntry_gFnc(TmpDimSetID_lRecTmp, GenLedSetup_gRec."Shortcut Dimension 8 Code", "Update Dimension Batch"."Shortcut Dimension 8 Code");

        OldDimSetID_vInt := DimChngMgt_lCdu.GetDimensionSetID_gFnc(TmpDimSetID_lRecTmp);
        DimChngMgt_lCdu.UpdGlobalDimFromSetID_gFnc(OldDimSetID_vInt, FieldGD1_vCod, FieldGD2_vCod);
    end;
}
