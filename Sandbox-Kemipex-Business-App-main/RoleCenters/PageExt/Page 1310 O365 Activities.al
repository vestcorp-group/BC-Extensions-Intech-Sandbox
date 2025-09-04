// pageextension 58132 Businessmanageractivitymage extends "O365 Activities"//T12370-Full Comment
// {
//     layout
//     {
//         addafter("Sales This Month")
//         {
//             /*  field(CCSalesthisMonth; CCSalesthisMonth)
//               {
//                   ApplicationArea = all;
//                   Caption = 'Sales This Month Curr. Company';
//                   DecimalPlaces = 0;
//                   trigger OnDrillDown()
//                   var
//                       Consolsales: Page consolidatedSalesdetails;
//                   begin
//                       Consolsales.Run();
//                   end;
//               }
//               field(CMSalesthismonthconsol; CMSalesthismonthconsol)
//               {
//                   Caption = 'Sales This Month Consolildated';
//                   ApplicationArea = all;
//                   DecimalPlaces = 0;
//                   trigger OnDrillDown()
//                   var
//                       Consolsales: Page consolidatedSalesdetails;
//                   begin
//                       Consolsales.Run();
//                   end;
//               }
//               field(YTDConsolidatedSales; YTDConsolidatedSales)
//               {
//                   ApplicationArea = all;
//                   Caption = 'YTD Sales Consolidated';
//                   DecimalPlaces = 0;
//                   trigger OnDrillDown()
//                   var
//                       Consolsales: Page consolidatedSalesdetails;
//                   begin
//                       Consolsales.Run();
//                   end;
//               }
//               */
//         }
//         modify("Sales This Month")
//         {
//             Visible = false;
//         }
//         modify("Overdue Purch. Invoice Amount")
//         {
//             Visible = false;
//         }
//         modify("Overdue Sales Invoice Amount")
//         {
//             Visible = false;
//         }
//     }
//     trigger OnAfterGetRecord()
//     var
//         CLE: Record "Cust. Ledger Entry";
//         company: Record Company;
//         // configp_Pr_cus: Record "Kemipex Configuration Panel";
//         BlockCust: Text[2000];
//         usersetup: Record "User Setup";
//     begin
//         /*  configp_Pr_cus.Get();
//           BlockCust := configp_Pr_cus."Production Customer";

//           Clear(CMSalesthismonthconsoltemp);
//           Clear(CCSalesthisMonth);
//           Clear(CMSalesthismonthconsol);
//           Clear(YTDConsolidatedSales);
//           Clear(YTDConsolidatedSalesTemp);
//           Clear(YTDCurrentCompanySales);

//           CLE.SetRange("IC Partner Code", '');
//           CLE.SetFilter("Posting Date", 'P1..t');
//           CLE.SetFilter("Customer No.", BlockCust);
//           CLE.CalcSums("Sales (LCY)");
//           YTDCurrentCompanySales := CLE."Sales (LCY)";

//           CLE.SetFilter("Posting Date", '1M..t');
//           CLE.CalcSums("Sales (LCY)");
//           CCSalesthisMonth := CLE."Sales (LCY)";

//           repeat
//               CLE.ChangeCompany(company.Name);
//               CLE.SetRange("IC Partner Code", '');
//               CLE.SetFilter("Posting Date", 'P1..t');

//               cle.CalcSums("Sales (LCY)");
//               YTDConsolidatedSalesTemp += CLE."Sales (LCY)";

//               CLE.SetFilter("Posting Date", '1M..t');
//               CLE.CalcSums("Sales (LCY)");
//               CMSalesthismonthconsoltemp += CLE."Sales (LCY)";

//           until company.Next() = 0;
//           CMSalesthismonthconsol := CMSalesthismonthconsoltemp - CCSalesthisMonth;
//           YTDConsolidatedSales := YTDConsolidatedSalesTemp - YTDCurrentCompanySales;
//           */
//     end;

//     var
//         CCSalesthisMonth: Decimal;
//         CMSalesthismonthconsoltemp: Decimal;
//         CMSalesthismonthconsol: Decimal;
//         YTDConsolidatedSales: Decimal;
//         YTDConsolidatedSalesTemp: Decimal;
//         YTDCurrentCompanySales: Decimal;
// }