pageextension 58014 Itemcard extends "Item Card"//T12370-Full Comment 
{
    layout
    {
        // addfirst(factboxes)
        // {
        //     part("Consolidated Inventory"; "Item Company Wise Inventory")
        //     {
        //         ApplicationArea = all;
        //         SubPageLink = "Item No." = field("No.");
        //     }
        // }
        // addfirst(factboxes)
        // {
        //     part(KFZEConsolidatedInventory; "Item Comp Wise Inventory temp")
        //     {
        //         ApplicationArea = all;
        //         Caption = 'Consolidated Inventory';
        //     }
        // }
        /*
       modify(Description)
       {
           Caption = 'Item Commercial Name';
       }
       modify(GTIN)
       {
           Visible = false;
       }
       modify("Automatic Ext. Texts")
       {
           Visible = false;
       }
       modify("Shelf No.")
       {
           Visible = false;
       }
       modify("Created From Nonstock Item")
       {
           Visible = false;
       }
       modify("Search Description")
       {
           Caption = 'Item Short Name';
           Importance = Promoted;
       }
       modify("Net Weight")
       {
           Visible = false;
       }
       modify("Gross Weight")
       {
           Visible = false;
       }
       modify("Unit Volume")
       {
           Visible = false;
       }
       modify("Price Includes VAT")
       {
           Visible = false;
       }

       modify("Item Disc. Group")
       {
           Visible = false;
       }
       modify("Warehouse Class Code")
       {
           Visible = false;
       }
       modify("Serial Nos.")
       {
           Visible = false;
       }
       modify("Special Equipment Code")
       {
           Visible = false;
       }
       modify("Put-away Template Code")
       {
           Visible = false;
       }
       modify("Put-away Unit of Measure Code")
       {
           Visible = false;
       }
       modify("Phys Invt Counting Period Code")
       {
           Visible = false;
       }
       modify("Last Phys. Invt. Date")
       {
           Visible = false;
       }
       modify("Last Counting Period Update")
       {
           Visible = false;
       }
       modify("Next Counting End Date")
       {
           Visible = false;
       }
       modify("Next Counting Start Date")
       {
           Visible = false;
       }
       modify("Use Cross-Docking")
       {
           Visible = false;
       }
#pragma warning disable AL0432 // TODO: - Will removed once it will be removed by base App-30-04-2022
       modify(SpecialPurchPricesAndDiscountsTxt)
#pragma warning restore AL0432 // TODO: - Will removed once it will be removed by base App-30-04-2022
       {
           Visible = false;
       }
       modify("Default Deferral Template Code")
       {
           Visible = false;
       }
       modify("Include Inventory")
       {
           Visible = false;
       }
       modify("Lot Accumulation Period")
       {
           Visible = false;
       }
       modify("Rescheduling Period")
       {
           Visible = false;
       }
       modify(PreventNegInventoryDefaultYes)
       {
           Visible = false;
       }
       modify(StockoutWarningDefaultYes)
       {
           Visible = false;
       }
       modify("Common Item No.")
       {
           Visible = false;
       }
       modify("Allow Invoice Disc.")
       {
           Visible = false;
       }
       modify("Tariff No.")
       {
           Caption = 'HS Code';
       }
       modify("Vendor Item No.")
       {
           Visible = false;
       }
       modify("Lot Nos.")
       {
           Visible = false;
       }
       modify("Item Incentive Ratio (IIR)")
       {
           Caption = 'Item Incentive Point (IIP)';
           Editable = false;
       }
       addafter("Vendor Item No.")
       {
           field(Vendor_item_description; rec.Vendor_item_description)
           {
               Visible = true;
               ApplicationArea = all;
           }
       }
       moveafter("Description"; "Search Description")
       moveafter("Search Description"; GenericName)
       addbefore(Blocked)
       {
           field("Block Reason"; rec."Block Reason")
           {
               ApplicationArea = all;
           }
           field("Description 21"; rec."Description 2")
           {
               Caption = 'Packing';
               ApplicationArea = all;
           }
       }

       addafter(Inventory)
       {
           field(TotalSalesQty; TotalSalesQty)
           {
               Caption = 'Total Sales Qty.';
               DecimalPlaces = 3;
               Editable = false;
               ApplicationArea = all;
           }
           field(TotalPurchqty; TotalPurchqty)
           {
               Caption = 'Total Purchase Qty.';
               DecimalPlaces = 3;
               Editable = false;
               ApplicationArea = all;
           }
       } */
        addafter("Purchasing Code")
        {
            field(No_of_variance; No_of_variance_)
            {
                Caption = 'No. of Variance';
                ApplicationArea = all;
                Editable = false;
                trigger OnDrillDown()
                begin

                    item_variance_t.Reset();
                    item_variance_t.SetRange("Item No.", rec."No.");
                    Page.Run(page::"Item Variants", item_variance_t);
                end;
            }
            /* field("Storage Handling Instruction"; Rec."Storage Handling Instruction")
            {
                ApplicationArea = All;
                MultiLine = true;
            }
            */
            // field("KFZEShow on Sales Budget"; Rec."KFZEShow on Sales Budget")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the value of the Show on Sales Budget field.';
            // }
        }
        /*  moveafter("Vendor No."; "Manufacturer Description")

         //06-08-2022-start
         modify("Sales Unit of Measure")
         {
             Editable = IsUOMEditable;
             Enabled = IsUOMEditable;
             ShowMandatory = true;
         }
         modify("Base Unit of Measure")
         {
             Editable = IsUOMEditable;
             Enabled = IsUOMEditable;
         }
         modify("Purch. Unit of Measure")
         {
             Editable = IsUOMEditable;
             Enabled = IsUOMEditable;
         }
         //06-08-2022-end

         addafter(ItemTracking)
         {
             group("Label Printing")
             {
                 field("Pictogram Code"; rec."Pictogram Code")
                 {
                     Caption = 'Pictograms';
                     ApplicationArea = all;

                 }
                 field("Saber Code"; rec."Saber Code")
                 {
                     ApplicationArea = all;
                 }
                 field("Precautionary Statement"; rec."Precautionary Statement")
                 {
                     ApplicationArea = all;
                     MultiLine = true;
                 }
             }
         }

         addlast(FactBoxes)
         {
             part("ItemUOM"; "Item UOM Factbox")
             {
                 ApplicationArea = all;
                 SubPageLink = "Item No." = field("No.");
             }
         } */

        /* 14-08-2022-start // hide by B

        addlast(content)
        {
            group("Label")
            {
                field("Image 1"; Rec."Image 1")
                {
                    ApplicationArea = All;
                }
                field("Image 2"; Rec."Image 2")
                {
                    ApplicationArea = All;
                }
                field("Image 3"; Rec."Image 3")
                {
                    ApplicationArea = All;
                }
                field("Image 4"; Rec."Image 4")
                {
                    ApplicationArea = All;
                }
                field("Image 5"; Rec."Image 5")
                {
                    ApplicationArea = All;
                }
                field("Image 6"; Rec."Image 6")
                {
                    ApplicationArea = All;
                }
            }
            group("Note")
            {
                usercontrol(ItemTextEditor; ItemTextEditor)
                {
                    ApplicationArea = All;
                    trigger ControlReady()
                    begin
                        CurrPage.ItemTextEditor.Init();
                        //CurrPage.Test.Load(AttentionNOte);
                    end;

                    trigger OnAfterInit()
                    begin
                        IsEditorEnabled := true;
                        CurrPage.ItemTextEditor.Load(AttentionNOte);
                        CurrPage.ItemTextEditor.SetReadOnly(NOT CurrPage.Editable);
                    end;

                    trigger SaveRequested(data: Text)
                    begin
                        //Message(data);
                        Rec.setAttentionNote(data);
                    end;

                    //14-08-2022 -start
                    trigger ContentChanged()
                    begin
                        CurrPage.ItemTextEditor.RequestSave();
                    end;
                    //14-08-2022 -end
                }

                // field("Attention Note"; AttentionNOte)
                // {
                //     ApplicationArea = All;

                //     trigger OnValidate()
                //     begin
                //         Rec.setAttentionNote(AttentionNOte);
                //     end;
                // }
            }
        }
        */ //14-08-2022-end
    }

    /* actions
    {

        addfirst(Creation)
        {
            action(Release)
            {
                Caption = 'Release to Companies';
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    rec.companytransfer2(xRec, true);
                end;
            }
            action(TPRelease)
            {
                Caption = 'TP Release to Companies';
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    rec.TPcompanytransfer(xRec, true);
                end;
            }
        }
    } */
    trigger OnAfterGetCurrRecord()
    var
        item_variance: Record "Item Variant";
    begin

        if ile.FindSet() then
            ile.SetRange("Item No.", rec."No.");
        ile.SetRange("Entry Type", ile."Entry Type"::Sale);
        ile.CalcSums(Quantity);
        TotalSalesQty := ile.Quantity * -1;

        if ile.FindSet() then
            ile.SetRange("Item No.", rec."No.");
        ile.SetRange("Entry Type", ile."Entry Type"::Purchase);
        ile.CalcSums(Quantity);
        TotalPurchqty := ile.Quantity;

        if item_variance.findset() then
            item_variance.SetRange("Item No.", rec."No.");
        No_of_variance_ := item_variance.Count();

        // CurrPage.KFZEConsolidatedInventory.Page.LoadConsolidatedInvtData(Rec."No.");
    end;

    //06-08-2022-start
    trigger OnOpenPage()
    begin
        // IsEditable();
    end;

    /* trigger OnAfterGetRecord() // hide by B
    begin
        IsEditable();
        AttentionNOte := Rec.GetAttentionNote();

        if IsEditorEnabled then begin
            IsEditorEnabled := false;
            CurrPage.ItemTextEditor.Init();
        end;
    end; */

    local procedure IsEditable()
    var
        Utility: Codeunit Events;
        RecUserSetup: Record "User Setup";
        comment: Text;
    begin
        IsUOMEditable := true;
        if Utility.IsItemApproved(Rec."No.") then begin
            if Utility.IsTransactionAvailableForItem(Rec."No.", comment) then
                IsUOMEditable := false;
            Clear(RecUserSetup);
            if RecUserSetup.GET(UserId) then begin
                if RecUserSetup."Allow To Edit Items" then begin
                    IsUOMEditable := true;
                    CurrPage.Editable := true;
                end
                else begin
                    CurrPage.Editable := false;
                    IsUOMEditable := false;
                end;

            end else begin
                CurrPage.Editable := false;
                IsUOMEditable := false;
            end;

        end
        else
            CurrPage.Editable := true;
    end;
    //06-08-2022-end

    //08-09-2022-start
    /* trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction in [CloseAction::OK, CloseAction::LookupOK] then begin
            if Rec."Product Family" = '' then
                Error('%1 must have a value in Item: No.=%2. It cannot be empty.', Rec.FieldCaption("Product Family"), Rec."No.");
        end;
    end; */

    //08-09-2022-end

    /*  trigger OnDeleteRecord(): Boolean
     begin
         Error('Not allowed to delete the record!');
     end; */


    var
        TotalSalesQty: Decimal;
        TotalPurchqty: Decimal;
        ILE: Record "Item Ledger Entry";
        No_of_variance_: Integer;
        item_variance_t: Record "Item Variant";
        IsUOMEditable: Boolean;
        AttentionNOte: Text;
        IsEditorEnabled: Boolean;
}