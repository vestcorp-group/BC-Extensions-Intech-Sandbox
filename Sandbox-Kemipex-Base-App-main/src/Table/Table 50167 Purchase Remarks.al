table 50167 "Purchase Remarks"//T12370-N
{
    Caption = 'Remarks';

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Receipt,Posted Invoice,Posted Credit Memo,Posted Return Shipment';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Receipt,"Posted Invoice","Posted Credit Memo","Posted Return Shipment";
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
        }
        field(5; "Code"; Code[10])
        {
            Caption = 'Code';
        }
        field(6; Remark; Text[500])
        {
            Caption = 'Remark';
        }
        field(7; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
        }
    }

    keys
    {
        key(Key1; "Document Type", "No.", "Document Line No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    procedure CopyRemarks(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20])
    var
        PurchaseRemarkLine: Record "Purchase Remarks";
        PurchaseRemarkLine2: Record "Purchase Remarks";
        IsHandled: Boolean;
    begin

        PurchaseRemarkLine.SetRange("Document Type", FromDocumentType);
        PurchaseRemarkLine.SetRange("No.", FromNumber);
        if PurchaseRemarkLine.FindSet then
            repeat
                PurchaseRemarkLine2 := PurchaseRemarkLine;
                PurchaseRemarkLine2."Document Type" := ToDocumentType;
                PurchaseRemarkLine2."No." := ToNumber;
                PurchaseRemarkLine2.Insert;
            until PurchaseRemarkLine.Next = 0;
    end;

    procedure CopyRemarksArchieve(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20])
    var
        PurchaseRemarkLine: Record "Purchase Remarks";
        PurchaseRemarkLine2: Record "Purchase Remark Archieve";
        IsHandled: Boolean;
    begin

        PurchaseRemarkLine.SetRange("Document Type", FromDocumentType);
        PurchaseRemarkLine.SetRange("No.", FromNumber);
        if PurchaseRemarkLine.FindSet then
            repeat
                PurchaseRemarkLine2.Init();
                PurchaseRemarkLine2.TransferFields(PurchaseRemarkLine);
                PurchaseRemarkLine2."Document Type" := ToDocumentType;
                PurchaseRemarkLine2."No." := ToNumber;
                PurchaseRemarkLine2.Insert;
            until PurchaseRemarkLine.Next = 0;
    end;

    procedure DeleteRemarks(DocType: Option; DocNo: Code[20])
    begin
        SetRange("Document Type", DocType);
        SetRange("No.", DocNo);
        if not IsEmpty then
            DeleteAll;
    end;

    procedure ShowRemarks(DocType: Option; DocNo: Code[20]; DocLineNo: Integer)
    var
        PurchaseRemarkSheet: Page "Purchase Remark Sheet";
    begin
        SetRange("Document Type", DocType);
        SetRange("No.", DocNo);
        SetRange("Document Line No.", DocLineNo);
        Clear(PurchaseRemarkSheet);
        PurchaseRemarkSheet.SetTableView(Rec);
        PurchaseRemarkSheet.RunModal;
    end;

}