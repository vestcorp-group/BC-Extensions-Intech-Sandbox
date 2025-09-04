pageextension 50114 TransferOrderPageExt50114 extends "Transfer Order"
{
    actions
    {
        addafter("&Print")
        {
            action("Commercial Invoice")
            {
                ApplicationArea = All;
                Caption = 'Commercial Invoice';
                Image = Print;

                trigger OnAction()
                var
                    TransferHdr_lRec: Record "Transfer Header";
                    TransferCommercialInv_lRpt: Report "Commercial Invoice";
                begin
                    TransferHdr_lRec.RESET;
                    TransferHdr_lRec.SetRange("No.", Rec."No.");
                    if TransferHdr_lRec.FindFirst() then begin
                        TransferCommercialInv_lRpt.SetTableView(TransferHdr_lRec);
                        TransferCommercialInv_lRpt.RunModal(); //Temp alok
                    end;
                end;

            }
            action("Delivery Advise")
            {
                ApplicationArea = All;
                Caption = 'Delivery Advise';
                Image = Print;

                trigger OnAction()
                var
                    TransferHdr_lRec: Record "Transfer Header";
                    DeliveryAdvise_lRpt: Report "Delivery Advise";
                begin
                    TransferHdr_lRec.RESET;
                    TransferHdr_lRec.SetRange("No.", Rec."No.");
                    if TransferHdr_lRec.FindFirst() then begin
                        DeliveryAdvise_lRpt.SetTableView(TransferHdr_lRec);
                        DeliveryAdvise_lRpt.RunModal();
                    end;
                end;

            }
            action("TO Ownership Clearance")
            {
                ApplicationArea = All;
                Caption = 'TO Ownership Clearance';
                Image = Print;

                trigger OnAction()
                var
                    TransferHdr_lRec: Record "Transfer Header";
                    ToOwnershipClearance_lRpt: Report "TO Ownership Clearance";
                begin
                    TransferHdr_lRec.RESET;
                    TransferHdr_lRec.SetRange("No.", Rec."No.");
                    if TransferHdr_lRec.FindFirst() then begin
                        ToOwnershipClearance_lRpt.SetTableView(TransferHdr_lRec);
                        ToOwnershipClearance_lRpt.RunModal(); //Temp alok
                    end;
                end;

            }
            action("Packing List")
            {
                ApplicationArea = All;
                Caption = 'Packing List';
                Image = Print;

                trigger OnAction()
                var
                    TransferHdr_lRec: Record "Transfer Header";
                    PackingList_lRpt: Report "Packing List_Copy";
                begin
                    TransferHdr_lRec.RESET;
                    TransferHdr_lRec.SetRange("No.", Rec."No.");
                    if TransferHdr_lRec.FindFirst() then begin
                        PackingList_lRpt.SetTableView(TransferHdr_lRec);
                        PackingList_lRpt.RunModal(); //Temp alok
                    end;
                end;

            }
        }
    }
}