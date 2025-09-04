page 85651 apiSalesShipmentLine
{
    PageType = API;
    Caption = 'apiSalesShipmentLine';
    APIPublisher = 'ISPL';
    APIGroup = 'API';
    ApplicationArea = all;
    APIVersion = 'v2.0';
    EntityName = 'apiSalesShipmentLineIC';
    EntitySetName = 'apiSalesShipmentLineIC';
    SourceTable = "Sales Shipment Line";
    Description = 'T13919';
    DelayedInsert = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field(orderNo; Rec."Order No.")
                {
                    Caption = 'Order No.';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(documentNo; Rec."Document No.")
                {
                    Caption = 'Document No.';
                }
                field(locationCode; Rec."Location Code")
                {
                    Caption = 'Location Code';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }

            }
        }
    }
}