report 50269 KMP_RptPOSummary//T12370-N
{
    UsageCategory = Administration;
    ApplicationArea = All;
    RDLCLayout = './Layouts/KMP_RptPOSummary.rdl';
    Caption = 'PO Summary Report';
    //'Caption' is being deprecated in the versions: '1.0' or greater. This property does not have any effect on report columns. This warning will become an error in a future release//30th April 2022
    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            UseTemporary = true;
            DataItemTableView = sorting("No.") order(ascending) WHERE("Document Type" = filter('Order'));
            column(No_; "No.")
            { }
            column(Document_Type; "Document Type")
            { }
            column(Document_Date; "Document Date")
            { }
            column(Supplier_Ref_No; "Vendor Order No.")
            {
                //Caption = 'Supplier Ref No';//30-04-2022
            }
            column(Supplier_Name; "Buy-from Vendor Name")
            {
                //Caption = 'Supplier Name';//30-04-2022
            }
            column(Currency_Code; "Currency Code")
            { }
            column(Currency_Factor; 1 / "Currency Factor")
            { }
            column(Delivery_Terms; TransactionSpecificationG.Text + ', ' + AreaG.Text)
            { }
            column(Payment_Terms_Code; PaymentMethodG.Description)
            { }
            column(CustomerNo; CustomerG."Search Name")
            { }
            column(Expected_Receipt_Date; "Expected Receipt Date")
            { }
            column(Order_Date; BPODateG)
            { }
            column("Area"; AreaG.Text)
            { }
            column(CompanyNameValue; CompanyNameValue)
            { }
            column(CompanyAddr1Value; CompanyAddr1Value)
            { }
            column(CompanyAddr2Value; CompanyAddr2Value)
            { }
            column(Company_Name; "Posting Description")
            { }

            column(FromDate; FromDate)
            { }
            column(ToDate; ToDate)
            { }
            dataitem(PurchaseLine; "Purchase Line")
            {
                UseTemporary = true;
                DataItemLink = "Document No." = field("No.");

                column(PO_Number; "Document No.")
                { }
                column(BPO_Number; "Blanket Order No.")
                {
                    //Caption = 'BPO Number';//30-04-2022
                }
                column(Supplier_Product_Name; "Vendor Item No.")
                {
                    //Caption = 'Supplier Product Name';//30-04-2022
                }
                column(Quantity; Quantity)
                { }
                column(Qty__to_Receive; "Qty. to Receive")
                { }
                column(Quantity_Received; "Quantity Received")
                { }
                column(Quantity_Invoiced; "Quantity Invoiced")
                { }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                { }
                column(Rate; "Direct Unit Cost")
                {
                    // Caption = 'Rate';//30-04-2022
                }
                column(Total_Amount; Amount)
                {
                    //Caption = 'Total Amount';////30-04-2022
                }
                column(Item_Name; Description)
                {
                    //Caption = 'Item Name';////30-04-2022
                }
                column(ItemSerachDesc; ItemG."Search Description")
                { }
                column(ETD; CustomETD)
                { }
                column(ETA; CustomETA)
                { }
                column(R_ETD; CustomR_ETD)
                { }
                column(R_ETA; CustomR_ETA)
                { }
                column(POComment; CommentG)
                { }
                dataitem(DimensionSetEntry; "Dimension Set Entry")
                {
                    UseTemporary = true;
                    DataItemLink = "Dimension Set ID" = field("Dimension Set ID");
                    DataItemTableView = WHERE("Dimension Code" = filter('SP'));
                    column(Shortcut_Dimension_1_Code; "Dimension Value Name")
                    { }
                }

                trigger OnAfterGetRecord()
                var
                    PurchaseOrderLineL: Record "Purchase Line";
                    PurchaseHeaderL: Record "Purchase Header";
                    PurchaseCommentLineL: Record "Purch. Comment Line";
                    SalesPersonCodeL: Record "Dimension Set Entry";
                begin
                    // Change Company
                    Clear(CommentG);
                    SalesPersonG.ChangeCompany(PurchaseHeader."Posting Description");
                    ItemG.ChangeCompany(PurchaseHeader."Posting Description");
                    PurchaseHeaderL.ChangeCompany(PurchaseHeader."Posting Description");
                    PurchaseCommentLineL.ChangeCompany(PurchaseHeader."Posting Description");

                    if ItemNoG > '' then
                        if "No." <> ItemNoG then
                            CurrReport.Skip();

                    if SalesPersonG.Get("Shortcut Dimension 1 Code") then;

                    if Type = Type::Item then
                        ItemG.Get("No.");
                    BPODateG := PurchaseHeader."Order Date";
                    if ("Blanket Order No." > '') and
                        PurchaseHeaderL.Get(PurchaseHeaderL."Document Type"::"Blanket Order", "Blanket Order No.") and
                        (PurchaseHeaderL."Document Date" > 0D)
                    then
                        BPODateG := PurchaseHeaderL."Document Date";

                    PurchaseCommentLineL.SetRange("Document Type", "Document Type");
                    PurchaseCommentLineL.SetRange("No.", "Document No.");
                    PurchaseCommentLineL.SetRange("Document Line No.", "Line No.");
                    if PurchaseCommentLineL.FindSet() then
                        repeat
                            if CommentG > '' then
                                CommentG += ',';
                            CommentG += PurchaseCommentLineL.Comment;
                        until PurchaseCommentLineL.Next() = 0;
                end;
            }

            trigger OnAfterGetRecord()
            var
                GLSetupL: Record "General Ledger Setup";
                VendorL: Record Vendor;
            begin
                GLSetupL.ChangeCompany(PurchaseHeader."Posting Description");
                AreaG.ChangeCompany(PurchaseHeader."Posting Description");
                ShipmentMethodG.ChangeCompany(PurchaseHeader."Posting Description");
                TransactionSpecificationG.ChangeCompany(PurchaseHeader."Posting Description");
                PaymentMethodG.ChangeCompany(PurchaseHeader."Posting Description");
                VendorL.ChangeCompany(PurchaseHeader."Posting Description");

                If VendorL.Get("Buy-from Vendor No.") and (VendorL."IC Partner Code" > '') and (not ShowInterCompany) then
                    CurrReport.Skip();
                GLSetupL.Get();
                if "Currency Code" = '' then
                    "Currency Code" := GLSetupL."LCY Code";

                if "Currency Factor" = 0 then
                    "Currency Factor" := 1;

                if "Area" > '' then
                    AreaG.Get("Area");

                if "Shipment Method Code" > '' then
                    ShipmentMethodG.Get("Shipment Method Code");

                if "Transaction Specification" > '' then
                    TransactionSpecificationG.Get("Transaction Specification");

                if "Payment Terms Code" > '' then
                    PaymentMethodG.Get("Payment Terms Code");

                if "Sell-to Customer No." > '' then
                    CustomerG.Get("Sell-to Customer No.");
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                field(FromDate; FromDate)
                {
                    ApplicationArea = All;
                    Caption = 'From Date';
                }
                field(ToDate; ToDate)
                {
                    ApplicationArea = All;
                    Caption = 'To Date';
                }

                field(VendorNo; VendorNo)
                {
                    ApplicationArea = All;
                    Caption = 'Vendor No.';
                    TableRelation = Vendor;
                }
                field("Item No."; ItemNoG)
                {
                    ApplicationArea = All;
                    TableRelation = Item;
                }
                field("Company Name"; CompanyNameG)
                {
                    ApplicationArea = all;
                    TableRelation = Company;
                }
                field("Show Intercompany"; ShowInterCompany)
                {
                    ApplicationArea = all;
                }
            }
        }

    }

    var
        PurchaseHeaderG: Record "Purchase Header";
        PurchaseLineG: Record "Purchase Line";
        ShipmentMethodG: Record "Shipment Method";
        TransactionSpecificationG: Record "Transaction Specification";
        PaymentMethodG: Record "Payment Terms";
        CustomerG: Record Customer;
        SalesPersonG: Record Dimension;
        DimensionSetEntryG: Record "Dimension Set Entry";
        AreaG: Record "Area";
        ItemG: Record Item;
        CompanyInfo: Record 79;
        CompanyG: Record Company;
        FromDate: Date;
        ToDate: Date;
        VendorNo: Text[20];
        CompanyNameValue: Text[50];
        CompanyAddr1Value: Text[50];
        CompanyAddr2Value: Text[50];
        OrderNoG: Code[20];
        ItemNoG: Code[20];
        BPODateG: Date;
        CommentG: Text;
        CompanyNameG: Text;
        ShowInterCompany: Boolean;

    trigger OnPreReport()
    var
        RecordName: Record "Purchase Header";
        CompanyInfoRec: Record "Company Information";
        RecShortName: Record "Company Short Name";//20MAY2022
    begin
        if CompanyNameG > '' then
            CompanyG.SetRange(Name, CompanyNameG);
        CompanyG.FindSet();
        repeat
            //20MAY2022-start
            Clear(RecShortName);
            RecShortName.SetRange(Name, CompanyG.Name);
            RecShortName.SetRange("Block in Reports", true);
            if not RecShortName.FindFirst() then begin
                PurchaseHeaderG.ChangeCompany(CompanyG.Name);
                PurchaseLineG.ChangeCompany(CompanyG.Name);
                DimensionSetEntryG.ChangeCompany(CompanyG.Name);
                PurchaseHeaderG.SetCurrentKey("Document Type", "No.", "Document Date", "Buy-from Vendor No.");
                PurchaseHeaderG.SetRange("Document Type", PurchaseHeaderG."Document Type"::Order);
                PurchaseHeaderG.SetFilter("Document Date", '%1..%2', FromDate, ToDate);
                PurchaseHeaderG.SetFilter("Buy-from Vendor No.", VendorNo);
                if PurchaseHeaderG.FindSet() then
                    repeat
                        InsertHeaderRecord(PurchaseHeaderG, CompanyG.Name);
                        PurchaseLineG.SetCurrentKey("Document Type", "Document No.");
                        PurchaseLineG.SetRange("Document Type", PurchaseHeaderG."Document Type");
                        PurchaseLineG.SetRange("Document No.", PurchaseHeaderG."No.");
                        if PurchaseLineG.FindSet() then
                            repeat
                                InsertLineRecord(PurchaseLineG);
                                DimensionSetEntryG.SetCurrentKey("Dimension Set ID", "Dimension Code");
                                DimensionSetEntryG.SetRange("Dimension Set ID", PurchaseLineG."Dimension Set ID");
                                DimensionSetEntryG.setfilter("Dimension Code", 'SP');
                                if DimensionSetEntryG.FindFirst() then
                                    InsertDimensionRecord(DimensionSetEntryG);
                            until PurchaseLineG.Next() = 0;
                    until PurchaseHeaderG.Next() = 0;
            end;
        until CompanyG.Next() = 0;

        // if CompanyInfoRec.Get() then begin
        //     CompanyNameValue := CompanyInfoRec.Name;
        //     CompanyAddr1Value := CompanyInfoRec.Address;
        //     CompanyAddr2Value := CompanyInfoRec."Address 2";
        // end;
        if CompanyNameG > '' then
            CompanyNameValue := CompanyNameG
        else
            CompanyNameValue := 'Group of Companies';
    end;

    local procedure InsertHeaderRecord(PurchaseHdrP: Record "Purchase Header"; CompanyNameP: Text)
    var
        myInt: Integer;
    begin
        PurchaseHeader.Init();
        PurchaseHeader := PurchaseHdrP;
        PurchaseHeader."Posting Description" := CompanyNameP; // Company Name
        PurchaseHeader.Insert();
    end;

    local procedure InsertLineRecord(PurchaseLineP: Record "Purchase Line")
    var
        myInt: Integer;
    begin
        PurchaseLine.Init();
        PurchaseLine := PurchaseLineP;
        PurchaseLine.Insert();
    end;

    local procedure InsertDimensionRecord(DimensionSetP: Record "Dimension Set Entry")
    var
        myInt: Integer;
    begin
        DimensionSetEntry.Init();
        DimensionSetEntry := DimensionSetP;
        DimensionSetEntry.SetRecFilter();
        if DimensionSetEntry.IsEmpty() then
            DimensionSetEntry.Insert();
    end;
}