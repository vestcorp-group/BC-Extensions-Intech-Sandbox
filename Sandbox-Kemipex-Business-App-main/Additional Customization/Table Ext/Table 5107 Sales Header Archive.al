tableextension 53017 SalesHdrArchive extends "Sales Header Archive"//T12370-Full Comment  //T12574-N
{
    fields
    {
        field(58022; "Advance Payment"; Boolean)
        {
            Editable = false;
        }
        field(53100; "Price Changed"; Boolean)
        {
            Caption = 'Price Changed';
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = exist("Sales Line" where("Document Type" = field("Document Type"), "Document No." = field("No."), "Price Changed" = const(true), Type = const(Item)));
        }
        field(53101; "Payment Terms Changed"; Boolean)
        {
            Caption = 'Payment Terms Changed';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(53102; "Initial Payment Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(53103; "Excess Payment Terms Days"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(53104; "Sub Status"; Text[150])
        {
            DataClassification = ToBeClassified;
            //Editable = false;
        }
        field(53105; "Salesperson Name"; Text[50])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Salesperson/Purchaser".Name where(Code = field("Salesperson Code")));
        }
        field(53106; "Credit Limit Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53107; "Price Change %"; Decimal)
        {
            Caption = 'Price Change %';
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = min("Sales Line"."Price Change %" where("Document Type" = field("Document Type"), "Document No." = field("No."), Type = const(Item), "Price Change %" = filter('<>0')));
        }
        field(53108; "Credit Limit 1st Range"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53109; "Credit Limit 2nd Range"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53111; "Credit Limit 3rd Range"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53112; "Price Change % 1st Range"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53113; "Price Change % 2nd Range"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53114; "Price Change % 3rd Range"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}
