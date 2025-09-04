pageextension 70001 "SalesQuotes Extension" extends "Sales Quote" //UAT 12-12-2024
{
    layout
    {
        addlast(content)
        {
            group(Remarks3)
            {
                Caption = 'Remarks';
                part(Remarks2; "Remarks Part")
                {
                    SubPageLink = "Document Type" = const("Quote"), "Document No." = field("No.");
                    ApplicationArea = all;
                }
            }

        }
        addafter(Status)
        {
            field("Duty Exemption"; rec."Duty Exemption")
            {
                ApplicationArea = all;
            }

        }
        addlast(General)
        {
            //             field("Customer Registration Type."; rec."Customer Registration Type")
            //             {
            //                 ApplicationArea = all;
            //                 Editable = false;
            //             }
            //             field("Customer Registration No."; rec."Customer Registration No.")
            //             {
            //                 ApplicationArea = all;
            //                 Editable = false;
            //             }
            //T12724 NS 07112024
            field("PI Validity Date"; rec."PI Validity Date")
            {
                ApplicationArea = all;

            }
            // field("Bank on Invoice 2"; rec."Bank on Invoice 2")
            // {
            //     Caption = 'Bank on Invoice';
            //     ApplicationArea = All;
            //     Editable = EditBankInvoice;
            // }//T-12855-AS
            //T12724 NE 07112024
        }
        //UK::New requirement 070420>>
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                Customer_rec: Record Customer;
            begin

                // if Customer_rec.get("Sell-to Customer No.") then
                //     if Customer_rec."seller Bank Detail" then
                //         EditableBoolean := false
                //     else
                //         EditableBoolean := true;

                rec.EditBankonInvoice(EditBankInvoice);
            end;
        }
        // modify("Bank on Invoice 2") //PackingListExtChange
        // {
        //     Editable = EditBankInvoice;
        // }
        //UK::New requirement 070420<<
        addafter("Order Date")
        {
            field("Shipment Term"; rec."Shipment Term")
            {
                ApplicationArea = All;
                Editable = ShipmentEditable;

            }
            field("Insurance Policy No."; rec."Insurance Policy No.")
            {
                ApplicationArea = All;
                Editable = EditInsuranceNoBool;
            }
            field("Customer Port of Discharge"; rec."Customer Port of Discharge")
            {
                ApplicationArea = All;
            }
        }
        modify("Transaction Specification")
        {
            // Caption = 'Incoterm'; // 08-01-2025 Hyper care Support
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
    actions
    {
        //         // Add changes to page actions here
        //T12724 NS 07112024
        addlast(processing)
        {
            action(Remarks)
            {
                ApplicationArea = All;
                Image = Comment;
                Promoted = true;
                RunObject = page "Remarks Part";
                RunPageLink = "Document No." = field("No."), "Document Type" = filter("Blanket Order"), "Document Line No." = const(0);
            }
        }
        //T12724 NE 07112024
        //         addafter(Print)
        //         {
        //             /* action("Print Preview")
        //              {
        //                  ApplicationArea = all;
        //                  Promoted = true;
        //                  PromotedIsBig = true;
        //                  PromotedCategory = Category6;
        //                  trigger OnAction()
        //                  var
        //                      salesHeader: Record "Sales Header";
        //                  begin
        //                      salesHeader.Reset();
        //                      salesHeader.SetRange("No.", Rec."No.");
        //                      if salesHeader.FindSet() then
        //                          Report.RunModal(Report::"Blanket Sales_PI Preview", true, true, salesHeader);
        //                  end;
        //              } */
        //         }
        addlast("F&unctions")
        {
            // action("Proforma Invoice")
            // {
            //     PromotedCategory = Report;
            //     Promoted = true;
            //     Image = Report;
            //     ApplicationArea = All;
            //     trigger OnAction()
            //     var
            //         salesHeader: Record "Sales Header";
            //     begin
            //         salesHeader.SetRange("No.", Rec."No.");
            //         if salesHeader.FindFirst() then
            //             Report.RunModal(80011, true, false, salesHeader);
            //     end;
            // }
        }
    }
    trigger OnOpenPage()
    var
    begin
        rec.EditBankonInvoice(EditBankInvoice);
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
        rec.EditInsurancePolicyNo(EditInsuranceNoBool);
        rec.EditBankonInvoice(EditBankInvoice);
        CurrPage.Update(false);
    end;

    var

    trigger OnAfterGetCurrRecord()
    var
        SalereceiableSetup: Record "Sales & Receivables Setup";
    begin
        SalereceiableSetup.Get();
        If rec."PI Validity Date" = 0D then begin
            if rec."Order Date" <> 0D then
                rec."PI Validity Date" := CalcDate(SalereceiableSetup."PI Validity Calculation", rec."Order Date")
            else
                rec."PI Validity Date" := 0D;
        end;
        rec.EditBankonInvoice(EditBankInvoice);
    end;

    var
        EditBankInvoice: Boolean;

        [InDataSet]
        ShipmentEditable: Boolean;
        [InDataSet]
        EditInsuranceNoBool: Boolean;
        CurrePage: Page "Change Exchange Rate";

}