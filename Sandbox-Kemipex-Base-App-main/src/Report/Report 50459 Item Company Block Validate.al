// report 50459 "Item Company Block Validate"//T12370-Full Comment
// {
//     UsageCategory = Administration;
//     ApplicationArea = All;
//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem("Item Company Block"; "Item Company Block")
//         {
//             RequestFilterFields = "Item No.";
//             trigger OnAfterGetRecord()
//             var
//                 ItemCompanyblockRec: Record "Item Company Block";
//                 CompanyRec: Record Company;
//                 ItemRec: Record Item;
//             begin

//                 if "Item Company Block"."Item No." <> '' then begin
//                     if not CompanyRec.Get("Item Company Block".Company) then


//                         // if not ItemRec.ChangeCompany("Item Company Block".Company) then
//                         //     if not ItemRec.Get("Item No.") then
//                         "Item Company Block".Delete();

//                 end;

//                 // if CompanyRec.FindSet() then begin
//                 //     repeat
//                 //         ItemRec.ChangeCompany(CompanyRec.Name);
//                 //         if ItemRec.Get(Item."No.") then begin
//                 //             if not ItemCompanyblockRec.Get(ItemRec."No.", CompanyRec.Name) then begin
//                 //                 ItemCompanyblockRec.Init();
//                 //                 ItemCompanyblockRec."Item No." := ItemRec."No.";
//                 //                 ItemCompanyblockRec.Company := CompanyRec.Name;
//                 //                 if ItemCompanyblockRec.Insert then ItemCompanyblockRec.ValidateItemCompanyBlock(ItemRec."No.");
//                 //             end;
//                 //         end;
//                 //     until CompanyRec.Next() = 0;
//                 // end;
//             end;
//         }
//     }
//     // ItemCompanyblockRec.Blocked := ItemRec.Blocked;
//     // ItemCompanyblockRec."Sales Blocked" := ItemRec."Sales Blocked";
//     // ItemCompanyblockRec."Purchase Blocked" := ItemRec."Purchasing Blocked";
//     requestpage
//     {
//         layout
//         {
//             area(Content)
//             {
//                 group(GroupName)
//                 {

//                 }
//             }
//         }

//         actions
//         {
//             area(processing)
//             {
//                 action(ActionName)
//                 {
//                     ApplicationArea = All;

//                 }
//             }
//         }
//     }

//     var
//         myInt: Integer;
// }