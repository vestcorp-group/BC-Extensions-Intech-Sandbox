codeunit 50368 "Warehouse Instruction Mgmt"//T12370-Full Comment //Code Uncommented-24-12-24
{
    Permissions = tabledata "Sales Shipment Line" = rm;
    trigger OnRun()
    begin

    end;

    var
        myInt: Integer;

    procedure CreateWDIHeaderMultiple(ShipmentHeader: Record "Sales Shipment Header")
    var
        SalesShipmentline: Record "Sales Shipment Line";
        WDIHeader: Record "Warehouse Delivery Inst Header";
    begin
        SalesShipmentline.Reset();
        SalesShipmentline.SetRange("Document No.", ShipmentHeader."No.");
        SalesShipmentline.SetRange(SalesShipmentline.Type, SalesShipmentline.Type::Item);
        if SalesShipmentline.FindSet() then begin
            repeat
                WDIHeader.SetRange("Sales Shipment No.", SalesShipmentline."Document No.");
                WDIHeader.SetRange("Location Code", SalesShipmentline."Location Code");
                if not WDIHeader.FindSet() then begin
                    CreateWDIHeaderSingle(SalesShipmentline);
                end;
                if SalesShipmentline.CountryOfOrigin <> SalesShipmentline.LineCountryOfOrigin then SalesShipmentline.Relabel := true;
                SalesShipmentline.Modify(true);
            until SalesShipmentline.Next() = 0;
        end;
    end;

    procedure CreateWDIHeaderSingle(ShipmentLine: Record "Sales Shipment Line")
    var
        NoSeriesMGMnt: Codeunit NoSeriesManagement;
        WDIsetup: Record "Warehouse Instruction Setup";
        WDIHeader: Record "Warehouse Delivery Inst Header";
        ShipmentHeader: Record "Sales Shipment Header";
        Location: Record Location;
    begin
        if WDIsetup.Get() then;
        if ShipmentHeader.get(ShipmentLine."Document No.") then;
        if WDIsetup."Whse Delivery Ins No. Series" = '' then
            Error('No. Series Required in Warehouse Instruction Setup for Warehouse Delivery Instruction No. Series')
        else begin
            Location.Get(ShipmentLine."Location Code");
            NoSeriesMGMnt.SetDefaultSeries(WDIHeader."WDI No", WDIsetup."Whse Delivery Ins No. Series");
            WDIHeader."WDI No" := NoSeriesMGMnt.GetNextNo(WDIsetup."Whse Delivery Ins No. Series", WorkDate(), true);
            WDIHeader."Bill-to Customer Code" := ShipmentLine."Bill-to Customer No.";
            WDIHeader."Ship-to Customer Code" := ShipmentHeader."Ship-to Code";
            WDIHeader."Location Code" := ShipmentLine."Location Code";
            WDIHeader."Sales Shipment No." := ShipmentLine."Document No.";
            WDIHeader."Bill-to Customer Name" := ShipmentHeader."Bill-to Name";
            WDIHeader."Location Name" := Location.Name;
            WDIHeader."Location E-mail Address" := Location."E-Mail";
            WDIHeader."Order No." := ShipmentLine."Order No.";
            WDIHeader."Blanket Order No." := ShipmentLine."Blanket Order No.";
            WDIHeader."WDI Date" := ShipmentLine."Posting Date";
            WDIHeader."Customer Phone No" := ShipmentHeader."Sell-to Phone No.";
            WDIHeader.Validate("Customer Contact Code", ShipmentHeader."Sell-to Contact No.");
            if ShipmentHeader."Transaction Specification" = WDIsetup."Ex-Works Incoterm" then begin
                WDIHeader."Ex-Works" := true;
            end
            else begin
                WDIHeader.Validate("Ex-Works", false);
            end;
            WDIHeader.Insert(true);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterInsertShipmentLine', '', true, true)]
    local procedure CreateWDIafterposting(var SalesShptLine: Record "Sales Shipment Line")
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
    begin
        SalesShipmentHeader.SetRange("No.", SalesShptLine."Document No.");
        if SalesShipmentHeader.FindFirst() then
            CreateWDIHeaderMultiple(SalesShipmentHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Shipping Agent", 'OnAfterInsertEvent', '', true, true)]
    local procedure AgentMasterNoGen(var Rec: Record "Shipping Agent")
    var
        WHISetup: Record "Warehouse Instruction Setup";
        Noseries: Record "No. Series";
        NoSeriesMGMnt: Codeunit NoSeriesManagement;
        BRMng: Codeunit "Relationship Performance Mgt.";
        BRRec: Record "Business Relation";
    begin
        if WHISetup.Get() then;
        if WHISetup."Agent No. Series" = '' then
            Error('Agent No. Series required in Warehouse Instruction Setup') else begin
            NoSeriesMGMnt.SetDefaultSeries(Rec."Agent Code2", WHISetup."Agent No. Series");
            Rec."Agent Code2" := NoSeriesMGMnt.GetNextNo(WHISetup."Agent No. Series", WorkDate(), true);

        end;
    end;


    [EventSubscriber(ObjectType::Page, Page::"Contact List", 'OnInsertRecordEvent', '', true, true)]
    local procedure CreateAgentContact(var Rec: Record Contact; var xRec: Record Contact; var AllowInsert: Boolean)
    var

    begin

    end;
}