page 58245 "Item Comp Wise Inventory temp"//T12370-Full Comment     //T13413-Full UnComment
{
    PageType = ListPart;
    Editable = false;
    SourceTable = ItemVarCompanywise;
    Caption = 'Consolidated Inventory';

    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;
    RefreshOnActivate = true;
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            group("Inventory Details")
            {

                field(TotalInventory1; TotalInventory1)
                {
                    ApplicationArea = all;
                    Caption = 'Total Inventory';
                }
                field(TotalSalesReservedQty; TotalSalesReservedQty)
                {
                    ApplicationArea = all;
                    Caption = 'Sales Reserved Qty';
                }
                field(TotalProductionReserverd; TotalProductionReserverd)
                {
                    ApplicationArea = all;
                    Caption = 'Production Reserved Qty.';
                }
                field(TotalAvailableInventory; TotalAvailableInventory)
                {
                    ApplicationArea = all;
                    Caption = 'Available Qty.';
                    Style = Strong;
                    StyleExpr = true;
                }
            }
            repeater(GroupName)
            {
                Caption = 'Inventory Details';
                field(Company; Rec.CompanyName)
                {
                    ApplicationArea = All;
                    Width = 2;
                }
                field(VariantCode; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    Width = 2;
                    Caption = 'Variant Code';
                    // Visible = QCVisible;
                }

                field(Inventory; Rec.Inventory)
                {
                    ApplicationArea = all;
                    Width = 5;
                }
                field(SalesReservedQty; Rec."Sales Reserved")
                {
                    ApplicationArea = all;
                    Width = 5;
                    Caption = 'Sales Reserved';
                }
                field(ProductionReserved; Rec."Production Reserved")
                {
                    ApplicationArea = all;
                    Width = 5;
                    Caption = 'Production Reserved';
                }
                field("QC Blocked"; Rec.BlockedQty)
                {
                    ApplicationArea = All;
                    Width = 2;
                    Caption = 'QC Blocked';

                }
                field(AvailableInventory; Rec."Available Inventory")
                {
                    ApplicationArea = all;
                    Width = 5;
                    Style = Strong;
                    StyleExpr = true;
                    Caption = 'Available Inventory';
                }
            }
        }
    }
    #region allProcedures
    local procedure OnOpenInventoryPage(ItemNo: Code[20])
    var
        CompanyRec: Record Company;
        ItemVariant: Record "Item Variant";
        ItemRec: Record item;
        ILE: Record "Item Ledger Entry";
        ReservervationEntry: Record "Reservation Entry";
        RecShortName: Record "Company Short Name";
        CompanyRec1: Record Company;
        VarBlockedQty: Decimal;

    begin
        Clear(TotalInventory);
        Clear(TotalSalesReservedQty);
        Clear(TotalProductionReserverd);
        Clear(TotalAvailableInventory);
        Clear(TotalInventory1);

        Rec.DeleteAll();
        Rec."Item No." := ItemNo;
        if CompanyRec.FindSet() then
            repeat
                CompanyShortName.SetRange(Name, CompanyRec.Name);
                CompanyShortName.SetRange("Block in Reports", false);
                if CompanyShortName.FindFirst() then begin
                    ILE.ChangeCompany(CompanyRec.Name);
                    ILE.SetRange("Item No.", rec."Item No.");
                    ILE.SetFilter("Variant Code", '%1', '');
                    ILE.SetFilter("Remaining Quantity", '<>0');
                    ILE.CalcSums("Remaining Quantity");
                    TotalInventory := ILE."Remaining Quantity";
                    if TotalInventory <> 0 then begin
                        Rec.Init();
                        Rec.CompanyName := CompanyShortName."Short Name";


                        Rec."Item No." := Rec."Item No.";

                        Rec."Variant Code" := '';

                        Rec.Inventory := TotalInventory;
                        // Rec.Inventory := TotalInventory;

                        TotalInventory1 := TotalInventory1 + TotalInventory;

                        Rec."Production Reserved" := ProductionReservedCal('', CompanyRec.Name);
                        //Rec."Production Reserved" := Rec."Production Reserved";

                        Rec."Sales Reserved" := SalesReservedCal('', CompanyRec.Name);
                        //Rec."Sales Reserved" := Rec."Sales Reserved";

                        Rec.BlockedQty := BlockedQtyCal('', CompanyRec.Name);
                        //Rec.BlockedQty := Rec.BlockedQty;

                        Rec."Available Inventory" := Rec.Inventory - Rec."Production Reserved" - Rec."Sales Reserved";
                        Rec.Insert();
                    end;

                    ItemVariant.ChangeCompany(CompanyRec.Name);
                    ItemVariant.SetRange("Item No.", Rec."Item No.");
                    if ItemVariant.FindSet() then
                        repeat
                            if userSetup.get(UserId) then
                                if userSetup."Show Blocked Variant Inventory" = true then
                                    ItemVariant.SetRange(Blocked1)
                                else
                                    ItemVariant.SetRange(Blocked1, false);

                            TotalInventory := 0;
                            VarBlockedQty := 0;

                            ILE.ChangeCompany(CompanyRec.Name);
                            ILE.SetRange("Item No.", rec."Item No.");
                            ILE.SetRange("Variant Code", ItemVariant.Code);
                            ILE.SetFilter("Remaining Quantity", '<>0');
                            ILE.CalcSums("Remaining Quantity");
                            TotalInventory := ILE."Remaining Quantity";

                            if TotalInventory <> 0 then begin
                                Rec.Init();
                                Rec.CompanyName := CompanyShortName."Short Name";
                                // Rec.CompanyName := Rec.CompanyName;

                                Rec."Item No." := Rec."Item No.";
                                Rec."Variant Code" := ItemVariant.Code;
                                //Rec."Variant Code" := ItemVariant.code;

                                Rec.Inventory := TotalInventory;
                                //Rec.Inventory := TotalInventory;


                                TotalInventory1 := TotalInventory1 + TotalInventory;

                                Rec."Production Reserved" := ProductionReservedCal(ItemVariant.Code, CompanyRec.Name);
                                Rec."Sales Reserved" := SalesReservedCal(ItemVariant.code, CompanyRec.name);
                                Rec.BlockedQty := BlockedQtyCal(ItemVariant.Code, CompanyRec.Name);

                                Rec."Available Inventory" := Rec.Inventory - Rec."Production Reserved" - Rec."Sales Reserved";

                                //TotalAvailableInventory
                                Rec.Insert();
                            end;
                        until ItemVariant.Next() = 0;
                end;

            until CompanyRec.Next() = 0;

        TotalAvailableInventory := TotalInventory1 - TotalProductionReserverd - TotalSalesReservedQty;
    end;

    local procedure BlockedQtyCal(VarCode: Code[50]; CompanyName: Text[30]) BlockedQtyVar: Decimal
    begin

        LotInformation.ChangeCompany(CompanyName);
        LotInformation.SetRange("Item No.", Rec."Item No.");
        LotInformation.SetRange("Variant Code", VarCode);
        LotInformation.SetRange(Blocked, true);
        if LotInformation.FindFirst() then begin
            LotInformation.CalcFields(Inventory);
            BlockedQtyVar := LotInformation.Inventory;
        end;
        exit(BlockedQtyVar);
    end;

    local procedure ProductionReservedCal(VarCode: Code[50]; CompanyName: Text[30]) ProductionReserve: Decimal
    var
        ILE: Record "Item Ledger Entry";
    begin
        ILE.ChangeCompany(CompanyName);
        ILE.SetRange("Item No.", rec."Item No.");
        ILE.SetRange("Variant Code", VarCode);
        ILE.SetFilter("Remaining Quantity", '<>0');
        ILE.CalcSums("Remaining Quantity");
        ILE.SetRange("Production Warehouse", true);
        ILE.CalcSums("Remaining Quantity");
        if Ile."Remaining Quantity" <> 0 then
            ProductionReserve := ILE."Remaining Quantity";

        TotalProductionReserverd := TotalProductionReserverd + ProductionReserve;
        exit(ProductionReserve);

    end;

    local procedure SalesReservedCal(VarCode: Code[50]; CompanyName: Text[30]) SalesReserver: Decimal
    var
        ReservervationEntry: Record "Reservation Entry";
    begin
        ReservervationEntry.Reset();
        ReservervationEntry.ChangeCompany(CompanyName);
        ReservervationEntry.SetRange("Reservation Status", ReservervationEntry."Reservation Status"::Reservation);
        ReservervationEntry.SetRange("Source Type", 32);
        ReservervationEntry.SetRange("Item No.", Rec."Item No.");
        ReservervationEntry.SetRange("Source Subtype", 0);
        ReservervationEntry.SetRange(Positive, true);
        ReservervationEntry.SetRange("Variant Code", VarCode);
        ReservervationEntry.CalcSums("Quantity (Base)");
        SalesReserver := Abs(ReservervationEntry."Quantity (Base)");
        TotalSalesReservedQty := TotalSalesReservedQty + SalesReserver;

        exit(salesReserver);

    end;

    internal procedure LoadConsolidatedInvtData(ItemNo: Code[20])
    begin
        OnOpenInventoryPage(ItemNo);
        CurrPage.Update(false);
    end;
    #endregion allProcedures
    #region globalVar
    var
        TotalInventory: Decimal;
        TotalInventory1: Decimal;
        CompanyShortName: Record "Company Short Name";
        TotalSalesReservedQty: Decimal;
        TotalProductionReserverd: Decimal;
        TotalAvailableInventory: Decimal;
        VariantCode: Record "Item Variant";
        codvar: Code[50];
        LotInformation: Record 6505;
        QCVisible: Boolean;
        userSetup: Record "User Setup";
        ILE1: Record "Item Ledger Entry";
        page778: page "Customer Statistics";
    #endregion globalVar
}
