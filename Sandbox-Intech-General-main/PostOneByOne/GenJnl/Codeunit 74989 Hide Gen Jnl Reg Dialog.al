Codeunit 74989 "Hide Gen Jnl Reg Dialog"
{
    // Created By Nilesh Gajjar for NAV 2013 R2 Upgrade
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    procedure SetHideDia_gFnc(InputSetHideDia_iBln: Boolean)

    begin
        SetHideDia_gBln := InputSetHideDia_iBln;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post", 'OnBeforeCode', '', false, false)]
    local procedure OnBeforeCode(var GenJournalLine: Record "Gen. Journal Line"; var HideDialog: Boolean);
    begin
        IF SetHideDia_gBln Then begin
            HideDialog := true;
        End;
    end;

    var
        SetHideDia_gBln: Boolean;
}

