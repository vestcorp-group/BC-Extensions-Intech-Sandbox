// query 53041 CurrencyExchangeAPI//T12370-Full Comment
// {
//     QueryType = Normal;
//     Caption = 'BI Currency Exchange Rate';

//     elements
//     {
//         dataitem(Currency_Exchange_Rate; "Currency Exchange Rate")
//         {
//             column(Currency_Code; "Currency Code") { }
//             column(Starting_Date; "Starting Date") { }
//             column(Relational_Currency_Code; "Relational Currency Code") { }
//             column(Exchange_Rate_Amount; "Exchange Rate Amount") { }
//             column(Relational_Exch__Rate_Amount; "Relational Exch. Rate Amount") { }

//         }
//     }

//     var
//         myInt: Integer;

//     trigger OnBeforeOpen()
//     begin

//     end;
// }