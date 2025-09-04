pageextension 58139 SalesLine extends "Customer Details FactBox"//T12370-Full Comment  // T13353-AS 15-01-2025 code uncommented
{
    layout
    {
        addbefore("Credit Limit (LCY)")
        {
            field("Insurance Limit (LCY) 2"; rec."Insurance Limit (LCY) 2")
            {
                ApplicationArea = all;
                Caption = 'Insurance Limit (LCY)';
            }

        }
        addafter("Credit Limit (LCY)")
        {
            field("Outstanding Orders (LCY)"; rec."Outstanding Orders (LCY)")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies Open Sales order Value';
                trigger OnDrillDown()
                var
                    salesline: Record "Sales Line";
                    SO_list: page "Sales Lines";
                    SalesHeader: Record "Sales Header";
                // SalesHeader: Record "Sales Header";
                begin
                    /* SalesHeader.SetRange("Sell-to Customer No.", Rec."No.");
                    SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                    SalesHeader.SetFilter(Status, '%1|%2', SalesHeader.Status::"Pending Approval", SalesHeader.Status::Released);
                    if SalesHeader.FindSet() then begin */
                    salesline.SetRange("Bill-to Customer No.", rec."No.");
                    salesline.SetRange("Document Type", salesline."Document Type"::Order);
                    // SalesHeader.SetRange("Status"::Released);
                    SO_list.SetTableView(salesline);
                    SO_list.Run();
                    // end;




                end;
            }
            field("Balance (LCY)"; rec."Balance (LCY)")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the payment amount that the customer owes for completed sales. This value is also known as the customers balance.';
                trigger OnDrillDown()
                var
                    custledgertable: Record "Cust. Ledger Entry";
                    customerLedgerPage: page "Customer Ledger Entries";
                begin
                    custledgertable.SetRange("Customer No.", rec."No.");
                    custledgertable.SetRange(Open, true);
                    customerLedgerPage.SetTableView(custledgertable);
                    customerLedgerPage.Run();
                end;
            }
            field(CalcOverdueBalance; rec.CalcOverdueBalance)
            {
                Caption = 'Balance Due(LCY) ';
                ToolTip = 'Specifies payments from the customer that are overdue per todays date';
                ApplicationArea = all;
                trigger OnDrillDown()
                var
                    custledgertable: Record "Cust. Ledger Entry";
                    customerLedgerPage: page "Customer Ledger Entries";
                begin
                    custledgertable.SetRange("Customer No.", rec."No.");
                    custledgertable.SetRange(Open, true);
                    custledgertable.SetFilter("Due Date", '..%1', WorkDate());
                    customerLedgerPage.SetTableView(custledgertable);
                    customerLedgerPage.Run();
                end;
            }

        }
        addafter(AvailableCreditLCY)
        {
            field(GetTotalAmountLCY; rec.GetTotalAmountLCY)
            {
                Caption = 'Total';
                ApplicationArea = all;
            }
        }

        addbefore(AvailableCreditLCY)
        {
            field("Orders (LCY)-InProcess"; Rec."Orders (LCY)-InProcess")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies your expected sales income from the customer in LCY based on ongoing sales orders.';
            }
        }
    }


}