report 50211 KMP_CustomerStatement//T12370-N
{
    Caption = 'Customer Statement';
    DefaultLayout = RDLC;
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/KMP_CustomerStatement.rdl';

    dataset
    {
        dataitem(Company; Company)
        {
            RequestFilterFields = Name;
            column(Name; Name) { }
            column(CompanyText; CompanyTxtG) { }
            column(CompanyShortName; CompShortNameG."Short Name") { }
            column(PrintingDate; Format(Today, 0, '<Day,2>-<Month Text>-<year4>')) { }
            dataitem(Customer; Customer)
            {
                RequestFilterFields = "Country/Region Code";
                column(No_; "No.") { }
                column(Search_Name; "Search Name") { }
                column(Responsibility_Center; "Responsibility Center") { }
                column(Salesperson; SalespersonPurchrG."Short Name") { }
                column(Salesperson_TeamName; TeamNameG) { }
                column(Country_Region_Code; "Country/Region Code") { }
                dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
                {
                    CalcFields = "Amount (LCY)", "Remaining Amt. (LCY)";
                    DataItemLink = "Customer No." = field("No.");
                    DataItemTableView = where(Open = filter(true));
                    column(BSO_No_; BSONoG) { }
                    column(BSO_Date; Format(BSODateG, 0, '<Day,2>/<Month,2>/<year4>')) { }
                    column(SO_No_; SONoG) { }
                    column(SO_Date; Format(SODateG, 0, '<Day,2>/<Month,2>/<year4>')) { }
                    column(Invoice_Date; Format(InvoiceDateG, 0, '<Day,2>/<Month,2>/<year4>')) { }
                    column(Document_No_; "Document No.") { }
                    column(Currency_Code; "Currency Code") { }
                    column(Invoice_Amount; Amount) { }
                    column(Invoice_Amount__LCY_; "Amount (LCY)") { }
                    column(Invoice_Due_Date; Format("Due Date", 0, '<Day,2>/<Month,2>/<year4>')) { }
                    column(Outstanding_Balance__LCY_; "Remaining Amt. (LCY)") { }
                    column(Due_Days; Today - "Due Date") { }
                    column(Running_Value; RunningValueG) { }

                    trigger OnPreDataItem()
                    var
                        myInt: Integer;
                    begin
                        ChangeCompany(Company.Name);
                    end;

                    trigger OnAfterGetRecord()
                    var
                        SalesInvLnL: Record "Sales Invoice Line";
                        SalesHdrL: Record "Sales Header";
                        SalesHdrArchiveL: Record "Sales Header Archive";
                    begin
                        if "Remaining Amt. (LCY)" = 0 then
                            CurrReport.Skip();
                        Clear(InvoiceDateG);
                        Clear(SONoG);
                        Clear(BSONoG);
                        Clear(SODateG);
                        Clear(BSODateG);
                        case ReportFilterG of
                            // ReportFilterG::"Outstanding":
                            //     if (Today - "Due Date" < 0) then
                            //         CurrReport.Skip();
                            ReportFilterG::"Over Due":
                                if (Today - "Due Date" < 0) then
                                    CurrReport.Skip();
                        end;
                        GLSetupG.ChangeCompany(Company.Name);
                        SalesInvLnL.ChangeCompany(Company.Name);
                        SalesHdrL.ChangeCompany(Company.Name);
                        SalesHdrArchiveL.ChangeCompany(Company.Name);

                        GLSetupG.Get();
                        if "Currency Code" = '' then
                            "Currency Code" := GLSetupG."LCY Code";
                        if (CurrencyCodeG > '') and (CurrencyCodeG <> "Currency Code") then
                            CurrReport.Skip();
                        if (SalesInvoiceG > '') and (SalesInvoiceG <> "Document No.") then
                            CurrReport.Skip();
                        InvoiceDateG := "Posting Date";
                        SalesInvLnL.SetRange("Document No.", "Document No.");
                        SalesInvLnL.SetRange(Type, SalesInvLnL.Type::Item);
                        if SalesInvLnL.FindFirst() then begin
                            InvoiceDateG := SalesInvLnL."Posting Date";

                            SONoG := SalesInvLnL."Order No.";
                            if (SalesOrderG > '') and (SalesOrderG <> SONoG) then
                                CurrReport.Skip();
                            if SalesHdrL.Get(SalesHdrL."Document Type"::Order, SalesInvLnL."Order No.") then
                                SODateG := SalesHdrL."Document Date"
                            else begin
                                SalesHdrArchiveL.SetRange("Document Type", SalesHdrArchiveL."Document Type"::Order);
                                SalesHdrArchiveL.SetRange("No.", SalesInvLnL."Order No.");
                                if SalesHdrArchiveL.FindFirst() then
                                    SODateG := SalesHdrArchiveL."Document Date";
                            end;

                            BSONoG := SalesInvLnL."Blanket Order No.";
                            if SalesHdrL.Get(SalesHdrL."Document Type"::"Blanket Order", SalesInvLnL."Blanket Order No.") then
                                BSODateG := SalesHdrL."Document Date"
                            else begin
                                SalesHdrArchiveL.SetRange("Document Type", SalesHdrArchiveL."Document Type"::"Blanket Order");
                                SalesHdrArchiveL.SetRange("No.", SalesInvLnL."Order No.");
                                if SalesHdrArchiveL.FindFirst() then
                                    BSODateG := SalesHdrArchiveL."Document Date";
                            end;
                        end;

                        if not TempCurrencyG.Get("Currency Code") then begin
                            TempCurrencyG.Init();
                            TempCurrencyG.Code := "Currency Code";
                            TempCurrencyG.Insert();
                        end;
                        TempCurrencyG."Customer Balance" += Amount;
                        TempCurrencyG.Modify();
                        RunningValueG += 1;
                    end;
                }

                // Customer DataItem
                trigger OnPreDataItem()
                begin
                    ChangeCompany(Company.Name);
                    SetFilter("No.", CustNoG);
                    if SalesPersonG > '' then
                        SetFilter("Salesperson Code", SalesPersonG);
                    if not ShowIntercompanyCustG then
                        SetFilter("IC Partner Code", '%1', '');
                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                    SalesInvHdrL: Record "Sales Invoice Header";
                    TeamSalespersonL: Record "Team Salesperson";
                begin
                    Clear(SalespersonPurchrG);
                    TeamNameG := '';
                    SalespersonPurchrG.ChangeCompany(Company.Name);
                    SalesInvHdrL.ChangeCompany(Company.Name);
                    TeamSalespersonL.ChangeCompany(Company.Name);
                    if SalesInvoiceG > '' then
                        if not SalesInvHdrL.Get(SalesInvoiceG) then
                            CurrReport.Skip()
                        else
                            if "No." <> SalesInvHdrL."Bill-to Customer No." then
                                CurrReport.Skip();
                    if "Salesperson Code" > '' then begin
                        SalespersonPurchrG.Get("Salesperson Code");
                        TeamSalespersonL.SetRange("Salesperson Code", "Salesperson Code");
                        if SalespersonTeamsG > '' then begin
                            TeamSalespersonL.SetRange("Team Code", SalespersonTeamsG);
                            if not TeamSalespersonL.FindFirst() then
                                CurrReport.Skip();
                        end;
                        if TeamSalespersonL.FindFirst() then begin
                            TeamSalespersonL.CalcFields("Team Name");
                            TeamNameG := TeamSalespersonL."Team Name";
                        end;
                    end;

                end;

            }

            // Company DataItem
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                FindFirst();
                if Count = 1 then
                    CompanyTxtG := Company.Name
                else
                    CompanyTxtG := 'Group of Companies';
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                CompShortNameG.Get(Name);
            end;
        }
        dataitem(Total; Integer)
        {
            column(TotalInvoiceCaption; 'Total Invoice') { }
            column(Total_Currency_Code; TempCurrencyG.Code) { }
            column(Total_Invoice_Value; TempCurrencyG."Customer Balance") { }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                if not TempCurrencyG.FindSet() then
                    CurrReport.Break();
                SETRANGE(Number, 1, TempCurrencyG.COUNT);
            end;

            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                if Number = 1 then
                    TempCurrencyG.FindFirst()
                else
                    TempCurrencyG.Next(1);
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filters)
                {
                    field("Report Filter"; ReportFilterG)
                    {
                        ApplicationArea = all;
                    }
                    field(Customer; CustNoG)
                    {
                        ApplicationArea = all;
                        TableRelation = Customer;
                    }
                    field("Sales Team"; SalespersonTeamsG)
                    {
                        ApplicationArea = all;
                        TableRelation = Team;
                    }
                    field(Salesperson; SalesPersonG)
                    {
                        ApplicationArea = all;
                        TableRelation = "Salesperson/Purchaser";
                    }
                    field("Currency"; CurrencyCodeG)
                    {
                        ApplicationArea = all;
                        TableRelation = Currency;
                    }
                    field("Show Intercompany"; ShowIntercompanyCustG)
                    {
                        ApplicationArea = all;
                    }
                    field("Sales Order"; SalesOrderG)
                    {
                        Visible = false;
                        ApplicationArea = all;
                        TableRelation = "Sales Header"."No." where("Document Type" = filter(Order));
                    }
                    field("Sales Invoice"; SalesInvoiceG)
                    {
                        Visible = false;
                        ApplicationArea = all;
                        TableRelation = "Sales Invoice Header";
                    }


                }
            }
        }

    }

    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        TempCurrencyG.DeleteAll();
        RunningValueG := 0;
    end;

    var
        CompShortNameG: Record "Company Short Name";
        SalespersonPurchrG: Record "Salesperson/Purchaser";
        GLSetupG: Record "General Ledger Setup";
        TempCurrencyG: Record Currency temporary;
        CompanyTxtG: Text[100];
        TeamNameG: text[50];
        SONoG: Code[20];
        BSONoG: Code[20];
        SalesOrderG: Code[20];
        SalesInvoiceG: Code[20];
        CurrencyCodeG: Code[20];
        SalespersonTeamsG: Code[20];
        CustNoG: Code[20];
        SalesPersonG: Code[20];
        DueDaysG: Integer;
        RunningValueG: Integer;
        SODateG: Date;
        InvoiceDateG: Date;
        BSODateG: Date;
        ShowIntercompanyCustG: Boolean;
        ReportFilterG: Option "Outstanding","Over Due";
}