// /// <summary>
// /// PageExtension ExtendNavigationArea (ID 54012) extends Record Business Manager Role Center.
// /// </summary>
// pageextension 54012 "ExtendNavigationArea" extends "Business Manager Role Center"
// {

//     actions
//     {
//         addlast(Sections)
//         {
//             group(Upload)
//             {
//                 action("PurchaseInvoice")
//                 {
//                     RunObject = page "Upload Purchase Invoice";
//                     Caption = 'Purchase Invoice';
//                     ApplicationArea = All;
//                 }
//                 action(PostedPurchaseInvoice)
//                 {
//                     RunObject = page "Posted Upload Purchase Invoice";
//                     ApplicationArea = All;
//                     Caption = 'Posted Purchase Invoice';
//                 }

//                 action("UploadVoucherLine")
//                 {
//                     RunObject = page "Upload Voucher Lines";
//                     Caption = 'Voucher Lines';
//                     ApplicationArea = All;
//                 }
//                 action("PostedUploadVoucherLine")
//                 {
//                     RunObject = page "Posted Upload Voucher Lines";
//                     ApplicationArea = All;
//                     Caption = 'Posted Voucher Lines';
//                 }
//             }
//         }
//     }
// }