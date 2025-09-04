report 50009 ReceiptVoucher
{
    Caption = 'Receipt Voucher';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Receipt_Voucher.rdl';
    dataset
    {
        dataitem(GLEntry; "G/L Entry")
        {
            DataItemTableView = sorting("Entry No.");
            RequestFilterFields = "Document No.";

            column(Companyinfo_gRec_Name; Companyinfo_gRec.Name) { }
            column(Source_Code; "Source Code") { }
            column(Document_No_; "Document No.") { }
            column(Posting_Date; "Posting Date") { }
            column(G_L_Account_No_; "G/L Account No.") { }
            column(G_L_Account_Name; "G/L Account Name") { }
            column(Description; Description) { }
            column(Source_Currency_Code; CurrencDesc) { }
            column(Source_Currency_Amount; CurrenAmmt_gDec) { }
            column(Debit_Amount; "Debit Amount") { }
            column(Credit_Amount; "Credit Amount") { }
            column(SRNo_gInt; SRNo_gInt) { }
            column(Amount; Abs(Amount)) { }
            column(AmountInWords; AmountInWords) { }
            column(Transaction_No_; "Transaction No.") { }
            column(Entry_No_; "Entry No.") { }
            column(TotalAmt_gDec; TotalAmt_gDec) { }
            column(DocNo_gTxt; DocNo_gTxt) { }
            column(Reporttitle_gTxt; Reporttitle_gTxt) { }

            trigger OnPreDataItem()
            begin
                SRNo_gInt := 0;
            end;

            trigger OnAfterGetRecord()
            var
                GLSetup_lRec: Record "General Ledger Setup";
                RepCheck: Report Check_IN;
            begin
                SRNo_gInt += 1;
                CurrencDesc := '';

                Reporttitle_gTxt := '';

                if GLEntry."Source Code" = 'CASHRECJNL' then
                    Reporttitle_gTxt := 'Receipt Voucher';

                // if (GLEntry."Source Code" <> 'PAYMENTJNL') AND (GLEntry."Source Code" <> 'CASHRECJNL') then
                //     CurrReport.Skip();

                if "Posting Date" <> "Posting Date" then begin
                    "Posting Date" := "Posting Date";
                    TotalAmt_gDec := 0;
                end;

                GLSetup_lRec.Get();
                if GLEntry."Source Currency Code" = '' then begin
                    CurrencDesc := GLSetup_lRec."LCY Code";
                    CurrenAmmt_gDec := GLEntry.Amount;
                end else begin
                    CurrencDesc := GLEntry."Source Currency Code";
                    CurrenAmmt_gDec := GLEntry."Source Currency Amount";
                end;
                TotalAmt_gDec += "Debit Amount";


                RepCheck.InitTextVariable();
                IF GLEntry."Source Currency Code" <> '' then
                    RepCheck.FormatNoText(NoText, ROUND(TotalAmt_gDec, 0.01), GLEntry."Source Currency Code")
                else
                    RepCheck.FormatNoText(NoText, ROUND(TotalAmt_gDec, 0.01), '');
                AmountInWords := NoText[1];


                Clear(DocNo_gTxt);
                // if GLEntry."Source Type" = GLEntry."Source Type"::Vendor then begin
                //     VendorLedgerEntry_gRec.Reset();
                //     VendorLedgerEntry_gRec.SetRange("Document Type", "Document Type"::Payment);
                //     VendorLedgerEntry_gRec.SetRange("Document No.", "Document No.");
                //     if VendorLedgerEntry_gRec.FindFirst() then begin
                //         FindPurchaseDocumentNo_lFnc(VendorLedgerEntry_gRec);
                //     end;
                // end else begin
                if GLEntry."Source Type" = GLEntry."Source Type"::Customer then begin
                    CustomerLedgerEntry_gRec.Reset();
                    CustomerLedgerEntry_gRec.SetRange("Document Type", "Document Type"::Payment);
                    CustomerLedgerEntry_gRec.SetRange("Document No.", "Document No.");
                    if CustomerLedgerEntry_gRec.FindFirst() then begin
                        FindSalesDocumentNo_lFnc(CustomerLedgerEntry_gRec);
                    end;
                end;
            end;


            // end;


        }
    }
    labels
    {
        Reporttitle_lbl = 'Payment Voucher';
        VoucherNo_lbl = 'Voucher No.';
        PostingDte_lbl = 'Posting Date';
        SN_lbl = 'SN';
        AcctNo_lbl = 'A/C Code';
        AcctName_lbl = 'Account Name';
        Appliedto_lbl = 'Applied to';
        Desc_lbl = 'Description';
        Cur_lbl = 'CUR';
        Ammount_lbl = 'Amount';
        Exch_lbl = 'Exch.';
        Debit_lbl = 'Debit(LCY)';
        Credit_lbl = 'Credit(LCY)';
        Preparedby_lbl = 'Prepared By';
        CheckedBy_lbl = 'Checked By';
        Authorised_lbl = 'Authorised By';
        totalAmtinlcur_lbl = 'Total Amount in Local Currency:';




    }
    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //             }
    //         }
    //     }
    //     actions
    //     {
    //         area(Processing)
    //         {
    //         }
    //     }
    // }

    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        Companyinfo_gRec.Get;
        // Companyinfo_gRec.CalcFields(Picture);
    end;

    Local procedure FindSalesDocumentNo_lFnc(CustLedEntry: Record "Cust. Ledger Entry")
    var
        DtldCustLedgEntry1: Record "Detailed Cust. Ledg. Entry";
        DtldCustLedgEntry2: Record "Detailed Cust. Ledg. Entry";
        CLE_lRec1: Record "Cust. Ledger Entry";
    begin
        // Clear(DocNo_gTxt);

        DtldCustLedgEntry1.SetCurrentKey("Cust. Ledger Entry No.");
        DtldCustLedgEntry1.SetRange("Cust. Ledger Entry No.", CustLedEntry."Entry No.");
        DtldCustLedgEntry1.SetRange(Unapplied, false);
        if DtldCustLedgEntry1.Find('-') then
            repeat
                if DtldCustLedgEntry1."Cust. Ledger Entry No." =
                   DtldCustLedgEntry1."Applied Cust. Ledger Entry No."
                then begin
                    DtldCustLedgEntry2.Init();
                    DtldCustLedgEntry2.SetCurrentKey("Applied Cust. Ledger Entry No.", "Entry Type");
                    DtldCustLedgEntry2.SetRange(
                      "Applied Cust. Ledger Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                    DtldCustLedgEntry2.SetRange("Entry Type", DtldCustLedgEntry2."Entry Type"::Application);
                    DtldCustLedgEntry2.SetRange(Unapplied, false);
                    if DtldCustLedgEntry2.Find('-') then
                        repeat
                            if DtldCustLedgEntry2."Cust. Ledger Entry No." <>
                               DtldCustLedgEntry2."Applied Cust. Ledger Entry No."
                            then begin
                                CLE_lRec1.Reset();
                                CLE_lRec1.SetCurrentKey("Entry No.");
                                CLE_lRec1.SetRange("Entry No.", DtldCustLedgEntry2."Cust. Ledger Entry No.");
                                if CLE_lRec1.Find('-') then begin
                                    repeat
                                        if CLE_lRec1."Document Type" = CLE_lRec1."Document Type"::Invoice then
                                            if DocNo_gTxt <> '' then begin
                                                DocNo_gTxt := DocNo_gTxt + '|' + CLE_lRec1."Document No."
                                            end else
                                                DocNo_gTxt := CLE_lRec1."Document No.";

                                    until CLE_lRec1.next = 0;
                                end;
                            end;
                        until DtldCustLedgEntry2.Next() = 0;
                end else begin
                    CLE_lRec1.SetCurrentKey("Entry No.");
                    CLE_lRec1.SetRange("Entry No.", DtldCustLedgEntry1."Applied Cust. Ledger Entry No.");
                    if CLE_lRec1.Find('-') then begin
                        repeat
                            if CLE_lRec1."Document Type" = CLE_lRec1."Document Type"::Invoice then
                                if DocNo_gTxt <> '' then begin
                                    DocNo_gTxt := DocNo_gTxt + '|' + CLE_lRec1."Document No."
                                end else
                                    DocNo_gTxt := CLE_lRec1."Document No.";

                        until CLE_lRec1.next = 0;
                    end;
                end;
            until DtldCustLedgEntry1.Next() = 0;
    end;

    // Local procedure FindPurchaseDocumentNo_lFnc(VendLedEntry: Record "Vendor Ledger Entry")
    // var
    //     DtldVendLedgEntry1: Record "Detailed Vendor Ledg. Entry";
    //     DtldVendLedgEntry2: Record "Detailed Vendor Ledg. Entry";
    //     VLE_lRec1: Record "Vendor Ledger Entry";
    // begin
    //     // Clear(DocNo_gTxt);

    //     DtldVendLedgEntry1.SetCurrentKey("Vendor Ledger Entry No.");
    //     DtldVendLedgEntry1.SetRange("Vendor Ledger Entry No.", VendLedEntry."Entry No.");
    //     DtldVendLedgEntry1.SetRange(Unapplied, false);
    //     if DtldVendLedgEntry1.Find('-') then
    //         repeat
    //             if DtldVendLedgEntry1."Vendor Ledger Entry No." =
    //                DtldVendLedgEntry1."Applied Vend. Ledger Entry No."
    //             then begin
    //                 DtldVendLedgEntry2.Init();
    //                 DtldVendLedgEntry2.SetCurrentKey("Applied Vend. Ledger Entry No.", "Entry Type");
    //                 DtldVendLedgEntry2.SetRange(
    //                   "Applied Vend. Ledger Entry No.", DtldVendLedgEntry1."Applied Vend. Ledger Entry No.");
    //                 DtldVendLedgEntry2.SetRange("Entry Type", DtldVendLedgEntry2."Entry Type"::Application);
    //                 DtldVendLedgEntry2.SetRange(Unapplied, false);
    //                 if DtldVendLedgEntry2.Find('-') then
    //                     repeat
    //                         if DtldVendLedgEntry2."Vendor Ledger Entry No." <>
    //                            DtldVendLedgEntry2."Applied Vend. Ledger Entry No."
    //                         then begin
    //                             VLE_lRec1.Reset();
    //                             VLE_lRec1.SetCurrentKey("Entry No.");
    //                             VLE_lRec1.SetRange("Entry No.", DtldVendLedgEntry2."Vendor Ledger Entry No.");
    //                             if VLE_lRec1.Findset then begin
    //                                 repeat
    //                                     if VLE_lRec1."Document Type" = VLE_lRec1."Document Type"::Invoice then
    //                                         if DocNo_gTxt <> VLE_lRec1."Document No." then begin
    //                                             if DocNo_gTxt <> '' then begin
    //                                                 DocNo_gTxt := DocNo_gTxt + ' ' + VLE_lRec1."Document No."
    //                                             end else
    //                                                 DocNo_gTxt := VLE_lRec1."Document No.";
    //                                         end;

    //                                 until VLE_lRec1.next = 0;
    //                             end;
    //                         end;
    //                     until DtldVendLedgEntry2.Next() = 0;
    //             end else begin
    //                 VLE_lRec1.SetCurrentKey("Entry No.");
    //                 VLE_lRec1.SetRange("Entry No.", DtldVendLedgEntry1."Applied Vend. Ledger Entry No.");
    //                 if VLE_lRec1.Find('-') then begin
    //                     repeat
    //                         if VLE_lRec1."Document Type" = VLE_lRec1."Document Type"::Invoice then
    //                             if DocNo_gTxt <> VLE_lRec1."Document No." then begin
    //                                 if DocNo_gTxt <> '' then begin
    //                                     DocNo_gTxt := DocNo_gTxt + ' ' + VLE_lRec1."Document No."
    //                                 end else
    //                                     DocNo_gTxt := VLE_lRec1."Document No.";
    //                             end;

    //                     until VLE_lRec1.next = 0;
    //                 end;
    //             end;
    //         until DtldVendLedgEntry1.Next() = 0;
    // end;

    var
        Reporttitle_gTxt: Text;
        TotalAmt_gDec: Decimal;
        Companyinfo_gRec: Record "Company Information";
        CurrencDesc: Text;
        CurrenAmmt_gDec: Decimal;
        SRNo_gInt: Integer;
        NoText: array[2] of Text;
        AmountInWords: Text;
        DocNo_gTxt: text;
        VendorLedgerEntry_gRec: Record "Vendor Ledger Entry";
        CustomerLedgerEntry_gRec: Record "Cust. Ledger Entry";
}
