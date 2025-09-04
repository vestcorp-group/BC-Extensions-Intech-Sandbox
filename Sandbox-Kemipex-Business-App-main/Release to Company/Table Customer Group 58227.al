// tableextension 58227 Customergroup extends "Customer Group"
// {
//     procedure companytransfer(CustomerGroup_from: Record "Customer Group")
//     var
//         masterconfig: Record "Release to Company Setup";
//         CustomerGroup_to: Record "Customer Group";
//         Text001: Label 'Customer Group %1 transfered to %2 Company';
//         Text002: Label 'Customer Group %1 modified in %2 Company';
//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Customer", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 CustomerGroup_to.ChangeCompany(masterconfig."Company Name");
//                 CustomerGroup_to.Reset();
//                 if not CustomerGroup_to.Get(CustomerGroup_from."Customer Group Code") then begin
//                     CustomerGroup_to.Init();
//                     CustomerGroup_to := CustomerGroup_from;
//                     if CustomerGroup_to.Insert() then;
//                     Message(Text001, CustomerGroup_to."Customer Group Code", masterconfig."Company Name");
//                 end
//                 else begin
//                     CustomerGroup_to.TransferFields(CustomerGroup_from, false);
//                     if CustomerGroup_to.Modify() then;
//                     Message(Text002, CustomerGroup_to."Customer Group Code", masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;
// }