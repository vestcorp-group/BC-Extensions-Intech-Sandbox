pageextension 75061 InvtShipment_P75061 extends "Invt. Shipment"
{
    //InvShipRec-NS
    actions
    {
        modify("P&ost")
        {
            Visible = false;
        }

        modify("Post and &Print")
        {
            Visible = false;
        }




        addafter("P&ost")
        {
            action("Post_Doc")
            {
                Caption = 'Post';
                ApplicationArea = All;
                Image = Post;
                ShortcutKey = F9;
                trigger OnAction()
                var
                    InvtDocPostShipment: Codeunit "Invt. Doc.-Post Shipment";
                begin
                    Location_gRec.Consistent(false);
                    IF Location_gRec.GET(Rec."Location Code") THEn begin
                        Location_gRec.Bkp_ReceiptRequire := Location_gRec."Require Receive";
                        Location_gRec.Bkp_ShipmentRequire := Location_gRec."Require Shipment";

                        Location_gRec."Require Receive" := false;
                        Location_gRec."Require Shipment" := false;
                        Location_gRec.Modify();
                    end;

                    Clear(InvtDocPostShipment);
                    InvtDocPostShipment.Run(Rec);

                    IF Location_gRec.GET(Rec."Location Code") THEn begin
                        Location_gRec."Require Receive" := Location_gRec.Bkp_ReceiptRequire;
                        Location_gRec."Require Shipment" := Location_gRec.Bkp_ShipmentRequire;
                        Location_gRec.Modify();
                    end;
                    Location_gRec.Consistent(TRUE);
                end;

            }


        }
    }

    trigger OnOpenPage()
    var
        InvtSetup_lRec: Record "Inventory Setup";
    begin
        InvtSetup_lRec.Get();
    end;

    var
        Location_gRec: Record Location;

    //InvShipRec-NE
}
