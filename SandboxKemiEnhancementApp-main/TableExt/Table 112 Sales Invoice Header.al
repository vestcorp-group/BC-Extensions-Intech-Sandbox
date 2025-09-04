tableextension 70002 SalesInvoiceExt extends "Sales Invoice Header"//T12370-N
{
    fields
    {
        field(50703; "Remarks Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50700; "Duty Exemption"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50704; "Sales Order Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70102; "Shipment Count"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(80001; "Customer Registration Type"; Text[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Registration"."Customer Registration Type";
            Editable = false;
        }
        field(80002; "Customer Registration No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(80003; "PI Validity Date"; Date)
        {
            DataClassification = ToBeClassified;
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
        }
        field(70101; "Customer Port of Discharge"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        //SD::GK 05/04/2020
        field(80010; "Customer Alternate Short Name"; Text[20])
        {

        }
        field(80011; "Customer Short Name"; Text[100])//Hypercare 25-02-2025 Length
        {
            DataClassification = ToBeClassified;
        }
        field(58037; "Tax Type"; Code[40])
        {
            TableRelation = TaxType;
            DataClassification = ToBeClassified;
        }
        //SD::GK 05/04/2020
        /*    modify("Sell-to Customer No.")
            {
                trigger OnAfterValidate()
                var
                    CustomerRec: Record Customer;
                begin
                    CustomerRec.get(Rec."Sell-to Customer No.");
                    Rec."Tax Type" := CustomerRec."Tax Type";
                    if Rec.Modify() then;
                end;
            }
    */
    }

    var
        myInt: Integer;
}
