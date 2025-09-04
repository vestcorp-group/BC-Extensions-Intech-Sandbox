codeunit 50100 ControlAccess_V2
{
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;

    [EventSubscriber(ObjectType::Page, Page::"Customer List", 'OnOpenPageEvent', '', true, true)]
    local procedure CustomerAccessControl(var Rec: Record Customer)
    var
        UserSetupRec: Record "User Setup";
        SPFilter: Code[20];
    begin
        if UserSetupRec.Get(UserId) then;

        if UserSetupRec."Sales Support User" then
            exit else begin
            if UserSetupRec."Salespers./Purch. Code" <> '' then begin
                Rec.FilterGroup(2);
                Rec.SetFilter("Salesperson Code", GetSalespersonRegionFilter1(UserSetupRec."Salespers./Purch. Code"));
                Rec.FilterGroup(0);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Customer Lookup", 'OnOpenPageEvent', '', true, true)]
    local procedure CustomerLookupAccesscontrol(var Rec: Record Customer)
    var
        UserSetupRec: Record "User Setup";
    begin
        if UserSetupRec.Get(UserId) then;
        if UserSetupRec."Sales Support User" then
            exit else begin
            if UserSetupRec."Salespers./Purch. Code" <> '' then begin
                Rec.FilterGroup(2);
                Rec.SetFilter("Salesperson Code", GetSalespersonRegionFilter1(UserSetupRec."Salespers./Purch. Code"));
                Rec.FilterGroup(0);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Blanket Sales Orders", 'OnOpenPageEvent', '', true, true)]
    local procedure BSOAccessControl(var Rec: Record "Sales Header")
    var
        UserSetupRec: Record "User Setup";
        SPfilter: Code[20];
        Blank: Code[20];
    begin
        //45560-OS
        // if UserSetupRec.Get(UserId) then;
        // if UserSetupRec."Sales Support User" then
        //     exit else begin
        //     if UserSetupRec."Salespers./Purch. Code" <> '' then begin
        //         Rec.FilterGroup(2);
        //         Rec.SetFilter("Salesperson Code", GetSalespersonRegionFilter1(UserSetupRec."Salespers./Purch. Code"));
        //         Rec.FilterGroup(0);
        //     end;
        // end;
        //45560-OE
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order List", 'OnOpenPageEvent', '', true, true)]
    local procedure SOAccessControl(var Rec: Record "Sales Header")
    var
        UserSetupRec: Record "User Setup";
    begin
        if UserSetupRec.Get(UserId) then;
        if UserSetupRec."Sales Support User" then
            exit else begin
            if UserSetupRec."Salespers./Purch. Code" <> '' then begin
                Rec.FilterGroup(2);
                Rec.SetFilter("Salesperson Code", GetSalespersonRegionFilter1(UserSetupRec."Salespers./Purch. Code"));
                Rec.FilterGroup(0);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Shipments", 'OnOpenPageEvent', '', true, true)]
    local procedure SalesShipmentAccessControl(var Rec: Record "Sales Shipment Header")
    var
        UserSetupRec: Record "User Setup";
    begin
        if UserSetupRec.Get(UserId) then;

        if UserSetupRec."Sales Support User" then
            exit else begin
            if UserSetupRec."Salespers./Purch. Code" <> '' then begin
                Rec.FilterGroup(2);
                Rec.SetFilter("Salesperson Code", GetSalespersonRegionFilter1(UserSetupRec."Salespers./Purch. Code"));
                Rec.FilterGroup(0);
            end;
        end;

        // Rec.FilterGroup(2);
        // Rec.SetFilter("Customer Group Code", GetSalespersonRegionFilter1(UserSetupRec."Salespers./Purch. Code"));
        // Rec.FilterGroup(0);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Credit Memos", 'OnOpenPageEvent', '', true, true)]
    local procedure SalesCreditMemoAccessControl(var Rec: Record "Sales Header")
    var
        UserSetupRec: Record "User Setup";
    begin
        if UserSetupRec.Get(UserId) then;
        if UserSetupRec."Sales Support User" then
            exit else begin
            if UserSetupRec."Salespers./Purch. Code" <> '' then begin
                Rec.FilterGroup(2);
                Rec.SetFilter("Salesperson Code", GetSalespersonRegionFilter1(UserSetupRec."Salespers./Purch. Code"));
                Rec.FilterGroup(0);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Credit Memos", 'OnOpenPageEvent', '', true, true)]
    local procedure PostedSalesCreditMemoAccessControl(var Rec: Record "Sales Cr.Memo Header")
    var
        UserSetupRec: Record "User Setup";
    begin
        if UserSetupRec.Get(UserId) then;
        if UserSetupRec."Sales Support User" then
            exit else begin
            if UserSetupRec."Salespers./Purch. Code" <> '' then begin
                Rec.FilterGroup(2);
                Rec.SetFilter("Salesperson Code", GetSalespersonRegionFilter1(UserSetupRec."Salespers./Purch. Code"));
                Rec.FilterGroup(0);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Posted Return Receipts", 'OnOpenPageEvent', '', true, true)]
    local procedure ReturnReceiptsAccessControl(var Rec: Record "Return Receipt Header")
    var
        UserSetupRec: Record "User Setup";
    begin
        if UserSetupRec.Get(UserId) then;
        if UserSetupRec."Sales Support User" then
            exit else begin
            if UserSetupRec."Salespers./Purch. Code" <> '' then begin
                Rec.FilterGroup(2);
                Rec.SetFilter("Salesperson Code", GetSalespersonRegionFilter1(UserSetupRec."Salespers./Purch. Code"));
                Rec.FilterGroup(0);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Return Order List", 'OnOpenPageEvent', '', true, true)]
    local procedure SalesReturnOrdersAccessControl(var Rec: Record "Sales Header")
    var
        UserSetupRec: Record "User Setup";
    begin
        if UserSetupRec.Get(UserId) then;
        if UserSetupRec."Sales Support User" then
            exit else begin
            if UserSetupRec."Salespers./Purch. Code" <> '' then begin
                Rec.FilterGroup(2);
                Rec.SetFilter("Salesperson Code", GetSalespersonRegionFilter1(UserSetupRec."Salespers./Purch. Code"));
                Rec.FilterGroup(0);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Customer Ledger Entries", 'OnOpenPageEvent', '', true, true)]
    local procedure CustomerLedgerAccessControl(var Rec: Record "Cust. Ledger Entry")
    var
        UserSetupRec: Record "User Setup";
    begin
        if UserSetupRec.Get(UserId) then;
        if UserSetupRec."Sales Support User" then
            exit else begin
            if UserSetupRec."Salespers./Purch. Code" <> '' then begin
                Rec.FilterGroup(2);
                Rec.SetFilter("Salesperson Code", GetSalespersonRegionFilter1(UserSetupRec."Salespers./Purch. Code"));
                Rec.FilterGroup(0);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Invoices", 'OnOpenPageEvent', '', true, true)]
    local procedure PostedSalesControl(var Rec: Record "Sales Invoice Header")
    var
        UserSetupRec: Record "User Setup";
    begin
        if UserSetupRec.Get(UserId) then;
        if UserSetupRec."Sales Support User" then
            exit else begin
            if UserSetupRec."Salespers./Purch. Code" <> '' then begin
                Rec.FilterGroup(2);
                Rec.SetFilter("Salesperson Code", GetSalespersonRegionFilter1(UserSetupRec."Salespers./Purch. Code"));
                Rec.FilterGroup(0);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Invoice List", 'OnOpenPageEvent', '', true, true)]
    local procedure SalesinvoiceAccessControl(var Rec: Record "Sales Header")
    var
        UserSetupRec: Record "User Setup";
    begin
        if UserSetupRec.Get(UserId) then;
        if UserSetupRec."Sales Support User" then
            exit else begin
            if UserSetupRec."Salespers./Purch. Code" <> '' then begin
                Rec.FilterGroup(2);
                Rec.SetFilter("Salesperson Code", GetSalespersonRegionFilter1(UserSetupRec."Salespers./Purch. Code"));
                Rec.FilterGroup(0);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Blanket Sales Order Archives", 'OnOpenPageEvent', '', true, true)]
    local procedure BSOArchhivedAccessControl(var Rec: Record "Sales Header Archive")
    var
        UserSetupRec: Record "User Setup";
    begin
        if UserSetupRec.Get(UserId) then;
        if UserSetupRec."Sales Support User" then
            exit else begin
            if UserSetupRec."Salespers./Purch. Code" <> '' then begin
                Rec.FilterGroup(2);
                Rec.SetFilter("Salesperson Code", GetSalespersonRegionFilter1(UserSetupRec."Salespers./Purch. Code"));
                Rec.FilterGroup(0);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order Archives", 'OnOpenPageEvent', '', true, true)]
    local procedure SOArchhivedAccessControl(var Rec: Record "Sales Header Archive")
    var
        UserSetupRec: Record "User Setup";
    begin
        if UserSetupRec.Get(UserId) then;
        if UserSetupRec."Sales Support User" then
            exit else begin
            if UserSetupRec."Salespers./Purch. Code" <> '' then begin
                Rec.FilterGroup(2);
                Rec.SetFilter("Salesperson Code", GetSalespersonRegionFilter1(UserSetupRec."Salespers./Purch. Code"));
                Rec.FilterGroup(0);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Detailed Cust. Ledg. Entries", 'OnOpenPageEvent', '', true, true)]
    local procedure DetailedCLEAccessControl(var Rec: Record "Detailed Cust. Ledg. Entry")
    var
        UserSetupRec: Record "User Setup";
    begin
        // if UserSetupRec.Get(UserId) then;
        // if UserSetupRec."Sales Support User" then
        //     exit else begin
        //     // if UserSetupRec."Salespers./Purch. Code" <> '' then begin
        //     //     Rec.FilterGroup(2);
        //     //     Rec.SetFilter("Customer Group Code 2", GetSalespersonRegionFilter1(UserSetupRec."Salespers./Purch. Code"));
        //     //     Rec.FilterGroup(0);
        //     // end;
        // end;
    end;

    procedure GetSalespersonRegionFilter(SPCode: Code[20]) RegionFilter: Text[100];
    var
        UserSetupRec: Record "User Setup";
        SPRegionnRec: Record "Salesperson Customer Group";
    begin
        // if UserSetupRec.Get(UserId) then;

        SPRegionnRec.SetRange("Salesperson code", SPCode);
        if SPRegionnRec.FindSet() then begin
            repeat
                RegionFilter += SPRegionnRec."Customer Group Code";
                RegionFilter += '|';
            until SPRegionnRec.Next() = 0;

            RegionFilter := RegionFilter.TrimEnd('|');
        end;
        exit(RegionFilter);
    end;

    procedure GetSalespersonRegionFilter1(SPCode: Code[20]) RegionFilter: Text[100];
    var
        UserSetupRec: Record "User Setup";
        SPRegionnRec: Record "Team Salesperson";
    begin
        // if UserSetupRec.Get(UserId) then;

        SPRegionnRec.SetRange("Manager Code", SPCode);
        if SPRegionnRec.FindSet() then begin
            repeat
                RegionFilter += SPRegionnRec."Salesperson Code";
                RegionFilter += '|';
            until SPRegionnRec.Next() = 0;

            RegionFilter := RegionFilter.TrimEnd('|');
        end else
            RegionFilter := SPCode;
        exit(RegionFilter);
    end;
}