codeunit 80201 "INT Product Config SingleInst."
{
    // -----------------------------------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd. - support@intech-systems.com
    // -----------------------------------------------------------------------------------------------------------------------------
    // ID                        Date            Author
    // -----------------------------------------------------------------------------------------------------------------------------
    // 1.0.0.0                  07/04/18        Intech Systems Pvt. Ltd.
    // -----------------------------------------------------------------------------------------------------------------------------

    SingleInstance = true;

    trigger OnRun();
    begin
    end;

    var
        ProductCode: Code[20];
        AssemblyCode: Code[20];
        ParameterCode: Code[20];
        ItemCategory: Code[20];
        ProductIndustry: Code[20];
        SDate: Date;
        EDate: Date;
        ItemTypeGlobal: Option " ",Standard,"Non-Standard";

    procedure GetProductCode(): Code[20];
    begin
        EXIT(ProductCode);
    end;

    procedure GetAssemblyCode(): Code[20];
    begin
        EXIT(AssemblyCode);
    end;

    procedure GetParameterCode(): Code[20];
    begin
        EXIT(ParameterCode);
    end;

    procedure ClearValues();
    begin
        CLEAR(ProductCode);
        CLEAR(AssemblyCode);
        CLEAR(ParameterCode);
    end;

    procedure SetValues(NewProductCode: Code[20]; NewAssemblyCode: Code[20]; NewParameterCode: Code[20]);
    begin
        CLEAR(ProductCode);
        CLEAR(AssemblyCode);
        CLEAR(ParameterCode);

        ProductCode := NewProductCode;
        AssemblyCode := NewAssemblyCode;
        ParameterCode := NewParameterCode;
    end;

    procedure SetValues2(NewItemCategory: Code[20]; NewProdCode: Code[20]; StartingDate: Date; EndingDate: Date; ItemType: Option " ",Standard,"Non-Standard");
    begin
        ItemTypeGlobal := ItemType;
        ItemCategory := NewItemCategory;
        ProductIndustry := NewProdCode;
        SDate := StartingDate;
        EDate := EndingDate;
    end;

    procedure ReSetValues2();
    begin
        ItemTypeGlobal := ItemTypeGlobal::" ";
        ItemCategory := '';
        ProductIndustry := '';
        SDate := 0D;
        EDate := 0D;
    end;

    procedure GetValues2(var NewItemCategory: Code[20]; var NewProdCode: Code[20]; var StartingDate: Date; var EndingDate: Date; var ItemType: Option " ",Standard,"Non-Standard");
    begin
        ItemType := ItemTypeGlobal;
        NewItemCategory := ItemCategory;
        NewProdCode := ProductIndustry;
        StartingDate := SDate;
        EndingDate := EDate;
    end;
}

