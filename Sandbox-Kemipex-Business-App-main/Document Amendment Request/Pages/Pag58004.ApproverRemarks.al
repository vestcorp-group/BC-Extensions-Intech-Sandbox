page 58004 "Approver Remarks"//T12370-Full Comment //T12574-N
{
    Caption = 'Approver Remarks';
    PageType = StandardDialog;
    // SourceTable = "Approval Entry";
    // Permissions = tabledata "Approval Entry" = RIMD;
    Editable = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Approver Remarks"; Remarks)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowMandatory = true;
                    Editable = true;
                    Enabled = true;
                }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction in [CloseAction::OK, CloseAction::LookupOK] then begin
            if Remarks = '' then
                Error('Approver Remarks must have a value.');
        end;
    end;

    procedure GetRemarks(): Text
    begin
        exit(Remarks);
    end;

    var
        Remarks: Text[250];
}
