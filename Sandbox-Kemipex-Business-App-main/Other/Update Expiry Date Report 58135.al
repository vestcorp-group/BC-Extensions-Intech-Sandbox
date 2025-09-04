report 58135 "Update_expiry"//T12370-Full Comment//HyperCare
{
    UsageCategory = Administration;
    Caption = 'Update Expiry Date from Manufacturing Date';
    ApplicationArea = All;
    ProcessingOnly = true;
    Permissions = tabledata "item Ledger Entry" = RM;

    dataset
    {
        dataitem("Item Ledger Entry"; "Item Ledger Entry")
        {
            DataItemTableView = where("Manufacturing Date 2" = filter(<> ''), "Expiry Period 2" = filter(<> ''), "Remaining Quantity" = filter('<>0'));
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                "Expiration Date" := CalcDate("Expiry Period 2", "Manufacturing Date 2");
                if Modify() then;

            end;
        }
    }
    var
        myInt: Integer;
}