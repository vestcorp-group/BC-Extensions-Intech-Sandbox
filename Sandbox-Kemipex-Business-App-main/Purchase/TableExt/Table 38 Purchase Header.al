tableextension 58001 PurchaseHeaderExt extends "Purchase Header"
{
    fields
    {
        field(50000; "Payment Worsen"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'T50306';
        }
        field(50001; "Price Comparison"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'T50306';
        }
        field(50002; "New Product"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'T50306';
        }
        field(50003; "Limit Payable"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'T50306';
        }
        field(50004; "Short Close Qty < 5"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'T50306';
        }
        field(50005; "Short Close Qty > 5"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'T50306';
        }
        field(50006; "OverDue"; Boolean)
        {
            DataClassification = ToBeClassified;
            Description = 'T50306';
        }
        field(50007; "FA Exist"; Boolean)
        {
            Description = 'T50306';
            FieldClass = FlowField;
            CalcFormula = exist("Purchase Line" where("Document Type" = field("Document Type"), "Document No." = field("No."), Type = const("Fixed Asset")));
        }


    }
}