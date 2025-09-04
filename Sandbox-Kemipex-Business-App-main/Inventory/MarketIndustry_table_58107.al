// tableextension 58107 marketindustrytableext extends "KMP_TblMarketIndustry"//T12370-Full Comment
// {
//     fields
//     {
//         field(58040; "Customer Master Allowed"; Boolean)
//         {
//             DataClassification = ToBeClassified;
//         }
//     }
//     // procedure companytransfer(miname_from: Record KMP_TblMarketIndustry)
//     // var
//     //     masterconfig: Record 50101;
//     //     miname_to: Record KMP_TblMarketIndustry;
//     //     Text001: Label 'Market Industry %1 transfer to %2 Company';
//     //     Text002: Label 'Market Industry %1 modified in %2 Company';

//     // begin
//     //     masterconfig.reset();
//     //     masterconfig.SetRange(masterconfig."Transfer Customer", true);
//     //     masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//     //     if masterconfig.FindSet() then
//     //         repeat
//     //             miname_to.ChangeCompany(masterconfig."Company Name");
//     //             miname_to.Reset();
//     //             if not miname_to.Get(miname_from.Code) then begin
//     //                 miname_to.Init();
//     //                 miname_to := miname_from;
//     //                 if miname_to.Insert() then;
//     //                 Message(Text001, miname_from.Description, masterconfig."Company Name");
//     //             end
//     //             else begin
//     //                 miname_to.Description := miname_from.Description;
//     //                 if miname_to.Modify() then;
//     //                 Message(Text002, miname_to.Description, masterconfig."Company Name");
//     //             end;
//     //         until masterconfig.Next() = 0;
//     // end;
// }