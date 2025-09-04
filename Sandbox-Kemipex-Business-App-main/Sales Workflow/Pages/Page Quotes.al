pageextension 53001 "Sales Quote Page Ext" extends "Sales Quote"//06012024
{
    layout
    {

        addlast(General)
        {
            group(ApprovalDetails)
            {
                Caption = 'Approval Reason & Details';


                field("Item Description Approval"; Rec."Item Description Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Item Description Approval field.', Comment = '%';
                    Editable = false;
                    Description = 'T50307';
                }
                field("HSN Code Approval"; Rec."HSN Code Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the HSN Code Approval field.', Comment = '%';
                    Editable = false;
                    Description = 'T50307';
                }
                field("Country Of Origin Approval"; Rec."Country Of Origin Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Country Of Origin Approval field.', Comment = '%';
                    Editable = false;
                    Description = 'T50307';
                }
                field("Minimum Initial Price Approval"; Rec."Minimum Initial Price Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum Initial Price Approval field.', Comment = '%';
                    Editable = false;
                    Description = 'T50307';
                }
                field("Minimum Selling Price Approval"; Rec."Minimum Selling Price Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Minimum Selling Price Approval field.', Comment = '%';
                    Editable = false;
                    Description = 'T50307';
                }
                field("Payment Terms Approval"; Rec."Payment Terms Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Payment Terms Approval field.', Comment = '%';
                    Editable = false;
                    Description = 'T50307';
                }
                field("Shipping Address Approval"; Rec."Shipping Address Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipping Address Approval field.', Comment = '%';
                    Editable = false;
                    Description = 'T50307';
                }
                field("Shipment Method Approval"; Rec."Shipment Method Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipment Method Approval field.', Comment = '%';
                    Editable = false;
                    Description = 'T50307';
                }
                field("Shorter Delivery Date Approval"; Rec."Shorter Delivery Date Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shorter Delivery Date Approval field.', Comment = '%';
                    Editable = false;
                    Description = 'T50307';
                }
                field("Advance Payment Approval"; Rec."Advance Payment Approval")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Advance Payment Approval field.', Comment = '%';
                    Editable = false;
                    Description = 'T50307';
                }
            }
        }
        modify("Area")
        {
            Caption = 'Port of Discharge';
        }
        modify("Exit Point")
        {
            Caption = 'Port of Loading';
        }
    }
    actions
    {

        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            var
                myInt: Integer;
            begin
                myInt += 1;
            end;
        }

        addafter(Print)
        {
            action("Sales Quotation Local UAE")
            {
                ApplicationArea = all;
                Caption = 'Sales Quotation Local';
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category9;
                trigger OnAction()
                var
                    salesHeader: Record "Sales Header";
                begin
                    companyinfo_gRec.Get();

                    if (companyinfo_gRec.Name = 'Coraplus India Private Limited') OR (companyinfo_gRec.Name = 'Chemiprime Impex Pvt. Ltd.') then begin
                        salesHeader.Reset();
                        salesHeader.SetRange("No.", Rec."No.");
                        if salesHeader.FindSet() then
                            Report.RunModal(Report::"Sales Quotation_Local_IND", true, true, salesHeader);
                    end else begin
                        if (CompanyName <> 'Alyachem_1') AND (CompanyName = 'Chemidea_1') then begin//T52854-NS
                            salesHeader.Reset();
                            salesHeader.SetRange("No.", Rec."No.");
                            if salesHeader.FindSet() then
                                Report.RunModal(Report::"Sales Quotation_Local UAE", true, true, salesHeader);
                        end;
                    end;
                end;
            }
            action("Sales Quotation Export UAE")
            {
                ApplicationArea = all;
                Caption = 'Sales Quotation Export';
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category9;
                trigger OnAction()
                var
                    salesHeader: Record "Sales Header";
                begin
                    salesHeader.Reset();
                    salesHeader.SetRange("No.", Rec."No.");
                    if salesHeader.FindSet() then
                        Report.RunModal(Report::"Sales Quotaion Export UAE", true, true, salesHeader);
                end;
            }
            action("Proforma Invoice Export UAE")
            {
                ApplicationArea = all;
                Caption = 'Proforma Invoice Export';
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category9;
                trigger OnAction()
                var
                    salesHeader: Record "Sales Header";
                begin
                    salesHeader.Reset();
                    salesHeader.SetRange("No.", Rec."No.");
                    if salesHeader.FindSet() then
                        Report.RunModal(Report::"Proforma Invoice_Export UAE", true, true, salesHeader);
                end;
            }
            // action("Proforma Invoice Local UAE")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Proforma Invoice Local';
            //     Image = Print;
            //     Promoted = true;
            //     PromotedIsBig = true;
            //     PromotedCategory = Category9;
            //     trigger OnAction()
            //     var
            //         salesHeader: Record "Sales Header";
            //     begin
            //         salesHeader.Reset();
            //         salesHeader.SetRange("No.", Rec."No.");
            //         if salesHeader.FindSet() then
            //             Report.RunModal(Report::"Proforma Invoice_Local UAE", true, true, salesHeader);
            //     end;
            // }

        }

    }
    var
        companyinfo_gRec: Record "Company Information";
}
