pageextension 50122 GLEntriesExt extends "General Ledger Entries"  //T49067-N
{
    layout
    {
        addafter("Document No.")
        {
            field("Document Date"; Rec."Document Date")
            {
                ApplicationArea = All;
                Description = 'T49067';
            }
        }
    }

}