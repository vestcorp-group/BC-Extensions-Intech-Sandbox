codeunit 80208 ParaDep_INT
{
    SingleInstance = true;

    procedure SetValue(ProdCode: Code[20]; ParaCode: Code[20])
    begin
        GlobView_ProdCode := ProdCode;
        GlobView_ParaCode := ParaCode;
    end;

    procedure GetValue(Var ProdCode: Code[20]; Var ParaCode: Code[20])
    begin
        ProdCode := GlobView_ProdCode;
        ParaCode := GlobView_ParaCode;
    end;

    var
        GlobView_ProdCode: Code[20];
        GlobView_ParaCode: Code[20];

}
