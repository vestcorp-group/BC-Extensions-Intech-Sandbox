report 85654 "Update IC trancation"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Description = 'T13919';
    ProcessingOnly = true;

    trigger OnPostReport()
    begin
        Companies_gRec.Reset();
        if Companies_gRec.FindSet() then
            repeat
                intercompaSetup_gRec.Reset();
                intercompaSetup_gRec.changeCompany(Companies_gRec."Name");
                if intercompaSetup_gRec.findset() then
                    repeat
                        intercompaSetup_gRec."Auto. Send Transactions" := true;
                        intercompaSetup_gRec."Transaction Notifications" := true;
                        intercompaSetup_gRec.Modify();
                    until intercompaSetup_gRec.Next() = 0;

                ICpartner_gRec.Reset();
                ICpartner_gRec.changeCompany(Companies_gRec."Name");
                if ICpartner_gRec.findset() then
                    repeat
                        ICpartner_gRec."Auto. Accept Transactions" := true;
                        ICpartner_gRec.Modify();
                    until ICpartner_gRec.Next() = 0;
            until Companies_gRec.Next() = 0;
    end;

    var
        Companies_gRec: record "Company";
        intercompaSetup_gRec: Record "IC Setup";
        ICpartner_gRec: Record "IC Partner";
}