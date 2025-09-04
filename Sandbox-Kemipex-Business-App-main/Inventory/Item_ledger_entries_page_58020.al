pageextension 58020 ILE extends "Item Ledger Entries"//T12370-Full Comment //HyperCare
{
    layout
    {
        addafter("Document No.")
        {
            /*  field("Source No.1"; rec."Source No.")
             {
                 ApplicationArea = All;
                 Visible = true;
                 Caption = 'Source No.';
             } */
            /* field("Unit of Measure Code"; "Unit of Measure Code")
             {
                 ApplicationArea = all;
                 Visible = true;
             }
             */
        }
        /* modify("Variant Code")
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                ItemVariant: Record "Item Variant";
                ItemVariantPage: Page "Item Variants";
            begin
                ItemVariant.Reset();
                ItemVariant.FilterGroup(2);
                ItemVariant.SetRange("Item No.", Rec."Item No.");
                ItemVariant.SetRange(Blocked1, false);
                Clear(ItemVariantPage);
                ItemVariantPage.SetRecord(ItemVariant);
                ItemVariantPage.SetTableView(ItemVariant);
                ItemVariantPage.LookupMode(true);
                if ItemVariantPage.RunModal() = Action::LookupOK then begin
                    ItemVariantPage.GetRecord(ItemVariant);
                    Rec."Variant Code" := ItemVariant.Code;
                    rec.Validate("Variant Code");
                end;
                ItemVariant.FilterGroup(0);
            end;
        } */
    }
    actions
    {
        addafter("Update GRN DATE")
        {
            action("Update Manufacturing Date")
            {
                Promoted = true;
                PromotedCategory = Process;
                Image = ImportExcel;
                ApplicationArea = all;
                //RunObject = report "Import Group GRN Date";
                trigger OnAction()
                begin
                    Report.RunModal(58134, false, false);
                end;
            }

            action("Update Expiration Report")
            {
                ApplicationArea = all;
                trigger OnAction()
                var
                    UpdateExpiry: Report 58135;
                begin
                    UpdateExpiry.Run();

                end;
            }
            //T50890-NS Anoop
            action("Update Custom BOE")
            {
                Promoted = true;
                PromotedCategory = Process;
                Image = ImportExcel;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    Report.RunModal(53016, false, false);
                end;
            }
            //T50890-NE Anoop

        }
    }
}