codeunit 80004 "B.O_to_S.O"//T12370-Full Comment
{
    trigger OnRun()
    begin

    end;

    //     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnBeforeSalesOrderHeaderModify', '', True, true)]
    //     local procedure BO_to_SO(VAR SalesOrderHeader: Record "Sales Header"; BlanketOrderSalesHeader: Record "Sales Header")
    //     begin
    //         SalesOrderHeader."Customer Registration Type" := BlanketOrderSalesHeader."Customer Registration Type";
    //         SalesOrderHeader."Customer Registration No." := BlanketOrderSalesHeader."Customer Registration No.";
    //         SalesOrderHeader."PI Validity Date" := BlanketOrderSalesHeader."PI Validity Date";
    //     end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnAfterInsertSalesOrderLine', '', True, true)]
    local procedure BO_Line_to_SO_line(VAR SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; BlanketOrderSalesLine: Record "Sales Line"; BlanketOrderSalesHeader: Record "Sales Header")
    begin
        SalesOrderLine."Item Generic Name" := BlanketOrderSalesLine."Item Generic Name";
        SalesOrderLine."Line Generic Name" := BlanketOrderSalesLine."Line Generic Name";
        SalesOrderLine.Modify();
    end;

    [EventSubscriber(ObjectType::Table, 37, 'OnAfterInsertEvent', '', false, false)]
    local procedure SO_to_SI(VAR Rec: Record "Sales Line"; RunTrigger: Boolean)
    var
        SalesShipmentLine: Record "Sales Shipment Line";
        SalesShipmentHeader: Record "Sales Shipment Header";
        salesHeader: Record "Sales Header";
        salesHeader2: Record "Sales Header";
        SaleLineRec: Record "Sales Line";
        OrderNo: Code[20];
    begin
        if (Rec."Document Type" = Rec."Document Type"::Invoice) then begin
            SalesShipmentLine.Reset();
            SalesShipmentLine.SetRange("Document No.", Rec."Shipment No.");
            SalesShipmentLine.SetRange(Type, SalesShipmentLine.Type::Item);
            SalesShipmentLine.SetRange("No.", Rec."No.");
            if SalesShipmentLine.FindFirst() then begin
                OrderNo := SalesShipmentLine."Order No.";
                salesHeader.Reset();
                salesHeader.SetRange("No.", Rec."Document No.");
                if salesHeader.FindFirst() then begin
                    salesHeader2.Reset();
                    if salesHeader2.Get(salesHeader2."Document Type"::Order, OrderNo) then begin
                        // salesHeader."Customer Registration Type" := salesHeader2."Customer Registration Type";
                        // salesHeader."Customer Registration No." := salesHeader2."Customer Registration No.";
                        // salesHeader."PI Validity Date" := salesHeader2."PI Validity Date";
                        SaleLineRec.Reset();
                        SaleLineRec.SetRange("Document No.", salesHeader2."No.");
                        SaleLineRec.SetRange("No.", Rec."No.");
                        if SaleLineRec.FindFirst() then begin
                            Rec."Item Generic Name" := SaleLineRec."Item Generic Name";
                            Rec."Line Generic Name" := SaleLineRec."Line Generic Name";
                            Rec.Modify();
                        end;
                    end;
                    salesHeader.Modify();
                end;
            end;
        end;
    end;

    //     var
    //         myInt: Integer;
}
