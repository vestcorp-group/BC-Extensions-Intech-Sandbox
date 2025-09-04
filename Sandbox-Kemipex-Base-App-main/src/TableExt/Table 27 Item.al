tableextension 50177 KMP_TblExtItem extends Item//T12370-N
{
    fields
    {
        /* //T12370_MIG  modify(Blocked)
        {
            trigger OnAfterValidate()
            var
                ItemCompanyBlockRec: Record "Item Company Block";
            begin
                ItemCompanyBlockRec.SetRange("Item No.", Rec."No.");
                ItemCompanyBlockRec.SetRange(Company, Rec.CurrentCompany);
                if ItemCompanyBlockRec.FindFirst() then ItemCompanyBlockRec.Blocked := Rec.Blocked;
                if ItemCompanyBlockRec.Modify() then;
            end;
        }
        modify("Sales Blocked")
        {
            trigger OnAfterValidate()
            var
                ItemCompanyBlockRec: Record "Item Company Block";
            begin
                ItemCompanyBlockRec.SetRange("Item No.", Rec."No.");
                ItemCompanyBlockRec.SetRange(Company, Rec.CurrentCompany);
                if ItemCompanyBlockRec.FindFirst() then ItemCompanyBlockRec."Sales Blocked" := Rec."Sales Blocked";
                if ItemCompanyBlockRec.Modify() then;

            end;
        }
        modify("Purchasing Blocked")
        {
            trigger OnAfterValidate()
            var
                ItemCompanyBlockRec: Record "Item Company Block";
            begin
                ItemCompanyBlockRec.SetRange("Item No.", Rec."No.");
                ItemCompanyBlockRec.SetRange(Company, Rec.CurrentCompany);
                if ItemCompanyBlockRec.FindFirst() then ItemCompanyBlockRec."Purchase Blocked" := Rec."Purchasing Blocked";
                if ItemCompanyBlockRec.Modify() then;
            end;
        }
        modify("Inventory Posting Group")
        {
            trigger OnAfterValidate()
            var
                company: Record Company;
                Item: Record item;
                ILE: Record "Item Ledger Entry";
                TotalInv: Decimal;
                InventorySetupRec: Record "Inventory Setup";
                ConfirmChange: Boolean;
                SecondConfirm: Boolean;
            begin
                if InventorySetupRec.Get() then;
                if InventorySetupRec."Allow Inv. Post. Group Modify" = false then begin
                    company.SetFilter(Name, '<>%1', CurrentCompany);
                    repeat
                        ILE.Reset();
                        ILE.ChangeCompany(company.Name);
                        ILE.SetRange("Item No.", "No.");
                        ILE.SetFilter("Remaining Quantity", '<>0');
                        ILE.CalcSums("Remaining Quantity");
                        TotalInv += ILE."Remaining Quantity";
                    until company.Next() = 0;
                    if TotalInv <> 0 then Error('Inventory Posting group Cannot be changed if inventory is not 0');
                end
                else begin
                    ConfirmChange := Dialog.Confirm('Are you sure you want to change the inventory posting group?', true);
                    if ConfirmChange then
                        exit
                    else
                        Rec."Inventory Posting Group" := xRec."Inventory Posting Group"
                end;
            end;
        } */
        // Add changes to table fields here
        field(50177; MarketIndustry; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = KMP_TblMarketIndustry;
            trigger OnValidate()
            var
                TblMarketIndustL: Record KMP_TblMarketIndustry;
            begin
                TblMarketIndustL.Get(MarketIndustry);
                "Market Industry Desc." := TblMarketIndustL.Description;
            end;
        }
        field(50178; GenericName; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = KMP_TblGenericName;
            trigger OnValidate()
            var
                TblGenericNameL: Record KMP_TblGenericName;
            begin
                TblGenericNameL.Get(GenericName);
                "Generic Description" := TblGenericNameL.Description;
            end;
        }
        // field(50179; CountryOfOrigin; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = KMP_TblCountryOfOrigin;
        // }
        field(50179; ManufacturerName; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Manufacturer;
            trigger OnValidate()
            var
                TblMfrNameL: Record Manufacturer;
            begin
                TblMfrNameL.Get(ManufacturerName);
                "Manufacturer Description" := TblMfrNameL.Name;
            end;
        }
        field(50180; "Generic Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Generic Name';
            TableRelation = KMP_TblGenericName.Description;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                GenericNameL: Record KMP_TblGenericName;
                DescriptionIsNo: Boolean;
                Confirmed: Boolean;
            begin
                if StrLen("Generic Description") <= MaxStrLen(GenericNameL.Code) then
                    DescriptionIsNo := GenericNameL.Get("Generic Description")
                else
                    DescriptionIsNo := false;
                if not DescriptionIsNo then begin
                    GenericNameL.SetRange(Description, "Generic Description");
                    if GenericNameL.FindFirst() then
                        Confirmed := true
                    else begin
                        GenericNameL.SETFILTER(Description, '''@' + CONVERTSTR("Generic Description", '''', '?') + '''');
                        if GenericNameL.FindFirst() then
                            Confirmed := true;
                    end;
                    if DescriptionIsNo or Confirmed then begin
                        GenericName := GenericNameL.Code;
                        "Generic Description" := GenericNameL.Description;
                    end else
                        FieldError("Generic Description", StrSubstNo(DescriptionNotExistErr, "Generic Description", GenericNameL.TableCaption));

                end;
            end;
        }
        field(50181; "Manufacturer Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Manufacturer Name';
            TableRelation = Manufacturer.Name;
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                TblManufacturerNameL: Record Manufacturer;
                DescriptionIsNo: Boolean;
                Confirmed: Boolean;
            begin
                if StrLen("Manufacturer Description") <= MaxStrLen(TblManufacturerNameL.Code) then
                    DescriptionIsNo := TblManufacturerNameL.Get("Manufacturer Description")
                else
                    DescriptionIsNo := false;
                if not DescriptionIsNo then begin
                    TblManufacturerNameL.SetRange(Name, "Manufacturer Description");
                    if TblManufacturerNameL.FindFirst() then
                        Confirmed := true
                    else begin
                        TblManufacturerNameL.SETFILTER(Name, '''@' + CONVERTSTR("Manufacturer Description", '''', '?') + '''');
                        if TblManufacturerNameL.FindFirst() then
                            Confirmed := true;
                    end;
                    if DescriptionIsNo or Confirmed then begin
                        ManufacturerName := TblManufacturerNameL.Code;
                        "Manufacturer Description" := TblManufacturerNameL.Name;
                    end else
                        FieldError("Manufacturer Description", StrSubstNo(DescriptionNotExistErr, "Manufacturer Description", TblManufacturerNameL.TableCaption));

                end;
            end;
        }
        field(50182; "Market Industry Desc."; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Market Industry';
            TableRelation = KMP_TblMarketIndustry.Description;
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                TblMarketIndustryL: Record KMP_TblMarketIndustry;
                DescriptionIsNo: Boolean;
                Confirmed: Boolean;
            begin
                if StrLen("Market Industry Desc.") <= MaxStrLen(TblMarketIndustryL.Code) then
                    DescriptionIsNo := TblMarketIndustryL.Get("Market Industry Desc.")
                else
                    DescriptionIsNo := false;
                if not DescriptionIsNo then begin
                    TblMarketIndustryL.SetRange(Description, "Market Industry Desc.");
                    if TblMarketIndustryL.FindFirst() then
                        Confirmed := true
                    else begin
                        TblMarketIndustryL.SETFILTER(Description, '''@' + CONVERTSTR("Market Industry Desc.", '''', '?') + '''');
                        if TblMarketIndustryL.FindFirst() then
                            Confirmed := true;
                    end;
                    if DescriptionIsNo or Confirmed then begin
                        MarketIndustry := TblMarketIndustryL.Code;
                        "Market Industry Desc." := TblMarketIndustryL.Description;
                    end else
                        FieldError("Market Industry Desc.", StrSubstNo(DescriptionNotExistErr, "Market Industry Desc.", TblMarketIndustryL.TableCaption));

                end;
            end;
        }
        field(50183; "Item Category Desc."; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Category';
            TableRelation = "Item Category".Description;
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                ItemCategoryL: Record "Item Category";
                DescriptionIsNo: Boolean;
                Confirmed: Boolean;
            begin
                if StrLen("Item Category Desc.") <= MaxStrLen(ItemCategoryL.Code) then
                    DescriptionIsNo := ItemCategoryL.Get("Item Category Desc.")
                else
                    DescriptionIsNo := false;
                if not DescriptionIsNo then begin
                    ItemCategoryL.SetRange(Description, "Item Category Desc.");
                    if ItemCategoryL.FindFirst() then
                        Confirmed := true
                    else begin
                        ItemCategoryL.SETFILTER(Description, '''@' + CONVERTSTR("Item Category Desc.", '''', '?') + '''');
                        if ItemCategoryL.FindFirst() then
                            Confirmed := true;
                    end;
                    if DescriptionIsNo or Confirmed then begin
                        "Item Category Code" := ItemCategoryL.Code;
                        "Item Category Desc." := ItemCategoryL.Description;
                    end else
                        FieldError("Item Category Desc.", StrSubstNo(DescriptionNotExistErr, "Item Category Desc.", ItemCategoryL.TableCaption));
                end;
            end;
        }
        field(50184; "Allow Loose Qty."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Loose Qty.';
        }
        field(50100; "Vendor Country of Origin"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Country of origin';
            TableRelation = "Country/Region";
        }
        field(50101; "IMCO Class"; Code[20])
        {
            TableRelation = "IMCO Class Master";
            Caption = 'UN Number';
        }
        // field(50101; "Customer Block"; Code[20])
        // {
        //     TableRelation = "Item Customer Block";
        // }
        /*//T12370_MIG  modify("Item Category Code")
         {
             trigger OnAfterValidate()
             var
                 ItemCatL: Record "Item Category";
             begin
                 ItemCatL.Get("Item Category Code");
                 "Item Category Desc." := ItemCatL.Description;
             end;
         } */

        field(50185; "Temporary Vendor Name"; Text[200])
        {
            DataClassification = ToBeClassified; // B Development
        }
        field(50186; "Item Incentive Ratio (IIR)"; Option)
        {
            OptionMembers = "","1","2","3","4","5";
            InitValue = 5;
        }
        field(50187; "Product Family"; Code[20])
        {
            TableRelation = "Product Family";
        }
        field(50188; "Product Family Name"; Text[200])
        {
            Caption = 'Product Family Name';
            FieldClass = FlowField;
            CalcFormula = lookup("Product Family"."Product Family Name" where(Code = field("Product Family")));
        }
        field(50189; "COA Distribution"; Option)
        {
            OptionMembers = "","Kemipex COA","Supplier COA","Both";
            InitValue = "Kemipex COA";
        }
        field(50190; "CAS No."; Text[500])
        {
            DataClassification = ToBeClassified;
            Caption = 'CAS No.';
        }
        field(50191; "IUPAC Name"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'IUPAC Name';
        }
    }

    fieldgroups
    {
        addlast(DropDown; "Search Description")
        { }
    }


    var
        DescriptionNotExistErr: Label ': The value %1 doesn''t exist in table %2';


}