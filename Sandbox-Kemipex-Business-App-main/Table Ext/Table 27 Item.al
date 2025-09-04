tableextension 58079 items extends 27//T12370-Full Comment,T12855
{
    fields
    {
        field(58008; Vendor_item_description; Text[100])
        {
            Caption = 'Vendor Item Description';
        }

        //T13413-NS
        field(58030; "Consolidated Inventory"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        //T13413-NE

        /*field(58031; "Consolidated Inventory Value"; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53010; "Storage Handling Instruction"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(53011; "CRM Code"; Text[50])
        {

        }
        field(53012; "Saber Code"; Text[12])
        {
            DataClassification = ToBeClassified;
        }
        field(53013; "Precautionary Statement"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(53014; "Pictogram Code"; Code[20])
        {
            TableRelation = "Item Pictogram"."Pictogram Code" WHERE("Item No." = FIELD("No."));
        }
       */
        // field(53400; "KFZEShow on Sales Budget"; Boolean)
        // {
        //     Caption = 'Show on Sales Budget';
        // }





        //T12370-NS
        //     modify(Reserve)
        //     {
        //         trigger OnAfterValidate()
        //         var
        //             SalesLine: Record "Sales Line";
        //             company: Record Company;
        //         begin
        //             If (Description = '') OR ("No." = '') then exit;
        //             companytransfer2(Rec, true);
        //             company.SetFilter(Name, '<>%1', CurrentCompany);
        //             SalesLine.SetRange("No.", Rec."No.");
        //             repeat
        //                 SalesLine.ChangeCompany(company.Name);
        //                 if SalesLine.FindSet() then begin
        //                     repeat
        //                         SalesLine.Reserve := Rec.Reserve;
        //                         if SalesLine.Modify() then;
        //                     until SalesLine.Next() = 0;
        //                 end;
        //             until company.Next() = 0;
        //         end;
        //     }
        // }
        // keys
        // {
        //     key(key18; "Consolidated Inventory")
        //     {

        //     }

        // }
        // fieldgroups
        // {
        //     addlast(DropDown; "Search Description")
        //     {

        //     }
        //T12370-NE

    }

    //T12370-NS
    // procedure companytransfer2(item_from: Record Item; showMessage: Boolean)
    // var
    //     masterconfig: Record "Release to Company Setup";
    //     item_to: Record Item;
    //     Text001: Label 'Item %1 transfer to %2 Company';
    //     Text002: Label 'Item %1 modified in %2 Company';
    //     ItemUOM_TO: Record "Item Unit of Measure";
    //     ItemUOM_From: Record "Item Unit of Measure";
    //     itemVarianceFrom: Record "Item Variant";
    //     ItemVarianceTo: Record "Item Variant";
    //     itemVariantDetailsFrom: Record "Item Variant Details";
    //     ItemVariantDetailsTo: Record "Item Variant Details";
    //     ItemTestingParameterFrom: Record "Item Testing Parameter";
    //     ItemTestingParameterTo: Record "Item Testing Parameter";
    //     ProductFamilyFrom: Record "Product Family";
    //     ProductFamilyTo: Record "Product Family";
    //     LastDirectCostV: Decimal;
    //     UnitCostV: Decimal;
    //     StandardCostV: Decimal;
    //     Blocked: Boolean;
    //     SalesBlocked: Boolean;
    //     PurchaseBlocked: Boolean;
    //     EventsCod: Codeunit Events;
    //     isUOMNotAllowed: Boolean;
    //     comment: Text;
    // begin
    //     isUOMNotAllowed := EventsCod.IsTransactionAvailableForItem(item_from."No.", comment);
    //     masterconfig.reset();
    //     masterconfig.SetRange(masterconfig."Transfer Item", true);
    //     masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
    //     if masterconfig.FindSet() then
    //         repeat
    //             //++
    //             //deleting sub masters before inserting
    //             if not isUOMNotAllowed then begin
    //                 Clear(ItemUOM_TO);
    //                 ItemUOM_TO.ChangeCompany(masterconfig."Company Name");
    //                 ItemUOM_TO.Reset();
    //                 ItemUOM_TO.SetRange("Item No.", item_from."No.");
    //                 if ItemUOM_TO.FindSet() then
    //                     ItemUOM_TO.DeleteAll();
    //             end;

    //             Clear(ItemVarianceTo);
    //             ItemVarianceTo.ChangeCompany(masterconfig."Company Name");
    //             ItemVarianceTo.Reset();
    //             ItemVarianceTo.SetRange("Item No.", item_from."No.");
    //             if ItemVarianceTo.FindSet() then
    //                 ItemVarianceTo.DeleteAll();

    //             Clear(ItemVariantDetailsTo);
    //             ItemVariantDetailsTo.ChangeCompany(masterconfig."Company Name");
    //             ItemVariantDetailsTo.Reset();
    //             ItemVariantDetailsTo.SetRange("Item No.", item_from."No.");
    //             if ItemVariantDetailsTo.FindSet() then
    //                 ItemVariantDetailsTo.DeleteAll();

    //             Clear(ItemTestingParameterTo);
    //             ItemTestingParameterTo.ChangeCompany(masterconfig."Company Name");
    //             ItemTestingParameterTo.Reset();
    //             ItemTestingParameterTo.SetRange("Item No.", item_from."No.");
    //             if ItemTestingParameterTo.FindSet() then
    //                 ItemTestingParameterTo.DeleteAll();

    //             //--
    //             Clear(item_to);
    //             item_to.ChangeCompany(masterconfig."Company Name");
    //             item_to.Reset();
    //             if not item_to.Get(item_from."No.") then begin
    //                 item_to.Init();
    //                 item_to := item_from;
    //                 if item_to.Insert() then begin
    //                     ItemUOM_From.Reset();
    //                     ItemUOM_From.SetRange("Item No.", Item_From."No.");
    //                     IF ItemUOM_From.FindSet() then
    //                         repeat
    //                             IF not ItemUOM_TO.Get(ItemUOM_From."Item No.", ItemUOM_From.Code) then begin
    //                                 ItemUOM_TO.Init();
    //                                 ItemUOM_TO := ItemUOM_From;
    //                                 If ItemUOM_TO.Insert() then;
    //                             end else
    //                                 If ItemUOM_TO.Modify() then;
    //                         until ItemUOM_From.Next() = 0;

    //                     itemVarianceFrom.Reset();
    //                     itemVarianceFrom.SetRange("Item No.", item_from."No.");
    //                     if itemVarianceFrom.FindSet() then
    //                         repeat
    //                             Clear(ItemVarianceTo);
    //                             ItemVarianceTo.ChangeCompany(masterconfig."Company Name");
    //                             ItemVarianceTo.Reset();
    //                             if not ItemVarianceTo.Get(itemVarianceFrom."Item No.", itemVarianceFrom.Code) then begin
    //                                 ItemVarianceTo.Init();
    //                                 ItemVarianceTo := itemVarianceFrom;
    //                                 //if ItemVarianceTo.Modify() then;
    //                                 if ItemVarianceTo.Insert() then;
    //                             end else
    //                                 If ItemVarianceTo.Modify() then;
    //                         until itemVarianceFrom.Next() = 0;


    //                     ItemVariantDetailsFrom.Reset();
    //                     ItemVariantDetailsFrom.SetRange("Item No.", item_from."No.");
    //                     if ItemVariantDetailsFrom.FindSet() then
    //                         repeat
    //                             Clear(ItemVariantDetailsTo);
    //                             ItemVariantDetailsTo.ChangeCompany(masterconfig."Company Name");
    //                             ItemVariantDetailsTo.Reset();
    //                             if not ItemVariantDetailsTo.Get(ItemVariantDetailsFrom."Item No.", ItemVariantDetailsFrom."Variant Code") then begin
    //                                 ItemVariantDetailsTo.Init();
    //                                 ItemVariantDetailsTo := ItemVariantDetailsFrom;
    //                                 //if ItemVarianceTo.Modify() then;
    //                                 if ItemVariantDetailsTo.Insert() then;
    //                             end else
    //                                 If ItemVariantDetailsTo.Modify() then;
    //                         until ItemVariantDetailsFrom.Next() = 0;

    //                     ItemTestingParameterFrom.Reset();
    //                     ItemTestingParameterFrom.SetRange("Item No.", item_from."No.");
    //                     if ItemTestingParameterFrom.FindSet() then
    //                         repeat
    //                             Clear(ItemTestingParameterTo);
    //                             ItemTestingParameterTo.ChangeCompany(masterconfig."Company Name");
    //                             ItemTestingParameterTo.Reset();
    //                             if not ItemTestingParameterTo.Get(ItemTestingParameterFrom."Item No.", ItemTestingParameterFrom.Code) then begin
    //                                 ItemTestingParameterTo.Init();
    //                                 ItemTestingParameterTo := ItemTestingParameterFrom;
    //                                 // if ItemTestingParameterTo.Modify() then;
    //                                 if ItemTestingParameterTo.Insert() then;
    //                             end else
    //                                 If ItemTestingParameterTo.Modify() then;
    //                         until ItemTestingParameterFrom.Next() = 0;

    //                     //ProductFamily
    //                     ProductFamilyFrom.Reset();
    //                     ProductFamilyFrom.SetRange(code, item_from."Product Family");
    //                     if ProductFamilyFrom.FindFirst() then begin
    //                         Clear(ProductFamilyTo);
    //                         ProductFamilyTo.ChangeCompany(masterconfig."Company Name");
    //                         ProductFamilyTo.Reset();
    //                         if not ProductFamilyTo.Get(ProductFamilyFrom.Code) then begin
    //                             ProductFamilyTo.Init();
    //                             ProductFamilyTo := ProductFamilyFrom;
    //                             if ProductFamilyTo.Insert() then;
    //                         end else
    //                             If ProductFamilyTo.Modify() then;
    //                     end;
    //                 end;
    //                 if showMessage then
    //                     Message(Text001, item_from.Description, masterconfig."Company Name");
    //             end
    //             else begin
    //                 LastDirectCostv := item_to."Last Direct Cost";
    //                 UnitCostv := item_to."Unit Cost";
    //                 Blocked := item_to.Blocked;
    //                 SalesBlocked := item_to."Sales Blocked";
    //                 PurchaseBlocked := item_to."Purchasing Blocked";
    //                 StandardCostV := item_to."Standard Cost";
    //                 item_to.TransferFields(item_from, false);
    //                 item_to."Last Direct Cost" := LastDirectCostV;
    //                 item_to."Unit Cost" := UnitCostV;
    //                 item_to."Standard Cost" := StandardCostV;
    //                 item_to.Blocked := Blocked;
    //                 item_to."Sales Blocked" := SalesBlocked;
    //                 item_to."Purchasing Blocked" := PurchaseBlocked;

    //                 if item_to.Modify() then begin
    //                     ItemUOM_From.Reset();
    //                     ItemUOM_From.SetRange("Item No.", item_from."No.");
    //                     IF ItemUOM_From.FindSet() then
    //                         repeat
    //                             Clear(ItemUOM_TO);
    //                             ItemUOM_TO.ChangeCompany(masterconfig."Company Name");
    //                             ItemUOM_TO.Reset();
    //                             IF not ItemUOM_TO.Get(ItemUOM_From."Item No.", ItemUOM_From.Code) then begin
    //                                 ItemUOM_TO.Init();
    //                                 ItemUOM_TO := ItemUOM_From;
    //                                 IF ItemUOM_TO.Insert() then;
    //                             end
    //                             ELSE Begin
    //                                 ItemUOM_TO.TransferFields(ItemUOM_From, false);
    //                                 IF ItemUOM_TO.Modify() then;
    //                             End;
    //                         until ItemUOM_From.Next() = 0;
    //                     itemVarianceFrom.Reset();
    //                     itemVarianceFrom.SetRange("Item No.", item_from."No.");
    //                     if itemVarianceFrom.FindSet() then begin
    //                         repeat
    //                             Clear(ItemVarianceTo);
    //                             ItemVarianceTo.ChangeCompany(masterconfig."Company Name");
    //                             ItemVarianceTo.Reset();
    //                             if not ItemVarianceTo.get(itemVarianceFrom."Item No.", itemVarianceFrom.Code) then begin
    //                                 ItemVarianceTo.Init();
    //                                 ItemVarianceTo := itemVarianceFrom;
    //                                 if ItemVarianceTo.Insert() then;
    //                             end
    //                             else begin
    //                                 ItemVarianceTo.TransferFields(itemVarianceFrom, false);
    //                                 if ItemVarianceTo.Modify() then;
    //                             end;
    //                         until itemVarianceFrom.Next() = 0;
    //                     end;

    //                     itemVariantDetailsFrom.Reset();
    //                     itemVariantDetailsFrom.SetRange("Item No.", item_from."No.");
    //                     if itemVariantDetailsFrom.FindSet() then begin
    //                         repeat
    //                             Clear(ItemVariantDetailsTo);
    //                             ItemVariantDetailsTo.ChangeCompany(masterconfig."Company Name");
    //                             ItemVariantDetailsTo.Reset();
    //                             if not ItemVariantDetailsTo.get(itemVariantDetailsFrom."Item No.", itemVariantDetailsFrom."Variant Code") then begin
    //                                 ItemVariantDetailsTo.Init();
    //                                 ItemVariantDetailsTo := itemVariantDetailsFrom;
    //                                 if ItemVariantDetailsTo.Insert() then;
    //                             end
    //                             else begin
    //                                 ItemVariantDetailsTo.TransferFields(itemVariantDetailsFrom, false);
    //                                 if ItemVariantDetailsTo.Modify() then;
    //                             end;
    //                         until itemVariantDetailsFrom.Next() = 0;
    //                     end;

    //                     ItemTestingParameterFrom.Reset();
    //                     ItemTestingParameterFrom.SetRange("Item No.", item_from."No.");
    //                     if ItemTestingParameterFrom.FindSet() then begin
    //                         repeat
    //                             Clear(ItemTestingParameterTo);
    //                             ItemTestingParameterTo.ChangeCompany(masterconfig."Company Name");
    //                             ItemTestingParameterTo.Reset();
    //                             if not ItemTestingParameterTo.get(ItemTestingParameterFrom."Item No.", ItemTestingParameterFrom.Code) then begin
    //                                 ItemTestingParameterTo.Init();
    //                                 ItemTestingParameterTo := ItemTestingParameterFrom;
    //                                 if ItemTestingParameterTo.Insert() then;
    //                             end
    //                             else begin
    //                                 ItemTestingParameterTo.TransferFields(ItemTestingParameterFrom, false);
    //                                 if ItemTestingParameterTo.Modify() then;
    //                             end;
    //                         until ItemTestingParameterFrom.Next() = 0;
    //                     end;

    //                     //ProductFamily
    //                     ProductFamilyFrom.Reset();
    //                     ProductFamilyFrom.SetRange(code, item_from."Product Family");
    //                     if ProductFamilyFrom.FindFirst() then begin
    //                         Clear(ProductFamilyTo);
    //                         ProductFamilyTo.ChangeCompany(masterconfig."Company Name");
    //                         ProductFamilyTo.Reset();
    //                         if not ProductFamilyTo.Get(ProductFamilyFrom.Code) then begin
    //                             ProductFamilyTo.Init();
    //                             ProductFamilyTo := ProductFamilyFrom;
    //                             if ProductFamilyTo.Insert() then;
    //                         end else
    //                             If ProductFamilyTo.Modify() then;
    //                     end;

    //                 end;
    //                 if showMessage then
    //                     Message(Text002, item_to.Description, masterconfig."Company Name");
    //             end;
    //         until masterconfig.Next() = 0;
    // end;


    // procedure TPcompanytransfer(item_from: Record Item; showMessage: Boolean)
    // var
    //     masterconfig: Record "Release to Company Setup";
    //     item_to: Record Item;
    //     Text001: Label 'Item %1 Testing Parameter transfer to %2 Company';
    //     Text002: Label 'Item %1 Testing Parameter modified in %2 Company';
    //     ItemTestingParameterFrom: Record "Item Testing Parameter";
    //     ItemTestingParameterTo: Record "Item Testing Parameter";

    // begin

    //     masterconfig.reset();
    //     masterconfig.SetRange(masterconfig."Transfer Item", true);
    //     masterconfig.SetFilter(masterconfig."Company Name", '<>%1', CompanyName);
    //     if masterconfig.FindSet() then
    //         repeat

    //             Clear(ItemTestingParameterTo);
    //             ItemTestingParameterTo.ChangeCompany(masterconfig."Company Name");
    //             ItemTestingParameterTo.Reset();
    //             ItemTestingParameterTo.SetRange("Item No.", item_from."No.");
    //             if ItemTestingParameterTo.FindSet() then
    //                 ItemTestingParameterTo.DeleteAll();


    //             Clear(item_to);
    //             item_to.ChangeCompany(masterconfig."Company Name");
    //             item_to.Reset();
    //             if not item_to.Get(item_from."No.") then begin


    //                 ItemTestingParameterFrom.Reset();
    //                 ItemTestingParameterFrom.SetRange("Item No.", item_from."No.");
    //                 if ItemTestingParameterFrom.FindSet() then
    //                     repeat
    //                         Clear(ItemTestingParameterTo);
    //                         ItemTestingParameterTo.ChangeCompany(masterconfig."Company Name");
    //                         ItemTestingParameterTo.Reset();
    //                         if not ItemTestingParameterTo.Get(ItemTestingParameterFrom."Item No.", ItemTestingParameterFrom.Code) then begin
    //                             ItemTestingParameterTo.Init();
    //                             ItemTestingParameterTo := ItemTestingParameterFrom;

    //                             if ItemTestingParameterTo.Insert() then;
    //                         end else
    //                             If ItemTestingParameterTo.Modify() then;
    //                     until ItemTestingParameterFrom.Next() = 0;

    //                 if showMessage then
    //                     Message(Text001, item_from.Description, masterconfig."Company Name");
    //             end
    //             else begin                    
    //                 ItemTestingParameterFrom.Reset();
    //                 ItemTestingParameterFrom.SetRange("Item No.", item_from."No.");
    //                 if ItemTestingParameterFrom.FindSet() then begin
    //                     repeat
    //                         Clear(ItemTestingParameterTo);
    //                         ItemTestingParameterTo.ChangeCompany(masterconfig."Company Name");
    //                         ItemTestingParameterTo.Reset();
    //                         if not ItemTestingParameterTo.get(ItemTestingParameterFrom."Item No.", ItemTestingParameterFrom.Code) then begin
    //                             ItemTestingParameterTo.Init();
    //                             ItemTestingParameterTo := ItemTestingParameterFrom;
    //                             if ItemTestingParameterTo.Insert() then;
    //                         end
    //                         else begin
    //                             ItemTestingParameterTo.TransferFields(ItemTestingParameterFrom, false);
    //                             if ItemTestingParameterTo.Modify() then;
    //                         end;
    //                     until ItemTestingParameterFrom.Next() = 0;
    //                 end;

    //                 if showMessage then
    //                     Message(Text002, item_to.Description, masterconfig."Company Name");
    //             end;
    //         until masterconfig.Next() = 0;
    // end;
    //T12370-NE
}