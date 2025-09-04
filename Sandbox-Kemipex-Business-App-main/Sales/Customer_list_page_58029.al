pageextension 58029 Customerlist extends "Customer List"//T12370-Full Comment T13353-AS 15-01-2025 code uncommented
{
    layout
    {
        // modify("Location Code")
        // {
        //     Visible = false;
        // }
        // modify("Salesperson Code")
        // {
        //     ApplicationArea = all;
        //     Visible = true;
        // }
        // modify("Country/Region Code")
        // {
        //     Visible = true;
        // }
        // addafter(Contact)
        // {
        //     field("E-Mail"; rec."E-Mail")
        //     {
        //         ApplicationArea = all;
        //     }
        // }
        addafter("Salesperson Code")
        {
            field(SalespersonName; SalespersonName)
            {
                ApplicationArea = all;
                Visible = true;
                Caption = 'Salesperson Name';
            }
            field(County; rec.County)
            {
                Description = 'Country Name';
                Caption = 'Country';
                ApplicationArea = all;
                Visible = true;
            }
            // field("Market Industry Description"; rec."Market Industry Description")
            // {
            //     Caption = 'Market Industry';
            //     ApplicationArea = all;
            // }
            // field("Block Email Distribution"; rec."Block Email Distribution")
            // {
            //     ApplicationArea = all;
            // }
            field("Insurance Limit (LCY) 2"; rec."Insurance Limit (LCY) 2") //T13353-AS 15-01-2025 code uncommented
            {
                ApplicationArea = all;
                Caption = 'Insurance Limit (LCY)';
            }
            field("Customer Incentive Ratio (CIR)"; Rec."Customer Incentive Ratio (CIR)")//Hypercare 07-03-2025
            {
                ApplicationArea = All;
            }
        }
        // movebefore("Salesperson Code"; "Responsibility Center")
        // moveafter(Contact; "Phone No.")
        // addafter(Blocked)
        // {
        //     // field("Blocked Reason"; rec."Blocked Reason")
        //     // {
        //     //     ApplicationArea = all;
        //     // }
        // }
    }

    trigger OnDeleteRecord(): Boolean
    begin
        Error('Not allowed to delete the record!');
    end;

    trigger OnAfterGetRecord()
    var
        SP: Record "Salesperson/Purchaser";
    begin
        Clear(SalespersonName);
        if rec."Salesperson Code" <> '' then begin
            sp.get(rec."Salesperson Code");
            SalespersonName := sp.Name;
        end;
    end;

    // trigger OnOpenPage()
    // var
    //     myInt: Integer;
    // begin
    //     rec.FilterGroup(2);
    //     Rec.SetFilter("Salesperson Code", 'SP03');
    //     rec.FilterGroup(0);
    // end;


    var
        SalespersonName: Text[100];

}