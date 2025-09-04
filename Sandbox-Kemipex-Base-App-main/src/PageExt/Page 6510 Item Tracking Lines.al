pageextension 50342 KMP_PageExtItemTrackingLine extends "Item Tracking Lines"//T12370-Full Comment
{
    layout
    {
        addafter("Lot No.")
        {
            field(CustomLotNumber; rec.CustomLotNumber)
            {
                ApplicationArea = all;
                AssistEdit = true;
                trigger OnAssistEdit()
                var
                    ReservEntry: Record "Reservation Entry";
                    SalesLineL: Record "Sales Line";
                    PurchaseLineL: Record "Purchase Line";
                    TransferLineL: Record "Transfer Line";
                    AssemblyLineL: Record "Assembly Line";
                    ItemJournalL: Record "Item Journal Line";
                    ItemTrackingDataCollection: Codeunit "Item Tracking Data Collection";
                    CreateReservEntry: Codeunit "Create Reserv. Entry";
                    CurrentSignFactor: Integer;
                    CurrentSourceType: Integer;
                    CurrentSourceCaption: Text[255];
                    SourceQuantityArray: array[5] of Decimal;
                    MaxQuantity: Decimal;
                    InsertIsBlocked: Boolean;
                begin
                    ReservEntry."Source Type" := Rec."Source Type";
                    ReservEntry."Source Subtype" := Rec."Source Subtype";
                    CurrentSignFactor := CreateReservEntry.SignFactor(ReservEntry);
                    CurrentSourceCaption := ReservEntry.TextCaption;
                    CurrentSourceType := ReservEntry."Source Type";
                    case true of
                        SalesLineL.Get(Rec."Source Subtype", rec."Source ID", Rec."Source Ref. No."):
                            SourceQuantityArray[1] := SalesLineL."Quantity (Base)";
                        PurchaseLineL.Get(Rec."Source Subtype", rec."Source ID", Rec."Source Ref. No."):
                            SourceQuantityArray[1] := PurchaseLineL."Quantity (Base)";
                        TransferLineL.Get(rec."Source ID", Rec."Source Ref. No."):
                            SourceQuantityArray[1] := TransferLineL."Quantity (Base)";
                        AssemblyLineL.Get(Rec."Source Subtype", rec."Source ID", Rec."Source Ref. No."):
                            SourceQuantityArray[1] := AssemblyLineL."Quantity (Base)";
                        ItemJournalL.Get(CopyStr(Rec."Source ID", 1, 10), Rec."Source Batch Name", Rec."Source Ref. No."):
                            SourceQuantityArray[1] := ItemJournalL."Quantity (Base)";
                    end;
                    MaxQuantity := SourceQuantityArray[1] - Rec."Quantity (Base)";
                    ItemTrackingDataCollection.AssistEditTrackingNo(Rec,
                      (CurrentSignFactor * SourceQuantityArray[1] < 0) AND NOT InsertIsBlocked,
                      CurrentSignFactor, Enum::"Item Tracking Type"::"Lot No.", MaxQuantity);//30-04-2022
                    // CurrentSignFactor, 1, MaxQuantity);//30-04-2022-commented and added above
                    rec."Bin Code" := '';
                    CurrPage.UPDATE;
                end;

                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    MakeCustomBOEEditable();
                end;
            }
            field(CustomBOENumber; rec.CustomBOENumber)
            {
                ApplicationArea = All;
                Caption = 'Custom BOE No.';
                Editable = CustomBOEEditableG;
            }
            field("New Custom Lot No."; rec."New Custom Lot No.")
            {
                ApplicationArea = all;
                Visible = NewBOENoVisibleG;
            }
            field("New BOE No."; rec."New Custom BOE No.")
            {
                ApplicationArea = all;
                Visible = NewBOENoVisibleG;
            }

            //Moved from PDCnOthers
            field("Supplier Batch No. 2"; rec."Supplier Batch No. 2")
            {
                ApplicationArea = All;
                Caption = 'Supplier Batch No.';
            }
            field("Manufacturing Date 2"; rec."Manufacturing Date 2")
            {
                ApplicationArea = All;
                Caption = 'Manufacturing Date';
            }
            field("Expiry Period 2"; rec."Expiry Period 2")
            {
                ApplicationArea = All;
                Caption = 'Expiry Period';
            }
            field("Gross Weight 2"; rec."Gross Weight 2")
            {
                ApplicationArea = All;
                Caption = 'Gross Weight';
            }
            field("Net Weight 2"; rec."Net Weight 2")
            {
                ApplicationArea = All;
                Caption = 'Net Weight';
            }
        }
        modify("Lot No.")
        {
            Visible = false;
        }
        modify("New Lot No.")
        {
            Visible = false;
        }
    }

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        MakeCustomBOEEditable();
    end;

    local procedure MakeCustomBOEEditable()
    var
        PurchHdrL: Record "Purchase Header";
        ItemJournalLineL: Record "Item Journal Line";
    begin
        if rec."Source Type" = Database::"Assembly Header" then
            CustomBOEEditableG := true;
        if rec."Source Type" = Database::"Purchase Line" then
            if PurchHdrL.Get(rec."Source Subtype", rec."Source ID") then
                if (PurchHdrL."IC Direction" = PurchHdrL."IC Direction"::Incoming) and (PurchHdrL."Buy-from IC Partner Code" <> '') then
                    CustomBOEEditableG := true;
        if rec."Source Type" = Database::"Item Journal Line" then begin
            ItemJournalLineL.Get(rec."Source ID", rec."Source Batch Name", rec."Source Ref. No.");
            NewBOENoVisibleG := ItemJournalLineL.IsReclass(ItemJournalLineL);
            if rec."Source Subtype" = rec."Source Subtype"::"6" then begin
                CustomBOEEditableG := true;
            end;
        end;
    end;

    var
        [InDataSet]
        CustomBOEEditableG: Boolean;
        [InDataSet]
        NewBOENoVisibleG: Boolean;
}