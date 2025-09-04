pageextension 70021 "Sales Return Order Ext." extends "Sales Return Order"//T12370-Full Comment
{
    layout
    {
        // Add changes to page layout here
        addafter("Posting Date")
        {
            //             field("Posting Date Time"; Rec."Posting Date Time")
            //             {
            //                 ApplicationArea = All;
            //                 Caption = 'Posting Date Time';
            //                 Editable = false;
            //             }
            //             field("Shipment Term"; Rec."Shipment Term")
            //             {
            //                 ApplicationArea = All;
            //                 Editable = ShipmentEditable;
            //             }
            field("Insurance Policy No."; Rec."Insurance Policy No.")
            {
                ApplicationArea = All;
                Editable = EditInsuranceNoBool;
            }
            //             field("Customer Port of Discharge"; Rec."Customer Port of Discharge")
            //             {
            //                 ApplicationArea = All;
        }
    // }
        modify("Transaction Specification")
        {
            trigger OnAfterValidate()
            Var
                TransactionSpec: Record "Transaction Specification";
                CompanyInfo: Record "Company Information";
            begin
                CompanyInfo.Get();
                if Rec."Transaction Specification" <> '' then begin
                    if TransactionSpec.Get(Rec."Transaction Specification") then begin
                        if TransactionSpec."Insurance By" = TransactionSpec."Insurance By"::Seller then begin
                            Clear(Rec."Insurance Policy No.");
                            Rec."Insurance Policy No." := CompanyInfo."Insurance Policy Number";
                            Rec.Modify();
                        end
                        else
                            if TransactionSpec."Insurance By" = TransactionSpec."Insurance By"::Buyer then begin
                                Clear(Rec."Insurance Policy No.");
                            end;
                    end;
                end;

                Rec.EditInsurancePolicyNo(EditInsuranceNoBool);
                CurrPage.Update(true);
            end;
        }
    }

    trigger OnAfterGetRecord()
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document No.", Rec."No.");
        SalesLine.SetFilter("Quantity Shipped", '<>%1', 0);
        if SalesLine.FindSet() then
            repeat
                // ShipmentEditable := false;
            until SalesLine.Next() = 0
        else
            // ShipmentEditable := true;
        Rec.EditInsurancePolicyNo(EditInsuranceNoBool);
        CurrPage.Update(true);

    end;


    var
//         [InDataSet]
//         ShipmentEditable: Boolean;
        [InDataSet]
        EditInsuranceNoBool: Boolean;


}