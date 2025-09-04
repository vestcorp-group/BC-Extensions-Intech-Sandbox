pageextension 75002 Purchase_Order_List_75002 extends "Purchase Order List"
{
    layout
    {
        addafter(Amount)
        {
            field(AmountToCustomer; AmountToVendor_gDec)
            {
                ApplicationArea = All;
                Caption = 'Amount To Customer';
                Editable = false;
            }
            field(GSTAmount_gDec; GSTAmount_gDec)
            {
                ApplicationArea = All;
                Caption = 'GST Amount';
                Editable = false;
            }
            field(TDSAmount_gDec; TDSAmount_gDec)
            {
                ApplicationArea = All;
                Caption = 'TDS Amount';
                Editable = false;
            }
        }
        //ViewShortCutDim-NS
        addafter("Shortcut Dimension 2 Code")
        {
            field("ShortcutDimCode_gCodeArr[3]"; ShortcutDimCode_gCodeArr[3])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,3';
                Visible = ViewShortcutDim3_gBln;
            }
            field("ShortcutDimCode_gCodeArr[4]"; ShortcutDimCode_gCodeArr[4])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,4';
                Visible = ViewShortcutDim4_gBln;
            }
            field("ShortcutDimCode_gCodeArr[5]"; ShortcutDimCode_gCodeArr[5])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,5';
                Visible = ViewShortcutDim5_gBln;

            }
            field("ShortcutDimCode_gCodeArr[6]"; ShortcutDimCode_gCodeArr[6])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,6';
                Visible = ViewShortcutDim6_gBln;

            }

            field("ShortcutDimCode_gCodeArr[7]"; ShortcutDimCode_gCodeArr[7])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,7';
                Visible = ViewShortcutDim7_gBln;
            }

            field("ShortcutDimCode_gCodeArr[8"; ShortcutDimCode_gCodeArr[8])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,8';
                Visible = ViewShortcutDim7_gBln;
            }
        }
        //ViewShortCutDim-NE
    }
    trigger OnOpenPage()
    begin
        //ViewShortCutDim-NS
        GTSetup_gRec.GET;
        IF GTSetup_gRec."Shortcut Dimension 3 Code" <> '' then
            ViewShortcutDim3_gBln := true;

        GTSetup_gRec.GET;
        IF GTSetup_gRec."Shortcut Dimension 4 Code" <> '' then
            ViewShortcutDim4_gBln := true;

        GTSetup_gRec.GET;
        IF GTSetup_gRec."Shortcut Dimension 5 Code" <> '' then
            ViewShortcutDim5_gBln := true;

        GTSetup_gRec.GET;
        IF GTSetup_gRec."Shortcut Dimension 6 Code" <> '' then
            ViewShortcutDim6_gBln := true;

        GTSetup_gRec.GET;
        IF GTSetup_gRec."Shortcut Dimension 7 Code" <> '' then
            ViewShortcutDim7_gBln := true;

        GTSetup_gRec.GET;
        IF GTSetup_gRec."Shortcut Dimension 8 Code" <> '' then
            ViewShortcutDim8_gBln := true;
        //ViewShortCutDim-NE
    end;

    trigger OnAfterGetRecord()
    begin
        Clear(CalcStatistics_gCdu);
        CalcStatistics_gCdu.GetPurchaseStatisticsAmount(Rec, AmountToVendor_gDec);

        Clear(GSTStatistics_gCdu);
        GSTStatistics_gCdu.GetPurchaseStatisticsAmount(Rec, GSTAmount_gDec);

        Clear(INTTDSStatistics_gCdu);
        TDSAmount_gDec := INTTDSStatistics_gCdu.GetTDSAmount(Rec.RecordId);
        GTSetup_gRec.ShowShortcutDimCode_gFnc(ShortcutDimCode_gCodeArr, Rec."Dimension Set ID");
    end;

    var
        AmountToVendor_gDec: Decimal;
        GSTAmount_gDec: Decimal;
        CalcStatistics_gCdu: Codeunit "Calculate Statistics";
        GSTStatistics_gCdu: Codeunit "INT2 GST Statistics";
        TDSAmount_gDec: Decimal;
        INTTDSStatistics_gCdu: Codeunit "INT2 TDS Statistics";
        //ViewShortCutDim-NS
        ShortcutDimCode_gCodeArr: array[8] of Code[20];
        //[InDataSet]
        ViewShortcutDim3_gBln: Boolean;
        //[InDataSet]
        ViewShortcutDim4_gBln: Boolean;
        //[InDataSet]
        ViewShortcutDim5_gBln: Boolean;
        //[InDataSet]
        ViewShortcutDim6_gBln: Boolean;
        //[InDataSet]
        ViewShortcutDim7_gBln: Boolean;
        //[InDataSet]
        ViewShortcutDim8_gBln: Boolean;
        GTSetup_gRec: Record "General Ledger Setup";
    //ViewShortCutDim-NE

}