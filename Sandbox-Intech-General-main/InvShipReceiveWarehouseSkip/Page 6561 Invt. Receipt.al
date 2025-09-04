pageextension 75060 "Invt Receipt Ext_75060" extends "Invt. Receipt"
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
                ShortcutKey = F9;
                Image = Post;
                trigger OnAction()
                var
                    InvPost_lCdu: Codeunit "Invt. Doc.-Post (Yes/No)";
                begin
                    Location_gRec.Consistent(false);
                    IF Location_gRec.GET(Rec."Location Code") THEn begin
                        Location_gRec.Bkp_ReceiptRequire := Location_gRec."Require Receive";
                        Location_gRec.Bkp_ShipmentRequire := Location_gRec."Require Shipment";

                        Location_gRec."Require Receive" := false;
                        Location_gRec."Require Shipment" := false;
                        Location_gRec.Modify();
                    end;

                    Clear(InvPost_lCdu);
                    InvPost_lCdu.Run(Rec);

                    IF Location_gRec.GET(Rec."Location Code") THEn begin
                        Location_gRec."Require Receive" := Location_gRec.Bkp_ReceiptRequire;
                        Location_gRec."Require Shipment" := Location_gRec.Bkp_ShipmentRequire;
                        Location_gRec.Modify();
                    end;
                    Location_gRec.Consistent(TRUE);
                end;

            }
        }
        modify("Re&lease")
        {
            Visible = false;
            Enabled = false;
            Promoted = False;
        }
        modify("Reo&pen")
        {
            Visible = false;
            Enabled = false;
            Promoted = False;
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
