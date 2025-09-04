pageextension 75045 Purchase_Credit_Memo_75045 extends "Purchase Credit Memo"
{
    layout
    {
        addlast(General)
        {
            //SkipRefNoChk-NS
            field("Skip Check Invoice Ref"; Rec."Skip Check Invoice Ref")
            {
                ToolTip = 'Specifies the value of the Skip Check Invoice Ref field.';
                ApplicationArea = All;
                Visible = ViewSkipRefNoCheck_gBln;
            }
            //SkipRefNoChk-NE
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

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    Rec.LookupShortcutDimCode_gFnc(3, ShortcutDimCode_gCodeArr[3]);
                end;

                trigger OnValidate()
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    Rec.ValidateShortcutDimCode(3, ShortcutDimCode_gCodeArr[3]);
                end;
            }
            field("ShortcutDimCode_gCodeArr[4]"; ShortcutDimCode_gCodeArr[4])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,4';
                Visible = ViewShortcutDim4_gBln;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    Rec.LookupShortcutDimCode_gFnc(4, ShortcutDimCode_gCodeArr[4]);
                end;

                trigger OnValidate()
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    Rec.ValidateShortcutDimCode(4, ShortcutDimCode_gCodeArr[4]);
                end;
            }
            field("ShortcutDimCode_gCodeArr[5]"; ShortcutDimCode_gCodeArr[5])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,5';
                Visible = ViewShortcutDim5_gBln;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    Rec.LookupShortcutDimCode_gFnc(5, ShortcutDimCode_gCodeArr[5]);
                end;

                trigger OnValidate()
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    Rec.ValidateShortcutDimCode(5, ShortcutDimCode_gCodeArr[5]);
                end;
            }
            field("ShortcutDimCode_gCodeArr[6]"; ShortcutDimCode_gCodeArr[6])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,6';
                Visible = ViewShortcutDim6_gBln;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    Rec.LookupShortcutDimCode_gFnc(6, ShortcutDimCode_gCodeArr[6]);
                end;

                trigger OnValidate()
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    Rec.ValidateShortcutDimCode(6, ShortcutDimCode_gCodeArr[6]);
                end;
            }

            field("ShortcutDimCode_gCodeArr[7]"; ShortcutDimCode_gCodeArr[7])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,7';
                Visible = ViewShortcutDim7_gBln;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    Rec.LookupShortcutDimCode_gFnc(7, ShortcutDimCode_gCodeArr[7]);
                end;

                trigger OnValidate()
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    Rec.ValidateShortcutDimCode(7, ShortcutDimCode_gCodeArr[7]);
                end;
            }

            field("ShortcutDimCode_gCodeArr[8"; ShortcutDimCode_gCodeArr[8])
            {
                ApplicationArea = Basic;
                CaptionClass = '1,2,8';
                Visible = ViewShortcutDim7_gBln;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    Rec.LookupShortcutDimCode_gFnc(8, ShortcutDimCode_gCodeArr[8]);
                end;

                trigger OnValidate()
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    Rec.ValidateShortcutDimCode(8, ShortcutDimCode_gCodeArr[8]);
                end;
            }
        }
        //ViewShortCutDim-NE
    }


    actions
    {
        // Add changes to page actions here
        addlast("F&unctions")
        {

            // 120822 -NS
            action("View Tax Transcation Entries")
            {
                ApplicationArea = Basic;
                Image = ViewDescription;

                trigger OnAction()
                var
                    TaxTrnasactionValue: Record "Tax Transaction Value";
                    PL_lRec: Record "Purchase Line";
                begin
                    TaxTrnasactionValue.Reset();
                    PL_lRec.RESET;
                    PL_lRec.Setrange("Document No.", Rec."No.");
                    IF PL_lRec.FindSet() Then begin
                        repeat
                            TaxTrnasactionValue.SetRange("Tax Record ID", PL_lRec.RecordId);
                            IF TaxTrnasactionValue.FindSet() THen begin
                                repeat
                                    TaxTrnasactionValue.Mark(TRUE);
                                until TaxTrnasactionValue.Next() = 0;
                            end;

                            TaxTrnasactionValue.SetRange("Tax Record ID");
                        until PL_lRec.Next() = 0;
                    end;

                    TaxTrnasactionValue.MarkedOnly(TRUE);
                    Page.RunModal(Page::"INT_Tax Transcation Value View", TaxTrnasactionValue);
                end;
            }

            //UpdateGSTDetail-NS
            action("Update GST Detail")
            {
                ApplicationArea = All;
                Image = AddAction;

                trigger OnAction()
                var
                    SalesPurchGSTMgt_lCdu: Codeunit "Sales/Purchase GST Mgt.";
                begin
                    //GST-NS
                    Clear(SalesPurchGSTMgt_lCdu);
                    SalesPurchGSTMgt_lCdu.UpdatePurchaseDocument_gFnc(Rec);
                    //GST-NE
                end;
            }
            //UpdateGSTDetail-NE
        }
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

        //SkipRefNoChk-NS
        PurchSetup_gRec.Get();
        ViewSkipRefNoCheck_gBln := PurchSetup_gRec."Enable Skip Ref Check";
        //SkipRefNoChk-NE
    end;


    trigger OnAfterGetRecord()
    begin
        Clear(GSTStatistics_gCdu);
        GSTStatistics_gCdu.GetPurchaseStatisticsAmount(Rec, GSTAmount_gDec);

        //ViewShortCutDim-NS
        Rec.ShowShortcutDimCode_gFnc(ShortcutDimCode_gCodeArr);
        //ViewShortCutDim-NE
    end;


    var
        GSTAmount_gDec: Decimal;

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

        //SkipRefNoChk-NS
        //[InDataSet]
        ViewSkipRefNoCheck_gBln: Boolean;
        PurchSetup_gRec: Record "Purchases & Payables Setup";
    //SkipRefNoChk-NE
}