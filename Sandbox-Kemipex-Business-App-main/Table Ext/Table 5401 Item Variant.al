tableextension 58232 itemvariant extends "Item Variant"//T12370-N,T12855
{
    //DataCaptionFields = "Item No.", "Code", Description, HSNCode, CountryOfOrigin;
    fields
    {
        field(58232; HSNCode; Code[20])
        {
            Caption = 'Item HSN Code';
            DataClassification = ToBeClassified;
            TableRelation = "Tariff Number";
            Editable = true;
        }
        field(58233; CountryOfOrigin; Code[20])
        {
            Caption = 'Item Country of Origin';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
            Editable = true;
        }
        field(58234; "Packing Description"; Text[150])
        {
            Caption = 'Packing Description';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(58266; Remarks; Text[2000])
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(58235; Blocked1; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(58265; "Variant Details"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Item Variant Details"."Variant Code" where("Item No." = field("Item No."));
            Editable = true;

            trigger OnValidate()
            var

            begin
                if ("Variant Details" <> '') AND ("Variant Details" <> Code) then
                    Error('Incorrect variant details!');
            end;
        }
        field(58267; "Packing Code"; Code[10])
        {
            Caption = 'Primary Packing Code';
            Description = 'T13802';
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
        }
        modify("Description 2")
        {
            Caption = 'Variant Short Name';
        }
    }

    fieldgroups
    {
        addlast(DropDown; "Description 2", HSNCode, CountryOfOrigin, Remarks, "Packing Description")
        {

        }

    }

    /* T12370_Dependency-COA procedure TPVarcompanytransfer(item_from: Record "Item Variant"; showMessage: Boolean)
    var
        masterconfig: Record "Release to Company Setup";
        item_to: Record "Item Variant";
        Text001: Label 'Item %1 %2 Testing Parameter transfer to %3 Company';
        Text002: Label 'Item %1 %2 Testing Parameter modified in %3 Company';
        ItemTestingParameterFrom: Record "Item Variant Testing Parameter";
        ItemTestingParameterTo: Record "Item Variant Testing Parameter";

    begin

        masterconfig.reset();
        masterconfig.SetRange(masterconfig."Transfer Item", true);
        masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
        if masterconfig.FindSet() then
            repeat

                Clear(ItemTestingParameterTo);
                ItemTestingParameterTo.ChangeCompany(masterconfig."Company Name");
                ItemTestingParameterTo.Reset();
                ItemTestingParameterTo.SetRange("Item No.", item_from."Item No.");
                ItemTestingParameterTo.SetRange("Variant Code", item_from.Code);
                if ItemTestingParameterTo.FindSet() then
                    ItemTestingParameterTo.DeleteAll();

                //--
                Clear(item_to);
                item_to.ChangeCompany(masterconfig."Company Name");
                item_to.Reset();
                if not item_to.Get(item_from."Item No.", item_from.Code) then begin
                    // item_to.Init();
                    // item_to := item_from;
                    // if item_to.Insert() then begin

                    ItemTestingParameterFrom.Reset();
                    ItemTestingParameterFrom.SetRange("Item No.", item_from."Item No.");
                    ItemTestingParameterFrom.SetRange("Variant Code", item_from.Code);
                    if ItemTestingParameterFrom.FindSet() then
                        repeat
                            Clear(ItemTestingParameterTo);
                            ItemTestingParameterTo.ChangeCompany(masterconfig."Company Name");
                            ItemTestingParameterTo.Reset();
                            if not ItemTestingParameterTo.Get(ItemTestingParameterFrom."Item No.", ItemTestingParameterFrom.Code) then begin
                                ItemTestingParameterTo.Init();
                                ItemTestingParameterTo := ItemTestingParameterFrom;
                                // if ItemTestingParameterTo.Modify() then;
                                if ItemTestingParameterTo.Insert() then;
                            end else
                                If ItemTestingParameterTo.Modify() then;
                        until ItemTestingParameterFrom.Next() = 0;
                    //  end;
                    if showMessage then
                        Message(Text001, item_from."Item No.", item_from.code, masterconfig."Company Name");
                end
                else begin
                    //  Blocked := item_to.Blocked;
                    // item_to.TransferFields(item_from, false);
                    // if item_to.Modify() then begin
                    ItemTestingParameterFrom.Reset();
                    ItemTestingParameterFrom.SetRange("Item No.", item_from."Item No.");
                    ItemTestingParameterFrom.SetRange("Variant Code", item_from.Code);
                    if ItemTestingParameterFrom.FindSet() then begin
                        repeat
                            Clear(ItemTestingParameterTo);
                            ItemTestingParameterTo.ChangeCompany(masterconfig."Company Name");
                            ItemTestingParameterTo.Reset();
                            if not ItemTestingParameterTo.get(ItemTestingParameterFrom."Item No.", ItemTestingParameterFrom."Variant Code", ItemTestingParameterFrom.Code) then begin
                                ItemTestingParameterTo.Init();
                                ItemTestingParameterTo := ItemTestingParameterFrom;
                                if ItemTestingParameterTo.Insert() then;
                            end
                            else begin
                                ItemTestingParameterTo.TransferFields(ItemTestingParameterFrom, false);
                                if ItemTestingParameterTo.Modify() then;
                            end;
                        until ItemTestingParameterFrom.Next() = 0;
                    end;

                    //  end;
                    if showMessage then
                        Message(Text002, item_to."Item No.", item_to.Code, masterconfig."Company Name");
                end;
            until masterconfig.Next() = 0;
    end; */
}