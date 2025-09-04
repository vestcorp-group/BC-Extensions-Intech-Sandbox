Page 74990 "Auto finished Prod. Order"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Production Order";
    SourceTableView = sorting(Status, "No.")
                      where("Finished from batch job" = filter(true));

    //AutoFinishProdOrder

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                }

                field("Finished Date from batch job"; Rec."Finished Date from batch job")
                {
                    ApplicationArea = Basic;
                }
                field("Finished By from batch job"; Rec."Finished By from batch job")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
    }
}

