tableextension 50802 InventorySetupExt extends "Inventory Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50801; "Stock Count Template"; Code[20])
        {
            TableRelation = "Item Journal Template";

        }
        field(50802; "Stock Count Batch"; Code[20])
        {
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Stock Count Template"));
        }
        field(50803; "Allow Inv. Post. Group Modify"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                ConfirmChange: Boolean;
                SecondConfirm: Boolean;
            begin
                if "Allow Inv. Post. Group Modify" then begin
                    ConfirmChange := Dialog.Confirm('Are you sure you want to allow change inventory posting group?', true);
                    if ConfirmChange = false then begin
                        Rec."Allow Inv. Post. Group Modify" := false;
                    end else
                        exit

                end;
            end;
        }
    }

    var
        myInt: Integer;
}