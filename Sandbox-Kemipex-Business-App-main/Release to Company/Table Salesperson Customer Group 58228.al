// tableextension 58228 SalespersonCustomergroup extends "Salesperson Customer Group"
// {
//     procedure companytransfer(SPCustomerGroup_from: Record "Salesperson Customer Group")
//     var
//         masterconfig: Record "Release to Company Setup";
//         SPCustomerGroup_to: Record "Salesperson Customer Group";
//         Text001: Label 'Salesperson Customer Group %1 transfered to %2 Company';
//         Text002: Label 'Salesperson Customer Group %1 modified in %2 Company';
//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Customer", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 SPCustomerGroup_to.ChangeCompany(masterconfig."Company Name");
//                 SPCustomerGroup_to.Reset();
//                 if not SPCustomerGroup_to.Get(SPCustomerGroup_from."Customer Group Code") then begin
//                     SPCustomerGroup_to.Init();
//                     SPCustomerGroup_to := SPCustomerGroup_from;
//                     if SPCustomerGroup_to.Insert() then;
//                     Message(Text001, SPCustomerGroup_to."Customer Group Code", masterconfig."Company Name");
//                 end
//                 else begin
//                     SPCustomerGroup_to.TransferFields(SPCustomerGroup_from, false);
//                     if SPCustomerGroup_to.Modify() then;
//                     Message(Text002, SPCustomerGroup_to."Customer Group Code", masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;
// }