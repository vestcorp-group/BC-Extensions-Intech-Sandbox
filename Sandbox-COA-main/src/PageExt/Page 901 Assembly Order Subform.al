pageextension 50507 AssemblyOrders extends "Assembly Order Subform"//T12370-Full Comment
{
    layout
    {
    }
    actions
    {
        addafter("Item Tracking Lines")
        {
            action("Copy Parameter")
            {
                ApplicationArea = all;
                /* Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true; */
                Caption = 'Copy lot and TP Finished Goods';
                trigger OnAction()
                var
                    LotVariantTestingParameterFromRec: Record "Lot Variant Testing Parameter"; //AJAY
                    LotVariantTestingParameterToRec: Record "Lot Variant Testing Parameter"; //AJAY
                    ReservationRec: Record "Reservation Entry";
                    ReservationRec2: Record "Reservation Entry";
                    entryno: Integer;
                    LotDialog: Dialog;
                    NewCode: Code[50];
                    lotGenpage: Page "Lot Generation Dialog";
                    AssemblyHeader: Record "Assembly Header";
                    CopyTP: Boolean;
                    ItemRecLine: Record Item;
                    ItemRecheader: Record Item;


                begin
                    Clear(NewCode);
                    Clear(lotGenpage);
                    Clear(PreviousLotNo_lCde);
                    if AssemblyHeader.Get(AssemblyHeader."Document Type"::Order, Rec."Document No.") then;
                    ItemRecLine.Get(Rec."No.");
                    ItemRecheader.Get(AssemblyHeader."Item No.");
                    if lotGenpage.RunModal() = Action::ok then begin
                        if ItemRecLine."Base Unit of Measure" <> ItemRecheader."Base Unit of Measure" then Error('Line Base UOM and Header Base UOM does not Match');
                        //if Rec."Quantity (Base)" > AssemblyHeader."Quantity (Base)" then Error('Line Qty. cannot be higher than Header Qty.');
                        begin
                            lotGenpage.GetFields(NewCode, CopyTP);
                            PreviousLotNo_lCde := NewCode;//28-01-2025
                            if IncStr(NewCode) = '' then Error('The value in the %1 field must have a number so that we can assign the next number in the series.', NewCode);
                            ReservationRec.SetRange("Item No.", Rec."No.");
                            ReservationRec.SetRange("Location Code", rec."Location Code");
                            ReservationRec.SetRange("Variant Code", rec."Variant Code"); //added by Bayas
                            ReservationRec.SetRange("Source type", 901);
                            ReservationRec.SetRange("Source Subtype", 1);
                            ReservationRec.SetRange("Source ID", Rec."Document No.");
                            ReservationRec.SetRange("Source Ref. No.", rec."Line No.");
                            if ReservationRec.FindSet() then begin
                                ReservationRec2.SetRange("Source ID", AssemblyHeader."No.");
                                ReservationRec2.SetRange("Source Ref. No.", 0);
                                ReservationRec2.SetRange("Source Type", 900);
                                ReservationRec2.SetRange("Item No.", AssemblyHeader."Item No.");
                                ReservationRec2.SetRange("Location Code", AssemblyHeader."Location Code");
                                ReservationRec2.SetRange("Variant Code", AssemblyHeader."Variant Code"); //added by Bayas
                                if ReservationRec2.FindSet() then
                                    Error('Header Lot No. already Exist')
                                else
                                    repeat
                                        NewCode := IncStr(NewCode);
                                        if ReservationRec2.FindLast() then entryno := ReservationRec2."Entry No." + 1;
                                        ReservationRec2.Init();
                                        ReservationRec2.TransferFields(ReservationRec);
                                        ReservationRec2."Entry No." := entryno;
                                        ReservationRec2."Item No." := AssemblyHeader."Item No.";
                                        ReservationRec2.Validate("Lot No.", NewCode);
                                        ReservationRec2.Validate("Lot No.", NewCode + '@' + ReservationRec.CustomBOENumber);
                                        ReservationRec2.CustomBOENumber := ReservationRec.CustomBOENumber;
                                        ReservationRec2."Supplier Batch No. 2" := ReservationRec.CustomLotNumber;
                                        ReservationRec2."Source Type" := 900;
                                        ReservationRec2."Source Ref. No." := 0;
                                        ReservationRec2."Shipment Date" := 0D;
                                        ReservationRec2.Validate("Expiry Period 2", ReservationRec."Expiry Period 2");
                                        ReservationRec2."Location Code" := AssemblyHeader."Location Code";
                                        ReservationRec2."Variant Code" := AssemblyHeader."Variant Code"; // added by Bayas
                                        ReservationRec2."Source Prod. Order Line" := 0;
                                        ReservationRec2.Positive := true;
                                        ReservationRec2.Validate("Quantity (Base)", Abs(ReservationRec."Quantity (Base)"));
                                        //Hypercare T13334-NS
                                        FindLotItemLedgerEntry_lFnc(ReservationRec, PreviousLotNo_lCde);
                                        ReservationRec2."QC No." := QCNo_gCde;
                                        ReservationRec2."Expiration Date" := ExpDate_gDte;//T13359-N
                                        ReservationRec2."Posted QC No." := PostedQCNo_gCde;
                                        //Hypercare T13334-NE
                                        if ReservationRec2.Insert() then begin
                                            if CopyTP then begin
                                                LotVariantTestingParameterFromRec.Reset();
                                                LotVariantTestingParameterFromRec.SetRange("Source ID", ReservationRec."Source ID");
                                                LotVariantTestingParameterFromRec.SetRange("Source Ref. No.", ReservationRec."Source Ref. No.");
                                                LotVariantTestingParameterFromRec.SetRange("Item No.", ReservationRec."Item No.");
                                                LotVariantTestingParameterFromRec.SetRange("Variant Code", ReservationRec."Variant Code");
                                                LotVariantTestingParameterFromRec.SetRange("Lot No.", ReservationRec.CustomLotNumber);
                                                LotVariantTestingParameterFromRec.SetRange("BOE No.", ReservationRec.CustomBOENumber);
                                                if LotVariantTestingParameterFromRec.FindSet() then begin
                                                    repeat
                                                        if not LotVariantTestingParameterToRec.Get(Rec."Document No.", 0, AssemblyHeader."Item No.", AssemblyHeader."Variant Code", NewCode, ReservationRec.CustomBOENumber, LotVariantTestingParameterFromRec.Code) then begin
                                                            LotVariantTestingParameterToRec.Init();
                                                            LotVariantTestingParameterToRec.TransferFields(LotVariantTestingParameterFromRec);
                                                            LotVariantTestingParameterToRec."Source Ref. No." := 0;
                                                            LotVariantTestingParameterToRec."Item No." := AssemblyHeader."Item No.";
                                                            LotVariantTestingParameterToRec."Variant Code" := AssemblyHeader."Variant Code";
                                                            //lottestingparamterToRec.Validate(Code, lottestingparamterFromRec.Code); //commented
                                                            LotVariantTestingParameterToRec."Lot No." := NewCode;
                                                            LotVariantTestingParameterToRec."BOE No." := ReservationRec.CustomBOENumber;
                                                            if LotVariantTestingParameterToRec.Insert() then;
                                                        end
                                                        else begin
                                                            LotVariantTestingParameterToRec."Actual Value" := LotVariantTestingParameterFromRec."Actual Value";
                                                            if LotVariantTestingParameterToRec.Modify() then;
                                                        end;
                                                    until LotVariantTestingParameterFromRec.Next() = 0;
                                                end;
                                            end;
                                        end;
                                    until ReservationRec.Next() = 0;
                                IF CopyTP THEN
                                    Message('Lot No. Generated and Testing Parameters Copied')
                                else
                                    Message('Lot No. Generated');
                            end
                            else
                                Message('Lot No. Missing for Item %1 %2', Rec."No.", Rec.Description);
                        end;
                    end;
                end;
            }
        }
    }
    var
        myInt: Integer;



        //Hypercare-NS T13334-NS
        QCNo_gCde: Code[20];
        PostedQCNo_gCde: Code[20];
        ExpDate_gDte: Date;//28-01-2025
        PreviousLotNo_lCde: Code[50];//28-01-2025
        AssemblyHeader_gRec: Record "Assembly Header";

    procedure FindLotItemLedgerEntry_lFnc(ReservationEntry_iRec: Record "Reservation Entry"; LotNo_iCde: code[50]) //Hypercare
    var
        ItemLedgerEntry_lRec: Record "Item Ledger Entry";
    begin
        Clear(QCNo_gCde);
        Clear(PostedQCNo_gCde);
        ExpDate_gDte := 0D;//T13359-N
        ItemLedgerEntry_lRec.reset;
        ItemLedgerEntry_lRec.SetRange("Item No.", ReservationEntry_iRec."Item No.");
        ItemLedgerEntry_lRec.SetRange("Variant Code", ReservationEntry_iRec."Variant Code");
        ItemLedgerEntry_lRec.SetRange("Location Code", ReservationEntry_iRec."Location Code");
        if LotNo_iCde <> '' then
            ItemLedgerEntry_lRec.SetRange("Lot No.", ReservationEntry_iRec."Lot No.");//Hypercare 01-03-2025
        ItemLedgerEntry_lRec.SetRange(Open, true);
        ItemLedgerEntry_lRec.SetFilter("Remaining Quantity", '>%1', 0);
        // ItemLedgerEntry_lRec.SetFilter("Posted QC No.", '<>%1', '');//T13359-O
        if ItemLedgerEntry_lRec.FindFirst() then begin
            QCNo_gCde := ItemLedgerEntry_lRec."QC No.";
            PostedQCNo_gCde := ItemLedgerEntry_lRec."Posted QC No.";
            ExpDate_gDte := ItemLedgerEntry_lRec."Expiration Date";//T13359-N
        end;
    end;

    //Hypercare-NE T13334-NE
}

