/// <summary>
/// TableExtension G/L Entry Ext (ID 60104) extends Record G/L Entry.
/// </summary>
tableextension 54003 "G/L Entry Ext" extends "G/L Entry"
{
    fields
    {
        // Add changes to table fields here
        field(60100; "Upload Document No."; code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50600; "IC Elimination"; Boolean)
        {

        }
        field(50601; "IC Elimination Reversed"; boolean)
        {

        }
    }

}