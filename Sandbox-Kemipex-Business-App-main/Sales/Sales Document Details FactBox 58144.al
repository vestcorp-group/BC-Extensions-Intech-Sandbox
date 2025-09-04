
// page 58144 SalesdocumentDetailFactbox//T12370-Full Comment
// {
//     PageType = CardPart;
//     ApplicationArea = All;
//     UsageCategory = Administration;
//     SourceTable = "Sales Header";
//     Caption = 'Document Details';
//     layout
//     {
//         area(Content)
//         {
//             group("Document Details")
//             {
//                 field(Salesperson; Salesperson)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field(RC; RC)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Responsibility Center';
//                 }
//                 field(PaymentTerms; PaymentTerms)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Payment Terms';
//                 }
//                 field(POL; POL)
//                 {
//                     Caption = 'Port of Loading';
//                     ApplicationArea = all;
//                 }
//                 field(POD; POD)
//                 {
//                     Caption = 'Port of Discharge';
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     trigger OnAfterGetCurrRecord()
//     var
//         SalesPersonRec: Record "Salesperson/Purchaser";
//         PaymenttermsRec: Record "Payment Terms";
//         PODrec: Record "Area";
//         POLrec: Record "Entry/Exit Point";
//         RCrec: Record "Responsibility Center";
//     begin
//         if SalesPersonRec.get(rec."Salesperson Code") then
//             Salesperson := SalesPersonRec.Name;
//         if PaymenttermsRec.Get(rec."Payment Terms Code") then
//             PaymentTerms := PaymenttermsRec.Description;
//         if PODrec.Get(rec."Area") then
//             POD := PODrec.Text;
//         if POLrec.get(rec."Exit Point") then
//             POL := POLrec.Description;
//         if RCrec.Get(rec."Responsibility Center") then
//             RC := RCrec.Name;
//     end;

//     var
//         Salesperson: Text[100];
//         PaymentTerms: Text[100];
//         POL: Text[100];
//         POD: Text[100];
//         RC: Text[100];
// }