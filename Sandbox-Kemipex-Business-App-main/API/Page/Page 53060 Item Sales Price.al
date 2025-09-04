page 53060 APIItemSalesPrice//T12370-Full Comment //T50051 Code Uncommented
{
    ApplicationArea = All;
    Caption = 'API ItemSalesPrice';
    PageType = API;
    SourceTable = "Price List Line";//31-12-2024-Sales Price
    Permissions = tabledata "Price List Line" = RMI;//31-12-2024-Sales Price
    DataCaptionFields = "Asset No.";
    UsageCategory = History;
    DeleteAllowed = false;
    ModifyAllowed = true;
    InsertAllowed = true;
    DelayedInsert = true;

    // Powerautomate Category
    EntityName = 'ItemSalesPrice';
    EntitySetName = 'ItemSalesPrices';
    EntityCaption = 'ItemSalesPrice';
    EntitySetCaption = 'ItemSalesPrices';
    // ODataKeyFields = SystemId;
    Extensible = false;

    APIPublisher = 'Kemipex';
    APIGroup = 'SalesPrice';
    APIVersion = 'v2.0';


    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item_No"; rec."Asset No.")
                {
                    ApplicationArea = all;
                }
                field("Item_Commercial_Name"; rec."Item Commercial Name")
                {
                    ApplicationArea = all;
                }
                field("Base_UOM"; rec."Base UOM")
                {
                    ApplicationArea = all;
                }
                field("Currency"; rec."Currency 2")
                {
                    ApplicationArea = all;
                    Caption = 'Currency';
                }
                field("Unit_Price"; rec."Unit Price 2")
                {
                    ApplicationArea = all;
                    Caption = 'Unit Price';
                }
                field("Minimum_Selling_Price"; rec."Minimum Selling Price")
                {
                    ApplicationArea = all;
                }
                field("Incentive_Point"; rec."Incentive Point")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}
