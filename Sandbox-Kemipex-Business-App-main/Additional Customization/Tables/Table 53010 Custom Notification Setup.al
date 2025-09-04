// table 53010 "Custom Notification Setup"//T12370-Full Comment
// {
//     Caption = 'Custom Notification Setup';
//     DataClassification = ToBeClassified;

//     fields
//     {
//         field(1; "Code"; Code[20])
//         {
//             Caption = 'Code';
//             DataClassification = ToBeClassified;
//         }
//         field(2; "Table"; Enum NotificationTable)
//         {
//             Caption = 'Table';
//             DataClassification = ToBeClassified;
//         }
//         field(3; "Field Id"; Integer)
//         {
//             Caption = 'Field Id';
//             DataClassification = ToBeClassified;
//             TableRelation = IF ("Table" = const(Item)) Field where(TableNo = const(27)) else
//             if (Table = const("Reservation Entry")) Field where(TableNo = const(337)) else
//             if (Table = const("Sales Header")) Field where(TableNo = const(36));

//             trigger OnValidate()
//             var
//                 Field: Record Field;
//             begin
//                 Clear(Field);
//                 if "Field Id" <> 0 then begin
//                     TestField(Table);
//                     if Table = Table::Item then
//                         Field.SetRange(TableNo, 27)
//                     else
//                         if Table = Table::"Reservation Entry" then
//                             Field.SetRange(TableNo, 337)
//                         else
//                             if Table = Table::"Sales Header" then
//                                 Field.SetRange(TableNo, 36);

//                     Field.SetRange("No.", "Field Id");
//                     if Field.FindFirst() then
//                         "Field Name" := Field."Field Caption";
//                 end else
//                     "Field Name" := '';
//             end;
//         }
//         field(4; "Field Name"; Text[30])
//         {
//             Caption = 'Field Name';
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(5; "Filter Text"; Text[100])
//         {
//             Caption = 'Filter Text';
//             DataClassification = ToBeClassified;
//         }
//         field(6; Enabled; Boolean)
//         {
//             Caption = 'Enabled';
//             DataClassification = ToBeClassified;
//         }
//         // field(7; "User Id"; Text[30])
//         // {
//         //     DataClassification = ToBeClassified;
//         //     TableRelation = User."User Name";
//         //     ValidateTableRelation = false;

//         //     trigger OnValidate()
//         //     var
//         //         UserSelection: Codeunit "User Selection";
//         //     // a:Record 37
//         //     begin
//         //         UserSelection.ValidateUserName("User ID");
//         //     end;
//         // }
//         // field(8; "Notification Date"; Date)
//         // {
//         //     DataClassification = ToBeClassified;
//         // }
//         field(9; "Notification Text"; Text[250])
//         {
//             DataClassification = ToBeClassified;
//         }
//     }
//     keys
//     {
//         key(PK; "Code")
//         {
//             Clustered = true;
//         }
//     }

//     trigger OnInsert()
//     var
//         RecSalesSetup: Record "Sales & Receivables Setup";
//         Noseries: Codeunit NoSeriesManagement;
//     begin
//         RecSalesSetup.GET;
//         RecSalesSetup.TestField("Notification Entry Nos.");
//         if Code = '' then begin
//             Code := Noseries.GetNextNo(RecSalesSetup."Notification Entry Nos.", WorkDate(), true);
//         end;
//     end;
// }

// enum 53010 NotificationTable
// {
//     value(0; " ")
//     {
//     }
//     value(1; "Sales Header")
//     {

//     }
//     value(2; "Item")
//     {

//     }
//     value(3; "Reservation Entry")
//     {

//     }
// }
