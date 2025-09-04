pageextension 50482 ItemChargeAssignmentPurch extends "Item Charge Assignment (Purch)"//T12370-Full Comment
{
    layout
    {
        // addafter("<Gross Weight>")
        // {
        //     field(TotalGrossweight; TotalGrossWeight)
        //     {
        //         Caption = 'Total Gross Weight';
        //         ApplicationArea = All;
        //     }
        // }
    }

    actions
    {
        addafter(SuggestItemChargeAssignment)
        {
            action(SuggestItemChargeByGrossWeight)
            {
                Caption = 'Suggest Item Charge By Gross Weight';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    myInt: Integer;
                    FilterText: Text;
                    ItemChargeAssignmentPurchRec: Record "Item Charge Assignment (Purch)";
                    TotalGWeight: Decimal;
                    PurchaseReceiptLine: Record "Purch. Rcpt. Line";
                    PurchaseReturnReceiptLine: Record "Return Receipt Line";
                    SalesShipmentLine: Record "Sales Shipment Line";
                    SalesReturnShipmentLine: Record "Return Shipment Line";
                    TrasnferReceiptLine: Record "Transfer Receipt Line";
                    PurchaseLine: Record "Purchase Line";
                    TotalAssignmentqty: Decimal;
                begin

                    PurchaseLine.get(PurchaseLine."Document Type"::Invoice, rec."Document No.", rec."Document Line No.");
                    TotalAssignmentqty := PurchaseLine.Quantity;
                    TotalGWeight := GrossweightAssignment(Rec, true, 0, 0);
                    GrossweightAssignment(Rec, false, TotalGWeight, TotalAssignmentqty);


                end;
            }

        }

        // modify(SuggestItemChargeAssignment)
        // {
        //     Visible = false;
        // }
    }

    procedure GrossweightAssignment(var ItemChargeAssignmentPurchRec: Record "Item Charge Assignment (Purch)"; GWTrue: Boolean; TotalGrossWeightIn: Decimal; TotalQtytoAssign: Decimal) GrossWeightOut: Decimal;
    var

        PurchaseReceiptLine: Record "Purch. Rcpt. Line";
        PurchaseReturnReceiptLine: Record "Return Receipt Line";
        SalesShipmentLine: Record "Sales Shipment Line";
        SalesReturnShipmentLine: Record "Return Shipment Line";
        TrasnferReceiptLine: Record "Transfer Receipt Line";
    begin
        Clear(GrossWeightOut);
        ItemChargeAssignmentPurchRec.Reset();
        ItemChargeAssignmentPurchRec.SetRange("Document Type", Rec."Document Type");
        ItemChargeAssignmentPurchRec.SetRange("Document No.", Rec."Document No.");
        ItemChargeAssignmentPurchRec.SetRange("Document Line No.", Rec."Document Line No.");
        ItemChargeAssignmentPurchRec.SetRange("Item Charge No.", Rec."Item Charge No.");
        if ItemChargeAssignmentPurchRec.FindSet() then begin
            repeat
                case ItemChargeAssignmentPurchRec."Applies-to Doc. Type" of
                    ItemChargeAssignmentPurchRec."Applies-to Doc. Type"::Receipt:
                        begin
                            PurchaseReceiptLine.Reset();
                            PurchaseReceiptLine.SetRange("Document No.", ItemChargeAssignmentPurchRec."Applies-to Doc. No.");
                            PurchaseReceiptLine.SetRange("Line No.", ItemChargeAssignmentPurchRec."Applies-to Doc. Line No.");
                            if PurchaseReceiptLine.FindFirst() then begin
                                if GWTrue then
                                    GrossWeightOut += PurchaseReceiptLine."Gross Weight"
                                else begin
                                    ItemChargeAssignmentPurchRec.Validate("Qty. to Assign", PurchaseReceiptLine."Gross Weight" / TotalGrossWeightIn * TotalQtytoAssign);
                                    // ItemChargeAssignmentPurchRec."Qty. to Assign" := PurchaseReceiptLine."Gross Weight" / TotalGrossWeightIn * TotalQtytoAssign;
                                    ItemChargeAssignmentPurchRec.Modify();
                                end;
                            end;
                        end;

                    ItemChargeAssignmentPurchRec."Applies-to Doc. Type"::"Return Receipt":
                        begin
                            PurchaseReturnReceiptLine.Reset();
                            PurchaseReturnReceiptLine.SetRange("Document No.", ItemChargeAssignmentPurchRec."Applies-to Doc. No.");
                            PurchaseReturnReceiptLine.SetRange("Line No.", ItemChargeAssignmentPurchRec."Applies-to Doc. Line No.");
                            if PurchaseReturnReceiptLine.FindFirst() then begin
                                if GWTrue then
                                    GrossWeightOut += PurchaseReturnReceiptLine."Gross Weight"
                                else begin
                                    ItemChargeAssignmentPurchRec.Validate("Qty. to Assign", PurchaseReturnReceiptLine."Gross Weight" / TotalGrossWeightIn * TotalQtytoAssign);
                                    // ItemChargeAssignmentPurchRec."Qty. to Assign" := PurchaseReturnReceiptLine."Gross Weight" / TotalGrossWeightIn * TotalQtytoAssign;
                                    ItemChargeAssignmentPurchRec.Modify();
                                end;
                            end;
                        end;

                    ItemChargeAssignmentPurchRec."Applies-to Doc. Type"::"Sales Shipment":
                        begin
                            SalesShipmentLine.Reset();
                            SalesShipmentLine.SetRange("Document No.", ItemChargeAssignmentPurchRec."Applies-to Doc. No.");
                            SalesShipmentLine.SetRange("Line No.", ItemChargeAssignmentPurchRec."Applies-to Doc. Line No.");
                            if SalesShipmentLine.FindFirst() then begin
                                if GWTrue then
                                    GrossWeightOut += SalesShipmentLine."Gross Weight"
                                else begin
                                    ItemChargeAssignmentPurchRec.Validate("Qty. to Assign", SalesShipmentLine."Gross Weight" / TotalGrossWeightIn * TotalQtytoAssign);
                                    //  ItemChargeAssignmentPurchRec."Qty. to Assign" := SalesShipmentLine."Gross Weight" / TotalGrossWeightIn * TotalQtytoAssign;
                                    ItemChargeAssignmentPurchRec.Modify();
                                end;
                            end;
                        end;

                    ItemChargeAssignmentPurchRec."Applies-to Doc. Type"::"Return Shipment":
                        begin
                            SalesReturnShipmentLine.Reset();
                            SalesReturnShipmentLine.SetRange("Document No.", ItemChargeAssignmentPurchRec."Applies-to Doc. No.");
                            SalesReturnShipmentLine.SetRange("Line No.", ItemChargeAssignmentPurchRec."Applies-to Doc. Line No.");
                            if SalesReturnShipmentLine.FindFirst() then begin
                                if GWTrue then
                                    GrossWeightOut += SalesReturnShipmentLine."Gross Weight"
                                else begin
                                    ItemChargeAssignmentPurchRec.Validate("Qty. to Assign", SalesReturnShipmentLine."Gross Weight" / TotalGrossWeightIn * TotalQtytoAssign);
                                    //  ItemChargeAssignmentPurchRec."Qty. to Assign" := SalesReturnShipmentLine."Gross Weight" / TotalGrossWeightIn * TotalQtytoAssign;
                                    ItemChargeAssignmentPurchRec.Modify();
                                end;
                            end;
                        end;
                    ItemChargeAssignmentPurchRec."Applies-to Doc. Type"::"Transfer Receipt":
                        begin
                            TrasnferReceiptLine.Reset();
                            TrasnferReceiptLine.SetRange("Document No.", ItemChargeAssignmentPurchRec."Applies-to Doc. No.");
                            TrasnferReceiptLine.SetRange("Line No.", ItemChargeAssignmentPurchRec."Applies-to Doc. Line No.");
                            if TrasnferReceiptLine.FindFirst() then begin
                                if GWTrue then
                                    GrossWeightOut += TrasnferReceiptLine."Gross Weight"
                                else begin
                                    ItemChargeAssignmentPurchRec.Validate("Qty. to Assign", TrasnferReceiptLine."Gross Weight" / TotalGrossWeightIn * TotalQtytoAssign);
                                    //  ItemChargeAssignmentPurchRec."Qty. to Assign" := TrasnferReceiptLine."Gross Weight" / TotalGrossWeightIn * TotalQtytoAssign;
                                    ItemChargeAssignmentPurchRec.Modify();
                                end;
                            end;
                        end;
                end;
            until ItemChargeAssignmentPurchRec.Next() = 0;
            exit(GrossWeightOut);
        end;



    end;

    var
        myInt: Integer;



    protected var

}