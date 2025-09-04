Codeunit 75009 Subscribe_Table_454_INTGEN
{

    trigger OnRun()
    begin
    end;

    //ViewApproalEntries-NS
    [EventSubscriber(ObjectType::Table, Database::"Approval Entry", 'OnBeforeMarkAllWhereUserisApproverOrSender', '', false, false)]
    local procedure OnBeforeMarkAllWhereUserisApproverOrSender(var ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean);
    begin
        IsHandled := true;  //Enveryone Can View Approval Entry on Approvals Entry Page
    end;
    //ViewApproalEntries-NE
}

