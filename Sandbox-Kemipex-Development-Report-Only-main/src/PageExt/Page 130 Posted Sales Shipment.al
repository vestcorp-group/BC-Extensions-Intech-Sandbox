pageextension 50552 "Posted Sales Shipment_50552" extends "Posted Sales Shipment"
{

    actions
    {
        addafter("&Print")
        {
            action(delivery_order)
            {
                Caption = 'Delivery Order';
                Image = Print;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                // //17-04-25-NS
                // Visible = false;
                // Enabled = false;
                // //17-04-25-NE
                trigger OnAction()
                var
                    SalesShipHdr_lRec: Record "Sales Shipment Header";
                begin
                    SalesShipHdr_lRec.Reset();
                    SalesShipHdr_lRec.SetRange("No.", Rec."No.");
                    SalesShipHdr_lRec.SetRange("Sell-to Customer No.", Rec."Sell-to Customer No.");
                    Report.Run(Report::"Delivery Order", true, false, SalesShipHdr_lRec);
                end;
            }
            // action("Packing List")
            // {
            //     ApplicationArea = All;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     PromotedIsBig = true;
            //     Image = ListPage;
            //     Caption = 'Packing List';
            //     trigger OnAction()
            //     var
            //         SalesShipmentHeader_lRec: Record "Sales Shipment Header";
            //     begin
            //         SalesShipmentHeader_lRec.Reset();
            //         SalesShipmentHeader_lRec.SetRange("No.", Rec."No.");
            //         if SalesShipmentHeader_lRec.FindFirst() then
            //             REPORT.RUNMODAL(Report::"3_Kemipex Packing List", TRUE, FALSE, SalesShipmentHeader_lRec);
            //     end;
            // }
        }
    }
}