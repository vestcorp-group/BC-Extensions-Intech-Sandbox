tableextension 74990 General_Ledger_Setup_74990 extends "General Ledger Setup"
{
    fields
    {
        //GSTPurchLia-NS
        field(74990; "Skip Intetrim Entry RC"; Boolean)
        {
            Caption = 'Skip Interim Entry Create Purchase Reverse Charge Case';
            DataClassification = ToBeClassified;
        }
        //GSTPurchLia-NE
    }
    procedure ShowShortcutDimCode_gFnc(var ShortcutDimCode_lCode: array[8] of Code[20]; DimSetID: Integer)
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.GetShortcutDimensions(DimSetID, ShortcutDimCode_lCode);
    end;
}
