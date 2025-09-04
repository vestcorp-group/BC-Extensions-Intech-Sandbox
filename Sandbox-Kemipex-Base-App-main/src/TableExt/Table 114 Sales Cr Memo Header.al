tableextension 50399 SalesCrMemoHeaderTblExt extends "Sales Cr.Memo Header"//T12370-N
{
    // version NAVW113.00
    fields
    {
        field(50011; "Seller/Buyer 2"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //Moved from Packing list Extension 
        field(50012; "Bank on Invoice 2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account";
        }
        field(50013; "Inspection Required 2"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Legalization Required 2"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "LC No. 2"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "LC Date 2"; Date)
        {
            DataClassification = ToBeClassified;
        }
        // field(50017; "Customer Group Code"; Code[20])
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = lookup(Customer."Customer Group Code" where("No." = field("Bill-to Customer No.")));
        // }
        // field(50018; "Customer Group Code 2"; Code[200])
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = lookup(Customer."Customer Group Code 2" where("No." = field("Bill-to Customer No.")));
        // }
 //T13919-NS
        field(50017; "IC Transaction No."; Integer)
        {

        }
         //T13919-NE
    }
}