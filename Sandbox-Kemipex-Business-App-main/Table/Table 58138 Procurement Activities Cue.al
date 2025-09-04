table 58138 "Procurement Activities Cue"//T12370-Full Comment   //T13413-Full UnComment
{
    fields
    {
        field(1; "Primary"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(58019; "Approved BPO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Document Type" = filter("Blanket Order"), Status = filter(Released)));
        }
        field(58020; "Pending Approval BPO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Document Type" = filter("Blanket Order"), Status = filter("Pending Approval")));
        }
        field(58021; "Open BPO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Document Type" = filter("Blanket Order"), Status = filter(Open)));
        }
        field(58022; "Approved PO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Document Type" = filter("Order"), Status = filter(Released), "Buy-from IC Partner Code" = filter('')));
        }
        field(58023; "Pending Approval PO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Document Type" = filter("Order"), Status = filter("Pending Approval"), "Buy-from IC Partner Code" = filter('')));
        }
        field(58024; "Open PO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Document Type" = filter(Order), Status = filter(Open), "Buy-from IC Partner Code" = filter('')));
        }
    }
    keys
    {
        key(PrimaryKey; "Primary")
        {
            Clustered = TRUE;
        }
    }
}