// table 58181 KMP_PurchasePriceList//T12370-Full Comment
// {
//     DataClassification = ToBeClassified;
//     fields
//     {
//         field(1; EntryNo; Integer)
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//             AutoIncrement = true;
//         }
//         field(2; "Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(3; Source; Option)
//         {
//             OptionMembers = "",Email,"Phone Call","Meeting","Whatsapp";
//             OptionCaption = ', Email,Phone Call,Meeting,Whatsapp';
//         }
//         field(4; User; Code[50])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = User;
//             Editable = false;
//         }
//         field(5; Vendor; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = Vendor;

//             trigger OnValidate()
//             var
//                 vendor_rec: Record Vendor;
//             begin
//                 vendor_rec.get(Rec.Vendor);
//                 Rec."Vendor Name" := vendor_rec.Name;
//             end;
//         }
//         field(6; "Vendor Name"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(8; "Item Code"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = Item;

//             trigger OnValidate()
//             var
//                 itemRec: Record Item;
//             begin
//                 itemRec.Get(Rec."Item Code");
//                 Rec."Item Name" := itemRec.Description;
//             end;
//         }
//         field(9; "Item Name"; Text[200])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(10; "Unit"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "Unit of Measure";
//         }
//         field(11; Currency; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = Currency;
//         }
//         field(12; "Unit Price"; Decimal)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(13; "Package"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "Unit of Measure";
//         }
//         field(14; "Weight/Pkg"; Text[100])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(15; "Incoterm"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "Transaction Specification";
//         }
//         field(16; "Validity"; Date)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(17; "Comment"; Text[500])
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(18; "Last Modified By"; Code[50])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = User;
//             Editable = false;
//         }
//         field(19; "Last Modified Date"; Date)
//         {
//             DataClassification = ToBeClassified;
//             Editable = false;
//         }
//         field(20; "Port of Discharge"; Code[20])
//         {
//             DataClassification = ToBeClassified;
//             TableRelation = "Area";

//         }
//         /*
//         email
//         phone call
//         meeting
//         whatsapp
//         */
//     }

//     keys
//     {
//         key(PK; EntryNo)
//         {
//             Clustered = true;
//         }
//     }

//     var
//         myInt: Integer;

//     trigger OnInsert()

//     begin
//         User := UserId;

//         Date := WorkDate();
//     end;

//     trigger OnModify()
//     begin
//         "Last Modified By" := UserId;
//         "Last Modified Date" := WorkDate();


//         /*
//                 TestField("Vendor Name");
//                 TestField("Item Name");
//                 TestField(Incoterm);
//                 TestField("Unit Price");
//         */
//     end;

//     trigger OnDelete()
//     begin

//     end;

//     trigger OnRename()
//     begin

//     end;

// }