// tableextension 58130 columnlayoutnametableext extends "Column Layout Name"//T12370-Full Comment
// {
//     procedure companytransfer(column_from: Record "Column Layout Name")
//     var
//         masterconfig: Record "Release to Company Setup";
//         column_to: Record "Column Layout Name";
//         clline_from: Record "Column Layout";
//         clline_to: Record "Column Layout";
//         Text001: Label 'Column Layout Name %1 transfer to %2 Company';
//         Text002: Label 'Column Layout Name %1 modified in %2 Company';

//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Customer", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 column_to.ChangeCompany(masterconfig."Company Name");
//                 column_to.Reset();

//                 if not column_to.Get(column_from."Name") then begin
//                     column_to.Init();
//                     column_to := column_from;
//                     if column_to.Insert() then;
//                     clline_from.Reset();
//                     clline_from.SetRange("Column Layout Name", column_from.Name);
//                     if clline_from.FindSet() then begin
//                         repeat
//                             clline_to.ChangeCompany(masterconfig."Company Name");
//                             clline_to.Reset();
//                             if not clline_to.get(clline_from."Column Layout Name", clline_from."Line No.") then
//                                 clline_to.Init();
//                             clline_to := clline_from;
//                             if clline_to.Insert() then;
//                         until clline_from.Next() = 0;
//                     end;
//                     Message(Text001, column_from."Name", masterconfig."Company Name");
//                 end
//                 else begin
//                     column_to."Description" := column_from."Description";
//                     column_to."Analysis View Name" := column_to."Analysis View Name";
//                     if column_to.Modify() then;

//                     clline_from.Reset();
//                     clline_from.SetRange("Column Layout Name", column_from.Name);
//                     clline_to.ChangeCompany(masterconfig."Company Name");
//                     clline_to.Reset();
//                     clline_to.SetRange("Column Layout Name", column_from.Name);
//                     clline_to.DeleteAll();
//                     if clline_from.FindSet() then begin
//                         repeat
//                             if not clline_to.get(clline_from."Column Layout Name", clline_from."Line No.") then begin
//                                 clline_to.Init();
//                                 clline_to := clline_from;
//                                 if clline_to.Insert() then;
//                             end
//                         /*   else begin
//                                clline_to.ChangeCompany(masterconfig."Company Name");
//                                clline_to."Column No." := clline_from."Column No.";
//                                clline_to."Column Header" := clline_from."Column Header";
//                                clline_to."Column Type" := clline_from."Column Type";
//                                clline_to."Ledger Entry Type" := clline_from."Ledger Entry Type";
//                                clline_to."Amount Type" := clline_from."Amount Type";
//                                clline_to.Formula := clline_from.Formula;
//                                clline_to."Comparison Date Formula" := clline_from."Comparison Date Formula";
//                                clline_to."Show Opposite Sign" := clline_from."Show Opposite Sign";
//                                clline_to.Show := clline_from.Show;
//                                clline_to."Rounding Factor" := clline_from."Rounding Factor";
//                                clline_to."Show Indented Lines" := clline_from."Show Indented Lines";
//                                clline_to."Comparison Period Formula" := clline_from."Comparison Period Formula";
//                                clline_to."Business Unit Totaling" := clline_from."Business Unit Totaling";
//                                clline_to."Dimension 1 Totaling" := clline_from."Dimension 1 Totaling";
//                                clline_to."Dimension 2 Totaling" := clline_from."Dimension 2 Totaling";
//                                clline_to."Dimension 3 Totaling" := clline_from."Dimension 3 Totaling";
//                                clline_to."Dimension 4 Totaling" := clline_from."Dimension 4 Totaling";
//                                clline_to."Cost Center Totaling" := clline_from."Cost Center Totaling";
//                                clline_to."Cost Object Totaling" := clline_from."Cost Object Totaling";
//                                clline_to."Comparison Period Formula LCID" := clline_from."Comparison Period Formula LCID";
//                                if clline_to.Modify() then;
//                            end;
//                            */
//                         until clline_from.Next() = 0;
//                     end;
//                     Message(Text002, column_to."Name", masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;
// }