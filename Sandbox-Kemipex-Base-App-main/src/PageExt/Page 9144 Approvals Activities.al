// pageextension 50469 ApprovalActivityQue extends "Approvals Activities"//T12370-Full Comment
// {
//     layout
//     {
//         // Add changes to page layout here
//         addafter("Requests to Approve")
//         {
//             field(KMReqtoApprove; KMReqtoApprove)
//             {
//                 Caption = 'KM Request to Approve ';
//                 ApplicationArea = all;
//                 Style = Unfavorable;
//                 StyleExpr = StyleExp;
//                 DrillDownPageId = "Kemipex Request to Appove";
//                 DrillDown = true;
//                 trigger OnDrillDown()
//                 var
//                     KmApprovalCodeunit: Codeunit "Kemipex Approval Codeunit";
//                     KMapprovalEntry: Record "Kemipex Approval Entry";
//                     KMrequesttoapprove: Page "Kemipex Request to Appove";
//                 begin
//                     KMapprovalEntry.SetFilter("Approver ID", KmApprovalCodeunit.GetuserGroupFilter());
//                     KMapprovalEntry.SetRange(Status, KMapprovalEntry.Status::Open);
//                     if KMapprovalEntry.FindSet() then begin
//                         Page.Run(Page::"Kemipex Request to Appove", KMapprovalEntry);
//                     end;
//                 end;
//             }
//         }
//     }

//     trigger OnAfterGetRecord()
//     var
//         KmApprovalCodeunit: Codeunit "Kemipex Approval Codeunit";
//         KMapprovalEntry: Record "Kemipex Approval Entry";
//     begin
//         KMapprovalEntry.SetFilter("Approver ID", KmApprovalCodeunit.GetuserGroupFilter());
//         KMapprovalEntry.SetRange(Status, KMapprovalEntry.Status::Open);
//         KMReqtoApprove := KMapprovalEntry.Count;
//         if KMReqtoApprove > 0 then
//             StyleExp := 'Unfavorable' else
//             StyleExp := 'Favorable';
//     end;

//     var
//         KMReqtoApprove: Integer;
//         StyleExp: Text;
// }
