pageextension 70007 "Sales Invoice Extension" extends "Sales Invoice"//T12370-Full Comment
{
    layout
    {
        addlast(General)
        {

            field("Duty Exemption"; Rec."Duty Exemption")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Sales Order Date"; Rec."Sales Order Date")
            {
                ApplicationArea = All;
            }
        }
        addlast(General)
        {
            field("Customer Registration Type."; Rec."Customer Registration Type")
            {
                ApplicationArea = all;
                Editable = false;
            }

            field("Customer Registration No."; Rec."Customer Registration No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("PI Validity Date"; "PI Validity Date")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        addafter("Posting Date")
        {
            // field("Posting Date Time"; "Posting Date Time")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Posting Date Time';
            //     Editable = false;
            // }
            field("Shipment Term"; Rec."Shipment Term")
            {
                ApplicationArea = All;
                Editable = ShipmentEditable;

            }
            field("Insurance Policy No."; Rec."Insurance Policy No.")
            {
                ApplicationArea = All;
                Editable = EditInsuranceNoBool;
            }
            field("Customer Port of Discharge"; Rec."Customer Port of Discharge")
            {
                ApplicationArea = All;
            }

        }
        modify("Transaction Specification")
        {
            trigger OnAfterValidate()
            Var
                TransactionSpec: Record "Transaction Specification";
                CompanyInfo: Record "Company Information";
            begin
                if Rec."Insurance Policy No." = '' then begin//19-12-2024 UAT Posting Issue
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
                end;
                Rec.EditInsurancePolicyNo(EditInsuranceNoBool);
                CurrPage.Update(true);
            end;

        }


    }

    actions
    {
        // Add changes to page actions here
        addlast(processing)
        {
            action("Pre Sales Invoice Remarks")
            {
                ApplicationArea = All;
                Image = Comment;
                Promoted = true;
                RunObject = page "Remarks Part";
                RunPageLink = "Document No." = field("Remarks Order No."), "Document Type" = filter(Invoice), "Document Line No." = const(0);
            }

        }
        addafter("F&unctions")
        {
            action("Pre-Sale Invoice")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Report;
                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("No.", Rec."No.");
                    if SalesHeader.FindFirst() then
                        Report.RunModal(80006, true, true, SalesHeader);
                end;
            }
        }
        // addlast(Reporting)
        // {
        //     action("Pre sales Invoice")
        //     {
        //         ApplicationArea = All;
        //         Image = Report;
        //         Promoted = true;
        //         PromotedCategory = Report;
        //         trigger OnAction()
        //         var
        //             salesHeader: Record "Sales Header";
        //         begin
        //             salesHeader.SetRange("No.", Rec."No.");
        //             Report.Run(70000, true, false, salesHeader);
        //         end;
        //     }
        // }
    }
    trigger OnAfterGetCurrRecord()
    var
        SalereceiableSetup: Record "Sales & Receivables Setup";
    begin
        // if "Transaction Specification" <> '' then begin
        //     EditInsurancePolicyNo(EditInsuranceNoBool);
        //     CurrPage.Update(true);
        // end;
        SalereceiableSetup.Get();
        if Rec."PI Validity Date" = 0D then begin
            if Rec."Order Date" <> 0D then begin //19-12-2024 UAT Posting Issue
                Rec."PI Validity Date" := CalcDate(SalereceiableSetup."PI Validity Calculation", Rec."Order Date");
                Rec.Modify();
                CurrPage.Update();
            end
            else begin
                Rec."PI Validity Date" := 0D;
            end;
        end;
    end;

    trigger OnAfterGetRecord()
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document No.", Rec."No.");
        SalesLine.SetFilter("Quantity Shipped", '<>%1', 0);
        if SalesLine.FindFirst() then
            ShipmentEditable := false
        else
            ShipmentEditable := true;

    end;

    var

        ShipmentEditable: Boolean;
        EditInsuranceNoBool: Boolean;

}