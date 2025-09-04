report 50600 "IC-Profit Elimination"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'IC Profit Elimination';
    RDLCLayout = './Layouts/ICProfitElimination.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("IC Profit Elimination"; "IC Profit Elimination")
        {
            DataItemTableView = SORTING("Lot No.");

            column(compInfoName; compInfo.Name) { }
            column(startDate; startDate) { }
            column(endDate; endDate) { }
            column(Remaining_Quantity; "Remaining Quantity") { }
            column(unitCost; unitCost) { }
            column(totalValue; totalValue) { }
            column(Lot_No_; "Lot No.") { }
            column(Profit___IC; "Profit % IC") { }
            column(Unrealized_Profit; "Unrealized Profit") { }
            column(Bussines_Unit; "Bussines Unit") { }
            column(postingDate; postingDate) { }
            column(BU_CompName; BU_CompName) { }
            column(entryNo; entryNo) { }
            column(IC_Source_No_; "IC Source No.") { }
            column(Scenario; Scenario) { }

            trigger OnPreDataItem()
            begin
                compInfo.get();
                "Elimination Proces".GenerateLines(startDate, endDate);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(startDate; startDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Start Date';
                    }
                    field(endDate; endDate)
                    {
                        ApplicationArea = All;
                        Caption = 'End Date';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            // startDate := 20201201D;
            // endDate := 20210427D;
        end;
    }

    var
        startDate: Date;
        endDate: Date;
        compInfo: Record "Company Information";
        "Elimination Proces": Codeunit "Elimination Proces";
}