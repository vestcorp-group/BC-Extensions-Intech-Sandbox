// report 53200 "Update PO Last Approved Amount"//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'Update PO Last Approved Amount';
//     UsageCategory = Administration;
//     ProcessingOnly = true;
//     dataset
//     {
//         dataitem(Integer; "Integer")
//         {
//             trigger OnPreDataItem()
//             begin
//                 SetRange(Number, 1);
//             end;

//             trigger OnAfterGetRecord()
//             var
//                 PurchaseHeader: Record "Purchase Header";
//                 PurchLine: Record "Purchase Line";
//                 PurchLineAmt: Decimal;
//                 i: Integer;
//             begin
//                 PurchaseHeader.Reset;
//                 PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
//                 PurchaseHeader.SetRange(Status, PurchaseHeader.Status::Released);
//                 // if OverriteApprovedAmount = false then
//                 PurchaseHeader.SetFilter("Last Approved Amount", '=%1', 0);
//                 if PurchaseHeader.FindFirst() then
//                     Repeat
//                         PurchLineAmt := 0;
//                         PurchaseHeader."Last Approved Amount" := 0;
//                         PurchLine.SetRange("Document Type", PurchaseHeader."Document Type");
//                         PurchLine.SetRange("Document No.", PurchaseHeader."No.");
//                         if PurchLine.FindFirst() then
//                             repeat
//                                 PurchLineAmt := PurchLineAmt + PurchLine."Line Amount";
//                             until PurchLine.Next() = 0;
//                         PurchaseHeader."Last Approved Amount" := PurchLineAmt;
//                         i += 1;
//                         PurchaseHeader.Modify();
//                     Until PurchaseHeader.Next() = 0;
//                 Message('Successfully updated %1 record', i);
//             end;
//         }
//     }
//     requestpage
//     {
//         layout
//         {
//             area(content)
//             {
//                 /* group(Options)
//                  {
//                      Caption = 'Options';
//                      field(OverriteApprovedAmount; OverriteApprovedAmount)
//                      {
//                          ApplicationArea = Suite;
//                          Caption = 'Allow overriting Last Approved Amount';
//                      }

//                  } */
//             }
//         }
//         actions
//         {
//             area(processing)
//             {
//             }
//         }
//     }
//     var
//     // OverriteApprovedAmount: Boolean;
// }
