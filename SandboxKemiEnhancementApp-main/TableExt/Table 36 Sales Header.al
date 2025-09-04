tableextension 70000 "Sales Header Extension" extends "Sales Header"//T12370-Full Comment
{
    fields
    {
        field(50700; "Duty Exemption"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50703; "Remarks Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50704; "Sales Order Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51100; "Commercial Card No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(80001; "Customer Registration Type"; Text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Registration"."Customer Registration Type";
        }
        field(80002; "Customer Registration No."; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(80003; "PI Validity Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        //SD::GK 05/04/2020
        field(80010; "Customer Alternate Short Name"; Text[20])
        {

        }
        field(80011; "Customer Short Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        //SD::GK 05/04/2020
        modify("Order Date")
        {
            trigger OnAfterValidate()
            var
                SalesReceivablesSetup: Record "Sales & Receivables Setup";
            Begin
                SalesReceivablesSetup.Get();
                if "Order Date" <> 0D then
                    "PI Validity Date" := CalcDate(SalesReceivablesSetup."PI Validity Calculation", "Order Date")
                else
                    "PI Validity Date" := 0D;

            End;
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                CustomerRegistration: Record "Customer Registration";
                CustomerRec: Record Customer;
                Customer_rec: Record Customer;
                CustomerRec1: Record Customer;
            begin

                if "Sell-to Customer No." <> '' then begin
                    if CustomerRec.Get("Sell-to Customer No.") and (CustomerRec."Customer Registration Type" <> '') then begin
                        // if CustomerRegistration.Get(CustomerRec."Customer Registration Type") then begin
                        "Customer Registration Type" := CustomerRec."Customer Registration Type";
                        "Customer Registration No." := CustomerRec."Customer Registration No.";
                        "Tax Type" := CustomerRec."Tax Type";

                        if Modify() then;
                        //end;
                    end
                    else begin
                        "Customer Registration No." := '';
                        "Customer Registration Type" := '';
                    end;
                end
                else begin
                    "Customer Registration No." := '';
                    "Customer Registration Type" := '';
                end;

                if "Sell-to Customer No." <> '' then begin
                    if CustomerRec1.Get("Sell-to Customer No.") then
                        if CustomerRec1."Customer Port of Discharge" <> '' then
                            "Customer Port of Discharge" := CustomerRec1."Customer Port of Discharge";
                end;
                //SD::GK 05/04/2020
                if "Sell-to Customer No." <> '' then begin
                    if CustomerRec1.Get("Sell-to Customer No.") then begin
                        if CustomerRec1.AltCustomerName <> '' then
                            "Customer Alternate Short Name" := CustomerRec1.AltCustomerName
                        else
                            "Customer Alternate Short Name" := '';
                        if CustomerRec1."Search Name" <> '' then
                            "Customer Short Name" := CustomerRec1."Search Name"
                        else
                            "Customer Short Name" := '';
                    end;
                end;


                //    CustomerRec.get(Rec."Sell-to Customer No.");
                //  if Rec.Modify() then;
                //SD::GK 05/04/2020
            end;
        }

        field(70000; "Posting Date Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(70001; "Shipment Term"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "One Shipment","Partial Shipment";
        }
        field(70100; "Insurance Policy No."; Text[30])
        {

            DataClassification = ToBeClassified;
            //Editable = EditInsuranceNo;
        }
        field(70101; "Customer Port of Discharge"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Area";
        }
        field(70102; "Shipment Count"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(58037; "Tax Type"; Code[40])
        {
            TableRelation = TaxType;
            DataClassification = ToBeClassified;
        }

        // modify("Shipment Method Code")
        // {
        //     trigger OnAfterValidate()
        //     var
        //     begin
        //         // "Transaction Specification" := "Shipment Method Code";
        //     end;
        // }
        // modify("Transaction Specification")
        // {
        //     trigger OnAfterValidate()
        //     var
        //         TransactionSpec: Record "Transaction Specification";
        //         CompanyInfo: Record "Company Information";

        //     begin
        //         CompanyInfo.Get();
        //         if "Transaction Specification" <> '' then begin
        //             if TransactionSpec.Get("Transaction Specification") then begin
        //                 if TransactionSpec."Insurance By" = TransactionSpec."Insurance By"::Seller then begin
        //                     Clear("Insurance Policy No.");
        //                     "Insurance Policy No." := CompanyInfo."Insurance Policy Number";
        //                     Modify();
        //                 end
        //                 else
        //                     if TransactionSpec."Insurance By" = TransactionSpec."Insurance By"::Buyer then begin
        //                         Clear("Insurance Policy No.");
        //                     end;
        //             end;
        //         end;
        //     end;

        // }
    }
    // trigger OnAfterInsert()
    // begin
    //     "Sales Order Date" := "Order Date";
    // end;

    procedure EditInsurancePolicyNo(var EditInsuranceNo: Boolean)
    var
        TransactionSpecification: Record "Transaction Specification";
    begin
        if TransactionSpecification.Get("Transaction Specification") then begin
            if TransactionSpecification."Insurance By" = TransactionSpecification."Insurance By"::Buyer then
                EditInsuranceNo := true
            else
                if TransactionSpecification."Insurance By" = TransactionSpecification."Insurance By"::Seller then
                    EditInsuranceNo := false;
        end;
    end;

    procedure EditBankonInvoice(var EditBankOninvoice: Boolean)
    var
        CustomerRec: Record Customer;
    begin
        if "Sell-to Customer No." <> '' then
            if CustomerRec.get("Sell-to Customer No.") then
                if CustomerRec."seller Bank Detail" then begin
                    EditBankOninvoice := false;
                    // "Bank on Invoice" := '';
                    // Modify();
                end
                else
                    if not CustomerRec."seller Bank Detail" then begin
                        EditBankOninvoice := true;
                    end;
    end;

    var
        DateTime: DateTime;
}