pageextension 58008 "Sales Return Order_Ext" extends "Sales Return Order"
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
    }
}