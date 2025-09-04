codeunit 50355 "Consolidated Data"//T12370-Full Comment     //T13413-Full UnComment
{
    Permissions = tabledata "Approval Entry" = rm;
    trigger OnRun()
    begin

    end;

  //Salesperson: code[20] length increase by 10-20
    procedure ConsolidatedSales(StartDate: Date; EndDate: Date; Salesperson: code[20]; Consolidate: Boolean) Sales: Decimal;
    var
        CLE: Record "Cust. Ledger Entry";
        company: Record Company;
        BlockCust: Text[2000];
        usersetup: Record "User Setup";
        accountingperiod: Record "Accounting Period";
        FYstart: Date;
        item_rec: Record item;
        ItemTotalcost: Decimal;
        valueEntry: Record "Value Entry";
        RecShortName: Record "Company Short Name";//18MAY2022
    begin

        //FYstart := accountingperiod.GetFiscalYearStartDate(WorkDate());
        BlockCust := reportexemptCustomers();
        CLE.SetRange("IC Partner Code", '');
        CLE.SetFilter("Posting Date", '%1..%2', StartDate, EndDate);
        CLE.SetFilter("Customer No.", BlockCust);
        CLE.SetFilter(Prepayment, '%1', false);
        CLE.SetFilter("Salesperson Code", Salesperson);
        CLE.CalcSums("Sales (LCY)");

        if not Consolidate then begin
            Sales := CLE."Sales (LCY)"
        end
        else begin
            company.SetFilter(name, '<> %1', CLE.CurrentCompany);
            repeat
                //18MAY2022-start
                Clear(RecShortName);
                RecShortName.SetRange(Name, company.Name);
                RecShortName.SetRange("Block in Reports", true);
                if not RecShortName.FindFirst() then begin
                    CLE.ChangeCompany(company.Name);
                    CLE.CalcSums("Sales (LCY)");
                    Sales += CLE."Sales (LCY)";
                end;
            //18MAY2022-end;
            until company.Next() = 0;
        end;
        exit(Sales);
    end;

    procedure ConsolidatedTeamSales(StartDate: Date; EndDate: Date; Consolidate: Boolean; TeamCode: Code[20]) TeamSales: Decimal;
    var
        SalesTeamSP: Record "Team Salesperson";
        SPCOde: Text;
    begin
        SalesTeamSP.SetRange("Team Code", TeamCode);
        if SalesTeamSP.FindSet() then
            repeat
                TeamSales += ConsolidatedSales(StartDate, EndDate, SalesTeamSP."Salesperson Code", Consolidate);
                SPCOde += SalesTeamSP."Salesperson Code";
            until SalesTeamSP.Next() = 0;
        exit(TeamSales);
    end;

    procedure ReceivableCalculation(Due: Boolean) Receivable: Decimal;
    var
        CLE: Record "Cust. Ledger Entry";
        company: Record Company;
        ConsolSalesCodeunit: codeunit "Consolidated Data";
        // CLE: Record Customer;
        RecShortName: Record "Company Short Name";//18MAY2022
    begin
        // company.SetFilter(Name, '<>%1', CLE.CurrentCompany);
        if company.FindSet() then
            repeat
                //18MAY2022-start
                Clear(RecShortName);
                RecShortName.SetRange(Name, company.Name);
                RecShortName.SetRange("Block in Reports", true);
                if not RecShortName.FindFirst() then begin
                    CLE.Reset();
                    CLE.ChangeCompany(company.Name);
                    CLE.SetRange("IC Partner Code", '');
                    CLE.SetFilter("Remaining Amt. (LCY)", '>%1', 0);
                    // CLE.SetFilter("Customer No.", ConsolSalesCodeunit.reportexemptCustomers());
                    CLE.SetFilter("Customer No.", ConsolSalesCodeunit.reportexemptCustomers() + '&' + ICCompany());
                    if CLE.FindSet() then
                        repeat
                            if not due then begin
                                CLE.CalcFields("Remaining Amt. (LCY)");
                                Receivable += CLE."Remaining Amt. (LCY)";
                            end
                            else begin
                                CLE.SetFilter("Due Date", '..%1', Today);
                                CLE.CalcFields("Remaining Amt. (LCY)");
                                Receivable += CLE."Remaining Amount";
                            end;
                        until CLE.Next() = 0;
                end;
            until company.Next() = 0;
        //18MAY2022-end
        exit(Receivable);
    end;

    //     procedure ReceivableCalculation(Due: Boolean) Receivable: Decimal;
    // var
    //     CLE: Record "Cust. Ledger Entry";
    //     company: Record Company;
    //     ConsolSalesCodeunit: codeunit "Consolidated Data";
    //     CustomerRec: Record Customer;
    // begin
    //     // company.SetFilter(Name, '<>%1', rec.CurrentCompany);
    //     if company.FindSet() then
    //         repeat
    //             CustomerRec.Reset();
    //             CustomerRec.ChangeCompany(company.Name);
    //             CustomerRec.SetRange("IC Partner Code", '');
    //             CustomerRec.SetFilter("No.", ConsolSalesCodeunit.reportexemptCustomers());
    //             if CustomerRec.FindSet() then
    //                 repeat
    //                     if not due then begin
    //                         CustomerRec.CalcFields("Balance (LCY)");
    //                         Receivable += CustomerRec."Balance (LCY)";
    //                     end
    //                     else begin
    //                         CustomerRec.CalcFields("Balance Due (LCY)");
    //                         Receivable += CustomerRec."Balance Due (LCY)";
    //                     end;
    //                 until CustomerRec.Next() = 0;
    //         until company.Next() = 0;
    //     exit(Receivable);
    // end;

    procedure reportexemptCustomers() HiddenCustomers: Text;
    var
        customerrec: Record Customer;
    begin
        customerrec.SetRange("Hide in Reports", true);
        if customerrec.FindSet() then begin
            HiddenCustomers := ' ';
            repeat
                HiddenCustomers += '<>';
                HiddenCustomers += customerrec."No.";
                HiddenCustomers += '&';
            until customerrec.Next() = 0;
            HiddenCustomers := HiddenCustomers.TrimEnd('&');
            exit(HiddenCustomers);
        end;
    end;

    procedure ICCompany() ICCustomers: Text;
    var
        Customer: Record Customer;
    begin
        Customer.SetFilter("IC Partner Code", '<>%1', '');
        if Customer.FindSet() then begin
            ICCustomers := '';
            repeat
                ICCustomers += '<>';
                ICCustomers += Customer."No.";
                ICCustomers += '&';
            until Customer.Next() = 0;
        end;

        ICCustomers := ICCustomers.TrimEnd('&');
        exit(ICCustomers);
    end;


    [EventSubscriber(ObjectType::Table, Database::"Approval Entry", 'OnAfterInsertEvent', '', true, true)]
    local procedure MyProcedure(var Rec: Record "Approval Entry")
    var
        CustomerRec: Record Customer;
        itemRec: Record item;
        VendorRec: Record Vendor;
        SalesheaderRec: Record "Sales Header";
    begin

        if Rec."Table ID" = 18 then begin
            CustomerRec.get(rec."Record ID to Approve");
            Rec."Short Name" := CustomerRec."Search Name";
            if rec.Modify() then;
        end;
        if Rec."Table ID" = 27 then begin
            itemRec.Get(Rec."Record ID to Approve");
            rec."Short Name" := itemRec."Search Description";
            if rec.Modify() then;
        end;
        if rec."Table ID" = 23 then begin
            VendorRec.Get(Rec."Record ID to Approve");
            Rec."Short Name" := VendorRec."Search Name";
            if rec.Modify() then;
        end;
        if Rec."Table ID" = 36 then begin

        end;
    end;
}