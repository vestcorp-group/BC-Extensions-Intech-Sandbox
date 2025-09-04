report 50514 "Copy Alternate"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {

        dataitem("Lot Testing Parameter"; "Lot Testing Parameter")
        {
            trigger OnAfterGetRecord()
            var

            begin
#pragma warning disable AL0432 // TODO: - Will remove once it will be removed from the table-30-04-2022
                "Lot Testing Parameter".Value2 := "Lot Testing Parameter".Value;
#pragma warning restore AL0432 // TODO: - Will remove once it will be removed from the table-30-04-2022
                "Lot Testing Parameter".Modify();
            end;
        }
        dataitem("Posted Lot Testing Parameter"; "Posted Lot Testing Parameter")
        {
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
#pragma warning disable AL0432 // TODO: - Will remove once it will be removed from the table-30-04-2022
                "Posted Lot Testing Parameter".Value2 := "Posted Lot Testing Parameter".Value;
#pragma warning restore AL0432 // TODO: - Will remove once it will be removed from the table-30-04-2022
                "Posted Lot Testing Parameter".Modify();
            end;
        }
        dataitem("Item Testing Parameter"; "Item Testing Parameter")
        {
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
#pragma warning disable AL0432 // TODO: - Will remove once it will be removed from the table-30-04-2022
                "Item Testing Parameter".Value2 := "Item Testing Parameter".Value;
#pragma warning restore AL0432 // TODO: - Will remove once it will be removed from the table-30-04-2022
                "Item Testing Parameter".Modify();
            end;
        }

    }
}