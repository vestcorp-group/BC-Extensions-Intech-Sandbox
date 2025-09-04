tableextension 70004 SalesCrMemoExt extends "Sales Cr.Memo Header"//T12370-Full Comment T12946-Code Uncommented
{
    fields
    {
        field(50703; "Remarks Order No."; Code[20])
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
            // Editable =EditInsuranceNo;
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
        //SD::GK 05/04/2020
    }

    var
        myInt: Integer;
}