report 85208 "Ledger cum Payment Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Description = 'T50566';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = where("Document Type" = filter('Invoice'));
            trigger OnPreDataItem()
            begin
                Window_gDlg.UPDATE(1, COUNT);
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                Curr_gInt += 1;
                Window_gDlg.UPDATE(2, Curr_gInt);
                Clear(GSTAmount_gDec);
                Clear(TDSAmount_gDec);
                if "Vendor Ledger Entry"."Document Type" = "Vendor Ledger Entry"."Document Type"::Invoice then begin
                    Clear(GSTAmount_gDec);
                    DetailedGSTLedEntry_gRec.Reset();
                    DetailedGSTLedEntry_gRec.SetRange("Document No.", "Vendor Ledger Entry"."Document No.");
                    DetailedGSTLedEntry_gRec.SetRange("Posting Date", "Vendor Ledger Entry"."Posting Date");
                    DetailedGSTLedEntry_gRec.CalcSums("GST Amount");
                    //if DetailedGSTLedEntry_gRec.FindFirst() then begin
                    GSTAmount_gDec := DetailedGSTLedEntry_gRec."GST Amount";
                    //end;
                    Clear(TDSAmount_gDec);
                    TDSEntry_gRec.Reset();
                    TDSEntry_gRec.SetRange("Document No.", "Vendor Ledger Entry"."Document No.");
                    TDSEntry_gRec.SetRange("Posting Date", "Vendor Ledger Entry"."Posting Date");
                    TDSEntry_gRec.CalcSums("TDS Amount", "TDS Base Amount");
                    //if TDSEntry_gRec.FindFirst() then begin
                    TDSAmount_gDec := TDSEntry_gRec."TDS Amount";
                    //End;

                    //GetVendAppledEntry_lFnc("Vendor Ledger Entry");
                    //MakeExcelDataBody_lFnc();

                end else begin
                    if "Vendor Ledger Entry".Open then begin
                        Clear(GSTAmount_gDec);
                        DetailedGSTLedEntry_gRec.Reset();
                        DetailedGSTLedEntry_gRec.SetRange("Document No.", "Vendor Ledger Entry"."Document No.");
                        DetailedGSTLedEntry_gRec.SetRange("Posting Date", "Vendor Ledger Entry"."Posting Date");
                        DetailedGSTLedEntry_gRec.CalcSums("GST Amount");
                        //if DetailedGSTLedEntry_gRec.FindFirst() then begin
                        GSTAmount_gDec := DetailedGSTLedEntry_gRec."GST Amount";
                        //end;
                        Clear(TDSAmount_gDec);
                        TDSEntry_gRec.Reset();
                        TDSEntry_gRec.SetRange("Document No.", "Vendor Ledger Entry"."Document No.");
                        TDSEntry_gRec.SetRange("Posting Date", "Vendor Ledger Entry"."Posting Date");
                        TDSEntry_gRec.CalcSums("TDS Amount", "TDS Base Amount");
                        //if TDSEntry_gRec.FindFirst() then begin
                        TDSAmount_gDec := TDSEntry_gRec."TDS Amount";
                        //End;
                        // GetVendAppledEntry_lFnc("Vendor Ledger Entry");

                    end;
                end;
                MakeExcelDataBody_lFnc();
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }


    }
    trigger OnPostReport()
    begin
        CreateExcelBook_lFnc();

        Window_gDlg.CLOSE;
        Message('Data exported in Excel successfully');


    end;

    trigger OnPreReport()
    begin
        Window_gDlg.OPEN('Total...\#1##################\#2##################\');

        ExcelBuffer_gRecTmp.Reset();
        ExcelBuffer_gRecTmp.DeleteAll();

        MakeExcelDataInfo_lFnc();
    end;

    local procedure CreateExcelBook_lFnc()
    begin
        ExcelBuffer_gRecTmp.CreateNewBook('Ledger cum Payment Report');
        ExcelBuffer_gRecTmp.WriteSheet('Ledger cum Payment Report', CompanyName, UserId);
        ExcelBuffer_gRecTmp.SetFriendlyFilename('Ledger cum Payment Report');
        ExcelBuffer_gRecTmp.CloseBook();
        ExcelBuffer_gRecTmp.OpenExcel();
        Error('');
    end;




    local procedure MakeExcelDataInfo_lFnc()
    begin
        ExcelBuffer_gRecTmp.SetUseInfoSheet();
        ExcelBuffer_gRecTmp.AddInfoColumn(Format(Text002), false, true, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddInfoColumn(COMPANYNAME, false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddInfoColumn(Format(Text003), false, true, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddInfoColumn(Report::"Ledger cum Payment Report", false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddInfoColumn(Format(Text005), false, true, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddInfoColumn(UserId, false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddInfoColumn(Format(Text006), false, true, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddInfoColumn(Today, false, false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
        ExcelBuffer_gRecTmp.ClearNewRow();
        MakeExcelDataHeader_lFnc();
    end;

    local procedure MakeExcelDataHeader_lFnc()
    begin
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddColumn('Company :' + CompanyName, false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddColumn('Posting Date', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Document Date', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Document Type', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Document No.', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('External Document No.', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Vendor No.', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Vendor Name', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Description', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Base Amount', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('GST/Tax', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Total Amount', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('TDS Amount', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Amount Payable', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Credit Note No', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('External Credit Note No.', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('CN Document date', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Credit Note Amount', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Payment Document No', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Payment Date', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Amount Paid', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('NEFT No.', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('Remaining Amount', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('PO Number', false, '', true, false, true, '', ExcelBuffer_gRecTmp."cell type"::Text);
    end;

    local procedure MakeExcelDataBody_lFnc()
    begin
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry"."Posting Date", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry"."Document Date", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry"."Document Type", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry"."Document No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry"."External Document No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry"."Vendor No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry"."Vendor Name", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry".Description, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        "Vendor Ledger Entry".CalcFields(Amount, "Remaining Amount", "Amount (LCY)");
        ExcelBuffer_gRecTmp.AddColumn(Abs("Vendor Ledger Entry"."Purchase (LCY)"), false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(GSTAmount_gDec, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(Abs("Vendor Ledger Entry"."Amount (LCY)"), false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(TDSAmount_gDec, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        ExcelBuffer_gRecTmp.AddColumn(Abs("Vendor Ledger Entry"."Amount (LCY)") - TDSAmount_gDec, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        GetVendAppledEntry_lFnc("Vendor Ledger Entry");
        // if AppliedVendorLedEntry_gRec."Document Type" IN [AppliedVendorLedEntry_gRec."Document Type"::"Credit Memo", AppliedVendorLedEntry_gRec."Document Type"::" "] then begin
        //     ExcelBuffer_gRecTmp.AddColumn(AppliedVendorLedEntry_gRec."Document No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        //     ExcelBuffer_gRecTmp.AddColumn(AppliedVendorLedEntry_gRec."External Document No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        //     ExcelBuffer_gRecTmp.AddColumn(AppliedVendorLedEntry_gRec."Posting Date", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
        //     ExcelBuffer_gRecTmp.AddColumn(AppliedVendorLedEntry_gRec.Amount, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        // End else begin
        //     ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        //     ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        //     ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        //     ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        // end;
        // if AppliedVendorLedEntry_gRec."Document Type" = AppliedVendorLedEntry_gRec."Document Type"::Payment then begin
        //     ExcelBuffer_gRecTmp.AddColumn(AppliedVendorLedEntry_gRec."Document No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        //     ExcelBuffer_gRecTmp.AddColumn(AppliedVendorLedEntry_gRec."Posting Date", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
        //     ExcelBuffer_gRecTmp.AddColumn(AppliedVendorLedEntry_gRec.Amount, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        //     ExcelBuffer_gRecTmp.AddColumn(AppliedVendorLedEntry_gRec."NEFT No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        // End else begin
        //     ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        //     ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        //     ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        //     ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        // End;
        if (PaymentCounter > 0) and (CrMemoCounter = 0) then begin
            ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
            ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
            ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
            ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        end;
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry"."Remaining Amount" * -1, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
        Clear(PurchRcptHdr_gRec);
        PurchaseInvLine_gRec.Reset();
        PurchaseInvLine_gRec.SetRange("Document No.", "Vendor Ledger Entry"."Document No.");
        PurchaseInvLine_gRec.SetFilter("Receipt No.", '<>%1', '');
        if PurchaseInvLine_gRec.FindFirst() then begin
            if PurchRcptHdr_gRec.Get(PurchaseInvLine_gRec."Receipt No.") then;
        end;
        ExcelBuffer_gRecTmp.AddColumn(PurchRcptHdr_gRec."Order No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
    end;

    local procedure GetVendAppledEntry_lFnc(VAR VendLedgEntry_vRec: Record "Vendor Ledger Entry");
    var
        VLE_lRec: Record "Vendor Ledger Entry";
        DVendLedEntry_lRec: Record "Detailed Vendor Ledg. Entry";
        DtldCustLedgEntry1: Record "Detailed Vendor Ledg. Entry";
        ApplAmount_lDec: Decimal;

    begin
        Clear(VLE_lRec);
        if VLE_lRec.get(VendLedgEntry_vRec."Entry No.") then;

        if VLE_lRec."Entry No." <> 0 then begin
            Clear(AppliedVendorLedEntry_gRec);
            FindApplnEntriesDtldtLedgEntry(VLE_lRec);
            AppliedVendorLedEntry_gRec.SetCurrentkey("Entry No.");
            AppliedVendorLedEntry_gRec.SetRange("Entry No.");

            if VLE_lRec."Closed by Entry No." <> 0 then begin
                AppliedVendorLedEntry_gRec."Entry No." := VLE_lRec."Closed by Entry No.";
                AppliedVendorLedEntry_gRec.Mark(true);
            end;
            Clear(PaymentCounter);
            Clear(CrMemoCounter);
            AppliedVendorLedEntry_gRec.SetCurrentkey("Closed by Entry No.");
            AppliedVendorLedEntry_gRec.SetRange("Closed by Entry No.", VLE_lRec."Entry No.");
            if AppliedVendorLedEntry_gRec.Find('-') then
                repeat
                    AppliedVendorLedEntry_gRec.Mark(true);
                until AppliedVendorLedEntry_gRec.Next = 0;

            AppliedVendorLedEntry_gRec.SetCurrentkey("Entry No.");
            AppliedVendorLedEntry_gRec.SetRange("Closed by Entry No.");
        end;


        AppliedVendorLedEntry_gRec.MarkedOnly(true);
        AppliedVendorLedEntry_gRec.SetCurrentKey("Document Type");
        AppliedVendorLedEntry_gRec.SetAscending("Document Type", false);
        //AppliedVendorLedEntry_gRec.SetCurrentKey("Amount (LCY)");
        AppliedVendorLedEntry_gRec.SetFilter("Document Type", '<>%1', AppliedVendorLedEntry_gRec."Document Type"::Invoice);
        if AppliedVendorLedEntry_gRec.FindSet() then begin //VJ 040825
            repeat
                DVendLedEntry_lRec.Reset();
                DVendLedEntry_lRec.SetRange("Entry Type", DVendLedEntry_lRec."Entry Type"::Application);
                DVendLedEntry_lRec.SetRange("Vendor Ledger Entry No.", VendLedgEntry_vRec."Entry No.");
                if DVendLedEntry_lRec.FindSet() then
                    DVendLedEntry_lRec.CalcSums("Amount (LCY)");
                AppliedVendorLedEntry_gRec.CalcFields(Amount);
                // Clear(DtldCustLedgEntry1);
                // DtldCustLedgEntry1.SetCurrentkey("Vendor Ledger Entry No.");
                // DtldCustLedgEntry1.SetRange("Vendor Ledger Entry No.", AppliedVendorLedEntry_gRec."Entry No.");
                // DtldCustLedgEntry1.SetRange(Unapplied, false);
                // //DtldCustLedgEntry1.SetFilter("Document Type", '%1|%2', DtldCustLedgEntry1."Document Type"::Payment, DtldCustLedgEntry1."Document Type"::Refund);
                // DtldCustLedgEntry1.SetRange("Entry Type", DtldCustLedgEntry1."Entry Type"::Application);
                // if DtldCustLedgEntry1.Find('-') then begin
                //     VLE_lRec."Posting Date" := DtldCustLedgEntry1."Posting Date";
                // end;
                // VLE_lRec.Modify();
                //MakeExcelDataBody_lFnc();
                //if AppliedVendorLedEntry_gRec."Document Type" IN [AppliedVendorLedEntry_gRec."Document Type"::"Credit Memo", AppliedVendorLedEntry_gRec."Document Type"::" "] then begin
                if AppliedVendorLedEntry_gRec."Document Type" = AppliedVendorLedEntry_gRec."Document Type"::"Credit Memo" then begin
                    PaymentCounter += 1;
                    if PaymentCounter = 1 then begin
                        ExcelBuffer_gRecTmp.AddColumn(AppliedVendorLedEntry_gRec."Document No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                        ExcelBuffer_gRecTmp.AddColumn(AppliedVendorLedEntry_gRec."External Document No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                        ExcelBuffer_gRecTmp.AddColumn(AppliedVendorLedEntry_gRec."Posting Date", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
                        ExcelBuffer_gRecTmp.AddColumn(AppliedVendorLedEntry_gRec.Amount * -1, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
                    end else begin
                        CreateBlankLines();
                        ExcelBuffer_gRecTmp.AddColumn(AppliedVendorLedEntry_gRec."Document No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                        ExcelBuffer_gRecTmp.AddColumn(AppliedVendorLedEntry_gRec."External Document No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                        ExcelBuffer_gRecTmp.AddColumn(AppliedVendorLedEntry_gRec."Posting Date", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
                        ExcelBuffer_gRecTmp.AddColumn(AppliedVendorLedEntry_gRec.Amount * -1, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
                    end;
                    // End else begin
                    //     ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                    //     ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                    //     ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                    //     ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                    // end;

                End else if AppliedVendorLedEntry_gRec."Document Type" IN [AppliedVendorLedEntry_gRec."Document Type"::Payment, AppliedVendorLedEntry_gRec."Document Type"::" "] then begin
                    CrMemoCounter += 1;
                    if CrMemoCounter = 1 then begin
                        if PaymentCounter < 1 then begin
                            ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                            ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                            ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                            ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                        end;

                        ExcelBuffer_gRecTmp.AddColumn(AppliedVendorLedEntry_gRec."Document No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                        ExcelBuffer_gRecTmp.AddColumn(AppliedVendorLedEntry_gRec."Posting Date", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
                        ExcelBuffer_gRecTmp.AddColumn(DVendLedEntry_lRec."Amount (LCY)", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
                        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                    end else begin
                        CreateBlankLinesPayment();
                        ExcelBuffer_gRecTmp.AddColumn(AppliedVendorLedEntry_gRec."Document No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                        ExcelBuffer_gRecTmp.AddColumn(AppliedVendorLedEntry_gRec."Posting Date", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
                        ExcelBuffer_gRecTmp.AddColumn(DVendLedEntry_lRec."Amount (LCY)", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Number);
                        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                    end;
                    // End else begin
                    //     ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                    //     ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                    //     ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                    //     ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);

                End else begin
                    ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                    ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                    ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                    ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                    ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                    ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                    ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
                    ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);

                end;
            //end;
            until AppliedVendorLedEntry_gRec.Next = 0;

        end else begin
            ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
            ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
            ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
            ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
            ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
            ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
            ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
            ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);

        end;
    end;

    local procedure FindApplnEntriesDtldtLedgEntry(VLE_iRec: Record "Vendor Ledger Entry")
    var
        DtldCustLedgEntry1: Record "Detailed Vendor Ledg. Entry";
        DtldCustLedgEntry2: Record "Detailed Vendor Ledg. Entry";
    begin
        DtldCustLedgEntry1.SetCurrentkey("Vendor Ledger Entry No.");
        DtldCustLedgEntry1.SetRange("Vendor Ledger Entry No.", VLE_iRec."Entry No.");
        DtldCustLedgEntry1.SetRange(Unapplied, false);
        if DtldCustLedgEntry1.Find('-') then begin
            repeat
                if DtldCustLedgEntry1."Vendor Ledger Entry No." =
                  DtldCustLedgEntry1."Applied Vend. Ledger Entry No."
                then begin
                    DtldCustLedgEntry2.Init;
                    DtldCustLedgEntry2.SetCurrentkey("Applied Vend. Ledger Entry No.", "Entry Type");
                    DtldCustLedgEntry2.SetRange(
                      "Applied Vend. Ledger Entry No.", DtldCustLedgEntry1."Applied Vend. Ledger Entry No.");
                    DtldCustLedgEntry2.SetRange("Entry Type", DtldCustLedgEntry2."entry type"::Application);
                    DtldCustLedgEntry2.SetRange(Unapplied, false);
                    if DtldCustLedgEntry2.Find('-') then begin
                        repeat
                            if DtldCustLedgEntry2."Vendor Ledger Entry No." <>
                              DtldCustLedgEntry2."Applied Vend. Ledger Entry No."
                            then begin
                                AppliedVendorLedEntry_gRec.SetCurrentkey("Entry No.");
                                AppliedVendorLedEntry_gRec.SetRange("Entry No.", DtldCustLedgEntry2."Vendor Ledger Entry No.");
                                if AppliedVendorLedEntry_gRec.Find('-') then
                                    AppliedVendorLedEntry_gRec.Mark(true);
                            end;
                        until DtldCustLedgEntry2.Next = 0;
                    end;
                end else begin
                    AppliedVendorLedEntry_gRec.SetCurrentkey("Entry No.");
                    AppliedVendorLedEntry_gRec.SetRange("Entry No.", DtldCustLedgEntry1."Applied Vend. Ledger Entry No.");
                    if AppliedVendorLedEntry_gRec.Find('-') then
                        AppliedVendorLedEntry_gRec.Mark(true);
                end;
            until DtldCustLedgEntry1.Next = 0;
        end;
    end;

    var
        ExcelBuffer_gRecTmp: Record "Excel Buffer";
        Window_gDlg: Dialog;
        Curr_gInt: Integer;
        Text002: label 'Company Name';
        PaymentCounter, CrMemoCounter : Integer;

    local procedure CreateBlankLines()
    begin
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry"."Posting Date", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry"."Document Date", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry"."Document Type", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry"."Document No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry"."External Document No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry"."Vendor No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry"."Vendor Name", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry".Description, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        //"Vendor Ledger Entry".CalcFields(Amount, "Remaining Amount", "Amount (LCY)");
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
    end;

    local procedure CreateBlankLinesPayment()
    begin
        ExcelBuffer_gRecTmp.NewRow();
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry"."Posting Date", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry"."Document Date", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Date);
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry"."Document Type", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry"."Document No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry"."External Document No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry"."Vendor No.", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry"."Vendor Name", false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn("Vendor Ledger Entry".Description, false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        //"Vendor Ledger Entry".CalcFields(Amount, "Remaining Amount", "Amount (LCY)");
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
        ExcelBuffer_gRecTmp.AddColumn('', false, '', false, false, false, '', ExcelBuffer_gRecTmp."cell type"::Text);
    end;

    var
        Text003: label 'Report No.';
        Text005: label 'User ID';
        Text006: label 'Date';
        StartDate_gDte: Date;
        EndDate_gDte: Date;
        AppliedVendorLedEntry_gRec: Record "Vendor Ledger Entry";
        DetailedGSTLedEntry_gRec: Record "Detailed GST Ledger Entry";
        TDSEntry_gRec: Record "TDS Entry";
        Narration_gTxt: Text;
        Vendor_gRec: Record Vendor;
        PurchRcptHdr_gRec: Record "Purch. Rcpt. Header";
        PurchaseInvLine_gRec: Record "Purch. Inv. Line";
        GSTAmount_gDec: Decimal;
        TDSAmount_gDec: Decimal;

}