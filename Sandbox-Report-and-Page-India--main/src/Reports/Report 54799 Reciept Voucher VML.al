report 54799 "Reciept Voucher VML"//T12370-N
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/RecieptVoucher.rdl';
    Caption = 'Reciept Voucher';

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            RequestFilterFields = "Posting Date", "Document No.";

            column(VoucherSourceDesc; SourceDesc + ' Voucher')
            {
            }
            column(DocumentNo_GLEntry; "Document No.")
            {
            }
            column(PostingDateFormatted; 'Date: ' + FORMAT("Posting Date"))
            {
            }
            column(CompanyInformationAddress; CompanyInformation.Address + ' ' + CompanyInformation."Address 2" + '  ' + CompanyInformation.City + 'Tel: ' + CompanyInformation."Phone No." + 'Fax: ' + CompanyInformation."Fax No.")
            {
            }
            column(CompanyInformationEmail; CompanyInformation."E-Mail" + 'Website:' + CompanyInformation."Home Page")
            {
            }
            column(CompanyInformationName; CompanyInformation.Name)
            {
            }
            column(CompanyInformation; CompanyInformation.Picture)
            {
            }
            column(CreditAmount_GLEntry; "Credit Amount")
            {
            }
            column(DebitAmount_GLEntry; "Debit Amount")
            {
            }
            column(DrText; DrText)
            {
            }
            column(GLAccName; GLAccName)
            {
            }
            column(CrText; CrText)
            {
            }
            column(DebitAmountTotal; DebitAmountTotal)
            {
            }
            column(CreditAmountTotal; CreditAmountTotal)
            {
            }
            column(ChequeDetail; 'Cheque No: ' + ChequeNo + '  Dated: ' + FORMAT(ChequeDate))
            {
            }
            column(ChequeNo; ChequeNo)
            {
            }
            column(ChequeDate; ChequeDate)
            {
            }
            column(RsNumberText1NumberText2; NumberText[1] + ' ' + NumberText[2])
            {
            }
            column(EntryNo_GLEntry; "Entry No.")
            {
            }
            column(PostingDate_GLEntry; "Posting Date")
            {
            }
            column(TransactionNo_GLEntry; "Transaction No.")
            {
            }
            column(VoucherNoCaption; VoucherNoCaptionLbl)
            {
            }
            column(CreditAmountCaption; CreditAmountCaptionLbl)
            {
            }
            column(DebitAmountCaption; DebitAmountCaptionLbl)
            {
            }
            column(ParticularsCaption; ParticularsCaptionLbl)
            {
            }
            column(AmountInWordsCaption; AmountInWordsCaptionLbl)
            {
            }
            column(PreparedByCaption; PreparedByCaptionLbl)
            {
            }
            column(CheckedByCaption; CheckedByCaptionLbl)
            {
            }
            column(ApprovedByCaption; ApprovedByCaptionLbl)
            {
            }
            column(Narration_LineNarration; '')
            {
            }
            column(PrintLineNarration; PrintLineNarration)
            {
            }
            column(Document_No_; "Document No.")
            {
            }
            column(Document_Date; "Document Date")
            {
            }
            column(Description; Description)
            {
            }
            column(Amount; abs(Amount))
            {
            }
            column(Sn; Sn)
            {
            }
            column(Cheque_External_Document_No_; "External Document No.")
            {
            }
            column(paymentCOde; paymentCOde)
            {
            }
            column(BankName; BankName)
            {
            }
            column(REDM_Customer_Name; CustomerName)
            {
            }
            /*             dataitem(LineNarration; "Posted Narration") //table id 16548 was mentioned here 
                        {
                            DataItemLink = "Transaction No." = FIELD("Transaction No."),
                                           "Entry No." = FIELD("Entry No.");
                            DataItemTableView = SORTING("Entry No.", "Transaction No.", "Line No.");
                            column(Narration_LineNarration; Narration)
                            {
                            }
                            column(PrintLineNarration; PrintLineNarration)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                IF PrintLineNarration THEN BEGIN
                                    PageLoop := PageLoop - 1;
                                    LinesPrinted := LinesPrinted + 1;
                                END;
                            end;
                        }
             */
            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number);

                column(IntegerOccurcesCaption; IntegerOccurcesCaptionLbl)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    PageLoop := PageLoop - 1;
                end;

                trigger OnPreDataItem()
                begin
                    GLEntry.SETCURRENTKEY("Document No.", "Posting Date", Amount);
                    GLEntry.ASCENDING(FALSE);
                    GLEntry.SETRANGE("Posting Date", "G/L Entry"."Posting Date");
                    GLEntry.SETRANGE("Document No.", "G/L Entry"."Document No.");
                    GLEntry.FINDLAST;
                    IF NOT (GLEntry."Entry No." = "G/L Entry"."Entry No.") THEN CurrReport.BREAK;
                    SETRANGE(Number, 1, PageLoop)
                end;
            }
            column(Narration_PostedNarration1; '')
            {
            }
            column(NarrationCaption; NarrationCaptionLbl)
            {
            }
            /*             dataitem(PostedNarration1; "Posted Narration")//16548
                        {
                            DataItemLink = "Transaction No." = FIELD("Transaction No.");
                            DataItemTableView = SORTING("Entry No.", "Transaction No.", "Line No.")
                                                WHERE("Entry No." = FILTER(0));
                            column(Narration_PostedNarration1; Narration)
                            {
                            }
                            column(NarrationCaption; NarrationCaptionLbl)
                            {
                            }

                            trigger OnPreDataItem()
                            begin
                                GLEntry.SETCURRENTKEY("Document No.", "Posting Date", Amount);
                                GLEntry.ASCENDING(FALSE);
                                GLEntry.SETRANGE("Posting Date", "G/L Entry"."Posting Date");
                                GLEntry.SETRANGE("Document No.", "G/L Entry"."Document No.");
                                GLEntry.FINDLAST;
                                IF NOT (GLEntry."Entry No." = "G/L Entry"."Entry No.") THEN
                                    CurrReport.BREAK;
                            end;
                        }
             */
            trigger OnAfterGetRecord()
            begin
                GLAccName := FindGLAccName("Source Type".AsInteger(), "Entry No.", "Source No.", "G/L Account No.");
                IF Amount < 0 THEN BEGIN
                    CrText := 'To';
                    DrText := '';
                END
                ELSE BEGIN
                    CrText := '';
                    DrText := 'Dr';
                END;
                SourceDesc := '';
                IF "Source Code" <> '' THEN BEGIN
                    SourceCode.GET("Source Code");
                    SourceDesc := SourceCode.Description;
                END;
                PageLoop := PageLoop - 1;
                LinesPrinted := LinesPrinted + 1;
                ChequeNo := '';
                ChequeDate := 0D;
                IF ("Source No." <> '') AND ("Source Type" = "Source Type"::"Bank Account") THEN BEGIN
                    IF BankAccLedgEntry.GET("Entry No.") THEN BEGIN
                        // SKMChequeNo := BankAccLedgEntry."Cheque No.";
                        //SKM ChequeDate := BankAccLedgEntry."Cheque Date";
                    END;
                END;
                IF (ChequeNo <> '') AND (ChequeDate <> 0D) THEN BEGIN
                    PageLoop := PageLoop - 1;
                    LinesPrinted := LinesPrinted + 1;
                END;
                IF PostingDate <> "Posting Date" THEN BEGIN
                    PostingDate := "Posting Date";
                    TotalDebitAmt := 0;
                END;
                IF DocumentNo <> "Document No." THEN BEGIN
                    DocumentNo := "Document No.";
                    TotalDebitAmt := 0;
                END;
                IF PostingDate = "Posting Date" THEN BEGIN
                    InitTextVariable;
                    TotalDebitAmt += "Debit Amount";
                    FormatNoText(NumberText, ABS(TotalDebitAmt), '');
                    PageLoop := NUMLines;
                    LinesPrinted := 0;
                END;
                IF (PrePostingDate <> "Posting Date") OR (PreDocumentNo <> "Document No.") THEN BEGIN
                    DebitAmountTotal := 0;
                    CreditAmountTotal := 0;
                    PrePostingDate := "Posting Date";
                    PreDocumentNo := "Document No.";
                END;
                DebitAmountTotal := DebitAmountTotal + "Debit Amount";
                CreditAmountTotal := CreditAmountTotal + "Credit Amount";
                Sn := Sn + 1;
                /*   GenJurnalLine.Reset();
                  GenJurnalLine.SetRange("Document No.", "G/L Entry"."Document No.");
                  GenJurnalLine.SetRange("Posting Date", "G/L Entry"."Posting Date");

                  if GenJurnalLine.FindFirst() then begin


                      BankName := GenJurnalLine.Description;

                      paymentCOde := GenJurnalLine."Payment Method Code";
                  end */
                bankAccLedgerRec.Reset();
                bankAccLedgerRec.SetRange("Document No.", "Document No.");
                bankAccLedgerRec.SetRange("Posting Date", "Posting Date");
                if bankAccLedgerRec.FindFirst() then BankName := bankAccLedgerRec.Description;
                CustomerLedgerRec.Reset();
                CustomerLedgerRec.SetRange("Document No.", "Document No.");
                CustomerLedgerRec.SetRange("Posting Date", "Posting Date");
                if CustomerLedgerRec.FindFirst() then paymentCOde := CustomerLedgerRec."Payment Method Code";
                //CustomerName := CustomerLedgerRec."Customer Name";
                customerRec.Reset();
                customerRec.SetRange(customerRec."No.", CustomerLedgerRec."Customer No.");
                if customerRec.FindFirst() then CustomerName := customerRec.Name;
            end;

            trigger OnPreDataItem()
            begin
                NUMLines := 13;
                PageLoop := NUMLines;
                LinesPrinted := 0;
                DebitAmountTotal := 0;
                CreditAmountTotal := 0;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(PrintLineNarration; PrintLineNarration)
                    {
                        Caption = 'PrintLineNarration';
                        ApplicationArea = all;
                        Visible = false;
                    }
                }
            }
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
        CompanyInformation.GET;
        CompanyInformation.CalcFields(Picture);
    end;

    var
        bankAccLedgerRec: Record "Bank Account Ledger Entry";
        CustomerLedgerRec: Record "Cust. Ledger Entry";
        CustomerLedgerRec1: Record "Cust. Ledger Entry";
        customerRec: Record Customer;
        CustomerName: Text;
        GenJurnalLine: Record "Gen. Journal Line";
        BankName: Text[200];
        paymentCOde: Text[200];
        CompanyInformation: Record "Company Information";
        SourceCode: Record "Source Code";
        Sn: Integer;
        GLEntry: Record "G/L Entry";
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        GLAccName: Text[50];
        SourceDesc: Text[50];
        CrText: Text[2];
        DrText: Text[2];
        NumberText: array[2] of Text[80];
        PageLoop: Integer;
        LinesPrinted: Integer;
        NUMLines: Integer;
        ChequeNo: Code[50];
        ChequeDate: Date;
        Text16526: Label 'ZERO';
        Text16527: Label 'HUNDRED';
        Text16528: Label 'AND';
        Text16529: Label '%1 results in a written number that is too long.';
        Text16532: Label 'ONE';
        Text16533: Label 'TWO';
        Text16534: Label 'THREE';
        Text16535: Label 'FOUR';
        Text16536: Label 'FIVE';
        Text16537: Label 'SIX';
        Text16538: Label 'SEVEN';
        Text16539: Label 'EIGHT';
        Text16540: Label 'NINE';
        Text16541: Label 'TEN';
        Text16542: Label 'ELEVEN';
        Text16543: Label 'TWELVE';
        Text16544: Label 'THIRTEEN';
        Text16545: Label 'FOURTEEN';
        Text16546: Label 'FIFTEEN';
        Text16547: Label 'SIXTEEN';
        Text16548: Label 'SEVENTEEN';
        Text16549: Label 'EIGHTEEN';
        Text16550: Label 'NINETEEN';
        Text16551: Label 'TWENTY';
        Text16552: Label 'THIRTY';
        Text16553: Label 'FORTY';
        Text16554: Label 'FIFTY';
        Text16555: Label 'SIXTY';
        Text16556: Label 'SEVENTY';
        Text16557: Label 'EIGHTY';
        Text16558: Label 'NINETY';
        Text16559: Label 'THOUSAND';
        Text16560: Label 'MILLION';
        Text16561: Label 'BILLION';
        Text16562: Label 'LAKHS';
        Text16563: Label 'CRORE';
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        PrintLineNarration: Boolean;
        PostingDate: Date;
        TotalDebitAmt: Decimal;
        DocumentNo: Code[20];
        DebitAmountTotal: Decimal;
        CreditAmountTotal: Decimal;
        PrePostingDate: Date;
        PreDocumentNo: Code[50];
        VoucherNoCaptionLbl: Label 'Voucher No. :';
        CreditAmountCaptionLbl: Label 'Credit Amount';
        DebitAmountCaptionLbl: Label 'Debit Amount';
        ParticularsCaptionLbl: Label 'Particulars';
        AmountInWordsCaptionLbl: Label 'Amount (in words):';
        PreparedByCaptionLbl: Label 'Prepared by:';
        CheckedByCaptionLbl: Label 'Checked by:';
        ApprovedByCaptionLbl: Label 'Approved by:';
        IntegerOccurcesCaptionLbl: Label 'IntegerOccurces';
        NarrationCaptionLbl: Label 'Narration :';

    procedure FindGLAccName("Source Type": Option " ",Customer,Vendor,"Bank Account","Fixed Asset";
    "Entry No.": Integer;
    "Source No.": Code[20];
    "G/L Account No.": Code[20]): Text[50]
    var
        AccName: Text[50];
        VendLedgerEntry: Record "Vendor Ledger Entry";
        Vend: Record vendor;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Cust: Record Customer;
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        Bank: Record "Bank Account";
        FALedgerEntry: Record "FA Ledger Entry";
        FA: Record "Fixed Asset";
        GLAccount: Record "G/L Account";
    begin
        IF "Source Type" = "Source Type"::Vendor THEN
            IF VendLedgerEntry.GET("Entry No.") THEN BEGIN
                Vend.GET("Source No.");
                AccName := Vend.Name;
            END
            ELSE BEGIN
                GLAccount.GET("G/L Account No.");
                AccName := GLAccount.Name;
            END
        ELSE
            IF "Source Type" = "Source Type"::Customer THEN
                IF CustLedgerEntry.GET("Entry No.") THEN BEGIN
                    Cust.GET("Source No.");
                    AccName := Cust.Name;
                END
                ELSE BEGIN
                    GLAccount.GET("G/L Account No.");
                    AccName := GLAccount.Name;
                END
            ELSE
                IF "Source Type" = "Source Type"::"Bank Account" THEN
                    IF BankLedgerEntry.GET("Entry No.") THEN BEGIN
                        Bank.GET("Source No.");
                        AccName := Bank.Name;
                    END
                    ELSE BEGIN
                        GLAccount.GET("G/L Account No.");
                        AccName := GLAccount.Name;
                    END
                ELSE BEGIN
                    GLAccount.GET("G/L Account No.");
                    AccName := GLAccount.Name;
                END;
        IF "Source Type" = "Source Type"::" " THEN BEGIN
            GLAccount.GET("G/L Account No.");
            AccName := GLAccount.Name;
        END;
        EXIT(AccName);
    end;

    procedure FormatNoText(var NoText: array[2] of Text[80];
    No: Decimal;
    CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        Currency: Record Currency;
        GLSetup: Record "General Ledger Setup";
        TensDec: Integer;
        OnesDec: Integer;
    begin
        Clear(Currency);
        CLEAR(NoText);//HyperCare
        NoTextIndex := 1;//HyperCare
        // IF CurrencyCode <> '' THEN BEGIN //HyperCare 09-01-2025
        //     Currency.GET(CurrencyCode);
        //     NoText[1] := Currency.Code + '';//HyperCare
        // END else begin
        //     GLSetup.GET;
        //     //Currency.GET(GLSetup."LCY Code");//HyperCare
        //     NoText[1] := GLSetup."LCY Code" + '';//HyperCare
        // end;
        // CLEAR(NoText);
        // NoTextIndex := 1;
        // NoText[1] := Currency.Code + '';
        IF No < 1 THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526)
        ELSE BEGIN
            FOR Exponent := 4 DOWNTO 1 DO BEGIN
                PrintExponent := FALSE;
                IF No > 99999 THEN BEGIN
                    Ones := No DIV (POWER(100, Exponent - 1) * 10);
                    Hundreds := 0;
                END
                ELSE BEGIN
                    Ones := No DIV POWER(1000, Exponent - 1);
                    Hundreds := Ones DIV 100;
                END;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                IF Hundreds > 0 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text16527);
                END;
                IF Tens >= 2 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    IF Ones > 0 THEN AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                END
                ELSE
                    IF (Tens * 10 + Ones) > 0 THEN AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                IF PrintExponent AND (Exponent > 1) THEN AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                IF No > 99999 THEN
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(100, Exponent - 1) * 10
                ELSE
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            END;
        END;
        // IF CurrencyCode <> '' THEN BEGIN
        //     Currency.GET(CurrencyCode);
        //     AddToNoText(NoText, NoTextIndex, PrintExponent, '' + Currency.Description);
        // END
        // ELSE
        //     AddToNoText(NoText, NoTextIndex, PrintExponent, '');
        AddToNoText(NoText, NoTextIndex, PrintExponent, Text16528);
        TensDec := ((No * 100) MOD 100) DIV 10;
        OnesDec := (No * 100) MOD 10;
        IF TensDec >= 2 THEN BEGIN
            AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[TensDec]);
            IF OnesDec > 0 THEN AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[OnesDec]);
        END
        ELSE
            IF (TensDec * 10 + OnesDec) > 0 THEN
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[TensDec * 10 + OnesDec])
            ELSE
                AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526);
        IF (Currency."Subsidiary Currency" <> '') THEN
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + Currency."Subsidiary Currency" + ' ONLY')
        ELSE
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ONLY');
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80];
    var NoTextIndex: Integer;
    var PrintExponent: Boolean;
    AddText: Text[30])
    begin
        PrintExponent := TRUE;
        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) DO BEGIN
            NoTextIndex := NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText) THEN ERROR(Text16529, AddText);
        END;
        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    procedure InitTextVariable()
    begin
        OnesText[1] := Text16532;
        OnesText[2] := Text16533;
        OnesText[3] := Text16534;
        OnesText[4] := Text16535;
        OnesText[5] := Text16536;
        OnesText[6] := Text16537;
        OnesText[7] := Text16538;
        OnesText[8] := Text16539;
        OnesText[9] := Text16540;
        OnesText[10] := Text16541;
        OnesText[11] := Text16542;
        OnesText[12] := Text16543;
        OnesText[13] := Text16544;
        OnesText[14] := Text16545;
        OnesText[15] := Text16546;
        OnesText[16] := Text16547;
        OnesText[17] := Text16548;
        OnesText[18] := Text16549;
        OnesText[19] := Text16550;
        TensText[1] := '';
        TensText[2] := Text16551;
        TensText[3] := Text16552;
        TensText[4] := Text16553;
        TensText[5] := Text16554;
        TensText[6] := Text16555;
        TensText[7] := Text16556;
        TensText[8] := Text16557;
        TensText[9] := Text16558;
        ExponentText[1] := '';
        ExponentText[2] := Text16559;
        ExponentText[3] := Text16562;
        ExponentText[4] := Text16563;
    end;
}
