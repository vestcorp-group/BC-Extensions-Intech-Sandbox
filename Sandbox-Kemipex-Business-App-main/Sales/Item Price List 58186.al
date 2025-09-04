page 58186 "item Price List"//T12370-Full Comment
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
#pragma warning disable AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
    SourceTable = "Price List Line";//31-12-2024-Sales Price
    Permissions = TableData "Price List Line" = r;//31-12-2024-Sales Price
#pragma warning restore AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
    Caption = 'Item Price List';

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
                    ApplicationArea = All;
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
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Import Items")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    ItemRec: Record Item;
#pragma warning disable AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
                    SalesPriceRec: Record "Sales Price";
#pragma warning restore AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
                begin
                    ItemRec.SetRange("Inventory Posting Group", 'PD');
                    ItemRec.SetRange("Sales Blocked", false);
                    ItemRec.SetRange(Blocked, false);
                    if ItemRec.FindSet() then;
                    repeat
                        SalesPriceRec.SetRange("Item No.", ItemRec."No.");
                        if SalesPriceRec.FindSet() then
                            exit else begin
                            SalesPriceRec.Init();
                            SalesPriceRec.Validate("Item No.", ItemRec."No.");
                            if SalesPriceRec.Insert() then;
                        end;
                    until ItemRec.Next() = 0;
                    Message('Item import complete');
                end;
            }
            action("Assign USD as Currency")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
#pragma warning disable AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
                    SalesPriceRec: Record "Price List Line";//31-12-2024-Sales Price
#pragma warning restore AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
                begin
                    if SalesPriceRec.FindSet() then
                        repeat
#pragma warning disable AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
                            if SalesPriceRec."Currency 2" = '' then SalesPriceRec."Currency 2" := 'USD';
#pragma warning restore AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
                            if SalesPriceRec.Modify() then;
                        until SalesPriceRec.Next() = 0;
                    Message('USD Currency assiged');
                end;
            }

            action("Release to Company")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                var
                begin
                    rec.TransferPrice(xRec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        item: Record Item;
    begin
        //Clear(ItemShortName);
        //Item.GET(Rec."Item No.");
        //ItemShortName := item."Search Description";
    end;

    trigger OnDeleteRecord(): Boolean
    var
    begin
        Error('Not allowed to delete item price');
    end;

    var

    // ItemShortName: Text;
}