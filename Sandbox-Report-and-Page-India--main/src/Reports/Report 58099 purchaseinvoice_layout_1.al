report 58099 purchaseinvoice_layout_1//T12370-N
{
    UsageCategory = Administration;
    ApplicationArea = all;
    RDLCLayout = './Layouts/Posted_purchase_invoice.rdl';
    Caption = 'Posted Purchase Invoice_New';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            RequestFilterFields = "No.";
            column(ReportHeader; ReportHeader) { }
            column(Company_Name; company.Name) { }
            column(company_Address; company.Address) { }
            column(company_address2; company."Address 2") { }
            column(company_city; company.City) { }
            column(company_country; CompanyCountry.Name) { }
            column(company_telno; company."Phone No.") { }
            column(CompanyInRegNew; company."Registration No New")
            { }
            column(companyGST; company."GST Registration No.") { }
            column(companyPAN; company."P.A.N. No.") { }
            column(company_logo; company.Picture) { }
            column(company_email; company."E-Mail") { }
            column(Pan_No; company."P.A.N. No.")
            { }
            column(GST_Reg; company."GST Registration No.")
            { }
            column(company_website; company."Home Page") { }
            column(Pay_to_Name; "Pay-to Name") { }
            column(Pay_to_Address; "Pay-to Address") { }
            column(Pay_to_Address_2; "Pay-to Address 2") { }
            column(Pay_to_City; "Pay-to City") { }
            column(Pay_to_Country_Region_Code; vendorcountry.Name) { }
            column(Pay_to_Vendor_No_; "Pay-to Vendor No.") { }
            column(No_; "No.") { }
            column(Posting_Date; "Posting Date") { }
            column(Document_Date; "Document Date") { }
            column(Due_Date; "Due Date") { }
            column(Payment_Terms_Code; paymentterm.Description) { }
            column(Payment_Method_Code; paymentmethod.Description) { }
            column(Vendor_Invoice_No_; "Vendor Invoice No.") { }
            column(Currency_Code; "Currency Code") { }
            column(Posting_Description; "Posting Description") { }
            column(User_ID; "User ID") { }
            column(Vendor_GST_Reg__No_; "Vendor GST Reg. No.") { }
            column(VendorGST; Vendor."GST Registration No.") { }
            column(VendorPAN; Vendor."P.A.N. No.") { }
            column(tsdrecTDSAMOUNT; tsdrec."TDS Amount")
            {

            }
            column(Remaining_Amount; "Remaining Amount")
            {

            }
            column(AmountInWord; AMountInW)
            {

            }

            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = field("No.");

                column(Receipt_No_; "Receipt No.")
                {

                }
                column(Line; "No.") { }
                column(Line_No_; "Line No.") { }
                column(Description; Description) { }
                column(Unit_of_Measure_Code; "Base UOM") { }
                column(Quantity; "Quantity (Base)") { DecimalPlaces = 0 : 3; }
                column(Direct_Unit_Cost; "Unit Price Base UOM") { }
                column(Amount; Amount) { }
                column(GST_Group_Code; "GST Group Code") { }
                column(Amount_Including_VAT; "Amount Including VAT") { }
                column(VAT_Calculation_Type; "VAT Calculation Type") { }
                column(line_GST_amount; line_GST_amount) { }
                column(GST; GST)
                {

                }
                column(CGST; CGST)
                { }
                column(IGST; IGST)
                { }
                column(SGST; SGST)
                { }
                column(GSTAmount; GSTAmount)
                { }
                column(AmountInclGst; AmountInclGst)
                { }

                column(AmountExclGST; AmountExclGST)
                { }
                column(CGSTamount; CGSTamount) { }
                column(IGSTamount; IGSTamount) { }
                column(SGSTAmount; SGSTAmount) { }

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                    recDetGstDetail: Record "Detailed GST Ledger Entry";


                begin
                    // total := 0;
                    if "No." = '' THEN
                        CurrReport.Skip();
                    // SetFilter(Type, '<>%1', Type::" ");
                    Clear(line_GST_amount);
                    line_GST_amount := Amount / 100 * "VAT %";
                    if "Unit Price Base UOM" = 0 then begin
                        "Unit Price Base UOM" := "Direct Unit Cost";
                        "Base UOM" := "Unit of Measure Code";
                        "Quantity (Base)" := Quantity;
                    end;


                    InitGSTVariable();

                    // if Type = Type::Item then begin
                    AmountExclGST := Quantity * "Direct Unit Cost";
                    recDetGstDetail.Reset();
                    recDetGstDetail.SetRange("Transaction Type", recDetGstDetail."Transaction Type"::Purchase);
                    recDetGstDetail.SetRange("Document Type", recDetGstDetail."Document Type"::Invoice);
                    recDetGstDetail.SetRange("Document No.", "Purch. Inv. Line"."Document No.");
                    recDetGstDetail.SetRange("Document Line No.", "Purch. Inv. Line"."Line No.");
                    if recDetGstDetail.FindSet() then
                        repeat
                            case recDetGstDetail."GST Component Code" of
                                'IGST':
                                    begin
                                        IGSTamount := recDetGstDetail."GST Amount";
                                        IGST := Format(recDetGstDetail."GST %") + '%';
                                    end;
                                'CGST':
                                    begin
                                        CGSTamount := recDetGstDetail."GST Amount";
                                        CGST := Format(recDetGstDetail."GST %") + '%';
                                    end;
                                'SGST':
                                    begin
                                        SGSTAmount := recDetGstDetail."GST Amount";
                                        SGST := Format(recDetGstDetail."GST %") + '%';
                                    end;
                            end;
                            GSTPer += recDetGstDetail."GST %";
                        until recDetGstDetail.Next() = 0;

                    GSTAmount := IGSTamount + CGSTamount + SGSTAmount;
                    // end;
                    GST := Format(GSTPer) + '%';
                    if IGSTamount > 0 then begin
                        IGST := Format(GSTPer) + '%';
                        CGST := '';
                        SGST := '';
                    end else begin
                        IGST := '';
                        CGST := Format(GSTPer / 2) + '%';
                        SGST := Format(GSTPer / 2) + '%';
                    end;

                    AmountInclGst := AmountExclGST + GSTAmount;

                    // if Type = Type::Item then begin
                    //     //GST := '18%';
                    //     AmountExclGST := Quantity * "Direct Unit Cost";
                    //     GSTAmount := Round(AmountExclGST * 18 / 100, 0.01, '=');
                    //     AmountInclGst := GSTAmount + AmountExclGST;
                    //     // IGST:='18%';
                    //     CGST := '9%';
                    //     SGST := '9%';
                    //     GST := '18%';
                    //     if IGST <> '' then begin
                    //         IGSTamount := GSTAmount;
                    //     end

                    //     else begin
                    //         CGSTamount := GSTAmount / 2;
                    //         SGSTAmount := GSTAmount / 2;
                    //     end

                    // end;




                    // chekReport.InitTextVariable();
                    //  chekReport.FormatNoText(Notext, total, '');
                    //  CheckReportNew.InitTextVariable();
                    // CheckReportNew.FormatNoText(Notext, total, '');
                    // AMountInW := DelChr(Notext[1], '<>', '*') + Notext[2];
                    // AMountInW := CopyStr(String1, 2, StrLen(String1));

                    // AMountInW := CopyStr(Notext[1], 1, StrPos(Notext[1], '/100') - 1) + ' PAISA ONLY';
                    //  AMountInW := Notext[1];
                    // end;
                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                GLS: Record "General Ledger Setup";
            begin
                Clear(header_GST_amount);
                gls.Get();
                Vendor.get("Buy-from Vendor No.");
                if "Currency Code" = '' then "Currency Code" := gls."LCY Code";
                if vendorcountry.Get("Purch. Inv. Header"."Pay-to Country/Region Code") then;
                if paymentterm.Get("Purch. Inv. Header"."Payment Terms Code") then;
                if paymentmethod.Get("Purch. Inv. Header"."Payment Method Code") then;

                if "Purch. Inv. Header"."Prepayment Invoice" then ReportHeader := 'Prepayment Invoice' else ReportHeader := 'Posted Purchase Invoice';

                tsdrec.Reset();
                tsdrec.SetRange("Document No.", "No.");
                tsdrec.SetRange("Vendor No.", "Buy-from Vendor No.");
                if tsdrec.FindFirst() then;


                CheckReportNew.InitTextVariable();
                CheckReportNew.FormatNoText(Notext, Round("Remaining Amount", 0.01), "Purch. Inv. Header"."Currency Code");
                // AMountInW := DelChr(Notext[1], '<>', '*') + Notext[2];
                // AMountInW := CopyStr(String1, 2, StrLen(String1));

                // AMountInW := CopyStr(Notext[1], 1, StrPos(Notext[1], '/100') - 1) + ' PAISA ONLY';
                AMountInW := Notext[1];

            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                company.get();
                company.CalcFields(Picture);
                CompanyCountry.Get(company."Country/Region Code");
            end;
        }
    }

    local procedure InitGSTVariable()
    Begin
        GST := '';
        GSTPer := 0;
        GSTAmount := 0;
        IGST := '';
        IGSTamount := 0;
        CGST := '';
        CGSTamount := 0;
        SGST := '';
        SGSTAmount := 0;
        AmountExclGST := 0;
        // AmountInclGst := 0;
    End;

    var
        AmountInWord: Text[250];

        tsdrec: Record 18689;
        chekReport: Report Check;
        chekReport1: Report Check;
        //CheckReportNew: report Check;
        CheckReportNew: Report "Reciept Voucher VML";
        Notext: array[2] of Text[100];
        company: Record "Company Information";
        Vendor: Record Vendor;
        line_GST_amount: Decimal;
        header_GST_amount: Decimal;
        CompanyCountry: Record "Country/Region";
        vendorcountry: Record "Country/Region";
        paymentterm: Record "Payment Terms";
        paymentmethod: Record "Payment Method";
        ReportHeader: Text[100];
        GST: text[50];
        GSTPer: Decimal;
        IGST: text[50];
        SGST: text[50];
        CGST: text[50];
        total: Decimal;

        AmountInclGst: Decimal;
        AmountExclGST: Decimal;
        GSTAmount: Decimal;
        IGSTamount: Decimal;
        SGSTAmount: Decimal;
        CGSTamount: Decimal;
        AMountInW: Text[250];
}