report 85657 "FPO Print"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    Description = 'T51931';
    RDLCLayout = './Layouts/FPOPrint.rdl';


    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            column(SrNoOut_gInt; SrNoOut_gInt)
            {
            }
            column(SrNoCon_gInt; SrNoCon_gInt)
            {
            }
            column(ConsumptionEntry_gBln; ConsumptionEntry_gBln)
            {
            }
            column(OutputEntry_gBln; OutputEntry_gBln)
            {
            }
            column(QtyPer_gDec; QtyPer_gDec)
            {
            }
            column(DocumentNo_ItemLedgerEntry; "Document No.")
            {
            }
            column(EntryType_ItemLedgerEntry; "Entry Type")
            {
            }
            column(PostingDate_ItemLedgerEntry; "Posting Date")
            {
            }
            column(LocationCode_ItemLedgerEntry; "Location Code")
            {
            }
            column(LotNo_ItemLedgerEntry; "Lot No.")
            {
            }
            column(ItemNo_ItemLedgerEntry; "Item No.")
            {
            }
            column(PackSize_gTxt; PackSize_gTxt)
            {
            }
            column(Description_ItemLedgerEntry; Description)
            {
            }
            column(UnitofMeasureCode_ItemLedgerEntry; "Unit of Measure Code")
            {
            }
            column(Quantity_ItemLedgerEntry; Quantity)
            {
            }
            column(ConsumedQty_gDec; ConsumedQty_gDec)
            {
            }
            column(OutputQty_gDec; OutputQty_gDec)
            {
            }
            column(FinishedDate; ProdOrder_gRec."Finished Date")
            {
            }
            column(LotSize; ProdOrder_gRec."Batch Quantity")
            {
            }
            column(FinishedGoods; ProdOrder_gRec.Description)
            {
            }
            column(CustomBOENumber_ItemLedgerEntry; CustomBOENumber)
            {
            }
            column(UnitPrice_gDec; UnitPrice_gDec)
            {
            }
            column(PrinInput_gBln; PrinInput_gBln)
            {
            }
            column(currencyCode; GLSetup_gRec."LCY Code")
            {
            }

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                ConsumptionEntry_gBln := false;
                OutputEntry_gBln := false;
                if ("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Consumption) or ("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::"Assembly Consumption") then begin
                    SrNoCon_gInt += 1;
                    ConsumedQty_gDec := "Item Ledger Entry".Quantity;
                    ConsumptionEntry_gBln := true;
                end else if ("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::Output) or ("Item Ledger Entry"."Entry Type" = "Item Ledger Entry"."Entry Type"::"Assembly Output") then begin
                    SrNoOut_gInt += 1;
                    OutputQty_gDec := "Item Ledger Entry".Quantity;
                    OutputEntry_gBln := true;
                End;
                if ProdOrder_gRec.Get(ProdOrder_gRec.Status::Finished, "Item Ledger Entry"."Order No.") then;

                Clear(QtyPer_gDec);
                if Item_gRec.Get(ProdOrder_gRec."Source No.") then begin
                    ProdBomHdr_gRec.Reset();
                    ProdBomHdr_gRec.SetRange("No.", Item_gRec."Production BOM No.");
                    if ProdBomHdr_gRec.FindFirst() then begin
                        ProdBomLine_gRec.Reset();
                        ProdBomLine_gRec.SetRange("Production BOM No.", ProdBomHdr_gRec."No.");
                        ProdBomLine_gRec.SetRange("No.", "Item Ledger Entry"."Item No.");
                        if ProdBomLine_gRec.Findset() then
                            repeat
                                QtyPer_gDec := ProdBomLine_gRec."Quantity per";
                                PrinInput_gBln := ProdBomLine_gRec."Principal Input";
                            until ProdBomLine_gRec.Next() = 0
                    end;
                end;

                SKU_gRec.Reset();
                SKU_gRec.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                SKU_gRec.SetRange("Location Code", "Item Ledger Entry"."Location Code");
                SKU_gRec.SetRange("Variant Code", "Item Ledger Entry"."Variant Code");
                if SKU_gRec.FindFirst() then
                    UnitPrice_gDec := SKU_gRec."Unit Cost";

                ItemVariant_gRec.Reset();
                ItemVariant_gRec.SetRange(code, "Item Ledger Entry"."Variant Code");
                ItemVariant_gRec.SetRange("Item No.", "Item Ledger Entry"."Item No.");
                if ItemVariant_gRec.FindSet() then
                    PackSize_gTxt := ItemVariant_gRec."Packing Description";
            end;

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                GLSetup_gRec.Get();
            end;
        }
    }


    var
        ProdOrder_gRec: Record "Production Order";
        ItemVariant_gRec: Record "Item Variant";
        Item_gRec: Record Item;
        ProdBomHdr_gRec: Record "Production BOM Header";
        ProdBomLine_gRec: Record "Production BOM Line";
        SKU_gRec: Record "Stockkeeping Unit";
        GLSetup_gRec: Record "General Ledger Setup";
        SrNoOut_gInt: Integer;
        SrNoCon_gInt: Integer;
        OutputEntry_gBln: Boolean;
        ConsumptionEntry_gBln: Boolean;
        QtyPer_gDec: Decimal;
        UnitPrice_gDec: Decimal;
        PrinInput_gBln: Boolean;
        PackSize_gTxt: Text;
        ConsumedQty_gDec: Decimal;
        OutputQty_gDec: Decimal;
}