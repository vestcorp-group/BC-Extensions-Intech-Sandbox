Codeunit 74988 "Hide Wh Jnl Reg Dialog"
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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse. Jnl.-Register", 'OnBeforeConfirmRegisterLines', '', false, false)]
    local procedure OnBeforeConfirmRegisterLines(var WhseJnlLine: Record "Warehouse Journal Line"; var Result: Boolean; var IsHandled: Boolean);
    begin
        IF SetHideDia_gBln Then begin
            Result := TRUE;
            IsHandled := true;
        End;
    end;


    var
        SetHideDia_gBln: Boolean;
}

