// pageextension 58032 "Item Units of Measure" extends "Item Units of Measure"//T12370-Full Comment
// {
//     //20-10-2022-start

//     layout
//     {
//         addlast(Control1)
//         {
//             field("Decimal Allowed"; Rec."Decimal Allowed")
//             {
//                 ApplicationArea = All;
//             }
//         }
//         addafter("Packing Weight")
//         {
//             field("Variant Code"; Rec."Variant Code")
//             {
//                 ApplicationArea = all;
//             }
//         }
//     }

//     //20-10-2022-end
//     trigger OnOpenPage()
//     begin
//         IsEditable();
//     end;

//     local procedure IsEditable()
//     var
//         Utility: Codeunit Events;
//         RecUserSetup: Record "User Setup";
//         Comment: Text;
//     begin
//         CurrPage.Editable := true;
//         IsUOMEditable := true;
//         if Utility.IsItemApproved(Rec."Item No.") then begin
//             CurrPage.Editable := false;
//             IsUOMEditable := false;
//         end;

//         if Utility.IsTransactionAvailableForItem(Rec."Item No.", Comment) then begin
//             CurrPage.Editable := false;
//             IsUOMEditable := false;
//         end;

//         InvSetup.Get();
//         Clear(RecUserSetup);
//         if RecUserSetup.GET(UserId) OR (InvSetup."Allow to edit Item UOM") then begin
//             if RecUserSetup."Allow To Edit Items" then begin
//                 CurrPage.Editable := true;
//                 IsUOMEditable := true;
//             end;
//         end;
//     end;

//     trigger OnModifyRecord(): Boolean
//     var
//         comment: Text;
//     begin
//         InvSetup.GET;
//         if InvSetup."Allow to edit Item UOM" then exit;
//         if EventsCod.IsTransactionAvailableForItem(Rec."Item No.", comment) then
//             Error('Item ' + Rec."Item No." + ' has transaction. You cannot modify record.\' + comment);
//     end;

//     trigger OnNewRecord(BelowxRec: boolean)
//     var
//         comment: Text;
//     begin
//         InvSetup.GET;
//         if InvSetup."Allow to edit Item UOM" then exit;
//         if EventsCod.IsTransactionAvailableForItem(Rec."Item No.", comment) then
//             Error('Item ' + Rec."Item No." + ' has transaction. You cannot insert record.\' + comment);
//     end;

//     trigger OnInsertRecord(BelowxRec: boolean): Boolean
//     var
//         comment: Text;
//     begin
//         InvSetup.GET;
//         if InvSetup."Allow to edit Item UOM" then exit;
//         if EventsCod.IsTransactionAvailableForItem(Rec."Item No.", comment) then
//             Error('Item ' + Rec."Item No." + ' has transaction. You cannot insert record.\' + comment);
//     end;

//     trigger OnDeleteRecord(): Boolean
//     var
//         comment: Text;
//     begin
//         InvSetup.GET;
//         if InvSetup."Allow to edit Item UOM" then exit;
//         if EventsCod.IsTransactionAvailableForItem(Rec."Item No.", comment) then
//             Error('Item ' + Rec."Item No." + ' has transaction. You cannot delete record.\' + comment);
//     end;

//     trigger OnAfterGetCurrRecord()
//     begin
//         IsEditable();
//     end;

//     var
//         IsUOMEditable: Boolean;
//         EventsCod: Codeunit Events;
//         InvSetup: Record "Inventory Setup";
// }
