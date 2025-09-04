Report 50129 "GRNI report -Group"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Description = 'T48841';
    ProcessingOnly = true;
    Caption = 'GRNI report -Group';

    dataset
    {
        dataitem(Company; Company)
        {
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                trigger OnPreDataItem()
                begin
                    SetFilter("Entry Type", '=%1', "Entry Type"::Purchase);
                    SetFilter("Document Type", '=%1', "Document Type"::"Purchase Receipt");
                    SetRange("Posting Date", StartDate_gDte, EndDate_gDte);
                    SetRange("Invoiced Quantity", 0);
                    CalcFields("Cost Amount (Actual)", "Sales Amount (Actual)", "Cost Amount (Non-Invtbl.)");
                end;

                trigger OnAfterGetRecord()
                begin
                    ExcelBuffer.NewRow();
                    ExcelBuffer.AddColumn(Company."Display Name", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Posting Date", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Date);
                    ExcelBuffer.AddColumn("Entry Type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Document Type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Document No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Source No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    if Vendor_gRec.Get("Source No.") then
                        ExcelBuffer.AddColumn(Vendor_gRec.Name, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text)
                    else
                        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Item No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Description", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Global Dimension 1 Code", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Global Dimension 2 Code", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Analysis Date", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Date);
                    ExcelBuffer.AddColumn("Of Spec", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Location Code", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Production Wh.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Quantity", false, '', false, false, false, '##,#0.00', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn(CustomLotNumber, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(CustomBOENumber, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn(BillOfExit, false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Supplier Batch No. 2", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Manufacturing Date 2", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Date);
                    ExcelBuffer.AddColumn("Expiry Period 2", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Net Weight 2", false, '', false, false, false, '##,#0.00', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn("Gross Weight 2", false, '', false, false, false, '##,#0.00', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn("Invoiced Quantity", false, '', false, false, false, '##,#0.00', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn("Remaining Quantity", false, '', false, false, false, '##,#0.00', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn("Sales Amount (Actual)", false, '', false, false, false, '##,#0.00', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn("Cost Amount (Actual)", false, '', false, false, false, '##,#0.00', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn("Profit % IC", false, '', false, false, false, '##,#0.00', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn("Cost Amount (Non-Invtbl.)", false, '', false, false, false, '##,#0.00', ExcelBuffer."Cell Type"::Number);
                    ExcelBuffer.AddColumn("Open", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Order Type", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    ExcelBuffer.AddColumn("Entry No.", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Number);
                    DimesionSetEntry_gRec.Reset();
                    DimesionSetEntry_gRec.SetRange("Dimension Set ID", "Dimension Set ID");
                    if DimesionSetEntry_gRec.FindSet() then begin
                        DimesionSetEntry_gRec.SetRange("Dimension Code", 'DEP');
                        if DimesionSetEntry_gRec.FindFirst() then
                            ExcelBuffer.AddColumn(DimesionSetEntry_gRec."Dimension Value Code", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text)
                        else
                            ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                        DimesionSetEntry_gRec.SetRange("Dimension Code", 'PROFIT CENTER');
                        if DimesionSetEntry_gRec.FindFirst() then
                            ExcelBuffer.AddColumn(DimesionSetEntry_gRec."Dimension Value Code", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text)
                        else
                            ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                        DimesionSetEntry_gRec.SetRange("Dimension Code", 'BANK');
                        if DimesionSetEntry_gRec.FindFirst() then
                            ExcelBuffer.AddColumn(DimesionSetEntry_gRec."Dimension Value Code", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text)
                        else
                            ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                        DimesionSetEntry_gRec.SetRange("Dimension Code", 'VEHICLE');
                        if DimesionSetEntry_gRec.FindFirst() then
                            ExcelBuffer.AddColumn(DimesionSetEntry_gRec."Dimension Value Code", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text)
                        else
                            ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    end
                    else begin
                        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                        ExcelBuffer.AddColumn('', false, '', false, false, false, '', ExcelBuffer."Cell Type"::Text);
                    end;
                    ExcelBuffer.AddColumn("Group GRN Date", false, '', false, false, false, '', ExcelBuffer."Cell Type"::Date);
                end;
            }
            trigger OnPreDataItem()
            begin
                if CompanyNameG <> '' then
                    SetFilter("Display Name", CompanyNameG)
            end;

            trigger OnAfterGetRecord()
            begin
                "Item Ledger Entry".ChangeCompany(Company.Name);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(StartDate_gDte; StartDate_gDte)
                {
                    ApplicationArea = All;
                    Caption = 'Start Date';
                }
                field(EndDate_gDte; EndDate_gDte)
                {
                    ApplicationArea = All;
                    Caption = 'End Date';
                }
                group(Options)
                {
                    field("Company Name"; CompanyNameG)
                    {
                        ApplicationArea = all;
                        TableRelation = Company;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            CompList_lPge: Page "Company List";
                            Company_lRec: Record Company;
                        begin
                            clear(Company_lRec);
                            Clear(CompList_lPge);
                            CompList_lPge.Editable(false);
                            CompList_lPge.LookupMode(true);
                            CompList_lPge.SetTableView(Company_lRec);
                            if CompList_lPge.RunModal() = Action::LookupOK then begin
                                Clear(CompanyNameG);
                                CompList_lPge.SetSelection(Company_lRec);
                                if Company_lRec.FindSet() then begin
                                    repeat
                                        if CompanyNameG <> '' then
                                            CompanyNameG += '|' + Company_lRec."Display Name"
                                        else
                                            CompanyNameG := Company_lRec."Display Name";
                                    until Company_lRec.Next() = 0;
                                end;
                            end;
                        end;
                    }
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        ExcelBuffer.NewRow;
        ExcelBuffer.AddColumn('Co. Name', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Posting Date', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Entry Type', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Document Type', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Document No.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Source No.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Vendor Name', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Item No.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Description', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Sales Person', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Region', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Analysis Date', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Off-Spec', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Location Code', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Production Wh.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Quantity', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Custom Lot No.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Custom BOE No.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Bill Of Exit', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Supplier Batch No.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Manufacturing Date', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Expiry Period', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Net Weight', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Gross Weight', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Invoiced Quantity', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Remaining Quantity', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Sales Amount (Actual)', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Cost Amount (Actual)', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Profit %', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Cost Amount (Non-Invtbl.)', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Open', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Order Type', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Entry No.', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Dep Code', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Profit Center Code', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Bank Code', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Vehicle Code', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);
        ExcelBuffer.AddColumn('Group GRN Date', false, '', true, false, false, '', ExcelBuffer."Cell Type"::Text);

    end;

    trigger OnPostReport()
    begin
        ExcelBuffer.CreateNewBook('Item Ledger Entries');
        ExcelBuffer.WriteSheet('Item Ledger Entries', CompanyName, UserId);
        ExcelBuffer.CloseBook();
        ExcelBuffer.SetFriendlyFilename('GRNI report -Group');
        ExcelBuffer.OpenExcel();
    end;

    var
        EndDate_gDte: Date;
        StartDate_gDte: Date;
        DimesionSetEntry_gRec: Record "Dimension Set Entry";
        Vendor_gRec: Record Vendor;
        CompanyNameG: Text;
        ExcelBuffer: Record "Excel Buffer" temporary;
}