// table 58156 "Kemipex Configuration Panel"//T12370-Full Comment
// {

//     // This table is no longer in use. 
//     DataClassification = ToBeClassified;

//     fields
//     {
//         field(1; PrimaryK; Integer)
//         {
//             DataClassification = ToBeClassified;
//         }
//         field(2; "Production Customer"; Text[200])
//         {
//             DataClassification = ToBeClassified;
//         }
//     }

//     keys
//     {
//         key(PK; PrimaryK)
//         {
//             Clustered = true;
//         }
//     }
// }

// // procedure companytransfer(KCP_from: Record "Kemipex Configuration Panel")
// // var
// //     masterconfig: Record 50101;
// //     KCP_to: Record "Kemipex Configuration Panel";
// //     Text001: Label 'Configuration Transfered to %1';
// //     Text002: Label 'Configuration Modified in %1';
// // begin
// //     masterconfig.reset();
// //     masterconfig.SetRange(masterconfig."Transfer Customer", true);
// //     masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
// //     if masterconfig.FindSet() then
// //         repeat
// //             KCP_to.ChangeCompany(masterconfig."Company Name");
// //             KCP_to.Reset();
// //             if not KCP_to.Get(KCP_from.PrimaryK) then begin
// //                 KCP_to.Init();
// //                 KCP_to := KCP_from;
// //                 if KCP_to.Insert() then;
// //                 Message(Text001, masterconfig."Company Name");
// //             end
// //             else begin
// //                 KCP_to."Production Customer" := KCP_from."Production Customer";
// //                 if KCP_to.Modify() then;
// //                 Message(Text002, masterconfig."Company Name");
// //             end;
// //         until masterconfig.Next() = 0;
// // end;

// // 