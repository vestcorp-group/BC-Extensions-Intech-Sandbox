page 58003 "Item Sales Price"//T12370-Full Comment //T50051 Code Uncommented
{
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Item Sales Price';
#pragma warning disable AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
    SourceTable = "Price List Line";
#pragma warning restore AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
    PageType = List;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Item No."; rec."Asset No.")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; rec."Variant Code")
                {
                    ApplicationArea = all;
                }
#pragma warning disable AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
                field("Item Commercial Name"; rec."Item Commercial Name")
#pragma warning restore AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
                {
                    Caption = 'Item Commercial Name';
                    ApplicationArea = All;
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
                }
#pragma warning disable AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
                field("Currency 2"; rec."Currency 2")
#pragma warning restore AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
                {
                    ApplicationArea = All;
                    Caption = 'Currency Code';
                }
#pragma warning disable AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
                field("Unit Price 2"; rec."Unit Price 2")
#pragma warning restore AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
                {
                    //Caption = 'Unit Price Base UOM';
                    Caption = 'Selling Price';//Updated caption on 26-09-2022
                    ApplicationArea = All;
                }
#pragma warning disable AL0432 // TODO: - Will removed once it will be removed from base app 26-09-2022
                field("Minimum Selling Price"; Rec."Minimum Selling Price")
                {
                    ApplicationArea = All;
                    Visible = Visible_gBol;//T13852-N
                }
                field("Incentive Point"; Rec."Incentive Point")
                {
                    ApplicationArea = All;
                    Visible = Visible_gBol;//T13852-N
                }
#pragma warning restore AL0432 // TODO: - Will removed once it will be removed from base app 26-09-2022
            }
        }
        //T50051 Code commented
        // area(factboxes)
        // {
        //     part(ConsolInv; "Item Company Wise Inventory")
        //     {
        //         ApplicationArea = all;
        //         SubPageLink = "Item No." = field("Item No.");
        //         Visible = false;
        //     }
        //     part(KFZEConsolidatedInventory; "Item Comp Wise Inventory temp")
        //     {
        //         ApplicationArea = all;
        //         Caption = 'Consolidated Inventory';
        //     }
        // }
        //T50051 Code commented

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
                    SalesPriceRec: Record "Price List Line";//31-12-2024
#pragma warning restore AL0432 // TODO: - Will removed once it will be removed from base app 30-04-2022
                begin
                    ItemRec.SetRange("Inventory Posting Group", 'PD');
                    ItemRec.SetRange("Sales Blocked", false);
                    ItemRec.SetRange(Blocked, false);
                    if ItemRec.FindSet() then;
                    repeat
                        SalesPriceRec.SetRange("Asset No.", ItemRec."No.");
                        if SalesPriceRec.FindSet() then
                            exit else begin
                            SalesPriceRec.Init();
                            SalesPriceRec.Validate("Asset No.", ItemRec."No.");
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
                    SalesPriceRec: Record "Price List Line";
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
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Visible_lFnc();//T13852-N
    end;

    trigger OnAfterGetRecord()
    var
        item: Record Item;
    begin
        //Clear(ItemShortName);
        //Item.GET(Rec."Item No.");
        //ItemShortName := item."Search Description";
        Visible_lFnc(); //T13852-N
    end;

    trigger OnAfterGetCurrRecord()
    begin
        // CurrPage.KFZEConsolidatedInventory.Page.LoadConsolidatedInvtData(Rec."Item No.");
    end;

    //T13852-NS
    local procedure Visible_lFnc()
    begin
        clear(Usersetup_gRec);
        if Usersetup_gRec.get(UserId) then begin
            if not Usersetup_gRec."Allow to view Sales Price" then
                Visible_gBol := false
            else
                Visible_gBol := true;
        end;
    end;
    var

    // ItemShortName: Text;
        Visible_gBol: Boolean;
        Usersetup_gRec: Record "User Setup";
    //T13852-NE
}