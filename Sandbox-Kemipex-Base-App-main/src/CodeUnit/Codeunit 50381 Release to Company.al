// codeunit 50381 "Release to Company" //T12370-Full Comment
// {
//     trigger OnRun()
//     begin

//     end;

//     var
//         myInt: Integer;

//     procedure BlanketReleaseToCompany(RecID: RecordId; RecDesc: Text)
//     VAR
//         RecordRefFrom: RecordRef;
//         FieldReffrom: FieldRef;
//         RecordRefTo: RecordRef;
//         ReleaseToCompanySetup: Record "Release to Company Setup";
//         Rec2: Record "Item Entry Relation";
//         Transferred: Label '%1 Transfered to %2 Company';
//         Modified: Label '%1 Modified in %2 Company';

//     begin
//         RecordRefFrom.Open(RecID.TableNo);
//         RecordRefTo.Open(RecID.TableNo);
//         RecordRefFrom.Get(RecID);

//         ReleaseToCompanySetup.Reset();
//         ReleaseToCompanySetup.SetRange("Transfer Others", true);
//         ReleaseToCompanySetup.SetFilter("Company Name", '<>%1', CompanyName);

//         if ReleaseToCompanySetup.FindSet() then
//             repeat
//                 RecordRefTo.ChangeCompany(ReleaseToCompanySetup."Company Name");
//                 RecordRefTo.Reset();
//                 if not RecordRefTo.Get(RecID) then begin
//                     RecordRefTo.Init();

//                     RecordRefTo.Copy(RecordRefFrom, false);


//                     if RecordRefTo.Insert() then
//                         Message(Transferred, RecDesc, ReleaseToCompanySetup."Company Name");
//                 end
//                 else begin
//                     RecordRefTo.Copy(RecordRefFrom, false);
//                     RecordRefTo.ChangeCompany(ReleaseToCompanySetup."Company Name");

//                     if RecordRefTo.Modify() then
//                         Message(Modified, RecDesc, ReleaseToCompanySetup."Company Name");
//                 end;
//             until ReleaseToCompanySetup.Next() = 0;
//         RecordRefFrom.Close();
//         RecordRefTo.Close();
//     end;

//     procedure ReleaseVendorMaster(Vendor_From: Record Vendor)
//     var
//         ReleaseTocomSetup: Record "Release to Company Setup";
//         ToVendor: Record Vendor;
//         Text001: Label 'Vendor %1 transferred to %2 Company. ';
//         Text002: Label 'Vendor %1 exist in %2 Company. ';
//     begin
//         ReleaseTocomSetup.Reset;
//         ReleaseTocomSetup.SetRange(ReleaseTocomSetup."Transfer Vendor", true);
//         ReleaseTocomSetup.SetFilter(ReleaseTocomSetup."Company Name", '<>%1', CompanyName);
//         if ReleaseTocomSetup.FindSet then
//             repeat
//                 ToVendor.ChangeCompany(ReleaseTocomSetup."Company Name");
//                 ToVendor.Reset;
//                 if not ToVendor.Get(Vendor_From."No.") then begin
//                     ToVendor.Init;
//                     ToVendor := Vendor_From;
//                     IF ToVendor.Insert then;
//                     Message(Text001, ToVendor."No.", ReleaseTocomSetup."Company Name");
//                 end
//                 else begin
//                     ToVendor.TransferFields(Vendor_From, false);
//                     IF ToVendor.Modify() then;
//                     Message(Text002, Vendor_From."No.", ReleaseTocomSetup."Company Name");
//                 end;
//             until ReleaseTocomSetup.Next = 0;
//     end;

//     procedure ReleaseGLMaster(GL_From: Record "G/L Account")
//     var
//         ReleaseCompSetup: Record "Release to Company Setup";
//         ToGL: Record "G/L Account";
//         Text001: Label 'Account %1 transferred to %2 Company.';
//         Text002: Label 'Account %1 exists in %2 Company.';
//     begin
//         ReleaseCompSetup.Reset;
//         ReleaseCompSetup.SetRange(ReleaseCompSetup."Transfer Gl Account", true);
//         ReleaseCompSetup.SetFilter(ReleaseCompSetup."Company Name", '<>%1', CompanyName);
//         if ReleaseCompSetup.FindSet then
//             repeat
//                 ToGL.ChangeCompany(ReleaseCompSetup."Company Name");
//                 ToGL.Reset;
//                 if not ToGL.Get(GL_From."No.") then begin
//                     ToGL.Init;
//                     ToGL := GL_From;
//                     IF ToGL.Insert then;
//                     Message(Text001, ToGL."No.", ReleaseCompSetup."Company Name");
//                 end
//                 else begin
//                     ToGL.TransferFields(GL_From, false);
//                     IF ToGL.Modify() then;
//                 ENd;
//                 Message(Text002, GL_From."No.", ReleaseCompSetup."Company Name");
//             until ReleaseCompSetup.Next = 0;
//     end;

//     procedure ReleasePODtoCompany(POD_from: Record "Area")
//     var
//         masterconfig: Record "Release to Company Setup";
//         POD_to: Record "Area";
//         Text001: Label 'Port of Discharge  %1 transfered to %2 Company';
//         Text002: Label 'Port of Discharge  %1 modified in %2 Company';
//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Customer", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 POD_to.ChangeCompany(masterconfig."Company Name");
//                 POD_to.Reset();
//                 if not POD_to.Get(POD_from.Code) then begin
//                     POD_to.Init();
//                     POD_to := POD_from;
//                     if POD_to.Insert() then;
//                     Message(Text001, POD_to.Text, masterconfig."Company Name");
//                 end
//                 else begin
//                     POD_to.Text := POD_from.Text;
//                     if POD_to.Modify() then;
//                     Message(Text002, POD_to.Text, masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;

//     [EventSubscriber(ObjectType::Table, Database::"Area", 'OnAfterValidateEvent', 'Text', true, true)]
//     local procedure ValidatePODText(var Rec: Record "Area")

//     begin
//         ReleasePODtoCompany(Rec);
//     end;

//     procedure ReleasePOLtoCompany(POL_from: Record "Entry/Exit Point")
//     var
//         masterconfig: Record "Release to Company Setup";
//         POL_to: Record "Entry/Exit Point";
//         Text001: Label 'Port of Loading %1 transfered to %2 Company';
//         Text002: Label 'Port of Loading %1 modified in %2 Company';
//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Customer", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 POL_to.ChangeCompany(masterconfig."Company Name");
//                 POL_to.Reset();
//                 if not POL_to.Get(POL_from.Code) then begin
//                     POL_to.Init();
//                     POL_to := POL_from;
//                     if POL_to.Insert() then;
//                     Message(Text001, POL_to.Description, masterconfig."Company Name");
//                 end
//                 else begin
//                     POL_to.Description := POL_from.Description;
//                     if POL_to.Modify() then;
//                     Message(Text002, POL_to.Description, masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;

//     [EventSubscriber(ObjectType::Table, Database::"Entry/Exit Point", 'OnAfterValidateEvent', 'Description', true, true)]
//     local procedure ValidatePOLDesc(var Rec: Record "Entry/Exit Point")
//     begin
//         ReleasePOLtoCompany(Rec);
//     end;

//     procedure ReleaseSalepersonToCompany(SP_from: Record "Salesperson/Purchaser")
//     var
//         masterconfig: Record "Release to Company Setup";
//         SP_to: Record "Salesperson/Purchaser";
//         Text001: Label 'Salesperson %1 transfered to %2 Company';
//         Text002: Label 'Salesperson %1 modified in %2 Company';
//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Customer", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 SP_to.ChangeCompany(masterconfig."Company Name");
//                 SP_to.Reset();
//                 if not SP_to.Get(SP_from.Code) then begin
//                     SP_to.Init();
//                     SP_to := SP_from;
//                     if SP_to.Insert() then;
//                     Message(Text001, SP_to.Name, masterconfig."Company Name");
//                 end
//                 else begin
//                     sp_to.TransferFields(SP_from, false);
//                     if SP_to.Modify() then;
//                     Message(Text002, SP_to.Name, masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;

//     procedure ReleaseUserSetupToCompany(us_from: Record "User Setup")
//     var
//         masterconfig: Record "Release to Company Setup";
//         us_to: Record "User Setup";
//         Text001: Label 'User %1 transfer to %2 Company';
//         Text002: Label 'User %1 modified in %2 Company';

//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Gl Account", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 us_to.ChangeCompany(masterconfig."Company Name");
//                 us_to.Reset();
//                 if not us_to.Get(us_from."User ID") then begin
//                     us_to.Init();
//                     us_to := us_from;
//                     if us_to.Insert() then;
//                     Message(Text001, us_from."User ID", masterconfig."Company Name");
//                 end
//                 else begin
//                     us_to.TransferFields(us_from, false);
//                     if us_to.Modify() then;
//                     Message(Text002, us_to."User ID", masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;

//     procedure ReleaseMarktetIndustry(miname_from: Record KMP_TblMarketIndustry)
//     var
//         masterconfig: Record "Release to Company Setup";
//         miname_to: Record KMP_TblMarketIndustry;
//         Text001: Label 'Market Industry %1 transfer to %2 Company';
//         Text002: Label 'Market Industry %1 modified in %2 Company';

//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Customer", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 miname_to.ChangeCompany(masterconfig."Company Name");
//                 miname_to.Reset();
//                 if not miname_to.Get(miname_from.Code) then begin
//                     miname_to.Init();
//                     miname_to := miname_from;
//                     if miname_to.Insert() then;
//                     Message(Text001, miname_from.Description, masterconfig."Company Name");
//                 end
//                 else begin
//                     miname_to.Description := miname_from.Description;
//                     if miname_to.Modify() then;
//                     Message(Text002, miname_to.Description, masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;

//     procedure ReleaseManufacturerToCompany(mname_from: Record KMP_TblManufacturerName)
//     var
//         masterconfig: Record "Release to Company Setup";
//         mname_to: Record KMP_TblManufacturerName;
//         Text001: Label 'Manufacturer %1 transfer to %2 Company';
//         Text002: Label 'Manufacturer %1 modified in %2 Company';

//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Customer", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 mname_to.ChangeCompany(masterconfig."Company Name");
//                 mname_to.Reset();
//                 if not mname_to.Get(mname_from.Code) then begin
//                     mname_to.Init();
//                     mname_to := mname_from;
//                     if mname_to.Insert() then;
//                     Message(Text001, mname_from.Description, masterconfig."Company Name");
//                 end
//                 else begin
//                     mname_to.Description := mname_from.Description;
//                     if mname_to.Modify() then;
//                     Message(Text002, mname_to.Description, masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;


//     procedure ReleaseItemChargeToCompany(ItemCharge_from: Record "Item Charge")
//     var
//         masterconfig: Record "Release to Company Setup";
//         ItemCharge_to: Record "Item Charge";
//         Text001: Label 'Item Charge %1 transfered to %2 Company';
//         Text002: Label 'Item Charge %1 modified in %2 Company';
//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Customer", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 ItemCharge_to.ChangeCompany(masterconfig."Company Name");
//                 ItemCharge_to.Reset();
//                 if not ItemCharge_to.Get(ItemCharge_from."No.") then begin
//                     ItemCharge_to.Init();
//                     ItemCharge_to."No." := ItemCharge_from."No.";
//                     ItemCharge_to.Description := ItemCharge_from.Description;
//                     ItemCharge_to.Validate("Gen. Prod. Posting Group", ItemCharge_from."Gen. Prod. Posting Group");
//                     //ItemCharge_to.Validate("Tax Group Code", ItemCharge_from."Tax Group Code");
//                     ItemCharge_to.Validate("VAT Prod. Posting Group", ItemCharge_from."VAT Prod. Posting Group");
//                     ItemCharge_to."Search Description" := ItemCharge_from."Search Description";
//                     ItemCharge_to."Global Dimension 1 Code" := ItemCharge_from."Global Dimension 1 Code";
//                     ItemCharge_to."Global Dimension 2 Code" := ItemCharge_from."Global Dimension 2 Code";
//                     if ItemCharge_to.Insert() then;
//                     Message(Text001, ItemCharge_to.Description, masterconfig."Company Name");
//                 end
//                 else begin
//                     ItemCharge_to.Description := ItemCharge_from.Description;
//                     ItemCharge_to.Validate("Gen. Prod. Posting Group", ItemCharge_from."Gen. Prod. Posting Group");
//                     //ItemCharge_to.Validate("Tax Group Code", ItemCharge_from."Tax Group Code");
//                     ItemCharge_to.Validate("VAT Prod. Posting Group", ItemCharge_from."VAT Prod. Posting Group");
//                     ItemCharge_to."Search Description" := ItemCharge_from."Search Description";
//                     ItemCharge_to."Global Dimension 1 Code" := ItemCharge_from."Global Dimension 1 Code";
//                     ItemCharge_to."Global Dimension 2 Code" := ItemCharge_from."Global Dimension 2 Code";
//                     if ItemCharge_to.Modify() then;
//                     Message(Text002, ItemCharge_to.Description, masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;

//     procedure ReleaseGenericNameToCompany(gname_from: Record KMP_TblGenericName)
//     var
//         masterconfig: Record "Release to Company Setup";
//         gname_to: Record KMP_TblGenericName;
//         Text001: Label 'Generic Name %1 transfer to %2 Company';
//         Text002: Label 'Generic Name %1 modified in %2 Company';
//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Customer", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 gname_to.ChangeCompany(masterconfig."Company Name");
//                 gname_to.Reset();
//                 if not gname_to.Get(gname_from.Code) then begin
//                     gname_to.Init();
//                     gname_to := gname_from;
//                     if gname_to.Insert() then;
//                     Message(Text001, gname_from.Description, masterconfig."Company Name");
//                 end
//                 else begin
//                     gname_to.Description := gname_from.Description;
//                     if gname_to.Modify() then;
//                     Message(Text002, gname_to.Description, masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;

//     procedure ReleaseInventorypostingSetupToCompany(is_from: Record "Inventory Posting Setup")
//     var
//         masterconfig: Record "Release to Company Setup";
//         is_to: Record "Inventory Posting Setup";
//         Text001: Label 'Inventory Posting Setup %1 transfered to %2 Company';
//         Text002: Label 'Inventory Posting Setup %1 modified in %2 Company';

//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Customer", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 is_to.ChangeCompany(masterconfig."Company Name");
//                 is_to.Reset();
//                 if not is_to.Get(is_from."Location Code", is_from."Invt. Posting Group Code") then begin
//                     is_to.Init();
//                     is_to := is_from;
//                     if is_to.Insert() then;
//                     Message(Text001, is_from."Location Code", masterconfig."Company Name");
//                 end
//                 else begin
//                     is_to.TransferFields(is_from);
//                     // is_to."Inventory Account" := is_from."Inventory Account";
//                     // is_to.Description := is_from.Description;
//                     // is_to."View All Accounts on Lookup" := is_from."View All Accounts on Lookup";
//                     // is_to."Inventory Account (Interim)" := is_from."Inventory Account (Interim)";
//                     // is_to."WIP Account" := is_from."WIP Account";
//                     // is_to."Material Variance Account" := is_from."Material Variance Account";
//                     // is_to."Capacity Variance Account" := is_from."Capacity Variance Account";
//                     // is_to."Mfg. Overhead Variance Account" := is_from."Mfg. Overhead Variance Account";
//                     // is_to."Cap. Overhead Variance Account" := is_from."Cap. Overhead Variance Account";
//                     // is_to."Subcontracted Variance Account" := is_from."Subcontracted Variance Account";
//                     if is_to.Modify() then;
//                     Message(Text002, is_to."Location Code", masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;

//     procedure ReleaseGenProdPostGroupToCompany(GEN_PD_GP_from: Record "Gen. Product Posting Group")
//     var
//         masterconfig: Record "Release to Company Setup";
//         GEN_PD_GP_to: Record "Gen. Product Posting Group";
//         Text001: Label 'Product Posting Group %1 transfered to %2 Company';
//         Text002: Label 'Product Posting Group %1 modified in %2 Company';
//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Customer", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 GEN_PD_GP_to.ChangeCompany(masterconfig."Company Name");
//                 GEN_PD_GP_to.Reset();
//                 if not GEN_PD_GP_to.Get(GEN_PD_GP_from.Code) then begin
//                     GEN_PD_GP_to.Init();
//                     GEN_PD_GP_to := GEN_PD_GP_from;
//                     if GEN_PD_GP_to.Insert() then;
//                     Message(Text001, GEN_PD_GP_to.Code, masterconfig."Company Name");
//                 end
//                 else begin
//                     GEN_PD_GP_to.Description := GEN_PD_GP_from.Description;
//                     GEN_PD_GP_to."Def. VAT Prod. Posting Group" := GEN_PD_GP_from."Def. VAT Prod. Posting Group";
//                     GEN_PD_GP_to."Auto Insert Default" := GEN_PD_GP_from."Auto Insert Default";
//                     if GEN_PD_GP_to.Modify() then;
//                     Message(Text002, GEN_PD_GP_to.Code, masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;

//     procedure ReleaseFXRateToCompany(Cur_FX_from: Record "Currency Exchange Rate")
//     var
//         masterconfig: Record "Release to Company Setup";
//         Cur_FX_To: Record "Currency Exchange Rate";
//         Text001: Label 'Exchange Rate for  %1 transfered to %2 Company';
//         Text002: Label 'Exchange Rate for  %1 modified in %2 Company';
//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Exchange Rate", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 Cur_FX_To.ChangeCompany(masterconfig."Company Name");
//                 Cur_FX_To.Reset();
//                 if not Cur_FX_To.Get(Cur_FX_from."Currency Code", Cur_FX_from."Starting Date") then begin
//                     Cur_FX_To.Init();
//                     Cur_FX_To := Cur_FX_from;
//                     if Cur_FX_To.Insert() then;
//                     Message(Text001, Cur_FX_To."Starting Date", masterconfig."Company Name");
//                 end
//                 else begin
//                     Cur_FX_To."Exchange Rate Amount" := Cur_FX_from."Exchange Rate Amount";
//                     Cur_FX_To."Adjustment Exch. Rate Amount" := Cur_FX_from."Adjustment Exch. Rate Amount";
//                     Cur_FX_To."Relational Currency Code" := Cur_FX_from."Relational Currency Code";
//                     Cur_FX_To."Relational Exch. Rate Amount" := Cur_FX_from."Relational Exch. Rate Amount";
//                     Cur_FX_To."Fix Exchange Rate Amount" := Cur_FX_from."Fix Exchange Rate Amount";
//                     Cur_FX_To."Relational Adjmt Exch Rate Amt" := Cur_FX_from."Relational Adjmt Exch Rate Amt";

//                     Cur_FX_To.Modify();
//                     Message(Text002, Cur_FX_To."Starting Date", masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;

//     procedure ReleaseLocationToCompany(Location_from: Record Location)
//     var
//         masterconfig: Record "Release to Company Setup";
//         Location_to: Record Location;
//         Text001: Label 'Location %1 transfered to %2 Company';
//         Text002: Label 'Location %1 modified in %2 Company';
//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Customer", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 Location_to.ChangeCompany(masterconfig."Company Name");
//                 Location_to.Reset();
//                 if not Location_to.Get(Location_from.Code) then begin
//                     Location_to.Init();
//                     Location_to := Location_from;
//                     if Location_to.Insert() then;
//                     Message(Text001, Location_to.Name, masterconfig."Company Name");
//                 end
//                 else begin
//                     Location_to.TransferFields(Location_from, false);
//                     if Location_to.Modify() then;
//                     Message(Text002, Location_to.Name, masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;

//     procedure ReleaseReportSelectionToCompany(rss_from: Record "Report Selections")
//     var
//         masterconfig: Record "Release to Company Setup";
//         rss_to: Record "Report Selections";
//         Text001: Label 'Report Selections %1 transfer to %2 Company';
//         Text002: Label 'Report Selections %1 modified in %2 Company';

//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Customer", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 rss_to.ChangeCompany(masterconfig."Company Name");
//                 rss_to.Reset();
//                 if not rss_to.Get(rss_from.Usage, rss_from.Sequence) then begin
//                     rss_to.Init();
//                     rss_to := rss_from;
//                     if rss_to.Insert() then;
//                     Message(Text001, rss_from."Report Caption", masterconfig."Company Name");
//                 end
//                 else begin

//                     rss_to.TransferFields(rss_from, false);
//                     // rss_to."Report ID" := rss_from."Report ID";
//                     // rss_to."Report Caption" := rss_from."Report Caption";
//                     // rss_to."Custom Report Layout Code" := rss_from."Custom Report Layout Code";
//                     // rss_to."Use for Email Attachment" := rss_from."Use for Email Attachment";
//                     // rss_to."Use for Email Body" := rss_from."Use for Email Body";
//                     // rss_to."Email Body Layout Code" := rss_from."Email Body Layout Code";
//                     // rss_to."Email Body Layout Description" := rss_from."Email Body Layout Description";
//                     // rss_to."Email Body Layout Type" := rss_from."Email Body Layout Type";
//                     if rss_to.Modify() then;
//                     Message(Text002, rss_to."Report Caption", masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;


//     procedure ReleaseResponsibilityCenterToCompany(RC_from: Record "Responsibility Center")
//     var
//         masterconfig: Record "Release to Company Setup";
//         RC_to: Record "Responsibility Center";
//         Text001: Label 'Payment Term %1 transfered to %2 Company';
//         Text002: Label 'Payment Term %1 modified in %2 Company';
//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Customer", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 RC_to.ChangeCompany(masterconfig."Company Name");
//                 RC_to.Reset();
//                 if not RC_to.Get(RC_from.Code) then begin
//                     RC_to.Init();
//                     RC_to := RC_from;
//                     if RC_to.Insert() then;
//                     Message(Text001, RC_to.Name, masterconfig."Company Name");
//                 end
//                 else begin
//                     RC_to.TransferFields(RC_from, false);
//                     // RC_to.Name := RC_from.Name;
//                     // RC_to.Address := RC_from.Address;
//                     // RC_to."Address 2" := RC_from."Address 2";
//                     // RC_to.City := RC_from.City;
//                     // RC_to.Contact := RC_from.Contact;
//                     // RC_to."Contract Gain/Loss Amount" := RC_from."Contract Gain/Loss Amount";
//                     // RC_to."Country/Region Code" := RC_from."Country/Region Code";
//                     // RC_to."Date Filter" := RC_from."Date Filter";
//                     // RC_to."E-Mail" := RC_from."E-Mail";
//                     // RC_to."Fax No." := RC_from."Fax No.";
//                     // RC_to."Global Dimension 1 Code" := RC_from."Global Dimension 1 Code";
//                     // RC_to."Global Dimension 2 Code" := RC_from."Global Dimension 2 Code";
//                     // RC_to."Home Page" := RC_from."Home Page";
//                     // RC_to."Location Code" := RC_from."Location Code";
//                     // RC_to."Post Code" := RC_from."Post Code";
//                     // RC_to.County := RC_from.County;
//                     // RC_to."Phone No." := RC_from."Phone No.";
//                     if RC_to.Modify() then;
//                     Message(Text002, RC_to.Name, masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;

//     procedure ReleaseHSCodetoCompany(TariffNumbers_from: Record "Tariff Number")
//     var
//         masterconfig: Record "Release to Company Setup";
//         TariffNumbers_to: Record "Tariff Number";
//         Text001: Label 'HS Code %1 transfered to %2 Company';
//         Text002: Label 'HS Code %1 modified in %2 Company';
//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Customer", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 TariffNumbers_to.ChangeCompany(masterconfig."Company Name");
//                 TariffNumbers_to.Reset();
//                 if not TariffNumbers_to.Get(TariffNumbers_from."No.") then begin
//                     TariffNumbers_to.Init();
//                     TariffNumbers_to := TariffNumbers_from;
//                     if TariffNumbers_to.Insert() then;
//                     Message(Text001, TariffNumbers_to."No.", masterconfig."Company Name");
//                 end
//                 else begin
//                     TariffNumbers_to.TransferFields(TariffNumbers_from, false);
//                     if TariffNumbers_to.Modify() then;
//                     Message(Text002, TariffNumbers_to."No.", masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;

//     procedure ReleaseTeamsToCompany(Team_from: Record Team)
//     var
//         masterconfig: Record "Release to Company Setup";
//         Team_to: Record Team;
//         Team_Salespersons_from: Record "Team Salesperson";
//         Team_Salespersons_to: Record "Team Salesperson";
//         Text001: Label 'Teams %1 transfered to %2 Company';
//         Text002: Label 'Teams %1 modified in %2 Company';
//     begin
//         masterconfig.reset();
//         masterconfig.SetRange(masterconfig."Transfer Customer", true);
//         masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
//         if masterconfig.FindSet() then
//             repeat
//                 Team_to.ChangeCompany(masterconfig."Company Name");
//                 Team_to.Reset();
//                 if not Team_to.Get(Team_from.Code) then begin
//                     Team_to.Init();
//                     Team_to := Team_from;
//                     if Team_to.Insert() then;
//                     Team_Salespersons_from.Reset();
//                     Team_Salespersons_from.SetRange("Team Code", Team_from.code);
//                     if Team_Salespersons_from.FindSet() then begin
//                         repeat
//                             Team_Salespersons_to.ChangeCompany(masterconfig."Company Name");
//                             Team_Salespersons_to.Reset();
//                             if not Team_Salespersons_to.Get(Team_Salespersons_from."Team Code", Team_Salespersons_from."Salesperson Code") then
//                                 Team_Salespersons_to.Init();
//                             Team_Salespersons_to := Team_Salespersons_from;
//                             Team_Salespersons_to.Insert();
//                         until Team_Salespersons_from.Next() = 0;
//                     end;
//                     Message(Text001, Team_to.Code, masterconfig."Company Name");
//                 end
//                 else begin
//                     Team_to.TransferFields(Team_from, false);
//                     if Team_to.Modify() then begin
//                         Team_Salespersons_from.Reset();
//                         Team_Salespersons_from.SetRange("Team Code", Team_from.Code);
//                         Team_Salespersons_to.ChangeCompany(masterconfig."Company Name");
//                         Team_to.Reset();
//                         Team_Salespersons_to.SetRange("Team Code", Team_from.Code);
//                         if Team_Salespersons_to.FindSet() then
//                             Team_Salespersons_to.DeleteAll();
//                         if Team_Salespersons_from.FindSet() then
//                             repeat
//                                 //    if not Team_Salespersons_to.Get(Team_Salespersons_from."Team Code", Team_Salespersons_from."Salesperson Code") then begin
//                                 Team_Salespersons_to.Init();
//                                 Team_Salespersons_to := Team_Salespersons_from;
//                                 if Team_Salespersons_to.Insert() then;
//                             //  end
//                             Until Team_Salespersons_from.Next() = 0;
//                     end;
//                     Message(Text002, Team_to.Code, masterconfig."Company Name");
//                 end;
//             until masterconfig.Next() = 0;
//     end;

// }
