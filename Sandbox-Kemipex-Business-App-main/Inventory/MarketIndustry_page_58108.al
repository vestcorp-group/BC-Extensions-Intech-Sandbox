// pageextension 58108 marketindustrypageext extends KMP_PageMarketIndustry//T12370-Full Comment
// {

//     layout
//     {
//         addafter(Description)
//         {

//             field("Customer Master Allowed"; rec."Customer Master Allowed")
//             {
//                 ApplicationArea = all;
//             }
//         }
//     }
//     actions
//     {
//         addfirst(Creation)
//         {
//             // action(Release)
//             // {
//             //     Caption = 'Release to Companies';
//             //     ApplicationArea = all;
//             //     Promoted = true;
//             //     PromotedCategory = Process;
//             //     PromotedIsBig = true;
//             //     trigger OnAction()
//             //     var
//             //         myInt: Integer;
//             //     begin
//             //         rec.companytransfer(xRec);
//             //     end;
//             // }

//         }
//         // Add changes to page actions here
//     }
//     var
//         myInt: Integer;
// }