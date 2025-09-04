tableextension 75023 Transfer_Shipment_Header_74342 extends "Transfer Shipment Header"
{
    fields
    {
        // Add changes to table fields here
        field(74331; "Party No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(74332; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(74333; "Name 2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(74334; Address; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(74335; "Address 2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(74336; "Post Code"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(74337; City; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(74338; "Country/Region Code"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(74339; "Party Type"; Enum "Transfer Party Type Enum")
        {
            DataClassification = ToBeClassified;
        }
        field(74340; "Returnable Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }


    var
        myInt: Integer;
}