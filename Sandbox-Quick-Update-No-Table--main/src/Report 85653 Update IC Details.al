report 85653 "Update IC Details"
{
    Description = 'T13919';
    Caption = 'Update IC Details';
    ProcessingOnly = true;

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(AssignValues)
                {
                    Caption = 'Assign Values';

                    field(ClientId; ClientId_gTxt)
                    {
                        ApplicationArea = all;
                        Caption = 'Client Id';
                    }
                    field(SecretId; SecretId_gTxt)
                    {
                        ApplicationArea = all;
                        Caption = 'Secret Id';
                    }

                    field(InterCompTenantId; InterCompTenantId_gTxt)
                    {
                        ApplicationArea = all;
                        Caption = 'InterComp Tenant Id';
                    }
                    field(InterCompTenantName; InterCompTenantName_gTxt)
                    {
                        ApplicationArea = all;
                        Caption = 'InterComp Tenant Name';
                    }
                }
            }
        }
    }

    var
        ClientId_gTxt: Text;
        SecretId_gTxt: Text;
        InterCompTenantId_gTxt: Text;
        InterCompTenantName_gTxt: Text;

    procedure GetValue(var ClientIdiTxt: Text; var SecretIdiTxt: Text; var InterCompTenantIdiTxt: Text; var InterCompTenantNameiTxt: Text)
    begin
        ClientIdiTxt := ClientId_gTxt;
        SecretIdiTxt := SecretId_gTxt;
        InterCompTenantIdiTxt := InterCompTenantId_gTxt;
        InterCompTenantNameiTxt := InterCompTenantName_gTxt;
    end;
}