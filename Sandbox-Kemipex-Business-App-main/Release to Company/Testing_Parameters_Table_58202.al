// tableextension 58202 TestingParameterstableext extends "Testing Parameter"
// {
//     procedure companytransfer(TestingParameters_from: Record "Testing Parameter")//T12370-Full Comment
//     var
//         masterconfig: Record "Release to Company Setup";
//         TestingParameters_to: Record "Testing Parameter";
//         Text001: Label 'Testing Parameter %1 transfered to %2 Company';
//         Text002: Label 'Testing Parameter %1 modified in %2 Company';
//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Customer", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 TestingParameters_to.ChangeCompany(masterconfig."Company Name");
//                 TestingParameters_to.Reset();
//                 if not TestingParameters_to.Get(TestingParameters_from.Code) then begin
//                     TestingParameters_to.Init();
//                     TestingParameters_to := TestingParameters_from;
//                     if TestingParameters_to.Insert() then;
//                     Message(Text001, TestingParameters_to.Code, masterconfig."Company Name");
//                 end
//                 else begin
//                     TestingParameters_to.TransferFields(TestingParameters_from, false);
//                     if TestingParameters_to.Modify() then;
//                     Message(Text002, TestingParameters_to.Code, masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;
// }