codeunit 80206 "INT Install Code-PC"
{
    Subtype = Install;
    trigger OnInstallAppPerCompany()
    var
        INTSetup: Record "INT Packaging Config Setup";
        INTKeyValidationMgt: Codeunit "INT Key Validation Mgt- PC";
    begin

        if INTSetup.IsEmpty() then begin
            INTSetup.INIT();
            INTSetup.INSERT();
            INTSetup."Activation Key" := INTKeyValidationMgt.GetKey(30);
            INTSetup.Modify();
        end;

        // User_Local.Init();
        // User_Local.Validate("User Security ID", CreateGuid());
        // User_Local.Validate("User Name", 'BC');
        // User_Local.Validate("Full Name", 'Business Portal User');
        // User_Local.Validate("License Type", User_Local."License Type"::"Full User");
        // User_Local.Insert(true);

        // User_Local.Reset();
        // User_Local.SetRange("User Name", 'BC');
        // User_Local.FindFirst();

        // AccessControl.Init();
        // AccessControl.Validate("User Security ID", User_Local."User Security ID");
        // AccessControl.Insert(true);
    end;
}