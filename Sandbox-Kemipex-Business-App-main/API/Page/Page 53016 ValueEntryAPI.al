page 53016 ValueEntryAPI//T12370-Full Comment //T50051 Code Uncommented
{
    ApplicationArea = All;
    Caption = 'BI Value Entry API';
    PageType = List;
    SourceTable = "Value Entry";
    Permissions = tabledata "Value Entry" = R;
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
                    ToolTip = 'Specifies the number of the item that this value entry is linked to.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the posting date of this entry.';
                }
                field("Item Ledger Entry Type"; Rec."Item Ledger Entry Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of item ledger entry that caused this value entry.';
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the source document that the entry originates from.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the document number of the entry.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the entry.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for the location of the item that the entry is linked to.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the value of the Variant Code field.', Comment = '%';
                    ApplicationArea = All;
                    Description = 'T50387';
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inventory Posting Group field.';
                }
                field("Item Ledger Entry No."; Rec."Item Ledger Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the item ledger entry that this value entry is linked to.';
                }
                field("Item Ledger Entry Quantity"; Rec."Item Ledger Entry Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the average cost calculation.';
                }
                field("Invoiced Quantity"; Rec."Invoiced Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many units of the item are invoiced by the posting that the value entry line represents.';
                }
                field("Cost per Unit"; Rec."Cost per Unit")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the cost for one base unit of the item in the entry.';
                }
                field("Sales Amount (Actual)"; Rec."Sales Amount (Actual)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the price of the item for a sales entry.';
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies which salesperson or purchaser is linked to the entry.';
                }
                field("Cost Amount (Actual)"; Rec."Cost Amount (Actual)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the cost of invoiced items.';
                }
                field("Cost Amount (Non-Invtbl.)"; Rec."Cost Amount (Non-Invtbl.)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the non-inventoriable cost, that is an item charge assigned to an outbound entry.';
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of value described in this entry.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies what type of document was posted to create the value entry.';
                }
                field("Document Line No."; Rec."Document Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the line number of the line on the posted document that corresponds to the value entry.';
                }
                field("Item Charge No."; Rec."Item Charge No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item charge number of the value entry.';
                }
                field(ICPartner; ICPartner)
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
