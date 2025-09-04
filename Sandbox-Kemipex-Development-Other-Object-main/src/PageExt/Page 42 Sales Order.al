//T12068-NS
pageextension 50004 "Page 42 Sales Order" extends "Sales Order"
{
    layout
    {
        addlast(General)
        {

            //T13399-OS
            // field(BDM; Rec.BDM)
            // {
            //     ApplicationArea = all;
            //     ToolTip = 'Specifies the value of the BDM field.';
            // }
            //T13399-OE
            field("Currency Factor"; Rec."Currency Factor")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Currency Factor field.', Comment = '%';
            }
            //T12141-NS 
            field("First Approval Completed"; Rec."First Approval Completed")
            {
                ApplicationArea = All;
                Visible = false;
                ToolTip = 'Specifies the value of the First Approval Completed field.', Comment = '%';
                Description = 'T12141';
            }
            //T12141-NE

        }
        addlast("Shipping and Billing")
        {
            group("Logistic Details")
            {
                field("Vehicle No_New"; Rec."Vehicle No_New")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Vehicle No field.', Comment = '%';
                }
                field("Container Code"; Rec."Container Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Container Code field.', Comment = '%';
                }
                field("Container Plat No."; Rec."Container Plat No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Container Plat No. field.', Comment = '%';
                }
                field("Container Seal No."; Rec."Container Seal No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Container Seal No. field.', Comment = '%';
                }
            }
        }
        addafter(SalesLines)
        {
            //T12539-NS
            part("Multiple Payment Terms Subform"; "Multiple Payment Terms Subform")
            {
                ApplicationArea = All;
                SubPageLink = "Table ID" = const(36), "Document No." = field("No."), "Document Type" = filter(Order), Type = const(Sales);
                UpdatePropagation = Both;
                //Editable = IsSalesLinesEditable;
                //Enabled = CheckStatus;
            }
            //T12539-NE
        }


    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        //T12539-NS
        IsSalesLinesEditable := Rec.SalesLinesEditable();

        If Rec.Status = Rec.Status::Released then
            CheckStatus := false
        else
            CheckStatus := true;
        //T12539-NE


        //T53497-NS
        QtyCheck_ShipedANDInvoiced_SalesOrder(Rec);
        //T53497-NE


    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        //T53497-NS
        QtyCheck_ShipedANDInvoiced_SalesOrder(Rec);
        //T53497-NE

    end;

    procedure QtyCheck_ShipedANDInvoiced_SalesOrder(var Rec: Record "Sales Header")
    var
        SalesLine_lRec: Record "Sales Line";

    begin

        SalesLine_lRec.reset;
        SalesLine_lRec.setRange("Document Type", SalesLine_lRec."Document Type"::Order);
        SalesLine_lRec.setRange("Document No.", Rec."No.");
        SalesLine_lRec.setfilter(Quantity, '<>%1', 0);
        SalesLine_lRec.SetFilter("Quantity Shipped", '<>%1', 0);
        if SalesLine_lRec.findSet then begin
            Clear(ChangedAllowed_gBol);
            repeat
                if SalesLine_lRec."Quantity Shipped" <> SalesLine_lRec."Quantity Invoiced" then
                    ChangedAllowed_gBol := true;
            until SalesLine_lRec.next() = 0;
            if ChangedAllowed_gBol then
                CurrPage.Editable := true
            else
                CurrPage.Editable := false;
        end;
    end;

    var
        IsSalesLinesEditable: Boolean;//T12539-N
        CheckStatus: Boolean;//T12539-N
        ChangedAllowed_gBol: Boolean;
        NotAllowed_gBol: Boolean;


}
//T12068-NE
