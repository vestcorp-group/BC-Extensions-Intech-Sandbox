pageextension 85652 CompanyInformation extends "Company Information"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        //T13919-NS
        addafter(Action27)
        {
            action(UpdateICDetails)
            {
                ApplicationArea = All;
                Caption = 'Update IC Details';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    UpdateICDetails_lRpt: Report "Update IC Details";
                    ClientId_lTxt: Text;
                    SecretId_lTxt: Text;
                    InterCompTenantId_lTxt: Text;
                    InterCompTenantName_lTxt: Text;
                    Companies_lRec: Record "Company";
                    compinfo_lRec: Record "Company Information";
                begin
                    Clear(UpdateICDetails_lRpt);
                    UpdateICDetails_lRpt.RunModal();
                    UpdateICDetails_lRpt.GetValue(ClientId_lTxt, SecretId_lTxt, InterCompTenantId_lTxt, InterCompTenantName_lTxt);
                    if ClientId_lTxt = '' then
                        exit;
                    Companies_lRec.Reset();
                    if Companies_lRec.FindSet() then
                        repeat
                            compinfo_lRec.Reset();
                            compinfo_lRec.ChangeCompany(Companies_lRec."Name");
                            if compinfo_lRec.FindFirst() then begin
                                compinfo_lRec."Client ID" := ClientId_lTxt;
                                compinfo_lRec."Secret ID" := SecretId_lTxt;
                                compinfo_lRec."IC Tenant ID" := InterCompTenantId_lTxt;
                                compinfo_lRec."IC Tenant Name" := InterCompTenantName_lTxt;
                                compinfo_lRec.Modify();
                            end;

                        // Message(compinfo_lRec.Name);
                        until Companies_lRec.Next() = 0;
                end;
                //T13919-NE
            }
            action(UpdateICDetails_)
            {
                ApplicationArea = All;
                Caption = 'Update Stagging Company Information';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    Companies_lRec: Record Company;
                    compinfo_lRec: Record "Company Information";
                    stagingcompany_lRec: Record "Staging Company Information";
                begin
                    stagingcompany_lRec.Reset();
                    stagingcompany_lRec.DeleteAll();
                    Companies_lRec.Reset();
                    if Companies_lRec.FindSet() then
                        repeat
                            compinfo_lRec.Reset();
                            compinfo_lRec.ChangeCompany(Companies_lRec."Name");
                            compinfo_lRec.FindFirst();
                            compinfo_lRec.CalcFields(Stamp, Picture, Logo);
                            stagingcompany_lRec.Reset();
                            stagingcompany_lRec.SetRange(code, Companies_lRec.Name);
                            if not stagingcompany_lRec.FindFirst() then begin
                                stagingcompany_lRec.Init();
                                stagingcompany_lRec.Code := Companies_lRec.Name;
                                stagingcompany_lRec.Name := compinfo_lRec.Name;
                                stagingcompany_lRec."Name 2" := compinfo_lRec."Name 2";
                                stagingcompany_lRec.Address := compinfo_lRec.Address;
                                stagingcompany_lRec."Address 2" := compinfo_lRec."Address 2";
                                stagingcompany_lRec.City := compinfo_lRec.City;
                                stagingcompany_lRec."Phone No." := compinfo_lRec."Phone No.";
                                stagingcompany_lRec."Phone No. 2" := compinfo_lRec."Phone No. 2";
                                stagingcompany_lRec."Telex No." := compinfo_lRec."Telex No.";
                                stagingcompany_lRec."Fax No." := compinfo_lRec."Fax No.";
                                stagingcompany_lRec."VAT Registration No." := compinfo_lRec."VAT Registration No.";
                                stagingcompany_lRec."Registration No." := compinfo_lRec."Registration No.";
                                stagingcompany_lRec."Country/Region Code" := compinfo_lRec."Country/Region Code";
                                stagingcompany_lRec.Picture := compinfo_lRec.Picture;
                                stagingcompany_lRec."Stamp" := compinfo_lRec."Stamp";
                                stagingcompany_lRec."Logo" := compinfo_lRec."Logo";
                                stagingcompany_lRec.Insert();
                            end;
                        // Message(compinfo_lRec.Name);
                        until Companies_lRec.Next() = 0;
                    Message('Data updated succcessfully');
                end;
                //T13919-NE
            }
        }
    }

    var
}