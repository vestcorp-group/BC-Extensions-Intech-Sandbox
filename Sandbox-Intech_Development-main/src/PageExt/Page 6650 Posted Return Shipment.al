pageextension 50123 PostedReturnShipExt extends "Posted Return Shipment"
{
    Description = 'T49070';

    actions
    {
        addafter("&Return Shpt.")
        {

            action("Packing List")
            {
                ApplicationArea = All;
                Description = 'T49070';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = Print;
                trigger OnAction()
                var
                    ReturnShipmentHeader_lRec: Record "Return Shipment Header";
                begin
                    ReturnShipmentHeader_lRec.Reset();
                    ReturnShipmentHeader_lRec.SetRange("No.", Rec."No.");
                    if ReturnShipmentHeader_lRec.FindFirst() then
                        REPORT.RUNMODAL(Report::"Packing List PRS", TRUE, FALSE, ReturnShipmentHeader_lRec);
                end;
            }

        }
    }
}