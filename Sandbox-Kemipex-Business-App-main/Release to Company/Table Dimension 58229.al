// tableextension 58229 Dimension extends Dimension
// {
//     procedure companytransfer(Dimension_from: Record Dimension)
//     var
//         masterconfig: Record "Release to Company Setup";
//         Dimension_to: Record Dimension;
//         Text001: Label 'Dimension %1 transfered to %2 Company';
//         Text002: Label 'Dimension %1 modified in %2 Company';
//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Gl Account", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 Dimension_to.ChangeCompany(masterconfig."Company Name");
//                 Dimension_to.Reset();
//                 if not Dimension_to.Get(Dimension_from.Code) then begin
//                     Dimension_to.Init();
//                     Dimension_to := Dimension_from;
//                     if Dimension_to.Insert() then;
//                     Message(Text001, Dimension_to.Code, masterconfig."Company Name");
//                 end
//                 else begin
//                     Dimension_to.TransferFields(Dimension_from, false);
//                     if Dimension_to.Modify() then;
//                     Message(Text002, Dimension_to.Code, masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;
// }