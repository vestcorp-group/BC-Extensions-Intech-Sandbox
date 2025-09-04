report 58218 "BPO Summary Report"//T12370-Full Comment  //T13413-Full UnComment
{
    UsageCategory = Administration;
    ApplicationArea = All;
    RDLCLayout = 'Reports/BPOSummaryReport.rdl';
    Caption = 'BPO Summary Report';

    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            UseTemporary = true;
            DataItemTableView = sorting("No.") order(ascending) WHERE("Document Type" = filter('Blanket Order'));
            column(No_; "No.")
            { }
            column(Document_Type; "Document Type")
            { }
            column(Document_Date; "Document Date")
            { }
            column(Supplier_Ref_No; "Vendor Order No.")
            {
                // 30-04-2022 caption is not a vaild property in report
                //Caption = 'Supplier Ref No';
            }
            column(Supplier_Name; "Buy-from Vendor Name")
            {
                // 30-04-2022 caption is not a vaild property in report
                //Caption = 'Supplier Name';
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
            column(Order_Date; "Document Date")
            { }
            column(Shortcut_Dimension_1_Code; SalesPersonG.Name)
            { }
            column(Transaction_Specification; "Transaction Specification")
            { }
            column(CompanyAddr1Value; CompanyAddr1Value)
            { }
            column(CompanyAddr2Value; CompanyAddr2Value)
            { }
            column(CompanyNameValue; CompanyNameValue)
            { }
            column(Company_Name; CompanyShortName."Short Name")
            { }
            // column(CompanyName_Filter; CompanyName_Filter)
            // { }

            column(FromDate; FromDate)
            { }
            column(ToDate; ToDate)
            { }
            column(Status; Status)
            { }
            dataitem(PurchaseLine; "Purchase Line")
            {
                UseTemporary = true;
                DataItemLink = "Document No." = field("No."), "Document Type" = field("Document Type");
                column(PO_Number; OrderNoG)
                { }
                column(BPO_Number; "Document No.")
                {
                    // 30-04-2022 caption is not a vaild property in report
                    //Caption = 'BPO Number';
                }
                column(Supplier_Product_Name; ItemG.Vendor_item_description)
                {
                    // 30-04-2022 caption is not a vaild property in report
                    //Caption = 'Supplier Product Name';
                }
                column(Location_Code; "Location Code")
                { }
                column(Quantity; "Quantity (Base)")
                { }
                column(Quantity_Received; "Qty. Received (Base)")
                { }
                column(Quantity_Invoiced; "Qty. Invoiced (Base)")
                { }
                column(Unit_of_Measure_Code; BaseUOM)
                { }
                column(Rate; "Direct Unit Cost" / "Qty. per Unit of Measure")
                {
                    // 30-04-2022 caption is not a vaild property in report
                    //Caption = 'Rate';
                }
                column(Total_Amount; Amount)
                {
                    // 30-04-2022 caption is not a vaild property in report
                    //Caption = 'Total Amount';
                }
                column(Item_Name; Description)
                {
                    // 30-04-2022 caption is not a vaild property in report
                    // Caption = 'Item Name';
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
                column(Qty__to_Receive; "Quantity (Base)" - "Qty. Received (Base)")
                { }
                column(BPOComment; CommentG)
                { }
                trigger OnAfterGetRecord()
                var
                    PurchaseOrderLineL: Record "Purchase Line";
                    PurchaseCommentLineL: Record "Purch. Comment Line";
                begin
                    Clear(ItemG);
                    Clear(BaseUOM);
                    SalesPersonG.ChangeCompany(PurchaseHeader."Posting Description");
                    ItemG.ChangeCompany(PurchaseHeader."Posting Description");
                    PurchaseOrderLineL.ChangeCompany(PurchaseHeader."Posting Description");
                    PurchaseCommentLineL.ChangeCompany(PurchaseHeader."Posting Description");
                    if Type = Type::Item then
                        if ItemG.Get("No.") then;
                    BaseUOM := ItemG."Base Unit of Measure";

                    if ItemNoG > '' then
                        if "No." <> ItemNoG then
                            CurrReport.Skip();
                    Clear(OrderNoG);
                    Clear(CommentG);
                    PurchaseOrderLineL.Reset();
                    PurchaseOrderLineL.SetRange("Blanket Order No.", "Document No.");

                    if PurchaseOrderLineL.FindFirst() then
                        OrderNoG := PurchaseOrderLineL."Document No.";
                    if SalesPersonG.Get("Shortcut Dimension 1 Code") then;
                    if PurchaseOrderLineL.Type = PurchaseOrderLineL.Type::Item then;

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

            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                SetCurrentKey("No.", "Document Date");
            end;

            trigger OnAfterGetRecord()
            var
                GLSetupL: Record "General Ledger Setup";
            begin
                GLSetupL.ChangeCompany(PurchaseHeader."Posting Description");
                AreaG.ChangeCompany(PurchaseHeader."Posting Description");
                ShipmentMethodG.ChangeCompany(PurchaseHeader."Posting Description");
                TransactionSpecificationG.ChangeCompany(PurchaseHeader."Posting Description");
                PaymentMethodG.ChangeCompany(PurchaseHeader."Posting Description");
                if CompanyShortName.Get("Posting Description") then;

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
            }
        }

    }

    var
        PurchaseHeaderG: Record "Purchase Header";
        PurchaseLineG: Record "Purchase Line";
        CompanyInfo: Record 79;
        SalesPersonG: Record Dimension;
        AreaG: Record "Area";
        ItemG: Record Item;
        ShipmentMethodG: Record "Shipment Method";
        TransactionSpecificationG: Record "Transaction Specification";
        PaymentMethodG: Record "Payment Terms";
        CustomerG: Record Customer;
        CompanyG: Record Company;
        VendorNo: Text[20];
        CompanyNameValue: Text[50];
        CompanyAddr1Value: Text[50];
        CompanyAddr2Value: Text[50];
        OrderNoG: Code[20];
        ItemNoG: Code[20];
        CommentG: Text;
        CompanyNameG: Text;
        FromDate: Date;
        ToDate: Date;
        CompanyName_Filter: Text;
        BaseUOM: Code[20];
        CompanyShortName: Record "Company Short Name";

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
            Clear(RecShortName);//20MAY2022-start
            RecShortName.SetRange(Name, CompanyG."Name");
            RecShortName.SetRange("Block in Reports", true);
            if not RecShortName.FindFirst() then begin
                PurchaseHeaderG.ChangeCompany(CompanyG.Name);
                PurchaseLineG.ChangeCompany(CompanyG.Name);
                PurchaseHeaderG.SetCurrentKey("Document Type", "No.", "Document Date", "Buy-from Vendor No.");
                PurchaseHeaderG.SetRange("Document Type", PurchaseHeaderG."Document Type"::"Blanket Order");
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

}