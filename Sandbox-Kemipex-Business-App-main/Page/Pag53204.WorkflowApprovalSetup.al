
// page 53204 "PO Approval Field Incl. Setup"//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'PO Approval Field Include Setup';
//     PageType = List;
//     SourceTable = "PO Approval Field Incl. Setup";
//     UsageCategory = Administration;

//     layout
//     {
//         area(content)
//         {
//             repeater(Control1)
//             {
//                 ShowCaption = false;
//                 field(TableNo; Rec.TableNo)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(TableName; Rec.TableName)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field(FieldName; Rec.FieldName)
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }
//                 field("Approval Document Type"; Rec."Approval Document Type")
//                 {
//                     ApplicationArea = Basic, Suite;
//                 }

//             }
//         }
//     }
//     actions
//     {
//         area(processing)
//         {
//             group("F&unctions")
//             {
//                 Caption = 'F&unctions';
//                 Image = "Action";
//                 action("Check")
//                 {
//                     ApplicationArea = Suite;
//                     Caption = 'Check';

//                     trigger OnAction()
//                     var
//                         i: Integer;
//                         RecRef: RecordRef;
//                         FldRef: FieldRef;
//                         Item: Record Item;
//                         PurchHeader: Record "Purchase Header";
//                     begin
//                         // RecRef.OPEN(27);
//                         // FldRef := RecRef.FIELD(1); // Item."No."
//                         // FldRef.SETRANGE('IT0000007');
//                         // RecRef.FIND('-');
//                         // FOR i := 1 TO RecRef.FIELDCOUNT DO BEGIN
//                         //     FldRef := RecRef.FIELDINDEX(i);
//                         //     CASE FldRef.NAME OF // Or you can use a case on FldRef.NUMBER
//                         //         'Description':
//                         //             MESSAGE('%1 is %2.', FldRef.CAPTION, FldRef.VALUE);
//                         //         'Unit Cost':
//                         //             MESSAGE('%1 is %2.', FldRef.CAPTION, FldRef.VALUE);
//                         //     END;
//                         // END;

//                         RecRef.OPEN(38);
//                         FldRef := RecRef.FIELD(3); // Item."No."
//                         FldRef.SETRANGE('KM/PO/101188');
//                         RecRef.FIND('-');
//                         FOR i := 1 TO RecRef.FIELDCOUNT DO BEGIN
//                             if i = 23 then begin
//                                 FldRef := RecRef.FIELDINDEX(i);
//                                 FldRef.Value := 1;
//                                 MESSAGE('%1 is %2.', FldRef.CAPTION, FldRef.VALUE);
//                             end;
//                             // CASE FldRef.NAME OF // Or you can use a case on FldRef.NUMBER
//                             //     'Description':
//                             //         MESSAGE('%1 is %2.', FldRef.CAPTION, FldRef.VALUE);
//                             //     'Vendor Invoice No.':
//                             //         MESSAGE('%1 is %2.', FldRef.CAPTION, FldRef.VALUE);
//                             // END;
//                         END;


//                     end;
//                 }
//             }
//         }
//     }


//     trigger OnAfterGetCurrRecord()
//     var
//     begin
//     end;

//     trigger OnOpenPage()
//     var
//     begin
//     end;

//     var
// }
