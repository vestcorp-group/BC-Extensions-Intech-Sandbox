xmlport 53000 GrossProfit//T12370-Full Comment T12946-Code Uncommented
{
    Caption = 'GrossProfit';
    UseDefaultNamespace = true;
    Direction = Both;
    Encoding = UTF8;
    FormatEvaluate = Xml;
    Format = Xml;


    schema
    {
        textelement(Root)
        {
            tableelement(GrossProfitReport; "Gross Profit Report")
            {
                fieldelement(GroupCo; GrossProfitReport."Group Co.")
                {
                }
                fieldelement(DocumentType; GrossProfitReport."Document Type")
                {
                }
                fieldelement(Incoterm; GrossProfitReport.Incoterm)
                {
                }
                fieldelement(SODate; GrossProfitReport."SO Date")
                {
                }
                fieldelement(SONo; GrossProfitReport."SO No.")
                {
                }
                fieldelement(SIDate; GrossProfitReport."SI Date")
                {
                }
                fieldelement(SINo; GrossProfitReport."SI No.")
                {
                }
                fieldelement(CustomerCode; GrossProfitReport."Customer Code")
                {
                }
                fieldelement(CustomerShortName; GrossProfitReport."Customer Short Name")
                {
                }
                fieldelement(ItemCode; GrossProfitReport."Item Code")
                {
                }
                fieldelement(ItemCategory; GrossProfitReport."Item Category")
                {
                }
                fieldelement(ItemMarketIndustry; GrossProfitReport."Item Market Industry")
                {
                }
                fieldelement(ItemShortName; GrossProfitReport."Item Short Name")
                {
                }
                fieldelement(BaseUOM; GrossProfitReport."Base UOM")
                {
                }
                fieldelement(BaseUOMPrice; GrossProfitReport."Base UOM Price")
                {
                }
                fieldelement(CUR; GrossProfitReport.CUR)
                {
                }
                fieldelement(CogsLCY; GrossProfitReport."Cogs (LCY)")
                {
                }
                fieldelement(COSLCY; GrossProfitReport."COS (LCY)")
                {
                }
                fieldelement(EXPCDT; GrossProfitReport."EXP-CDT")
                {
                }
                fieldelement(EXPCOO; GrossProfitReport."EXP-COO")
                {
                }
                fieldelement(EXPFRT; GrossProfitReport."EXP-FRT")
                {
                }
                fieldelement(EXPINPC; GrossProfitReport."EXP-INPC")
                {
                }
                fieldelement(EXPINS; GrossProfitReport."EXP-INS")
                {
                }
                fieldelement(EXPLEGAL; GrossProfitReport."EXP-LEGAL")
                {
                }
                fieldelement(EXPOTHER; GrossProfitReport."EXP-OTHER")
                {
                }
                fieldelement(EXPSERV; GrossProfitReport."EXP-SERV")
                {
                }
                fieldelement(EXPTHC; GrossProfitReport."EXP-THC")
                {
                }
                fieldelement(EXPTRC; GrossProfitReport."EXP-TRC")
                {
                }
                fieldelement(EXPWHHNDL; GrossProfitReport."EXP-WH HNDL")
                {
                }
                fieldelement(EXPWHPACK; GrossProfitReport."EXP-WH PACK")
                {
                }
                fieldelement(DEMURRAGECHARGES; GrossProfitReport."DEMURRAGE CHARGES")
                {
                }
                fieldelement(POD; GrossProfitReport.POD)
                {
                }
                fieldelement(POL; GrossProfitReport.POL)
                {
                }
                fieldelement(QTY; GrossProfitReport.QTY)
                {
                }
                fieldelement(EffGP; GrossProfitReport."Eff GP %")
                {
                }
                fieldelement(EffGPLCY; GrossProfitReport."Eff GP (LCY)")
                {
                }
                fieldelement(OtherRevenueLCY; GrossProfitReport."Other Revenue (LCY)")
                {
                }
                fieldelement(REBATETOCUSTOMER; GrossProfitReport."REBATE TO CUSTOMER")
                {
                }
                fieldelement(Total; GrossProfitReport.Total)
                {
                }
                fieldelement(TotalAmount; GrossProfitReport."Total Amount")
                {
                }
                fieldelement(TotalAmountLCY; GrossProfitReport."Total Amount (LCY)")
                {
                }
                fieldelement(TotalSalesDiscount; GrossProfitReport."Total Sales Discount")
                {
                }
                fieldelement(TotalSalesExpensesLCY; GrossProfitReport."Total Sales Expenses (LCY)")
                {
                }
                fieldelement(Teams; GrossProfitReport.Teams)
                {
                }
                fieldelement(SalespersonName; GrossProfitReport."Salesperson Name")
                {
                }
                fieldelement(IcCompanyCode; GrossProfitReport."IC Company Code")
                {

                }
                fieldelement(CustomBOE; GrossProfitReport."Custom LOT No.")
                {

                }
                fieldelement(VendorInvoiceNumner; GrossProfitReport."Vendor Invoice No.")
                {

                }
                fieldelement(CreatedFromIndia; GrossProfitReport."Created By Other Instance")
                {

                }
                fieldelement(CustomerName; GrossProfitReport."Customer Name")
                {

                }
                fieldelement(OtherCharges; GrossProfitReport."Other Charges")
                {

                }
                // fieldelement(VariantCode; GrossProfitReport."Variant Code")
                // {

                // } //Hypercare 17-02-2025

                trigger OnBeforeInsertRecord()
                begin
                    EntryNumber += 1;
                    GrossProfitReport."Entry No." := EntryNumber
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
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

    procedure SetEntryNumber(Number: integer)
    begin
        EntryNumber := Number;
    end;

    var
        EntryNumber: Integer;
}
