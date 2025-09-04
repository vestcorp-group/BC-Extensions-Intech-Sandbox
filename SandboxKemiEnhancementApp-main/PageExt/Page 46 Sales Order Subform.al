pageextension 80122 "Sales Order Subform Page Ext" extends "Sales Order Subform"//T12370-Full Comment
{
    layout
    {
        // Add changes to page layout here
        addbefore(LineHSNCode)
        {
            field("Item Generic Name"; rec."Item Generic Name")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("Line Generic Name"; rec."Line Generic Name")
            {
                ApplicationArea = all;
            }
        }
        addafter("Unit Price")
        {
            field("Customer Requested Unit Price"; rec."Customer Requested Unit Price")//T13395-N
            {
                ApplicationArea = All;
            }
            
        }
    }

    //     actions
    //     {
    //         addlast("Related Information")
    //         {
    //             action("R&emarks")
    //             {
    //                 ApplicationArea = All;
    //                 Image = ViewComments;
    //                 trigger OnAction()
    //                 var
    //                     SalesOrderRemarks: Record "Sales Order Remarks";
    //                     SalesOrderRemarksPage: Page "Sales Order Remarks";
    //                 begin
    //                     rec.TESTFIELD("Document No.");
    //                     rec.TESTFIELD("Line No.");
    //                     SalesOrderRemarks.SETRANGE("Document Type", rec."Document Type");
    //                     SalesOrderRemarks.SETRANGE("Document No.", rec."Document No.");
    //                     SalesOrderRemarks.SETRANGE("Document Line No.", rec."Line No.");
    //                     SalesOrderRemarksPage.SETTABLEVIEW(SalesOrderRemarks);
    //                     SalesOrderRemarksPage.RunModal();
    //                 end;
    //             }
    //         }
    //     }

    //     var
    //         myInt: Integer;
}