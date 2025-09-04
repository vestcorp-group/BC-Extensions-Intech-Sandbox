report 80120 "Stock Aging Analysis"//T12370-Full Comment T12946-Code Uncommented
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'ST03 Stock Aging Analysis';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Layout_80120_StockAgingAnalysis.rdl';
    dataset
    {
        dataitem(Integer; Integer)
        {
            DataItemTableView = sorting(Number);
            column(Number; Number) { }
            column(ReportCaption; ReportCaption) { }
            column(Company_Name; Comp_Name) { }
            column(ShortNameCom; ShortNameCom."Short Name") { }
            column(PeriodStartDate_; FORMAT(PeriodStartDate[2], 0, '<Day>-<Month Text>-<Year4>')) { }
            dataitem(Item; Item)
            {
                DataItemTableView = SORTING(Description) WHERE("Inventory Posting Group" = FILTER('<>SAMPLE'));
                RequestFilterFields = "Item Category Code", "No.";
                column(Item_No; Item."No.") { }
                column(Description; Item.Description) { }
                column(UOM; Item."Base Unit of Measure") { }
                column(Inventory; Item.Inventory) { }
                column(Inventory_Posting_Group; "Inventory Posting Group") { }
                column(AvlQty1; AvlQty[1]) { }
                column(AvlQty2; AvlQty[2]) { }
                column(AvlQty3; AvlQty[3]) { }
                column(AvlQty4; AvlQty[4]) { }
                column(AvlQty5; AvlQty[5]) { }
                column(AvlQty6; AvlQty[6]) { }
                column(AvlQty7; AvlQty[7]) { }
                column(Unit_Cost; Item."Unit Cost") { }
                column(PeriodStartDate2; FORMAT(PeriodStartDate[2], 0, '<Day>-<Month Text>-<Year4>')) { }
                column(PeriodStartDate3; PeriodStartDate[3]) { }
                column(PeriodStartDate4; PeriodStartDate[4]) { }
                column(PeriodStartDate5; PeriodStartDate[5]) { }
                column(PeriodStartDate31; Format(PeriodStartDate[3] - 1)) { }
                column(PeriodStartDate41; Format(PeriodStartDate[4] - 1)) { }
                column(PeriodStartDate51; Format(PeriodStartDate[5] - 1)) { }
                column(PeriodStartDate61; Format(PeriodStartDate[6] - 1)) { }
                column(PeriodStartDate71; Format(PeriodStartDate[7] - 1)) { }
                column(Periodlength1; Periodlength[1]) { }
                column(Periodlength2; Periodlength[2]) { }
                column(Periodlength3; Periodlength[3]) { }
                column(Periodlength4; Periodlength[4]) { }
                column(Periodlength5; Periodlength[5]) { }
                column(Periodlength6; Periodlength[6]) { }
                column(ValueTotal_1; ValueTotal[1]) { }
                column(ValueTotal_2; ValueTotal[2]) { }
                column(ValueTotal_3; ValueTotal[3]) { }
                column(ValueTotal_4; ValueTotal[4]) { }
                column(ValueTotal_5; ValueTotal[5]) { }
                column(ValueTotal_6; ValueTotal[6]) { }
                column(ValueTotal_7; ValueTotal[7]) { }
                column(RowNum; RowNum) { }
                trigger OnPreDataItem()
                begin
                    Item.ChangeCompany(SelectedCode[Integer.Number]);

                    if ItemCodeFilter <> '' then begin
                        IF TextManagement.MakeTextFilter(ItemCodeFilter) = 0 THEN
                            Item.SetFilter("No.", ItemCodeFilter);
                    End;
                    if ItemCategoryFilter <> '' then begin
                        IF TextManagement.MakeTextFilter(ItemCategoryFilter) = 0 THEN
                            Item.SetFilter("Item Category Code", ItemCategoryFilter);
                    end;
                    //if InventoryPostingFilter <> '' then begin
                    //IF TextManagement.MakeTextFilter(InventoryPostingFilter) = 0 THEN
                    //Item.SetFilter("Inventory Posting Group", InventoryPostingFilter);
                    //end;
                    IF InventoryPostingGroup <> '' then
                        Item.SetFilter("Inventory Posting Group", InventoryPostingGroup);
                end;

                trigger OnAfterGetRecord()
                begin
                    FOR i := 1 TO 7 DO BEGIN
                        if i = 1 then begin
                            ILE.Reset();
                            ILE.ChangeCompany(SelectedCode[Integer.Number]);
                            ILE.SETRANGE(ILE."Item No.", Item."No.");
                            if AgingAsPerGroupGRN = true then
                                ILE.SETRANGE(ILE."Group GRN Date", PeriodStartDate[i], PeriodStartDate[i + 1])
                            else
                                ILE.SETRANGE(ILE."Posting Date", PeriodStartDate[i], PeriodStartDate[i + 1]);
                            ILE.CALCSUMS("Remaining Quantity");
                            AvlQty[i] := ILE."Remaining Quantity";
                        End
                        else
                            if i = 2 then begin
                                ILE.Reset();
                                ILE.ChangeCompany(SelectedCode[Integer.Number]);
                                ILE.SETRANGE(ILE."Item No.", Item."No.");
                                if AgingAsPerGroupGRN = true then
                                    ILE.SETRANGE(ILE."Group GRN Date", PeriodStartDate[i + 1], PeriodStartDate[i])
                                else
                                    ILE.SETRANGE(ILE."Posting Date", PeriodStartDate[i + 1], PeriodStartDate[i]);
                                ILE.CALCSUMS("Remaining Quantity");
                                AvlQty[i] := ILE."Remaining Quantity";
                            End
                            else
                                if i > 2 then begin
                                    ILE.Reset();
                                    ILE.ChangeCompany(SelectedCode[Integer.Number]);
                                    ILE.SETRANGE(ILE."Item No.", Item."No.");
                                    if AgingAsPerGroupGRN = true then
                                        ILE.SETRANGE(ILE."Group GRN Date", PeriodStartDate[i + 1], PeriodStartDate[i] - 1)
                                    else
                                        ILE.SETRANGE(ILE."Posting Date", PeriodStartDate[i + 1], PeriodStartDate[i] - 1);
                                    ILE.CALCSUMS("Remaining Quantity");
                                    AvlQty[i] := ILE."Remaining Quantity";
                                end;
                    end;
                    if ((AvlQty[1] + AvlQty[2] + AvlQty[3] + AvlQty[4] + AvlQty[5] + AvlQty[6] + AvlQty[7]) = 0) then
                        CurrReport.Skip();
                    RowNum += 1;
                    ValueTotal[1] := AvlQty[1] * Item."Unit Cost";
                    ValueTotal[2] := AvlQty[2] * Item."Unit Cost";
                    ValueTotal[3] := AvlQty[3] * Item."Unit Cost";
                    ValueTotal[4] := AvlQty[4] * Item."Unit Cost";
                    ValueTotal[5] := AvlQty[5] * Item."Unit Cost";
                    ValueTotal[6] := AvlQty[6] * Item."Unit Cost";
                    ValueTotal[7] := AvlQty[7] * Item."Unit Cost";

                end;

                trigger OnPostDataItem()
                begin
                end;
            }
            trigger OnPreDataItem()
            var
            begin
                SETRANGE(Number, 1, CountRec);
            end;

            trigger OnAfterGetRecord()
            var
            begin
                ShortNameCom.Get(SelectedCode[Number]);
            End;

            trigger OnPostDataItem()
            var
            begin

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
                    // field("As On Date"; PeriodStartDate[2])
                    // {
                    //     ApplicationArea = All;

                    // }
                    field("Company Group"; Comp_Name)
                    {
                        TableRelation = Company.Name;
                        ApplicationArea = all;
                    }
                    field("Aging As Per Group GRN"; AgingAsPerGroupGRN)
                    {
                        ApplicationArea = all;
                    }
                    field("Inventory Posting Group"; InventoryPostingGroup)
                    //TableRelation = "Inventory Posting Group";
                    {
                        ApplicationArea = all;
                        TableRelation = "Inventory Posting Group";
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    trigger OnInitReport()
    begin
        Comp_Name := 'Consolidate All companies';
        InventoryPostingGroup := 'PD';
        AgingAsPerGroupGRN := true;
    end;

    trigger OnPreReport()
    var
        fromDate: Date;
        RecShortName: Record "Company Short Name";//20MAY2022
        RecShortName2: Record "Company Short Name";//20MAY2022
        BUParentCount, BUChildCount : Integer;
    begin
        ItemCategoryFilter := Item.GetFilter("Item Category Code");
        InventoryPostingFilter := InventoryPostingGroup;
        ItemCodeFilter := Item.GetFilter("No.");


        ValueTotal[1] := 0;
        ValueTotal[2] := 0;
        ValueTotal[3] := 0;
        ValueTotal[4] := 0;
        ValueTotal[5] := 0;
        ValueTotal[6] := 0;
        ValueTotal[7] := 0;

        RowNum := 0;
        j := 0;
        // fromDate := Today;
        PeriodStartDate[2] := Today;

        Evaluate(Periodlength[1], '0D');
        Evaluate(Periodlength[2], '-30D');
        Evaluate(Periodlength[3], '-60D');
        Evaluate(Periodlength[4], '-90D');
        Evaluate(Periodlength[5], '-180D');
        Evaluate(Periodlength[6], '-360D');
        for i := 2 to 6 do
            PeriodStartDate[i + 1] := CalcDate(Periodlength[i], PeriodStartDate[i]);
        PeriodStartDate[8] := 0D;   //"DMY2Date(31, 12, 9999)" Replaced By "0D";
        PeriodStartDate[1] := 0D;

        BusinessUnit.RESET;
        BusinessUnit.CHANGECOMPANY(Comp_Name);
        IF BusinessUnit.FINDSET THEN BEGIN
            //CountRec := BusinessUnit.COUNT;
            REPEAT
                Clear(RecShortName);//20MAY2022-start
                RecShortName.SetRange(Name, BusinessUnit."Company Name");
                RecShortName.SetRange("Block in Reports", true);
                if not RecShortName.FindFirst() then begin
                    BUParentCount += 1;
                    j += 1;
                    SelectedCode[j] := BusinessUnit."Company Name";
                    IF BusinessUnit."Company Name" <> Comp_Name THEN BEGIN
                        BusinessUnitRec.RESET;
                        BusinessUnitRec.CHANGECOMPANY(BusinessUnit."Company Name");
                        IF BusinessUnitRec.FINDSET THEN
                            REPEAT
                                Clear(RecShortName2);//20MAY2022-start
                                RecShortName2.SetRange(Name, BusinessUnitRec."Company Name");
                                RecShortName2.SetRange("Block in Reports", true);
                                if not RecShortName2.FindFirst() then begin
                                    IF BusinessUnitRec."Company Name" <> BusinessUnit."Company Name" THEN BEGIN
                                        //CountRec += 1;
                                        BUChildCount += 1;
                                        j += 1;
                                        SelectedCode[j] := BusinessUnitRec."Company Name";
                                    END;
                                end;

                            UNTIL BusinessUnitRec.NEXT = 0;
                    END;
                end;
            UNTIL BusinessUnit.NEXT = 0;
            CountRec := BUParentCount + BUChildCount;
        END
        Else Begin
            CountRec := 1;
            SelectedCode[CountRec] := Comp_Name;
        End;

    end;

    trigger OnPostReport()
    begin

    end;

    var

        i: Integer;
        j: Integer;
        CountRec: Integer;
        AvlQty: array[7] of Decimal;
        ValueTotal: array[7] of Decimal;
        RowNum: Decimal;
        PeriodStartDate: array[8] of Date;
        Periodlength: array[6] of DateFormula;
        //CurrentCode: Code[30];
        ReportCaption: Label 'Stock Aging Analysis';
        SelectedCode: array[15] of Text[100];
        Comp_Name: Text[40];
        AgingAsPerGroupGRN: Boolean;
        InventoryPostingGroup: Code[250];
        ILE: Record "Item Ledger Entry";
        BusinessUnit: Record "Business Unit";
        BusinessUnitRec: Record "Business Unit";
        CompanyInformation: Record "Company Information";
        ShortNameCom: Record "Company Short Name";
        TextManagement: Codeunit TextManagement;
        ItemCategoryFilter: Text[100];
        ItemCodeFilter: Text[100];
        InventoryPostingFilter: text[100];
}