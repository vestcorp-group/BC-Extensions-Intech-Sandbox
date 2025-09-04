pageextension 53004 TransferOrderExt extends "Transfer Order"//Hypercare 03-02-2025
{
    layout
    {
        // Add changes to page layout here
    }
    actions
    {
        addafter("&Print")
        {
            action("Transfer Order 58235")
            {
                ApplicationArea = all;
                Image = PrintReport;
                Caption = 'Transfer Order';
                Promoted = true;
                PromotedCategory = Category8;
                trigger onaction()
                var
                    TransferHeader: Record "Transfer Header";
                begin
                    TransferHeader.Reset();
                    TransferHeader.SetRange("No.", Rec."No.");
                    if TransferHeader.FindFirst() then
                        Report.RunModal(58235, true, false, TransferHeader);
                end;
            }
            // action("Transfer Order 80000")
            // {
            //     ApplicationArea = all;
            //     Image = PrintReport;
            //     Caption = 'Transfer Order';
            //     Promoted = true;
            //     PromotedCategory = Category8;
            //     trigger onaction()
            //     var
            //         TransferHeader: Record "Transfer Header";
            //     begin
            //         TransferHeader.Reset();
            //         TransferHeader.SetRange("No.", Rec."No.");
            //         if TransferHeader.FindFirst() then
            //             Report.RunModal(80000, true, false, TransferHeader);
            //     end;
            // }
        }
        // Add changes to page actions here
    }
    var
        myInt: Integer;
}