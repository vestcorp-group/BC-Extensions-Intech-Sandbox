tableextension 75025 GL_Enrty_75025 extends "G/L Entry"
{
    keys
    {
        //I-C0059-1001701-01-NS
        key(Key71; "G/L Account No.", "Posting Date", "Source Code", "Business Unit Code", "Global Dimension 1 Code", "Global Dimension 2 Code")
        {
            SumIndexFields = Amount;
        }
        //I-C0059-1001701-01-NE
    }
}