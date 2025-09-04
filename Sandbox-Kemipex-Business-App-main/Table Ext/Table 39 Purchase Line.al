tableextension 58049 PurchaselineTbl extends "Purchase Line"//T12370-N
{
    fields
    {

        field(58004; Item_COO; Code[20])
        {
            Caption = 'Item Country Of Origin';
            TableRelation = "Country/Region";
            Editable = false;
        }
        field(58005; Item_Manufacturer_Code; Code[20])
        {
            Caption = 'Item Manufacturer Code';
            // TableRelation = KMP_TblManufacturerName;T12855-O
            TableRelation = Manufacturer;//T12855-N
            Editable = false;
        }
        field(58006; Item_Manufacturer_Description; Text[100])
        {
            Caption = 'Item Manufacturer';
            Editable = false;
        }
        field(58007; Item_short_name; Text[100])
        {
            Caption = 'Item Short Name';
            Editable = false;
        }
        field(58009; "Base UOM"; Code[20])
        {
            Editable = false;
        }
        field(58010; "Unit Price Base UOM"; Decimal)
        {//T12370-NS
         //Kemipex Hypercare -10-01-2025-NS
            trigger OnValidate()
            var
                myInt: Integer;
                purchaseheader: Record "Purchase Header";
            begin
                TestStatusOpen();
                Validate("Direct Unit Cost", Round("Unit Price Base UOM" * "Qty. per Unit of Measure", 0.01))
            end;
            //T12370-NE
            //Kemipex Hypercare -10-01-2025-NE
        }

        field(58029; "Item HS Code"; Code[20])
        {
            TableRelation = "Tariff Number";
            DataClassification = ToBeClassified;
            Editable = false;
        }

        //08-08-2022-start
        field(58035; "Item Incentive Point (IIP)"; Option)
        {
            OptionMembers = ,"1","2","3","4","5";
        }

        field(53000; "Salesperson Code"; Code[20])
        {
            Caption = 'Salesperson Code';
            TableRelation = "Salesperson/Purchaser";
        }

        field(53001; "Container Size"; Text[200])
        {
            Caption = 'Container Size';
            DataClassification = ToBeClassified;
        }
        field(53002; "Shipping Remarks"; Text[150])
        {
            Caption = 'Shipping Remarks';
            DataClassification = ToBeClassified;
        }
        field(53003; "In-Out Instruction"; Text[200])
        {
            Caption = 'Material Inbound/Outbound Instruction';
            DataClassification = ToBeClassified;
        }
        field(53004; "Shipping Line"; Text[150])
        {
            Caption = 'Shipping Line';
            DataClassification = ToBeClassified;
        }
        field(53005; "BL-AWB No."; Text[150])
        {
            Caption = 'BL/AWB Number';
            DataClassification = ToBeClassified;
        }
        field(53006; "Vessel-Voyage No."; Text[150])
        {
            Caption = 'Vessel/Voyage Number';
            DataClassification = ToBeClassified;
        }
        field(53007; "Freight Forwarder"; Text[150])
        {
            Caption = 'Freight Forwarder';
            DataClassification = ToBeClassified;
        }
        field(53008; "Freight Charge"; Text[150])
        {
            Caption = 'Freight Charge';
            DataClassification = ToBeClassified;
        }
        //T12370-NS,T12855-NS
        modify("Variant Code") //added by Bayas 
        {

            trigger OnBeforeValidate()
            Var
                VariantRec: Record "Item Variant";
            begin
                if Rec.Type = Rec.Type::Item then
                    ItemDescription := Rec.Description;
            end;

            trigger OnAfterValidate()
            Var
                VariantRec: Record "Item Variant";
                itemRec: Record Item;
                VariantDetailsRec: Record "Item Variant Details";
                Manufacturer: Record Manufacturer;//T12855-N
            // Manufacturer: Record KMP_TblManufacturerName;T12855-O
            begin
                if (Rec.Type = Rec.Type::Item) then begin//AND (Rec."Posting Group" <> 'SAMPLE')
                    ItemRec.Get("No.");
                    if rec."Variant Code" <> '' then begin
                        VariantRec.Get(rec."No.", rec."Variant Code");
                        if VariantRec."Variant Details" <> '' then
                            VariantDetailsRec.Get(rec."No.", Rec."Variant Code");
                        if VariantRec.HSNCode <> '' then begin
                            Rec."Item HS Code" := VariantRec.HSNCode;
                        end else begin
                            Rec."Item HS Code" := itemRec."Tariff No.";
                        end;
                        if VariantRec.CountryOfOrigin <> '' then begin
                            Rec.Item_COO := VariantRec.CountryOfOrigin;
                        end else begin
                            Rec.Item_COO := itemRec."Country/Region of Origin Code";
                        end;
                        if VariantDetailsRec."Manufacturer Name" <> '' then begin
                            Manufacturer.Get(VariantDetailsRec."Manufacturer Name");
                            Rec.Item_Manufacturer_Code := VariantDetailsRec."Manufacturer Name";
                            Rec.Item_Manufacturer_Description := Manufacturer.Name;//T12855-N
                        end else begin
                            Item_Manufacturer_code := itemRec.ManufacturerName;
                            Item_Manufacturer_Description := itemRec."Manufacturer Description";
                        end;

                        if VariantRec.Description <> '' then begin
                            Rec.Item_short_name := VariantRec.Description;
                        end else begin
                            Rec.Item_short_name := itemRec."Search Description";
                        end;

                        if VariantDetailsRec."Vendor Item Description" <> '' then begin
                            Rec.Description := VariantDetailsRec."Vendor Item Description";
                        end else begin
                            Rec.Description := itemRec.Vendor_item_description;
                        end;

                        // Message('%1 then %2', VariantRec.HSNCode, VariantRec.CountryOfOrigin);
                    end else begin
                        //ItemRec.Get("No.");
                        Rec."Item HS Code" := itemRec."Tariff No.";
                        Rec.Item_COO := itemRec."Country/Region of Origin Code";
                        Item_Manufacturer_code := itemRec.ManufacturerName;
                        Item_Manufacturer_Description := itemRec."Manufacturer Description";
                        Rec.Item_short_name := itemRec."Search Description";
                        Rec.Description := itemRec.Vendor_item_description;
                    end;
                end;
            end;
            //T12855-NE
        }


        // modify("Location Code")
        // {
        //     trigger OnBeforeValidate()
        //     begin
        //         if Rec.Type = Rec.Type::Item then
        //             ItemDescription := Rec.Description;
        //     end;

        //     trigger OnAfterValidate()
        //     begin
        //         if Rec.Type = Rec.Type::Item then
        //             Rec.Description := ItemDescription;
        //     end;
        // }

        // modify("Unit of Measure Code")
        // {
        //     Caption = 'UOM';
        //     trigger OnBeforeValidate()
        //     begin
        //         if Rec.Type = Rec.Type::Item then
        //             ItemDescription := Rec.Description;
        //     end;

        //     trigger OnAfterValidate()
        //     begin
        //         if Rec.Type = Rec.Type::Item then
        //             Rec.Description := ItemDescription;
        //     end;
        // }

        // //08-08-2022-end
        modify("No.")
        {
            //20-09-2022
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST("G/L Account"), "System-Created Entry" = CONST(false)) "G/L Account" WHERE("Direct Posting" = CONST(true), "Account Type" = CONST(Posting), Blocked = CONST(false))
            ELSE
            IF (Type = CONST("G/L Account"), "System-Created Entry" = CONST(true)) "G/L Account" ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST("Charge (Item)")) "Item Charge"
            ELSE
            IF (Type = CONST(Item), "Document Type" = FILTER(<> "Credit Memo" & <> "Return Order")) Item WHERE(Blocked = CONST(false)) ELSE
            IF (Type = CONST(Item), "Document Type" = FILTER("Credit Memo" | "Return Order")) Item WHERE(Blocked = CONST(false))
            else
            if (Type = const(Resource)) Resource;
            //20-09-2022
            trigger OnAfterValidate()
            var
                item_m: Record Item;
                typeref: FieldRef;
            begin
                if type = Type::Item then
                    item_m.Get(rec."No.");
                item_m.SetRange("No.", Rec."No.");
                Item_COO := item_m."Country/Region of Origin Code";
                "Item HS Code" := item_m."Tariff No.";
                Item_short_name := item_m."Search Description";
                Item_Manufacturer_code := item_m.ManufacturerName;
                Item_Manufacturer_Description := item_m."Manufacturer Description";
                "Base UOM" := item_m."Base Unit of Measure";
                if item_m.Vendor_item_description = '' then
                    exit
                else
                    Description := item_m.Vendor_item_description;
            end;
        }
        modify("Direct Unit Cost")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                "Unit Price Base UOM" := Round("Direct Unit Cost" / "Qty. per Unit of Measure", 0.01);
            end;
        }
        //T13620-NS
        modify(CustomETD)
        {
            trigger OnAfterValidate()
            begin
                EmptyETD();
                if CustomETD <> 0D then
                    exit
                else
                    VerifyOriginalDates();
            end;
        }
        modify(CustomETA)
        {
            trigger OnAfterValidate()
            begin
                EmptyETD();
                VerifyOriginalDates();
            end;
        }
        modify(CustomR_ETD)
        {
            trigger OnAfterValidate()
            begin
                if CustomETA = 0D then Error('ETA Cannot be empty');
                EmptyR_EDT();
                if CustomR_ETD <> 0D then
                    exit
                else
                    VerifyRevisedDates();
            end;
        }
        modify(CustomR_ETA)
        {
            trigger OnAfterValidate()
            begin
                EmptyR_EDT();
                VerifyRevisedDates();
            end;
        }
        //T13620-NE
        // //GST-22/05/2022
        // modify("VAT %")
        // {
        //     CaptionClass = 'GSTORVAT,VAT %';
        // }
        // modify("VAT Bus. Posting Group")
        // {
        //     CaptionClass = 'GSTORVAT,VAT Bus. Posting Group';
        // }
        // modify("Amount Including VAT")
        // {
        //     CaptionClass = 'GSTORVAT,Amount Including VAT';
        // }
        // modify("VAT Difference")
        // {
        //     CaptionClass = 'GSTORVAT,VAT Difference';
        // }
        // modify("VAT Identifier")
        // {
        //     CaptionClass = 'GSTORVAT,VAT Identifier';
        // }
        // modify("VAT Prod. Posting Group")
        // {
        //     CaptionClass = 'GSTORVAT,VAT Prod. Posting Group';
        // }
        // modify("VAT Base Amount")
        // {
        //     CaptionClass = 'GSTORVAT,VAT Base Amount';
        // }
        // modify("Prepmt VAT Diff. Deducted")
        // {
        //     CaptionClass = 'GSTORVAT,Prepmt VAT Diff. Deducted';
        // }
        // modify("Prepmt. VAT Amount Inv. (LCY)")
        // {
        //     CaptionClass = 'GSTORVAT,Prepmt. VAT Amount Inv. (LCY)';
        // }
        // modify("Prepmt. VAT Base Amt.")
        // {
        //     CaptionClass = 'GSTORVAT,Prepmt. Prepmt. VAT Base Amt.';
        // }
        // modify("Prepayment VAT %")
        // {
        //     CaptionClass = 'GSTORVAT,Prepayment VAT %';
        // }
        // modify("Prepayment VAT Difference")
        // {
        //     CaptionClass = 'GSTORVAT,Prepayment VAT Difference';
        // }
        // modify("Prepayment VAT Identifier")
        // {
        //     CaptionClass = 'GSTORVAT,Prepayment VAT Identifier';
        // }
        // modify("VAT Calculation Type")
        // {
        //     CaptionClass = 'GSTORVAT,VAT Calculation Type';
        // }
        // modify("Prepmt VAT Diff. to Deduct")
        // {
        //     CaptionClass = 'GSTORVAT,Prepmt VAT Diff. to Deduct';
        // }
        // modify("Prepmt. VAT Calc. Type")
        // {
        //     CaptionClass = 'GSTORVAT,Prepmt. VAT Calc. Type';
        // }
        // modify("Prepmt. Amt. Incl. VAT")
        // {
        //     CaptionClass = 'GSTORVAT,Prepmt. Amt. Incl. VAT';
        // }
        // modify("Prepmt. Amount Inv. Incl. VAT")
        // {
        //     CaptionClass = 'GSTORVAT,Prepmt. Amount Inv. Incl. VAT';
        // }
        // modify("A. Rcd. Not Inv. Ex. VAT (LCY)")
        // {
        //     CaptionClass = 'GSTORVAT,A. Rcd. Not Inv. Ex. VAT (LCY)';
        // }
        // modify("Outstanding Amt. Ex. VAT (LCY)")
        // {
        //     CaptionClass = 'GSTORVAT,Outstanding Amt. Ex. VAT (LCY)';
        // }

    }
    //T13620-NS
    local procedure EmptyETD()
    begin
        if CustomETD = 0D then Error('ETD Cannot be empty');
    end;

    local procedure EmptyR_EDT()
    begin
        if CustomR_ETD = 0D then Error('R-ETD Cannot be empty');
    end;

    local procedure VerifyOriginalDates()
    var
    begin
        if CustomETA < CustomETD then
            Error('ETA Cannot be earlier than ETD');
    end;

    local procedure VerifyRevisedDates()
    var
    begin
        if CustomR_ETA < CustomR_ETD then Error('R-ETA Cannot be earlier than R-ETD');
    end;
    //T13620-NE

    // trigger OnModify()
    // var
    //     PurchLine: Record "Purchase Line";
    //     PurchHeader: Record "Purchase Header";
    //     CurrentAmount: Decimal;
    //     AmountwithTolerance: Decimal;
    //     PurchPaySetup: Record "Purchases & Payables Setup";
    //     AmountErrorLbl: TextConst ENU = 'Current Amount %1 is exceeding previous approved amount %2. Maximum amount availabe for approval including tolerance is %3.';
    // begin
    //     if "Document Type" = "Document Type"::Order then begin
    //         PurchPaySetup.Get();
    //         PurchHeader.SetRange("Document Type", "Document Type");
    //         PurchHeader.SetRange("No.", "Document No.");
    //         PurchHeader.SetRange(Status, PurchHeader.Status::Released);
    //         if PurchHeader.FindFirst() then begin
    //             if PurchHeader."Last Approved Amount" <> 0 then begin
    //                 if PurchPaySetup."Purchase Order Tolerance %" <> 0 then begin
    //                     PurchLine.SetRange("Document Type", "Document Type");
    //                     PurchLine.SetRange("Document No.", "Document No.");
    //                     PurchLine.SetFilter("Line No.", '<>%1', "Line No.");
    //                     if PurchLine.FindFirst() then
    //                         repeat
    //                             CurrentAmount += PurchLine."Line Amount";
    //                         until PurchLine.Next() = 0;

    //                     CurrentAmount += "Line Amount";
    //                     AmountwithTolerance := PurchHeader."Last Approved Amount" + (PurchHeader."Last Approved Amount" * PurchPaySetup."Purchase Order Tolerance %" / 100);
    //                     if CurrentAmount > AmountwithTolerance then
    //                         Error(AmountErrorLbl, CurrentAmount, PurchHeader."Last Approved Amount", AmountwithTolerance);

    //                 end;
    //             end;
    //         end;
    //     end;
    // end;

    trigger OnInsert()
    var
        PurchHeader: Record "Purchase Header";
    begin
        if PurchHeader.Get("Document Type", "Document No.") then
            if PurchHeader."Document Type" = PurchHeader."Document Type"::Order then
                PurchHeader.TestField(Status, PurchHeader.Status::Open);
    end;

    trigger OnDelete()
    var
        PurchHeader: Record "Purchase Header";
    begin
        if PurchHeader.Get("Document Type", "Document No.") then
            if PurchHeader."Document Type" = PurchHeader."Document Type"::Order then
                PurchHeader.TestField(Status, PurchHeader.Status::Open);
    end;
    //T12370-NE

    var
        ItemDescription: Text[100];
}