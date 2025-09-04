page 58167 "Salesperson Activity Cue"//T12370-Full Comment      //T13413-Full UnComment
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Sales Details';
    SourceTable = Customer;

    layout
    {
        area(Content)
        {
            cuegroup("Sales Details")
            {
                CuegroupLayout = Wide;
                Caption = 'Your Sales Details';
                field(CMSalesthismonthconsol; CMSalesthismonthconsol)
                {
                    Caption = 'Your Sales This Month Consolildated';
                    ApplicationArea = all;
                    DecimalPlaces = 0;
                    trigger OnDrillDown()
                    var
                        SP: Record "Salesperson/Purchaser";
                    begin
                        sp.Reset();
                        sp.SetFilter(Code, TeamFilterProcedure());
                        page.Run(Page::"Salesperson Consolidated Sales", SP);
                    end;
                }
                field(YTDConsolidatedSales; YTDConsolidatedSales)
                {
                    ApplicationArea = all;
                    Caption = 'Your YTD Sales Consolidated';
                    DecimalPlaces = 0;
                    trigger OnDrillDown()
                    var
                        SP: Record "Salesperson/Purchaser";
                    begin
                        sp.Reset();
                        sp.SetFilter(Code, TeamFilterProcedure());
                        page.Run(Page::"Salesperson Consolidated Sales", SP);
                    end;
                }
            }

            cuegroup("Team Sales Details")
            {
                Caption = 'Team Sales Details';
                Visible = true;
                CuegroupLayout = Wide;
                field(teamCMSalesthismonthconsol; teamCMSalesthismonthconsol)
                {
                    Caption = 'Team Sales This Month Consolildated';
                    ApplicationArea = all;
                    DecimalPlaces = 0;
                    trigger OnDrillDown()
                    var
                        SP: Record "Salesperson/Purchaser";
                    begin
                        sp.Reset();
                        sp.SetFilter(Code, TeamFilterProcedure());
                        page.Run(Page::"Salesperson Consolidated Sales", SP);
                    end;
                }

                field(teamYTDConsolidatedSales; teamYTDConsolidatedSales)
                {
                    ApplicationArea = all;
                    Caption = 'Team YTD Sales Consolidated';
                    DecimalPlaces = 0;
                    trigger OnDrillDown()
                    var
                        SP: Record "Salesperson/Purchaser";
                    begin
                        sp.Reset();
                        sp.SetFilter(Code, TeamFilterProcedure());
                        page.Run(Page::"Salesperson Consolidated Sales", SP);
                    end;
                }
            }

            cuegroup(Other)
            {
                Caption = 'Item Details';
                Visible = true;
                actions
                {
                    action(Inventory)
                    {
                        ApplicationArea = all;
                        Caption = 'Item Price & Consolidated Inventory';
                        Image = TileBrickProducts;
                        trigger OnAction()
                        var
                            ItemInventory: Page ConsolInventoryNPriceforSales;
                        begin
                            ItemInventory.Run();
                        end;
                    }
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
        teamsalestemp: Record "Team Salesperson";
        teamsales: Record "Team Salesperson";
        jc: Text;
        accountingperiod: Record "Accounting Period";
        FYstart: Date;
        CosolSalesCodeunit: codeunit "Consolidated Data";
        CurrentMonthStartDate: Date;

    begin
        CurrentMonthStartDate := CalcDate('CM+1D-1M');
        FYstart := accountingperiod.GetFiscalYearStartDate(WorkDate());

        if usersetup.Get(UserId) then;
        teamsalestemp.SetRange("Salesperson Code", usersetup."Salespers./Purch. Code");
        if teamsalestemp.FindFirst() then begin
            TeamCode := teamsalestemp."Team Code";
        end;

        CMSalesthismonthconsol := CosolSalesCodeunit.ConsolidatedSales(CurrentMonthStartDate, WorkDate(), usersetup."Salespers./Purch. Code", true);
        YTDConsolidatedSales := CosolSalesCodeunit.ConsolidatedSales(FYstart, WorkDate(), usersetup."Salespers./Purch. Code", true);
        teamCMSalesthismonthconsol := CosolSalesCodeunit.ConsolidatedTeamSales(CurrentMonthStartDate, WorkDate(), true, TeamCode);
        teamYTDConsolidatedSales := CosolSalesCodeunit.ConsolidatedTeamSales(FYstart, WorkDate(), true, TeamCode);
    end;

    procedure TeamFilterProcedure() FilterText: Text[2000];
    var
        Consolsales: Page "Salesperson Consolidated Sales";
        SP: Record "Salesperson/Purchaser";
        usersetup: Record "User Setup";
        teamsalestemp: Record "Team Salesperson";
        teamsales: Record "Team Salesperson";
        jc: Text;

    begin
        usersetup.Get(UserId);
        teamsalestemp.SetRange("Salesperson Code", usersetup."Salespers./Purch. Code");
        if teamsalestemp.FindFirst() then
            teamsales.SetRange("Team Code", teamsalestemp."Team Code");

        if teamsales.FindSet() then begin
            jc := '';
            repeat
                TeamSPFilter += jc + teamsales."Salesperson Code";
                jc := '|';
            until teamsales.Next() = 0;
        end;
        FilterText := TeamSPFilter;
        exit(FilterText)
    end;

    var
        CCSalesthisMonth: Decimal;
        CMSalesthismonthconsoltemp: Decimal;
        CMSalesthismonthconsol: Decimal;
        YTDConsolidatedSales: Decimal;
        YTDConsolidatedSalesTemp: Decimal;
        YTDCurrentCompanySales: Decimal;
        teamCCSalesthisMonth: Decimal;
        teamCMSalesthismonthconsol: Decimal;
        teamYTDConsolidatedSales: Decimal;
        teamYTDCurrentCompanySales: Decimal;
        Name2: Text;
        TeamSPFilter: Text[2000];
        TotalCompanySales: Decimal;
        CMSalesthismonthconsol2: Decimal;
        YTDConsolidatedSales2: Decimal;
        teamCMSalesthismonthconsol2: Decimal;
        teamYTDConsolidatedSales2: Decimal;
        TeamCode: Code[20];
}


//  begin
//         Clear(TeamSPFilter);
//         Clear(jc);
//         usersetup.Get(UserId);
//         Name := usersetup."User ID";
//         configp_Pr_cus.Get();
//         BlockCust := configp_Pr_cus."Production Customer";
//         FYstart := accountingperiod.GetFiscalYearStartDate(WorkDate());

//         if usersetup.Get(UserId) then begin
//             CLE.SetFilter("Salesperson Code", usersetup."Salespers./Purch. Code");

//         end
//         else begin
//             exit;
//         end;

//         Clear(CMSalesthismonthconsoltemp);
//         Clear(CCSalesthisMonth);
//         Clear(CMSalesthismonthconsol);
//         Clear(YTDConsolidatedSales);
//         Clear(YTDConsolidatedSalesTemp);
//         Clear(YTDCurrentCompanySales);

//         CLE.SetRange("IC Partner Code", '');
//         CLE.SetFilter("Posting Date", '%1..t', FYstart);
//         CLE.SetFilter("Customer No.", BlockCust);
//         CLE.CalcSums("Sales (LCY)");
//         YTDCurrentCompanySales := CLE."Sales (LCY)";

//         CLE.SetFilter("Posting Date", '1M..t');
//         CLE.CalcSums("Sales (LCY)");
//         CCSalesthisMonth := CLE."Sales (LCY)";

//         company.SetFilter(Name, '<>%1', CurrentCompany);
//         repeat
//             CLE.ChangeCompany(company.Name);
//             CLE.SetRange("IC Partner Code", '');
//             CLE.SetFilter("Posting Date", '%1..t', FYstart);

//             CLE.CalcSums("Sales (LCY)");
//             YTDConsolidatedSales += CLE."Sales (LCY)";

//             CLE.SetFilter("Posting Date", '1M..t');
//             CLE.CalcSums("Sales (LCY)");
//             CMSalesthismonthconsol += CLE."Sales (LCY)";

//         until company.Next() = 0;

//         teamsalestemp.SetRange("Salesperson Code", usersetup."Salespers./Purch. Code");
//         if teamsalestemp.FindFirst() then begin
//             teamsales.SetRange("Team Code", teamsalestemp."Team Code");
//             TeamCode := teamsalestemp."Team Code";
//         end;

//         if teamsales.FindSet() then begin
//             jc := '';
//             repeat
//                 TeamSPFilter += jc + teamsales."Salesperson Code";
//                 jc := '|';
//             until teamsales.Next() = 0;

//             Clear(CLE);
//             Clear(company);
//             Clear(teamCMSalesthismonthconsol);
//             Clear(teamCCSalesthisMonth);
//             Clear(teamYTDConsolidatedSales);
//             Clear(teamYTDCurrentCompanySales);

//             company.SetFilter(Name, '<>%1', CurrentCompany);
//             repeat

//                 CLE.SetRange("IC Partner Code", '');
//                 CLE.SetFilter("Posting Date", '%1..t', FYstart);
//                 CLE.SetFilter("Customer No.", BlockCust);
//                 CLE.SetFilter("Salesperson Code", TeamSPFilter);
//                 CLE.CalcSums("Sales (LCY)");
//                 teamYTDCurrentCompanySales := CLE."Sales (LCY)";

//                 CLE.SetFilter("Posting Date", '1M..t');
//                 CLE.CalcSums("Sales (LCY)");
//                 teamCCSalesthisMonth := CLE."Sales (LCY)";

//                 repeat
//                     CLE.ChangeCompany(company.Name);
//                     CLE.SetRange("IC Partner Code", '');
//                     CLE.SetFilter("Posting Date", '%1..t', FYstart);

//                     cle.CalcSums("Sales (LCY)");
//                     teamYTDConsolidatedSales += CLE."Sales (LCY)";

//                     CLE.SetFilter("Posting Date", '1M..t');
//                     CLE.CalcSums("Sales (LCY)");
//                     teamCMSalesthismonthconsol += CLE."Sales (LCY)";
//                 until company.Next() = 0;
//             until teamsales.Next() = 0;
//         end;

//         CurrentMonthStartDate := CalcDate('CM+1D-1M');
//         CMSalesthismonthconsol2 := CosolSalesCodeunit.ConsolidatedSales(CurrentMonthStartDate, WorkDate(), usersetup."Salespers./Purch. Code", true);
//         YTDConsolidatedSales2 := CosolSalesCodeunit.ConsolidatedSales(FYstart, WorkDate(), usersetup."Salespers./Purch. Code", true);
//         teamCMSalesthismonthconsol2 := CosolSalesCodeunit.ConsolidatedTeamSales(CurrentMonthStartDate, WorkDate(), true, TeamCode);
//         teamYTDConsolidatedSales2 := CosolSalesCodeunit.ConsolidatedTeamSales(FYstart, WorkDate(), true, TeamCode);
//     end;


// procedure TeamFilterProcedure() FilterText: Text[200];
// var
//     Consolsales: Page "Salesperson Consolidated Sales";
//     SP: Record "Salesperson/Purchaser";
//     usersetup: Record "User Setup";
//     teamsalestemp: Record "Team Salesperson";
//     teamsales: Record "Team Salesperson";
//     jc: Text;

// begin
//     usersetup.Get(UserId);
//     teamsalestemp.SetRange("Salesperson Code", usersetup."Salespers./Purch. Code");
//     if teamsalestemp.FindFirst() then
//         teamsales.SetRange("Team Code", teamsalestemp."Team Code");

//     if teamsales.FindSet() then begin
//         jc := '';
//         repeat
//             TeamSPFilter += jc + teamsales."Salesperson Code";
//             jc := '|';
//         until teamsales.Next() = 0;
//     end;
//     FilterText := TeamSPFilter;
//     exit(FilterText)
// end;