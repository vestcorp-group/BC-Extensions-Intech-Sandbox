tableextension 74984 Purchase_Header_74984 extends "Purchase Header"
{
    fields
    {
        field(74331; Remarks; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(74332; "LR/RR No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'C0007';
        }
        field(74333; "LR/RR Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'C0007';
        }
        field(74334; "Vendor Invoice Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        // Add changes to table fields here
        //SkipRefNoChk-NS
        field(74981; "Skip Check Invoice Ref"; Boolean)
        {
            Caption = 'Skip Check Invoice Reference for Old Invoice Credit Memo';
            DataClassification = ToBeClassified;
        }
        //SkipRefNoChk-NE
    }

    var
        myInt: Integer;

    procedure CalculateImportDuty(var PurchHeader_vRec: Record "Purchase Header")
    var
        PurchaseLine_lRec: Record "Purchase Line";
        GSTImportDutySetup_lRec: Record "GST Import Duty Setup";
        LandingCost_lDec: Decimal;
        BCDAmount_lDec: Decimal;
        CustomeCessAmount_lDec: Decimal;
        CustomSHECessAmount_lDec: Decimal;
        TotalAmountForCustomDutyCalculation_lDec: Decimal;
    begin
        PurchaseLine_lRec.RESET;
        PurchaseLine_lRec.SETRANGE("Document Type", PurchHeader_vRec."Document Type");
        PurchaseLine_lRec.SETRANGE("Document No.", PurchHeader_vRec."No.");
        PurchaseLine_lRec.SETFILTER("No.", '<>%1', '');
        IF PurchaseLine_lRec.FINDSET THEN BEGIN
            REPEAT
                CLEAR(GSTImportDutySetup_lRec);
                IF GSTImportDutySetup_lRec.GET(PurchaseLine_lRec."GST Import Duty Code") THEN;

                LandingCost_lDec := 0;
                IF PurchaseLine_lRec."GST Assessable Value" <> 0 THEN
                    PurchaseLine_lRec."Landing Cost Amount" := PurchaseLine_lRec."GST Assessable Value" * PurchHeader_vRec."Currency Factor";
                IF PurchaseLine_lRec."GST Assessable Value" = 0 THEN
                    PurchaseLine_lRec."Landing Cost Amount" := ROUND((((PurchaseLine_lRec."Line Amount" + LandingCost_lDec) * GSTImportDutySetup_lRec."Landing Cost %") / 100), 0.01);

                //Calculation of Landing Cost <- End
                IF PurchaseLine_lRec."GST Assessable Value" <> 0 THEN
                    TotalAmountForCustomDutyCalculation_lDec := PurchaseLine_lRec."Landing Cost Amount";
                IF PurchaseLine_lRec."GST Assessable Value" = 0 THEN
                    TotalAmountForCustomDutyCalculation_lDec := PurchaseLine_lRec."Line Amount" + PurchaseLine_lRec."Landing Cost Amount" + LandingCost_lDec;

                //Calculation of Custom Duty Amount -> Start
                IF GSTImportDutySetup_lRec.Code <> '' THEN BEGIN
                    BCDAmount_lDec := ROUND(((TotalAmountForCustomDutyCalculation_lDec * GSTImportDutySetup_lRec."BCD %") / 100), 0.00001);
                    CustomeCessAmount_lDec := ROUND(((BCDAmount_lDec * GSTImportDutySetup_lRec."Custom eCess %") / 100), 0.00001);
                    CustomSHECessAmount_lDec := ROUND(((BCDAmount_lDec * GSTImportDutySetup_lRec."Custom SHE Cess %") / 100), 0.00001);

                    PurchaseLine_lRec."Custom Duty Amount" := BCDAmount_lDec + CustomeCessAmount_lDec + CustomSHECessAmount_lDec;
                END;
                //Calculation of Custom Duty Amount <- End

                //NG-NS 103117
                IF NOT (PurchHeader_vRec."GST Vendor Type" IN [PurchHeader_vRec."GST Vendor Type"::Import, PurchHeader_vRec."GST Vendor Type"::SEZ]) THEN BEGIN
                    PurchaseLine_lRec."Landing Cost Amount" := 0;
                    PurchaseLine_lRec."Custom Duty Amount" := 0;
                    PurchaseLine_lRec."GST Import Duty Code" := '';
                    PurchaseLine_lRec."GST Assessable Value" := 0;
                    PurchaseLine_lRec."GST Assessable Value" := 0;
                END;

                IF (PurchaseLine_lRec."GST Assessable Value" = 0) AND (PurchaseLine_lRec."GST Import Duty Code" = '') THEN BEGIN
                    PurchaseLine_lRec."Landing Cost Amount" := 0;
                    PurchaseLine_lRec."Custom Duty Amount" := 0;
                END;
                //NG-NE 103117

                PurchaseLine_lRec.MODIFY;
            until PurchaseLine_lRec.Next() = 0;
        end;
    end;
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

    procedure "Amount To Vendor"(): Decimal
    var
        CalAmount_lDec: Decimal;
        CalcStatistics: Codeunit "Calculate Statistics";
    begin
        //Update Logic Here
        //DG-NS
        CalcStatistics.GetPurchaseStatisticsAmount(Rec, CalAmount_lDec);
        exit(CalAmount_lDec);
        //DG-NE
    end;
}