page 50458 "Item Company Wise Inventory"//T12370-Full Comment    //T13413-Full UnComment
{
    PageType = ListPart;
    Editable = false;
    SourceTable = "Item Company Block";
    // SourceTableTemporary = true;
    Caption = 'Consolidated Inventory';
    SourceTableView = where("Company Blocked" = const(false));
    DeleteAllowed = false;
    ModifyAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group("Inventory Details")
            {
                // field("Item No."; rec."Item No.")
                // {
                //     ApplicationArea = all;
                // }
                field(TotalInventory; TotalInventory)
                {
                    ApplicationArea = all;
                    Caption = 'Total Inventory  ';

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
                field(Company; CompanyShortName."Short Name")
                {
                    ApplicationArea = All;
                    Width = 2;
                }
                field(Inventory; Inventory)
                {
                    ApplicationArea = all;
                    Width = 5;
                }
                field(SalesReservedQty; SalesReservedQty)
                {
                    ApplicationArea = all;
                    Width = 5;
                    Caption = 'Sales Reserved';
                }
                field(ProductionReserved; ProductionReserved)
                {
                    ApplicationArea = all;
                    Width = 5;
                    Caption = 'Production Reserved';
                }
                field(AvailableInventory; AvailableInventory)
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
    trigger OnOpenPage()
    var
        myInt: Integer;
        COde1: Code[10];
        CompanyRec: Record Company;
        ItemRec: Record item;
    begin

    end;

    trigger OnAfterGetRecord()
    var
        CompanyRec: Record Company;
        ItemRec: Record item;
        ILE: Record "Item Ledger Entry";
        ReservervationEntry: Record "Reservation Entry";
        RecShortName: Record "Company Short Name";//20MAY2022
    begin
        Clear(Inventory);
        Clear(TotalInventory);
        Clear(TotalSalesReservedQty);
        Clear(ProductionReserved);
        Clear(SalesReservedQty);
        Clear(TotalAvailableInventory);
        Clear(TotalProductionReserverd);
        Clear(TotalSalesReservedQty);

        if CompanyShortName.Get(Rec.Company) then;

        ILE.Reset();
        ILE.ChangeCompany(Rec.Company);
        ile.SetRange("Item No.", Rec."Item No.");
        ILE.SetFilter("Remaining Quantity", '<>0');
        ile.CalcSums("Remaining Quantity");
        Inventory := ILE."Remaining Quantity";
        ILE.SetRange("Production Warehouse", true);
        ILE.CalcSums("Remaining Quantity");
        ProductionReserved := ILE."Remaining Quantity";

        ReservervationEntry.Reset();
        ReservervationEntry.ChangeCompany(Rec.Company);
        ReservervationEntry.SetRange("Reservation Status", ReservervationEntry."Reservation Status"::Reservation);
        ReservervationEntry.SetRange("Source Type", 32);
        ReservervationEntry.SetRange("Item No.", Rec."Item No.");
        ReservervationEntry.SetRange("Source Subtype", 0);
        ReservervationEntry.SetRange(Positive, true);
        ReservervationEntry.CalcSums("Quantity (Base)");
        SalesReservedQty := Abs(ReservervationEntry."Quantity (Base)");

        CompanyRec.SetFilter(Name, '<>%1', rec.CurrentCompany);
        repeat
            //20MAY2022-start
            Clear(RecShortName);
            RecShortName.SetRange(Name, CompanyRec.Name);
            RecShortName.SetRange("Block in Reports", true);
            if not RecShortName.FindFirst() then begin
                ReservervationEntry.Reset();
                ReservervationEntry.ChangeCompany(CompanyRec.Name);
                ReservervationEntry.SetRange("Reservation Status", ReservervationEntry."Reservation Status"::Reservation);
                ReservervationEntry.SetRange("Source Type", 32);
                ReservervationEntry.SetRange("Item No.", Rec."Item No.");
                ReservervationEntry.SetRange("Source Subtype", 0);
                ReservervationEntry.SetRange(Positive, true);
                ReservervationEntry.CalcSums("Quantity (Base)");
                TotalSalesReservedQty += Abs(ReservervationEntry."Quantity (Base)");

                ILE.Reset();
                ILE.ChangeCompany(CompanyRec.Name);
                ILE.SetRange("Item No.", rec."Item No.");
                ILE.SetFilter("Remaining Quantity", '<>0');
                ILE.CalcSums("Remaining Quantity");
                TotalInventory += ILE."Remaining Quantity";
                ILE.SetRange("Production Warehouse", true);
                ILE.CalcSums("Remaining Quantity");
                TotalProductionReserverd += ILE."Remaining Quantity";
            end;

        until CompanyRec.Next() = 0;

        AvailableInventory := Inventory - ProductionReserved - SalesReservedQty;
        TotalAvailableInventory := TotalInventory - TotalProductionReserverd - TotalSalesReservedQty;

    end;

    var
        Inventory: Decimal;
        SalesReservedQty: Decimal;
        ProductionReserved: Decimal;
        AvailableInventory: Decimal;
        TotalInventory: Decimal;
        CompanyShortName: Record "Company Short Name";
        TotalSalesReservedQty: Decimal;
        TotalProductionReserverd: Decimal;
        TotalAvailableInventory: Decimal;
}