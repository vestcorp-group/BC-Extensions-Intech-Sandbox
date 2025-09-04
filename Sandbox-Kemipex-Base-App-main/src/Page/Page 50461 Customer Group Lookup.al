page 50461 "Customer Group Lookup"//T12370-N
{
    PageType = List;
    Editable = false;
    SourceTable = "Customer Group";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Customer Group Code"; rec."Customer Group Code")
                {
                    ApplicationArea = All;

                }
                field("Description/Name"; rec."Description/Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


}