pageextension 75027 Purchase_Invoice_75027 extends "Purchase Invoice"
{
    layout
    {
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
            action("Calculate Import Duty")
            {
                ApplicationArea = Basic;
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ImportDutyCalc: Report "Import Duty Calculation";
                    PurchHeader: Record "Purchase Header";
                begin
                    //Rec.CalculateImportDuty(Rec);
                    PurchHeader.Reset();
                    PurchHeader.SetRange("Document Type", Rec."Document Type");
                    PurchHeader.SetRange("No.", Rec."No.");
                    ImportDutyCalc.SetTableView(PurchHeader);
                    ImportDutyCalc.RunModal();
                end;
            }
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
    trigger OnAfterGetRecord()
    begin
        //ViewShortCutDim-NS
        Rec.ShowShortcutDimCode_gFnc(ShortcutDimCode_gCodeArr);
        //ViewShortCutDim-NE
    end;

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
    // 120822 -NE
    var
        myInt: Integer;
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