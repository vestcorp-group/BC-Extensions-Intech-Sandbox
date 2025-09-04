tableextension 50469 ApprovalActivtyqueext extends "Approvals Activities Cue"
{
    fields
    {
        // Add changes to table fields here

        // field(50100; "Kemipex Requests to Approve"; Integer)
        // {
        //     CalcFormula = Count("Kemipex Approval Entry" WHERE("Approver ID" = FIELD("User ID Filter"),
        //                                                 Status = FILTER(Open)));
        //     Caption = 'Kemipex Requests to Approve';
        //     FieldClass = FlowField;
        // }
    }

    var
        myInt: Integer;
}