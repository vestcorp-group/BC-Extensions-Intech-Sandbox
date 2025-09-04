pageextension 70005 SaleOrderExt extends "Sales Order"//T12370-Full Comment
{
    layout
    {

        addlast(content)
        {
            group(Remarks)
            {
                Caption = 'Remarks';

            }
            part(SORemarks; "Remarks Part")
            {
                Caption = 'Sales Order Remarks ';
                SubPageLink = "Document Type" = const(Order), "Document No." = field("No.");
                ApplicationArea = all;
            }
            part(ShipmentRemarks; "Remarks Part")
            {
                Caption = 'Sales Shipment Remarks ';
                SubPageLink = "Document Type" = const(Shipment), "Document No." = field("No.");
                ApplicationArea = all;
            }
            part(InvoiceRemarks; "Remarks Part")
            {
                Caption = 'Sales Invoice Remarks ';
                SubPageLink = "Document Type" = const(Invoice), "Document No." = field("No.");
                ApplicationArea = all;
            }

        }
        addlast(content)
        {

        }
        addlast(content)
        {

        }
        addafter(Status)
        {

            field("Duty Exemption"; rec."Duty Exemption")
            {
                ApplicationArea = All;
            }

        }
        addlast(General)
        {
            field("Customer Registration Type."; rec."Customer Registration Type")
            {
                ApplicationArea = all;
                Editable = false;

            }

            field("Customer Registration No."; rec."Customer Registration No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
            field("PI Validity Date"; rec."PI Validity Date")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
        //UK::New requirement 070420>>
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                Customer_rec: Record Customer;
                CustomerRec: Record Customer;
            begin

                // if Customer_rec.get("Sell-to Customer No.") then
                //     if Customer_rec."seller Bank Detail" then
                //         EditableBoolean := false
                //     else
                //         EditableBoolean := true;

                if Rec."Sell-to Customer No." <> '' then begin
                    if CustomerRec.Get(Rec."Sell-to Customer No.") then
                        Rec."Customer Port of Discharge" := CustomerRec."Customer Port of Discharge"
                    else
                        Rec."Customer Port of Discharge" := '';
                end;

                Rec.EditBankonInvoice(EditBankInvoice);

            end;
        }
        modify("Bank on Invoice 2") //PackingListExtChange
        {
            Editable = EditBankInvoice;
        }
        //UK::New requirement 070420<<
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

    actions
    {
        addlast("&Print")
        {
            action("Proforma Invoice")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Report;
                Image = Report;
                Caption = 'Proforma Invoice';
                trigger OnAction()
                var
                    salesHeader: Record "Sales Header";
                begin
                    Commit();
                    salesHeader.SetRange("No.", Rec."No.");
                    if salesHeader.FindFirst() then
                        Report.RunModal(80011, true, false, salesHeader);
                end;
            }
        }
        addlast(processing)
        {
            action("Blanket Sales Order Remarks")
            {
                ApplicationArea = All;
                Image = Comment;
                Caption = 'Sales Order Remarks';
                Promoted = true;
                RunObject = page "Remarks Part";
                RunPageLink = "Document No." = field("No."), "Document Type" = filter(Order), "Document Line No." = const(0);
            }
            action("Sales Shipment Remarks")
            {
                ApplicationArea = All;
                Image = Comment;
                Promoted = true;
                RunObject = page "Remarks Part";
                RunPageLink = "Document No." = field("No."), "Document Type" = filter(Shipment), "Document Line No." = const(0);
            }
            action("Sales Invoice Remarks")
            {
                ApplicationArea = All;
                Image = Comment;
                Promoted = true;
                RunObject = page "Remarks Part";
                RunPageLink = "Document No." = field("No."), "Document Type" = filter(Invoice), "Document Line No." = const(0);
            }
        }
    }
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
        Rec.EditInsurancePolicyNo(EditInsuranceNoBool);
        Rec.EditBankonInvoice(EditBankInvoice);
        CurrPage.Update(false);
    end;

    trigger OnOpenPage()
    begin
        // IF Rec."No." <> '' then begin //UK::25062020
        //     EditInsuranceNoBool := false;
        //     EditInsurancePolicyNo(EditInsuranceNoBool);
        //     EditBankonInvoice(EditBankInvoice);
        //     CurrPage.Update();
        // end;
    end;
    // trigger OnAfterGetRecord()
    // var
    //     SalesHeader: Record "Sales Header";
    // begin
    //     // SalesHeader.SetRange("No.", "Remarks Order No.");
    //     // SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
    //     // if SalesHeader.FindFirst() then
    //     "Sales Order Date" := "Order Date";
    // end;


    var
        EditableBoolean: Boolean;

    trigger OnAfterGetCurrRecord()
    var
        SalereceiableSetup: Record "Sales & Receivables Setup";
    begin
        IF Rec."No." <> '' then begin //UK::25062020
            SalereceiableSetup.Get();
            if Rec."PI Validity Date" = 0D then begin
                if Rec."Order Date" <> 0D then
                    Rec."PI Validity Date" := CalcDate(SalereceiableSetup."PI Validity Calculation", Rec."Order Date")
                else
                    Rec."PI Validity Date" := 0D;
            End;
            Rec.EditInsurancePolicyNo(EditInsuranceNoBool);
            Rec.EditBankonInvoice(EditBankInvoice);
            CurrPage.Update(false);
        end;
    end;

    var
        [InDataSet]
        ShipmentEditable: Boolean;
        [InDataSet]
        EditInsuranceNoBool: Boolean;

        EditBankInvoice: Boolean;
}