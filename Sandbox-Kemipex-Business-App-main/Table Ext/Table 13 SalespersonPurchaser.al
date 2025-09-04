tableextension 58094 Salesperson_table extends "Salesperson/Purchaser"//T12370-Full Comment     //T13413-Full UnComment
{
    fields
    {
        field(58027; "Sales Blocked"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(58028; "Purchase Blocked"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        modify("Privacy Blocked")
        {
            trigger OnAfterValidate()
            var
            begin
                if "Privacy Blocked" = true then begin
                    "Sales Blocked" := true;
                    "Purchase Blocked" := true;
                end
                else
                    exit
            end;
        }
    }
    // procedure companytransfer(SP_from: Record "Salesperson/Purchaser")
    // var
    //     masterconfig: Record 50101;
    //     SP_to: Record "Salesperson/Purchaser";
    //     Text001: Label 'Salesperson %1 transfered to %2 Company';
    //     Text002: Label 'Salesperson %1 modified in %2 Company';
    // begin
    //     masterconfig.reset();
    //     masterconfig.SetRange(masterconfig."Transfer Customer", true);
    //     masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
    //     if masterconfig.FindSet() then
    //         repeat
    //             SP_to.ChangeCompany(masterconfig."Company Name");
    //             SP_to.Reset();
    //             if not SP_to.Get(SP_from.Code) then begin
    //                 SP_to.Init();
    //                 SP_to := SP_from;
    //                 if SP_to.Insert() then;
    //                 Message(Text001, SP_to.Name, masterconfig."Company Name");
    //             end
    //             else begin
    //                 sp_to.TransferFields(SP_from, false);
    //                 if SP_to.Modify() then;
    //                 Message(Text002, SP_to.Name, masterconfig."Company Name");
    //             end;
    //         until masterconfig.Next() = 0;
    // end;
}