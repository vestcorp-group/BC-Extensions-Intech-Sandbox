Report 74985 "Import Duty Calculation"
{
    DefaultLayout = RDLC;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {

            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");

                trigger OnAfterGetRecord()
                var
                    TaxTransactionValue: Record "Tax Transaction Value";
                    GSTSetup: Record "GST Setup";
                    GSTRate: Decimal;
                begin
                    GSTSetup.GET;
                    TestField("GST Group Code");

                    "Purchase Line".Validate("GST Assessable Value", 10);

                    TaxTransactionValue.Reset();
                    TaxTransactionValue.SetRange("Tax Record ID", "Purchase Line".RecordId);
                    TaxTransactionValue.SetRange("Tax Type", GSTSetup."GST Tax Type");
                    TaxTransactionValue.SetRange("Value Type", TaxTransactionValue."Value Type"::COMPONENT);
                    TaxTransactionValue.SetRange("Value ID", 3);
                    TaxTransactionValue.SetFilter(Percent, '<>%1', 0);
                    IF TaxTransactionValue.IsEmpty then
                        exit;
                    TaxTransactionValue.FINDFIRST;
                    GSTRate := TaxTransactionValue.Percent;

                    if CustomExcRate_gDec <> 0 then
                        CustomDutyChargesFCY := CustomOtherCharges_gDec / CustomExcRate_gDec
                    else
                        CustomDutyChargesFCY := CustomOtherCharges_gDec;

                    PerLineChargesFCY_gDec := 0;
                    PerLineChargesFCY_gDec := ("Purchase Line"."Line Amount" * (CustomOtherCharges_gDec / CustomExcRate_gDec)) / TotalLineAmount_gDec;


                    if CustomExcRate_gDec <> 0 then
                        TotalAmtWithChargesInLCY_gDec := (PerLineChargesFCY_gDec + "Purchase Line"."Line Amount") * CustomExcRate_gDec
                    else
                        TotalAmtWithChargesInLCY_gDec := (PerLineChargesFCY_gDec + "Purchase Line"."Line Amount");

                    if "Purchase Line"."GST Import Duty Code" <> '' then begin
                        GSTImportDutySetup_gRec.Get("Purchase Line"."GST Import Duty Code");
                        BCDLCY_gDec := ROUND(((TotalAmtWithChargesInLCY_gDec * GSTImportDutySetup_gRec."BCD %") / 100), 0.01);
                        CustomECess_gDec := ROUND(((BCDLCY_gDec * GSTImportDutySetup_gRec."Custom eCess %") / 100), 0.01);
                        SHECess_gDec := ROUND(((BCDLCY_gDec * GSTImportDutySetup_gRec."Custom SHE Cess %") / 100), 0.01);
                        CustomDuty_gDec := ROUND((BCDLCY_gDec + SHECess_gDec + CustomECess_gDec) * "Purchase Header"."Currency Factor", 0.01);
                        GSTAssValue_gDec := ROUND((TotalAmtWithChargesInLCY_gDec * "Purchase Header"."Currency Factor"), 0.01);
                        GSTAmount_gDec := ROUND(((GSTAssValue_gDec * GSTRate) / 100), 0.01);
                    end;
                    "Purchase Line".Validate("GST Assessable Value", GSTAssValue_gDec);
                    "Purchase Line".Validate("Custom Duty Amount", CustomDuty_gDec);

                    "Purchase Line".Modify(true);
                end;

                trigger OnPreDataItem()
                begin
                    CustomDutyChargesFCY := 0;
                    CustomDutyChargesFCY_gDec := 0;
                    BCDLCY_gDec := 0;
                    SHECess_gDec := 0;
                    GSTAssValue_gDec := 0;
                    GSTAmount_gDec := 0;
                    CustomDuty_gDec := 0;
                    CustomECess_gDec := 0;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                TotalLineAmount_gDec := 0;
                PurchaseLine_gRec.Reset;
                PurchaseLine_gRec.SetRange("Document Type", "Purchase Header"."Document Type");
                PurchaseLine_gRec.SetRange("Document No.", "Purchase Header"."No.");
                if PurchaseLine_gRec.FindFirst then
                    repeat
                        TotalLineAmount_gDec += PurchaseLine_gRec."Line Amount";
                    until PurchaseLine_gRec.Next = 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Option)
                {
                    field("Custom Exc. Rate"; CustomExcRate_gDec)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Custom Other Charges"; CustomOtherCharges_gDec)
                    {
                        ApplicationArea = Basic;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CustomExcRate_gDec: Decimal;
        CustomOtherCharges_gDec: Decimal;
        CustomDutyChargesFCY: Decimal;
        TotalAmtWithChargesInLCY_gDec: Decimal;
        CustomDutyChargesFCY_gDec: Decimal;
        GSTImportDutySetup_gRec: Record "GST Import Duty Setup";
        BCDLCY_gDec: Decimal;
        SHECess_gDec: Decimal;
        CustomDuty_gDec: Decimal;
        GSTAssValue_gDec: Decimal;
        GSTAmount_gDec: Decimal;
        PerLineChargesFCY_gDec: Decimal;
        TotalLineAmount_gDec: Decimal;
        PurchaseLine_gRec: Record "Purchase Line";
        CustomECess_gDec: Decimal;
}

