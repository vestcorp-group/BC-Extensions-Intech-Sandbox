page 85658 apiItemLedgerEntriesICBatch
{
    APIGroup = 'API';
    APIPublisher = 'ISPL';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'apiItemLedgerEntriesICBatch';
    EntityName = 'apiItemLedgerEntriesICBatch';
    EntitySetName = 'apiItemLedgerEntriesICBatch';
    PageType = API;
    SourceTable = "Item Ledger Entry";
    Description = 'T14049';
    DelayedInsert = true;


    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(documentType; Rec."Document Type")
                {
                    Caption = 'Document Type';
                }
                field(documentLineNo; Rec."Document Line No.")
                {
                    Caption = 'Document Line No.';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(customLotNumber; Rec.CustomLotNumber)
                {
                    Caption = 'Lot No.';
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
                field(expiryPeriod2; Rec."Expiry Period 2")
                {
                    Caption = 'Expiry Period 2';
                }
                field(variantCode; Rec."Variant Code")
                {
                    Caption = 'Variant Code';
                }
                field(itemNo; Rec."Item No.")
                {
                    Caption = 'Item No.';
                }
                field(customBOENumber; Rec.CustomBOENumber)
                {
                    Caption = 'Custom BOE No.';
                }
                field(postedQCNo; Rec."Posted QC No.")
                {
                    Caption = 'Posted QC No.';
                }
                field(groupGRNDate; Rec."Group GRN Date")//Hypercare 06-03-2025
                {
                    Caption = 'Group GRN Date';
                }

            }
        }
    }
}
