pageextension 50363 ShipmentHExt extends "Posted Sales Shipment"//T12370-Full Comment
{
    layout
    {
        //         // Add changes to page layout here
        addafter("Responsibility Center")
        {
            //             // field("Seller/Buyer 2"; rec."Seller/Buyer 2")
            //             // {
            //             //     ApplicationArea = all;
            //             //     Editable = false;
            //             //     Caption = 'Seller/Buyer';
            //             // }
            //             field("Bank on Invoice 2"; rec."Bank on Invoice 2")
            //             {
            //                 Caption = 'Bank on Invoice';
            //                 ApplicationArea = All;
            //             }
            //             field("Inspection Required 2"; rec."Inspection Required 2")
            //             {
            //                 ApplicationArea = All;
            //                 Caption = 'Inspection Required';
            //                 // Visible = false;
            //             }
            //             field("Legalization Required 2"; rec."Legalization Required 2")
            //             {
            //                 ApplicationArea = All;
            //                 Caption = 'Legalization Required';
            //                 // Visible = false;
            //             }
            //             field("Seller/Buyer 2"; rec."Seller/Buyer 2")
            //             {
            //                 ApplicationArea = all;
            //                 Caption = 'Seller/Buyer';
            //             }
            field("LC No. 2"; rec."LC No. 2")
            {
                ApplicationArea = All;
                Caption = 'LC No.';
            }
            field("LC Date 2"; rec."LC Date 2")
            {
                ApplicationArea = all;
                Caption = 'LC Date';
            }
        }
    }


    //AS-24-12-24 Code Uncommented

    actions
    {
        addfirst(Processing)
        {
            action("Warehouse Instruction")
            {
                ApplicationArea = all;
                Caption = 'Warehouse Instruction';
                Image = Warehouse;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    WarehouseInstruction: Page "Warehouse Delivery Instruction";
                    WImgmt: Codeunit "Warehouse Instruction Mgmt";
                    WarehouseInstructionheader: Record "Warehouse Delivery Inst Header";
                begin
                    WImgmt.CreateWDIHeaderMultiple(Rec);
                    WarehouseInstructionheader.Reset();
                    WarehouseInstructionheader.SetRange("Sales Shipment No.", Rec."No.");
                    Page.Run(Page::"Warehouse Delivery Inst List", WarehouseInstructionheader);

                    // Page.Run(Page::"Warehouse Delivery Inst List");
                end;
            }
        }
        //AS-24-12-24 Code Uncommented
    }

    //     var
    //         myInt: Integer;
    //         SalesOrders: Page "Sales Order List";
}