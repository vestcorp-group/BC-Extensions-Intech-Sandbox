tableextension 74989 Sales_Header_74989 extends "Sales Header"
{

    fields
    {
        //SkipRefNoChk-NS
        field(74981; "Skip Check Invoice Ref"; Boolean)
        {
            Caption = 'Skip Check Invoice Reference for Old Invoice Credit Memo';
            DataClassification = ToBeClassified;
        }
        //SkipRefNoChk-NE
    }

    //ViewShortCutDim-NS
    procedure ShowShortcutDimCode_gFnc(var ShortcutDimCode_lCode: array[8] of Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode_lCode);
    end;

    procedure LookupShortcutDimCode_gFnc(FieldNumber_lInt: Integer; var ShortcutDimCode_lCode: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.LookupDimValueCode(FieldNumber_lInt, ShortcutDimCode_lCode);
        ValidateShortcutDimCode(FieldNumber_lInt, ShortcutDimCode_lCode);
    end;
    //ViewShortCutDim-NE

    local procedure "====FieldFunc======"()
    begin
    end;

    procedure "Amount To Customer"(): Decimal
    var
        TotalAmtInclGST_lDec: Decimal;
        CalcStatistics: Codeunit "Calculate Statistics";
    begin
        //Update Logic Here
        //DG-06-02-2023-NS
        CalcStatistics.GetSalesStatisticsAmount(Rec, TotalAmtInclGST_lDec);
        exit(TotalAmtInclGST_lDec);
        //DG-06-02-2023-NE
    end;

}