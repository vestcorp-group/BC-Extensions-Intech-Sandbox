// pageextension 50504 "Posted Item Tracking Lines Ext" extends "Posted Item Tracking Lines"//T12370-Full Comment
// {
//     layout
//     {
//         addafter("Expiration Date")
//         {
//             field("Analysis Date"; rec."Analysis Date")
//             {
//                 ApplicationArea = all;
//             }
//             field("Of Spec"; rec."Of Spec")
//             {
//                 ApplicationArea = all;
//             }
//         }
//     }

//     actions
//     {
//         addfirst(Navigation)
//         {
//             action("Testing Parameter")
//             {
//                 ApplicationArea = all;
//                 Caption = 'Testing Parameters';
//                 //RunObject = Page "Posted Lot Testing Parameters";
//                 ToolTip = 'View or edit the item testing parameters for the lot number.';
//                 Image = AnalysisView;
//                 //RunPageLink = "Source ID" = field("Document No."),
//                 //"Source Ref. No." = field("Document Line No."),
//                 //"Item No." = field("Item No."),
//                 //"Lot No." = field(CustomLotNumber),
//                 //"BOE No." = field(CustomBOENumber);
//                 trigger OnAction()
//                 var
//                     LotPostedTestParameter: Record "Posted Lot Testing Parameter"; //AJAY
//                     LotPostedTestParameter2: Record "Posted Lot Testing Parameter"; //AJAY
//                     LotPostedVarintTestParameter: Record "Post Lot Var Testing Parameter"; //AJAY
//                     LotPostedVarintTestParameter2: Record "Post Lot Var Testing Parameter"; //AJAY
//                 begin //AJAY >>
//                     LotPostedVarintTestParameter2.RESET;
//                     LotPostedVarintTestParameter2.SetRange("Source ID", REC."Document No.");
//                     IF LotPostedVarintTestParameter2.FindFirst THEN begin
//                         LotPostedVarintTestParameter.FilterGroup(2);
//                         LotPostedVarintTestParameter.SetRange("Source ID", REC."Document No.");
//                         LotPostedVarintTestParameter.SetRange("Source Ref. No.", Rec."Document Line No.");
//                         LotPostedVarintTestParameter.SetRange("Item No.", rec."Item No.");
//                         LotPostedVarintTestParameter.SetRange("Variant Code", Rec."Variant Code");
//                         LotPostedVarintTestParameter.SetRange("Lot No.", Rec.CustomLotNumber);
//                         LotPostedVarintTestParameter.SetRange("BOE No.", rec.CustomBOENumber);
//                         IF PAGE.RUNMODAL(PAGE::"Post Lot Var Testing Parameter", LotPostedVarintTestParameter) = ACTION::LookupOK THEN;
//                     end ELSE BEGIN
//                         LotPostedTestParameter2.RESET;
//                         LotPostedTestParameter2.SetRange("Source ID", REC."Document No.");
//                         IF LotPostedTestParameter2.FindFirst THEN begin
//                             LotPostedTestParameter.FilterGroup(2);
//                             LotPostedTestParameter.SetRange("Source ID", REC."Document No.");
//                             LotPostedTestParameter.SetRange("Source Ref. No.", Rec."Document Line No.");
//                             LotPostedTestParameter.SetRange("Item No.", rec."Item No.");
//                             LotPostedTestParameter.SetRange("Lot No.", Rec.CustomLotNumber);
//                             LotPostedTestParameter.SetRange("BOE No.", rec.CustomBOENumber);
//                             IF PAGE.RUNMODAL(PAGE::"Posted Lot Testing Parameters", LotPostedTestParameter) = ACTION::LookupOK THEN;
//                         END else begin
//                             LotPostedVarintTestParameter.FilterGroup(2);
//                             LotPostedVarintTestParameter.SetRange("Source ID", REC."Document No.");
//                             LotPostedVarintTestParameter.SetRange("Source Ref. No.", Rec."Document Line No.");
//                             LotPostedVarintTestParameter.SetRange("Item No.", rec."Item No.");
//                             LotPostedVarintTestParameter.SetRange("Variant Code", Rec."Variant Code");
//                             LotPostedVarintTestParameter.SetRange("Lot No.", Rec.CustomLotNumber);
//                             LotPostedVarintTestParameter.SetRange("BOE No.", rec.CustomBOENumber);
//                             IF PAGE.RUNMODAL(PAGE::"Post Lot Var Testing Parameter", LotPostedVarintTestParameter) = ACTION::LookupOK THEN;
//                         end;
//                     end;
//                 end; //AJAY <<            
//             }
//         }
//     }
//     var
//         myInt: Integer;
// }