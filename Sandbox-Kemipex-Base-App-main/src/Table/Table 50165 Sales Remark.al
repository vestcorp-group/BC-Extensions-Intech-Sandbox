table 50165 "Sales Remark"//T12370-N
{
    Caption = 'Sales Remark Line';

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,Shipment,Posted Invoice,Posted Credit Memo,Posted Return Receipt,User task';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order",Shipment,"Posted Invoice","Posted Credit Memo","Posted Return Receipt","User Task";
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
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
        SalesRemarkLine: Record "Sales Remark";
        SalesRemarkLine2: Record "Sales Remark";
        IsHandled: Boolean;
    begin
        SalesRemarkLine.SetRange("Document Type", FromDocumentType);
        SalesRemarkLine.SetRange("No.", FromNumber);
        if SalesRemarkLine.FindSet then
            repeat
                SalesRemarkLine2 := SalesRemarkLine;
                SalesRemarkLine2."Document Type" := ToDocumentType;
                SalesRemarkLine2."No." := ToNumber;
                SalesRemarkLine2.Insert;
            until SalesRemarkLine.Next = 0;
    end;

    procedure CopyRemarksArchieve(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20])
    var
        SalesRemarkLine: Record "Sales Remark";
        SalesRemarkLine2: Record "Sales Remark Archieve";
        IsHandled: Boolean;
    begin
        SalesRemarkLine.SetRange("Document Type", FromDocumentType);
        SalesRemarkLine.SetRange("No.", FromNumber);
        if SalesRemarkLine.FindSet then
            repeat
                SalesRemarkLine2.Init();
                SalesRemarkLine2.TransferFields(SalesRemarkLine);
                SalesRemarkLine2."Document Type" := ToDocumentType;
                SalesRemarkLine2."No." := ToNumber;
                SalesRemarkLine2.Insert;
            until SalesRemarkLine.Next = 0;
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
        SalesRemarkSheet: Page "Sales Remark Sheet";
    begin
        SetRange("Document Type", DocType);
        SetRange("No.", DocNo);
        SetRange("Document Line No.", DocLineNo);
        Clear(SalesRemarkSheet);
        SalesRemarkSheet.SetTableView(Rec);
        SalesRemarkSheet.RunModal;
    end;

}