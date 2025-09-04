tableextension 74985 GL_Account_74985 extends "G/L Account"
{
    fields
    {
        // Add changes to table fields here
        field(50194; "GST Import Duty Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'GSTImport';
            TableRelation = "GST Import Duty Setup".Code;
        }
        //I-C0059-1001701-01-NS
        field(74985; "Source Code Filter"; Code[10])
        {
            Description = 'I-C0059-1001701-01';
            FieldClass = FlowFilter;
            TableRelation = "Source Code";
        }
        field(74986; "Balance at Date_Custom"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("No."),
                                                        "G/L Account No." = field(filter(Totaling)),
                                                        "Business Unit Code" = field("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                        "Posting Date" = field(upperlimit("Date Filter")),
                                                        "Source Code" = field("Source Code Filter")));
            Caption = 'Balance at Date (Source Code Filter)';
            Description = 'I-C0059-1001701-01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(74987; "Net Change_Custom"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("G/L Entry".Amount where("G/L Account No." = field("No."),
                                                        "G/L Account No." = field(filter(Totaling)),
                                                        "Business Unit Code" = field("Business Unit Filter"),
                                                        "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                        "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                        "Posting Date" = field("Date Filter"),
                                                        "Source Code" = field("Source Code Filter")));
            Caption = 'Net Change (Source Code Filter)';
            Description = 'I-C0059-1001701-01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(74988; "Debit Amount_Custom"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("G/L Entry"."Debit Amount" where("G/L Account No." = field("No."),
                                                                "G/L Account No." = field(filter(Totaling)),
                                                                "Business Unit Code" = field("Business Unit Filter"),
                                                                "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                "Posting Date" = field("Date Filter"),
                                                                "Source Code" = field("Source Code Filter")));
            Caption = 'Debit Amount (Source Code Filter)';
            Description = 'I-C0059-1001701-01';
            Editable = false;
            FieldClass = FlowField;
        }
        field(74989; "Credit Amount_Custom"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("G/L Entry"."Credit Amount" where("G/L Account No." = field("No."),
                                                                 "G/L Account No." = field(filter(Totaling)),
                                                                 "Business Unit Code" = field("Business Unit Filter"),
                                                                 "Global Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                 "Global Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                 "Posting Date" = field("Date Filter"),
                                                                 "Source Code" = field("Source Code Filter")));
            Caption = 'Credit Amount (Source Code Filter)';
            Description = 'I-C0059-1001701-01';
            Editable = false;
            FieldClass = FlowField;
        }
        //I-C0059-1001701-01-NE
    }

    var
        myInt: Integer;
}