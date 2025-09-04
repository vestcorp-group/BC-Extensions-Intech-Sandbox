pageextension 70020 "Sales redit Memo Ext" extends "Sales Credit Memo"//T12370-Full Comment
{
    layout
    {
        // Add changes to page layout hereaddafter("Posting Date")
        addafter("Posting Date")
        {
            //             field("Posting Date Time"; rec."Posting Date Time")
            //             {
            //                 ApplicationArea = All;
            //                 Caption = 'Posting Date Time';
            //                 Editable = false;
            //             }
            //             field("Shipment Term"; rec."Shipment Term")
            //             {
            //                 ApplicationArea = All;
            //                 Editable = ShipmentEditable;
            //             }
            field("Insurance Policy No."; rec."Insurance Policy No.")
            {
                ApplicationArea = All;
                Editable = EditInsuranceNoBool;
            }
            //             field("Customer Port of Discharge"; rec."Customer Port of Discharge")
            //             {
            //                 ApplicationArea = All;
            //             }
        }
        modify("Transaction Specification")
        {
            trigger OnAfterValidate()
            Var
                TransactionSpec: Record "Transaction Specification";
                CompanyInfo: Record "Company Information";
            begin
                CompanyInfo.Get();
                if rec."Transaction Specification" <> '' then begin
                    if TransactionSpec.Get(rec."Transaction Specification") then begin
                        if TransactionSpec."Insurance By" = TransactionSpec."Insurance By"::Seller then begin
                            Clear(rec."Insurance Policy No.");
                            rec."Insurance Policy No." := CompanyInfo."Insurance Policy Number";
                            rec.Modify();
                        end
                        else
                            if TransactionSpec."Insurance By" = TransactionSpec."Insurance By"::Buyer then begin
                                Clear(rec."Insurance Policy No.");
                            end;
                    end;
                end;
                rec.EditInsurancePolicyNo(EditInsuranceNoBool);
                CurrPage.Update(true);
            end;
        }
   }

    trigger OnAfterGetRecord()
    var
        SalesLine: Record "Sales Line";
    begin
        // SalesLine.SetRange("Document No.", Rec."No.");
        // SalesLine.SetFilter("Quantity Shipped", '<>%1', 0);
        // if SalesLine.FindSet() then
        //     repeat
        //         ShipmentEditable := false;
        //     until SalesLine.Next() = 0
        // else
        //     ShipmentEditable := true;

        rec.EditInsurancePolicyNo(EditInsuranceNoBool);
        CurrPage.Update(true);

    end;


    var
        //         [InDataSet]
        //         ShipmentEditable: Boolean;
        [InDataSet]
        EditInsuranceNoBool: Boolean;
}

