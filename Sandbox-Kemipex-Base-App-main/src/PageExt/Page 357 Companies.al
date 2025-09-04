pageextension 50259 "Companies Ext" extends Companies//T12370-Full Comment
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addfirst(Navigation)
        {
            action("Short Names")
            {
                ApplicationArea = all;
                Caption = 'Short Names';
                Image = Link;
                RunObject = page "Company Short Names";
            }
        }
    }

    var
        myInt: Integer;
}