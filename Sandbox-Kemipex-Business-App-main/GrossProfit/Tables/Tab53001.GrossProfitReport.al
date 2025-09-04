table 53001 "Gross Profit Report"//T12370-Full Comment T12946-Code Uncommented
{
    Caption = 'Gross Profit Report';
    DataClassification = ToBeClassified;
    DataPerCompany = false;
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Group Co."; Code[20])
        {
            Caption = 'Group Co.';
            DataClassification = ToBeClassified;
        }
        field(3; "SO Date"; Date)
        {
            Caption = 'SO Date';
            DataClassification = ToBeClassified;
        }
        field(4; "SO No."; Code[20])
        {
            Caption = 'SO No.';
            DataClassification = ToBeClassified;
        }
        field(5; "SI Date"; Date)
        {
            Caption = 'SI Date';
            DataClassification = ToBeClassified;
        }
        field(6; "SI No."; Code[20])
        {
            Caption = 'SI No.';
            DataClassification = ToBeClassified;
        }
        field(7; POL; Code[100])
        {
            Caption = 'POL';
            DataClassification = ToBeClassified;
        }
        field(8; POD; Code[50])
        {
            Caption = 'POD';
            DataClassification = ToBeClassified;
        }
        field(9; "Customer Code"; Code[20])
        {
            Caption = 'Customer Code';
            DataClassification = ToBeClassified;
        }
        field(10; "Customer Short Name"; Text[100]) //50-100 Hypercare Length increase
        {
            Caption = 'Customer Short Name';
            DataClassification = ToBeClassified;
        }
        field(11; Teams; Text[50])
        {
            Caption = 'Teams';
            DataClassification = ToBeClassified;
        }
        field(12; "Salesperson Name"; Text[50])
        {
            Caption = 'Salesperson Name';
            DataClassification = ToBeClassified;
        }
        field(13; Incoterm; Text[20])
        {
            Caption = 'Incoterm';
            DataClassification = ToBeClassified;
        }
        field(14; "Item Code"; Code[20])
        {
            Caption = 'Item Code';
            DataClassification = ToBeClassified;
        }
        field(15; "Item Short Name"; Text[50])
        {
            Caption = 'Item Short Name';
            DataClassification = ToBeClassified;
        }
        field(16; "Item Category"; Text[50])
        {
            Caption = 'Item Category';
            DataClassification = ToBeClassified;
        }
        field(17; "Item Market Industry"; Text[100])
        {
            Caption = 'Item Market Industry';
            DataClassification = ToBeClassified;
        }
        field(53; "Item Incentive Point (IIP)"; Integer)
        {
            Caption = 'Item Incentive Point (IIP)';
            DataClassification = ToBeClassified;
        }
        field(54; "Customer Incentive Point (CIP)"; Integer)
        {
            Caption = 'Customer Incentive Point (CIP)';
            DataClassification = ToBeClassified;
        }
        field(18; "Base UOM"; Code[20])
        {
            Caption = 'Base UOM';
            DataClassification = ToBeClassified;
        }
        field(19; QTY; Decimal)
        {
            Caption = 'QTY';
            DataClassification = ToBeClassified;
        }
        field(20; CUR; Code[20])
        {
            Caption = 'CUR';
            DataClassification = ToBeClassified;
        }
        field(21; "Base UOM Price"; Decimal)
        {
            Caption = 'Base UOM Price';
            DataClassification = ToBeClassified;
        }
        field(22; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DataClassification = ToBeClassified;
        }
        field(23; "Cogs (LCY)"; Decimal)
        {
            Caption = 'Cogs (LCY)';
            DataClassification = ToBeClassified;
        }
        field(24; "Other Revenue (LCY)"; Decimal)
        {
            Caption = 'Other Revenue (LCY)';
            DataClassification = ToBeClassified;
        }
        field(25; "Total Amount (LCY)"; Decimal)
        {
            Caption = 'Total Amount (LCY)';
            DataClassification = ToBeClassified;
        }
        field(26; "EXP-FRT"; Decimal)
        {
            Caption = 'EXP-FRT';
            DataClassification = ToBeClassified;
        }
        field(27; "EXP-THC"; Decimal)
        {
            Caption = 'EXP-THC';
            DataClassification = ToBeClassified;
        }
        field(28; "EXP-CDT"; Decimal)
        {
            Caption = 'EXP-CDT';
            DataClassification = ToBeClassified;
        }
        field(29; "EXP-TRC"; Decimal)
        {
            Caption = 'EXP-TRC';
            DataClassification = ToBeClassified;
        }
        field(30; "EXP-OTHER"; Decimal)
        {
            Caption = 'EXP-OTHER';
            DataClassification = ToBeClassified;
        }
        field(31; "EXP-INS"; Decimal)
        {
            Caption = 'EXP-INS';
            DataClassification = ToBeClassified;
        }
        field(32; "EXP-SERV"; Decimal)
        {
            Caption = 'EXP-SERV';
            DataClassification = ToBeClassified;
        }
        field(33; "EXP-INPC"; Decimal)
        {
            Caption = 'EXP-INPC';
            DataClassification = ToBeClassified;
        }
        field(34; "EXP-WH PACK"; Decimal)
        {
            Caption = 'EXP-WH PACK';
            DataClassification = ToBeClassified;
        }
        field(35; "EXP-WH HNDL"; Decimal)
        {
            Caption = 'EXP-WH HNDL';
            DataClassification = ToBeClassified;
        }
        field(36; "EXP-LEGAL"; Decimal)
        {
            Caption = 'EXP-LEGAL';
            DataClassification = ToBeClassified;
        }
        field(37; "EXP-COO"; Decimal)
        {
            Caption = 'EXP-COO';
            DataClassification = ToBeClassified;
        }
        field(38; "REBATE TO CUSTOMER"; Decimal)
        {
            Caption = 'REBATE TO CUSTOMER';
            DataClassification = ToBeClassified;
        }
        field(39; "DEMURRAGE CHARGES"; Decimal)
        {
            Caption = 'DEMURRAGE CHARGES';
            DataClassification = ToBeClassified;
        }
        field(40; "Total Sales Discount"; Decimal)
        {
            Caption = 'Total Sales Discount';
            DataClassification = ToBeClassified;
        }
        field(41; "Total Sales Expenses (LCY)"; Decimal)
        {
            Caption = 'Total Sales Expenses (LCY)';
            DataClassification = ToBeClassified;
        }
        field(42; "COS (LCY)"; Decimal)
        {
            Caption = 'COS (LCY)';
            DataClassification = ToBeClassified;
        }
        field(43; "Eff GP (LCY)"; Decimal)
        {
            Caption = 'Eff GP (LCY)';
            DataClassification = ToBeClassified;
        }
        field(44; "Eff GP %"; Decimal)
        {
            Caption = 'Eff GP %';
            DataClassification = ToBeClassified;
        }
        field(45; "Total"; Decimal)
        {
            Caption = 'Total';
            DataClassification = ToBeClassified;
        }
        field(46; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Invoice","Credit Memo";
        }
        field(47; "IC Company Code"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Custom LOT No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Vendor Invoice No."; code[40])
        {
            DataClassification = ToBeClassified;
        }
        field(50; "Created By Other Instance"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = ToBeClassified;
        }
        field(52; "Other Charges"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Variant Code"; code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Hypercare 17-02-2025';
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}
