page 58150 "Salesperson Consolidated Sales"//T12370-Full Comment    //T13413-Full UnComment
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Salesperson/Purchaser";
    Editable = false;
    DeleteAllowed = false;
    Caption = 'Sales Details';
    SourceTableView = sorting() where("Sales Blocked" = filter(false));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; rec.Code)
                {
                    ApplicationArea = all;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                }
                field(CurrentCompanySales; CMCurrentCompanySales)
                {
                    DecimalPlaces = 0;
                    ApplicationArea = all;
                    Caption = 'Sales This Month Curr. Company';
                }
                field(ConsolidatedSales; CMConsolidatedSales)
                {
                    DecimalPlaces = 0;
                    ApplicationArea = all;
                    Caption = 'Sales This Month Consolidated';
                }
                field(YTDConsolidatedSales; YTDConsolidatedSales)
                {
                    DecimalPlaces = 0;
                    ApplicationArea = all;
                    Caption = 'YTD Sales Consolidated';
                }

            }
        }
    }

    trigger OnAfterGetRecord()
    var
        CLE: Record "Cust. Ledger Entry";
        company: Record Company;
        accountingperiod: Record "Accounting Period";
        FYstart: Date;
        CosolSalesCodeunit: codeunit "Consolidated Data";
    begin
        FYstart := accountingperiod.GetFiscalYearStartDate(WorkDate());
        CurrentMonthStartDate := CalcDate('CM+1D-1M');
        CMCurrentCompanySales := CosolSalesCodeunit.ConsolidatedSales(CurrentMonthStartDate, WorkDate(), rec.Code, false);
        CMConsolidatedSales := CosolSalesCodeunit.ConsolidatedSales(CurrentMonthStartDate, WorkDate(), rec.Code, true);
        YTDConsolidatedSales := CosolSalesCodeunit.ConsolidatedSales(FYstart, WorkDate(), rec.Code, true);
    end;

    var
        CMConsolidatedSales: Decimal;
        CMCurrentCompanySales: Decimal;
        YTDConsolidatedSales: Decimal;
        CurrentMonthStartDate: Date;
}
//  begin
//         configp_Pr_cus.Get();
//         BlockCust := configp_Pr_cus."Production Customer";

//         Clear(CMCurrentCompanySales);
//         Clear(CMConsolidatedSales);
//         Clear(CMConsolidatedSalesTemp);
//         Clear(YTDConsolidatedSales);
//         Clear(YTDConsolidatedSalesTemp);
//         Clear(YTDCurrentCompanySales);
//         FYstart := accountingperiod.GetFiscalYearStartDate(WorkDate());
//         CLE.SetRange("IC Partner Code", '');
//         CLE.SetRange("Salesperson Code", rec.Code);
//         CLE.SetFilter("Posting Date", 'P');
//         CLE.SetFilter("Customer No.", BlockCust);
//         CLE.SetFilter(Prepayment, '%1', false);
//         CLE.CalcSums("Sales (LCY)");
//         CMCurrentCompanySales := CLE."Sales (LCY)";

//         CLE.SetRange("IC Partner Code", '');
//         CLE.SetRange("Salesperson Code", Code);
//         CLE.SetFilter("Posting Date", '%1..t', FYstart);
//         CLE.CalcSums("Sales (LCY)");
//         YTDCurrentCompanySales := CLE."Sales (LCY)";

//         company.SetFilter(Name, '<>%1', CurrentCompany);
//         repeat
//             cle.ChangeCompany(company.Name);
//             CLE.Reset();
//             CLE.SetRange("IC Partner Code", '');
//             CLE.SetRange("Salesperson Code", Code);
//             CLE.SetFilter("Posting Date", 'P');
//             CLE.CalcSums("Sales (LCY)");
//             CMConsolidatedSales += CLE."Sales (LCY)";

//             Cle.ChangeCompany(company.Name);
//             CLE.Reset();
//             CLE.SetRange("IC Partner Code", '');
//             CLE.SetRange("Salesperson Code", Code);
//             CLE.SetFilter("Posting Date", '%1..t', FYstart);
//             CLE.CalcSums("Sales (LCY)");
//             YTDConsolidatedSales += CLE."Sales (LCY)";

//         until company.Next() = 0;
//     end;