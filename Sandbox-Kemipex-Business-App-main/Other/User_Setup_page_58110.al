// pageextension 58110 usersetuppageext extends "User Setup"//T12370-Full Comment
// {

//     layout
//     {
//         /*   addafter("Allow Sales Unit of Measure")
//           {
//               field("Allow Pre SI Creation"; Rec."Allow Pre SI Creation")
//               {
//                   ApplicationArea = all;
//                   Caption = 'Allow Pre Sales Invoice Creation';
//               }
//           }
//           addafter("Allow Pre SI Creation")
//           {
//               field("Allow SO Line Reserve Modify"; Rec."Allow SO Line Reserve Modify")
//               {
//                   ApplicationArea = all;
//                   Caption = 'Allow SO Line Reserve Modify';
//               }
//               field("Allow IC Docs Without Relation"; Rec."Allow IC Docs Without Relation")
//               {
//                   ApplicationArea = all;
//                   Caption = 'Allow IC Docs Without Relation';
//               }
//               field("Allow Edit ETA/ETD"; Rec."Allow Edit ETA/ETD")
//               {
//                   ApplicationArea = all;
//                   ToolTip = 'Allow to edit ETA/ETD form';
//               }
//           } */
//         //06-08-2022-start
//         addlast(Control1)
//         {
//             /* field("Allow To Edit Items"; Rec."Allow To Edit Items")
//             {
//                 ApplicationArea = ALl;
//             }
//             field("Modify Posted Sales Inv. Line"; Rec."Modify Posted Sales Inv. Line")
//             {
//                 ApplicationArea = All;
//             }
//             field("Modify Posted Sales Shpt Line"; Rec."Modify Posted Sales Shpt Line")
//             {
//                 ApplicationArea = All;
//             }
//             field("Modify Posted Sales Invoice"; Rec."Modify Posted Sales Invoice")
//             {
//                 ApplicationArea = All;
//             }
//             field("Allow to update SO Unit Price"; Rec."Allow to update SO Unit Price")
//             {
//                 ApplicationArea = All;
//             }
//             field("Show Blocked Variant Inventory"; Rec."Show Blocked Variant Inventory")
//             {
//                 ApplicationArea = all;
//             } */
//             // field("KZFEEdit Allowed for Memb."; Rec."KZFEEdit Allowed for Memb.")
//             // {
//             //     ApplicationArea = All;
//             //     ToolTip = 'Specifies the value of the Edit Allowed for Team Member Sales Budget field.';
//             // }
//         }
//         //06-08-2022-end

//     }
//     actions
//     {
//         // addfirst(Creation)
//         // {
//         //     action(Release)
//         //     {
//         //         Caption = 'Release to Companies';
//         //         ApplicationArea = all;
//         //         Promoted = true;
//         //         PromotedCategory = Process;
//         //         PromotedIsBig = true;
//         //         trigger OnAction()
//         //         var
//         //             myInt: Integer;
//         //         begin
//         //             rec.companytransfer(xRec);
//         //         end;
//         //     }

//         // }


//         // Add changes to page actions here
//     }
//     var
//         myInt: Integer;
// }