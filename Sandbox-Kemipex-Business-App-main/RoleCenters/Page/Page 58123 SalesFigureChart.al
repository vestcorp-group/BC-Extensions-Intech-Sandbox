page 58123 SalesFigureChart//T12370-Full Comment    //T13413-Full UnComment
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Consolidated Sales Figure';
    SourceTable = "Team Salesperson";

    layout
    {
        area(Content)
        {
            usercontrol(chart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = all;
                trigger AddInReady()
                var
                    Buffer: Record "Business Chart Buffer";
                    SalepersonTeam: Record "Team Salesperson";
                    CustomerLedgerEntries: Record "Cust. Ledger Entry";
                    Salesperson: Record "Salesperson/Purchaser";
                    Company: Record Company;
                    customer: Record Customer;
                    i: Integer;
                    FYstart: Date;
                    accountingperiod: Record "Accounting Period";
                    BlockCust: Text[2000];
                    // configp_Pr_cus: Record "Kemipex Configuration Panel";
                    CosolSalesCodeunit: codeunit "Consolidated Data";
                    TeamMaster: Record Team;
                    CurrentMonthStartDate: Date;
                    ConsolSalesCodeunit: codeunit "Consolidated Data";

                begin
                    FYstart := accountingperiod.GetFiscalYearStartDate(WorkDate());
                    CurrentMonthStartDate := CalcDate('CM+1D-1M');
                    BlockCust := CosolSalesCodeunit.reportexemptCustomers();
                    // configp_Pr_cus.Get();
                    // BlockCust := configp_Pr_cus."Production Customer";

                    Buffer.Initialize();
                    Buffer.AddMeasure('Year to Date Sales', 1, Buffer."Data Type"::Decimal, Buffer."Chart Type"::Column.AsInteger());//30-04-2022 added sainteger with enum
                    Buffer.AddMeasure('Month to Date Sales', 1, Buffer."Data Type"::Decimal, Buffer."Chart Type"::Column.AsInteger());//30-04-2022 added sainteger with enum
                    Buffer.SetXAxis('Customer', Buffer."Data Type"::String);

                    TeamMaster.SetRange("Hide From Reports", false);
                    if TeamMaster.FindSet() then
                        repeat
                            Buffer.AddColumn(TeamMaster.Name);
                            SalepersonTeam.SetRange("Team Code", TeamMaster.Code);
                            if SalepersonTeam.FindSet() then
                                repeat


                                    SPSales := ConsolSalesCodeunit.ConsolidatedTeamSales(FYstart, WorkDate(), true, SalepersonTeam."Team Code");
                                    CMConsolidatedSales := ConsolSalesCodeunit.ConsolidatedTeamSales(CurrentMonthStartDate, WorkDate(), true, SalepersonTeam."Team Code");
                                    //     if Company.FindSet() then begin
                                    //         repeat

                                    //             //YTD
                                    //             // CustomerLedgerEntries.ChangeCompany(company.Name);
                                    //             // CustomerLedgerEntries.SetFilter("Customer No.", BlockCust);
                                    //             // CustomerLedgerEntries.SetRange("IC Partner Code", '');
                                    //             // CustomerLedgerEntries.SetRange("Salesperson Code", SalepersonTeam."Salesperson Code");
                                    //             // CustomerLedgerEntries.SetFilter("Posting Date", '%1..t', FYstart);
                                    //             // CustomerLedgerEntries.CalcSums("Sales (LCY)");
                                    //             // SPSales += CustomerLedgerEntries."Sales (LCY)";
                                    //             SPSales += ConsolSalesCodeunit.ConsolidatedSales(FYstart, WorkDate(), SalepersonTeam."Salesperson Code", true);

                                    //             //Monthly
                                    //             // CustomerLedgerEntries.ChangeCompany(company.Name);
                                    //             // CustomerLedgerEntries.SetFilter("Customer No.", BlockCust);
                                    //             // CustomerLedgerEntries.SetRange("IC Partner Code", '');
                                    //             // CustomerLedgerEntries.SetRange("Salesperson Code", SalepersonTeam."Salesperson Code");
                                    //             // CustomerLedgerEntries.SetFilter("Posting Date", 'P');
                                    //             // CustomerLedgerEntries.CalcSums("Sales (LCY)");
                                    //             // CMConsolidatedSales += CustomerLedgerEntries."Sales (LCY)";
                                    //             CMConsolidatedSales += ConsolSalesCodeunit.ConsolidatedSales(CurrentMonthStartDate, WorkDate(), SalepersonTeam."Salesperson Code", true);

                                    //         until company.Next() = 0;
                                    if SPSales <> 0 then begin
                                        Buffer.SetValueByIndex(0, i, SPSales);
                                        //  Buffer.SetValue('Sales', i, CMConsolidatedSales);
                                        Buffer.SetValueByIndex(1, i, CMConsolidatedSales);
                                    end;
                                //     end;

                                until SalepersonTeam.Next() = 0;
                            i += 1;
                            Clear(SPSales);
                            Clear(CMConsolidatedSales);
                        until TeamMaster.Next() = 0;
                    Buffer.Update(CurrPage.chart);
                end;
            }
        }
    }

    var
        SPSales: Decimal;
        CMConsolidatedSales: Decimal;
        YTDConsolidatedSales: Decimal;
}

/*       CustomerLedgerEntries.ChangeCompany(company.Name);
                                CustomerLedgerEntries.SetRange("IC Partner Code", '');
                                CustomerLedgerEntries.SetRange("Salesperson Code", Salesperson.Code);
                                CustomerLedgerEntries.SetFilter("Posting Date", 'P');
                                CustomerLedgerEntries.CalcSums("Sales (LCY)");
                                CMConsolidatedSales += CustomerLedgerEntries."Sales (LCY)";
*/

/*  CustomerLedgerEntries.SetRange("Salesperson Code", Salesperson.Code);
                         CustomerLedgerEntries.SetFilter("Posting Date", '%1..t', FYstart);
                         CustomerLedgerEntries.SetRange("IC Partner Code", '');
                         CustomerLedgerEntries.CalcSums("Sales (LCY)");
                         SPSales := CustomerLedgerEntries."Sales (LCY)";
                         */

/*    if Salesperson.FindSet() then
repeat
Clear(SPSales);
if Salesperson."Privacy Blocked" = false then begin
buffer.AddColumn(Salesperson."Short Name");
//company.SetFilter(Name, '<>%1', rec.CurrentCompany);
if Company.FindSet() then
repeat
    CustomerLedgerEntries.ChangeCompany(company.Name);
    CustomerLedgerEntries.SetRange("IC Partner Code", '');
    CustomerLedgerEntries.SetRange("Salesperson Code", Salesperson.Code);
    CustomerLedgerEntries.SetFilter("Posting Date", '%1..t', FYstart);
    CustomerLedgerEntries.CalcSums("Sales (LCY)");
    SPSales += CustomerLedgerEntries."Sales (LCY)";
until company.Next() = 0;
if SPSales <> 0 then begin
Buffer.SetValueByIndex(0, i, SPSales);
end;
i += 1;
end;
until Salesperson.Next() = 0;
*/






//    begin
//                     FYstart := accountingperiod.GetFiscalYearStartDate(WorkDate());
//                     CurrentMonthStartDate := CalcDate('CM+1D-1M');

//                     configp_Pr_cus.Get();
//                     BlockCust := configp_Pr_cus."Production Customer";

//                     Buffer.Initialize();
//                     Buffer.AddMeasure('Year to Date Sales', 1, Buffer."Data Type"::Decimal, Buffer."Chart Type"::Column);
//                     Buffer.AddMeasure('Month to Date Sales', 1, Buffer."Data Type"::Decimal, Buffer."Chart Type"::Column);
//                     Buffer.SetXAxis('Customer', Buffer."Data Type"::String);

//                     TeamMaster.SetRange("Hide From Reports", false);
//                     if TeamMaster.FindSet() then
//                         repeat
//                             Buffer.AddColumn(TeamMaster.Name);
//                             SalepersonTeam.SetRange("Team Code", TeamMaster.Code);
//                             if SalepersonTeam.FindSet() then
//                                 repeat
//                                     if Company.FindSet() then begin
//                                         repeat


//                                             //YTD
//                                             // CustomerLedgerEntries.ChangeCompany(company.Name);
//                                             // CustomerLedgerEntries.SetFilter("Customer No.", BlockCust);
//                                             // CustomerLedgerEntries.SetRange("IC Partner Code", '');
//                                             // CustomerLedgerEntries.SetRange("Salesperson Code", SalepersonTeam."Salesperson Code");
//                                             // CustomerLedgerEntries.SetFilter("Posting Date", '%1..t', FYstart);
//                                             // CustomerLedgerEntries.CalcSums("Sales (LCY)");
//                                             // SPSales += CustomerLedgerEntries."Sales (LCY)";
//                                             SPSales += ConsolSalesCodeunit.ConsolidatedSales(FYstart, WorkDate(), SalepersonTeam."Salesperson Code", true);

//                                             //Monthly
//                                             // CustomerLedgerEntries.ChangeCompany(company.Name);
//                                             // CustomerLedgerEntries.SetFilter("Customer No.", BlockCust);
//                                             // CustomerLedgerEntries.SetRange("IC Partner Code", '');
//                                             // CustomerLedgerEntries.SetRange("Salesperson Code", SalepersonTeam."Salesperson Code");
//                                             // CustomerLedgerEntries.SetFilter("Posting Date", 'P');
//                                             // CustomerLedgerEntries.CalcSums("Sales (LCY)");
//                                             // CMConsolidatedSales += CustomerLedgerEntries."Sales (LCY)";
//                                             CMConsolidatedSales += ConsolSalesCodeunit.ConsolidatedSales(CurrentMonthStartDate, WorkDate(), SalepersonTeam."Salesperson Code", true);


//                                         until company.Next() = 0;
//                                         if SPSales <> 0 then begin
//                                             Buffer.SetValueByIndex(0, i, SPSales);
//                                             //  Buffer.SetValue('Sales', i, CMConsolidatedSales);
//                                             Buffer.SetValueByIndex(1, i, CMConsolidatedSales);
//                                         end;
//                                     end;
//                                 until SalepersonTeam.Next() = 0;
//                             i += 1;
//                             Clear(SPSales);
//                             Clear(CMConsolidatedSales);
//                         until TeamMaster.Next() = 0;
//                     Buffer.Update(CurrPage.chart);
//                 end;
