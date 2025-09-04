report 50209 KMP_StockReservationReport//T12370-Full Comment //T13386-Full UnComment
{
    Caption = 'Stock Reservation';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/KMP_StockReservation.rdl';
    dataset
    {
        dataitem(Company; Company)
        {
            RequestFilterFields = Name;
            dataitem(Item; Item)
            {
                CalcFields = "Qty. on Sales Order", Inventory, "Qty. in Transit", "Reserved Qty. on Sales Orders";
                DataItemTableView = sorting("No.") where("Qty. on Sales Order" = filter(> 0));
                column(Company_Name; CompShortNameG."Short Name")
                { }
                column(Company_Text; CompanyTxtG)
                { }
                column(Item_No_; "No.")
                { }
                column(Description; ItemSearchDesc)
                { }
                column(Base_Unit_of_Measure; "Base Unit of Measure")
                { }
                column(Inventory; Inventory)
                { }
                column(Qty__in_Transit; QtyInTransitG)
                { }
                dataitem("Sales Line"; "Sales Line")
                {
                    CalcFields = "Reserved Quantity", "Reserved Qty. (Base)";
                    DataItemTableView = sorting("Document Type", "Document No.", "Line No.") where("Document Type" = const(Order), Type = const(Item));
                    DataItemLink = "No." = field("No.");
                    column(SO_No_; "Document No.")
                    { }
                    column(SO_Date; format(SalesHdrG."Document Date", 0, '<Day,2>/<Month,2>/<year4>'))
                    { }
                    column(Quantity_Reserved_; "Reserved Qty. (Base)")
                    { }
                    column(Customer_Name; CustomerG."Search Name")
                    { }
                    column(SalesPerson; Salesperson)
                    { }
                    column(Reserve_days; ReserveDaysG)
                    { }
                    column(Reservation_Date; Format(ReservationEntryG."Creation Date", 0, '<Day,2>/<Month,2>/<year4>'))
                    { }
                    column(ReservationDays; ReservationDays)
                    { }
                    column(IC_Customer; "IC Customer")
                    { }
                    column(IC_Related_SO; "IC Related SO")
                    { }
                    column(ReservationDaysFilter; ReservDaysFilterG)
                    { }
                    column(SkipEntry; SkipEntryG)
                    { }
                    column(Running_Value; RunningValueG) { }
                    column(Previous_Item_No; PreviousItemNoG) { }
                    column(Prev_Company_Name; PrevCompanyNameG) { }
                    column(Variant_Code; "Variant Code") { }
                    column(Transaction_Type; SalesHdrG."Transaction Type") { }
                    column(Promised_Delivery_Date; SalesHdrG."Promised Delivery Date") { }

                    trigger OnPreDataItem() // Sales Line
                    var
                        myInt: Integer;
                    begin
                        ChangeCompany(Company.Name);
                        // SetFilter("Sell-to Customer No.", CustomerNoG);
                    end;

                    trigger OnAfterGetRecord()
                    var
                        IC_Company: Record "IC Partner";
                        ICSalesHeader: Record "Sales Header";
                        VariantRec: Record "Item Variant";

                    begin
                        Clear(SalespersonPurchrG);
                        Clear(SkipEntryG);
                        Clear(ReservationEntryG);
                        Clear(Salesperson);
                        ReserveDaysG := 0;
                        SalesHdrG.ChangeCompany(Company.Name);
                        SalespersonPurchrG.ChangeCompany(Company.Name);
                        ReservationEntryG.ChangeCompany(Company.Name);
                        IC_Company.ChangeCompany(Company.Name);
                        CustomerG.ChangeCompany(Company.Name);
                        if "Reserved Quantity" = 0 then
                            CurrReport.Skip();
                        if not SalesHdrG.get("Document Type", "Document No.") then
                            CurrReport.Skip();
                        CustomerG.Get(SalesHdrG."Sell-to Customer No.");
                        // if (SalesPersonG > '') and (SalesHdrG."Salesperson Code" <> SalesPersonG) then
                        //     CurrReport.Skip();

                        ReservationEntryG.SetRange("Source ID", "Document No.");
                        ReservationEntryG.SetRange("Source Ref. No.", "Line No.");
                        ReservationEntryG.SetRange("Source Type", 37);
                        ReservationEntryG.SetRange("Source Subtype", "Document Type");
                        ReservationEntryG.SetRange("Reservation Status", ReservationEntryG."Reservation Status"::Reservation);
                        if ReservationEntryG.FindFirst() then
                            ReserveDaysG := Today() - ReservationEntryG."Creation Date";
                        case ReservDaysFilterG of
                            ReservDaysFilterG::"<":
                                SkipEntryG := ReserveDaysG >= ReservationDays;
                            ReservDaysFilterG::">":
                                SkipEntryG := ReserveDaysG <= ReservationDays;
                            ReservDaysFilterG::"=":
                                SkipEntryG := ReserveDaysG > ReservationDays;
                        end;

                        if SalesHdrG."Bill-to IC Partner Code" <> '' then begin

                            IC_Company.Get(SalesHdrG."Bill-to IC Partner Code");
                            if (IC_Company."Inbox Type" = IC_Company."Inbox Type"::Database) and (IC_Company."Inbox Details" <> '') and (IC_Company."Data Exchange Type" = IC_Company."Data Exchange Type"::Database) then begin //T13386 //Yaksh Hypercare Support
                                ICSalesHeader.ChangeCompany(IC_Company."Inbox Details");
                                ICSalesHeader.Reset();
                                if ICSalesHeader.get("Document Type"::Order, "IC Related SO") then;
                                if SalespersonPurchrG.Get(ICSalesHeader."Salesperson Code") then;
                                SalesPerson := SalespersonPurchrG."Short Name";
                            end;//Yaksh Hypercare Support
                        end
                        else begin
                            if SalespersonPurchrG.Get(SalesHdrG."Salesperson Code") then;
                            Salesperson := SalespersonPurchrG."Short Name";
                        end;

                        if "Variant Code" <> '' then begin // add by bayas
                            VariantRec.Get("No.", "Variant Code");
                            ItemSearchDesc := VariantRec.Description;
                        end else begin
                            ItemSearchDesc := item.Description;
                        end;


                        if (CustomerNoG > '') and ("Sell-to Customer No." <> CustomerNoG) then
                            SkipEntryG := true;
                        if (SalesPersonG > '') and (SalesHdrG."Salesperson Code" <> SalesPersonG) then
                            SkipEntryG := true;

                        if not SkipEntryG then begin
                            RunningValueG += 1;
                            PreviousItemNoG := CurrentItemNoG;
                            CurrentItemNoG := "No.";
                            PrevCompanyNameG := CurrCompanyNameG;
                            CurrCompanyNameG := CompShortNameG."Short Name";
                        end;
                        // if SkipEntryG then
                        //     CurrReport.Skip();
                        //     CurrReport.Break();
                    end;
                }

                trigger OnPreDataItem() // Item DataItem
                var
                    myInt: Integer;
                begin
                    ChangeCompany(Company.Name);
                    SetFilter("No.", ItemNoG);
                end;

                trigger OnAfterGetRecord()
                var
                    PurchLineL: Record "Purchase Line";
                begin
                    if "Reserved Qty. on Sales Orders" = 0 then
                        CurrReport.Skip();
                    // if (CurrentItemNoG = '') and (PreviousItemNoG = '') then
                    //     CurrentItemNoG := "No."
                    // else begin
                    //     PreviousItemNoG := CurrentItemNoG;
                    //     CurrentItemNoG := "No.";
                    // end;
                    Clear(QtyInTransitG);
                    PurchLineL.ChangeCompany(Company.Name);
                    PurchLineL.SetCurrentKey("Document Type", "Document No.", "Line No.", "No.");
                    PurchLineL.SetRange("Document Type", PurchLineL."Document Type"::Order);
                    PurchLineL.SetRange("No.", "No.");
                    PurchLineL.SetFilter(CustomR_ETD, '<=%1', WorkDate());
                    PurchLineL.SetFilter(CustomR_ETA, '>%1', WorkDate());
                    if PurchLineL.FindSet() then
                        PurchLineL.CalcSums("Quantity (Base)");
                    QtyInTransitG := PurchLineL."Quantity (Base)";
                end;
            }
            trigger OnPreDataItem() // Company DataItem
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
                RecShortName: Record "Company Short Name";
            begin
                CompShortNameG.Get(Name);
                PreviousItemNoG := '';
                //20MAY2022-start
                Clear(RecShortName);
                RecShortName.SetRange(Name, Name);
                RecShortName.SetRange("Block in Reports", true);
                if RecShortName.FindFirst() then exit;
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
                    field("Item No."; ItemNoG)
                    {
                        ApplicationArea = All;
                        TableRelation = Item;
                    }
                    field("Customer No."; CustomerNoG)
                    {
                        ApplicationArea = all;
                        TableRelation = Customer;
                    }
                    field(SalesPerson; SalesPersonG)
                    {
                        ApplicationArea = all;
                        TableRelation = "Salesperson/Purchaser";
                    }
                    field("Reservation Days Filter"; ReservDaysFilterG)
                    {
                        ApplicationArea = all;
                        OptionCaption = ' ,More than,Less than,Upto';
                    }
                    field("Reservation Days"; ReservationDays)
                    {
                        ApplicationArea = all;
                    }
                }
            }
        }

    }

    var
        CompanyG: Record Company;
        SalesHdrG: Record "Sales Header";
        ReservationEntryG: Record "Reservation Entry";
        CompShortNameG: Record "Company Short Name";
        SalespersonPurchrG: Record "Salesperson/Purchaser";
        CustomerG: Record Customer;
        ItemNoG: Code[20];
        CompanyNameG: Text;
        PrevCompanyNameG: Text;
        CurrCompanyNameG: Text;
        CustomerNoG: Code[20];
        SalesPersonG: Code[20];
        PreviousItemNoG: Code[20];
        CurrentItemNoG: Code[20];
        CompanyTxtG: Text;
        ReserveDaysG: Integer;
        ReservationDays: Integer;
        QtyInTransitG: Decimal;
        RunningValueG: Decimal;
        SkipEntryG: Boolean;
        ReservDaysFilterG: Option " ",">","<","=";
        Salesperson: Text;
        ItemSearchDesc: Text[100];
}