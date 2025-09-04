// tableextension 58241 TableextShippingAgent extends "Shipping Agent"
// {
//     procedure companytransfer(ShippingAgent_from: Record "Shipping Agent")
//     var
//         masterconfig: Record "Release to Company Setup";
//         ShippingAgent_to: Record "Shipping Agent";
//         Text001: Label 'Contact %1 transfered to %2 Company';
//         Text002: Label 'Contact Group %1 modified in %2 Company';
//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Customer", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 ShippingAgent_to.ChangeCompany(masterconfig."Company Name");
//                 ShippingAgent_to.Reset();
//                 if not ShippingAgent_to.Get(ShippingAgent_from.Code) then begin
//                     ShippingAgent_to.Init();
//                     ShippingAgent_to := ShippingAgent_from;
//                     if ShippingAgent_to.Insert() then;
//                     Message(Text001, ShippingAgent_to.Code, masterconfig."Company Name");
//                 end
//                 else begin
//                     ShippingAgent_to.TransferFields(ShippingAgent_from, false);
//                     if ShippingAgent_to.Modify() then;
//                     Message(Text002, ShippingAgent_to.Code, masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;
// }