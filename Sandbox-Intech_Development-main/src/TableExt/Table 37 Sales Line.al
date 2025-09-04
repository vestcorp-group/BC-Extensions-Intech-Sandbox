// tableextension 50117 SalesLineExt extends "Sales Line"
// {
//     fields
//     {
//         //T50219-NS-NB
//         modify(LineHSNCode)
//         {
//             trigger OnAfterValidate()
//             var
//                 SalesHeader_lRec: Record "Sales Header";
//             begin
//                 SalesHeader_lRec.Reset();
//                 if SalesHeader_lRec.Get(Rec."Document Type", REc."Document No.") then begin
//                     if SalesHeader_lRec.Status <> SalesHeader_lRec.status::Open then
//                         Error('Status need to be open.');
//                     if rec.LineHSNCode <> rec.HSNCode then begin
//                         SalesHeader_lRec."Required approval for Line" := true;
//                         SalesHeader_lRec.Modify();
//                     end else begin
//                         SalesHeader_lRec."Required approval for Line" := false;
//                         SalesHeader_lRec.Modify();
//                     end;
//                 end;
//             end;
//         }
//         modify(LineCountryOfOrigin)
//         {
//             trigger OnAfterValidate()
//             var
//                 SalesHeader_lRec: Record "Sales Header";
//             begin
//                 SalesHeader_lRec.Reset();
//                 if SalesHeader_lRec.Get(Rec."Document Type", REc."Document No.") then begin
//                     if SalesHeader_lRec.Status <> SalesHeader_lRec.status::Open then
//                         Error('Status need to be open.');
//                     if rec.LineCountryOfOrigin <> rec.CountryOfOrigin then begin
//                         SalesHeader_lRec."Required approval for Line" := true;
//                         SalesHeader_lRec.Modify();
//                     end else begin
//                         SalesHeader_lRec."Required approval for Line" := false;
//                         SalesHeader_lRec.Modify();
//                     end;
//                 end;

//             end;
//         }
//         modify("Line Generic Name")
//         {
//             trigger OnAfterValidate()
//             var
//                 SalesHeader_lRec: Record "Sales Header";
//             begin
//                 SalesHeader_lRec.Reset();
//                 if SalesHeader_lRec.Get(Rec."Document Type", REc."Document No.") then begin
//                     if SalesHeader_lRec.Status <> SalesHeader_lRec.status::Open then
//                         Error('Status need to be open.');
//                     if rec."Item Generic Name" <> rec."Line Generic Name" then begin
//                         SalesHeader_lRec."Required approval for Line" := true;
//                         SalesHeader_lRec.Modify();
//                     end else begin
//                         SalesHeader_lRec."Required approval for Line" := false;
//                         SalesHeader_lRec.Modify();
//                     end;
//                 end;
//             end;
//         }
//         //T50219-NE-NB
//     }

// }