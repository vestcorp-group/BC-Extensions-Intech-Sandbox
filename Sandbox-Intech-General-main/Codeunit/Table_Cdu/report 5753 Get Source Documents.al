Codeunit 75029 Subscribe
{
    //T12240-NS


    [EventSubscriber(ObjectType::Report, Report::"Get Source Documents", OnAfterCreateRcptHeader, '', false, false)]
    local procedure "Get Source Documents_OnAfterCreateRcptHeader"(var WarehouseReceiptHeader: Record "Warehouse Receipt Header"; WarehouseRequest: Record "Warehouse Request"; PurchaseLine: Record "Purchase Line")
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        PurchaseHeader.Reset();
        PurchaseHeader.SetRange("No.", PurchaseLine."Document No.");
        IF PurchaseHeader.FindFirst() then begin
            WarehouseReceiptHeader."LR/RR Date" := PurchaseHeader."LR/RR Date";
            WarehouseReceiptHeader."LR/RR No." := PurchaseHeader."LR/RR No.";
            WarehouseReceiptHeader."Shipping Agent Code" := PurchaseHeader."Shipping Agent Code";
        end;
    end;


}

