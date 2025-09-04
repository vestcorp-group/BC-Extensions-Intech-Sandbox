Table 74982 "Buffer Table ExpData AutoFin"
{
    // ------------------------------------------------------------------------------------------------------------------------------------
    // Intech-Systems - info@intech-systems.com
    // ------------------------------------------------------------------------------------------------------------------------------------
    // ID                      Date          Author
    // ------------------------------------------------------------------------------------------------------------------------------------
    // I-A010_A-6000062-01     21/07/15      Nilesh Gajjar
    //                                       New Report - 50123 Item Bin Contents Detail
    //                                       Create New Table
    // ------------------------------------------------------------------------------------------------------------------------------------
    //AutoFinishProdOrder

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type';
            Editable = false;
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
        }
        field(51; "Decimal 1"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(52; "Decimal 2"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(53; "Decimal 3"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(54; "Decimal 4"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(55; "Decimal 5"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(56; "Decimal 6"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(57; "Decimal 7"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(58; "Decimal 8"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(59; "Decimal 9"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(60; "Decimal 10"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(61; "Decimal 11"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(62; "Decimal 12"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(63; "Decimal 13"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(64; "Decimal 14"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(65; "Decimal 15"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(66; "Decimal 16"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(67; "Decimal 17"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(68; "Decimal 18"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(69; "Decimal 19"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(70; "Decimal 20"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(71; "Decimal 21"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(72; "Decimal 22"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(73; "Decimal 23"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(74; "Decimal 24"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(75; "Decimal 25"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(76; "Decimal 26"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(77; "Decimal 27"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(78; "Decimal 28"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(79; "Decimal 29"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(80; "Decimal 30"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(81; "Decimal 31"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(82; "Decimal 32"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(83; "Decimal 33"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(84; "Decimal 34"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(85; "Decimal 35"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(86; "Decimal 36"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(87; "Decimal 37"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(88; "Decimal 38"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(89; "Decimal 39"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(90; "Decimal 40"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(91; "Decimal 41"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(92; "Decimal 42"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(93; "Decimal 43"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(94; "Decimal 44"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(95; "Decimal 45"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(96; "Decimal 46"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(97; "Decimal 47"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(98; "Decimal 48"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(99; "Decimal 49"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(100; "Decimal 50"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(101; "Integer 1"; Integer)
        {
        }
        field(102; "Integer 2"; Integer)
        {
        }
        field(103; "Integer 3"; Integer)
        {
        }
        field(104; "Integer 4"; Integer)
        {
        }
        field(105; "Integer 5"; Integer)
        {
        }
        field(106; "Integer 6"; Integer)
        {
        }
        field(107; "Integer 7"; Integer)
        {
        }
        field(108; "Integer 8"; Integer)
        {
        }
        field(109; "Integer 9"; Integer)
        {
        }
        field(110; "Integer 10"; Integer)
        {
        }
        field(151; "Date 1"; Date)
        {
        }
        field(152; "Date 2"; Date)
        {
        }
        field(153; "Date 3"; Date)
        {
        }
        field(154; "Date 4"; Date)
        {
        }
        field(155; "Date 5"; Date)
        {
        }
        field(156; "Date 6"; Date)
        {
        }
        field(157; "Date 7"; Date)
        {
        }
        field(158; "Date 8"; Date)
        {
        }
        field(159; "Date 9"; Date)
        {
        }
        field(160; "Date 10"; Date)
        {
        }
        field(201; "Text 1"; Text[100])
        {
        }
        field(202; "Text 2"; Text[100])
        {
        }
        field(203; "Text 3"; Text[100])
        {
        }
        field(204; "Text 4"; Text[100])
        {
        }
        field(205; "Text 5"; Text[100])
        {
        }
        field(206; "Text 6"; Text[50])
        {
            Description = 'GSTR';
        }
        field(207; "Text 7"; Text[50])
        {
            Description = 'GSTR';
        }
        field(208; "Text 8"; Text[50])
        {
            Description = 'GSTR';
        }
        field(209; "Text 9"; Text[250])
        {
            Description = 'GSTR';
        }
        field(210; "Text 10"; Text[250])
        {
            Description = 'GSTR';
        }
        field(211; "Text 11"; Text[250])
        {
            Description = 'GSTR';
        }
        field(212; "Text 12"; Text[250])
        {
            Description = 'GSTR';
        }
        field(213; "Text 13"; Text[250])
        {
            Description = 'GSTR';
        }
        field(214; "Text 14"; Text[50])
        {
            Description = 'GSTR';
        }
        field(215; "Text 15"; Text[50])
        {
            Description = 'GSTR';
        }
        field(216; "Text 16"; Text[50])
        {
            Description = 'GSTR';
        }
        field(217; "Text 17"; Text[50])
        {
            Description = 'GSTR';
        }
        field(301; "Code 1"; Code[20])
        {
            Editable = false;
        }
        field(302; "Code 2"; Code[20])
        {
            Editable = false;
        }
        field(303; "Code 3"; Code[20])
        {
            Editable = false;
        }
        field(304; "Code 4"; Code[20])
        {
            Editable = false;
        }
        field(305; "Code 5"; Code[20])
        {
            Editable = false;
        }
        field(351; "Big Code 1"; Code[35])
        {
            Editable = false;
        }
        field(352; "Big Code 2"; Code[35])
        {
            Editable = false;
        }
        field(353; "Big Code 3"; Code[35])
        {
            Editable = false;
        }
        field(354; "Big Code 4"; Code[35])
        {
            Editable = false;
        }
        field(355; "Big Code 5"; Code[35])
        {
            Editable = false;
        }
        field(401; "Boolean 1"; Boolean)
        {
            Editable = false;
        }
        field(402; "Boolean 2"; Boolean)
        {
            Editable = false;
        }
        field(403; "Boolean 3"; Boolean)
        {
            Editable = false;
        }
        field(404; "Boolean 4"; Boolean)
        {
            Editable = false;
        }
        field(405; "Boolean 5"; Boolean)
        {
            Editable = false;
        }
        field(601; "Decimal 51"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(602; "Decimal 52"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(603; "Decimal 53"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(604; "Decimal 54"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(605; "Decimal 55"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(606; "Decimal 56"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(607; "Decimal 57"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(608; "Decimal 58"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(609; "Decimal 59"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(610; "Decimal 60"; Decimal)
        {
            BlankZero = true;
            Editable = false;
        }
        field(611; "Code 6"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
        key(Key2; "Date 1")
        {
        }
    }

    fieldgroups
    {
    }
}

