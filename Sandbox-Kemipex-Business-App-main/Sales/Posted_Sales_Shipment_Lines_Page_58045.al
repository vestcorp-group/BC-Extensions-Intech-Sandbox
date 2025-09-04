pageextension 58045 PostedShipmentLine extends "Posted Sales Shipment Lines"//T12370-Full Comment //T13796
{
    layout
    {
        addafter("Document No.")
        {
            field("Order No."; rec."Order No.")
            {
                ApplicationArea = all;
            }
            // field("IC Related SO"; rec."IC Related SO")
            // {
            //     ApplicationArea = all;
            //     Visible = false;
            // }
            // field("Posting Date"; rec."Posting Date")
            // {
            //     ApplicationArea = all;
            //     Visible = false;
            // }

            // field("Blanket Order No."; rec."Blanket Order No.")
            // {
            //     ApplicationArea = all;
            //     Visible = false;
            // }
            // field("Blanket Order Line No."; rec."Blanket Order Line No.")
            // {
            //     ApplicationArea = all;
            //     Visible = false;
            // }
            // field("Posting Group"; rec."Posting Group")
            // {
            //     ApplicationArea = all;
            //     Visible = false;
            // }
        }
        // addlast(Control1)
        // {

        //     field("Transaction Type"; rec."Transaction Type")
        //     {
        //         ApplicationArea = all;
        //         Caption = 'Order Type';
        //     }
        //     field("Container Size"; rec."Container Size")
        //     {
        //         ApplicationArea = All;
        //     }
        //     field("Shipping Remarks"; rec."Shipping Remarks")
        //     {
        //         ApplicationArea = All;
        //     }
        //     field("In-Out Instruction"; rec."In-Out Instruction")
        //     {
        //         ApplicationArea = All;
        //     }
        //     field("Shipping Line"; rec."Shipping Line")
        //     {
        //         ApplicationArea = All;
        //     }
        //     field("BL-AWB No."; rec."BL-AWB No.")
        //     {
        //         ApplicationArea = All;
        //     }
        //     field("Vessel-Voyage No."; rec."Vessel-Voyage No.")
        //     {
        //         ApplicationArea = all;
        //     }
        //     field("Freight Forwarder"; rec."Freight Forwarder")
        //     {
        //         ApplicationArea = all;
        //     }
        //     field("Freight Charge"; rec."Freight Charge")
        //     {
        //         ApplicationArea = all;
        //     }
        // }
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}