// tableextension 58128 columnlayouttableext extends "Column Layout"//T12370-Full Comment
// {
//     procedure companytransfer(column_from: Record "Column Layout")
//     var
//         masterconfig: Record "Release to Company Setup";
//         column_to: Record "Column Layout";
//         Text001: Label 'Column Layout %1 transfer to %2 Company';
//         Text002: Label 'Column Layout %1 modified in %2 Company';
//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Gl Account", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 column_to.ChangeCompany(masterconfig."Company Name");
//                 column_to.Reset();
//                 if not column_to.Get(column_from."Column Layout Name", column_from."Line No.") then begin
//                     column_to.Init();
//                     column_to := column_from;
//                     if column_to.Insert() then;
//                     Message(Text001, column_from."Column No.", masterconfig."Company Name");
//                 end
//                 else begin
//                     column_to."Column No." := column_from."Column No.";
//                     column_to."Column Header" := column_from."Column Header";
//                     column_to."Column Type" := column_from."Column Type";
//                     column_to."Ledger Entry Type" := column_from."Ledger Entry Type";
//                     column_to."Amount Type" := column_from."Amount Type";
//                     column_to.Formula := column_from.Formula;
//                     column_to."Comparison Date Formula" := column_from."Comparison Date Formula";
//                     column_to."Show Opposite Sign" := column_from."Show Opposite Sign";
//                     column_to.Show := column_from.Show;
//                     column_to."Rounding Factor" := column_from."Rounding Factor";
//                     column_to."Show Indented Lines" := column_from."Show Indented Lines";
//                     column_to."Comparison Period Formula" := column_from."Comparison Period Formula";
//                     column_to."Business Unit Totaling" := column_from."Business Unit Totaling";
//                     column_to."Dimension 1 Totaling" := column_from."Dimension 1 Totaling";
//                     column_to."Dimension 2 Totaling" := column_from."Dimension 2 Totaling";
//                     column_to."Dimension 3 Totaling" := column_from."Dimension 3 Totaling";
//                     column_to."Dimension 4 Totaling" := column_from."Dimension 4 Totaling";
//                     column_to."Cost Center Totaling" := column_from."Cost Center Totaling";
//                     column_to."Cost Object Totaling" := column_from."Cost Object Totaling";
//                     column_to."Comparison Period Formula LCID" := column_from."Comparison Period Formula LCID";
//                     if column_to.Modify() then;
//                     Message(Text002, column_to."Column No.", masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;
// }