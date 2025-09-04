// tableextension 58001 "Purchase Header" extends "Purchase Header"//T12370-Full Comment
// {
//     fields
//     {
//         //GST-22/05/2022
//         modify("VAT Base Discount %")
//         {
//             CaptionClass = 'GSTORVAT,VAT Base Discount %';
//         }
//         modify("VAT Country/Region Code")
//         {
//             CaptionClass = 'GSTORVAT,VAT Country/Region Code';
//         }
//         modify("VAT Registration No.")
//         {
//             CaptionClass = 'GSTORVAT,VAT Registration No.';
//         }
//         modify("Amount Including VAT")
//         {
//             CaptionClass = 'GSTORVAT,Amount Including VAT';
//         }
//         modify("Prices Including VAT")
//         {
//             CaptionClass = 'GSTORVAT,Prices Including VAT';
//         }
//         modify("A. Rcd. Not Inv. Ex. VAT (LCY)")
//         {
//             CaptionClass = 'GSTORVAT,A. Rcd. Not Inv. Ex. VAT (LCY)';
//         }
//         modify("VAT Bus. Posting Group")
//         {
//             CaptionClass = 'GSTORVAT,VAT Bus. Posting Group';
//         }

//         field(53205; "Last Approved Amount"; Decimal)
//         {
//             Caption = 'Last Approved Amount';
//             DataClassification = CustomerContent;
//             Editable = false;
//         }
//     }
// }
