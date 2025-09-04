// table 58237 "Item Pictogram"//T12370-Full Comment
// {
//     Caption = 'Item Pictogram';
//     DataCaptionFields = "Item No.", "Pictogram Code", "Print Sequence";
//     LookupPageID = "Item Pictogram";

//     fields
//     {
//         field(58238; "Item No."; Code[20])
//         {
//             Caption = 'Item No.';
//             NotBlank = true;
//             TableRelation = Item;
//         }
//         field(58239; "Pictogram Code"; Code[20])
//         {
//             Caption = 'Pictogram Code';
//             NotBlank = true;
//             TableRelation = Pictogram;
//         }
//         field(58240; "Print Sequence"; Integer)
//         {
//             Caption = 'Print Sequence';
//             NotBlank = true;
//         }
//     }
//     keys
//     {
//         key(Key1; "Item No.", "Pictogram Code")
//         {
//             Clustered = true;
//         }
//     }

//     fieldgroups
//     {
//         fieldgroup(DropDown; "Item No.", "Pictogram Code", "Print Sequence")
//         {
//         }
//     }

// }

