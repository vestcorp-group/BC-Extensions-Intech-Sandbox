// tableextension 58230 DimensionValue extends "Dimension Value"
// {
//     procedure companytransfer(DimensionVal_from: Record "Dimension Value")
//     var
//         masterconfig: Record "Release to Company Setup";
//         DimensionVal_to: Record "Dimension Value";
//         Text001: Label 'Dimension Value %1 transfered to %2 Company';
//         Text002: Label 'Dimension Value %1 modified in %2 Company';
//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Gl Account", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 DimensionVal_to.ChangeCompany(masterconfig."Company Name");
//                 DimensionVal_to.Reset();
//                 if not DimensionVal_to.Get(DimensionVal_from.Code) then begin
//                     DimensionVal_to.Init();
//                     DimensionVal_to := DimensionVal_from;
//                     if DimensionVal_to.Insert() then;
//                     Message(Text001, DimensionVal_to.Code, masterconfig."Company Name");
//                 end
//                 else begin
//                     DimensionVal_to.TransferFields(DimensionVal_from, false);
//                     if DimensionVal_to.Modify() then;
//                     Message(Text002, DimensionVal_to.Code, masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;
// }