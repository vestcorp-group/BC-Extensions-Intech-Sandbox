pageextension 50380 KMP_PageExtPurchaseOrdLine extends "Purchase Order Subform"//T12370-Full Comment T13620-N  50107-50380
{

    layout
    {
        // Add changes to page layout here
        // addafter(Quantity)
        // {
        //     field(CustomBOENumber; rec.CustomBOENumber)
        //     {
        //         ApplicationArea = All;
        //         Caption = 'Custom BOE No.';
        //         Editable = false;
        //     }
        // }

        addafter("Quantity Received")
        {
            field(CustomETD; rec.CustomETD)
            {
                ApplicationArea = All;
                Caption = 'ETD';
            }
            field(CustomETA; rec.CustomETA)
            {
                ApplicationArea = All;
                Caption = 'ETA';
            }
            field(CustomR_ETD; rec.CustomR_ETD)
            {
                ApplicationArea = All;
                Caption = 'R-ETD';
            }
            field(CustomR_ETA; rec.CustomR_ETA)
            {
                ApplicationArea = all;
                Caption = 'R-ETA';
            }
            // field("Container No. 2"; rec."Container No. 2")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Container No.';
            // }
        }

        // addafter("Quantity Invoiced")
        // {
        //     field("Profit % IC"; rec."Profit % IC")
        //     {
        //         ApplicationArea = all;
        //     }
        // }

        // modify("Order Date")
        // {
        //     Visible = false;
        //     ApplicationArea = All;
        // }

        // modify("Requested Receipt Date")
        // {
        //     Visible = false;
        //     ApplicationArea = All;
        // }

        // modify("Promised Receipt Date")
        // {
        //     Visible = false;
        //     ApplicationArea = All;

        // }
        // modify("Expected Receipt Date")
        // {
        //     Visible = false;
        //     ApplicationArea = All;

        // }

        // modify("Planned Receipt Date")
        // {
        //     Visible = false;
        //     ApplicationArea = All;
        // }

    }
    //T13935-NS
    actions
    {
        addafter("Co&mments")
        {
            action("Upload Lot No.")
            {
                ApplicationArea = all;
                Caption = 'Upload Lot No. from Excel';
                Image = ImportExcel;
                trigger OnAction()
                var
                    ExcelBuffer: Record "Excel Buffer";
                    ExcelBuffer2: Record "Excel Buffer";
                    PurchLineL: Record "Purchase Line";
                    FileMgt: Codeunit "File Management";
                    FileName: Text;
                    SupplierBatchNoL: Text[100];
                    InStreamL: InStream;
                    RowCountL: Integer;
                    ItemNoL: Code[20];
                    LotNoL: Code[50];
                    QuantityL: Decimal;
                    AnalysisDateL: Date;
                    ManufacturingDateL: Date;
                    ExpiryPeriodL: DateFormula;
                    FileExtensionFilterTok: Label 'Excel Files (*.xlsx)|*.xlsx|All Files (*.*)|*.*';
                    ExcelFileNameTok: Label '*%1.xlsx';
                    ExcelFileExtensionTok: Label '.xlsx';
                begin
                    ExcelBuffer.DeleteAll();
                    if not UPLOADINTOSTREAM('Select Excel File', '', FileExtensionFilterTok, FileName, InStreamL) then
                        exit;
                    ExcelBuffer.OpenBookStream(InStreamL, ExcelBuffer.SelectSheetsNameStream(InStreamL));
                    ExcelBuffer.ReadSheet;
                    PurchLineL.Reset();
                    PurchLineL.SetRange("Document Type", rec."Document Type");
                    PurchLineL.SetRange("Document No.", rec."Document No.");
                    PurchLineL.SetRange("Line No.", rec."Line No."); // Added after the discussion with manish.
                    if PurchLineL.FindSet() then
                        repeat
                            ExcelBuffer.Reset();
                            ExcelBuffer.SetRange("Cell Value as Text", PurchLineL."No.");
                            if ExcelBuffer.FindSet() then
                                repeat
                                    ExcelBuffer2.Reset();
                                    ExcelBuffer2.SetRange("Row No.", ExcelBuffer."Row No.");
                                    ExcelBuffer2.FindSet();
                                    for RowCountL := 1 to 7 do begin
                                        case ExcelBuffer2."Column No." of
                                            1:
                                                ItemNoL := ExcelBuffer2."Cell Value as Text";
                                            2:
                                                LotNoL := ExcelBuffer2."Cell Value as Text";
                                            3:
                                                Evaluate(QuantityL, ExcelBuffer2."Cell Value as Text");
                                            4:
                                                Evaluate(ManufacturingDateL, ExcelBuffer2."Cell Value as Text");
                                            5:
                                                Evaluate(ExpiryPeriodL, ExcelBuffer2."Cell Value as Text");
                                            6:
                                                SupplierBatchNoL := CopyStr(ExcelBuffer2."Cell Value as Text", 1, MaxStrLen(SupplierBatchNoL));
                                            7:
                                                Evaluate(AnalysisDateL, ExcelBuffer2."Cell Value as Text");
                                        end;
                                        ExcelBuffer2.Next(1);
                                    end;
                                    CreteResvEntry(PurchLineL, ItemNoL, LotNoL, QuantityL, ManufacturingDateL, ExpiryPeriodL, SupplierBatchNoL, AnalysisDateL);
                                until ExcelBuffer.Next() = 0;
                        until PurchLineL.Next() = 0;
                end;
            }
        }
    }
    local procedure CreteResvEntry(PurchLineP: Record "Purchase Line"; ItemNoP: Code[20]; LotNoP: Code[50]; QuantityP: Decimal; ManufacturingDateP: date; ExpiryPeriodP: DateFormula; SupplierBatchNoP: Text[100]; AnalysisDateP: Date)
    var
        ItemL: Record Item;
        ResvEntryL: Record "Reservation Entry";
        EntryNoL: Integer;
    begin
        ItemL.Get(ItemNoP);
        if ResvEntryL.FindLast() then
            ;
        EntryNoL := ResvEntryL."Entry No." + 1;
        ResvEntryL.Reset();
        ResvEntryL.SetSourceFilter(PurchLineP.RecordId.TableNo, PurchLineP."Document Type".AsInteger(), PurchLineP."Document No.", PurchLineP."Line No.", true);//30-04-2022-added asinteger withe enum
        //ResvEntryL.SetTrackingFilter('', LotNoP);//30-04-2022
        ResvEntryL.SetRange("Serial No.", '');//30-04-2022
        ResvEntryL.SetRange("Lot No.", LotNoP);//30-04-2022
        if not ResvEntryL.FindFirst() then begin
            ResvEntryL.Init();
            ResvEntryL."Entry No." := EntryNoL;
            ResvEntryL.Positive := true;
            ResvEntryL.SetSource(PurchLineP.RecordId.TableNo, PurchLineP."Document Type".AsInteger(), PurchLineP."Document No.", PurchLineP."Line No.", '', 0);//30-04-2022-Added As Integer with Enum
            ResvEntryL.SetItemData(ItemL."No.", ItemL.Description, PurchLineP."Location Code", PurchLineP."Variant Code", PurchLineP."Qty. per Unit of Measure");
            ResvEntryL."Creation Date" := WorkDate();
            ResvEntryL."Created By" := UserId;
            ResvEntryL."Reservation Status" := ResvEntryL."Reservation Status"::Surplus;
            ResvEntryL."Expected Receipt Date" := PurchLineP."Expected Receipt Date";
            ResvEntryL."Item Tracking" := ResvEntryL."Item Tracking"::"Lot No.";
            ResvEntryL.Insert();
        end;
        ResvEntryL."Manufacturing Date 2" := ManufacturingDateP;
        ResvEntryL."Expiry Period 2" := ExpiryPeriodP;
        //T51170-NS
        ResvEntryL."Warranty Date" := ManufacturingDateP;
        if (ResvEntryL."Manufacturing Date 2" <> 0D) and (format(ResvEntryL."Expiry Period 2") <> '') then
            ResvEntryL."Expiration Date" := CalcDate(ResvEntryL."Expiry Period 2", ResvEntryL."Manufacturing Date 2");
        //T51170-NE
        ResvEntryL.Validate("Quantity (Base)", QuantityP);
        ResvEntryL.CustomBOENumber := PurchLineP.CustomBOENumber;
        ResvEntryL.CustomLotNumber := LotNoP;
        if PurchLineP.CustomBOENumber > '' then
            ResvEntryL."Lot No." := LotNoP + '@' + PurchLineP.CustomBOENumber
        else
            ResvEntryL."Lot No." := LotNoP;
        ResvEntryL."Supplier Batch No. 2" := SupplierBatchNoP;
        ResvEntryL."Analysis Date" := AnalysisDateP; // Added for COA Process.
        ResvEntryL.Modify();
    end;
    //T13935-NE
    //T 10-04-2025-NS
    trigger OnModifyRecord(): Boolean
    var
        PurchaseHeader: Record "Purchase Header";
        HandledICInboxPurchLine: Record "Handled IC Inbox Purch. Line";
        HandledICInboxPurchHeader: Record "Handled IC Inbox Purch. Header";
        Text0001: Label 'You cannot modify because this is Inter Commpany Transaction.';
    begin
        if Rec."Document Type" <> Rec."Document Type"::Order then
            exit;

        PurchaseHeader.Reset();
        PurchaseHeader.Get(Rec."Document Type", Rec."Document No.");
        if PurchaseHeader."IC Transaction No." = 0 then
            exit;

        if Rec."IC Partner Ref. Type" = Rec."IC Partner Ref. Type"::"Cross Reference" then begin //Hypercare-09-04-2025-N
            HandledICInboxPurchHeader.reset;
            HandledICInboxPurchHeader.SetRange("IC Transaction No.", PurchaseHeader."IC Transaction No.");
            HandledICInboxPurchHeader.SetRange("Document Type", HandledICInboxPurchHeader."Document Type"::Order);
            HandledICInboxPurchHeader.SetRange("IC Partner Code", PurchaseHeader."Buy-from IC Partner Code");
            HandledICInboxPurchHeader.SetRange("No.", PurchaseHeader."IC Reference Document No.");
            if HandledICInboxPurchHeader.FindFirst() then begin

                HandledICInboxPurchLine.Reset();
                HandledICInboxPurchLine.SetRange("IC Transaction No.", HandledICInboxPurchHeader."IC Transaction No.");
                HandledICInboxPurchLine.SetRange("IC Partner Code", HandledICInboxPurchHeader."IC Partner Code");
                HandledICInboxPurchLine.SetRange("Line No.", Rec."Line No.");
                HandledICInboxPurchLine.SetRange("Transaction Source", HandledICInboxPurchHeader."Transaction Source");
                HandledICInboxPurchLine.SetFilter("IC Partner Reference", '<>%1', '');
                if HandledICInboxPurchLine.FindFirst() then begin

                    if Rec.Quantity <> HandledICInboxPurchLine.Quantity then
                        Error(Text0001);
                    if Rec."Unit of Measure Code" <> HandledICInboxPurchLine."Unit of Measure Code" then
                        Error(Text0001);
                    if HandledICInboxPurchLine."IC Partner Ref. Type" = HandledICInboxPurchLine."IC Partner Ref. Type"::"Cross Reference" then
                        if Rec."IC Item Reference No." <> HandledICInboxPurchLine."IC Item Reference No." then
                            Error(Text0001);
                end;
            end;

            if Rec."No." <> xRec."No." then
                Error(Text0001);
            if Rec."Variant Code" <> xRec."Variant Code" then
                Error(Text0001);
            if Rec."Line Amount" <> xRec."Line Amount" then
                Error(Text0001);
            if Rec."Direct Unit Cost" <> xRec."Direct Unit Cost" then
                Error(Text0001);
            if Rec."Line Discount Amount" <> xRec."Line Discount Amount" then
                Error(Text0001);
            if Rec."Inv. Discount Amount" <> xRec."Inv. Discount Amount" then
                Error(Text0001);
            if Rec."Line Discount %" <> xRec."Line Discount %" then
                Error(Text0001);
        end;//Hypercare-09-04-2025-N
    End;
    //T 10-04-2025-NE
}