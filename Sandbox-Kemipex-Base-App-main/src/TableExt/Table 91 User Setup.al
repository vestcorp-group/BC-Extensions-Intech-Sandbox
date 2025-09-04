tableextension 50251 KMP_UserSetup extends "User Setup"//T12370-N
{
    fields
    {
        field(50100; "Allow Short Close"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Short Close';
            Description = 'T12574-N';
        }
        field(50101; "Document Reopen"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Reopen';
        }
        // // Start Issue 50
        field(50102; "Allow Sales Unit of Measure"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Sales Unit of Measure';
        }
        field(50103; "Allow Payment Terms on Sales"; boolean)
        {
            DataClassification = ToBeClassified;
        }
        // // Stop Issue 50
        field(50104; "Show Qty.Calc.(Counting Sheet)"; Boolean)
        {
            Caption = 'Show Qty. Calculated';
            DataClassification = ToBeClassified;
        }
        field(50105; "Sales Support User"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50114; "Skip IC PO Restriction"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Skip IC PO Restriction';
        }
    }

    var
        myInt: Integer;
}