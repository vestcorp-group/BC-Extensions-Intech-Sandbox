Page 74984 "Update Document No. (Danger)"
{
    // --------------------------------------------------------------------------------------------------
    // Intech Systems Pvt. Ltd.
    // --------------------------------------------------------------------------------------------------
    // No.                    Date        Author
    // --------------------------------------------------------------------------------------------------
    // I-I034-302003-01       30/04/15    RaviShah
    //                        Update Navigate Page to Chnage Posting Date
    //                        Added Action "Update Date"
    //                        (Copy From Schiller)
    // --------------------------------------------------------------------------------------------------

    DataCaptionExpression = GetCaptionText;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPlus;
    Permissions = TableData "G/L Entry" = rm,
                  TableData "Cust. Ledger Entry" = rm,
                  TableData "Vendor Ledger Entry" = rm,
                  TableData "Item Ledger Entry" = rm,
                  TableData "Sales Shipment Header" = rm,
                  TableData "Sales Shipment Line" = rm,
                  TableData "Sales Invoice Header" = rm,
                  TableData "Sales Invoice Line" = rm,
                  TableData "Sales Cr.Memo Header" = rm,
                  TableData "Sales Cr.Memo Line" = rm,
                  TableData "Purch. Rcpt. Header" = rm,
                  TableData "Purch. Rcpt. Line" = rm,
                  TableData "Purch. Inv. Header" = rm,
                  TableData "Purch. Inv. Line" = rm,
                  TableData "Purch. Cr. Memo Hdr." = rm,
                  TableData "Purch. Cr. Memo Line" = rm,
                  TableData "Bank Account Ledger Entry" = rm,
                  TableData "Check Ledger Entry" = rm,
                  TableData "Detailed Cust. Ledg. Entry" = rm,
                  TableData "Detailed Vendor Ledg. Entry" = rm,
                  TableData "Posted Assembly Header" = rm,
                  TableData "Transfer Shipment Header" = rm,
                  TableData "Transfer Shipment Line" = rm,
                  TableData "Transfer Receipt Header" = rm,
                  TableData "Transfer Receipt Line" = rm,
                  TableData "Value Entry" = rm,
                  TableData "Capacity Ledger Entry" = rm,
                  TableData "Service Ledger Entry" = rm,
                  TableData "Service Invoice Header" = rm,
                  TableData "Service Invoice Line" = rm,
                  TableData "Return Shipment Header" = rm,
                  TableData "Return Shipment Line" = rm,
                  TableData "Return Receipt Header" = rm,
                  TableData "Return Receipt Line" = rm,
                  TableData "Warehouse Entry" = rm,
                  TableData "TDS Entry" = rm,
    TableData "Tax Transaction Value" = rm,
    tabledata "FA Ledger Entry" = rm;
    PromotedActionCategories = 'New,Process,Report,Find By';
    SaveValues = false;
    SourceTable = "Document Entry";
    SourceTableTemporary = true;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Document)
            {
                Caption = 'Document';
                Visible = DocumentVisible;
                field(DocNoFilter; DocNoFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'Document No.';

                    trigger OnValidate()
                    begin
                        SetDocNo(DocNoFilter);
                        ContactType := Contacttype::" ";
                        ContactNo := '';
                        ExtDocNo := '';
                        ClearTrackingInfo;
                        DocNoFilterOnAfterValidate;
                        FilterSelectionChanged;
                    end;
                }
                field(PostingDateFilter; PostingDateFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Date';

                    trigger OnValidate()
                    begin
                        SetPostingDate(PostingDateFilter);
                        ContactType := Contacttype::" ";
                        ContactNo := '';
                        ExtDocNo := '';
                        ClearTrackingInfo;
                        PostingDateFilterOnAfterValida;
                        FilterSelectionChanged;
                    end;
                }
                field(UpdateDate_gDate; UpdateDocNo_gCod)
                {
                    ApplicationArea = Basic;
                    Caption = 'Update Document No.';
                }
            }
            group("Business Contact")
            {
                Caption = 'Business Contact';
                Visible = BusinessContactVisible;
                field(ContactType; ContactType)
                {
                    ApplicationArea = Basic;
                    Caption = 'Business Contact Type';
                    OptionCaption = ' ,Vendor,Customer';

                    trigger OnValidate()
                    begin
                        SetDocNo('');
                        SetPostingDate('');
                        ClearTrackingInfo;
                        ContactTypeOnAfterValidate;
                        FilterSelectionChanged;
                    end;
                }
                field(ContactNo; ContactNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Business Contact No.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Vend: Record Vendor;
                        Cust: Record Customer;
                    begin
                        case ContactType of
                            Contacttype::Vendor:
                                if Page.RunModal(0, Vend) = Action::LookupOK then begin
                                    Text := Vend."No.";
                                    exit(true);
                                end;
                            Contacttype::Customer:
                                if Page.RunModal(0, Cust) = Action::LookupOK then begin
                                    Text := Cust."No.";
                                    exit(true);
                                end;
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        SetDocNo('');
                        SetPostingDate('');
                        ClearTrackingInfo;
                        ContactNoOnAfterValidate;
                        FilterSelectionChanged;
                    end;
                }
                field(ExtDocNo; ExtDocNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'External Document No.';

                    trigger OnValidate()
                    begin
                        SetDocNo('');
                        SetPostingDate('');
                        ClearTrackingInfo;
                        ExtDocNoOnAfterValidate;
                        FilterSelectionChanged;
                    end;
                }
            }
            group("Item Reference")
            {
                Caption = 'Item Reference';
                Visible = ItemReferenceVisible;
                field(SerialNoFilter2; SerialNoFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'Serial No.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        SerialNoInformationList: Page "Serial No. Information List";
                    begin
                        Clear(SerialNoInformationList);
                        if SerialNoInformationList.RunModal = Action::LookupOK then begin
                            Text := SerialNoInformationList.GetSelectionFilter;
                            exit(true);
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        ClearInfo;
                        SerialNoFilterOnAfterValidate;
                        FilterSelectionChanged;
                    end;
                }
                field(LotNoFilter2; LotNoFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'Lot No.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        LotNoInformationList: Page "Lot No. Information List";
                    begin
                        Clear(LotNoInformationList);
                        if LotNoInformationList.RunModal = Action::LookupOK then begin
                            Text := LotNoInformationList.GetSelectionFilter;
                            exit(true);
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        ClearInfo;
                        LotNoFilterOnAfterValidate;
                        FilterSelectionChanged;
                    end;
                }
            }
            group(Notification)
            {
                Caption = 'Notification';
                InstructionalText = 'The filter has been changed. Choose Find to update the list of related entries.';
                Visible = FilterSelectionChangedTxtVisible;
            }
            repeater(Control16)
            {
                Editable = false;
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Table Name"; Rec."Table Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Related Entries';
                }
                field("No. of Records"; Rec."No. of Records")
                {
                    ApplicationArea = Basic;
                    Caption = 'No. of Entries';
                    DrillDown = true;

                    trigger OnDrillDown()
                    begin
                        ShowRecords;
                    end;
                }
            }
            group(Source)
            {
                Caption = 'Source';
                field(DocType; DocType)
                {
                    ApplicationArea = Basic;
                    Caption = 'Document Type';
                    Editable = false;
                    Enabled = DocTypeEnable;
                }
                field(SourceType2; SourceType)
                {
                    ApplicationArea = Basic;
                    Caption = 'Source Type';
                    Editable = false;
                    Enabled = SourceTypeEnable;
                }
                field(SourceNo2; SourceNo)
                {
                    ApplicationArea = Basic;
                    Caption = 'Source No.';
                    Editable = false;
                    Enabled = SourceNoEnable;
                }
                field(SourceName; SourceName)
                {
                    ApplicationArea = Basic;
                    Caption = 'Source Name';
                    Editable = false;
                    Enabled = SourceNameEnable;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Process)
            {
                Caption = 'Process';
                action(Show)
                {
                    ApplicationArea = Basic;
                    Caption = '&Show Related Entries';
                    Enabled = ShowEnable;
                    Image = ViewDocumentLine;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunPageMode = View;

                    trigger OnAction()
                    begin
                        ShowRecords;
                    end;
                }
                action(Find)
                {
                    ApplicationArea = Basic;
                    Caption = 'Fi&nd';
                    Image = Find;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        FindPush;
                        FilterSelectionChangedTxtVisible := false;
                    end;
                }
                action(Print)
                {
                    ApplicationArea = Basic;
                    Caption = '&Print';
                    Ellipsis = true;
                    Enabled = PrintEnable;
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ItemTrackingNavigate: Report "Item Tracking Navigate";
                        DocumentEntries: Report "Document Entries";
                        ItemFilters: Record Item;
                    begin
                        if ItemTrackingSearch then begin
                            Clear(ItemTrackingNavigate);
                            ItemTrackingNavigate.TransferDocEntries(Rec);
                            ItemTrackingNavigate.TransferRecordBuffer(TempRecordBuffer);
                            //NG-NS 070324
                            ItemFilters.SetFilter("Serial No. Filter", SerialNoFilter);
                            ItemFilters.SetFilter("Lot No. Filter", LotNoFilter);
                            ItemFilters.SetFilter("No.", '');
                            ItemFilters.SetFilter("Variant Filter", '');
                            ItemTrackingNavigate.SetTrackingFilters(ItemFilters);
                            //NG-NE 070324  
                            ItemTrackingNavigate.Run;
                        end else begin
                            DocumentEntries.TransferDocEntries(Rec);
                            DocumentEntries.TransferFilters(DocNoFilter, PostingDateFilter);
                            DocumentEntries.Run;
                        end;
                    end;
                }
                action("Update Document No.")
                {
                    ApplicationArea = Basic;
                    Ellipsis = true;
                    Enabled = PrintEnable;
                    Image = UpdateUnitCost;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ItemTrackingNavigate: Report "Item Tracking Navigate";

                    begin
                        UpdateDateRecords_gFnc(); //I-I034-302003-01-N
                    end;
                }
            }
            group(FindGroup)
            {
                Caption = 'Find by';
                action(FindByDocument)
                {
                    ApplicationArea = Basic;
                    Caption = 'Find by Document';
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        FindBasedOn := Findbasedon::Document;
                        UpdateFindByGroupsVisibility;
                    end;
                }
                action(FindByBusinessContact)
                {
                    ApplicationArea = Basic;
                    Caption = 'Find by Business Contact';
                    Image = ContactPerson;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        FindBasedOn := Findbasedon::"Business Contact";
                        UpdateFindByGroupsVisibility;
                    end;
                }
                action(FindByItemReference)
                {
                    ApplicationArea = Basic;
                    Caption = 'Find by Item Reference';
                    Image = ItemTracking;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        FindBasedOn := Findbasedon::"Item Reference";
                        UpdateFindByGroupsVisibility;
                    end;
                }
            }
        }
    }

    trigger OnInit()
    begin
        SourceNameEnable := true;
        SourceNoEnable := true;
        SourceTypeEnable := true;
        DocTypeEnable := true;
        PrintEnable := true;
        ShowEnable := true;
        DocumentVisible := true;
        FindBasedOn := Findbasedon::Document;
    end;

    trigger OnOpenPage()
    begin
        IF UserId <> 'BCADMIN' then
            Error('Only BCADMIN user can use this page');

        UpdateForm := true;
        FindRecordsOnOpen;
    end;

    var
        Text000: label 'The business contact type was not specified.';
        Text001: label 'There are no posted records with this external document number.';
        Text002: label 'Counting records...';
        Text003: label 'Posted Sales Invoice';
        Text004: label 'Posted Sales Credit Memo';
        Text005: label 'Posted Sales Shipment';
        Text006: label 'Issued Reminder';
        Text007: label 'Issued Finance Charge Memo';
        Text008: label 'Posted Purchase Invoice';
        Text009: label 'Posted Purchase Credit Memo';
        Text010: label 'Posted Purchase Receipt';
        Text011: label 'The document number has been used more than once.';
        Text012: label 'This combination of document number and posting date has been used more than once.';
        Text013: label 'There are no posted records with this document number.';
        Text014: label 'There are no posted records with this combination of document number and posting date.';
        Text015: label 'The search results in too many external documents. Please specify a business contact no.';
        Text016: label 'The search results in too many external documents. Please use Navigate from the relevant ledger entries.';
        Text017: label 'Posted Return Receipt';
        Text018: label 'Posted Return Shipment';
        Text019: label 'Posted Transfer Shipment';
        Text020: label 'Posted Transfer Receipt';
        Text021: label 'Sales Order';
        Text022: label 'Sales Invoice';
        Text023: label 'Sales Return Order';
        Text024: label 'Sales Credit Memo';
        Text025: label 'Posted Assembly Order';
        sText003: label 'Posted Service Invoice';
        sText004: label 'Posted Service Credit Memo';
        sText005: label 'Posted Service Shipment';
        sText021: label 'Service Order';
        sText022: label 'Service Invoice';
        sText024: label 'Service Credit Memo';
        Text99000000: label 'Production Order';
        Cust: Record Customer;
        Vend: Record Vendor;
        SOSalesHeader: Record "Sales Header";
        SISalesHeader: Record "Sales Header";
        SROSalesHeader: Record "Sales Header";
        SCMSalesHeader: Record "Sales Header";
        SalesShptHeader: Record "Sales Shipment Header";
        SalesInvHeader: Record "Sales Invoice Header";
        ReturnRcptHeader: Record "Return Receipt Header";
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SOServHeader: Record "Service Header";
        SIServHeader: Record "Service Header";
        SCMServHeader: Record "Service Header";
        ServShptHeader: Record "Service Shipment Header";
        ServInvHeader: Record "Service Invoice Header";
        ServCrMemoHeader: Record "Service Cr.Memo Header";
        IssuedReminderHeader: Record "Issued Reminder Header";
        IssuedFinChrgMemoHeader: Record "Issued Fin. Charge Memo Header";
        PurchRcptHeader: Record "Purch. Rcpt. Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        ReturnShptHeader: Record "Return Shipment Header";
        PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr.";
        ProductionOrderHeader: Record "Production Order";
        PostedAssemblyHeader: Record "Posted Assembly Header";
        TransShptHeader: Record "Transfer Shipment Header";
        TransRcptHeader: Record "Transfer Receipt Header";
        PostedWhseRcptLine: Record "Posted Whse. Receipt Line";
        PostedWhseShptLine: Record "Posted Whse. Shipment Line";
        GLEntry: Record "G/L Entry";
        VATEntry: Record "VAT Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";
        DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        VendLedgEntry: Record "Vendor Ledger Entry";
        DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        ItemLedgEntry: Record "Item Ledger Entry";
        PhysInvtLedgEntry: Record "Phys. Inventory Ledger Entry";
        ResLedgEntry: Record "Res. Ledger Entry";
        JobLedgEntry: Record "Job Ledger Entry";
        JobWIPEntry: Record "Job WIP Entry";
        JobWIPGLEntry: Record "Job WIP G/L Entry";
        ValueEntry: Record "Value Entry";
        BankAccLedgEntry: Record "Bank Account Ledger Entry";
        CheckLedgEntry: Record "Check Ledger Entry";
        ReminderEntry: Record "Reminder/Fin. Charge Entry";
        FALedgEntry: Record "FA Ledger Entry";
        MaintenanceLedgEntry: Record "Maintenance Ledger Entry";
        InsuranceCovLedgEntry: Record "Ins. Coverage Ledger Entry";
        CapacityLedgEntry: Record "Capacity Ledger Entry";
        ServLedgerEntry: Record "Service Ledger Entry";
        GSTLedgerEntry: Record "GST Ledger Entry";
        DetailedGSTLedgerEntry: Record "Detailed GST Ledger Entry";
        ServiceTransferShptHeader: Record "Service Transfer Shpt. Header";
        ServiceTransferRcptHeader: Record "Service Transfer Rcpt. Header";
        WarrantyLedgerEntry: Record "Warranty Ledger Entry";
        WhseEntry: Record "Warehouse Entry";
        TempRecordBuffer: Record "Record Buffer" temporary;
        CostEntry: Record "Cost Entry";
        IncomingDocument: Record "Incoming Document";
        ApplicationManagement: Codeunit "Filter Tokens";
        ItemTrackingNavigateMgt: Codeunit "Item Tracking Navigate Mgt.";
        Window: Dialog;
        DocNoFilter: Code[250];
        PostingDateFilter: Text[250];
        NewDocNo: Code[20];
        ContactNo: Code[250];
        ExtDocNo: Code[250];
        NewPostingDate: Date;
        DocType: Text[50];
        SourceType: Text[30];
        SourceNo: Code[20];
        SourceName: Text[100];
        ContactType: Option " ",Vendor,Customer;
        DocExists: Boolean;
        NewSerialNo: Code[20];
        NewLotNo: Code[20];
        SerialNoFilter: Code[1000];
        LotNoFilter: Code[1000];
        TDSEntry: Record "TDS Entry";
        TCSEntry: Record "TCS Entry";
        //[InDataSet]
        ShowEnable: Boolean;
        //[InDataSet]
        PrintEnable: Boolean;
        //[InDataSet]
        DocTypeEnable: Boolean;
        //[InDataSet]
        SourceTypeEnable: Boolean;
        //[InDataSet]
        SourceNoEnable: Boolean;
        //[InDataSet]
        SourceNameEnable: Boolean;
        UpdateForm: Boolean;
        FindBasedOn: Option Document,"Business Contact","Item Reference";
        //[InDataSet]
        DocumentVisible: Boolean;
        //[InDataSet]
        BusinessContactVisible: Boolean;
        //[InDataSet]
        ItemReferenceVisible: Boolean;
        //[InDataSet]
        FilterSelectionChangedTxtVisible: Boolean;
        PageCaptionTxt: label 'Selected - %1';
        UpdateDocNo_gCod: Code[20];
        PurchRcptLine_gRec: Record "Purch. Rcpt. Line";
        ItemLedgerEntry_gRec: Record "Item Ledger Entry";
        WarehouseEntry_gRec: Record "Warehouse Entry";
        PurchCrmemohdr_gRec: Record "Purch. Cr. Memo Hdr.";
        PurchCrmemoLine_gRec: Record "Purch. Cr. Memo Line";
        CapacityLdrEntry_gRec: Record "Capacity Ledger Entry";


    procedure SetDoc(PostingDate: Date; DocNo: Code[20])
    begin
        NewDocNo := DocNo;
        NewPostingDate := PostingDate;
    end;

    local procedure FindExtRecords()
    var
        VendLedgEntry2: Record "Vendor Ledger Entry";
        FoundRecords: Boolean;
        DateFilter2: Code[250];
        DocNoFilter2: Code[250];
    begin
        FoundRecords := false;
        case ContactType of
            Contacttype::Vendor:
                begin
                    VendLedgEntry2.SetCurrentkey("External Document No.");
                    VendLedgEntry2.SetFilter("External Document No.", ExtDocNo);
                    VendLedgEntry2.SetFilter("Vendor No.", ContactNo);
                    if VendLedgEntry2.FindSet then begin
                        repeat
                            MakeExtFilter(
                              DateFilter2,
                              VendLedgEntry2."Posting Date",
                              DocNoFilter2,
                              VendLedgEntry2."Document No.");
                        until VendLedgEntry2.Next = 0;
                        SetPostingDate(DateFilter2);
                        SetDocNo(DocNoFilter2);
                        FindRecords;
                        FoundRecords := true;
                    end;
                end;
            Contacttype::Customer:
                begin
                    Rec.DeleteAll;
                    Rec."Entry No." := 0;
                    FindUnpostedSalesDocs(SOSalesHeader."document type"::Order.AsInteger(), Text021, SOSalesHeader);
                    FindUnpostedSalesDocs(SISalesHeader."document type"::Invoice.AsInteger(), Text022, SISalesHeader);
                    FindUnpostedSalesDocs(SROSalesHeader."document type"::"Return Order".AsInteger(), Text023, SROSalesHeader);
                    FindUnpostedSalesDocs(SCMSalesHeader."document type"::"Credit Memo".AsInteger(), Text024, SCMSalesHeader);
                    if SalesShptHeader.ReadPermission then begin
                        SalesShptHeader.Reset;
                        SalesShptHeader.SetCurrentkey("Sell-to Customer No.", "External Document No.");
                        SalesShptHeader.SetFilter("Sell-to Customer No.", ContactNo);
                        SalesShptHeader.SetFilter("External Document No.", ExtDocNo);
                        InsertIntoDocEntry(
                          Database::"Sales Shipment Header", 0, Text005, SalesShptHeader.Count);
                    end;
                    if SalesInvHeader.ReadPermission then begin
                        SalesInvHeader.Reset;
                        SalesInvHeader.SetCurrentkey("Sell-to Customer No.", "External Document No.");
                        SalesInvHeader.SetFilter("Sell-to Customer No.", ContactNo);
                        SalesInvHeader.SetFilter("External Document No.", ExtDocNo);
                        InsertIntoDocEntry(
                          Database::"Sales Invoice Header", 0, Text003, SalesInvHeader.Count);
                    end;
                    if ReturnRcptHeader.ReadPermission then begin
                        ReturnRcptHeader.Reset;
                        ReturnRcptHeader.SetCurrentkey("Sell-to Customer No.", "External Document No.");
                        ReturnRcptHeader.SetFilter("Sell-to Customer No.", ContactNo);
                        ReturnRcptHeader.SetFilter("External Document No.", ExtDocNo);
                        InsertIntoDocEntry(
                          Database::"Return Receipt Header", 0, Text017, ReturnRcptHeader.Count);
                    end;
                    if SalesCrMemoHeader.ReadPermission then begin
                        SalesCrMemoHeader.Reset;
                        SalesCrMemoHeader.SetCurrentkey("Sell-to Customer No.", "External Document No.");
                        SalesCrMemoHeader.SetFilter("Sell-to Customer No.", ContactNo);
                        SalesCrMemoHeader.SetFilter("External Document No.", ExtDocNo);
                        InsertIntoDocEntry(
                          Database::"Sales Cr.Memo Header", 0, Text004, SalesCrMemoHeader.Count);
                    end;
                    FindUnpostedServDocs(SOServHeader."document type"::Order.AsInteger(), sText021, SOServHeader);
                    FindUnpostedServDocs(SIServHeader."document type"::Invoice.AsInteger(), sText022, SIServHeader);
                    FindUnpostedServDocs(SCMServHeader."document type"::"Credit Memo".AsInteger(), sText024, SCMServHeader);
                    if ServShptHeader.ReadPermission then begin
                        if ExtDocNo = '' then begin
                            ServShptHeader.Reset;
                            ServShptHeader.SetCurrentkey("Customer No.");
                            ServShptHeader.SetFilter("Customer No.", ContactNo);
                            InsertIntoDocEntry(
                              Database::"Service Shipment Header", 0, sText005, ServShptHeader.Count);
                        end;
                    end;
                    if ServInvHeader.ReadPermission then begin
                        if ExtDocNo = '' then begin
                            ServInvHeader.Reset;
                            ServInvHeader.SetCurrentkey("Customer No.");
                            ServInvHeader.SetFilter("Customer No.", ContactNo);
                            InsertIntoDocEntry(
                              Database::"Service Invoice Header", 0, sText003, ServInvHeader.Count);
                        end;
                    end;
                    if ServCrMemoHeader.ReadPermission then begin
                        if ExtDocNo = '' then begin
                            ServCrMemoHeader.Reset;
                            ServCrMemoHeader.SetCurrentkey("Customer No.");
                            ServCrMemoHeader.SetFilter("Customer No.", ContactNo);
                            InsertIntoDocEntry(
                              Database::"Service Cr.Memo Header", 0, sText004, ServCrMemoHeader.Count);
                        end;
                    end;

                    DocExists := Rec.FindFirst;

                    UpdateFormAfterFindRecords;
                    FoundRecords := DocExists;
                end;
            else
                Error(Text000);
        end;

        if not FoundRecords then begin
            SetSource(0D, '', '', 0, '');
            Message(Text001);
        end;
    end;

    local procedure FindRecords()
    begin
        Window.Open(Text002);
        Rec.Reset;
        Rec.DeleteAll;
        Rec."Entry No." := 0;
        FindIncomingDocumentRecords;
        if SalesShptHeader.ReadPermission then begin
            SalesShptHeader.Reset;
            SalesShptHeader.SetFilter("No.", DocNoFilter);
            SalesShptHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Sales Shipment Header", 0, Text005, SalesShptHeader.Count);
        end;
        if SalesInvHeader.ReadPermission then begin
            SalesInvHeader.Reset;
            SalesInvHeader.SetFilter("No.", DocNoFilter);
            SalesInvHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Sales Invoice Header", 0, Text003, SalesInvHeader.Count);
        end;
        if ReturnRcptHeader.ReadPermission then begin
            ReturnRcptHeader.Reset;
            ReturnRcptHeader.SetFilter("No.", DocNoFilter);
            ReturnRcptHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Return Receipt Header", 0, Text017, ReturnRcptHeader.Count);
        end;
        if SalesCrMemoHeader.ReadPermission then begin
            SalesCrMemoHeader.Reset;
            SalesCrMemoHeader.SetFilter("No.", DocNoFilter);
            SalesCrMemoHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Sales Cr.Memo Header", 0, Text004, SalesCrMemoHeader.Count);
        end;
        if ServShptHeader.ReadPermission then begin
            ServShptHeader.Reset;
            ServShptHeader.SetFilter("No.", DocNoFilter);
            ServShptHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Service Shipment Header", 0, sText005, ServShptHeader.Count);
        end;
        if ServInvHeader.ReadPermission then begin
            ServInvHeader.Reset;
            ServInvHeader.SetFilter("No.", DocNoFilter);
            ServInvHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Service Invoice Header", 0, sText003, ServInvHeader.Count);
        end;
        if ServCrMemoHeader.ReadPermission then begin
            ServCrMemoHeader.Reset;
            ServCrMemoHeader.SetFilter("No.", DocNoFilter);
            ServCrMemoHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Service Cr.Memo Header", 0, sText004, ServCrMemoHeader.Count);
        end;
        if IssuedReminderHeader.ReadPermission then begin
            IssuedReminderHeader.Reset;
            IssuedReminderHeader.SetFilter("No.", DocNoFilter);
            IssuedReminderHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Issued Reminder Header", 0, Text006, IssuedReminderHeader.Count);
        end;
        if IssuedFinChrgMemoHeader.ReadPermission then begin
            IssuedFinChrgMemoHeader.Reset;
            IssuedFinChrgMemoHeader.SetFilter("No.", DocNoFilter);
            IssuedFinChrgMemoHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Issued Fin. Charge Memo Header", 0, Text007,
              IssuedFinChrgMemoHeader.Count);
        end;
        if PurchRcptHeader.ReadPermission then begin
            PurchRcptHeader.Reset;
            PurchRcptHeader.SetFilter("No.", DocNoFilter);
            PurchRcptHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Purch. Rcpt. Header", 0, Text010, PurchRcptHeader.Count);
        end;
        if PurchInvHeader.ReadPermission then begin
            PurchInvHeader.Reset;
            PurchInvHeader.SetFilter("No.", DocNoFilter);
            PurchInvHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Purch. Inv. Header", 0, Text008, PurchInvHeader.Count);
        end;
        if ReturnShptHeader.ReadPermission then begin
            ReturnShptHeader.Reset;
            ReturnShptHeader.SetFilter("No.", DocNoFilter);
            ReturnShptHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Return Shipment Header", 0, Text018, ReturnShptHeader.Count);
        end;
        if PurchCrMemoHeader.ReadPermission then begin
            PurchCrMemoHeader.Reset;
            PurchCrMemoHeader.SetFilter("No.", DocNoFilter);
            PurchCrMemoHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Purch. Cr. Memo Hdr.", 0, Text009, PurchCrMemoHeader.Count);
        end;
        if ProductionOrderHeader.ReadPermission then begin
            ProductionOrderHeader.Reset;
            ProductionOrderHeader.SetRange(
              Status,
              ProductionOrderHeader.Status::Released,
              ProductionOrderHeader.Status::Finished);
            ProductionOrderHeader.SetFilter("No.", DocNoFilter);
            InsertIntoDocEntry(
              Database::"Production Order", 0, Text99000000, ProductionOrderHeader.Count);
        end;
        if PostedAssemblyHeader.ReadPermission then begin
            PostedAssemblyHeader.Reset;
            PostedAssemblyHeader.SetFilter("No.", DocNoFilter);
            InsertIntoDocEntry(
              Database::"Posted Assembly Header", 0, Text025, PostedAssemblyHeader.Count);
        end;
        if TransShptHeader.ReadPermission then begin
            TransShptHeader.Reset;
            TransShptHeader.SetFilter("No.", DocNoFilter);
            TransShptHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Transfer Shipment Header", 0, Text019, TransShptHeader.Count);
        end;
        if TransRcptHeader.ReadPermission then begin
            TransRcptHeader.Reset;
            TransRcptHeader.SetFilter("No.", DocNoFilter);
            TransRcptHeader.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Transfer Receipt Header", 0, Text020, TransRcptHeader.Count);
        end;
        if PostedWhseShptLine.ReadPermission then begin
            PostedWhseShptLine.Reset;
            PostedWhseShptLine.SetCurrentkey("Posted Source No.", "Posting Date");
            PostedWhseShptLine.SetFilter("Posted Source No.", DocNoFilter);
            PostedWhseShptLine.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Posted Whse. Shipment Line", 0,
              PostedWhseShptLine.TableCaption, PostedWhseShptLine.Count);
        end;
        if PostedWhseRcptLine.ReadPermission then begin
            PostedWhseRcptLine.Reset;
            PostedWhseRcptLine.SetCurrentkey("Posted Source No.", "Posting Date");
            PostedWhseRcptLine.SetFilter("Posted Source No.", DocNoFilter);
            PostedWhseRcptLine.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Posted Whse. Receipt Line", 0,
              PostedWhseRcptLine.TableCaption, PostedWhseRcptLine.Count);
        end;
        if GLEntry.ReadPermission then begin
            GLEntry.Reset;
            GLEntry.SetCurrentkey("Document No.", "Posting Date");
            GLEntry.SetFilter("Document No.", DocNoFilter);
            GLEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"G/L Entry", 0, GLEntry.TableCaption, GLEntry.Count);
        end;
        if VATEntry.ReadPermission then begin
            VATEntry.Reset;
            VATEntry.SetCurrentkey("Document No.", "Posting Date");
            VATEntry.SetFilter("Document No.", DocNoFilter);
            VATEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"VAT Entry", 0, VATEntry.TableCaption, VATEntry.Count);
        end;

        if TDSEntry.ReadPermission then begin
            TDSEntry.Reset;
            TDSEntry.SetCurrentkey("Document No.", "Posting Date");
            TDSEntry.SetFilter("Document No.", DocNoFilter);
            TDSEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"TDS Entry", 0, TDSEntry.TableName, TDSEntry.Count);
        end;

        if TCSEntry.ReadPermission then begin
            TCSEntry.Reset;
            TCSEntry.SetCurrentkey("Document No.", "Posting Date");
            TCSEntry.SetFilter("Document No.", DocNoFilter);
            TCSEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"TCS Entry", 0, TCSEntry.TableName, TCSEntry.Count);
        end;

        if CustLedgEntry.ReadPermission then begin
            CustLedgEntry.Reset;
            CustLedgEntry.SetCurrentkey("Document No.");
            CustLedgEntry.SetFilter("Document No.", DocNoFilter);
            CustLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Cust. Ledger Entry", 0, CustLedgEntry.TableCaption, CustLedgEntry.Count);
        end;
        if DtldCustLedgEntry.ReadPermission then begin
            DtldCustLedgEntry.Reset;
            DtldCustLedgEntry.SetCurrentkey("Document No.");
            DtldCustLedgEntry.SetFilter("Document No.", DocNoFilter);
            DtldCustLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Detailed Cust. Ledg. Entry", 0, DtldCustLedgEntry.TableCaption, DtldCustLedgEntry.Count);
        end;
        if ReminderEntry.ReadPermission then begin
            ReminderEntry.Reset;
            ReminderEntry.SetCurrentkey(Type, "No.");
            ReminderEntry.SetFilter("No.", DocNoFilter);
            ReminderEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Reminder/Fin. Charge Entry", 0, ReminderEntry.TableCaption, ReminderEntry.Count);
        end;
        if VendLedgEntry.ReadPermission then begin
            VendLedgEntry.Reset;
            VendLedgEntry.SetCurrentkey("Document No.");
            VendLedgEntry.SetFilter("Document No.", DocNoFilter);
            VendLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Vendor Ledger Entry", 0, VendLedgEntry.TableCaption, VendLedgEntry.Count);
        end;
        if DtldVendLedgEntry.ReadPermission then begin
            DtldVendLedgEntry.Reset;
            DtldVendLedgEntry.SetCurrentkey("Document No.");
            DtldVendLedgEntry.SetFilter("Document No.", DocNoFilter);
            DtldVendLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Detailed Vendor Ledg. Entry", 0, DtldVendLedgEntry.TableCaption, DtldVendLedgEntry.Count);
        end;
        if ItemLedgEntry.ReadPermission then begin
            ItemLedgEntry.Reset;
            ItemLedgEntry.SetCurrentkey("Document No.");
            ItemLedgEntry.SetFilter("Document No.", DocNoFilter);
            ItemLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Item Ledger Entry", 0, ItemLedgEntry.TableCaption, ItemLedgEntry.Count);
        end;
        if ValueEntry.ReadPermission then begin
            ValueEntry.Reset;
            ValueEntry.SetCurrentkey("Document No.");
            ValueEntry.SetFilter("Document No.", DocNoFilter);
            ValueEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Value Entry", 0, ValueEntry.TableCaption, ValueEntry.Count);
        end;
        if PhysInvtLedgEntry.ReadPermission then begin
            PhysInvtLedgEntry.Reset;
            PhysInvtLedgEntry.SetCurrentkey("Document No.", "Posting Date");
            PhysInvtLedgEntry.SetFilter("Document No.", DocNoFilter);
            PhysInvtLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Phys. Inventory Ledger Entry", 0, PhysInvtLedgEntry.TableCaption, PhysInvtLedgEntry.Count);
        end;
        if ResLedgEntry.ReadPermission then begin
            ResLedgEntry.Reset;
            ResLedgEntry.SetCurrentkey("Document No.", "Posting Date");
            ResLedgEntry.SetFilter("Document No.", DocNoFilter);
            ResLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Res. Ledger Entry", 0, ResLedgEntry.TableCaption, ResLedgEntry.Count);
        end;
        FindJobRecords;
        if BankAccLedgEntry.ReadPermission then begin
            BankAccLedgEntry.Reset;
            BankAccLedgEntry.SetCurrentkey("Document No.", "Posting Date");
            BankAccLedgEntry.SetFilter("Document No.", DocNoFilter);
            BankAccLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Bank Account Ledger Entry", 0, BankAccLedgEntry.TableCaption, BankAccLedgEntry.Count);
        end;
        if CheckLedgEntry.ReadPermission then begin
            CheckLedgEntry.Reset;
            CheckLedgEntry.SetCurrentkey("Document No.", "Posting Date");
            CheckLedgEntry.SetFilter("Document No.", DocNoFilter);
            CheckLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Check Ledger Entry", 0, CheckLedgEntry.TableCaption, CheckLedgEntry.Count);
        end;
        if FALedgEntry.ReadPermission then begin
            FALedgEntry.Reset;
            FALedgEntry.SetCurrentkey("Document No.", "Posting Date");
            FALedgEntry.SetFilter("Document No.", DocNoFilter);
            FALedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"FA Ledger Entry", 0, FALedgEntry.TableCaption, FALedgEntry.Count);
        end;
        if MaintenanceLedgEntry.ReadPermission then begin
            MaintenanceLedgEntry.Reset;
            MaintenanceLedgEntry.SetCurrentkey("Document No.", "Posting Date");
            MaintenanceLedgEntry.SetFilter("Document No.", DocNoFilter);
            MaintenanceLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Maintenance Ledger Entry", 0, MaintenanceLedgEntry.TableCaption, MaintenanceLedgEntry.Count);
        end;
        if InsuranceCovLedgEntry.ReadPermission then begin
            InsuranceCovLedgEntry.Reset;
            InsuranceCovLedgEntry.SetCurrentkey("Document No.", "Posting Date");
            InsuranceCovLedgEntry.SetFilter("Document No.", DocNoFilter);
            InsuranceCovLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Ins. Coverage Ledger Entry", 0, InsuranceCovLedgEntry.TableCaption, InsuranceCovLedgEntry.Count);
        end;
        if CapacityLedgEntry.ReadPermission then begin
            CapacityLedgEntry.Reset;
            CapacityLedgEntry.SetCurrentkey("Document No.", "Posting Date");
            CapacityLedgEntry.SetFilter("Document No.", DocNoFilter);
            CapacityLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Capacity Ledger Entry", 0, CapacityLedgEntry.TableCaption, CapacityLedgEntry.Count);
        end;
        if WhseEntry.ReadPermission then begin
            WhseEntry.Reset;
            WhseEntry.SetCurrentkey("Reference No.", "Registering Date");
            WhseEntry.SetFilter("Reference No.", DocNoFilter);
            WhseEntry.SetFilter("Registering Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Warehouse Entry", 0, WhseEntry.TableCaption, WhseEntry.Count);
        end;

        if ServLedgerEntry.ReadPermission then begin
            ServLedgerEntry.Reset;
            ServLedgerEntry.SetCurrentkey("Document No.", "Posting Date");
            ServLedgerEntry.SetFilter("Document No.", DocNoFilter);
            ServLedgerEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Service Ledger Entry", 0, ServLedgerEntry.TableCaption, ServLedgerEntry.Count);
        end;
        if WarrantyLedgerEntry.ReadPermission then begin
            WarrantyLedgerEntry.Reset;
            WarrantyLedgerEntry.SetCurrentkey("Document No.", "Posting Date");
            WarrantyLedgerEntry.SetFilter("Document No.", DocNoFilter);
            WarrantyLedgerEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Warranty Ledger Entry", 0, WarrantyLedgerEntry.TableCaption, WarrantyLedgerEntry.Count);
        end;

        if CostEntry.ReadPermission then begin
            CostEntry.Reset;
            CostEntry.SetCurrentkey("Document No.", "Posting Date");
            CostEntry.SetFilter("Document No.", DocNoFilter);
            CostEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Cost Entry", 0, CostEntry.TableCaption, CostEntry.Count);
        end;

        if GSTLedgerEntry.ReadPermission then begin
            GSTLedgerEntry.Reset;
            GSTLedgerEntry.SetCurrentkey("Document No.", "Posting Date");
            GSTLedgerEntry.SetFilter("Document No.", DocNoFilter);
            GSTLedgerEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"GST Ledger Entry", 0, GSTLedgerEntry.TableCaption, GSTLedgerEntry.Count);
        end;
        if DetailedGSTLedgerEntry.ReadPermission then begin
            DetailedGSTLedgerEntry.Reset;
            DetailedGSTLedgerEntry.SetCurrentkey("Document No.", "Posting Date");
            DetailedGSTLedgerEntry.SetFilter("Document No.", DocNoFilter);
            DetailedGSTLedgerEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Detailed GST Ledger Entry", 0, DetailedGSTLedgerEntry.TableCaption, DetailedGSTLedgerEntry.Count);
        end;
        if ServiceTransferShptHeader.ReadPermission then begin
            ServiceTransferShptHeader.Reset;
            ServiceTransferShptHeader.SetFilter("No.", DocNoFilter);
            ServiceTransferShptHeader.SetFilter("Shipment Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Service Transfer Shpt. Header", 0, ServiceTransferShptHeader.TableCaption, ServiceTransferShptHeader.Count);
        end;
        if ServiceTransferRcptHeader.ReadPermission then begin
            ServiceTransferRcptHeader.Reset;
            ServiceTransferRcptHeader.SetFilter("No.", DocNoFilter);
            ServiceTransferRcptHeader.SetFilter("Receipt Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Service Transfer Rcpt. Header", 0, ServiceTransferRcptHeader.TableCaption, ServiceTransferRcptHeader.Count);
        end;
        DocExists := Rec.FindFirst;

        SetSource(0D, '', '', 0, '');
        if DocExists then begin
            if (NoOfRecords(Database::"Cust. Ledger Entry") + NoOfRecords(Database::"Vendor Ledger Entry") <= 1) and
               (NoOfRecords(Database::"Sales Invoice Header") + NoOfRecords(Database::"Sales Cr.Memo Header") +
                NoOfRecords(Database::"Sales Shipment Header") + NoOfRecords(Database::"Issued Reminder Header") +
                NoOfRecords(Database::"Issued Fin. Charge Memo Header") + NoOfRecords(Database::"Purch. Inv. Header") +
                NoOfRecords(Database::"Return Shipment Header") + NoOfRecords(Database::"Return Receipt Header") +
                NoOfRecords(Database::"Purch. Cr. Memo Hdr.") + NoOfRecords(Database::"Purch. Rcpt. Header") +
                NoOfRecords(Database::"Service Invoice Header") + NoOfRecords(Database::"Service Cr.Memo Header") +
                NoOfRecords(Database::"Service Shipment Header") +
                NoOfRecords(Database::"Transfer Shipment Header") + NoOfRecords(Database::"Transfer Receipt Header") <= 1)
            then begin
                // Service Management
                if NoOfRecords(Database::"Service Ledger Entry") = 1 then begin
                    ServLedgerEntry.FindFirst;
                    if ServLedgerEntry.Type = ServLedgerEntry.Type::"Service Contract" then
                        SetSource(
                          ServLedgerEntry."Posting Date", Format(ServLedgerEntry."Document Type"), ServLedgerEntry."Document No.",
                          2, ServLedgerEntry."Service Contract No.")
                    else
                        SetSource(
                          ServLedgerEntry."Posting Date", Format(ServLedgerEntry."Document Type"), ServLedgerEntry."Document No.",
                          2, ServLedgerEntry."Service Order No.")
                end;
                if NoOfRecords(Database::"Warranty Ledger Entry") = 1 then begin
                    WarrantyLedgerEntry.FindFirst;
                    SetSource(
                      WarrantyLedgerEntry."Posting Date", '', WarrantyLedgerEntry."Document No.",
                      2, WarrantyLedgerEntry."Service Order No.")
                end;

                // Sales
                if NoOfRecords(Database::"Cust. Ledger Entry") = 1 then begin
                    CustLedgEntry.FindFirst;
                    SetSource(
                      CustLedgEntry."Posting Date", Format(CustLedgEntry."Document Type"), CustLedgEntry."Document No.",
                      1, CustLedgEntry."Customer No.");
                end;
                if NoOfRecords(Database::"Detailed Cust. Ledg. Entry") = 1 then begin
                    DtldCustLedgEntry.FindFirst;
                    SetSource(
                      DtldCustLedgEntry."Posting Date", Format(DtldCustLedgEntry."Document Type"), DtldCustLedgEntry."Document No.",
                      1, DtldCustLedgEntry."Customer No.");
                end;
                if NoOfRecords(Database::"Sales Invoice Header") = 1 then begin
                    SalesInvHeader.FindFirst;
                    SetSource(
                      SalesInvHeader."Posting Date", Format(Rec."Table Name"), SalesInvHeader."No.",
                      1, SalesInvHeader."Bill-to Customer No.");
                end;
                if NoOfRecords(Database::"Sales Cr.Memo Header") = 1 then begin
                    SalesCrMemoHeader.FindFirst;
                    SetSource(
                      SalesCrMemoHeader."Posting Date", Format(Rec."Table Name"), SalesCrMemoHeader."No.",
                      1, SalesCrMemoHeader."Bill-to Customer No.");
                end;
                if NoOfRecords(Database::"Return Receipt Header") = 1 then begin
                    ReturnRcptHeader.FindFirst;
                    SetSource(
                      ReturnRcptHeader."Posting Date", Format(Rec."Table Name"), ReturnRcptHeader."No.",
                      1, ReturnRcptHeader."Sell-to Customer No.");
                end;
                if NoOfRecords(Database::"Sales Shipment Header") = 1 then begin
                    SalesShptHeader.FindFirst;
                    SetSource(
                      SalesShptHeader."Posting Date", Format(Rec."Table Name"), SalesShptHeader."No.",
                      1, SalesShptHeader."Sell-to Customer No.");
                end;
                if NoOfRecords(Database::"Posted Whse. Shipment Line") = 1 then begin
                    PostedWhseShptLine.FindFirst;
                    SetSource(
                      PostedWhseShptLine."Posting Date", Format(Rec."Table Name"), PostedWhseShptLine."No.",
                      1, PostedWhseShptLine."Destination No.");
                end;
                if NoOfRecords(Database::"Issued Reminder Header") = 1 then begin
                    IssuedReminderHeader.FindFirst;
                    SetSource(
                      IssuedReminderHeader."Posting Date", Format(Rec."Table Name"), IssuedReminderHeader."No.",
                      1, IssuedReminderHeader."Customer No.");
                end;
                if NoOfRecords(Database::"Issued Fin. Charge Memo Header") = 1 then begin
                    IssuedFinChrgMemoHeader.FindFirst;
                    SetSource(
                      IssuedFinChrgMemoHeader."Posting Date", Format(Rec."Table Name"), IssuedFinChrgMemoHeader."No.",
                      1, IssuedFinChrgMemoHeader."Customer No.");
                end;

                if NoOfRecords(Database::"Service Invoice Header") = 1 then begin
                    ServInvHeader.FindFirst;
                    SetSource(
                      ServInvHeader."Posting Date", Format(Rec."Table Name"), ServInvHeader."No.",
                      1, ServInvHeader."Bill-to Customer No.");
                end;
                if NoOfRecords(Database::"Service Cr.Memo Header") = 1 then begin
                    ServCrMemoHeader.FindFirst;
                    SetSource(
                      ServCrMemoHeader."Posting Date", Format(Rec."Table Name"), ServCrMemoHeader."No.",
                      1, ServCrMemoHeader."Bill-to Customer No.");
                end;
                if NoOfRecords(Database::"Service Shipment Header") = 1 then begin
                    ServShptHeader.FindFirst;
                    SetSource(
                      ServShptHeader."Posting Date", Format(Rec."Table Name"), ServShptHeader."No.",
                      1, ServShptHeader."Customer No.");
                end;

                // Purchase
                if NoOfRecords(Database::"Vendor Ledger Entry") = 1 then begin
                    VendLedgEntry.FindFirst;
                    SetSource(
                      VendLedgEntry."Posting Date", Format(VendLedgEntry."Document Type"), VendLedgEntry."Document No.",
                      2, VendLedgEntry."Vendor No.");
                end;
                if NoOfRecords(Database::"Detailed Vendor Ledg. Entry") = 1 then begin
                    DtldVendLedgEntry.FindFirst;
                    SetSource(
                      DtldVendLedgEntry."Posting Date", Format(DtldVendLedgEntry."Document Type"), DtldVendLedgEntry."Document No.",
                      2, DtldVendLedgEntry."Vendor No.");
                end;
                if NoOfRecords(Database::"Purch. Inv. Header") = 1 then begin
                    PurchInvHeader.FindFirst;
                    SetSource(
                      PurchInvHeader."Posting Date", Format(Rec."Table Name"), PurchInvHeader."No.",
                      2, PurchInvHeader."Pay-to Vendor No.");
                end;
                if NoOfRecords(Database::"Purch. Cr. Memo Hdr.") = 1 then begin
                    PurchCrMemoHeader.FindFirst;
                    SetSource(
                      PurchCrMemoHeader."Posting Date", Format(Rec."Table Name"), PurchCrMemoHeader."No.",
                      2, PurchCrMemoHeader."Pay-to Vendor No.");
                end;
                if NoOfRecords(Database::"Return Shipment Header") = 1 then begin
                    ReturnShptHeader.FindFirst;
                    SetSource(
                      ReturnShptHeader."Posting Date", Format(Rec."Table Name"), ReturnShptHeader."No.",
                      2, ReturnShptHeader."Buy-from Vendor No.");
                end;
                if NoOfRecords(Database::"Purch. Rcpt. Header") = 1 then begin
                    PurchRcptHeader.FindFirst;
                    SetSource(
                      PurchRcptHeader."Posting Date", Format(Rec."Table Name"), PurchRcptHeader."No.",
                      2, PurchRcptHeader."Buy-from Vendor No.");
                end;
                if NoOfRecords(Database::"Posted Whse. Receipt Line") = 1 then begin
                    PostedWhseRcptLine.FindFirst;
                    SetSource(
                      PostedWhseRcptLine."Posting Date", Format(Rec."Table Name"), PostedWhseRcptLine."No.",
                      2, '');
                end;
            end else begin
                if DocNoFilter <> '' then
                    if PostingDateFilter = '' then
                        Message(Text011)
                    else
                        Message(Text012);
            end;
        end else
            if PostingDateFilter = '' then
                Message(Text013)
            else
                Message(Text014);

        if UpdateForm then
            UpdateFormAfterFindRecords;
        Window.Close;
    end;

    local procedure FindJobRecords()
    begin
        if JobLedgEntry.ReadPermission then begin
            JobLedgEntry.Reset;
            JobLedgEntry.SetCurrentkey("Document No.", "Posting Date");
            JobLedgEntry.SetFilter("Document No.", DocNoFilter);
            JobLedgEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Job Ledger Entry", 0, JobLedgEntry.TableCaption, JobLedgEntry.Count);
        end;
        if JobWIPEntry.ReadPermission then begin
            JobWIPEntry.Reset;
            JobWIPEntry.SetFilter("Document No.", DocNoFilter);
            JobWIPEntry.SetFilter("WIP Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Job WIP Entry", 0, JobWIPEntry.TableCaption, JobWIPEntry.Count);
        end;
        if JobWIPGLEntry.ReadPermission then begin
            JobWIPGLEntry.Reset;
            JobWIPGLEntry.SetCurrentkey("Document No.", "Posting Date");
            JobWIPGLEntry.SetFilter("Document No.", DocNoFilter);
            JobWIPGLEntry.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Job WIP G/L Entry", 0, JobWIPGLEntry.TableCaption, JobWIPGLEntry.Count);
        end;
    end;


    procedure FindIncomingDocumentRecords()
    begin
        if IncomingDocument.ReadPermission then begin
            IncomingDocument.Reset;
            IncomingDocument.SetFilter("Document No.", DocNoFilter);
            IncomingDocument.SetFilter("Posting Date", PostingDateFilter);
            InsertIntoDocEntry(
              Database::"Incoming Document", 0, IncomingDocument.TableCaption, IncomingDocument.Count);
        end;
    end;

    local procedure UpdateFormAfterFindRecords()
    begin
        ShowEnable := DocExists;
        PrintEnable := DocExists;
        CurrPage.Update(false);
        DocExists := Rec.FindFirst;
        if DocExists then;
    end;

    local procedure InsertIntoDocEntry(DocTableID: Integer; DocType: Option; DocTableName: Text[1024]; DocNoOfRecords: Integer)
    begin
        if DocNoOfRecords = 0 then
            exit;
        Rec.Init;
        Rec."Entry No." := Rec."Entry No." + 1;
        Rec."Table ID" := DocTableID;
#pragma warning disable
        Rec."Document Type" := DocType;
#pragma warning disable
        Rec."Table Name" := CopyStr(DocTableName, 1, MaxStrLen(Rec."Table Name"));
        Rec."No. of Records" := DocNoOfRecords;
        Rec.Insert;
    end;

    local procedure NoOfRecords(TableID: Integer): Integer
    begin
        Rec.SetRange("Table ID", TableID);
        if not Rec.FindFirst then
            Rec.Init;
        Rec.SetRange("Table ID");
        exit(Rec."No. of Records");
    end;

    local procedure SetSource(PostingDate: Date; DocType2: Text[50]; DocNo: Text[50]; SourceType2: Integer; SourceNo2: Code[20])
    begin
        if SourceType2 = 0 then begin
            DocType := '';
            SourceType := '';
            SourceNo := '';
            SourceName := '';
        end else begin
            DocType := DocType2;
            SourceNo := SourceNo2;
            Rec.SetRange("Document No.", DocNo);
            Rec.SetRange("Posting Date", PostingDate);
            //DocNoFilter := GETFILTER("Document No.");  //NG-O 120719 it was change the searching document no. in case of warehouse document
            PostingDateFilter := Rec.GetFilter("Posting Date");
            case SourceType2 of
                1:
                    begin
                        SourceType := Cust.TableCaption;
                        if not Cust.Get(SourceNo) then
                            Cust.Init;
                        SourceName := Cust.Name;
                    end;
                2:
                    begin
                        SourceType := Vend.TableCaption;
                        if not Vend.Get(SourceNo) then
                            Vend.Init;
                        SourceName := Vend.Name;
                    end;
            end;
        end;
        DocTypeEnable := SourceType2 <> 0;
        SourceTypeEnable := SourceType2 <> 0;
        SourceNoEnable := SourceType2 <> 0;
        SourceNameEnable := SourceType2 <> 0;
    end;

    local procedure ShowRecords()
    begin
        if ItemTrackingSearch then
            ItemTrackingNavigateMgt.Show(Rec."Table ID")
        else
            case Rec."Table ID" of
                Database::"Incoming Document":
                    Page.Run(0, IncomingDocument);
                Database::"Sales Header":
                    ShowSalesHeaderRecords;
                Database::"Sales Invoice Header":
                    if Rec."No. of Records" = 1 then
                        Page.Run(GetPageId(Page::"Posted Sales Invoice"), SalesInvHeader)
                    else
                        Page.Run(GetPageId(Page::"Posted Sales Invoices"), SalesInvHeader);
                Database::"Sales Cr.Memo Header":
                    if Rec."No. of Records" = 1 then
                        Page.Run(GetPageId(Page::"Posted Sales Credit Memo"), SalesCrMemoHeader)
                    else
                        Page.Run(GetPageId(Page::"Posted Sales Credit Memos"), SalesCrMemoHeader);
                Database::"Return Receipt Header":
                    if Rec."No. of Records" = 1 then
                        Page.Run(Page::"Posted Return Receipt", ReturnRcptHeader)
                    else
                        Page.Run(0, ReturnRcptHeader);
                Database::"Sales Shipment Header":
                    if Rec."No. of Records" = 1 then
                        Page.Run(Page::"Posted Sales Shipment", SalesShptHeader)
                    else
                        Page.Run(0, SalesShptHeader);
                Database::"Issued Reminder Header":
                    if Rec."No. of Records" = 1 then
                        Page.Run(Page::"Issued Reminder", IssuedReminderHeader)
                    else
                        Page.Run(0, IssuedReminderHeader);
                Database::"Issued Fin. Charge Memo Header":
                    if Rec."No. of Records" = 1 then
                        Page.Run(Page::"Issued Finance Charge Memo", IssuedFinChrgMemoHeader)
                    else
                        Page.Run(0, IssuedFinChrgMemoHeader);
                Database::"Purch. Inv. Header":
                    if Rec."No. of Records" = 1 then
                        Page.Run(GetPageId(Page::"Posted Purchase Invoice"), PurchInvHeader)
                    else
                        Page.Run(GetPageId(Page::"Posted Purchase Invoices"), PurchInvHeader);
                Database::"Purch. Cr. Memo Hdr.":
                    if Rec."No. of Records" = 1 then
                        Page.Run(GetPageId(Page::"Posted Purchase Credit Memo"), PurchCrMemoHeader)
                    else
                        Page.Run(GetPageId(Page::"Posted Purchase Credit Memos"), PurchCrMemoHeader);
                Database::"Return Shipment Header":
                    if Rec."No. of Records" = 1 then
                        Page.Run(Page::"Posted Return Shipment", ReturnShptHeader)
                    else
                        Page.Run(0, ReturnShptHeader);
                Database::"Purch. Rcpt. Header":
                    if Rec."No. of Records" = 1 then
                        Page.Run(Page::"Posted Purchase Receipt", PurchRcptHeader)
                    else
                        Page.Run(0, PurchRcptHeader);
                Database::"Production Order":
                    Page.Run(0, ProductionOrderHeader);
                Database::"Posted Assembly Header":
                    if Rec."No. of Records" = 1 then
                        Page.Run(Page::"Posted Assembly Order", PostedAssemblyHeader)
                    else
                        Page.Run(0, PostedAssemblyHeader);
                Database::"Transfer Shipment Header":
                    if Rec."No. of Records" = 1 then
                        Page.Run(Page::"Posted Transfer Shipment", TransShptHeader)
                    else
                        Page.Run(0, TransShptHeader);
                Database::"Transfer Receipt Header":
                    if Rec."No. of Records" = 1 then
                        Page.Run(Page::"Posted Transfer Receipt", TransRcptHeader)
                    else
                        Page.Run(0, TransRcptHeader);
                Database::"Posted Whse. Shipment Line":
                    Page.Run(0, PostedWhseShptLine);
                Database::"Posted Whse. Receipt Line":
                    Page.Run(0, PostedWhseRcptLine);
                Database::"G/L Entry":
                    Page.Run(0, GLEntry);
                Database::"VAT Entry":
                    Page.Run(0, VATEntry);
                Database::"Detailed Cust. Ledg. Entry":
                    Page.Run(0, DtldCustLedgEntry);
                Database::"Cust. Ledger Entry":
                    Page.Run(0, CustLedgEntry);
                Database::"Reminder/Fin. Charge Entry":
                    Page.Run(0, ReminderEntry);
                Database::"Vendor Ledger Entry":
                    Page.Run(0, VendLedgEntry);
                Database::"Detailed Vendor Ledg. Entry":
                    Page.Run(0, DtldVendLedgEntry);
                Database::"Item Ledger Entry":
                    Page.Run(0, ItemLedgEntry);
                Database::"Value Entry":
                    Page.Run(0, ValueEntry);
                Database::"Phys. Inventory Ledger Entry":
                    Page.Run(0, PhysInvtLedgEntry);
                Database::"Res. Ledger Entry":
                    Page.Run(0, ResLedgEntry);
                Database::"Job Ledger Entry":
                    Page.Run(0, JobLedgEntry);
                Database::"Job WIP Entry":
                    Page.Run(0, JobWIPEntry);
                Database::"Job WIP G/L Entry":
                    Page.Run(0, JobWIPGLEntry);
                Database::"Bank Account Ledger Entry":
                    Page.Run(0, BankAccLedgEntry);
                Database::"Check Ledger Entry":
                    Page.Run(0, CheckLedgEntry);
                Database::"FA Ledger Entry":
                    Page.Run(0, FALedgEntry);
                Database::"Maintenance Ledger Entry":
                    Page.Run(0, MaintenanceLedgEntry);
                Database::"Ins. Coverage Ledger Entry":
                    Page.Run(0, InsuranceCovLedgEntry);
                Database::"Capacity Ledger Entry":
                    Page.Run(0, CapacityLedgEntry);
                Database::"Warehouse Entry":
                    Page.Run(0, WhseEntry);
                Database::"Service Header":
                    ShowServiceHeaderRecords;
                Database::"Service Invoice Header":
                    if Rec."No. of Records" = 1 then
                        Page.Run(Page::"Posted Service Invoice", ServInvHeader)
                    else
                        Page.Run(0, ServInvHeader);
                Database::"Service Cr.Memo Header":
                    if Rec."No. of Records" = 1 then
                        Page.Run(Page::"Posted Service Credit Memo", ServCrMemoHeader)
                    else
                        Page.Run(0, ServCrMemoHeader);
                Database::"Service Shipment Header":
                    if Rec."No. of Records" = 1 then
                        Page.Run(Page::"Posted Service Shipment", ServShptHeader)
                    else
                        Page.Run(0, ServShptHeader);
                Database::"Service Ledger Entry":
                    Page.Run(0, ServLedgerEntry);
                Database::"Cost Entry":
                    Page.Run(0, CostEntry);
                Database::"Warranty Ledger Entry":
                    Page.Run(0, WarrantyLedgerEntry);
            end;
    end;

    local procedure ShowSalesHeaderRecords()
    begin
        Rec.TestField("Table ID", Database::"Sales Header");

        case Rec."Document Type" of
            Rec."document type"::Order:
                if Rec."No. of Records" = 1 then
                    Page.Run(Page::"Sales Order", SOSalesHeader)
                else
                    Page.Run(0, SOSalesHeader);
            Rec."document type"::Invoice:
                if Rec."No. of Records" = 1 then
                    Page.Run(GetPageId(Page::"Sales Invoice"), SISalesHeader)
                else
                    Page.Run(0, SISalesHeader);
            Rec."document type"::"Return Order":
                if Rec."No. of Records" = 1 then
                    Page.Run(Page::"Sales Return Order", SROSalesHeader)
                else
                    Page.Run(0, SROSalesHeader);
            Rec."document type"::"Credit Memo":
                if Rec."No. of Records" = 1 then
                    Page.Run(GetPageId(Page::"Sales Credit Memo"), SCMSalesHeader)
                else
                    Page.Run(0, SCMSalesHeader);
        end;
    end;

    local procedure ShowServiceHeaderRecords()
    begin
        Rec.TestField("Table ID", Database::"Service Header");

        case Rec."Document Type" of
            Rec."document type"::Order:
                if Rec."No. of Records" = 1 then
                    Page.Run(Page::"Service Order", SOServHeader)
                else
                    Page.Run(0, SOServHeader);
            Rec."document type"::Invoice:
                if Rec."No. of Records" = 1 then
                    Page.Run(Page::"Service Invoice", SIServHeader)
                else
                    Page.Run(0, SIServHeader);
            Rec."document type"::"Credit Memo":
                if Rec."No. of Records" = 1 then
                    Page.Run(Page::"Service Credit Memo", SCMServHeader)
                else
                    Page.Run(0, SCMServHeader);
        end;
    end;

    local procedure SetPostingDate(PostingDate: Text[250])
    begin
        ApplicationManagement.MakeDateFilter(PostingDate);
        Rec.SetFilter("Posting Date", PostingDate);
        PostingDateFilter := Rec.GetFilter("Posting Date");
    end;

    local procedure SetDocNo(DocNo: Text[250])
    begin
        Rec.SetFilter("Document No.", DocNo);
        DocNoFilter := Rec.GetFilter("Document No.");
        PostingDateFilter := Rec.GetFilter("Posting Date");
    end;

    local procedure ClearSourceInfo()
    begin
        if DocExists then begin
            DocExists := false;
            Rec.DeleteAll;
            ShowEnable := false;
            SetSource(0D, '', '', 0, '');
            CurrPage.Update(false);
        end;
    end;

    local procedure MakeExtFilter(var DateFilter: Code[250]; AddDate: Date; var DocNoFilter: Code[250]; AddDocNo: Code[20])
    begin
        if DateFilter = '' then
            DateFilter := Format(AddDate)
        else
            if StrPos(DateFilter, Format(AddDate)) = 0 then
                if MaxStrLen(DateFilter) >= StrLen(DateFilter + '|' + Format(AddDate)) then
                    DateFilter := DateFilter + '|' + Format(AddDate)
                else
                    TooLongFilter;

        if DocNoFilter = '' then
            DocNoFilter := AddDocNo
        else
            if StrPos(DocNoFilter, AddDocNo) = 0 then
                if MaxStrLen(DocNoFilter) >= StrLen(DocNoFilter + '|' + AddDocNo) then
                    DocNoFilter := DocNoFilter + '|' + AddDocNo
                else
                    TooLongFilter;
    end;

    local procedure FindPush()
    begin
        if (DocNoFilter = '') and (PostingDateFilter = '') and
           (not ItemTrackingSearch) and
           ((ContactType <> 0) or (ContactNo <> '') or (ExtDocNo <> ''))
        then
            FindExtRecords
        else
            if ItemTrackingSearch and
               (DocNoFilter = '') and (PostingDateFilter = '') and
               (ContactType = 0) and (ContactNo = '') and (ExtDocNo = '')
            then
                FindTrackingRecords
            else
                FindRecords;
    end;

    local procedure TooLongFilter()
    begin
        if ContactNo = '' then
            Error(Text015);

        Error(Text016);
    end;

    local procedure FindUnpostedSalesDocs(DocType: Option; DocTableName: Text[100]; var SalesHeader: Record "Sales Header")
    begin
        if SalesHeader.ReadPermission then begin
            SalesHeader.Reset;
            SalesHeader.SetCurrentkey("Sell-to Customer No.", "External Document No.");
            SalesHeader.SetFilter("Sell-to Customer No.", ContactNo);
            SalesHeader.SetFilter("External Document No.", ExtDocNo);
            SalesHeader.SetRange("Document Type", DocType);
            InsertIntoDocEntry(Database::"Sales Header", DocType, DocTableName, SalesHeader.Count);
        end;
    end;

    local procedure FindUnpostedServDocs(DocType: Option; DocTableName: Text[100]; var ServHeader: Record "Service Header")
    begin
        if ServHeader.ReadPermission then begin
            if ExtDocNo = '' then begin
                ServHeader.Reset;
                ServHeader.SetCurrentkey("Customer No.");
                ServHeader.SetFilter("Customer No.", ContactNo);
                ServHeader.SetRange("Document Type", DocType);
                InsertIntoDocEntry(Database::"Service Header", DocType, DocTableName, ServHeader.Count);
            end;
        end;
    end;


    procedure FindTrackingRecords()
    var
        DocNoOfRecords: Integer;
    begin
        Window.Open(Text002);
        Rec.DeleteAll;
        Rec."Entry No." := 0;

        Clear(ItemTrackingNavigateMgt);
        ItemTrackingNavigateMgt.FindTrackingRecords(SerialNoFilter, LotNoFilter, '', '');

        ItemTrackingNavigateMgt.Collect(TempRecordBuffer);
        TempRecordBuffer.SetCurrentkey("Table No.", "Search Record ID");
        if TempRecordBuffer.Find('-') then
            repeat
                TempRecordBuffer.SetRange("Table No.", TempRecordBuffer."Table No.");

                DocNoOfRecords := 0;
                if TempRecordBuffer.Find('-') then
                    repeat
                        TempRecordBuffer.SetRange("Search Record ID", TempRecordBuffer."Search Record ID");
                        TempRecordBuffer.Find('+');
                        TempRecordBuffer.SetRange("Search Record ID");
                        DocNoOfRecords += 1;
                    until TempRecordBuffer.Next = 0;

                InsertIntoDocEntry(
                  TempRecordBuffer."Table No.", 0, TempRecordBuffer."Table Name", DocNoOfRecords);

                TempRecordBuffer.SetRange("Table No.");
            until TempRecordBuffer.Next = 0;

        DocExists := Rec.Find('-');

        UpdateFormAfterFindRecords;
        Window.Close;
    end;


    procedure SetTracking(SerialNo: Code[20]; LotNo: Code[20])
    begin
        NewSerialNo := SerialNo;
        NewLotNo := LotNo;
    end;


    procedure ItemTrackingSearch(): Boolean
    begin
        exit((SerialNoFilter <> '') or (LotNoFilter <> ''));
    end;


    procedure ClearTrackingInfo()
    begin
        SerialNoFilter := '';
        LotNoFilter := '';
    end;


    procedure ClearInfo()
    begin
        SetDocNo('');
        SetPostingDate('');
        ContactType := Contacttype::" ";
        ContactNo := '';
        ExtDocNo := '';
    end;

    local procedure DocNoFilterOnAfterValidate()
    begin
        ClearSourceInfo;
    end;

    local procedure PostingDateFilterOnAfterValida()
    begin
        ClearSourceInfo;
    end;

    local procedure ExtDocNoOnAfterValidate()
    begin
        ClearSourceInfo;
    end;

    local procedure ContactTypeOnAfterValidate()
    begin
        ClearSourceInfo;
    end;

    local procedure ContactNoOnAfterValidate()
    begin
        ClearSourceInfo;
    end;

    local procedure SerialNoFilterOnAfterValidate()
    begin
        ClearSourceInfo;
    end;

    local procedure LotNoFilterOnAfterValidate()
    begin
        ClearSourceInfo;
    end;


    procedure FindRecordsOnOpen()
    begin
        if (NewDocNo = '') and (NewPostingDate = 0D) and (NewSerialNo = '') and (NewLotNo = '') then begin
            Rec.DeleteAll;
            ShowEnable := false;
            PrintEnable := false;
            SetSource(0D, '', '', 0, '');
        end else
            if (NewSerialNo <> '') or (NewLotNo <> '') then begin
                SetSource(0D, '', '', 0, '');
                Rec.SetRange("Serial No. Filter", NewSerialNo);
                Rec.SetRange("Lot No. Filter", NewLotNo);
                SerialNoFilter := Rec.GetFilter("Serial No. Filter");
                LotNoFilter := Rec.GetFilter("Lot No. Filter");
                ClearInfo;
                FindTrackingRecords;
            end else begin
                Rec.SetRange("Document No.", NewDocNo);
                Rec.SetRange("Posting Date", NewPostingDate);
                DocNoFilter := Rec.GetFilter("Document No.");
                PostingDateFilter := Rec.GetFilter("Posting Date");
                ContactType := Contacttype::" ";
                ContactNo := '';
                ExtDocNo := '';
                ClearTrackingInfo;
                FindRecords;
            end;
    end;


    procedure UpdateNavigateForm(UpdateFormFrom: Boolean)
    begin
        UpdateForm := UpdateFormFrom;
    end;


    procedure ReturnDocumentEntry(var TempDocumentEntry: Record "Document Entry" temporary)
    begin
        Rec.SetRange("Table ID");  // Clear filter.
        Rec.FindSet;
        repeat
            TempDocumentEntry.Init;
            TempDocumentEntry := Rec;
            TempDocumentEntry.Insert;
        until Rec.Next = 0;
    end;

    local procedure UpdateFindByGroupsVisibility()
    begin
        DocumentVisible := false;
        BusinessContactVisible := false;
        ItemReferenceVisible := false;

        case FindBasedOn of
            Findbasedon::Document:
                DocumentVisible := true;
            Findbasedon::"Business Contact":
                BusinessContactVisible := true;
            Findbasedon::"Item Reference":
                ItemReferenceVisible := true;
        end;

        CurrPage.Update;
    end;

    local procedure FilterSelectionChanged()
    begin
        FilterSelectionChangedTxtVisible := true;
    end;

    local procedure GetCaptionText(): Text
    begin
        if Rec."Table Name" <> '' then
            exit(StrSubstNo(PageCaptionTxt, Rec."Table Name"));

        exit('');
    end;

    local procedure GetPageId(PageId: Integer): Integer
    begin
    end;

    local procedure UpdateDateRecords_gFnc()
    var
        PurchInvLine_gRec: Record "Purch. Inv. Line";
        SalesInvLine_gRec: Record "Sales Invoice Line";
        Text50000_gCtx: label 'Please select Update Date.';
        SalesCrMemoLine_lRec: Record "Sales Cr.Memo Line";
        R6650_lRec: Record "Return Shipment Header";
        R6660_lRec: Record "Return Receipt Header";
        R6651_lRec: Record "Return Shipment Line";
        R6661_lRec: Record "Return Receipt Line";
        T5744_lRec: Record "Transfer Shipment Header";
        T5745_lRec: Record "Transfer Shipment Line";
        T5746_lRec: Record "Transfer Receipt Header";
        T5747_lRec: Record "Transfer Receipt Line";
        ServiceLedgerEntry_lRec: Record "Service Ledger Entry";
        ServiceInvoiceHeader_lRec: Record "Service Invoice Header";
        ServiceInvoiceLine_lRec: Record "Service Invoice Line";
        Mod18001: Record "Detailed GST Ledger Entry";
        Mod18005: Record "GST Ledger Entry";
        ModILE_lRec: Record "Item Ledger Entry";
        ModWare_lRec: Record "Warehouse Entry";
        ModSIH_lRec: Record "Sales Invoice Header";
        ModSIL_lRec: Record "Sales Invoice Line";
        ModGLE_lRec: Record "G/L Entry";
        ModCLE: Record "Cust. Ledger Entry";
        ModDCLE_lRec: Record "Detailed Cust. Ledg. Entry";
        ModValueEntry_lRec: Record "Value Entry";
        TaxTransactionValue: Record "Tax Transaction Value";
        ModTaxTransactionValue: Record "Tax Transaction Value";
        TempTaxVar_lTxt: Text;
        ModSCML_lRec: Record "Sales Cr.Memo Line";
        ModSCMH_lRec: Record "Sales Cr.Memo Header";
        ModPurInvLine_lRec: Record "Purch. Inv. Line";
        ModPunInvHd_lRec: Record "Purch. Inv. Header";
        ModPCML_lRec: Record "Purch. Cr. Memo Line";
        ModPCMH_lRec: Record "Purch. Cr. Memo Hdr.";
        FALed_lRec: Record "FA Ledger Entry";
        ModFALed_lRec: Record "FA Ledger Entry";
        ModVLE_lRec: Record "Vendor Ledger Entry";
        ModDVLE_lRec: Record "Detailed Vendor Ledg. Entry";
    begin
        //I-I034-302003-01-NS
        if UpdateDocNo_gCod = '' then
            Error('Enter Update Document No.');

        IF UserId <> 'BCADMIN' then
            Error('Only User ID BCADMIN Allow to use this page');

        Rec.FindSet;
        repeat
            case Rec."Table ID" of
                114:
                    begin
                        SalesCrMemoHeader.Reset;
                        SalesCrMemoHeader.SetFilter("No.", DocNoFilter);
                        SalesCrMemoHeader.SetFilter("Posting Date", PostingDateFilter);
                        if SalesCrMemoHeader.FindFirst then begin

                            //IMP Notes : First Renumber the Line Table after update the Header table
                            SalesCrMemoLine_lRec.SetRange("Document No.", SalesCrMemoHeader."No.");
                            if SalesCrMemoLine_lRec.FindFirst then begin
                                repeat
                                    ModSCML_lRec.GET(SalesCrMemoLine_lRec."Document No.", SalesCrMemoLine_lRec."Line No.");
                                    ModSCML_lRec.Rename(UpdateDocNo_gCod, SalesCrMemoLine_lRec."Line No.");

                                    TaxTransactionValue.Reset();
                                    TaxTransactionValue.Setrange("Tax Record ID", SalesCrMemoLine_lRec.RecordId);
                                    IF TaxTransactionValue.FindSet() Then begin
                                        repeat
                                            ModTaxTransactionValue.GET(TaxTransactionValue.ID);
                                            ModTaxTransactionValue."Tax Record ID" := ModSCML_lRec.RecordId;
                                            TempTaxVar_lTxt := Format(ModTaxTransactionValue."Tax Record ID");
                                            ModTaxTransactionValue.Modify();
                                        until TaxTransactionValue.NEXT = 0;
                                    end;
                                until SalesCrMemoLine_lRec.Next = 0;
                            end;


                            ModSCMH_lRec.GET(SalesCrMemoHeader."No.");
                            ModSCMH_lRec.Rename(UpdateDocNo_gCod);
                            //Error('NG');
                        End;
                    end;
                122:
                    begin

                        PurchInvHeader.Reset;
                        PurchInvHeader.SetFilter("No.", DocNoFilter);
                        PurchInvHeader.SetFilter("Posting Date", PostingDateFilter);
                        if PurchInvHeader.FindFirst then begin

                            //IMP Notes : First Renumber the Line Table after update the Header table
                            PurchInvLine_gRec.SetRange("Document No.", PurchInvHeader."No.");
                            if PurchInvLine_gRec.FindFirst then begin
                                repeat
                                    ModPurInvLine_lRec.GET(PurchInvLine_gRec."Document No.", PurchInvLine_gRec."Line No.");
                                    ModPurInvLine_lRec.Rename(UpdateDocNo_gCod, PurchInvLine_gRec."Line No.");

                                    TaxTransactionValue.Reset();
                                    TaxTransactionValue.Setrange("Tax Record ID", PurchInvLine_gRec.RecordId);
                                    IF TaxTransactionValue.FindSet() Then begin
                                        repeat
                                            ModTaxTransactionValue.GET(TaxTransactionValue.ID);
                                            ModTaxTransactionValue."Tax Record ID" := ModPurInvLine_lRec.RecordId;
                                            TempTaxVar_lTxt := Format(ModTaxTransactionValue."Tax Record ID");
                                            ModTaxTransactionValue.Modify();
                                        until TaxTransactionValue.NEXT = 0;
                                    end;
                                until PurchInvLine_gRec.Next = 0;
                            end;


                            ModPunInvHd_lRec.GET(PurchInvHeader."No.");
                            ModPunInvHd_lRec.Rename(UpdateDocNo_gCod);
                            //Error('NG');
                        end;

                    end;

                6650:
                    Error('Case not define for Table Number %1', Rec."Table ID");
                // begin
                //     if R6650_lRec.ReadPermission then begin
                //         R6650_lRec.Reset;
                //         R6650_lRec.SetFilter("No.", DocNoFilter);
                //         R6650_lRec.SetFilter("Posting Date", PostingDateFilter);
                //         if R6650_lRec.FindFirst then begin
                //             R6650_lRec."Posting Date" := UpdateDocNo_gCod;
                //             R6650_lRec."Posting Date" := UpdateDocNo_gCod;
                //             R6650_lRec.Modify;

                //             R6651_lRec.Reset;
                //             R6651_lRec.SetRange("Document No.", R6650_lRec."No.");
                //             if R6651_lRec.FindFirst then begin
                //                 repeat
                //                     if R6651_lRec."Posting Date" <> 0D then
                //                         R6651_lRec."Posting Date" := UpdateDocNo_gCod;
                //                     R6651_lRec.Modify;
                //                 until R6651_lRec.Next = 0;
                //             end;
                //         end;
                //     end;
                // end;

                6660:
                    Error('Case not define for Table Number %1', Rec."Table ID");
                // begin
                //     if R6660_lRec.ReadPermission then begin
                //         R6660_lRec.Reset;
                //         R6660_lRec.SetFilter("No.", DocNoFilter);
                //         R6660_lRec.SetFilter("Posting Date", PostingDateFilter);
                //         if R6660_lRec.FindFirst then begin
                //             R6660_lRec."Posting Date" := UpdateDocNo_gCod;
                //             R6660_lRec."Posting Date" := UpdateDocNo_gCod;
                //             R6660_lRec.Modify;

                //             R6661_lRec.Reset;
                //             R6661_lRec.SetRange("Document No.", R6660_lRec."No.");
                //             if R6661_lRec.FindFirst then begin
                //                 repeat
                //                     if R6661_lRec."Posting Date" <> 0D then
                //                         R6661_lRec."Posting Date" := UpdateDocNo_gCod;
                //                     R6661_lRec.Modify;
                //                 until R6661_lRec.Next = 0;
                //             end;
                //         end;
                //     end;
                // end;

                120:
                    Error('Case not define for Table Number %1', Rec."Table ID");
                // begin
                //     if PurchRcptHeader.ReadPermission then begin
                //         PurchRcptHeader.Reset;
                //         PurchRcptHeader.SetFilter("No.", DocNoFilter);
                //         PurchRcptHeader.SetFilter("Posting Date", PostingDateFilter);
                //         if PurchRcptHeader.FindFirst then begin
                //             PurchRcptHeader."Posting Date" := UpdateDocNo_gCod;
                //             PurchRcptLine_gRec.SetRange("Document No.", PurchRcptHeader."No.");
                //             if PurchRcptLine_gRec.FindFirst then begin
                //                 repeat
                //                     if PurchRcptLine_gRec."Posting Date" <> 0D then begin
                //                         PurchRcptLine_gRec."Posting Date" := UpdateDocNo_gCod;
                //                         PurchRcptLine_gRec.Modify;
                //                     end;
                //                 until PurchRcptLine_gRec.Next = 0;
                //             end;
                //             PurchRcptHeader."Posting Date" := UpdateDocNo_gCod;
                //             PurchRcptHeader.Modify;
                //         end;
                //     end;
                // end;

                32:
                    begin
                        if ItemLedgerEntry_gRec.ReadPermission then begin
                            ItemLedgerEntry_gRec.Reset;
                            ItemLedgerEntry_gRec.SetFilter("Document No.", DocNoFilter);
                            ItemLedgerEntry_gRec.SetFilter("Posting Date", PostingDateFilter);
                            if ItemLedgerEntry_gRec.FindFirst then begin
                                repeat
                                    ModILE_lRec.GET(ItemLedgerEntry_gRec."Entry No.");
                                    ModILE_lRec."Document No." := UpdateDocNo_gCod;
                                    ModILE_lRec.Modify;
                                until ItemLedgerEntry_gRec.Next = 0;
                            end;
                        end;
                    end;
                5601:
                    begin
                        if FALed_lRec.ReadPermission then begin
                            FALed_lRec.Reset;
                            FALed_lRec.SetFilter("Document No.", DocNoFilter);
                            FALed_lRec.SetFilter("Posting Date", PostingDateFilter);
                            if FALed_lRec.FindFirst then begin
                                repeat
                                    ModFALed_lRec.GET(FALed_lRec."Entry No.");
                                    ModFALed_lRec."Document No." := UpdateDocNo_gCod;
                                    ModFALed_lRec.Modify;
                                until FALed_lRec.Next = 0;
                            end;
                        end;
                    end;
                7312:
                    begin
                        if WarehouseEntry_gRec.ReadPermission then begin
                            WarehouseEntry_gRec.Reset;
                            WarehouseEntry_gRec.SetFilter("Reference No.", DocNoFilter);
                            WarehouseEntry_gRec.SetFilter("Registering Date", PostingDateFilter);
                            if WarehouseEntry_gRec.FindSet then begin
                                repeat
                                    ModWare_lRec.GEt(WarehouseEntry_gRec."Entry No.");
                                    ModWare_lRec."Reference No." := UpdateDocNo_gCod;
                                    ModWare_lRec.Modify;
                                until WarehouseEntry_gRec.Next = 0;
                            end;
                        end;
                    end;
                112:
                    begin
                        if SalesInvHeader.ReadPermission then begin
                            SalesInvHeader.Reset;
                            SalesInvHeader.SetFilter("No.", DocNoFilter);
                            SalesInvHeader.SetFilter("Posting Date", PostingDateFilter);
                            if SalesInvHeader.FindFirst then begin

                                //IMP Notes : First Renumber the Line Table after update the Header table
                                SalesInvLine_gRec.SetRange("Document No.", SalesInvHeader."No.");
                                if SalesInvLine_gRec.FindFirst then begin
                                    repeat
                                        ModSIL_lRec.GET(SalesInvLine_gRec."Document No.", SalesInvLine_gRec."Line No.");
                                        ModSIL_lRec.Rename(UpdateDocNo_gCod, SalesInvLine_gRec."Line No.");

                                        TaxTransactionValue.Reset();
                                        TaxTransactionValue.Setrange("Tax Record ID", SalesInvLine_gRec.RecordId);
                                        IF TaxTransactionValue.FindSet() Then begin
                                            repeat
                                                ModTaxTransactionValue.GET(TaxTransactionValue.ID);
                                                ModTaxTransactionValue."Tax Record ID" := ModSIL_lRec.RecordId;
                                                TempTaxVar_lTxt := Format(ModTaxTransactionValue."Tax Record ID");
                                                ModTaxTransactionValue.Modify();
                                            until TaxTransactionValue.NEXT = 0;
                                        end;
                                    until SalesInvLine_gRec.Next = 0;
                                end;


                                ModSIH_lRec.GET(SalesInvHeader."No.");
                                ModSIH_lRec.Rename(UpdateDocNo_gCod);
                                //Error('NG');
                            end;
                        end;
                    end;

                124:

                    begin

                        PurchCrmemohdr_gRec.Reset;
                        PurchCrmemohdr_gRec.SetFilter("No.", DocNoFilter);
                        PurchCrmemohdr_gRec.SetFilter("Posting Date", PostingDateFilter);
                        if PurchCrmemohdr_gRec.FindFirst then begin

                            //IMP Notes : First Renumber the Line Table after update the Header table
                            PurchCrmemoLine_gRec.SetRange("Document No.", PurchCrmemohdr_gRec."No.");
                            if PurchCrmemoLine_gRec.FindFirst then begin
                                repeat
                                    ModPCML_lRec.GET(PurchCrmemoLine_gRec."Document No.", PurchCrmemoLine_gRec."Line No.");
                                    ModPCML_lRec.Rename(UpdateDocNo_gCod, PurchCrmemoLine_gRec."Line No.");

                                    TaxTransactionValue.Reset();
                                    TaxTransactionValue.Setrange("Tax Record ID", PurchCrmemoLine_gRec.RecordId);
                                    IF TaxTransactionValue.FindSet() Then begin
                                        repeat
                                            ModTaxTransactionValue.GET(TaxTransactionValue.ID);
                                            ModTaxTransactionValue."Tax Record ID" := ModPCML_lRec.RecordId;
                                            TempTaxVar_lTxt := Format(ModTaxTransactionValue."Tax Record ID");
                                            ModTaxTransactionValue.Modify();
                                        until TaxTransactionValue.NEXT = 0;
                                    end;
                                until PurchCrmemoLine_gRec.Next = 0;
                            end;


                            ModPCMH_lRec.GET(PurchCrmemohdr_gRec."No.");
                            ModPCMH_lRec.Rename(UpdateDocNo_gCod);
                            //Error('NG');
                        end;

                    end;

                17:
                    begin
                        if GLEntry.ReadPermission then begin
                            GLEntry.Reset;
                            GLEntry.SetFilter("Document No.", DocNoFilter);
                            GLEntry.SetFilter("Posting Date", PostingDateFilter);
                            if GLEntry.FindSet then begin
                                repeat
                                    ModGLE_lRec.GET(GLEntry."Entry No.");
                                    ModGLE_lRec."Document No." := UpdateDocNo_gCod;
                                    ModGLE_lRec.Modify;
                                until GLEntry.Next = 0;
                            end;
                        end;
                    end;


                18689:
                    Error('Case not define for Table Number %1', Rec."Table ID");
                // begin
                //     if TDSEntry.ReadPermission then begin
                //         TDSEntry.Reset;
                //         TDSEntry.SetFilter("Document No.", DocNoFilter);
                //         TDSEntry.SetFilter("Posting Date", PostingDateFilter);
                //         if TDSEntry.FindFirst then begin
                //             repeat
                //                 TDSEntry."Posting Date" := UpdateDocNo_gCod;
                //                 TDSEntry.Modify;
                //             until TDSEntry.Next = 0;
                //         end;
                //     end;
                // end;


                25:
                    begin
                        if VendLedgEntry.ReadPermission then begin
                            VendLedgEntry.Reset;
                            VendLedgEntry.SetFilter("Document No.", DocNoFilter);
                            VendLedgEntry.SetFilter("Posting Date", PostingDateFilter);
                            if VendLedgEntry.FindFirst then begin
                                repeat
                                    ModVLE_lRec.GET(VendLedgEntry."Entry No.");
                                    ModVLE_lRec."Document No." := UpdateDocNo_gCod;
                                    ModVLE_lRec.Modify;
                                until VendLedgEntry.Next = 0;
                            end;
                        end;
                    end;

                380:
                    begin
                        if DtldVendLedgEntry.ReadPermission then begin
                            DtldVendLedgEntry.Reset;
                            DtldVendLedgEntry.SetFilter("Document No.", DocNoFilter);
                            DtldVendLedgEntry.SetFilter("Posting Date", PostingDateFilter);
                            if DtldVendLedgEntry.FindFirst then begin
                                repeat
                                    ModDVLE_lRec.GET(DtldVendLedgEntry."Entry No.");
                                    ModDVLE_lRec."Document No." := UpdateDocNo_gCod;
                                    ModDVLE_lRec.Modify;
                                until DtldVendLedgEntry.Next = 0;
                            end;
                        end;
                    end;

                21:
                    begin
                        if CustLedgEntry.ReadPermission then begin
                            CustLedgEntry.Reset;
                            CustLedgEntry.SetFilter("Document No.", DocNoFilter);
                            CustLedgEntry.SetFilter("Posting Date", PostingDateFilter);
                            if CustLedgEntry.FindFirst then begin
                                repeat
                                    ModCLE.GET(CustLedgEntry."Entry No.");
                                    ModCLE."Document No." := UpdateDocNo_gCod;
                                    ModCLE.Modify;
                                until CustLedgEntry.Next = 0;
                            end;
                        end;
                    end;

                379:
                    begin
                        if DtldCustLedgEntry.ReadPermission then begin
                            DtldCustLedgEntry.Reset;
                            DtldCustLedgEntry.SetFilter("Document No.", DocNoFilter);
                            DtldCustLedgEntry.SetFilter("Posting Date", PostingDateFilter);
                            if DtldCustLedgEntry.FindFirst then begin
                                repeat
                                    ModDCLE_lRec.GET(DtldCustLedgEntry."Entry No.");
                                    ModDCLE_lRec."Document No." := UpdateDocNo_gCod;
                                    ModDCLE_lRec.Modify;
                                until DtldCustLedgEntry.Next = 0;
                            end;
                        end;
                    end;

                5802:
                    begin
                        if ValueEntry.ReadPermission then begin
                            ValueEntry.Reset;
                            ValueEntry.SetCurrentkey("Document No.");
                            ValueEntry.SetFilter("Document No.", DocNoFilter);
                            ValueEntry.SetFilter("Posting Date", PostingDateFilter);
                            if ValueEntry.FindFirst then begin
                                repeat
                                    ModValueEntry_lRec.GET(ValueEntry."Entry No.");
                                    ModValueEntry_lRec."Document No." := UpdateDocNo_gCod;
                                    ModValueEntry_lRec.Modify;
                                until ValueEntry.Next = 0;
                            end;
                        end;
                    end;

                5832:
                    Error('Case not define for Table Number %1', Rec."Table ID");
                // begin
                //     if CapacityLdrEntry_gRec.ReadPermission then begin
                //         CapacityLdrEntry_gRec.Reset;
                //         CapacityLdrEntry_gRec.SetCurrentkey("Document No.", "Posting Date");
                //         CapacityLdrEntry_gRec.SetFilter("Document No.", DocNoFilter);
                //         CapacityLdrEntry_gRec.SetFilter("Posting Date", PostingDateFilter);
                //         if CapacityLdrEntry_gRec.FindFirst then begin
                //             repeat
                //                 CapacityLdrEntry_gRec."Posting Date" := UpdateDocNo_gCod;
                //                 CapacityLdrEntry_gRec.Modify;
                //             until CapacityLdrEntry_gRec.Next = 0;
                //         end;
                //     end;
                // end;

                271:
                    Error('Case not define for Table Number %1', Rec."Table ID");
                // begin
                //     if BankAccLedgEntry.ReadPermission then begin
                //         BankAccLedgEntry.Reset;
                //         BankAccLedgEntry.SetCurrentkey("Document No.", "Posting Date");
                //         BankAccLedgEntry.SetFilter("Document No.", DocNoFilter);
                //         BankAccLedgEntry.SetFilter("Posting Date", PostingDateFilter);
                //         if BankAccLedgEntry.FindFirst then begin
                //             repeat
                //                 BankAccLedgEntry."Posting Date" := UpdateDocNo_gCod;
                //                 BankAccLedgEntry.Modify;
                //             until BankAccLedgEntry.Next = 0;
                //         end;
                //     end;
                // end;

                272:
                    Error('Case not define for Table Number %1', Rec."Table ID");
                // begin
                //     if CheckLedgEntry.ReadPermission then begin
                //         CheckLedgEntry.Reset;
                //         CheckLedgEntry.SetCurrentkey("Document No.", "Posting Date");
                //         CheckLedgEntry.SetFilter("Document No.", DocNoFilter);
                //         CheckLedgEntry.SetFilter("Posting Date", PostingDateFilter);
                //         if CheckLedgEntry.FindFirst then begin
                //             repeat
                //                 CheckLedgEntry."Posting Date" := UpdateDocNo_gCod;
                //                 CheckLedgEntry.Modify;
                //             until CheckLedgEntry.Next = 0;
                //         end;
                //     end;
                // end;

                18005:
                    begin
                        if GSTLedgerEntry.ReadPermission then begin
                            GSTLedgerEntry.Reset;
                            GSTLedgerEntry.SetCurrentkey("Document No.", "Posting Date");
                            GSTLedgerEntry.SetFilter("Document No.", DocNoFilter);
                            if GSTLedgerEntry.FindFirst then begin
                                repeat
                                    Mod18005.Get(GSTLedgerEntry."Entry No.");
                                    Mod18005."Document No." := UpdateDocNo_gCod;
                                    Mod18005.Modify;
                                until GSTLedgerEntry.Next = 0;
                            end;
                        end;
                    end;

                18001:
                    begin
                        if DetailedGSTLedgerEntry.ReadPermission then begin
                            DetailedGSTLedgerEntry.Reset;
                            DetailedGSTLedgerEntry.SetCurrentkey("Document No.", "Posting Date");
                            DetailedGSTLedgerEntry.SetFilter("Document No.", DocNoFilter);
                            if DetailedGSTLedgerEntry.FindFirst then begin
                                repeat
                                    Mod18001.Get(DetailedGSTLedgerEntry."Entry No.");
                                    Mod18001."Document No." := UpdateDocNo_gCod;
                                    Mod18001.Modify;
                                until DetailedGSTLedgerEntry.Next = 0;
                            end;
                        end;
                    end;

                910:
                    Error('Case not define for Table Number %1', Rec."Table ID");
                // begin
                //     if PostedAssemblyHeader.ReadPermission then begin
                //         PostedAssemblyHeader.Reset;
                //         PostedAssemblyHeader.SetFilter("No.", DocNoFilter);
                //         PostedAssemblyHeader.SetFilter("Posting Date", PostingDateFilter);
                //         if PostedAssemblyHeader.FindFirst then begin
                //             PostedAssemblyHeader."Posting Date" := UpdateDocNo_gCod;
                //             PostedAssemblyHeader.Modify;
                //         end;
                //     end;
                // end;

                5744:
                    Error('Case not define for Table Number %1', Rec."Table ID");
                // begin
                //     if T5744_lRec.ReadPermission then begin
                //         T5744_lRec.Reset;
                //         T5744_lRec.SetFilter("No.", DocNoFilter);
                //         T5744_lRec.SetFilter("Posting Date", PostingDateFilter);
                //         if T5744_lRec.FindFirst then begin
                //             T5744_lRec."Posting Date" := UpdateDocNo_gCod;
                //             T5745_lRec.SetRange("Document No.", T5744_lRec."No.");
                //             if T5745_lRec.FindFirst then begin
                //                 repeat
                //                 //            IF T5745_lRec."Posting Date" <> 0D THEN BEGIN
                //                 //            T5745_lRec."Posting Date" := UpdateDate_gDate;
                //                 //          T5745_lRec.MODIFY;
                //                 //END;
                //                 until T5745_lRec.Next = 0;
                //             end;
                //             T5744_lRec."Posting Date" := UpdateDocNo_gCod;
                //             T5744_lRec.Modify;
                //         end;
                //     end;
                // end;

                5746:
                    Error('Case not define for Table Number %1', Rec."Table ID");
                // begin
                //     if T5746_lRec.ReadPermission then begin
                //         T5746_lRec.Reset;
                //         T5746_lRec.SetFilter("No.", DocNoFilter);
                //         T5746_lRec.SetFilter("Posting Date", PostingDateFilter);
                //         if T5746_lRec.FindFirst then begin
                //             T5746_lRec."Posting Date" := UpdateDocNo_gCod;
                //             T5747_lRec.SetRange("Document No.", T5746_lRec."No.");
                //             if T5747_lRec.FindFirst then begin
                //                 repeat
                //                 //IF T5747_lRec."Posting Date" <> 0D THEN BEGIN
                //                 //T5747_lRec."Posting Date" := UpdateDate_gDate;
                //                 //T5747_lRec.MODIFY;
                //                 //END;
                //                 until T5747_lRec.Next = 0;
                //             end;
                //             T5746_lRec."Posting Date" := UpdateDocNo_gCod;
                //             T5746_lRec.Modify;
                //         end;
                //     end;
                // end;

                5907:
                    Error('Case not define for Table Number %1', Rec."Table ID");
                // begin
                //     if ServiceLedgerEntry_lRec.ReadPermission then begin
                //         ServiceLedgerEntry_lRec.Reset;
                //         ServiceLedgerEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
                //         ServiceLedgerEntry_lRec.SetFilter("Document No.", DocNoFilter);
                //         if ServiceLedgerEntry_lRec.FindFirst then begin
                //             repeat
                //                 if ServiceLedgerEntry_lRec."Posting Date" <> UpdateDocNo_gCod then begin
                //                     ServiceLedgerEntry_lRec."Posting Date" := UpdateDocNo_gCod;
                //                     ServiceLedgerEntry_lRec.Modify;
                //                 end;
                //             until ServiceLedgerEntry_lRec.Next = 0;
                //         end;
                //     end;
                // end;

                5992:
                    Error('Case not define for Table Number %1', Rec."Table ID");
                // begin
                //     if ServiceInvoiceHeader_lRec.ReadPermission then begin
                //         ServiceInvoiceHeader_lRec.Reset;
                //         ServiceInvoiceHeader_lRec.SetFilter("No.", DocNoFilter);
                //         ServiceInvoiceHeader_lRec.SetFilter("Posting Date", PostingDateFilter);
                //         if ServiceInvoiceHeader_lRec.FindFirst then begin
                //             ServiceInvoiceHeader_lRec."Posting Date" := UpdateDocNo_gCod;
                //             ServiceInvoiceLine_lRec.SetRange("Document No.", ServiceInvoiceHeader_lRec."No.");
                //             if ServiceInvoiceLine_lRec.FindFirst then begin
                //                 repeat
                //                     if ServiceInvoiceLine_lRec."Posting Date" <> 0D then begin
                //                         ServiceInvoiceLine_lRec."Posting Date" := UpdateDocNo_gCod;
                //                         ServiceInvoiceLine_lRec.Modify;
                //                     end;
                //                 until ServiceInvoiceLine_lRec.Next = 0;
                //                 ServiceInvoiceHeader_lRec."Posting Date" := UpdateDocNo_gCod;
                //                 ServiceInvoiceHeader_lRec.Modify;
                //             end;
                //         end;
                //     end;
                // end;

                18810:
                    Error('Case not define for Table Number %1', Rec."Table ID");
            // begin
            //     if TCSEntry.ReadPermission then begin
            //         TCSEntry.Reset;
            //         TCSEntry.SetFilter("Document No.", DocNoFilter);
            //         if TCSEntry.FindFirst then begin
            //             repeat
            //                 if TCSEntry."Posting Date" <> UpdateDocNo_gCod then begin
            //                     TCSEntry."Posting Date" := UpdateDocNo_gCod;
            //                     TCSEntry.Modify;
            //                 end;
            //             until TCSEntry.Next = 0;
            //         end;
            //     end;
            // end;

            end;
        until Rec.Next = 0;
        //I-I034-302003-01-NE
    end;
}

