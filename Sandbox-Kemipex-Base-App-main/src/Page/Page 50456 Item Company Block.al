// page 50456 "Item Company Block"//T12370-Full Comment
// {

//     // ApplicationArea = All;
//     Caption = 'Item Company Block';
//     PageType = ListPart;
//     SourceTable = "Item Company Block";
//     UsageCategory = Lists;


//     layout
//     {
//         area(content)
//         {
//             repeater(General)
//             {
//                 // field("Item No."; Rec."Item No.")
//                 // {
//                 //     ToolTip = 'Specifies the value of the Item No. field';
//                 //     ApplicationArea = All;
//                 // }
//                 field(Company; Rec.Company)
//                 {
//                     ToolTip = 'Specifies the value of the Company field';
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field(Block; Rec.Blocked)
//                 {
//                     ToolTip = 'Specifies the value of the Block field';
//                     ApplicationArea = All;
//                 }
//                 field("Sales Block"; Rec."Sales Blocked")
//                 {
//                     ToolTip = 'Specifies the value of the Sales Block field';
//                     ApplicationArea = All;
//                 }
//                 field("Purchase Block"; Rec."Purchase Blocked")
//                 {
//                     ToolTip = 'Specifies the value of the Purchase Block field';
//                     ApplicationArea = All;
//                 }
//             }
//         }
//     }
//     actions
//     {
//         area(Processing)
//         {

//             group(Blocked)
//             {
//                 action("Block All")
//                 {
//                     ApplicationArea = all;
//                     trigger OnAction()
//                     var
//                         ItemCompanyBlockRec: Record "Item Company Block";
//                     begin
//                         ItemCompanyBlockRec.SetRange("Item No.", Rec."Item No.");
//                         if ItemCompanyBlockRec.FindSet() then
//                             repeat
//                                 ItemCompanyBlockRec.Validate(Blocked, true);
//                                 if ItemCompanyBlockRec.Modify() then;
//                             until ItemCompanyBlockRec.Next() = 0;
//                     end;
//                 }
//                 action("Unblock All")
//                 {
//                     ApplicationArea = all;
//                     trigger OnAction()
//                     var
//                         ItemCompanyBlockRec: Record "Item Company Block";

//                     begin
//                         ItemCompanyBlockRec.SetRange("Item No.", Rec."Item No.");
//                         if ItemCompanyBlockRec.FindSet() then
//                             repeat
//                                 ItemCompanyBlockRec.Validate(Blocked, false);
//                                 if ItemCompanyBlockRec.Modify() then;
//                             until ItemCompanyBlockRec.Next() = 0;
//                     end;

//                 }
//             }
//             group("Sales Blocked")
//             {
//                 action("Sales Block All")
//                 {
//                     ApplicationArea = all;
//                     trigger OnAction()
//                     var
//                         ItemCompanyBlockRec: Record "Item Company Block";

//                     begin
//                         ItemCompanyBlockRec.SetRange("Item No.", Rec."Item No.");
//                         if ItemCompanyBlockRec.FindSet() then
//                             repeat
//                                 ItemCompanyBlockRec.Validate("Sales Blocked", true);
//                                 if ItemCompanyBlockRec.Modify() then;
//                             until ItemCompanyBlockRec.Next() = 0;
//                     end;
//                 }
//                 action("Sales Unblock All")
//                 {
//                     ApplicationArea = all;
//                     trigger OnAction()
//                     var
//                         ItemCompanyBlockRec: Record "Item Company Block";

//                     begin
//                         ItemCompanyBlockRec.SetRange("Item No.", Rec."Item No.");
//                         if ItemCompanyBlockRec.FindSet() then
//                             repeat
//                                 ItemCompanyBlockRec.Validate("Sales Blocked", false);
//                                 if ItemCompanyBlockRec.Modify() then;
//                             until ItemCompanyBlockRec.Next() = 0;
//                     end;
//                 }


//             }
//             group("Purchase Blocked")
//             {
//                 action("Purchase Block All")
//                 {
//                     ApplicationArea = all;
//                     trigger OnAction()
//                     var
//                         ItemCompanyBlockRec: Record "Item Company Block";

//                     begin
//                         ItemCompanyBlockRec.SetRange("Item No.", Rec."Item No.");
//                         if ItemCompanyBlockRec.FindSet() then
//                             repeat
//                                 ItemCompanyBlockRec.Validate("Purchase Blocked", true);
//                                 if ItemCompanyBlockRec.Modify() then;
//                             until ItemCompanyBlockRec.Next() = 0;
//                     end;
//                 }
//                 action("Purchase Unblock All")
//                 {
//                     ApplicationArea = all;
//                     trigger OnAction()
//                     var
//                         ItemCompanyBlockRec: Record "Item Company Block";

//                     begin
//                         ItemCompanyBlockRec.SetRange("Item No.", Rec."Item No.");
//                         if ItemCompanyBlockRec.FindSet() then
//                             repeat
//                                 ItemCompanyBlockRec.Validate("Purchase Blocked", false);
//                                 if ItemCompanyBlockRec.Modify() then;
//                             until ItemCompanyBlockRec.Next() = 0;
//                     end;
//                 }
//             }
//         }
//     }
// }