report 50554 "Generate IC Item References"
{
    UsageCategory = ReportsAndAnalysis;
    //ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Generate IC Item References-INT';

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Delete_All; Delte_gBln)
                    {
                        ApplicationArea = all;
                    }
                    field(Delete_MDM; DeleteMDM_gBln)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }


    trigger OnPostReport()
    var
        Customers: Record Customer;
        Vendors: Record Vendor;
        Items: Record Item;
        ItemVariants: Record "Item Variant";
        ItemUOM: Record "Item Unit of Measure";
        ItemReference: Record "Item Reference";
        ItemReferenceNew: Record "Item Reference";
        FieldMapping: Record "Integration Field Mapping";
        TableMapping: record "Integration Table Mapping";
    begin
        if Delte_gBln then begin
            ItemReferenceNew.Reset();
            if ItemReferenceNew.FindSet() then
                ItemReferenceNew.DeleteAll();
        end;
        Items.Reset();
        Items.SetFilter("Base Unit of Measure", '<>%1', '');
        if Items.FindSet() then
            repeat
                ItemVariants.Reset();
                ItemVariants.SetRange("Item No.", Items."No.");
                if ItemVariants.FindSet() then
                    repeat
                        ItemUOM.Reset();
                        ItemUOM.SetRange("Item No.", Items."No.");
                        if ItemUOM.FindSet() then
                            repeat
                                ItemReferenceNew.Reset();
                                Customers.Reset();
                                Customers.SetFilter("IC Partner Code", '<>%1', '');
                                if Customers.FindSet() then
                                    repeat
                                        CreateItemReference(Items."No.", ItemVariants.Code, ItemUOM.Code, ItemRefereType_Enum::Customer, Customers."No.", ItemVariants.Description);
                                    until Customers.Next() = 0;
                                ItemReferenceNew.Reset();
                                Vendors.Reset();
                                Vendors.SetFilter("IC Partner Code", '<>%1', '');
                                if Vendors.FindSet() then
                                    repeat
                                        CreateItemReference(Items."No.", ItemVariants.Code, ItemUOM.Code, ItemRefereType_Enum::Vendor, Vendors."No.", ItemVariants.Description);
                                    until Vendors.Next() = 0;
                            until ItemUOM.Next() = 0
                        else begin
                            ItemReferenceNew.Reset();
                            Customers.Reset();
                            Customers.SetFilter("IC Partner Code", '<>%1', '');
                            if Customers.FindSet() then
                                repeat
                                    CreateItemReference(Items."No.", ItemVariants.Code, Items."Base Unit of Measure", ItemRefereType_Enum::Customer, Customers."No.", ItemVariants.Description);
                                until Customers.Next() = 0;
                            ItemReferenceNew.Reset();
                            Vendors.Reset();
                            Vendors.SetFilter("IC Partner Code", '<>%1', '');
                            if Vendors.FindSet() then
                                repeat
                                    CreateItemReference(Items."No.", ItemVariants.Code, Items."Base Unit of Measure", ItemRefereType_Enum::Vendor, Vendors."No.", ItemVariants.Description);
                                until Vendors.Next() = 0;
                        end;
                    until ItemVariants.Next() = 0
                else begin
                    ItemUOM.Reset();
                    ItemUOM.SetRange("Item No.", Items."No.");
                    if ItemUOM.FindSet() then
                        repeat
                            ItemReferenceNew.Reset();
                            Customers.Reset();
                            Customers.SetFilter("IC Partner Code", '<>%1', '');
                            if Customers.FindSet() then
                                repeat
                                    CreateItemReference(Items."No.", ItemVariants.Code, ItemUOM.Code, ItemRefereType_Enum::Customer, Customers."No.", Items.Description);
                                until Customers.Next() = 0;
                            ItemReferenceNew.Reset();
                            Vendors.Reset();
                            Vendors.SetFilter("IC Partner Code", '<>%1', '');
                            if Vendors.FindSet() then
                                repeat
                                    CreateItemReference(Items."No.", ItemVariants.Code, ItemUOM.Code, ItemRefereType_Enum::Vendor, Vendors."No.", Items.Description);
                                until Vendors.Next() = 0;
                        until ItemUOM.Next() = 0
                    else begin
                        ItemReferenceNew.Reset();
                        Customers.Reset();
                        Customers.SetFilter("IC Partner Code", '<>%1', '');
                        if Customers.FindSet() then
                            repeat
                                CreateItemReference(Items."No.", ItemVariants.Code, Items."Base Unit of Measure", ItemRefereType_Enum::Customer, Customers."No.", Items.Description);
                            until Customers.Next() = 0;
                        ItemReferenceNew.Reset();
                        Vendors.Reset();
                        Vendors.SetFilter("IC Partner Code", '<>%1', '');
                        if Vendors.FindSet() then
                            repeat
                                CreateItemReference(Items."No.", ItemVariants.Code, Items."Base Unit of Measure", ItemRefereType_Enum::Vendor, Vendors."No.", Items.Description);
                            until Vendors.Next() = 0;
                    end;
                end;
            until Items.Next() = 0;
        if DeleteMDM_gBln then begin
            TableMapping.Reset();
            TableMapping.SetFilter(Type, 'Master Data Management');
            TableMapping.SetRange("Table ID", 5777);
            if TableMapping.FindFirst() then begin
                FieldMapping.Reset();
                FieldMapping.SetRange("Integration Table Mapping Name", TableMapping.Name);
                if FieldMapping.FindSet() then FieldMapping.DeleteAll();
                TableMapping.Delete();
            end;
        end;
    end;


    procedure CreateItemReference(ItemCode: Code[20]; VariantCode: Code[10]; UOMCode: Code[10]; ReferenceType: Enum "Item Reference Type"; ReferenceTypeNo: Code[20]; Description: Text[100])
    var
        ItemReference: Record "Item Reference";
        ItemReferenceNew: Record "Item Reference";
    begin
        ItemReference.Reset();
        ItemReference.SetRange("Item No.", ItemCode);
        ItemReference.SetRange("Variant Code", VariantCode);
        ItemReference.SetRange("Unit of Measure", UOMCode);
        ItemReference.SetRange("Reference Type", ReferenceType);
        ItemReference.SetRange("Reference Type No.", ReferenceTypeNo);
        if not ItemReference.FindFirst() then begin
            ItemReferenceNew.Init();
            ItemReferenceNew."Item No." := ItemCode;
            ItemReferenceNew."Variant Code" := VariantCode;
            ItemReferenceNew."Unit of Measure" := UOMCode;
            if ReferenceType = ItemReferenceNew."Reference Type"::Customer then
                ItemReferenceNew."Reference Type" := ItemReferenceNew."Reference Type"::Customer;
            if ReferenceType = ItemReferenceNew."Reference Type"::Vendor then
                ItemReferenceNew."Reference Type" := ItemReferenceNew."Reference Type"::Vendor;
            ItemReferenceNew."Reference Type No." := ReferenceTypeNo;
            ItemReferenceNew."Reference No." := StrSubstNo('%1%2%3', ItemCode, VariantCode, UOMCode);
            ItemReferenceNew.Description := Description;
            ItemReferenceNew.Insert();
        end
        else
            if ItemReference.Description <> Description then begin
                ItemReference.Description := Description;
                ItemReference.Modify();
            end;
    end;

    var
        Delte_gBln: Boolean;
        DeleteMDM_gBln: Boolean;
        ItemRefereType_Enum: Enum "Item Reference Type";
}