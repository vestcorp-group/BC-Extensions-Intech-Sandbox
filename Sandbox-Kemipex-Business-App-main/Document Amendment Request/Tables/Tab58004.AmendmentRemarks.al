// table 58004 "Amendment Remarks"//T12370-Full Comment
// {
//     Caption = 'Amendment Remarks';
//     DataClassification = ToBeClassified;

//     fields
//     {
//         field(1; "Document Type"; Option)
//         {
//             OptionMembers = Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order",Shipment;
//             DataClassification = ToBeClassified;
//         }
//         field(2; "Document No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(3; "Line No."; Integer)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(4; Comments; Text[500])
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(5; "Document Line No."; Integer)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(6; Type; Option)
//         {
//             DataClassification = ToBeClassified;
//             OptionMembers = " ",Unposted,Posted;
//         }
//         field(30; "New Remarks"; Text[500])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(31; "Amendment No."; Code[20])
//         {
//             DataClassification = ToBeClassified;
//         }
//     }
//     keys
//     {
//         key(PK; "Amendment No.", "Document Type", "Document No.", "Document Line No.", "Line No.")
//         {
//         }
//     }
// }
