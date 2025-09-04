pageextension 50264 PagExtCustomerCard extends "Customer Card"//T12370-Full Comment // T13353-AS 15-01-2025 code uncommented
{
    layout
    {
        //         modify("Responsibility Center")
        //         {
        //             Visible = false;
        //         }
        //         addafter("Balance (LCY)")
        //         {
        //             field("E-Mirsal Code"; rec."E-Mirsal Code")
        //             {
        //                 ApplicationArea = All;
        //             }
        //             field("Hide in Reports"; rec."Hide in Reports")
        //             {
        //                 ApplicationArea = all;
        //                 Caption = 'Hide this Customer in Financial Reports';
        //                 ToolTip = 'Enabling this will hide this customer from dashboard sales figures';
        //             }
        //         }

        // T13353-NS 15-01-2025 code uncommented

        AddAfter("Credit Limit (LCY)")
        {
            Field("Insurance Limit (LCY)"; rec."Insurance Limit (LCY) 2")
            {
                Caption = 'Insurance Limit (LCY)';
                ApplicationArea = all;
            }
        }
        // T13353-NE 15-01-2025 code uncommented

        //T52098-NS
        addlast(Invoicing)
        {
            field("Trade License Expiry Date"; Rec."Trade License Expiry Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Trade License Expiry Date field.', Comment = '%';
            }
        }
        //T52098-NE


        addafter("Salesperson Code")
        {
            // field("Customer Region"; rec."Customer Group Code 2")
            // {
            //     ApplicationArea = all;
            //     Caption = 'Customer Group';
            // }

            field("Customer Incentive Ratio (CIR)"; rec."Customer Incentive Ratio (CIR)")//Hypercare 07-03-2025
            {
                Caption = 'Customer Incentive Ratio (CIR)';
                ApplicationArea = all;
            }
        }
    }
    //     actions
    //     {
    //         addafter(Attachments)
    //         {
    //             action(Show_hide_customer)
    //             {
    //                 ApplicationArea = all;
    //                 trigger OnAction()
    //                 var
    //                     HideCustcode: Codeunit "Consolidated Data";
    //                     TxtL: Text;
    //                 begin
    //                     TxtL := HideCustcode.reportexemptCustomers();
    //                     Message('Hiden Customers %1', TxtL);
    //                 end;
    //             }
    //         }
}
