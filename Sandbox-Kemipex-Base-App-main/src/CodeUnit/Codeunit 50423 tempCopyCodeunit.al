// codeunit 50423 tempCopyCodeunit
// {
//     Permissions = tabledata "Sales Cr.Memo Line" = rm,
//     tabledata "Sales Cr.Memo Header" = rm,
//     tabledata "Sales Invoice Header" = rm,
//     tabledata "Sales Shipment Header" = rm,
//     tabledata "Sales Header" = rm;

//     trigger OnRun()
//     begin

//     end;

//     // procedure CopyPostedSalesCreditMemoLineData()
//     // var
//     //     RecRef: RecordRef;
//     //     DocNo: FieldRef;
//     //     ItemDec: FieldRef;
//     //     BaseUOMFrom: FieldRef;
//     //     BaseUOMTo: FieldRef;
//     //     PriceFrom: FieldRef;
//     //     PriceTo: FieldRef;
//     // begin
//     //     RecRef.Open(Database::"Sales Cr.Memo Line");
//     //     DocNo := RecRef.Field(3);
//     //     ItemDec := RecRef.Field(6);
//     //     BaseUOMFrom := RecRef.Field(50006);
//     //     BaseUOMTo := RecRef.Field(50100);
//     //     PriceFrom := RecRef.Field(50015);
//     //     PriceTo := RecRef.Field(50107);
//     //     if RecRef.FindSet() then
//     //         repeat
//     //             BaseUOMTo.Value := BaseUOMFrom.Value;
//     //             PriceTo.Value := PriceFrom.Value;
//     //             RecRef.Modify();
//     //         until RecRef.Next() = 0;
//     //     RecRef.Close();
//     // end;

//     procedure CopypostedSalesCreditMemoHeaderData()
//     var
//         RecRef: RecordRef;
//         BankFrom: FieldRef;
//         BankTo: FieldRef;
//         InspectionFrm: FieldRef;
//         InspectionTo: FieldRef;
//         LegalizationFrom: FieldRef;
//         LegalizatonTo: FieldRef;
//         LCNoFrom: FieldRef;
//         LCNoTo: FieldRef;
//         LCDateFrom: FieldRef;
//         LCDateTo: FieldRef;
//         SellerBuyerfrom: FieldRef;
//         sellterBuyerTo: FieldRef;


//     begin
//         RecRef.Open(Database::"Sales Cr.Memo Header");
//         // BankFrom := RecRef.Field(50005);
//         // BankTo := RecRef.Field(50100);
//         // InspectionFrm := RecRef.Field(50006);
//         // InspectionTo := RecRef.Field(50101);
//         // LegalizationFrom := RecRef.Field(50007);
//         // LegalizatonTo := RecRef.Field(50102);
//         // LCNoFrom := RecRef.Field(50008);
//         // LCNoTo := RecRef.Field(50103);
//         // LCDateFrom := RecRef.Field(50009);
//         // LCDateTo := RecRef.Field(50104);
//         SellerBuyerfrom := RecRef.Field(50010);
//         sellterBuyerTo := RecRef.Field(50011);

//         if RecRef.FindSet() then
//             repeat
//                 // BankTo.Value := BankFrom.Value;
//                 // InspectionTo.Value := InspectionFrm.Value;
//                 // LegalizatonTo.Value := LegalizationFrom.Value;
//                 // LCNoTo.Value := LCNoFrom.Value;
//                 // LCDateTo.Value := LCDateFrom.Value;
//                 sellterBuyerTo.Value := SellerBuyerfrom.Value;
//                 RecRef.Modify();
//             until RecRef.Next() = 0;
//         RecRef.Close();
//     end;

//     procedure CopySalesInvoiceHeaderData()
//     var
//         RecRef: RecordRef;
//         SellerBuyerfrom: FieldRef;
//         sellerBuyerTo: FieldRef;
//     begin
//         RecRef.Open(Database::"Sales Invoice Header");
//         SellerBuyerfrom := RecRef.Field(50010);
//         sellerBuyerTo := RecRef.Field(50011);
//         if RecRef.FindSet() then
//             repeat
//                 sellerBuyerTo.Value := SellerBuyerfrom.Value;
//                 RecRef.Modify()
//             until RecRef.Next() = 0;
//     end;

//     procedure CopySalesShipmentHeaderData()
//     var
//         RecRef: RecordRef;
//         SellerBuyerfrom: FieldRef;
//         sellerBuyerTo: FieldRef;
//     begin
//         RecRef.Open(Database::"Sales Shipment Header");
//         SellerBuyerfrom := RecRef.Field(50010);
//         sellerBuyerTo := RecRef.Field(50011);
//         if RecRef.FindSet() then
//             repeat
//                 sellerBuyerTo.Value := SellerBuyerfrom.Value;
//                 RecRef.Modify()
//             until RecRef.Next() = 0;

//         RecRef.Close();
//     end;

//     procedure CopySalesHeaderData()
//     var
//         RecRef: RecordRef;
//         SellerBuyerfrom: FieldRef;
//         sellerBuyerTo: FieldRef;
//         BankOnFrom: FieldRef;
//         BankOnTo: FieldRef;
//         InspectionFrom: FieldRef;
//         inspectionTo: FieldRef;
//         LegalizationFrom: FieldRef;
//         LegalizationTo: FieldRef;
//         LCNoFrom: FieldRef;
//         LCNoTo: FieldRef;
//         LCDateFrom: FieldRef;
//         LCDateTo: FieldRef;

//     begin

//         RecRef.Open(Database::"Sales Header");

//         if RecRef.FindSet() then
//             repeat

//                 SellerBuyerfrom := RecRef.Field(50010);
//                 sellerBuyerTo := RecRef.Field(50011);
//                 BankOnFrom := RecRef.Field(50005);
//                 BankOnTo := RecRef.Field(50012);
//                 sellerBuyerTo.Value := SellerBuyerfrom.Value;
//                 RecRef.Modify()
//             until RecRef.Next() = 0;
//         RecRef.Close();
//     end;

// }