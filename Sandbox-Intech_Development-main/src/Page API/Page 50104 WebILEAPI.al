page 50104 API_WebILEAPI
{

    APIGroup = 'PowerBIReport';
    APIPublisher = 'ISPL';
    APIVersion = 'v2.0';
    Caption = 'apiWebILEAPI';
    DelayedInsert = true;
    EntityName = 'webILEAPI';
    EntityCaption = 'webILEAPI';
    EntitySetName = 'webILEAPI';
    EntitySetCaption = 'webILEAPI';
    PageType = API;
    SourceTable = "Item Ledger Entry";
    Editable = false;
    DataAccessIntent = ReadOnly;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(entryNo; Rec."Entry No.")
                {
                    Caption = 'Entry No.';
                }
                field(itemNo; Rec."Item No.")
                {

                    Caption = 'Item No.';
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }
                field(postingDate; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                }
                field(entryType; Rec."Entry Type")
                {
                    Caption = 'Entry Type';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(sourceType; Rec."Source Type")
                {
                    Caption = 'Source Type';
                }
                field(sourceNo; Rec."Source No.")
                {
                    Caption = 'Source No.';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(remainingQuantity; Rec."Remaining Quantity")
                {
                    Caption = 'Remaining Quantity';
                }
                field(invoicedQuantity; Rec."Invoiced Quantity")
                {
                    Caption = 'Invoiced Quantity';
                }
                field(costAmountActual; Rec."Cost Amount (Actual)")
                {
                    Caption = 'Cost Amount (Actual)';
                }
                field(purchaseAmountActual; Rec."Purchase Amount (Actual)")
                {
                    Caption = 'Purchase Amount (Actual)';
                }
                field(salesAmountActual; Rec."Sales Amount (Actual)")
                {
                    Caption = 'Sales Amount (Actual)';
                }
                field(costAmountNonInvtbl; Rec."Cost Amount (Non-Invtbl.)")
                {
                    Caption = 'Cost Amount (Non-Invtbl.)';
                }
                field(positive; Rec.Positive)
                {
                    Caption = 'Positive';
                }
                field(customLotNumber; Rec.CustomLotNumber)
                {
                    Caption = 'CustomLotNumber';
                }
                field(customBOENumber; Rec.CustomBOENumber)
                {
                    Caption = 'CustomBOENumber';
                }
                field(customBOENumber2; Rec.CustomBOENumber2)
                {
                    Caption = 'CustomBOENumber2';
                }
                field(supplierBatchNo2; Rec."Supplier Batch No. 2")
                {
                    Caption = 'Supplier Batch No. 2';
                }
                field(manufacturingDate2; Rec."Manufacturing Date 2")
                {
                    Caption = 'Manufacturing Date 2';
                }
                field(expirationDate; Rec."Expiration Date")
                {
                    Caption = 'Expiration Date';
                }
                field(iCPartner; ICPartner)
                {
                    Caption = 'ICPartner';
                }
                field(groupGRNDate; rec."Group GRN Date")
                {
                    Caption = 'Group GRN Date';
                }
            }

        }
    }

    trigger OnAfterGetRecord()
    var
        RecCustomer: Record Customer;
        RecVendor: Record Vendor;
    begin
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
