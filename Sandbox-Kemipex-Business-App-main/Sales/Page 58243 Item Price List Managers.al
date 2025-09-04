page 58243 "Item Price List - Managers"//T12370-Full Comment
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
#pragma warning disable AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
    SourceTable = "Price List Line";//31-12-2024-Sales Price
#pragma warning restore AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
    Caption = 'Item Price List - Team Managers';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Item No."; rec."Asset No.")//31-12-2024-Sales Price
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
#pragma warning disable AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
                field("Item Commercial Name"; rec."Item Commercial Name")
#pragma warning restore AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
                {
                    Caption = 'Item Commercial Name';
                    ApplicationArea = All;
                    Editable = false;
                }
                //  field("Item Short Name"; ItemShortName)
                //  {
                //      ApplicationArea = all;
                //     Caption = 'Item Short Name';

                // }
#pragma warning disable AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
                field("Base UOM"; rec."Base UOM")
#pragma warning restore AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
                {
                    ApplicationArea = All;
                    Caption = 'Base UOM';
                    Editable = false;
                }
#pragma warning disable AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
                field("Currency 2"; rec."Currency 2")
#pragma warning restore AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
                {
                    ApplicationArea = All;
                    Caption = 'Currency Code';
                    Editable = false;
                }
#pragma warning disable AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
                field("Unit Price 2"; rec."Unit Price 2")
#pragma warning restore AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
                {
                    //Caption = 'Unit Price Base UOM';
                    Caption = 'Selling Price';//Updated caption on 26-09-2022
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Minimum Selling Price"; rec."Minimum Selling Price")
                {
                    Caption = 'Minimum Selling Price';
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    trigger OnDeleteRecord(): Boolean
    var
    begin
        Error('Not allowed to delete item price');
    end;
}