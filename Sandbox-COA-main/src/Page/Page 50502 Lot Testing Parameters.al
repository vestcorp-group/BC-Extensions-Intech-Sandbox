// page 50502 "Lot Testing Parameters"//T12370-Full Comment
// {
//     PageType = List;
//     SourceTable = "Lot Testing Parameter";
//     UsageCategory = Administration;
//     ApplicationArea = all;
//     layout
//     {
//         area(Content)
//         {
//             repeater(Parameters)
//             {
//                 field("Item No."; rec."Item No.")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//                 field("Lot No."; rec."Lot No.")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Code; rec.Code)
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Testing Parameter"; rec."Testing Parameter")
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Minimum; rec.Minimum)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Maximum; rec.Maximum)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field(Symbol; rec.Symbol)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                     Visible = false;//25-06-2022
//                 }
//                 field(Value; rec.Value2)
//                 {
//                     ApplicationArea = all;
//                     Editable = false;
//                 }
//                 field("Actual Value"; rec."Actual Value")
//                 {
//                     ApplicationArea = all;
//                     Editable = NOT IsActualDisbaled;
//                 }
//                 field(Priority; Rec.Priority)
//                 {
//                     ApplicationArea = All;
//                     Enabled = false;
//                 }
//                 field("Show in COA"; Rec."Show in COA")
//                 {
//                     ApplicationArea = All;
//                     Enabled = false;
//                 }
//                 field("Default Value"; Rec."Default Value")
//                 {
//                     ApplicationArea = All;
//                     Enabled = false;
//                 }
//                 field("Testing Parameter Code"; Rec."Testing Parameter Code")
//                 {
//                     ApplicationArea = All;
//                     Editable = false;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(Processing)
//         {
//             // action(GetTestingParameter)
//             // {

//             //     ApplicationArea = all;
//             //     Promoted = true;
//             //     PromotedCategory = Category10;
//             //     PromotedIsBig = true;
//             //     PromotedOnly = true;
//             //     trigger OnAction()
//             //     var
//             //         LotTestingParameterL: Record "Lot Testing Parameter";
//             //     begin

//             //         LotTestingParameterL.SetRecFilter();
//             //         repeat

//             //         until LotTestingParameterL.Next() = 0;
//             //         Message('Rcord is %1', LotTestingParameterL);
//             //     end;
//             // }
//         }
//     }

//     trigger OnOpenPage()
//     var
//         text1: Text;
//     begin

//     end;

//     procedure DisableActualValueControl()
//     begin
//         IsActualDisbaled := true;
//     end;

//     var
//         IsActualDisbaled: Boolean;

// }