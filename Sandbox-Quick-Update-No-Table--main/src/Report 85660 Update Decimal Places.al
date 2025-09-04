//Testing Purpose only
// report 85660 "Update Decimal Places"
// {
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;
//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem(Integer; Integer)
//         {
//             DataItemTableView = sorting(Number) where(Number = const(1));
//             trigger OnAfterGetRecord()
//             var
//                 myInt: Integer;
//                 check_L: Text;
//             begin
//                 check_L := DecimalPlacse_lFnc(DecimalValue_gDec, Places_gInt);
//                 Message(check_L);
//             end;
//         }
//     }
//     requestpage
//     {
//         SaveValues = true;
//         layout
//         {
//             area(Content)
//             {
//                 field("Decimal Values"; DecimalValue_gDec)
//                 {
//                     ApplicationArea = All;
//                     DecimalPlaces = 0 : 5;
//                 }
//                 field("Decimal Places"; Places_gInt)
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//         }

//     }
//     local procedure DecimalPlacse_lFnc(DecValue_iDec: Decimal; Places_iInt: Integer): Text
//     var
//         FormatString: Text;
//         Check: Text;
//     begin
//         if Places_iInt > 0 then begin
//             FormatString := '<Precision,' + Format(Places_iInt + 1) + '>' + '<sign><Integer Thousand>' + '<Decimals,' + Format(Places_iInt + 1) + '>';
//             Check := Format(DecValue_iDec, 0, FormatString);
//             exit(Check);
//         end else
//             exit(Format(DecValue_iDec));
//     end;

//     var
//         DecimalValue_gDec: Decimal;
//         Places_gInt: Integer;
// }