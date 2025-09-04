// report 58187 UpdateFXSalesPrice//T12370-Full Comment
// {
//     UsageCategory = Administration;
//     ApplicationArea = All;
//     ProcessingOnly = true;
//     Caption = 'Update FX Adjusted Item Price';

//     dataset
//     {
// #pragma warning disable AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
//         dataitem("Sales Price"; "Sales Price")
// #pragma warning restore AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
//         {
//             trigger OnAfterGetRecord()
//             var
//                 FXrec: Record "Currency Exchange Rate";
//             begin
// #pragma warning disable AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
//                 "Unit Price" := FXRec.ExchangeAmtFCYToLCY(WorkDate(), "Currency 2", "Unit Price 2", FXRec.GetCurrentCurrencyFactor("Currency 2"));
// #pragma warning restore AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
//                 if Modify() then;
//             end;
//         }
//     }

//     /* trigger OnRun()
//      var
//          FXrec: Record "Currency Exchange Rate";
//      begin
//          //SalesPrice."Unit Price" := FXRec.ExchangeAmtFCYToLCY(WorkDate(), SalesPrice."Currency 2", SalesPrice."Unit Price 2", FXRec.GetCurrentCurrencyFactor(SalesPrice."Currency 2"));
//      end;
//      var
//  */
// }