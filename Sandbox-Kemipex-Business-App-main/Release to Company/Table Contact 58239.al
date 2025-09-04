// tableextension 58239 TableextContact extends Contact//T12370-Full Comment
// {
//     procedure companytransfer(Contact_from: Record Contact)
//     var
//         masterconfig: Record "Release to Company Setup";
//         Contact_to: Record Contact;
//         Text001: Label 'Contact %1 transfered to %2 Company';
//         Text002: Label 'Contact Group %1 modified in %2 Company';
//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Customer", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 Contact_to.ChangeCompany(masterconfig."Company Name");
//                 Contact_to.Reset();
//                 if not Contact_to.Get(Contact_from."No.") then begin
//                     Contact_to.Init();
//                     Contact_to := Contact_from;
//                     if Contact_to.Insert() then;
//                     Message(Text001, Contact_to."No.", masterconfig."Company Name");
//                 end
//                 else begin
//                     Contact_to.TransferFields(Contact_from, false);
//                     if Contact_to.Modify() then;
//                     Message(Text002, Contact_to."No.", masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;
// }