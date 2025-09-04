page 58161 "Consolidated Sales Details"//T12370-Full Comment    //T13413-Full UnComment
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Consolidated Sales Details';
    SourceTable = Customer;

    layout
    {
        area(Content)
        {
            cuegroup("Sales Details")
            {
                CuegroupLayout = Wide;
                Caption = 'Sales';
                field(CCSalesthisMonth; CCSalesthisMonth)
                {
                    ApplicationArea = all;
                    Caption = 'Sales This Month Curr. Company';
                    DecimalPlaces = 0;
                    trigger OnDrillDown()
                    var
                        Consolsales: Page "Salesperson Consolidated Sales";
                    begin
                        Consolsales.Run();
                    end;
                }
                field(CMSalesthismonthconsol; CMSalesthismonthconsol)
                {
                    Caption = 'Sales This Month Consolildated';
                    ApplicationArea = all;
                    DecimalPlaces = 0;
                    trigger OnDrillDown()
                    var
                        Consolsales: Page "Salesperson Consolidated Sales";
                    begin
                        Consolsales.Run();
                    end;
                }
                field(YTDConsolidatedSales; YTDConsolidatedSales)
                {
                    ApplicationArea = all;
                    Caption = 'YTD Sales Consolidated';
                    DecimalPlaces = 0;
                    trigger OnDrillDown()
                    var
                        Consolsales: Page "Salesperson Consolidated Sales";
                    begin
                        Consolsales.Run();
                    end;
                }

            }
            cuegroup(Receivable)
            {
                Caption = 'Receivable';
                CuegroupLayout = Wide;
                field(TotalReceivable; TotalReceivable)
                {
                    Caption = 'Total Receivable';
                    ApplicationArea = all;
                    DecimalPlaces = 0;
                }
            }
            cuegroup(Inventory)
            {
                Caption = 'Inventory';
                CuegroupLayout = Wide;
                field(TotalInventoryValue; TotalInventoryValue)
                {
                    Caption = 'Total Inventory value';
                    ApplicationArea = all;
                    DecimalPlaces = 0;
                    trigger OnDrillDown()
                    var
                        consolinv: Page "Consol Inventory and valution";
                    begin
                        consolinv.Run();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        CLE: Record "Cust. Ledger Entry";
        company: Record Company;
        // configp_Pr_cus: Record "Kemipex Configuration Panel";
        BlockCust: Text[2000];
        usersetup: Record "User Setup";
        accountingperiod: Record "Accounting Period";
        FYstart: Date;
        item_rec: Record item;
        ItemTotalcost: Decimal;
        valueEntry: Record "Value Entry";
        CosolSalesCodeunit: codeunit "Consolidated Data";
        CustomerRec: Record Customer;
        DetailedCLE: Record "Detailed Cust. Ledg. Entry";
        RecShortName: Record "Company Short Name";//20MAY2022
    begin

        Clear(CMSalesthismonthconsoltemp);
        Clear(CCSalesthisMonth);
        Clear(CMSalesthismonthconsol);
        Clear(YTDConsolidatedSales);
        Clear(YTDConsolidatedSalesTemp);
        Clear(YTDCurrentCompanySales);
        Clear(TotalInventoryValue);
        Clear(TotalReceivable);

        FYstart := accountingperiod.GetFiscalYearStartDate(WorkDate());
        CurrentMonthStartDate := CalcDate('CM+1D-1M');
        BlockCust := CosolSalesCodeunit.reportexemptCustomers();

        company.SetFilter(Name, '<>%1', rec.CurrentCompany);
        repeat
            Clear(RecShortName);//20MAY2022
            RecShortName.SetRange(Name, company.Name);
            RecShortName.SetRange("Block in Reports", true);
            if not RecShortName.FindFirst() then begin

                valueEntry.Reset();
                valueEntry.ChangeCompany(company.Name);
                valueEntry.CalcSums("Cost Amount (Actual)");
                valueEntry.CalcSums("Cost Amount (Expected)");
                TotalInventoryValue += valueEntry."Cost Amount (Actual)" + valueEntry."Cost Amount (Expected)";
            end;
        until company.Next() = 0;

        YTDConsolidatedSales := CosolSalesCodeunit.ConsolidatedSales(FYstart, WorkDate(), '', true);
        CMSalesthismonthconsol := CosolSalesCodeunit.ConsolidatedSales(CurrentMonthStartDate, WorkDate(), '', true);
        CCSalesthisMonth := CosolSalesCodeunit.ConsolidatedSales(CurrentMonthStartDate, WorkDate(), '', false);
        TotalReceivable := CosolSalesCodeunit.ReceivableCalculation(false);
    end;

    var
        CCSalesthisMonth: Decimal;
        CMSalesthismonthconsoltemp: Decimal;
        CMSalesthismonthconsol: Decimal;
        YTDConsolidatedSales: Decimal;
        YTDConsolidatedSalesTemp: Decimal;
        YTDCurrentCompanySales: Decimal;
        TotalInventoryValue: Decimal;
        CurrentMonthStartDate: Date;
        TotalReceivable: Decimal;
        TotalReceivableDue: Decimal;
        ReserveredQty: Decimal;

    procedure CalculateReceivable() TotalRec: Decimal;
    var
        CLE: Record "Cust. Ledger Entry";
        company: Record Company;
        ConsolSalesCodeunit: codeunit "Consolidated Data";
        CustomerRec: Record Customer;
    begin
        // company.SetFilter(Name, '<>%1', rec.CurrentCompany);
        if company.FindSet() then
            repeat
                // CLE.Reset();
                // CLE.ChangeCompany(company.Name);
                // CLE.SetFilter("Customer No.", ConsolSalesCodeunit.reportexemptCustomers());
                // CLE.SetRange("IC Partner Code", '');
                // // CLE.SetRange(Open, true);
                // // CLE.SetRange(Prepayment, false);
                // repeat
                //     CLE.CalcFields("Remaining Amt. (LCY)");
                //     TotalRec += CLE."Remaining Amt. (LCY)";
                // until CLE.Next() = 0;

                CustomerRec.Reset();
                CustomerRec.ChangeCompany(company.Name);
                CustomerRec.SetRange("IC Partner Code", '');
                CustomerRec.SetFilter("No.", ConsolSalesCodeunit.reportexemptCustomers());
                if CustomerRec.FindSet() then
                    repeat
                        CustomerRec.CalcFields("Balance (LCY)");
                        TotalRec += CustomerRec."Balance (LCY)";
                    until CustomerRec.Next() = 0;
            until company.Next() = 0;
        exit(TotalRec);
    end;
}
//  begin
//         configp_Pr_cus.Get();
//         BlockCust := configp_Pr_cus."Production Customer";

//         Clear(CMSalesthismonthconsoltemp);
//         Clear(CCSalesthisMonth);
//         Clear(CMSalesthismonthconsol);
//         Clear(YTDConsolidatedSales);
//         Clear(YTDConsolidatedSalesTemp);
//         Clear(YTDCurrentCompanySales);
//         Clear(TotalInventoryValue);

//         FYstart := accountingperiod.GetFiscalYearStartDate(WorkDate());
//         CLE.SetRange("IC Partner Code", '');
//         CLE.SetFilter("Posting Date", '%1..t', FYstart);
//         CLE.SetFilter("Customer No.", BlockCust);
//         CLE.SetFilter(Prepayment, '%1', false);
//         CLE.CalcSums("Sales (LCY)");

//         YTDCurrentCompanySales := CLE."Sales (LCY)";

//         CLE.SetFilter("Posting Date", '1M..t');
//         CLE.CalcSums("Sales (LCY)");
//         CCSalesthisMonth := CLE."Sales (LCY)";

//         company.SetFilter(Name, '<>%1', CurrentCompany);
//         repeat
//             CLE.ChangeCompany(company.Name);
//             CLE.SetFilter("Posting Date", '%1..t', FYstart);
//             CLE.SetRange("IC Partner Code", '');

//             cle.CalcSums("Sales (LCY)");
//             YTDConsolidatedSales += CLE."Sales (LCY)";

//             CLE.SetFilter("Posting Date", '1M..t');
//             CLE.CalcSums("Sales (LCY)");
//             CMSalesthismonthconsol += CLE."Sales (LCY)";

//             valueEntry.Reset();
//             valueEntry.ChangeCompany(company.Name);
//             valueEntry.CalcSums("Cost Amount (Actual)");
//             valueEntry.CalcSums("Cost Amount (Expected)");
//             TotalInventoryValue += valueEntry."Cost Amount (Actual)" + valueEntry."Cost Amount (Expected)";

//         until company.Next() = 0;

//         /*    //valueEntry.ChangeCompany(company.Name);
//             valueEntry.CalcSums("Cost Amount (Actual)");
//             valueEntry.CalcSums("Cost Amount (Expected)");
//             TotalInventoryValue += valueEntry."Cost Amount (Actual)" + valueEntry."Cost Amount (Expected)";
//     */
//         CurrentMonthStartDate := CalcDate('CM+1D-1M');

//         YTDConsolidatedSales2 := CosolSalesCodeunit.ConsolidatedSales(FYstart, WorkDate(), '', true);
//         CMSalesthismonthconsol2 := CosolSalesCodeunit.ConsolidatedSales(CurrentMonthStartDate, WorkDate(), '', true);
//         CCSalesthisMonth2 := CosolSalesCodeunit.ConsolidatedSales(CurrentMonthStartDate, WorkDate(), '', false);
//     end;