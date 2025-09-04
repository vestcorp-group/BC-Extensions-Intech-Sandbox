pageextension 70004 PostedSalesShipmentExt extends "Posted Sales Shipment"//T12370-Full Comment
{
    layout
    {
        addlast(content)
        {

            group(Remarks3)
            {
                Caption = 'Remarks';

                part(Remarks2; "Remarks Part")
                {
                    SubPageLink = "Document Type" = const(Shipment), "Document No." = field("No.");
                    ApplicationArea = all;
                }
            }

        }
        addafter("Responsibility Center")
        {

            field("Duty Exemption"; rec."Duty Exemption")
            {
                ApplicationArea = All;
            }
            field("Sales Order Date"; rec."Sales Order Date")
            {
                ApplicationArea = All;
            }

        }
        addlast(General)
        {
            field("Customer Registration Type."; rec."Customer Registration Type")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Customer Registration No."; rec."Customer Registration No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            // field("PI Validity Date"; "PI Validity Date")
            // {
            //     ApplicationArea = all;
            //     Editable = false;
            // }
        }
        addafter("Posting Date")
        {
            field("Posting Date Time"; rec."Posting Date Time")
            {
                ApplicationArea = All;
                Caption = 'Posting Date Time';
                Editable = false;
            }
            field("Shipment Term"; rec."Shipment Term")
            {
                ApplicationArea = All;
                Editable = false;

            }
            field("Insurance Policy No."; rec."Insurance Policy No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Customer Port of Discharge"; rec."Customer Port of Discharge")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }

    }
    actions
    {
        addlast(processing)
        {
            action(Remarks)
            {
                ApplicationArea = All;
                Image = Comment;
                Promoted = true;
                RunObject = page "Posted Sales Shipment Remarks";
                RunPageLink = "Document No." = field("Remarks Order No."), "Document Type" = filter(Shipment), "Document Line No." = const(0);
            }

        }
        // addlast(Reporting)
        //{
        // action("Posted Sales Shipment")
        // {
        //     ApplicationArea = All;
        //     Image = Report;
        //     Promoted = true;
        //     PromotedCategory = Report;
        //     trigger OnAction()
        //     var
        //         SalesShipmentHeader: Record "Sales Shipment Header";
        //     begin
        //         SalesShipmentHeader.SetRange("No.", Rec."No.");
        //         Report.Run(70002, true, false, SalesShipmentHeader);
        //     end;
        // }
        // }

    }



    var
        myInt: Integer;
}