pageextension 53006 "Sales Setup Ext" extends "Sales & Receivables Setup"//T12370-Full Comment//Hypercare
{
    layout
    {
        // Add changes to page layout here
        addafter(Dimensions)
        {
            group(Email)
            {
                Caption = 'Approval Notification E-mail';
                field("Sales Support Email"; Rec."Sales Support Email") { ApplicationArea = Suite; }
            }
            group(DropShipment)
            {
                /*  field("Validate Shipped Qty. Drop Shipment"; Rec."Validate Shipped Qty. DropShip")//Hypercare
                 {
                     ApplicationArea = All;
                     Caption = 'Validate Drop Shipment Shipped Qty.';
                     ToolTip = 'Validate Shipped Qty. for Drop Shipment';
                 } */
            }
        }


        addafter("Number Series")
        {
            group("Workflow configuration-sales")
            {
                field("Credit Limit 1st From Range"; Rec."Credit Limit 1st From Range")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Credit Limit 1st From Range field.';
                }
                field("Credit Limit 1st To Range"; Rec."Credit Limit 1st To Range")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Credit Limit 1st To Range field.';
                }
                field("Credit Limit 2nd From Range"; Rec."Credit Limit 2nd From Range")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Credit Limit 2nd From Range field.';
                }
                field("Credit Limit 2nd To Range"; Rec."Credit Limit 2nd To Range")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Credit Limit 2nd To Range field.';
                }
                field("Credit Limit 3rd From Range"; Rec."Credit Limit 3rd From Range")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Credit Limit 3rd From Range field.';
                }
                field("Credit Limit 3rd To Range"; Rec."Credit Limit 3rd To Range")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Credit Limit 3rd To Range field.';
                }
                field("Price Change % 1st From Range"; Rec."Price Change % 1st From Range")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Price Change % 1st From Range field.';
                }
                field("Price Change % 1st To Range"; Rec."Price Change % 1st To Range")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Price Change % 1st To Range field.';
                }
                field("Price Change % 2nd From Range"; Rec."Price Change % 2nd From Range")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Price Change % 2nd From Range field.';
                }
                field("Price Change % 2nd To Range"; Rec."Price Change % 2nd To Range")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Price Change % 2nd To Range field.';
                }
                field("Price Change % 3rd From Range"; Rec."Price Change % 3rd From Range")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Price Change % 3rd From Range field.';
                }
                field("Price Change % 3rd To Range"; Rec."Price Change % 3rd To Range")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Price Change % 3rd To Range field.';
                }
            }
        }

        addlast(General)
        {
            // field("Validate Shiped Qty. For Drop Shipment"; Rec."Validate Shipped Qty. DropShip")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Validate Shipped Qty. For Drop Shipment';
            // }
            /* field("Notification Entry Nos."; Rec."Notification Entry Nos.") //HyperCare
            {
                ApplicationArea = All;
            }
            //22-10-2022-start
            field("Block Non IC Vendor in PO"; Rec."Block Non IC Vendor in PO")
            {
                ApplicationArea = All;
                Caption = 'Block Non-IC Vendor Creation on PO';
            }
            //22-10-2022-end
            field("Rel. Mand. for posting orders"; Rec."Rel. Mand. for posting orders")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies Release is mandatory before posting Sales Orders.';
            } */
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}