// tableextension 58010 ProductFamily extends "Product Family"//T12370-Full Comment
// {
//     procedure companytransfer(ProductFamilyFrom: Record "Product Family")
//     var
//         masterconfig: Record "Release to Company Setup";
//         ProductFamilyTo: Record "Product Family";
//         Text001: Label 'Product Family %1 transfered to %2 Company';
//         Text002: Label 'Product Family %1 modified in %2 Company';
//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Customer", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 ProductFamilyTo.ChangeCompany(masterconfig."Company Name");
//                 ProductFamilyTo.Reset();
//                 if not ProductFamilyTo.Get(ProductFamilyFrom.Code) then begin
//                     ProductFamilyTo.Init();
//                     ProductFamilyTo := ProductFamilyFrom;
//                     if ProductFamilyTo.Insert() then;
//                     Message(Text001, ProductFamilyTo.Code, masterconfig."Company Name");
//                 end
//                 else begin
//                     ProductFamilyTo.TransferFields(ProductFamilyFrom, false);
//                     if ProductFamilyTo.Modify() then;
//                     Message(Text002, ProductFamilyTo.Code, masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;
// }
