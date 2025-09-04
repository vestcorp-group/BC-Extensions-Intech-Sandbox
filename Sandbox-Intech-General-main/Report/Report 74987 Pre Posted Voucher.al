Report 74987 "Pre Posted Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Pre Posted Voucher.rdlc';
    Caption = 'Pre Posted Voucher';

    dataset
    {
        dataitem(GLEntries; "Integer")
        {
            DataItemTableView = sorting(Number);
            column(ReportForNavId_33027920; 33027920)
            {
            }
            column(GLAccName; GLAccName)
            {
            }
            column(GlobalDimension1Code_GLEntryTmpgRec; GLEntryTmp_gRec."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_GLEntryTmpgRec; GLEntryTmp_gRec."Global Dimension 2 Code")
            {
            }
            column(CompanyInformationAddress; CompanyInformation.Address + ' ' + CompanyInformation."Address 2" + '  ' + CompanyInformation.City)
            {
            }
            column(CompanyInformationName; CompanyInformation.Name)
            {
            }
            column(PostingDateFormatted; 'Date: ' + Format(GLEntryTmp_gRec."Posting Date"))
            {
            }
            column(DocumentNo_GLEntry; GLEntryTmp_gRec."Document No.")
            {
            }
            column(EntryNo_GLEntry; GLEntryTmp_gRec."Entry No.")
            {
            }
            column(PostingDate_GLEntry; GLEntryTmp_gRec."Posting Date")
            {
            }
            column(TransactionNo_GLEntry; GLEntryTmp_gRec."Transaction No.")
            {
            }
            column(DebitAmountTotal; DebitAmountTotal)
            {
            }
            column(CreditAmountTotal; CreditAmountTotal)
            {
            }
            column(RsNumberText1NumberText2; 'Rs. ' + NumberText[1] + ' ' + NumberText[2])
            {
            }
            column(VoucherSourceDesc; SourceDesc + ' Voucher')
            {
            }
            column(CreditAmount_GLEntry; GLEntryTmp_gRec."Credit Amount")
            {
            }
            column(DebitAmount_GLEntry; GLEntryTmp_gRec."Debit Amount")
            {
            }
            column(DrText; DrText)
            {
            }
            column(CrText; CrText)
            {
            }
            column(AccountNo_gCod; AccountNo_gCod)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Number = 1 then
                    GLEntryTmp_gRec.FindSet
                else
                    GLEntryTmp_gRec.Next;

                GLAccName := FindGLAccName(GLEntryTmp_gRec."Source Type".AsInteger(), GLEntryTmp_gRec."Entry No.", GLEntryTmp_gRec."Source No.", GLEntryTmp_gRec."G/L Account No.");

                SourceDesc := '';
                if GLEntryTmp_gRec."Source Code" <> '' then begin
                    SourceCode.Get(GLEntryTmp_gRec."Source Code");
                    SourceDesc := SourceCode.Description;
                end;

                if GLEntryTmp_gRec.Amount < 0 then begin
                    CrText := 'To';
                    DrText := '';
                end else begin
                    CrText := '';
                    DrText := 'Dr';
                end;


                if PostingDate <> GLEntryTmp_gRec."Posting Date" then begin
                    PostingDate := GLEntryTmp_gRec."Posting Date";
                    TotalDebitAmt := 0;
                end;
                if DocumentNo <> GLEntryTmp_gRec."Document No." then begin
                    DocumentNo := GLEntryTmp_gRec."Document No.";
                    TotalDebitAmt := 0;
                end;

                if PostingDate = GLEntryTmp_gRec."Posting Date" then begin
                    InitTextVariable;
                    TotalDebitAmt += GLEntryTmp_gRec."Debit Amount";
                    FormatNoText(NumberText, Abs(TotalDebitAmt), '');
                end;

                if (PrePostingDate <> GLEntryTmp_gRec."Posting Date") or (PreDocumentNo <> GLEntryTmp_gRec."Document No.") then begin
                    DebitAmountTotal := 0;
                    CreditAmountTotal := 0;
                    PrePostingDate := GLEntryTmp_gRec."Posting Date";
                    PreDocumentNo := GLEntryTmp_gRec."Document No.";
                end;

                DebitAmountTotal := DebitAmountTotal + GLEntryTmp_gRec."Debit Amount";
                CreditAmountTotal := CreditAmountTotal + GLEntryTmp_gRec."Credit Amount";
            end;

            trigger OnPreDataItem()
            begin
                DebitAmountTotal := 0;
                CreditAmountTotal := 0;
                GLEntryTmp_gRec.Reset;
                SetRange(Number, 1, GLEntryTmp_gRec.Count);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLEntryTmp_gRec.Reset;
        GLEntryTmp_gRec.DeleteAll;
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.Get;
    end;

    var
        CompanyInformation: Record "Company Information";
        SourceCode: Record "Source Code";
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
        Text16526: label 'ZERO';
        Text16527: label 'HUNDRED';
        Text16528: label 'AND';
        Text16529: label '%1 results in a written number that is too long.';
        Text16532: label 'ONE';
        Text16533: label 'TWO';
        Text16534: label 'THREE';
        Text16535: label 'FOUR';
        Text16536: label 'FIVE';
        Text16537: label 'SIX';
        Text16538: label 'SEVEN';
        Text16539: label 'EIGHT';
        Text16540: label 'NINE';
        Text16541: label 'TEN';
        Text16542: label 'ELEVEN';
        Text16543: label 'TWELVE';
        Text16544: label 'THIRTEEN';
        Text16545: label 'FOURTEEN';
        Text16546: label 'FIFTEEN';
        Text16547: label 'SIXTEEN';
        Text16548: label 'SEVENTEEN';
        Text16549: label 'EIGHTEEN';
        Text16550: label 'NINETEEN';
        Text16551: label 'TWENTY';
        Text16552: label 'THIRTY';
        Text16553: label 'FORTY';
        Text16554: label 'FIFTY';
        Text16555: label 'SIXTY';
        Text16556: label 'SEVENTY';
        Text16557: label 'EIGHTY';
        Text16558: label 'NINETY';
        Text16559: label 'THOUSAND';
        Text16560: label 'MILLION';
        Text16561: label 'BILLION';
        Text16562: label 'LAKH';
        Text16563: label 'CRORE';
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
        VoucherNoCaptionLbl: label 'Voucher No. :';
        CreditAmountCaptionLbl: label 'Credit Amount';
        DebitAmountCaptionLbl: label 'Debit Amount';
        ParticularsCaptionLbl: label 'Particulars';
        AmountInWordsCaptionLbl: label 'Amount (in words):';
        PreparedByCaptionLbl: label 'Prepared by:';
        CheckedByCaptionLbl: label 'Checked by:';
        ApprovedByCaptionLbl: label 'Approved by:';
        IntegerOccurcesCaptionLbl: label 'IntegerOccurces';
        NarrationCaptionLbl: label 'Narration :';
        AccountNo_gCod: Code[20];
        GLEntryTmp_gRec: Record "G/L Entry" temporary;


    procedure FindGLAccName("Source Type": Option " ",Customer,Vendor,"Bank Account","Fixed Asset"; "Entry No.": Integer; "Source No.": Code[20]; "G/L Account No.": Code[20]): Text[50]
    var
        AccName: Text[50];
        VendLedgerEntry: Record "Vendor Ledger Entry";
        Vend: Record Vendor;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        Cust: Record Customer;
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        Bank: Record "Bank Account";
        FALedgerEntry: Record "FA Ledger Entry";
        FA: Record "Fixed Asset";
        GLAccount: Record "G/L Account";
        VendorPostingGroup_lRec: Record "Vendor Posting Group";
        CustomerPostingGroup_lRec: Record "Customer Posting Group";
    begin
        if "Source Type" = "source type"::Vendor then
            if VendLedgerEntry.Get("Entry No.") then begin
                Vend.Get("Source No.");
                AccName := Vend.Name;
                AccountNo_gCod := Vend."No.";  //T7096-N  230118
            end else begin
                //CP-NS
                VendorPostingGroup_lRec.Reset;
                VendorPostingGroup_lRec.SetRange("Payables Account", "G/L Account No.");
                if VendorPostingGroup_lRec.FindFirst then begin
                    Vend.Get("Source No.");
                    AccName := Vend.Name;
                    AccountNo_gCod := Vend."No.";  //T7096-N  230118
                end else begin
                    //CP-NE
                    GLAccount.Get("G/L Account No.");
                    AccName := GLAccount.Name;
                    AccountNo_gCod := GLAccount."No.";  //T7096-N  230118
                end;    //CP-N
            end
        else
            if "Source Type" = "source type"::Customer then
                if CustLedgerEntry.Get("Entry No.") then begin
                    Cust.Get("Source No.");
                    AccName := Cust.Name;
                    AccountNo_gCod := Cust."No.";  //T7096-N  230118
                end else begin
                    //CP-NS
                    CustomerPostingGroup_lRec.Reset;
                    CustomerPostingGroup_lRec.SetRange("Receivables Account", "G/L Account No.");
                    if CustomerPostingGroup_lRec.FindFirst then begin
                        Cust.Get("Source No.");
                        AccName := Cust.Name;
                        AccountNo_gCod := Cust."No.";  //T7096-N  230118
                    end else begin
                        //CP-NE
                        GLAccount.Get("G/L Account No.");
                        AccName := GLAccount.Name;
                        AccountNo_gCod := GLAccount."No.";  //T7096-N  230118
                    end;    //CP-N
                end
            else
                if "Source Type" = "source type"::"Bank Account" then
                    if BankLedgerEntry.Get("Entry No.") then begin
                        Bank.Get("Source No.");
                        AccName := Bank.Name;
                        AccountNo_gCod := Bank."No.";  //T7096-N  230118
                    end else begin
                        GLAccount.Get("G/L Account No.");
                        AccName := GLAccount.Name;
                        AccountNo_gCod := GLAccount."No.";  //T7096-N  230118
                    end
                else begin
                    GLAccount.Get("G/L Account No.");
                    AccName := GLAccount.Name;
                    AccountNo_gCod := GLAccount."No.";  //T7096-N  230118
                end;

        if "Source Type" = "source type"::" " then begin
            GLAccount.Get("G/L Account No.");
            AccName := GLAccount.Name;
            AccountNo_gCod := GLAccount."No.";  //T7096-N  230118
        end;

        exit(AccName);
    end;


    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
        Currency: Record Currency;
        TensDec: Integer;
        OnesDec: Integer;
    begin
        Clear(NoText);
        NoTextIndex := 1;
        NoText[1] := '';

        if No < 1 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526)
        else begin
            for Exponent := 4 downto 1 do begin
                PrintExponent := false;
                if No > 99999 then begin
                    Ones := No DIV (Power(100, Exponent - 1) * 10);
                    Hundreds := 0;
                end else begin
                    Ones := No DIV Power(1000, Exponent - 1);
                    Hundreds := Ones DIV 100;
                end;
                Tens := (Ones MOD 100) DIV 10;
                Ones := Ones MOD 10;
                if Hundreds > 0 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text16527);
                end;
                if Tens >= 2 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    if Ones > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end else
                    if (Tens * 10 + Ones) > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                if PrintExponent and (Exponent > 1) then
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                if No > 99999 then
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(100, Exponent - 1) * 10
                else
                    No := No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;
        end;

        if CurrencyCode <> '' then begin
            Currency.Get(CurrencyCode);
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + '');
        end else
            AddToNoText(NoText, NoTextIndex, PrintExponent, 'RUPEES');

        AddToNoText(NoText, NoTextIndex, PrintExponent, Text16528);

        TensDec := ((No * 100) MOD 100) DIV 10;
        OnesDec := (No * 100) MOD 10;
        if TensDec >= 2 then begin
            AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[TensDec]);
            if OnesDec > 0 then
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[OnesDec]);
        end else
            if (TensDec * 10 + OnesDec) > 0 then
                AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[TensDec * 10 + OnesDec])
            else
                AddToNoText(NoText, NoTextIndex, PrintExponent, Text16526);
        if (CurrencyCode <> '') then
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ' + ' ONLY')
        else
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' PAISA ONLY');
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent := true;

        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1]) do begin
            NoTextIndex := NoTextIndex + 1;
            if NoTextIndex > ArrayLen(NoText) then
                Error(Text16529, AddText);
        end;

        NoText[NoTextIndex] := DelChr(NoText[NoTextIndex] + ' ' + AddText, '<');
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


    procedure CopyTmpTable_gFnc(var GLEntry_VRecTmp: Record "G/L Entry" temporary)
    begin
        GLEntryTmp_gRec.Reset;
        GLEntryTmp_gRec.DeleteAll;
        GLEntryTmp_gRec.Copy(GLEntry_VRecTmp, true);
    end;
}

