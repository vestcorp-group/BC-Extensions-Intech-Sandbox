pageextension 75031 Posted_Purchase_Receipt_75031 extends "Posted Purchase Receipt"
{
    layout
    {
        addafter("Posting Date")
        {
            //T12240-NS

            field("LR/RR No."; Rec."LR/RR No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LR/RR No. field.', Comment = '%';
            }
            field("LR/RR Date"; Rec."LR/RR Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the LR/RR Date field.', Comment = '%';
            }
            field("Shipping Agent Code"; Rec."Shipping Agent Code")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shipping Agent Service Code field.', Comment = '%';
            }
            //T12240-NE
        }
        // Add changes to page layout here
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

    //120822 NS
    actions
    {
        addafter("&Receipt")
        {
            action("View Tax Transcation Entries")
            {
                ApplicationArea = Basic;
                Image = ViewDescription;

                trigger OnAction()
                var
                    TaxTrnasactionValue: Record "Tax Transaction Value";
                    PRL_lRec: Record "Purch. Rcpt. Line";
                begin
                    TaxTrnasactionValue.Reset();
                    PRL_lRec.RESET;
                    PRL_lRec.Setrange("Document No.", Rec."No.");
                    IF PRL_lRec.FindSet() Then begin
                        repeat
                            TaxTrnasactionValue.SetRange("Tax Record ID", PRL_lRec.RecordId);
                            IF TaxTrnasactionValue.FindSet() THen begin
                                repeat
                                    TaxTrnasactionValue.Mark(TRUE);
                                until TaxTrnasactionValue.Next() = 0;
                            end;

                            TaxTrnasactionValue.SetRange("Tax Record ID");
                        until PRL_lRec.Next() = 0;
                    end;

                    TaxTrnasactionValue.MarkedOnly(TRUE);
                    Page.RunModal(Page::"INT_Tax Transcation Value View", TaxTrnasactionValue);
                end;
            }
        }
    }
    //120822 NE
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
    var
        myInt: Integer;
    begin
        GTSetup_gRec.ShowShortcutDimCode_gFnc(ShortcutDimCode_gCodeArr, Rec."Dimension Set ID");
    end;




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