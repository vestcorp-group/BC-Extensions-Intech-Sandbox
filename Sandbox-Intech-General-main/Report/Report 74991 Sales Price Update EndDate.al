Report 74991 "Sales Price Update EndDate"
{
    //SalesPriceEndDateUpdate
    Caption = 'Update Sales Price End Date Auto from Updated Price (Run Carefully)';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
#pragma warning disable
        dataitem("Sales Price"; "Sales Price")
        {
            DataItemTableView = sorting("Item No.", "Sales Type", "Sales Code", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity");

            trigger OnAfterGetRecord()
            var
                SP_lRec: Record "Sales Price";
            begin
#pragma warning disable
                Curr_gInt += 1;
                Win_gDlg.Update(2, Curr_gInt);

                if "Starting Date" = 0D then
                    CurrReport.Skip;


                SP_lRec.Reset;
                SP_lRec.SetRange("Item No.", "Item No.");
                SP_lRec.SetRange("Sales Type", "Sales Type");
                SP_lRec.SetRange("Sales Code", "Sales Code");
                SP_lRec.SetFilter("Starting Date", '<%1', "Starting Date");
                SP_lRec.SetRange("Currency Code", "Currency Code");
                SP_lRec.SetRange("Variant Code", "Variant Code");
                SP_lRec.SetRange("Unit of Measure Code", "Unit of Measure Code");
                SP_lRec.SetRange("Minimum Quantity", "Minimum Quantity");
                if SP_lRec.FindSet then begin
                    repeat
                        if (SP_lRec."Starting Date" <> 0D) and (SP_lRec."Ending Date" = 0D) then begin
                            SP_lRec."Ending Date" := "Starting Date" - 1;
                            SP_lRec.Modify;
                            ModCht_gInt += 1;
                        end;
                    until SP_lRec.Next = 0;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Win_gDlg.Close;
                Message('%1 - Entry Modify', ModCht_gInt);
            end;

            trigger OnPreDataItem()
            begin
                Win_gDlg.Open('Total #1##########\Current #2#############\Modify #3#########');
                Win_gDlg.Update(1, Count);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Win_gDlg: Dialog;
        Curr_gInt: Integer;
        ModCht_gInt: Integer;
}

