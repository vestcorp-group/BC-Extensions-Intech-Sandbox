tableextension 74999 Inventory_Period_74999 extends "Inventory Period"
{
    fields
    {
        //InvOpnChk-NS
        field(74981; "Open For Entry"; Boolean)
        {
            Caption = 'Open For Entry';
            Description = 'InvOpnChk';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                UserSetup_lRec: Record "User Setup";
            begin
                //InvOpnChk-NS
                UserSetup_lRec.GET(USERID);
                UserSetup_lRec.TESTFIELD("Allow to Open Inventory Period", TRUE);
                //InvOpnChk-NE

            end;
        }
        //InvOpnChk-NE
    }


    procedure InvtPeriodEntryExists_gfun(EndingDate: Date): Boolean
    var
        InvtPeriod: Record "Inventory Period";
    begin
        //InvOpnChk-NS
        InvtPeriod.SETRANGE("Ending Date", EndingDate);
        InvtPeriod.SETRANGE("Open For Entry", TRUE);
        EXIT(InvtPeriod.ISEMPTY);
        //InvOpnChk-NE
    end;
}
