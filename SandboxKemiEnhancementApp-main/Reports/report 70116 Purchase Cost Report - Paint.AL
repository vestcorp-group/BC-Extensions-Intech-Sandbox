report 70116 "Purchase Cost Report-Paint"//T12370-Full Comment
{
    DefaultLayout = RDLC;
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Layouts/Purchase_Cost_ReportPaint.rdl';
    Caption = 'Purchase Cost Report - Paint & Coatings';
    ApplicationArea = all;

    dataset
    {
        dataitem(Complist; Company)
        {
            DataItemTableView = sorting(Name);
            //RequestFilterFields = "Name";
            column(comp_name; Name)
            { }
            column(ReportTitle; ReportTitle)
            { }
            column(ReportFilter; ReportFilter)
            { }
            column(Details; Details)
            { }
            column(comp_filter; comp_filter)
            { }
            column(PIH_Filter; PIH_Filter)
            { }
            column(PIL_Filter; PIL_Filter)
            { }
            column(comp_short_text; comp_short_text)
            { }
            column(From_Date; From_Date)
            { }
            column(To_Date; To_Date)
            { }
            dataitem(PIH; "Purch. Inv. Header")
            {
                DataItemTableView = sorting("No.");
                //RequestFilterFields = "Posting Date", "Buy-from Vendor No.", "Shipment Method Code";
                PrintOnlyIfDetail = true;
                column(Vendor_Code; PIH."Buy-from Vendor No.")
                { }
                column(vendor_name; Vendor_Short_Name)
                { }
                column(PI_Date; PIH."Posting Date")
                { }
                column(PI_No; PIH."No.")
                { }
                column(Currency_Code; Currency_Code)
                { }
                dataitem(PIL; "Purch. Inv. Line")
                {
                    DataItemTableView = sorting("Document No.", "Line No.")
                    order(ascending)
                    where(Type = filter(Item));
                    DataItemLink = "Document No." = field("No.");
                    DataItemLinkReference = PIH;

                    column(Item_No_; PIL."No.")
                    { }
                    column(Item_name; Item_name)
                    { }
                    column(Transaction_Type; "Transaction Type")
                    { }
                    column(Base_UOM; Base_UOM)
                    { }
                    column(Base_UOM_Qty; PIL."Quantity (Base)")
                    { }
                    column(Location_Code; "Location Code") { }
                    column(Decimal_Allow; Decimal_Allow)
                    { }
                    column(PO_Price_per_base_uom; PIL."Line Amount" / PIL."Quantity (Base)")
                    { }
                    column(total_purchase_amount; PIL."Line Amount")
                    { }
                    column(total_purchase_amount_LCY; PIL."Unit Cost (LCY)" * PIL.Quantity)
                    { }
                    column(GRN_Date; GRN_Date)
                    { }
                    column(Order_No_; "Order No.")
                    { }
                    column(Order_Date; Order_Date)
                    { }
                    column(Incoterm; Transaction_Specification_text)
                    { }
                    column(IMP_WH_HNDL; IMP_WH_HNDL)
                    { }
                    column(IMP_WH_PACK; IMP_WH_PACK)
                    { }
                    column(IMP_TRC; IMP_TRC)
                    { }
                    column(IMP_OTHR; IMP_OTHR)
                    { }
                    column(IMP_FRT; IMP_FRT)
                    { }
                    column(IMP_CDT; IMP_CDT)
                    { }
                    column(IMP_INPC; IMP_INPC)
                    { }
                    column(IMP_THC; IMP_THC)
                    { }
                    column(IMP_SERV; IMP_SERV)
                    { }
                    column(IMP_WH_STRG; IMP_WH_STRG)
                    { }
                    column(ITS; ITS)
                    { }
                    column(IMP_DOCS; IMP_DOCS)
                    { }
                    column(DEMURRAGE_CHARGES; DEMURRAGE_CHARGES)
                    { }
                    column(TOTAL_PURCH_EXP_LCY; TOTAL_PURCH_EXP_LCY)
                    { }
                    column(GR_No; "Receipt No.")
                    { }

                    trigger OnPreDataItem()
                    begin
                        if Item_No <> '' then begin
                            PIL.SetRange("No.", Item_No);
                        end;
                        if Incoterm <> '' then
                            PIL.SetRange("Transaction Specification", Incoterm);

                    end;

                    trigger OnAfterGetRecord()
                    begin

                        Base_UOM := '';
                        IMP_WH_HNDL := 0;
                        IMP_WH_PACK := 0;
                        IMP_TRC := 0;
                        IMP_OTHR := 0;
                        IMP_FRT := 0;
                        IMP_CDT := 0;
                        IMP_INPC := 0;
                        IMP_THC := 0;
                        IMP_SERV := 0;
                        IMP_WH_STRG := 0;
                        ITS := 0;
                        IMP_DOCS := 0;
                        DEMURRAGE_CHARGES := 0;
                        TOTAL_PURCH_EXP_LCY := 0;
                        Order_Date := 0D;
                        GRN_Date := 0D;
                        Decimal_Allow := false;
                        Transaction_Specification_text := '';

                        RecItem.ChangeCompany(comp_name);
                        if PIL.Type = PIL.Type::Item then begin
                            RecItem.Reset;
                            RecItem.Get(PIL."No.");
                            Item_name := RecItem."Search Description";
                            Base_UOM := RecItem."Base Unit of Measure";

                            if RecItem.MarketIndustry <> 'MI0008' then
                                CurrReport.Skip();

                            UnitofMeasure.ChangeCompany(comp_name);
                            if UnitofMeasure.Get(Base_UOM) then
                                Decimal_Allow := UnitofMeasure."Decimal Allowed";
                        end;

                        Value_Entry.ChangeCompany(comp_name);
                        Value_Entry.RESET;
                        Value_Entry.SETCURRENTKEY("Document No.");
                        Value_Entry.SETRANGE("Document No.", "Document No.");
                        Value_Entry.SETRANGE("Document Type", Value_Entry."Document Type"::"Purchase Invoice");
                        Value_Entry.SETRANGE("Document Line No.", "Line No.");
                        Value_Entry.SETFILTER("Invoiced Quantity", '<>0');
                        IF Value_Entry.FINDSET THEN
                            REPEAT
                                ILE.ChangeCompany(comp_name);
                                ILE.GET(Value_Entry."Item Ledger Entry No.");
                                IF ILE."Document Type" = ILE."Document Type"::"Purchase Receipt" THEN begin
                                    PurchRcptLine.ChangeCompany(comp_name);
                                    IF PurchRcptLine.GET(ILE."Document No.", ILE."Document Line No.") THEN BEGIN
                                        GRN_Date := PurchRcptLine."Posting Date";
                                        Order_Date := PurchRcptLine."Order Date";
                                        Transaction_Specification_text := PurchRcptLine."Transaction Specification";
                                    END;
                                end;
                            UNTIL Value_Entry.NEXT = 0;

                        ILE.ChangeCompany(comp_name);
                        ILE.Reset;
                        ILE.SetRange("Document Type", ILE."Document Type"::"Purchase Receipt");
                        ILE.SetRange("Document No.", PIL."Receipt No.");
                        ILE.SetRange("Document Line No.", PIL."Receipt Line No.");
                        ILE.SetRange("Item No.", PIL."No.");
                        if ILE.FindFirst() then begin
                            repeat
                                if Item_Charges <> '' then begin
                                    Value_Entry_filter.ChangeCompany(comp_name);
                                    Value_Entry_filter.Reset();
                                    Value_Entry_filter.SetRange("Item Ledger Entry No.", ILE."Entry No.");
                                    Value_Entry_filter.SetFilter("Item Charge No.", '<>%1', '');
                                    Value_Entry_filter.SetRange("Item Charge No.", Item_Charges);
                                    if not Value_Entry_filter.FindFirst() then
                                        CurrReport.Skip();

                                end;

                                Value_Entry.ChangeCompany(comp_name);
                                Value_Entry.Reset();
                                Value_Entry.SetRange("Item Ledger Entry No.", ILE."Entry No.");
                                Value_Entry.SetFilter("Item Charge No.", '<>%1', '');
                                if Value_Entry.FindSet() then begin
                                    repeat
                                        if Value_Entry."Item Charge No." = '23' then begin
                                            IMP_WH_HNDL += Value_Entry."Cost Amount (Actual)";

                                        end;
                                        if Value_Entry."Item Charge No." = '22' then begin
                                            IMP_WH_PACK += Value_Entry."Cost Amount (Actual)";

                                        end;
                                        if Value_Entry."Item Charge No." = '14' then begin
                                            IMP_TRC += Value_Entry."Cost Amount (Actual)";

                                        end;
                                        if Value_Entry."Item Charge No." = '17' then begin
                                            IMP_OTHR += Value_Entry."Cost Amount (Actual)";

                                        end;
                                        if Value_Entry."Item Charge No." = '11' then begin
                                            IMP_FRT += Value_Entry."Cost Amount (Actual)";

                                        end;
                                        if Value_Entry."Item Charge No." = '12' then begin
                                            IMP_CDT += Value_Entry."Cost Amount (Actual)";

                                        end;
                                        if Value_Entry."Item Charge No." = '13' then begin
                                            IMP_INPC += Value_Entry."Cost Amount (Actual)";

                                        end;
                                        if Value_Entry."Item Charge No." = '15' then begin
                                            IMP_THC += Value_Entry."Cost Amount (Actual)";

                                        end;
                                        if Value_Entry."Item Charge No." = '16' then begin
                                            IMP_SERV += Value_Entry."Cost Amount (Actual)";

                                        end;
                                        if Value_Entry."Item Charge No." = '18' then begin
                                            IMP_WH_STRG += Value_Entry."Cost Amount (Actual)";

                                        end;
                                        if Value_Entry."Item Charge No." = '19' then begin
                                            ITS += Value_Entry."Cost Amount (Actual)";

                                        end;
                                        if Value_Entry."Item Charge No." = '25' then begin
                                            IMP_DOCS += Value_Entry."Cost Amount (Actual)";

                                        end;
                                        if Value_Entry."Item Charge No." = '33' then begin
                                            DEMURRAGE_CHARGES += Value_Entry."Cost Amount (Actual)";

                                        end;

                                        TOTAL_PURCH_EXP_LCY += Value_Entry."Cost Amount (Actual)";

                                    until Value_Entry.Next = 0;
                                end;
                            UNTIL ILE.NEXT = 0;
                        end;
                    end;
                }
                trigger OnPreDataItem()
                begin
                    PIH.ChangeCompany(comp_name);
                    PIH.Reset();
                    if (From_Date <> 0D) AND (To_Date <> 0D) then begin
                        PIH.SetFilter("Posting Date", '%1..%2', From_Date, To_Date);
                    end;
                    if Vendor_No <> '' then
                        PIH.SetRange("Buy-from Vendor No.", Vendor_No);
                end;

                trigger OnAfterGetRecord()
                begin
                    TOTAL_PURCH_EXP_LCY := 0;
                    Currency_Code := '';
                    Vendor_Short_Name := '';

                    RecVendor.ChangeCompany(comp_name);
                    if RecVendor.GET("Buy-from Vendor No.") then begin
                        Vendor_Short_Name := RecVendor."Search Name";
                        if (IC_Partner = false) AND (RecVendor."IC Partner Code" <> '') then
                            CurrReport.Skip();

                    end;
                    if PIH."Currency Code" = '' then begin
                        GenLedgerSetup.ChangeCompany(comp_name);
                        GenLedgerSetup.Get();
                        Currency_Code := GenLedgerSetup."LCY Code";
                    end
                    else
                        Currency_Code := PIH."Currency Code";
                    PIL.ChangeCompany(comp_name);

                end;
            }
            trigger OnPreDataItem()
            begin
                //comp_filter := Complist.GetFilters;
                if comp_filter = '' then begin
                    Complist.Reset();
                end
                else begin
                    Complist.SetRange(Name, comp_filter);
                end;

            end;

            trigger OnAfterGetRecord()
            begin
                Complist.ChangeCompany(Complist.Name);
                comp_name := Complist.Name;
                ReportTitle := 'Purchase Cost Report - Paint & Coatings';
                ReportFilter := Complist.GetFilters;
                comp_short.Get(comp_name);
                comp_short_text := comp_short."Short Name";

            end;
        }

    }

    requestpage
    {
        //SaveValues = true;
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Group Filter';
                    field(Details; Details)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Hide Item Charge Details';
                    }
                    field(IC_Partner; IC_Partner)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Include IC Transaction';
                    }
                    field(From_Date; From_Date)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'From Date';
                        ShowMandatory = true;

                    }
                    field(To_Date; To_Date)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'To Date';
                        ShowMandatory = true;
                    }
                    field(comp_filter; comp_filter)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Company ';
                        TableRelation = Company;
                    }
                    field(Vendor_No; Vendor_No)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Vendor No.';
                        TableRelation = Vendor;
                    }
                    field(Item_No; Item_No)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item No.';
                        TableRelation = Item;
                    }
                    field(Item_Charges; Item_Charges)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Charge No.';
                        TableRelation = "Item Charge";
                    }
                    field(Incoterm; Incoterm)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Incoterm';
                        TableRelation = "Transaction Specification";
                    }
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        if (From_Date = 0D) OR (To_Date = 0D) then begin
            Error('From Data and  To Date is Mandatory');
        end;

    end;

    trigger OnPostReport()
    begin

    end;

    var
        IC_Partner: Boolean;
        Incoterm: Code[20];
        Item_No: Code[20];
        Vendor_No: Code[20];
        Item_Charges: code[20];
        comp_filter: Text[100];
        PIH_Filter: Text[250];
        PIL_Filter: Text[250];
        comp_name: Text[50];
        ReportTitle: Text[50];
        ReportFilter: Text[50];
        comp_short: Record "Company Short Name";
        comp_short_text: text[30];
        Vendor_Short_Name: Text[70];
        Details: Boolean;
        RecItem: Record Item;
        Item_name: text[100];
        ILE: Record "Item Ledger Entry";
        GRN_Date: Date;
        Order_Date: Date;

        Base_UOM: Code[10];
        IMP_WH_HNDL: Decimal;
        IMP_WH_PACK: Decimal;
        IMP_TRC: Decimal;
        IMP_OTHR: Decimal;
        IMP_FRT: Decimal;
        IMP_CDT: Decimal;
        IMP_INPC: Decimal;
        IMP_THC: Decimal;
        IMP_SERV: Decimal;
        IMP_WH_STRG: Decimal;
        ITS: Decimal;
        IMP_DOCS: Decimal;
        DEMURRAGE_CHARGES: Decimal;
        TOTAL_PURCH_EXP_LCY: Decimal;
        From_Date: Date;
        To_Date: Date;
        Value_Entry: Record "Value Entry";
        Value_Entry_filter: Record "Value Entry";
        PurchRcptLine: Record "Purch. Rcpt. Line";
        RecVendor: Record Vendor;
        UnitofMeasure: Record "Unit of Measure";
        Decimal_Allow: Boolean;
        Transaction_Specification_text: Text[20];
        Currency_Code: Code[10];
        GenLedgerSetup: Record "General Ledger Setup";

}