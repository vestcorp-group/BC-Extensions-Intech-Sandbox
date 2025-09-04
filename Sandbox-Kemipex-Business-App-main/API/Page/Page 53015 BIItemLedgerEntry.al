page 53015 BIItemLedgerEntry//T12370-Full Comment //T50051 Code Uncommented
{
    ApplicationArea = All;
    Caption = 'BI Item Ledger Entry';
    PageType = List;
    SourceTable = "Item Ledger Entry";
    Permissions = tabledata "Item Ledger Entry" = R;
    DataCaptionFields = "Entry No.";
    UsageCategory = History;
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the item in the entry.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry''s posting date.';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies which type of transaction that the entry is created from.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies what type of document was posted to create the item ledger entry.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document number on the entry. The document is the voucher that the entry was based on, for example, a receipt.';
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source type that applies to the source number, shown in the Source No. field.';
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies where the entry originated.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the entry.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for the location that the entry is linked to.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of units of the item in the item entry.';
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity in the Quantity field that remains to be processed.';
                }
                field("Invoiced Quantity"; Rec."Invoiced Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many units of the item on the line have been invoiced.';
                }
                field("Cost Amount (Actual)"; Rec."Cost Amount (Actual)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the adjusted cost, in LCY, of the quantity posting.';
                }
                field("Purchase Amount (Actual)"; Rec."Purchase Amount (Actual)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Purchase Amount (Actual) field.';
                }
                field("Sales Amount (Actual)"; Rec."Sales Amount (Actual)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the sales amount, in LCY.';
                }
                field("Cost Amount (Non-Invtbl.)"; Rec."Cost Amount (Non-Invtbl.)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the adjusted non-inventoriable cost, that is an item charge assigned to an outbound entry.';
                }
                field(Positive; Rec.Positive)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the item in the item ledge entry is positive.';
                }
                field(CustomLotNumber; Rec.CustomLotNumber)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Lot No. field.';
                }
                field(CustomBOENumber; Rec.CustomBOENumber)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Custom BOE No. field.';
                }
                field(CustomBOENumber2; Rec.CustomBOENumber2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Custom BOE No. 2 field.';
                }
                field("Supplier Batch No. 2"; Rec."Supplier Batch No. 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Supplier Batch No. 2 field.';
                }
                field("Manufacturing Date 2"; Rec."Manufacturing Date 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Manufacturing Date 2 field.';
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last date that the item on the line can be used.';
                }
                field(ICPartner; ICPartner)
                {
                    ApplicationArea = All;
                }
                field("Group GRN Date"; rec."Group GRN Date")
                {
                    ApplicationArea = All;
                }
            }

        }
    }

    trigger OnAfterGetRecord()
    var
        RecCustomer: Record Customer;
        RecVendor: Record Vendor;
    begin
        // Note := Rec.GetAttentionNote();
        ICPartner := false;
        if Rec."Source No." <> '' then begin
            if Rec."Source Type" = Rec."Source Type"::Customer then begin
                Clear(RecCustomer);
                RecCustomer.GET(Rec."Source No.");
                if (RecCustomer."IC Company Code" <> '') OR (RecCustomer."IC Partner Code" <> '') then
                    ICPartner := true;
            end else
                if Rec."Source Type" = Rec."Source Type"::Vendor then begin
                    Clear(RecVendor);
                    RecVendor.GET(Rec."Source No.");
                    if (RecVendor."IC Company Code" <> '') OR (RecVendor."IC Partner Code" <> '') then
                        ICPartner := true;
                end;

        end;
    end;

    var
        ICPartner: Boolean;

}
