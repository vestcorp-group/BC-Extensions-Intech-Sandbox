table 58166 SalespersonActivityCue//T12370-Full Comment    //T13413-Full UnComment
{
    fields
    {
        field(1; "Primary"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Approved BSO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = filter("Blanket Order"), Status = filter(Released), "Salesperson Code" = field("Salesperson Code Filter")));
        }
        field(3; "Pending Approval BSO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = filter("Blanket Order"), Status = filter("Pending Approval"), "Salesperson Code" = field("Salesperson Code Filter")));
        }
        field(4; "Open BSO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = filter("Blanket Order"), Status = filter(Open), "Salesperson Code" = field("Salesperson Code Filter")));
        }
        field(5; "Approved SO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order), Status = filter(Released), "Salesperson Code" = field("Salesperson Code Filter")));
        }
        field(6; "Pending Approval SO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order), Status = filter("Pending Approval"), "Salesperson Code" = field("Salesperson Code Filter")));
        }
        field(7; "Open SO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order), Status = filter(Open), "Salesperson Code" = field("Salesperson Code Filter")));
        }
        field(8; "Salesperson Code Filter"; Code[20])
        {

            FieldClass = FlowFilter;
        }
        field(9; "Sales Team Filter"; Code[200])
        {
            FieldClass = FlowFilter;
        }

        field(10; "Team Approved BSO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = filter("Blanket Order"), Status = filter(Released), "Salesperson Code" = field("Sales Team Filter")));
        }
        field(11; "Team Pending Approval BSO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = filter("Blanket Order"), Status = filter("Pending Approval"), "Salesperson Code" = field("Sales Team Filter")));
        }
        field(12; "Team Open BSO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = filter("Blanket Order"), Status = filter(Open), "Salesperson Code" = field("Sales Team Filter")));
        }
        field(13; "Team Approved SO"; Integer)
        {

            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order), Status = filter(Released), "Salesperson Code" = field("Sales Team Filter")));
        }
        field(14; "Team Pending Approval SO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order), Status = filter("Pending Approval"), "Salesperson Code" = field("Sales Team Filter")));
        }
        field(15; "Team Open SO"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Sales Header" where("Document Type" = filter(Order), Status = filter(Open), "Salesperson Code" = field("Sales Team Filter")));
        }

    }
    keys
    {
        key(PrimaryKey; "Primary")
        {
            Clustered = TRUE;
        }
    }

    trigger OnModify()
    var
        usersetup: Record "User Setup";
    begin

    end;

    var

        SP: Code[20];
}