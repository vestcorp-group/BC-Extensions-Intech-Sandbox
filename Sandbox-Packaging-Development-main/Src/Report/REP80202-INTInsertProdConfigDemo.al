report 80202 "INT Insert Pack. Config Demo"
{
    Caption = 'Insert Packaging Configurator Demo Data';
    ProcessingOnly = true;
    UsageCategory = Administration;
    ApplicationArea = all;

    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));

            trigger OnAfterGetRecord()
            begin
                IF CreateSetup THEN BEGIN
                    IF ProductConfiguratorSetup.GET() THEN
                        if ProductConfiguratorSetup."Configurator Nos." = '' then
                            InsertSetupData();
                    SetConfigTemplate();
                END;

                IF CreateItems THEN
                    InsertItems();

                IF CreateSampleProduct THEN BEGIN
                    InsertParameters();
                    InsertProducts();
                    InsertProductParameters();
                    ApproveProduct();
                END;


            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("Create Setup"; CreateSetup)
                    {
                        ApplicationArea = all;
                        Caption = 'Create Setup';
                    }
                    field("Insert Items"; CreateItems)
                    {
                        ApplicationArea = all;
                        Caption = 'Insert Items';
                    }
                    field("Create Sample Product"; CreateSampleProduct)
                    {
                        ApplicationArea = all;
                        Caption = 'Create Sample Product';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        CreateSetup := TRUE;
        CreateItems := TRUE;
        CreateSampleProduct := TRUE;
    end;

    trigger OnPostReport()
    begin
        MESSAGE('Test Data Imported');
    end;

    var
        ProductConfiguratorSetup: Record "INT Packaging Config Setup";
        CreateItems: Boolean;
        CreateSampleProduct: Boolean;
        CreateSetup: Boolean;

    local procedure InsertSetupData()
    var
        NoSeries: Record "No. Series";
    begin
        CreateNewNoSeries();
        NoSeries.GET('PCONF');
        ProductConfiguratorSetup."Configurator Nos." := NoSeries.Code;
        ProductConfiguratorSetup.Modify(true);
    end;

    local procedure CreateNewNoSeries()
    var
        NoSeries: Record "No. Series";
        NoSeriesLine: Record "No. Series Line";
    begin
        IF NOT NoSeries.GET('PCONF') THEN BEGIN
            NoSeries.INIT();
            NoSeries.Code := 'PCONF';
            NoSeries.Description := 'Packaging Configurator';
            NoSeries."Default Nos." := TRUE;
            NoSeries."Manual Nos." := TRUE;
            NoSeries.INSERT();

            NoSeriesLine.INIT();
            NoSeriesLine."Series Code" := NoSeries.Code;
            NoSeriesLine."Starting No." := 'PCONF00001';
            NoSeriesLine.INSERT();
        END;
    end;

    local procedure CreateNewNoSeriesForItem()
    var
        NoSeries: Record "No. Series";
        NoSeriesLine: Record "No. Series Line";
    begin
        IF NOT NoSeries.GET('Item1') THEN BEGIN
            NoSeries.INIT();
            NoSeries.Code := 'ITEM1';
            NoSeries.Description := 'Partially Manufactured';
            NoSeries."Default Nos." := TRUE;
            NoSeries."Manual Nos." := TRUE;
            NoSeries.INSERT();

            NoSeriesLine.INIT();
            NoSeriesLine."Series Code" := NoSeries.Code;
            NoSeriesLine."Starting No." := '70000';
            NoSeriesLine.INSERT();
        END;
    end;

    local procedure InsertItems()
    var
        UnitofMeasure: Record "Unit of Measure";
        ItemCategory: Record "Item Category";
        GenProductPostingGroup: Record "Gen. Product Posting Group";
        InventoryPostingGroup: Record "Inventory Posting Group";
    begin
        IF NOT UnitofMeasure.GET('PCS') THEN
            CreateUOM();

        IF NOT ItemCategory.GET('SUPPLIERS') THEN
            CreateItemCategory();

        IF NOT GenProductPostingGroup.GET('RETAIL') THEN
            CreateGenPordPostingGroup();

        IF NOT InventoryPostingGroup.GET('RESALE') THEN
            CreateInvPostingGroup();

        CreateItemRecord('156-FHD', '15.6 inch Full HD Display', 56, 80);
        CreateItemRecord('156-HD', '15.6 inch HD Display', 70, 100);
        CreateItemRecord('16-FHD', '16 inch Full HD Display', 91, 130);
        CreateItemRecord('16-HD', '16 inch HD Display', 80.5, 115);
        CreateItemRecord('DDR3', 'DDR 3 - 4 GB', 17.5, 25);
        CreateItemRecord('DDR4-2133', 'DDR4 2133 MHz - 8 GB', 31.5, 45);
        CreateItemRecord('DDR4-2400', 'DDR4 2400 MHz - 8 GB (H Quad Core Processor)', 42, 60);
        CreateItemRecord('DOLBY-SPEAKER', 'High Quality Dolby Speakers 10W', 35, 50);
        CreateItemRecord('G-620', 'Intel ® HD Graphics 620', 21, 30);
        CreateItemRecord('G-630', 'Intel ® HD Graphics 630 (H Quad Core Processor)', 35, 50);
        CreateItemRecord('HDD 1 TB', 'HDD 1 TB', 126, 180);
        CreateItemRecord('HD-SPEAKER', 'High Definition Speakers 5W', 70, 100);
        CreateItemRecord('I3', 'Intel - i3', 175, 250);
        CreateItemRecord('I5', 'Intel - i5', 203, 290);
        CreateItemRecord('I7-H', 'Intel - i7, H Quad Core', 256, 370);
        CreateItemRecord('I7-U', 'Intel - i7, U Dual Core', 315, 450);
        CreateItemRecord('NK-64-16', 'NeoKylin 6.0 64 bit', 14, 20);
        CreateItemRecord('NVIDIA-930', 'NVIDIA ® GeForce 930MX 64 Bit', 56, 80);
        CreateItemRecord('SSD-1TB', 'SSD 1 TB', 189, 270);
        CreateItemRecord('SSD-512', 'SSD 512 GB', 140, 200);
        CreateItemRecord('UB-16', 'Ubuntu 16.04 LTS 64-bit', 35, 50);
        CreateItemRecord('W10-64-H', 'Windows 10 Home 64 bit', 56, 80);
        CreateItemRecord('W10-64-P', 'Windows 10 Pro 64 bit', 70, 100);
    end;

    local procedure CreateItemRecord(ItemNo: Code[20]; ItemDescp: Text[50]; UnitCost: Decimal; UnitPrice: Decimal)
    var
        Item: Record Item;
    begin
        IF NOT Item.GET(ItemNo) THEN BEGIN
            Item.INIT();
            Item.VALIDATE("No.", ItemNo);
            Item.VALIDATE(Description, ItemDescp);
            Item.INSERT(TRUE);
            Item.VALIDATE("Base Unit of Measure", 'PCS');
            Item.VALIDATE("Item Category Code", 'SUPPLIERS');
            Item.VALIDATE("Gen. Prod. Posting Group", 'RETAIL');
            Item.VALIDATE("Inventory Posting Group", 'RESALE');
            Item.VALIDATE("Unit Cost", UnitCost);
            Item.VALIDATE("Unit Price", UnitPrice);
            Item.MODIFY(TRUE);
        END;
    end;

    local procedure CreateUOM()
    var
        UnitofMeasure: Record "Unit of Measure";
    begin
        UnitofMeasure.INIT();
        UnitofMeasure.VALIDATE(Code, 'PCS');
        UnitofMeasure.VALIDATE(Description, 'Piece');
        UnitofMeasure.INSERT(TRUE);
    end;

    local procedure CreateItemCategory()
    var
        ItemCategory: Record "Item Category";
    begin
        ItemCategory.INIT();
        ItemCategory.VALIDATE(Code, 'SUPPLIERS');
        ItemCategory.VALIDATE(Description, 'Office Supplies');
        ItemCategory.INSERT(TRUE);
    end;

    local procedure CreateGenPordPostingGroup()
    var
        GenProductPostingGroup: Record "Gen. Product Posting Group";
    begin
        GenProductPostingGroup.INIT();
        GenProductPostingGroup.VALIDATE(Code, 'RETAIL');
        GenProductPostingGroup.VALIDATE(Description, 'Retail');
        GenProductPostingGroup.INSERT(TRUE);

    end;

    local procedure CreateInvPostingGroup()
    var
        InventoryPostingGroup: Record "Inventory Posting Group";
    begin
        InventoryPostingGroup.INIT();
        InventoryPostingGroup.VALIDATE(Code, 'RESALE');
        InventoryPostingGroup.VALIDATE(Description, 'Resale items');
        InventoryPostingGroup.INSERT(TRUE);

    end;

    local procedure InsertParameters()
    begin
        CreateParameter('HARD-DRIVE', 'Hard Drives', 'PCS');
        CreateParameterValues('HARD-DRIVE', 'HDD-1TB', 10000, 'HDD 1 TB');
        CreateParameterValues('HARD-DRIVE', 'SSD-512', 20000, 'SSD 512 GB');
        CreateParameterValues('HARD-DRIVE', 'SSD-1TB', 30000, 'SSD 1 TB');

        CreateParameter('SCREEN-TYPE', 'Screen Types', 'PCS');
        CreateParameterValues('SCREEN-TYPE', '156-HD', 10000, '15.6 inch HD Display');
        CreateParameterValues('SCREEN-TYPE', '156-FHD', 20000, '15.6 inch Full HD Display');
        CreateParameterValues('SCREEN-TYPE', '16-HD', 30000, '16 inch HD Display');
        CreateParameterValues('SCREEN-TYPE', '16-FHD', 40000, '16 inch Full HD Display');

        CreateParameter('MEMORY', 'Computer Memory', 'PCS');
        CreateParameterValues('MEMORY', 'DDR3', 10000, 'DDR 3 - 4GB');
        CreateParameterValues('MEMORY', 'DDR4-2133', 20000, 'DDR4 2133 MHz - 8GB');
        CreateParameterValues('MEMORY', 'DDR4-2400', 30000, 'DDR4 2400 MHz - 8GB(H Quad Core Processor)');

        CreateParameter('INTEL-PROCESSOR', 'Intel Processors', 'PCS');
        CreateParameterValues('INTEL-PROCESSOR', 'I3', 10000, 'Intel - i3');
        CreateParameterValues('INTEL-PROCESSOR', 'I5', 20000, 'Intel - i5');
        CreateParameterValues('INTEL-PROCESSOR', 'I7-U', 30000, 'Intel - i7,U Dual Core');
        CreateParameterValues('INTEL-PROCESSOR', 'I7-H', 40000, 'Intel - i7,U Quad Core');

        CreateParameter('MULTIMEDIA', 'Multimedia Options', 'PCS');
        CreateParameterValues('MULTIMEDIA', 'HD-SPEAKER', 10000, 'High Defination Speakers 5W');
        CreateParameterValues('MULTIMEDIA', 'DOLBY-SPEAKER', 20000, 'High Quality Dolby Speakers 10W');


        CreateParameter('OP-SYS', 'Computer Operating Systems', 'PCS');
        CreateParameterValues('OP-SYS', 'W10-64-P', 10000, 'Windows 10 Pro 64 bit');
        CreateParameterValues('OP-SYS', 'W10-64-H', 20000, 'Windows 10 Home 64 bit');
        CreateParameterValues('OP-SYS', 'UB-16', 30000, 'ubuntu 16.04 LTS 64 bit');
        CreateParameterValues('OP-SYS', 'NK-64-16', 40000, 'NeoKylin 6.0 64 bit');

        CreateParameter('V-CARD', 'Video Card', 'PCS');
        CreateParameterValues('V-CARD', 'G-620', 10000, 'Intel HD Graphics 620');
        CreateParameterValues('V-CARD', 'G-630', 20000, 'Intel HD Graphics 630(H Quad Code Processor)');
        CreateParameterValues('V-CARD', 'NVIDI-930', 30000, 'NVIDIA GeForce 930MX 64 Bit');
    end;

    local procedure CreateParameter(ParameterCode: Code[20]; Description: Text[50]; UOM: Code[10])
    var
        INTParameter: Record "INT Packaging Parameter";
    begin
        IF NOT INTParameter.GET(ParameterCode) THEN BEGIN
            INTParameter.INIT();
            INTParameter.VALIDATE("Packaging Parameter Code", ParameterCode);
            INTParameter.VALIDATE("Packaging Parameter Description", Description);
            INTParameter.INSERT(TRUE);
        END;
    end;

    local procedure CreateParameterValues(ParameterCode: Code[20]; ParameterValue: Code[20]; LineNo: Integer; ParameterValueDescription: Text[50])
    var
        INTParameterValues: Record "INT Packaging Parameter Values";
    begin
        IF NOT INTParameterValues.GET(ParameterCode, ParameterValue, LineNo) THEN BEGIN
            INTParameterValues.INIT();
            INTParameterValues.VALIDATE("Packaging Parameter Code", ParameterCode);
            INTParameterValues.VALIDATE("Packaging Parameter Value", ParameterValue);
            INTParameterValues.VALIDATE("Line No.", LineNo);
            INTParameterValues.VALIDATE("Packaging Parameter Value Description", ParameterValueDescription);
            INTParameterValues.INSERT(TRUE);
        END;
    end;

    local procedure SetConfigTemplate()
    var
        ConfigTemplateHeader: Record "Config. Template Header";
    begin
        ConfigTemplateHeader.RESET();
        ConfigTemplateHeader.SETRANGE("Table ID", 27);
        ConfigTemplateHeader.SETRANGE(Code, 'ITEM000005');
        IF ConfigTemplateHeader.FINDFIRST() THEN BEGIN
            ConfigTemplateHeader.MODIFY();
        END ELSE BEGIN
            ConfigTemplateHeader.INIT();
            ConfigTemplateHeader.VALIDATE(Code, 'ITEM000005');
            ConfigTemplateHeader.VALIDATE(Description, 'Misc');
            ConfigTemplateHeader.VALIDATE("Table ID", 27);
            ConfigTemplateHeader.VALIDATE(Enabled, TRUE);
            ConfigTemplateHeader.INSERT();
        END
    end;

    local procedure InsertProducts()
    begin
        CreateProduct('LAPTOP', 'Business Laptop');

        CreateProductAssembly('LAPTOP', 'PROCESSOR', 'Processor');
        CreateProductAssembly('LAPTOP', 'OPERATING SYSTEM', 'OPERATING SYSTEM');
        CreateProductAssembly('LAPTOP', 'MEMORY', 'MEMORY');
        CreateProductAssembly('LAPTOP', 'VIDEO CARD', 'VIDEO CARD');
        CreateProductAssembly('LAPTOP', 'DISPLAY', 'DISPLAY');
        CreateProductAssembly('LAPTOP', 'HARD DRIVE', 'HARD DRIVE');
        CreateProductAssembly('LAPTOP', 'MULTIMEDIA', 'MULTIMEDIA');
    end;

    local procedure CreateProduct(ProductCode: Code[20]; ProductDescription: Text[50])
    var
        INTProducts: Record "INT Packaging";
        NoSeries: Record "No. Series";
    begin
        IF NOT INTProducts.GET(ProductCode) THEN BEGIN
            INTProducts.INIT();
            INTProducts.VALIDATE("Product Code", ProductCode);
            INTProducts.VALIDATE("Product Description", ProductDescription);

            CreateNewNoSeriesForItem();

            INTProducts.INSERT(TRUE);
        END;
    end;

    local procedure CreateProductAssembly(ProductCode: Code[20]; AssemblyCode: Code[20]; AssemblyDescription: Text[50])
    var
        INTProductAssembly: Record "INT Packaging Assembly";
    begin
        IF NOT INTProductAssembly.GET(ProductCode, AssemblyCode) THEN BEGIN
            INTProductAssembly.INIT();
            INTProductAssembly.VALIDATE("Product Code", ProductCode);
            INTProductAssembly.VALIDATE("Assembly Code", AssemblyCode);
            INTProductAssembly.VALIDATE("Assembly Description", AssemblyDescription);
            INTProductAssembly.INSERT(TRUE);
        END;
    end;

    procedure InsertProductParameters()
    begin
        CreateProductParameter('LAPTOP', 'PROCESSOR', 'INTEL-PROCESSOR', 'Intel Processors');
        CreateProductParameter('LAPTOP', 'OPERATING SYSTEM', 'OP-SYS', 'Computer Operating Systems');
        CreateProductParameter('LAPTOP', 'MEMORY', 'MEMORY', 'Computer Memory');
        CreateProductParameter('LAPTOP', 'VIDEO CARD', 'V-CARD', 'Video Card');
        CreateProductParameter('LAPTOP', 'DISPLAY', 'SCREEN-TYPE', 'Screen Types');
        CreateProductParameter('LAPTOP', 'HARD DRIVE', 'HARD-DRIVE', 'Hard Drives');
        CreateProductParameter('LAPTOP', 'MULTIMEDIA', 'MULTIMEDIA', 'Multimedia Options');
    end;

    procedure CreateProductParameter(ProductCode: Code[20]; AssemblyCode: Code[20]; ParameterCode: Code[20]; ParameterDescription: Text[50])
    var
        INTProductParameters: Record "INT Packaging Parameters";
    begin
        IF NOT INTProductParameters.GET(ProductCode, ParameterCode) THEN BEGIN
            INTProductParameters.INIT();
            INTProductParameters.VALIDATE("Product Code", ProductCode);
            INTProductParameters.VALIDATE("Assembly Code", AssemblyCode);
            INTProductParameters.VALIDATE("Parameter Code", ParameterCode);
            INTProductParameters.VALIDATE("Parameter Description", ParameterDescription);
            INTProductParameters.INSERT(TRUE);

            CreateProductDependencyValues(ProductCode, ParameterCode, AssemblyCode);

            IF INTProductParameters."Serial No." = 4 THEN
                CreateProductDependency(TRUE, FALSE, ProductCode, ParameterCode);

            IF INTProductParameters."Serial No." = 5 THEN
                CreateProductDependency(FALSE, TRUE, ProductCode, ParameterCode);
        END;
    end;

    procedure CreateProductDependency(FirstDependency: Boolean; SecondDependency: Boolean; ProductCode: Code[20]; ParameterCode: Code[20])
    var
        INTProductParamDependency: Record "INT Packaging Param Dependency";
        INTProductParametersLocal: Record "INT Packaging Parameters";
    begin
        CASE TRUE OF
            FirstDependency:
                BEGIN
                    INTProductParametersLocal.RESET();
                    INTProductParametersLocal.SETRANGE("Product Code", ProductCode);
                    INTProductParametersLocal.SETFILTER("Serial No.", '%1..%2', 1, 2);
                    IF INTProductParametersLocal.FINDSET() THEN
                        REPEAT
                            INTProductParamDependency.INIT();
                            INTProductParamDependency.VALIDATE("Product Code", INTProductParametersLocal."Product Code");
                            INTProductParamDependency.VALIDATE("Parameter Code", ParameterCode);
                            INTProductParamDependency.VALIDATE("Parameter Depend On", INTProductParametersLocal."Parameter Code");
                            INTProductParamDependency.VALIDATE("Parameter Serial", 4);
                            INTProductParamDependency.VALIDATE("Parameter Depend On Serial", INTProductParametersLocal."Serial No.");
                            INTProductParamDependency.INSERT(TRUE);
                        UNTIL INTProductParametersLocal.NEXT() = 0;
                END;
            SecondDependency:
                BEGIN
                    INTProductParametersLocal.RESET();
                    INTProductParametersLocal.SETRANGE("Product Code", ProductCode);
                    INTProductParametersLocal.SETFILTER("Serial No.", '%1', 1);
                    IF INTProductParametersLocal.FINDSET() THEN
                        REPEAT
                            INTProductParamDependency.INIT();
                            INTProductParamDependency.VALIDATE("Product Code", INTProductParametersLocal."Product Code");
                            INTProductParamDependency.VALIDATE("Parameter Code", ParameterCode);
                            INTProductParamDependency.VALIDATE("Parameter Depend On", INTProductParametersLocal."Parameter Code");
                            INTProductParamDependency.VALIDATE("Parameter Serial", 5);
                            INTProductParamDependency.VALIDATE("Parameter Depend On Serial", INTProductParametersLocal."Serial No.");
                            INTProductParamDependency.INSERT(TRUE);
                        UNTIL INTProductParametersLocal.NEXT() = 0;
                END;
        END;
    end;

    procedure CreateProductDependencyValues(ProductCode: Code[20]; ParameterCode: Code[20]; AssemblyCode: Code[20])
    var
        INTProductParamRelationship: Record "INT Pack Param Relationship";
        INTProductParametersLocal: Record "INT Packaging Parameters";
        INTParameterValuesLocal: Record "INT Packaging Parameter Values";
        ParentCount: Integer;
    begin
        ParentCount := 1;
        INTProductParametersLocal.RESET();
        INTProductParametersLocal.SETRANGE("Product Code", ProductCode);
        INTProductParametersLocal.SETRANGE("Parameter Code", ParameterCode);
        INTProductParametersLocal.SETRANGE("Assembly Code", AssemblyCode);
        IF INTProductParametersLocal.FINDSET() THEN
            REPEAT
                INTParameterValuesLocal.RESET();
                INTParameterValuesLocal.SETRANGE("Packaging Parameter Code", ParameterCode);
                IF INTParameterValuesLocal.FINDSET() THEN
                    REPEAT
                        INTProductParamRelationship.INIT();
                        INTProductParamRelationship.VALIDATE("Product Code", ProductCode);
                        INTProductParamRelationship.VALIDATE("Parameter Code", ParameterCode);

                        INTProductParamRelationship.VALIDATE("Parameter Value", INTParameterValuesLocal."Packaging Parameter Value");
                        INTProductParamRelationship.VALIDATE("Parameter Value Description", INTParameterValuesLocal."Packaging Parameter Value Description");
                        CreateItemRecord(INTParameterValuesLocal."Packaging Parameter Value", INTParameterValuesLocal."Packaging Parameter Value Description", 10, 10);
                        INTProductParamRelationship.VALIDATE("Product Assembly Code", AssemblyCode);

                        IF INTProductParametersLocal."Serial No." = 4 THEN
                            CreateProductDependencyValuesforDependent(INTProductParamRelationship, ParentCount, 4);

                        IF INTProductParametersLocal."Serial No." = 5 THEN
                            CreateProductDependencyValuesforDependent(INTProductParamRelationship, ParentCount, 5);

                        ParentCount += 1;

                        INTProductParamRelationship.INSERT(TRUE);
                    UNTIL INTParameterValuesLocal.NEXT() = 0;
            UNTIL INTProductParametersLocal.NEXT() = 0;
    END;

    procedure CreateProductDependencyValuesforDependent(var INTProductParamRelationship: Record "INT Pack Param Relationship"; ParentCount: Integer; SerialNo: Integer)
    var
        INTProductParametersLocal: Record "INT Packaging Parameters";
        INTParameterValuesLocal: Record "INT Packaging Parameter Values";
        RecCount: Integer;
    begin
        INTProductParametersLocal.RESET();
        INTProductParametersLocal.SETRANGE("Product Code", INTProductParamRelationship."Product Code");
        IF SerialNo = 5 THEN
            INTProductParametersLocal.SETRANGE("Serial No.", 1);
        IF SerialNo = 4 THEN
            INTProductParametersLocal.SETFILTER("Serial No.", '%1..%2', 1, 2);

        IF INTProductParametersLocal.FINDSET() THEN
            REPEAT
                RecCount := 1;
                INTParameterValuesLocal.RESET();
                INTParameterValuesLocal.SETRANGE("Packaging Parameter Code", INTProductParametersLocal."Parameter Code");
                IF INTParameterValuesLocal.FINDSET() THEN
                    REPEAT
                        IF RecCount = ParentCount THEN
                            IF INTProductParametersLocal."Serial No." = 1 THEN BEGIN
                                INTProductParamRelationship.VALIDATE("Parameter 1", INTParameterValuesLocal."Packaging Parameter Value");
                                INTProductParamRelationship.VALIDATE("Parameter 1 Description", INTParameterValuesLocal."Packaging Parameter Value Description");
                            END ELSE
                                IF INTProductParametersLocal."Serial No." = 2 THEN BEGIN
                                    INTProductParamRelationship.VALIDATE("Parameter 2", INTParameterValuesLocal."Packaging Parameter Value");
                                    INTProductParamRelationship.VALIDATE("Parameter 2 Description", INTParameterValuesLocal."Packaging Parameter Value Description");
                                END;
                        RecCount += 1;
                    UNTIL INTParameterValuesLocal.NEXT() = 0;
            UNTIL INTProductParametersLocal.NEXT() = 0;
    END;

    procedure ApproveProduct()
    var
        Product: Record "INT Packaging";
    begin
        Product.Reset();
        Product.SetRange("Product Code", 'LAPTOP');
        if Product.FindFirst() then begin
            Product.Validate(Approved, true);
            Product.Modify();
        end;
    end;
}

