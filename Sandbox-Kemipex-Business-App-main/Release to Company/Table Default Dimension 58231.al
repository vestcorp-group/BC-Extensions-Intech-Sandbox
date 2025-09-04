// tableextension 58231 DefaultDimensionValue extends "Default Dimension"//T12370-Full Comment
// {
//     procedure companytransfer(DefaultDimension_from: Record "Default Dimension")
//     var
//         masterconfig: Record "Release to Company Setup";
//         DefaultDimension_to: Record "Default Dimension";
//         Text001: Label 'Dimension Value %1 transfered to %2 Company';
//         Text002: Label 'Dimension Value %1 modified in %2 Company';
//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Gl Account", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 DefaultDimension_to.ChangeCompany(masterconfig."Company Name");
//                 DefaultDimension_to.Reset();
//                 if not DefaultDimension_to.Get(DefaultDimension_from."Table ID") then begin
//                     DefaultDimension_to.Init();
//                     DefaultDimension_to := DefaultDimension_from;
//                     if DefaultDimension_to.Insert() then;
//                     Message(Text001, DefaultDimension_to."Dimension Code", masterconfig."Company Name");
//                 end
//                 else begin
//                     DefaultDimension_to.TransferFields(DefaultDimension_from, false);
//                     if DefaultDimension_to.Modify() then;
//                     Message(Text002, DefaultDimension_to."Dimension Code", masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;
// }