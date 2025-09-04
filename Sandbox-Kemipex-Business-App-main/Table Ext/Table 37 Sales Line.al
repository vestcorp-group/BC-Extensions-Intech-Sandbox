tableextension 58177 SalesLine extends "Sales Line"//T12370-Full Comment //T12574-N
{
    fields
    {
        // field(53001; "Container Size"; Text[200])
        // {
        //     Caption = 'Container Size';
        //     DataClassification = ToBeClassified;
        // }
        // field(53002; "Shipping Remarks"; Text[150])
        // {
        //     Caption = 'Shipping Remarks';
        //     DataClassification = ToBeClassified;
        // }
        // field(53003; "In-Out Instruction"; Text[200])
        // {
        //     Caption = 'Material Inbound/Outbound Instruction';
        //     DataClassification = ToBeClassified;
        // }
        // field(53004; "Shipping Line"; Text[150])
        // {
        //     Caption = 'Shipping Line';
        //     DataClassification = ToBeClassified;
        // }
        // field(53005; "BL-AWB No."; Text[150])
        // {
        //     Caption = 'BL/AWB Number';
        //     DataClassification = ToBeClassified;
        // }
        // field(53006; "Vessel-Voyage No."; Text[150])
        // {
        //     Caption = 'Vessel/Voyage Number';
        //     DataClassification = ToBeClassified;
        // }
        // field(53007; "Freight Forwarder"; Text[150])
        // {
        //     Caption = 'Freight Forwarder';
        //     DataClassification = ToBeClassified;
        // }
        // field(53008; "Freight Charge"; Text[150])
        // {
        //     Caption = 'Freight Charge';
        //     DataClassification = ToBeClassified;
        // }

        modify("Unit of Measure Code")
        {
            //     /*  trigger OnAfterValidate()
            //      var
            //          ItemRec: Record Item;
            //      begin
            //              if ItemRec.Get("No.") then;
            //              if ItemRec."Allow Loose Qty." then begin
            //                  if "Allow Loose Qty." then exit else Error('"Allow Loose Qty" should be enabled in Sales to change unit of measure');
            //              end

            //              else
            //                  Error('Item %1 is not allowed to sell in loose qty', ItemRec.Description);
            //      end; */

            trigger OnBeforeValidate()
            begin
                if Rec.Type = Rec.Type::Item then begin
                    ItemDescription := Rec.Description;
                    UnitPriceBaseUOM := Rec."Unit Price Base UOM 2";
                end;
            end;

            trigger OnAfterValidate()
            begin
                if Rec.Type = Rec.Type::Item then begin
                    Rec.Description := ItemDescription;
                    Rec."Unit Price Base UOM 2" := UnitPriceBaseUOM;
                    Validate("Unit Price Base UOM 2");
                end;
            end;
        }
        modify("Location Code")
        {
            trigger OnBeforeValidate()
            begin
                if Rec.Type = Rec.Type::Item then
                    ItemDescription := Rec.Description;
            end;

            trigger OnAfterValidate()
            begin
                if Rec.Type = Rec.Type::Item then
                    Rec.Description := ItemDescription;
            end;
        }
        modify("Variant Code") //added by Bayas
        {
            trigger OnAfterValidate()
            Var
                VariantRec: Record "Item Variant";
                ItemRec: Record Item;
                ItemL: Record Item;
                ItemUoML: Record "Item Unit of Measure";
                UnitofMeasureL: Record "Unit of Measure";
                ItemUOMVariant: Record "Item Unit of Measure";
                BaseUOMQtyL: Decimal;
            begin
                if (Rec.Type = Rec.Type::Item) then begin //AND (Rec."Posting Group" <> 'SAMPLE') 
                    ItemRec.Get("No.");
                    if rec."Variant Code" <> '' then begin
                        VariantRec.Get(rec."No.", rec."Variant Code");
                        if VariantRec.Blocked1 <> true then begin
                            if VariantRec.HSNCode <> '' then begin
                                Rec.HSNCode := VariantRec.HSNCode;
                                Rec.LineHSNCode := VariantRec.HSNCode;
                            end else begin
                                Rec.HSNCode := itemRec."Tariff No.";
                                Rec.LineHSNCode := itemRec."Tariff No.";
                            end;
                            if VariantRec.CountryOfOrigin <> '' then begin
                                Rec.CountryOfOrigin := VariantRec.CountryOfOrigin;
                                Rec.LineCountryOfOrigin := VariantRec.CountryOfOrigin;
                            end else begin
                                Rec.CountryOfOrigin := itemRec."Country/Region of Origin Code";
                                Rec.LineCountryOfOrigin := itemRec."Country/Region of Origin Code";
                            end;
                            // Message('%1 then %2', VariantRec.HSNCode, VariantRec.CountryOfOrigin);

                            ItemUoML.Get("No.", "Unit of Measure Code");
                            //Hypercare-12-03-2025-OS-NetWtGrossWt
                            // "Net Weight" := Quantity * ItemUoML."Net Weight";
                            // "Gross Weight" := "Net Weight";
                            //Hypercare-12-03-2025-OE-NetWtGrossWt 
                            BaseUOMQtyL := Quantity * ItemUoML."Qty. per Unit of Measure";
                            ItemUoML.Reset();
                            ItemUoML.SetCurrentKey("Item No.", "Qty. per Unit of Measure");
                            ItemUoML.Ascending(true);
                            ItemUoML.SetRange("Item No.", "No.");
                            if Rec."Variant Code" <> '' then begin
                                If ItemUoML."Variant Code" = Rec."Variant Code" then begin
                                    ItemUoML.SetRange("Variant Code", Rec."Variant Code");
                                end else begin
                                    ItemUoML.SetRange("Variant Code", '');
                                end;
                            end else begin
                                ItemUOMVariant.Get(Rec."No.", Rec."Unit of Measure Code");
                                if ItemUOMVariant."Variant Code" <> '' then begin
                                    ItemUoML.SetRange("Variant Code", ItemUOMVariant."Variant Code");
                                end else begin
                                    ItemUoML.SetRange("Variant Code", '');
                                end;
                            end;

                            if "Allow Loose Qty." then begin
                                if ItemUoML.FindFirst() then;
                                // "Gross Weight" += Round(BaseUOMQtyL / ItemUoML."Qty. per Unit of Measure", 1, '>') * ItemUoML."Packing Weight";//Hypercare-12-03-2025-O-NetWtGrossWt
                            end else begin
                                if ItemUoML.FindSet() then
                                    repeat
                                        UnitofMeasureL.Get(ItemUoML.Code);
                                        if not UnitofMeasureL."Decimal Allowed" then;
                                    // "Gross Weight" += Round(BaseUOMQtyL / ItemUoML."Qty. per Unit of Measure", 1, '>') * ItemUoML."Packing Weight";//Hypercare-12-03-2025-OS-NetWtGrossWt
                                    until ItemUoML.Next() = 0;
                            end;
                            //Hypercare-12-03-2025-OS-NetWtGrossWt
                            // "Gross Weight" := Round("Gross Weight", 1, '=');
                            // "Net Weight" := Round("Net Weight", 1, '=');
                            //Hypercare-12-03-2025-OS-NetWtGrossWt
                        end else begin
                            Error('Selected variant code has been blocked!');
                        end;

                    end else begin
                        //ItemRec.Get("No.");
                        Rec.HSNCode := itemRec."Tariff No.";
                        Rec.CountryOfOrigin := itemRec."Country/Region of Origin Code";
                        Rec.LineHSNCode := itemRec."Tariff No.";
                        Rec.LineCountryOfOrigin := itemRec."Country/Region of Origin Code";

                        ItemUoML.Get("No.", "Unit of Measure Code");
                        //Hypercare-12-03-2025-OS-NetWtGrossWt
                        // "Net Weight" := Quantity * ItemUoML."Net Weight";
                        // "Gross Weight" := "Net Weight";
                        //Hypercare-12-03-2025-OE-NetWtGrossWt
                        BaseUOMQtyL := Quantity * ItemUoML."Qty. per Unit of Measure";
                        ItemUoML.Reset();
                        ItemUoML.SetCurrentKey("Item No.", "Qty. per Unit of Measure");
                        ItemUoML.Ascending(true);
                        ItemUoML.SetRange("Item No.", "No.");
                        if Rec."Variant Code" <> '' then begin
                            If ItemUoML."Variant Code" = Rec."Variant Code" then begin
                                ItemUoML.SetRange("Variant Code", Rec."Variant Code");
                            end else begin
                                ItemUoML.SetRange("Variant Code", '');
                            end;
                        end else begin
                            ItemUOMVariant.Get(Rec."No.", Rec."Unit of Measure Code");
                            if ItemUOMVariant."Variant Code" <> '' then begin
                                ItemUoML.SetRange("Variant Code", ItemUOMVariant."Variant Code");
                            end else begin
                                ItemUoML.SetRange("Variant Code", '');
                            end;
                        end;

                        if "Allow Loose Qty." then begin
                            if ItemUoML.FindFirst() then;
                            // "Gross Weight" += Round(BaseUOMQtyL / ItemUoML."Qty. per Unit of Measure", 1, '>') * ItemUoML."Packing Weight";//Hypercare-12-03-2025-OS-NetWtGrossWt
                        end else begin
                            if ItemUoML.FindSet() then
                                repeat
                                    UnitofMeasureL.Get(ItemUoML.Code);
                                    if not UnitofMeasureL."Decimal Allowed" then;
                                // "Gross Weight" += Round(BaseUOMQtyL / ItemUoML."Qty. per Unit of Measure", 1, '>') * ItemUoML."Packing Weight";//Hypercare-12-03-2025-OS-NetWtGrossWt
                                until ItemUoML.Next() = 0;
                        end;
                        //Hypercare-12-03-2025-OS-NetWtGrossWt
                        // "Gross Weight" := Round("Gross Weight", 1, '=');
                        // "Net Weight" := Round("Net Weight", 1, '=');
                        //Hypercare-12-03-2025-OE-NetWtGrossWt
                    end;
                end;
            end;
        }
        modify("Allow Loose Qty.") //added by baya
        {
            trigger OnAfterValidate()
            var
                ItemL: Record Item;
                ItemUoML: Record "Item Unit of Measure";
                UnitofMeasureL: Record "Unit of Measure";
                BaseUOMQtyL: Decimal;
            begin
                if not ItemL.Get("No.") then
                    exit;
                ItemL.TestField("Allow Loose Qty.", true);
                if not UnitofMeasureL.Get("Unit of Measure Code") then
                    exit;
                if UnitofMeasureL."Decimal Allowed" then
                    exit;
                ItemUoML.Get("No.", "Unit of Measure Code");
                //Hypercare-12-03-2025-OS-NetWtGrossWt
                // "Net Weight" := Quantity * ItemUoML."Net Weight";
                // "Gross Weight" := "Net Weight";
                //Hypercare-12-03-2025-OE-NetWtGrossWt
                BaseUOMQtyL := Quantity * ItemUoML."Qty. per Unit of Measure";
                ItemUoML.Reset();
                ItemUoML.SetCurrentKey("Item No.", "Qty. per Unit of Measure");
                ItemUoML.Ascending(true);
                ItemUoML.SetRange("Item No.", "No.");
                if Rec."Variant Code" <> '' then begin
                    If ItemUoML."Variant Code" = Rec."Variant Code" then begin
                        ItemUoML.SetRange("Variant Code", Rec."Variant Code");
                    end else begin
                        ItemUoML.SetRange("Variant Code", '');
                    end;
                end else begin
                    ItemUoML.SetRange("Variant Code", '');
                end;
                if "Allow Loose Qty." then begin
                    if ItemUoML.FindFirst() then;
                    // "Gross Weight" += Round(BaseUOMQtyL / ItemUoML."Qty. per Unit of Measure", 1, '>') * ItemUoML."Packing Weight";//Hypercare-12-03-2025-OS-NetWtGrossWt
                end else begin
                    if ItemUoML.FindSet() then
                        repeat
                            UnitofMeasureL.Get(ItemUoML.Code);
                            if not UnitofMeasureL."Decimal Allowed" then;
                        // "Gross Weight" += Round(BaseUOMQtyL / ItemUoML."Qty. per Unit of Measure", 1, '>') * ItemUoML."Packing Weight";//Hypercare-12-03-2025-OS-NetWtGrossWt
                        until ItemUoML.Next() = 0;
                end;
                //Hypercare-12-03-2025-OS-NetWtGrossWt
                // "Gross Weight" := Round("Gross Weight", 1, '=');
                // "Net Weight" := Round("Net Weight", 1, '=');
                //Hypercare-12-03-2025-OE-NetWtGrossWt
            end;
        }
        modify(Reserve)
        {
            trigger OnBeforeValidate()
            var
                UsersetupRec: Record "User Setup";
            begin
                UsersetupRec.Get(UserId);
                if UsersetupRec."Allow SO Line Reserve Modify" <> true then
                    Error('Reserve field cannot be editable');
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
            begin
                if "Unit Price Base UOM 2" <> 0 then rec.Validate("Unit Price Base UOM 2", xRec."Unit Price Base UOM 2"); //PackingListExtChange
                if "Allow Loose Qty." then Validate("Allow Loose Qty.");
            end;
        }
        modify("No.")
        {
            //20-09-2022
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST("G/L Account"), "System-Created Entry" = CONST(false)) "G/L Account" WHERE("Direct Posting" = CONST(true),
                                                                                               "Account Type" = CONST(Posting),
                                                                                               Blocked = CONST(false))
            ELSE
            IF (Type = CONST("G/L Account"),
                                                                                                        "System-Created Entry" = CONST(true)) "G/L Account"
            ELSE
            IF (Type = CONST(Resource)) Resource
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST("Charge (Item)")) "Item Charge"
            ELSE
            IF (Type = CONST(Item), "Document Type" = FILTER(<> "Credit Memo" & <> "Return Order")) Item WHERE(Blocked = CONST(false)) ELSE
            IF (Type = CONST(Item), "Document Type" = FILTER("Credit Memo" | "Return Order")) Item WHERE(Blocked = CONST(false));
            //20-09-2022
            trigger OnAfterValidate()
            var
                Item_rec: Record Item;
            begin
                if rec.Type = rec.Type::Item then begin
                    Item_rec.Get(rec."No.");
                    Rec.LineCountryOfOrigin := Item_rec."Country/Region of Origin Code";
                    Rec.LineHSNCode := Item_rec."Tariff No.";
                end;
            end;
        }
        modify("Unit Price Base UOM 2") //PackingListExtChange
        {
            trigger OnBeforeValidate()
            var
            begin
                //  Validate("Unit Price Base UOM", Round("Unit Price Base UOM", 0.01));
                "Unit Price Base UOM 2" := Round("Unit Price Base UOM 2", 0.01); //PackingListExtChange
                if "Customer Requested Unit Price" = 0 then
                    "Customer Requested Unit Price" := "Unit Price Base UOM 2"; //PackingListExtChange
            end;
        }
        //GST-22/05/2022
        modify("VAT %")
        {
            CaptionClass = 'GSTORVAT,VAT %';
        }
        modify("VAT Bus. Posting Group")
        {
            CaptionClass = 'GSTORVAT,VAT Bus. Posting Group';
        }
        modify("VAT Clause Code")
        {
            CaptionClass = 'GSTORVAT,VAT Clause Code';
        }
        modify("Amount Including VAT")
        {
            CaptionClass = 'GSTORVAT,Amount Including VAT';
        }
        modify("VAT Difference")
        {
            CaptionClass = 'GSTORVAT,VAT Difference';
        }
        modify("VAT Identifier")
        {
            CaptionClass = 'GSTORVAT,VAT Identifier';
        }
        modify("VAT Prod. Posting Group")
        {
            CaptionClass = 'GSTORVAT,VAT Prod. Posting Group';
        }
        modify("VAT Base Amount")
        {
            CaptionClass = 'GSTORVAT,VAT Base Amount';
        }
        modify("Prepmt VAT Diff. Deducted")
        {
            CaptionClass = 'GSTORVAT,Prepmt VAT Diff. Deducted';
        }
        modify("Prepmt. VAT Amount Inv. (LCY)")
        {
            CaptionClass = 'GSTORVAT,Prepmt. VAT Amount Inv. (LCY)';
        }
        modify("Prepmt. VAT Base Amt.")
        {
            CaptionClass = 'GSTORVAT,Prepmt. Prepmt. VAT Base Amt.';
        }
        modify("Prepayment VAT %")
        {
            CaptionClass = 'GSTORVAT,Prepayment VAT %';
        }
        modify("Prepayment VAT Difference")
        {
            CaptionClass = 'GSTORVAT,Prepayment VAT Difference';
        }
        modify("Prepayment VAT Identifier")
        {
            CaptionClass = 'GSTORVAT,Prepayment VAT Identifier';
        }
        modify("VAT Calculation Type")
        {
            CaptionClass = 'GSTORVAT,VAT Calculation Type';
        }
        modify("Prepmt VAT Diff. to Deduct")
        {
            CaptionClass = 'GSTORVAT,Prepmt VAT Diff. to Deduct';
        }
        modify("Prepmt. VAT Calc. Type")
        {
            CaptionClass = 'GSTORVAT,Prepmt. VAT Calc. Type';
        }
        modify("Prepmt. Amt. Incl. VAT")
        {
            CaptionClass = 'GSTORVAT,Prepmt. Amt. Incl. VAT';
        }
        modify("Prepmt. Amount Inv. Incl. VAT")
        {
            CaptionClass = 'GSTORVAT,Prepmt. Amount Inv. Incl. VAT';
        }
        modify("Shipped Not Inv. (LCY) No VAT")
        {
            CaptionClass = 'GSTORVAT,Shipped Not Inv. (LCY) No VAT';
        }

        // modify("Line Amount")
        // {
        //     CaptionClass = GetCustomCaptionClass(FieldNo("Line Amount"));
        // }
        // modify("Unit Price")
        // {
        //     CaptionClass = GetCustomCaptionClass(FieldNo("Unit Price"));
        // }

        field(53010; "Initial Price"; Decimal)
        {
            Caption = 'Initial Price';
            DataClassification = ToBeClassified;
            Description = 'T12574';
        }
        field(53011; "Price Changed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53012; "Header Status"; Enum "Sales Document Status")
        {
            Caption = 'Header Status';
            Editable = false;
            Description = 'T12574';
        }
        field(53013; "Price Change %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'T12574';
        }

        //08-08-2022-start
        field(58035; "Item Incentive Point (IIP)"; Option)
        {
            OptionMembers = ,"1","2","3","4","5";
            Description = 'T12574';
        }
        field(58036; "Selling Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'T12574';
            trigger OnValidate()
            begin
                "Unit Price Difference" := "Unit Price Base UOM 2" - "Selling Price";
            end;
        }
        field(58037; "Unit Price Difference"; Decimal)
        {
            DataClassification = ToBeClassified;
            Description = 'Difference between unit price and selling Price defined in Item Price List';//T12574
        }

        //08-08-2022-end
        modify(LineCountryOfOrigin)
        {
            trigger OnAfterValidate()
            begin
                CompInfo.Get();
                if CompInfo."Country/Region Code" = LineCountryOfOrigin then begin
                    if CustomUserSetup.Get(UserId) then begin
                        if CustomUserSetup."Allow this Comp. COO selection" = false then
                            Error(Text000);
                    end else begin
                        Error(Text000);
                    end;
                end;
            end;
        }
        modify("Promised Delivery Date")
        {
            Caption = 'Proposed Delivery Date';
            trigger OnBeforeValidate()
            begin
                StatusCheckSuspended := true;
                TestStatusOpen();
            end;
        }

    }
    // local procedure GetCustomCaptionClass(Number: Integer): Text
    // begin
    //     exit('GSTORVAT,' + GetCaptionClass(Number));
    // end;

    var
        CompInfo: Record "Company Information";
        CustomUserSetup: Record "Custom User Setup";
        Text000: Label 'You are not authorised to select this country of origin!.';
        ItemDescription: Text[100];
        UnitPriceBaseUOM: Decimal;
}