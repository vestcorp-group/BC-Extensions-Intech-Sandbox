pageextension 70003 PostedSalesInvoiceExt extends "Posted Sales Invoice"//T12370-Full Comment
{

    layout
    {
        addlast(content)
        {
            group(Remarks)
            {
                Caption = 'Remarks';
                part(Remarks2; "Remarks Part")
                {
                    SubPageLink = "Document Type" = const(Invoice), "Document No." = field("No.");
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
                ApplicationArea = all;
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
            // field("Posting Date Time"; "Posting Date Time")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Posting Date Time';
            //     Editable = false;
            // }
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
        addafter(Print)
        {
            /* action("Transfer of Ownership")
            {
                ApplicationArea = all;
                Caption = 'Transfer of Ownership Certificate';
                Promoted = true;
                PromotedCategory = Category6;
                trigger onaction()
                var
                    SalesInvoiceHeader: Record "Sales Invoice Header";
                begin
                    SalesInvoiceHeader.Reset();
                    SalesInvoiceHeader.SetRange("No.", Rec."No.");
                    if SalesInvoiceHeader.FindFirst() then
                        Report.RunModal(70108, true, false, SalesInvoiceHeader);

                end;

            } */

        }
        addlast(processing)
        {
            action("Posted Sales Invoice Remarks")
            {

                ApplicationArea = All;
                Image = Comment;
                Promoted = true;
                RunObject = page "Posted Sales Invoice Remarks";
                RunPageLink = "Document Type" = filter(Invoice), "Document No." = field("Remarks Order No."), "Document Line No." = const(0);
                // trigger OnAction()
                // var
                //     salesShipmentLine: Record "Sales Shipment Line";
                //     SalesinvLine: Record "Sales Invoice Line";
                //     OrderNo: Code[20];
                //     SalesOrderRemarks: Record "Sales Order Remarks";
                //     salesOrderRemarkspage: page "Sales Order Remarks";
                // begin
                // SalesinvLine.SetRange("Document No.", Rec."No.");
                // SalesinvLine.SetRange(Type, SalesinvLine.Type::Item);
                // if SalesinvLine.FindFirst() then begin
                //     salesShipmentLine.Reset();
                //     salesShipmentLine.SetRange("Document No.", SalesinvLine."Shipment No.");
                //     salesShipmentLine.SetRange(Type, salesShipmentLine.Type::Item);
                //     if salesShipmentLine.FindFirst() then
                //         OrderNo := salesShipmentLine."Order No.";
                // end;
                // SalesOrderRemarks.SETRANGE("Document Type", SalesOrderRemarks."Document Type"::Invoice);
                // SalesOrderRemarks.SETRANGE("Document No.", OrderNo);
                // salesOrderRemarkspage.SETTABLEVIEW(SalesOrderRemarks);
                // salesOrderRemarkspage.RUNMODAL;
                // end;
            }

        }
        // addlast(Reporting)
        // {
        //     action("Post sales Invoice")
        //     {
        //         ApplicationArea = All;
        //         Image = Report;
        //         Promoted = true;
        //         PromotedCategory = Report;
        //         trigger OnAction()
        //         var
        //             salesInvHeader: Record "Sales Invoice Header";
        //         begin
        //             salesInvHeader.SetRange("No.", Rec."No.");
        //             Report.Run(70001, true, false, salesInvHeader);
        //         end;
        //     }
        // }
    }


}