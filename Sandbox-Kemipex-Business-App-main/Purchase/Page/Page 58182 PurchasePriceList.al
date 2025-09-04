// page 58182 PurchasePriceList//T12370-Full Comment
// {
//     PageType = List;
//     ApplicationArea = All;
//     UsageCategory = Lists;
//     SourceTable = KMP_PurchasePriceList;
//     Caption = 'Purchase Price List';
//     DeleteAllowed = false;

//     layout
//     {
//         area(Content)
//         {
//             repeater(GroupName)
//             {
//                 field(Date; rec.Date)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Vendor; rec.Vendor)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Vendor Code';
//                 }
//                 field("Vendor Name"; rec."Vendor Name")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(User; rec.User)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Source; rec.Source)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Item Code"; rec."Item Code")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Item Name"; rec."Item Name")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Unit; rec.Unit)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Currency; rec.Currency)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Unit Price"; rec."Unit Price")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Incoterm; rec.Incoterm)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Port of Discharge"; rec."Port of Discharge")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(Package; rec.Package)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Weight/Pkg"; rec."Weight/Pkg")
//                 {
//                     ApplicationArea = All;
//                 }

//                 field(Validity; rec.Validity)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Comment; rec.Comment)
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Last Modified By"; rec."Last Modified By")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Last Modified Date"; rec."Last Modified Date")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//         area(Factboxes)
//         {

//         }
//     }

//     actions
//     {
//         area(Processing)
//         {
//             action(ActionName)
//             {
//                 ApplicationArea = All;
//                 trigger OnAction();
//                 begin

//                 end;
//             }
//         }
//     }
// }