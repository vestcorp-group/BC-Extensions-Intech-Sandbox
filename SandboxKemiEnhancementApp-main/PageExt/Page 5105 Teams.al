pageextension 70103 TeamsPgext extends Teams//T12370-Full Comment   //T13413-Full UnComment
{
    layout
    {
        addafter(Name)
        {
            field("Hide From Reports"; rec."Hide From Reports")
            {
                ApplicationArea = all;

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}