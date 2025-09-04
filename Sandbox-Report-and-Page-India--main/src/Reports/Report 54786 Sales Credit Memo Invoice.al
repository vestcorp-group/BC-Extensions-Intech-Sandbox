report 54786 "Sales Credit Memo Invoice"//T12370-Full Comment //Code Uncommented 27-12-24
{
    UsageCategory = Administration;
    ApplicationArea = all;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/SalesCreditMemoInvoiceNew.rdl';

    dataset
    {
        dataitem("SalesCrMemoHeader"; "Sales Cr.Memo Header")
        {
            RequestFilterFields = "Posting Date";

            column(PostingDate; "Posting Date")
            {
            }
            column(No; "No.")
            {
            }

            // column(VendorInvoiceNo; "Vendor Invoice No.")
            // {
            // }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {
            }
            column(Sell_to_Customer_Name; "Sell-to Customer Name")
            {
            }
            column(sellfromCounty; recCLE."Seller State Code")
            {
            }
            column(Customer_Posting_Group; "Customer Posting Group")
            {
            }
            column(CusGSTNo; RecCust."GST Registration No.")
            {

            }
            column(SaleInvoiceNo; SalesnvHeaRec."No.")
            {

            }
            column(SaleInvoicePostingDate; SalesnvHeaRec."Posting Date")
            {

            }
            column(dtFromDate; dtFromDate)
            {

            }
            column(dtToDate; dtToDate)
            {

            }
            column(CompName; recCompInfo.Name)
            {

            }
            column(User_ID; USERID)
            {

            }
            column(cdCurrencyCode; cdCurrencyCode)
            {

            }
            column(Reportfilter; Reportfilter)
            {

            }
            column(BankaccountName; Bankaccount.Name)
            {

            }
            column(BankaccountAccNo; Bankaccount."Bank Account No.")
            {

            }
            column(Print_copy; Print_copy) { }
            column(BankaccountBranch; Bankaccount."Branch Name")
            {

            }
            column(BankaccountIFAC; Bankaccount."IFSC CODE")
            {

            }
            column(BankaccountSWIFTcode; Bankaccount."SWIFT Code")
            {

            }
            column(CompanyInformation_Address; recCompInfo.Address)
            { }
            column(CompanyInformation_Address2; recCompInfo."Address 2")
            { }
            column(CompanyInformation_City; recCompInfo.City + ' Pin Code - ' + CompanyInformation."Post Code")
            {
            }
            column(CompanyInformation_City1; recCompInfo.City)
            {
            }
            column(CompanyInformation_Country; CountryRec.Name)
            {
            }
            column(ShiptoVar; ShiptoVar)
            {

            }
            column(CustomeRefNo; "External Document No.")
            {

            }

            column(CompanyInformationGST; 'GST No.: ' + recCompInfo."GST Registration No.")
            {


            }
            column(CompanyInformation; 'CIN No.: ' + recCompInfo."Registration No.")
            {

            }
            column(CompanyInfoRegisNoNew; recCompInfo."Registration No New")
            {

            }
            column(CompanyInfoRegisPan; recCompInfo."P.A.N. No.")
            {

            }
            column(CompLogo; CompanyInformation.Picture)
            {
            }
            column(Telephone; recCompInfo."Phone No.")
            {

            }

            column(Posting_Date; "Posting Date")
            {

            }
            column(Return_Order_No_; "Return Order No.")
            {

            }
            column(CustRecBillName; CustRecBill.Name)
            {

            }
            column(CustRecBillAdress1; CustRecBill.Address)
            {

            }
            column(CustRecBillAddress2; CustRecBill."Address 2")
            {

            }

            column(CustRecBillNameContry; CountryRecBill.Name)
            {

            }
            column(CustRecBillCity; CustRecBill.City)
            {

            }
            column(CustRecBillGstNo; CustRecBill."GST Registration No.")
            {

            }
            column(CustRecBillPan; CustRecBill."P.A.N. No.")
            {

            }
            column(Currency_Code; "Currency Code")
            {

            }

            //Shipto

            column(CustRecShipName; CustRecSell.Name)
            {

            }
            column(CustRecShipAdress1; CustRecSell.Address)
            {

            }
            column(CustRecShipAddress2; CustRecSell."Address 2")
            {

            }
            column(CustRecShipNameContry; CountryRecShipp.Name)
            {

            }
            column(Payment_Terms_Code; "Payment Terms Code")
            {

            }


            column(CustRecShipCity; CustRecSell.City)
            {

            }
            column(CustRecShipGstNo; CustRecSell."GST Registration No.")
            {

            }
            column(CustRecShipPan; CustRecSell."P.A.N. No.")
            {

            }



            dataitem("SalesCrMemoLine";
            "Sales Cr.Memo Line")
            {
                DataItemLink = "Document No." = Field("No.");
                DataItemTableView = sorting("Document No.", "Line No.") where(Type = filter('Item|G/L Account'));
                //  RequestFilterFields = "No.";

                column(HSN_SAC_Code; "HSN/SAC Code")
                {

                }
                column(Description; Description)
                {

                }
                column(Quantity__Base_; "Quantity (Base)")
                {

                }
                column(Quantity; Quantity)

                {

                }
                column(quantitysum; quantitysum)
                {

                }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                {

                }
                column(Unit_Cost__LCY_; "Unit Cost (LCY)")
                {

                }
                column(VAT_Base_Amount; abs("VAT Base Amount"))
                {

                }
                column(Line_Amount; "Line Amount")
                {

                }
                column(PINONew; "Blanket Order No.")
                {

                }
                column(Sorting_No_; SortingNo)
                {

                }
                column(Unit_Price; "Unit Price")
                {

                }
                column(Document_No_; "Document No.")
                {

                }


                column(IGSTPer; IGSTPer) { }
                column(IGSTAmt; abs(IGSTAmt)) { }
                column(CGSTPer; CGSTPer) { }
                column(CGSTAmt; abs(CGSTAmt)) { }
                column(SGSTPer; SGSTPer) { }
                column(SGSTAmt; abs(SGSTAmt)) { }
                column(TotGST; abs(TotGST)) { }
                column(Totalvalue; Totalvalue)
                {

                }
                column(AMountInW; AMountInW)
                {

                }
                column(Sr; Sr)
                {

                }


                trigger OnAfterGetRecord()
                var
                    recDetGSTEnt: Record "Detailed GST Ledger Entry";
                begin
                    Sr += 1;
                    InitGSTVar();
                    if SalesCrMemoLine.Type = SalesCrMemoLine.Type::Item then begin
                        quantitysum := quantitysum + SalesCrMemoLine."Quantity (Base)";

                    end;
                    if SalesCrMemoLine.Description = 'Round Off' then
                        CurrReport.Skip();
                    Totalvalue := 0;


                    recDetGSTEnt.Reset();
                    recDetGSTEnt.SetRange("Transaction Type", recDetGSTEnt."Transaction Type"::Sales);
                    recDetGSTEnt.SetRange("Document Type", recDetGSTEnt."Document Type"::"Credit Memo");
                    recDetGSTEnt.SetRange("Document No.", SalesCrMemoLine."Document No.");
                    recDetGSTEnt.SetRange("Document Line No.", SalesCrMemoLine."Line No.");
                    if recDetGSTEnt.FindSet() then
                        repeat
                            case recDetGSTEnt."GST Component Code" of
                                'IGST':
                                    begin
                                        IGSTPer := recDetGSTEnt."GST %";
                                        IGSTAmt := recDetGSTEnt."GST Amount";
                                    end;
                                'CGST':
                                    begin
                                        CGSTPer := recDetGSTEnt."GST %";
                                        CGSTAmt := recDetGSTEnt."GST Amount";
                                    end;
                                'SGST':
                                    begin
                                        SGSTPer := recDetGSTEnt."GST %";
                                        SGSTAmt := recDetGSTEnt."GST Amount";
                                    end;
                            end;
                        until recDetGSTEnt.Next() = 0;
                    TotGST := IGSTAmt + CGSTAmt + SGSTAmt;

                    TotalValue := TotalValue + abs("VAT Base Amount") + abs(TotGST);
                    GrandTotal := GrandTotal + TotGST + abs("VAT Base Amount");

                    CheckReportNew.InitTextVariable();
                    CheckReportNew.FormatNoText(Notext, GrandTotal, SalesCrMemoHeader."Currency Code");
                    // AMountInW := DelChr(Notext[1], '<>', '*') + Notext[2];
                    // AMountInW := CopyStr(String1, 2, StrLen(String1));

                    // AMountInW := CopyStr(Notext[1], 1, StrPos(Notext[1], '/100') - 1) + ' PAISA ONLY';
                    AMountInW := Notext[1];
                end;

            }
            trigger OnPreDataItem()
            begin

            end;

            trigger OnAfterGetRecord()
            begin
                if "Bill-to Customer No." = "Sell-to Customer No." then
                    ShiptoVar := true
                else
                    ShiptoVar := false;
                RecCust.Get("Sell-to Customer No.");
                recCLE.Get("Cust. Ledger Entry No.");
                IF StateCode <> '' THEN BEGIN
                    IF StateCode <> recCLE."Seller State Code" THEN
                        CurrReport.Skip();
                END;
                if Bankaccount.get("Bank on Invoice 2") then;
                CompanyInformation.Get;
                CompanyInformation.CalcFields(Picture);
                if CustRecBill.get("Bill-to Customer No.") then;
                if CustRecSell.get("Sell-to Customer No.") then;
                recCompInfo.get();
                if CountryRec.Get(recCompInfo."Country/Region Code") then;
                if CountryRecBill.Get(CustRecBill."Country/Region Code") then;
                if CountryRecShipp.Get(CustRecSell."Country/Region Code") then;
                SalesnvHeaRec.Reset();
                SalesnvHeaRec.SetRange("No.", "Applies-to Doc. No.");
                if SalesnvHeaRec.FindFirst() then;

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Filters)
                {
                    Caption = 'Filters';
                    /*  field(dtFromDate; dtFromDate)
                     {
                         Caption = 'From Date';
                         ApplicationArea = all;
                     }
                     field(dtToDate; dtToDate)
                     {
                         Caption = 'To Date';
                         ApplicationArea = all;
                     } */
                    field(Statecode; StateCode)
                    {
                        Caption = 'State code';
                        ApplicationArea = All;
                        Visible = false;
                    }
                    field(Print_copy; Print_copy)
                    {
                        ApplicationArea = all;
                        Caption = 'Print Copy Document';
                    }

                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()

    begin
        Reportfilter := SalesCrMemoHeader.GetFilters;



    end;

    var
        SalesnvHeaRec: Record "Sales Invoice Header";
        Bankaccount: Record "Bank Account";
        quantitysum: Decimal;
        Reportfilter: Text[100];
        SortingNo: Integer;
        //recVend: Record Vendor;
        Notext: array[2] of Text[100];
        AMountInW: text[200];
        RecCust: Record Customer;
        //recVLE: Record "Vendor Ledger Entry";
        recCLE: Record "Cust. Ledger Entry";
        GrandTotal: Decimal;
        Totalvalue: Decimal;
        CountryRec: Record "Country/Region";
        CountryRecBill: Record "Country/Region";
        CountryRecShipp: Record "Country/Region";

        dtFromDate: Date;
        dtToDate: Date;
        cdCurrencyCode: Code[10];
        txtDateFilter: Text;
        recCompInfo: Record "Company Information";
        IGSTPer: Decimal;
        Print_copy: Boolean;
        IGSTAmt: Decimal;
        CGSTPer: Decimal;
        CGSTAmt: Decimal;
        SGSTPer: Decimal;
        ShiptoVar: Boolean;
        SGSTAmt: Decimal;
        TotGST: Decimal;
        StateCode: Code[50];
        CompanyInformation: Record "Company Information";
        CustRecSell: Record Customer;
        CustRecBill: Record Customer;
        CheckReportNew: report "Reciept Voucher VML";
        Sr: Integer;

    local procedure InitGSTVar()
    begin
        IGSTPer := 0;
        IGSTAmt := 0;
        CGSTPer := 0;
        CGSTAmt := 0;
        SGSTPer := 0;
        SGSTAmt := 0;
        TotGST := 0;
    end;
}
