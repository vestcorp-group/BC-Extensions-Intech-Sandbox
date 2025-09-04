Page 74986 "Update Dimension Navigate"
{
    Caption = 'Navigate Dimension Update';
    DataCaptionExpression = GetCaptionText;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Document;
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
                  TableData "Value Entry" = rm,
                  TableData "Capacity Ledger Entry" = rm,
                  TableData "Return Shipment Header" = rm,
                  TableData "Return Shipment Line" = rm,
                  TableData "Return Receipt Header" = rm,
                  TableData "Return Receipt Line" = rm,
                  TableData "Warehouse Entry" = rm,
                  TableData "TDS Entry" = rm;
    PromotedActionCategories = 'New,Process,Report,Find By';
    SaveValues = false;
    SourceTable = "Document Entry";
    SourceTableTemporary = true;
    ApplicationArea = All;
    UsageCategory = Tasks;


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
                    Style = Unfavorable;
                    StyleExpr = true;

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
                    Style = Unfavorable;
                    StyleExpr = true;

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
            }
            group("New Dimension")
            {
                field(NewShortcutDimension1Code; NewShortcutDimension1Code_gCod)
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,1';
                    Style = Strong;
                    StyleExpr = true;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        DimensionValue_lRec: Record "Dimension Value";
                    begin
                        DimensionValue_lRec.Reset;
                        DimensionValue_lRec.FilterGroup(2);
                        DimensionValue_lRec.SetRange("Dimension Code", GenLedSetup_gRec."Shortcut Dimension 1 Code");
                        DimensionValue_lRec.FilterGroup(0);
                        if Page.RunModal(0, DimensionValue_lRec) = Action::LookupOK then
                            NewShortcutDimension1Code_gCod := DimensionValue_lRec.Code
                    end;

                    trigger OnValidate()
                    begin
                        if NewShortcutDimension1Code_gCod <> '' then
                            Error('Select the value from lookup');
                    end;
                }
                field(NewShortcutDimension2Code; NewShortcutDimension2Code_gCod)
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,2';
                    Style = Strong;
                    StyleExpr = true;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        DimensionValue_lRec: Record "Dimension Value";
                    begin
                        DimensionValue_lRec.Reset;
                        DimensionValue_lRec.FilterGroup(2);
                        DimensionValue_lRec.SetRange("Dimension Code", GenLedSetup_gRec."Shortcut Dimension 2 Code");
                        DimensionValue_lRec.FilterGroup(0);
                        if Page.RunModal(0, DimensionValue_lRec) = Action::LookupOK then
                            NewShortcutDimension2Code_gCod := DimensionValue_lRec.Code
                    end;

                    trigger OnValidate()
                    begin
                        if NewShortcutDimension1Code_gCod <> '' then
                            Error('Select the value from lookup');
                    end;
                }
                field(NewShortcutDimension3Code; NewShortcutDimension3Code_gCod)
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,3';
                    Style = Strong;
                    StyleExpr = true;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        DimensionValue_lRec: Record "Dimension Value";
                    begin
                        DimensionValue_lRec.Reset;
                        DimensionValue_lRec.FilterGroup(2);
                        DimensionValue_lRec.SetRange("Dimension Code", GenLedSetup_gRec."Shortcut Dimension 3 Code");
                        DimensionValue_lRec.FilterGroup(0);
                        if Page.RunModal(0, DimensionValue_lRec) = Action::LookupOK then
                            NewShortcutDimension3Code_gCod := DimensionValue_lRec.Code
                    end;

                    trigger OnValidate()
                    begin
                        if NewShortcutDimension1Code_gCod <> '' then
                            Error('Select the value from lookup');
                    end;
                }
                field(NewShortcutDimension4Code; NewShortcutDimension4Code_gCod)
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,4';
                    Style = Strong;
                    StyleExpr = true;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        DimensionValue_lRec: Record "Dimension Value";
                    begin
                        DimensionValue_lRec.Reset;
                        DimensionValue_lRec.FilterGroup(2);
                        DimensionValue_lRec.SetRange("Dimension Code", GenLedSetup_gRec."Shortcut Dimension 4 Code");
                        DimensionValue_lRec.FilterGroup(0);
                        if Page.RunModal(0, DimensionValue_lRec) = Action::LookupOK then
                            NewShortcutDimension4Code_gCod := DimensionValue_lRec.Code
                    end;

                    trigger OnValidate()
                    begin
                        if NewShortcutDimension1Code_gCod <> '' then
                            Error('Select the value from lookup');
                    end;
                }
                field(NewShortcutDimension5Code; NewShortcutDimension5Code_gCod)
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,5';
                    Style = Strong;
                    StyleExpr = true;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        DimensionValue_lRec: Record "Dimension Value";
                    begin
                        DimensionValue_lRec.Reset;
                        DimensionValue_lRec.FilterGroup(2);
                        DimensionValue_lRec.SetRange("Dimension Code", GenLedSetup_gRec."Shortcut Dimension 5 Code");
                        DimensionValue_lRec.FilterGroup(0);
                        if Page.RunModal(0, DimensionValue_lRec) = Action::LookupOK then
                            NewShortcutDimension5Code_gCod := DimensionValue_lRec.Code
                    end;

                    trigger OnValidate()
                    begin
                        if NewShortcutDimension1Code_gCod <> '' then
                            Error('Select the value from lookup');
                    end;
                }
                field(NewShortcutDimension6Code; NewShortcutDimension6Code_gCod)
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,6';
                    Style = Strong;
                    StyleExpr = true;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        DimensionValue_lRec: Record "Dimension Value";
                    begin
                        DimensionValue_lRec.Reset;
                        DimensionValue_lRec.FilterGroup(2);
                        DimensionValue_lRec.SetRange("Dimension Code", GenLedSetup_gRec."Shortcut Dimension 6 Code");
                        DimensionValue_lRec.FilterGroup(0);
                        if Page.RunModal(0, DimensionValue_lRec) = Action::LookupOK then
                            NewShortcutDimension6Code_gCod := DimensionValue_lRec.Code
                    end;

                    trigger OnValidate()
                    begin
                        if NewShortcutDimension1Code_gCod <> '' then
                            Error('Select the value from lookup');
                    end;
                }
                field(NewShortcutDimension7Code; NewShortcutDimension7Code_gCod)
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,7';
                    Style = Strong;
                    StyleExpr = true;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        DimensionValue_lRec: Record "Dimension Value";
                    begin
                        DimensionValue_lRec.Reset;
                        DimensionValue_lRec.FilterGroup(2);
                        DimensionValue_lRec.SetRange("Dimension Code", GenLedSetup_gRec."Shortcut Dimension 7 Code");
                        DimensionValue_lRec.FilterGroup(0);
                        if Page.RunModal(0, DimensionValue_lRec) = Action::LookupOK then
                            NewShortcutDimension7Code_gCod := DimensionValue_lRec.Code
                    end;

                    trigger OnValidate()
                    begin
                        if NewShortcutDimension1Code_gCod <> '' then
                            Error('Select the value from lookup');
                    end;
                }
                field(NewShortcutDimension8Code; NewShortcutDimension8Code_gCod)
                {
                    ApplicationArea = Basic;
                    CaptionClass = '1,2,8';
                    Style = Strong;
                    StyleExpr = true;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        DimensionValue_lRec: Record "Dimension Value";
                    begin
                        DimensionValue_lRec.Reset;
                        DimensionValue_lRec.FilterGroup(2);
                        DimensionValue_lRec.SetRange("Dimension Code", GenLedSetup_gRec."Shortcut Dimension 8 Code");
                        DimensionValue_lRec.FilterGroup(0);
                        if Page.RunModal(0, DimensionValue_lRec) = Action::LookupOK then
                            NewShortcutDimension8Code_gCod := DimensionValue_lRec.Code
                    end;

                    trigger OnValidate()
                    begin
                        if NewShortcutDimension1Code_gCod <> '' then
                            Error('Select the value from lookup');
                    end;
                }
            }
            group(Notification)
            {
                Caption = 'Notification';
                InstructionalText = 'The filter has been changed. Choose Find to update the list of related entries.';
                Visible = FilterSelectionChangedTxtVisible;
            }
            repeater(Control578787)
            {
                Editable = false;
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                    Visible = false;
                }
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = Basic;
                    Style = Favorable;
                    StyleExpr = true;
                    Visible = false;
                }
                field("Table Name"; Rec."Table Name")
                {
                    ApplicationArea = Basic;
                    Caption = 'Related Entries';
                    Style = Favorable;
                    StyleExpr = true;
                }
                field("No. of Records"; Rec."No. of Records")
                {
                    ApplicationArea = Basic;
                    Caption = 'No. of Entries';
                    DrillDown = true;
                    Style = Favorable;
                    StyleExpr = true;

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
                field(SourceType; SourceType)
                {
                    ApplicationArea = Basic;
                    Caption = 'Source Type';
                    Editable = false;
                    Enabled = SourceTypeEnable;
                }
                field(SourceNo; SourceNo)
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
                action("Update Dimension")
                {
                    ApplicationArea = Basic;
                    Caption = 'Update Dimension';
                    Image = Account;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        PD_lDte: Date;
                    begin
                        Evaluate(PD_lDte, PostingDateFilter);
                        DocNoDateWiseDimUpd_gFnc(DocNoFilter, PD_lDte);
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
        GenLedSetup_gRec.Get;
    end;

    trigger OnOpenPage()
    begin
        UserSetup_lRec.Get(UserId);//T12883-N

        IF (UserId <> 'BCADMIN') then
            if (UserSetup_lRec."Allow to Update Dimension" = false) then//T12883-N
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
        Text0675676: label 'There are no posted records with this document number.';
        Text045789: label 'There are no posted records with this combination of document number and posting date.';
        Text015: label 'The search results in too many external documents. Please specify a business contact no.';
        Text06766: label 'The search results in too many external documents. Please use Navigate from the relevant ledger entries.';
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
        UserSetup_lRec: Record "User Setup";//T12883-N
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
        NewShortcutDimension1Code_gCod: Code[20];
        NewShortcutDimension2Code_gCod: Code[20];
        NewShortcutDimension3Code_gCod: Code[20];
        NewShortcutDimension4Code_gCod: Code[20];
        NewShortcutDimension5Code_gCod: Code[20];
        NewShortcutDimension6Code_gCod: Code[20];
        NewShortcutDimension7Code_gCod: Code[20];
        NewShortcutDimension8Code_gCod: Code[20];
        GenLedSetup_gRec: Record "General Ledger Setup";
        ExistingDimSetID_gInt: Integer;
        Window_gDlg: Dialog;


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
                Message(Text0675676)
            else
                Message(Text045789);

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
            DocNoFilter := Rec.GetFilter("Document No.");
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
            else begin
                ExistingDimSetID_gInt := 0;
                FindRecords;
                FillDim_gFnc;  //NG-N
            end;
    end;

    local procedure TooLongFilter()
    begin
        if ContactNo = '' then
            Error(Text015);

        Error(Text06766);
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


    procedure FillDim_gFnc()
    var
        DimSetEntry_lRec: Record "Dimension Set Entry";
    begin
        NewShortcutDimension1Code_gCod := '';
        NewShortcutDimension2Code_gCod := '';
        NewShortcutDimension3Code_gCod := '';
        NewShortcutDimension4Code_gCod := '';
        NewShortcutDimension5Code_gCod := '';
        NewShortcutDimension6Code_gCod := '';
        NewShortcutDimension7Code_gCod := '';
        NewShortcutDimension8Code_gCod := '';

        if GLEntry.FindFirst then begin
            DimSetEntry_lRec.Reset;
            DimSetEntry_lRec.SetRange("Dimension Set ID", GLEntry."Dimension Set ID");
            if DimSetEntry_lRec.FindSet then begin
                repeat
                    if DimSetEntry_lRec."Dimension Code" = GenLedSetup_gRec."Global Dimension 1 Code" then
                        NewShortcutDimension1Code_gCod := DimSetEntry_lRec."Dimension Value Code";

                    if DimSetEntry_lRec."Dimension Code" = GenLedSetup_gRec."Global Dimension 2 Code" then
                        NewShortcutDimension2Code_gCod := DimSetEntry_lRec."Dimension Value Code";

                    if DimSetEntry_lRec."Dimension Code" = GenLedSetup_gRec."Shortcut Dimension 3 Code" then
                        NewShortcutDimension3Code_gCod := DimSetEntry_lRec."Dimension Value Code";

                    if DimSetEntry_lRec."Dimension Code" = GenLedSetup_gRec."Shortcut Dimension 4 Code" then
                        NewShortcutDimension4Code_gCod := DimSetEntry_lRec."Dimension Value Code";

                    if DimSetEntry_lRec."Dimension Code" = GenLedSetup_gRec."Shortcut Dimension 5 Code" then
                        NewShortcutDimension5Code_gCod := DimSetEntry_lRec."Dimension Value Code";

                    if DimSetEntry_lRec."Dimension Code" = GenLedSetup_gRec."Shortcut Dimension 6 Code" then
                        NewShortcutDimension6Code_gCod := DimSetEntry_lRec."Dimension Value Code";

                    if DimSetEntry_lRec."Dimension Code" = GenLedSetup_gRec."Shortcut Dimension 7 Code" then
                        NewShortcutDimension7Code_gCod := DimSetEntry_lRec."Dimension Value Code";

                    if DimSetEntry_lRec."Dimension Code" = GenLedSetup_gRec."Shortcut Dimension 8 Code" then
                        NewShortcutDimension8Code_gCod := DimSetEntry_lRec."Dimension Value Code";

                until DimSetEntry_lRec.Next = 0;
            end;
        end;
    end;


    procedure DocNoDateWiseDimUpd_gFnc(DocNo_iCod: Code[20]; PostingDate_iDte: Date)
    var
        CustLedgerEntry_lRec: Record "Cust. Ledger Entry";
        DCLE_lRec: Record "Detailed Cust. Ledg. Entry";
        VendLedEntry_lRec: Record "Vendor Ledger Entry";
        DVLE_lRec: Record "Detailed Vendor Ledg. Entry";
        GLEntry_lRec: Record "G/L Entry";
        VATEntry_lRec: Record "VAT Entry";
        TDSEntry_lRec: Record "TDS Entry";
        TCSEntry_lRec: Record "TCS Entry";
        ReminderEntry_lRec: Record "Reminder/Fin. Charge Entry";
        ValueEntry_lRec: Record "Value Entry";
        ILE_lRec: Record "Item Ledger Entry";
        BankActLedEnty_lRec: Record "Bank Account Ledger Entry";
        ChkLedEntry_lRec: Record "Check Ledger Entry";
        FALedEntry_lRec: Record "FA Ledger Entry";
        MaintenanceLedgEntry_lRec: Record "Maintenance Ledger Entry";
        CapacityLedgEntry_lRec: Record "Capacity Ledger Entry";
        SalesShptHeader_lRec: Record "Sales Shipment Header";
        SalesInvHeader_lRec: Record "Sales Invoice Header";
        ReturnRcptHeader_lRec: Record "Return Receipt Header";
        SalesCrMemoHeader_lRec: Record "Sales Cr.Memo Header";
        ServShptHeader_lRec: Record "Service Shipment Header";
        ServInvHeader_lRec: Record "Service Invoice Header";
        ServCrMemoHeader_lRec: Record "Service Cr.Memo Header";
        IssuedReminderHeader_lRec: Record "Issued Reminder Header";
        IssuedFinChrgMemoHeader_lRec: Record "Issued Fin. Charge Memo Header";
        PurchRcptHeader_lRec: Record "Purch. Rcpt. Header";
        PurchInvHeader_lRec: Record "Purch. Inv. Header";
        ReturnShptHeader_lRec: Record "Return Shipment Header";
        PurchCrMemoHeader_lRec: Record "Purch. Cr. Memo Hdr.";
        ProductionOrderHeader_lRec: Record "Production Order";
        PostedAssemblyHeader_lRec: Record "Posted Assembly Header";
        TransShptHeader_lRec: Record "Transfer Shipment Header";
        TransRcptHeader_lRec: Record "Transfer Receipt Header";
        SalesShptLine_lRec: Record "Sales Shipment Line";
        SalesInvLine_lRec: Record "Sales Invoice Line";
        ReturnRcptLine_lRec: Record "Return Receipt Line";
        SalesCrMemoLine_lRec: Record "Sales Cr.Memo Line";
        ServShptLine_lRec: Record "Service Shipment Line";
        ServInvLine_lRec: Record "Service Invoice Line";
        ServCrMemoLine_lRec: Record "Service Cr.Memo Line";
        PurchRcptLine_lRec: Record "Purch. Rcpt. Line";
        PurchInvLine_lRec: Record "Purch. Inv. Line";
        ReturnShptLine_lRec: Record "Return Shipment Line";
        PurchCrMemoLine_lRec: Record "Purch. Cr. Memo Line";
        ProductionOrderLine_lRec: Record "Prod. Order Line";
        PostedAssemblyLine_lRec: Record "Posted Assembly Line";
        TransShptLine_lRec: Record "Transfer Shipment Line";
        TransRcptLine_lRec: Record "Transfer Receipt Line";
        JobLedgEntry_lRec: Record "Job Ledger Entry";
        JobWIPEntry_lRec: Record "Job WIP Entry";
        JobWIPGLEntry_lRec: Record "Job WIP G/L Entry";
        ServLedgerEntry_lRec: Record "Service Ledger Entry";
        WarrantyLedgerEntry_lRec: Record "Warranty Ledger Entry";
    begin
        if not Confirm('Do you want to update dimension?', false) then
            exit;

        if DocNo_iCod = '' then
            Error('Document No. cannot be blank');

        if PostingDate_iDte = 0D then
            Error('Posting Date cannot be blank');

        Window_gDlg.Open('Updating Data....');

        //Update Dimension Customer Led Entry
        CustLedgerEntry_lRec.Reset;
        CustLedgerEntry_lRec.SetRange("Document No.", DocNo_iCod);
        CustLedgerEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        if CustLedgerEntry_lRec.FindSet() then begin
            repeat
                UpdDim_lFnc(CustLedgerEntry_lRec."Dimension Set ID", CustLedgerEntry_lRec."Global Dimension 1 Code", CustLedgerEntry_lRec."Global Dimension 2 Code");
                CustLedgerEntry_lRec.Modify;

                DCLE_lRec.Reset;
                DCLE_lRec.SetRange("Cust. Ledger Entry No.", CustLedgerEntry_lRec."Entry No.");
                DCLE_lRec.ModifyAll("Initial Entry Global Dim. 1", CustLedgerEntry_lRec."Global Dimension 1 Code");
                DCLE_lRec.ModifyAll("Initial Entry Global Dim. 2", CustLedgerEntry_lRec."Global Dimension 2 Code");
            until CustLedgerEntry_lRec.Next = 0;
        end;

        //Update Dimension Vendor Led Entry
        VendLedEntry_lRec.Reset;
        VendLedEntry_lRec.SetRange("Document No.", DocNo_iCod);
        VendLedEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        if VendLedEntry_lRec.FindSet() then begin
            repeat
                UpdDim_lFnc(VendLedEntry_lRec."Dimension Set ID", VendLedEntry_lRec."Global Dimension 1 Code", VendLedEntry_lRec."Global Dimension 2 Code");
                VendLedEntry_lRec.Modify;

                DVLE_lRec.Reset;
                DVLE_lRec.SetRange("Vendor Ledger Entry No.", VendLedEntry_lRec."Entry No.");
                DVLE_lRec.ModifyAll("Initial Entry Global Dim. 1", VendLedEntry_lRec."Global Dimension 1 Code");
                DVLE_lRec.ModifyAll("Initial Entry Global Dim. 2", VendLedEntry_lRec."Global Dimension 2 Code");
            until VendLedEntry_lRec.Next = 0;
        end;

        //Update Dimension G/L Entry
        GLEntry_lRec.Reset;
        GLEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
        GLEntry_lRec.SetRange("Document No.", DocNo_iCod);
        GLEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        if GLEntry_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(GLEntry_lRec."Dimension Set ID", GLEntry_lRec."Global Dimension 1 Code", GLEntry_lRec."Global Dimension 2 Code");
                GLEntry_lRec.Modify;
            until GLEntry_lRec.Next = 0;
        end;


        // //Update Dimension TDS Entry
        // TDSEntry_lRec.Reset;
        // TDSEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
        // TDSEntry_lRec.SetRange("Document No.", DocNo_iCod);
        // TDSEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        // if TDSEntry_lRec.FindSet then begin
        //     repeat
        //         UpdDim_lFnc(TDSEntry_lRec."Dimension Set ID", TDSEntry_lRec."Global Dimension 1 Code", TDSEntry_lRec."Global Dimension 2 Code");
        //         TDSEntry_lRec.Modify;
        //     until TDSEntry_lRec.Next = 0;
        // end;

        //Update Dimension TCS Entry
        // TCSEntry_lRec.Reset;
        // TCSEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
        // TCSEntry_lRec.SetRange("Document No.", DocNo_iCod);
        // TCSEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        // if TCSEntry_lRec.FindSet then begin
        //     repeat
        //         UpdDim_lFnc(TCSEntry_lRec."Dimension Set ID", TCSEntry_lRec."Global Dimension 1 Code", TCSEntry_lRec."Global Dimension 2 Code");
        //         TCSEntry_lRec.Modify;
        //     until TCSEntry_lRec.Next = 0;
        // end;

        //Job Ledger Entry
        JobLedgEntry_lRec.Reset;
        JobLedgEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
        JobLedgEntry_lRec.SetRange("Document No.", DocNo_iCod);
        JobLedgEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        if JobLedgEntry_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(JobLedgEntry_lRec."Dimension Set ID", JobLedgEntry_lRec."Global Dimension 1 Code", JobLedgEntry_lRec."Global Dimension 2 Code");
                JobLedgEntry_lRec.Modify;
            until JobLedgEntry_lRec.Next = 0;
        end;

        //Job WIP Entry
        JobWIPEntry_lRec.Reset;
        JobWIPEntry_lRec.SetRange("Document No.", DocNo_iCod);
        JobWIPEntry_lRec.SetRange("WIP Posting Date", PostingDate_iDte);
        if JobWIPEntry_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(JobWIPEntry_lRec."Dimension Set ID", JobWIPEntry_lRec."Global Dimension 1 Code", JobWIPEntry_lRec."Global Dimension 2 Code");
                JobWIPEntry_lRec.Modify;
            until JobWIPEntry_lRec.Next = 0;
        end;

        //Job WIP GL Entry
        JobWIPGLEntry_lRec.Reset;
        JobWIPGLEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
        JobWIPGLEntry_lRec.SetRange("Document No.", DocNo_iCod);
        JobWIPGLEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        if JobWIPGLEntry_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(JobWIPGLEntry_lRec."Dimension Set ID", JobWIPGLEntry_lRec."Global Dimension 1 Code", JobWIPGLEntry_lRec."Global Dimension 2 Code");
                JobWIPGLEntry_lRec.Modify;
            until JobWIPGLEntry_lRec.Next = 0;
        end;


        //Update ILE
        ILE_lRec.Reset;
        ILE_lRec.SetCurrentkey("Document No.", "Posting Date");
        ILE_lRec.SetRange("Document No.", DocNo_iCod);
        ILE_lRec.SetRange("Posting Date", PostingDate_iDte);
        if ILE_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(ILE_lRec."Dimension Set ID", ILE_lRec."Global Dimension 1 Code", ILE_lRec."Global Dimension 2 Code");
                ILE_lRec.Modify;
            until ILE_lRec.Next = 0;
        end;

        //Update Dimension Value Entry
        ValueEntry_lRec.Reset;
        ValueEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
        ValueEntry_lRec.SetRange("Document No.", DocNo_iCod);
        ValueEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        if ValueEntry_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(ValueEntry_lRec."Dimension Set ID", ValueEntry_lRec."Global Dimension 1 Code", ValueEntry_lRec."Global Dimension 2 Code");
                ValueEntry_lRec.Modify;
            until ValueEntry_lRec.Next = 0;
        end;

        //Update Dimension Bank Act Led Entry
        BankActLedEnty_lRec.Reset;
        BankActLedEnty_lRec.SetCurrentkey("Document No.", "Posting Date");
        BankActLedEnty_lRec.SetRange("Document No.", DocNo_iCod);
        BankActLedEnty_lRec.SetRange("Posting Date", PostingDate_iDte);
        if BankActLedEnty_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(BankActLedEnty_lRec."Dimension Set ID", BankActLedEnty_lRec."Global Dimension 1 Code", BankActLedEnty_lRec."Global Dimension 2 Code");
                BankActLedEnty_lRec.Modify;
            until BankActLedEnty_lRec.Next = 0;
        end;

        //Update Dimension FA Led Entry
        FALedEntry_lRec.Reset;
        FALedEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
        FALedEntry_lRec.SetRange("Document No.", DocNo_iCod);
        FALedEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        if FALedEntry_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(FALedEntry_lRec."Dimension Set ID", FALedEntry_lRec."Global Dimension 1 Code", FALedEntry_lRec."Global Dimension 2 Code");
                FALedEntry_lRec.Modify;
            until FALedEntry_lRec.Next = 0;
        end;

        //Update Dimension Maintenance Ledg Entry Entry
        MaintenanceLedgEntry_lRec.Reset;
        MaintenanceLedgEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
        MaintenanceLedgEntry_lRec.SetRange("Document No.", DocNo_iCod);
        MaintenanceLedgEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        if MaintenanceLedgEntry_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(MaintenanceLedgEntry_lRec."Dimension Set ID", MaintenanceLedgEntry_lRec."Global Dimension 1 Code", MaintenanceLedgEntry_lRec."Global Dimension 2 Code");
                MaintenanceLedgEntry_lRec.Modify;
            until MaintenanceLedgEntry_lRec.Next = 0;
        end;

        //Update Dimension Cap Ledg Entry Entry
        CapacityLedgEntry_lRec.Reset;
        CapacityLedgEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
        CapacityLedgEntry_lRec.SetRange("Document No.", DocNo_iCod);
        CapacityLedgEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        if CapacityLedgEntry_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(CapacityLedgEntry_lRec."Dimension Set ID", CapacityLedgEntry_lRec."Global Dimension 1 Code", CapacityLedgEntry_lRec."Global Dimension 2 Code");
                CapacityLedgEntry_lRec.Modify;
            until CapacityLedgEntry_lRec.Next = 0;
        end;


        //Update Dimension Sales Shipment Header
        SalesShptHeader_lRec.Reset;
        SalesShptHeader_lRec.SetCurrentkey("No.", "Posting Date");
        SalesShptHeader_lRec.SetRange("No.", DocNo_iCod);
        SalesShptHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if SalesShptHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(SalesShptHeader_lRec."Dimension Set ID", SalesShptHeader_lRec."Shortcut Dimension 1 Code", SalesShptHeader_lRec."Shortcut Dimension 2 Code");
                SalesShptHeader_lRec.Modify;
                SalesShptLine_lRec.SetRange("Document No.", SalesShptHeader_lRec."No.");
                if SalesShptLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(SalesShptLine_lRec."Dimension Set ID", SalesShptLine_lRec."Shortcut Dimension 1 Code", SalesShptLine_lRec."Shortcut Dimension 2 Code");
                        SalesShptLine_lRec.Modify;
                    until SalesShptLine_lRec.Next = 0;
                end;
            until SalesShptHeader_lRec.Next = 0;
        end;

        //Update Dimension Sales Invoice Header
        SalesInvHeader_lRec.Reset;
        SalesInvHeader_lRec.SetCurrentkey("No.", "Posting Date");
        SalesInvHeader_lRec.SetRange("No.", DocNo_iCod);
        SalesInvHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if SalesInvHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(SalesInvHeader_lRec."Dimension Set ID", SalesInvHeader_lRec."Shortcut Dimension 1 Code", SalesInvHeader_lRec."Shortcut Dimension 2 Code");
                SalesInvHeader_lRec.Modify;
                SalesInvLine_lRec.SetRange("Document No.", SalesInvHeader_lRec."No.");
                if SalesInvLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(SalesInvLine_lRec."Dimension Set ID", SalesInvLine_lRec."Shortcut Dimension 1 Code", SalesInvLine_lRec."Shortcut Dimension 2 Code");
                        SalesInvLine_lRec.Modify;
                    until SalesInvLine_lRec.Next = 0;
                end;
            until SalesInvHeader_lRec.Next = 0;
        end;

        //Update Dimension Return Receipt Header
        ReturnRcptHeader_lRec.Reset;
        ReturnRcptHeader_lRec.SetCurrentkey("No.", "Posting Date");
        ReturnRcptHeader_lRec.SetRange("No.", DocNo_iCod);
        ReturnRcptHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if ReturnRcptHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(ReturnRcptHeader_lRec."Dimension Set ID", ReturnRcptHeader_lRec."Shortcut Dimension 1 Code", ReturnRcptHeader_lRec."Shortcut Dimension 2 Code");
                ReturnRcptHeader_lRec.Modify;
                ReturnRcptLine_lRec.SetRange("Document No.", ReturnRcptHeader_lRec."No.");
                if ReturnRcptLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(ReturnRcptLine_lRec."Dimension Set ID", ReturnRcptLine_lRec."Shortcut Dimension 1 Code", ReturnRcptLine_lRec."Shortcut Dimension 2 Code");
                        ReturnRcptLine_lRec.Modify;
                    until ReturnRcptLine_lRec.Next = 0;
                end;
            until ReturnRcptHeader_lRec.Next = 0;
        end;

        //Update Dimension Sales Cr. Memo Header
        SalesCrMemoHeader_lRec.Reset;
        SalesCrMemoHeader_lRec.SetCurrentkey("No.", "Posting Date");
        SalesCrMemoHeader_lRec.SetRange("No.", DocNo_iCod);
        SalesCrMemoHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if SalesCrMemoHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(SalesCrMemoHeader_lRec."Dimension Set ID", SalesCrMemoHeader_lRec."Shortcut Dimension 1 Code", SalesCrMemoHeader_lRec."Shortcut Dimension 2 Code");
                SalesCrMemoHeader_lRec.Modify;
                SalesCrMemoLine_lRec.SetRange("Document No.", SalesCrMemoHeader_lRec."No.");
                if SalesCrMemoLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(SalesCrMemoLine_lRec."Dimension Set ID", SalesCrMemoLine_lRec."Shortcut Dimension 1 Code", SalesCrMemoLine_lRec."Shortcut Dimension 2 Code");
                        SalesCrMemoLine_lRec.Modify;
                    until SalesCrMemoLine_lRec.Next = 0;
                end;
            until SalesCrMemoHeader_lRec.Next = 0;
        end;

        //Update Dimension Service Cr. Memo Header
        ServCrMemoHeader_lRec.Reset;
        ServCrMemoHeader_lRec.SetCurrentkey("No.", "Posting Date");
        ServCrMemoHeader_lRec.SetRange("No.", DocNo_iCod);
        ServCrMemoHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if ServCrMemoHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(ServCrMemoHeader_lRec."Dimension Set ID", ServCrMemoHeader_lRec."Shortcut Dimension 1 Code", ServCrMemoHeader_lRec."Shortcut Dimension 2 Code");
                ServCrMemoHeader_lRec.Modify;
                ServCrMemoLine_lRec.SetRange("Document No.", ServCrMemoHeader_lRec."No.");
                if ServCrMemoLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(ServCrMemoLine_lRec."Dimension Set ID", ServCrMemoLine_lRec."Shortcut Dimension 1 Code", ServCrMemoLine_lRec."Shortcut Dimension 2 Code");
                        ServCrMemoLine_lRec.Modify;
                    until ServCrMemoLine_lRec.Next = 0;
                end;
            until ServCrMemoHeader_lRec.Next = 0;
        end;

        //Update Dimension Service Shipment Header
        ServShptHeader_lRec.Reset;
        ServShptHeader_lRec.SetCurrentkey("No.", "Posting Date");
        ServShptHeader_lRec.SetRange("No.", DocNo_iCod);
        ServShptHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if ServShptHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(ServShptHeader_lRec."Dimension Set ID", ServShptHeader_lRec."Shortcut Dimension 1 Code", ServShptHeader_lRec."Shortcut Dimension 2 Code");
                ServShptHeader_lRec.Modify;
                ServShptLine_lRec.SetRange("Document No.", ServShptHeader_lRec."No.");
                if ServShptLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(ServShptLine_lRec."Dimension Set ID", ServShptLine_lRec."Shortcut Dimension 1 Code", ServShptLine_lRec."Shortcut Dimension 2 Code");
                        ServShptLine_lRec.Modify;
                    until ServShptLine_lRec.Next = 0;
                end;
            until ServShptHeader_lRec.Next = 0;
        end;

        //Update Dimension Service Invoice Header
        ServInvHeader_lRec.Reset;
        ServInvHeader_lRec.SetCurrentkey("No.", "Posting Date");
        ServInvHeader_lRec.SetRange("No.", DocNo_iCod);
        ServInvHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if ServInvHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(ServInvHeader_lRec."Dimension Set ID", ServInvHeader_lRec."Shortcut Dimension 1 Code", ServInvHeader_lRec."Shortcut Dimension 2 Code");
                ServInvHeader_lRec.Modify;
                ServInvLine_lRec.SetRange("Document No.", ServInvHeader_lRec."No.");
                if ServInvLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(ServInvLine_lRec."Dimension Set ID", ServInvLine_lRec."Shortcut Dimension 1 Code", ServInvLine_lRec."Shortcut Dimension 2 Code");
                        ServInvLine_lRec.Modify;
                    until ServInvLine_lRec.Next = 0;
                end;
            until ServInvHeader_lRec.Next = 0;
        end;

        //Service Leagder Entry
        ServLedgerEntry_lRec.Reset;
        ServLedgerEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
        ServLedgerEntry_lRec.SetRange("Document No.", DocNo_iCod);
        ServLedgerEntry_lRec.SetRange("Posting Date", PostingDate_iDte);
        if ServLedgerEntry_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(ServLedgerEntry_lRec."Dimension Set ID", ServLedgerEntry_lRec."Global Dimension 1 Code", ServLedgerEntry_lRec."Global Dimension 2 Code");
                ServLedgerEntry_lRec.Modify;
            until ServLedgerEntry_lRec.Next = 0;
        end;

        //Warranty Ledger Entry
        WarrantyLedgerEntry_lRec.Reset;
        WarrantyLedgerEntry_lRec.SetCurrentkey("Document No.", "Posting Date");
        WarrantyLedgerEntry_lRec.SetFilter("Document No.", DocNoFilter);
        WarrantyLedgerEntry_lRec.SetFilter("Posting Date", PostingDateFilter);
        if WarrantyLedgerEntry_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(WarrantyLedgerEntry_lRec."Dimension Set ID", WarrantyLedgerEntry_lRec."Global Dimension 1 Code", WarrantyLedgerEntry_lRec."Global Dimension 2 Code");
                WarrantyLedgerEntry_lRec.Modify;
            until WarrantyLedgerEntry_lRec.Next = 0;
        end;

        //Update Dimension Issued Reminder Header
        IssuedReminderHeader_lRec.Reset;
        IssuedReminderHeader_lRec.SetCurrentkey("No.", "Posting Date");
        IssuedReminderHeader_lRec.SetRange("No.", DocNo_iCod);
        IssuedReminderHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if IssuedReminderHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(IssuedReminderHeader_lRec."Dimension Set ID", IssuedReminderHeader_lRec."Shortcut Dimension 1 Code", IssuedReminderHeader_lRec."Shortcut Dimension 2 Code");
                IssuedReminderHeader_lRec.Modify;
            until IssuedReminderHeader_lRec.Next = 0;
        end;

        //Update Dimension Issued Fin. Chrg. Memo Header
        IssuedFinChrgMemoHeader_lRec.Reset;
        IssuedFinChrgMemoHeader_lRec.SetCurrentkey("No.", "Posting Date");
        IssuedFinChrgMemoHeader_lRec.SetRange("No.", DocNo_iCod);
        IssuedFinChrgMemoHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if IssuedFinChrgMemoHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(IssuedFinChrgMemoHeader_lRec."Dimension Set ID", IssuedFinChrgMemoHeader_lRec."Shortcut Dimension 1 Code", IssuedFinChrgMemoHeader_lRec."Shortcut Dimension 2 Code");
                IssuedFinChrgMemoHeader_lRec.Modify;
            until IssuedFinChrgMemoHeader_lRec.Next = 0;
        end;

        //Update Dimension Purchase Receipt Header
        PurchRcptHeader_lRec.Reset;
        PurchRcptHeader_lRec.SetCurrentkey("No.", "Posting Date");
        PurchRcptHeader_lRec.SetRange("No.", DocNo_iCod);
        PurchRcptHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if PurchRcptHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(PurchRcptHeader_lRec."Dimension Set ID", PurchRcptHeader_lRec."Shortcut Dimension 1 Code", PurchRcptHeader_lRec."Shortcut Dimension 2 Code");
                PurchRcptHeader_lRec.Modify;
                PurchRcptLine_lRec.SetRange("Document No.", PurchRcptHeader_lRec."No.");
                if ReturnRcptLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(PurchRcptLine_lRec."Dimension Set ID", PurchRcptLine_lRec."Shortcut Dimension 1 Code", PurchRcptLine_lRec."Shortcut Dimension 2 Code");
                        PurchRcptLine_lRec.Modify;
                    until PurchRcptLine_lRec.Next = 0;
                end;
            until PurchRcptHeader_lRec.Next = 0;
        end;

        //Update Dimension Purchase Invoice Header
        PurchInvHeader_lRec.Reset;
        PurchInvHeader_lRec.SetCurrentkey("No.", "Posting Date");
        PurchInvHeader_lRec.SetRange("No.", DocNo_iCod);
        PurchInvHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if PurchInvHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(PurchInvHeader_lRec."Dimension Set ID", PurchInvHeader_lRec."Shortcut Dimension 1 Code", PurchInvHeader_lRec."Shortcut Dimension 2 Code");
                PurchInvHeader_lRec.Modify;
                PurchInvLine_lRec.SetRange("Document No.", PurchInvHeader_lRec."No.");
                if PurchInvLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(PurchInvLine_lRec."Dimension Set ID", PurchInvLine_lRec."Shortcut Dimension 1 Code", PurchInvLine_lRec."Shortcut Dimension 2 Code");
                        PurchInvLine_lRec.Modify;
                    until PurchInvLine_lRec.Next = 0;
                end;
            until PurchInvHeader_lRec.Next = 0;
        end;

        //Update Dimension Purchase Invoice Header
        ReturnShptHeader_lRec.Reset;
        ReturnShptHeader_lRec.SetCurrentkey("No.", "Posting Date");
        ReturnShptHeader_lRec.SetRange("No.", DocNo_iCod);
        ReturnShptHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if ReturnShptHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(ReturnShptHeader_lRec."Dimension Set ID", ReturnShptHeader_lRec."Shortcut Dimension 1 Code", ReturnShptHeader_lRec."Shortcut Dimension 2 Code");
                ReturnShptHeader_lRec.Modify;
                ReturnShptLine_lRec.SetRange("Document No.", ReturnShptHeader_lRec."No.");
                if ReturnShptLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(ReturnShptLine_lRec."Dimension Set ID", ReturnShptLine_lRec."Shortcut Dimension 1 Code", ReturnShptLine_lRec."Shortcut Dimension 2 Code");
                        ReturnShptLine_lRec.Modify;
                    until ReturnShptLine_lRec.Next = 0;
                end;
            until ReturnShptHeader_lRec.Next = 0;
        end;

        //Update Dimension Purchase Cr. Memo Header
        PurchCrMemoHeader_lRec.Reset;
        PurchCrMemoHeader_lRec.SetCurrentkey("No.", "Posting Date");
        PurchCrMemoHeader_lRec.SetRange("No.", DocNo_iCod);
        PurchCrMemoHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if PurchCrMemoHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(PurchCrMemoHeader_lRec."Dimension Set ID", PurchCrMemoHeader_lRec."Shortcut Dimension 1 Code", PurchCrMemoHeader_lRec."Shortcut Dimension 2 Code");
                PurchCrMemoHeader_lRec.Modify;
                PurchCrMemoLine_lRec.SetRange("Document No.", PurchCrMemoHeader_lRec."No.");
                if PurchCrMemoLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(PurchCrMemoLine_lRec."Dimension Set ID", PurchCrMemoLine_lRec."Shortcut Dimension 1 Code", PurchCrMemoLine_lRec."Shortcut Dimension 2 Code");
                        PurchCrMemoLine_lRec.Modify;
                    until PurchCrMemoLine_lRec.Next = 0;
                end;
            until PurchCrMemoHeader_lRec.Next = 0;
        end;

        //Update Dimension Posted Assembly Header
        PostedAssemblyHeader_lRec.Reset;
        PostedAssemblyHeader_lRec.SetCurrentkey("No.", "Posting Date");
        PostedAssemblyHeader_lRec.SetRange("No.", DocNo_iCod);
        PostedAssemblyHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if PostedAssemblyHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(PostedAssemblyHeader_lRec."Dimension Set ID", PostedAssemblyHeader_lRec."Shortcut Dimension 1 Code", PostedAssemblyHeader_lRec."Shortcut Dimension 2 Code");
                PostedAssemblyHeader_lRec.Modify;
                PostedAssemblyLine_lRec.SetRange("Document No.", PostedAssemblyHeader_lRec."No.");
                if PostedAssemblyLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(PostedAssemblyLine_lRec."Dimension Set ID", PostedAssemblyLine_lRec."Shortcut Dimension 1 Code", PostedAssemblyLine_lRec."Shortcut Dimension 2 Code");
                        PostedAssemblyLine_lRec.Modify;
                    until PostedAssemblyLine_lRec.Next = 0;
                end;
            until PostedAssemblyHeader_lRec.Next = 0;
        end;

        //Update Dimension Transfer Shipment Header
        TransShptHeader_lRec.Reset;
        TransShptHeader_lRec.SetCurrentkey("No.", "Posting Date");
        TransShptHeader_lRec.SetRange("No.", DocNo_iCod);
        TransShptHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if TransShptHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(TransShptHeader_lRec."Dimension Set ID", TransShptHeader_lRec."Shortcut Dimension 1 Code", TransShptHeader_lRec."Shortcut Dimension 2 Code");
                TransShptHeader_lRec.Modify;
                TransShptLine_lRec.SetRange("Document No.", TransShptHeader_lRec."No.");
                if TransShptLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(TransShptLine_lRec."Dimension Set ID", TransShptLine_lRec."Shortcut Dimension 1 Code", TransShptLine_lRec."Shortcut Dimension 2 Code");
                        TransShptLine_lRec.Modify;
                    until TransShptLine_lRec.Next = 0;
                end;
            until TransShptHeader_lRec.Next = 0;
        end;

        //Update Dimension Transfer Receipt Header
        TransRcptHeader_lRec.Reset;
        TransRcptHeader_lRec.SetCurrentkey("No.", "Posting Date");
        TransRcptHeader_lRec.SetRange("No.", DocNo_iCod);
        TransRcptHeader_lRec.SetRange("Posting Date", PostingDate_iDte);
        if TransRcptHeader_lRec.FindSet then begin
            repeat
                UpdDim_lFnc(TransRcptHeader_lRec."Dimension Set ID", TransRcptHeader_lRec."Shortcut Dimension 1 Code", TransRcptHeader_lRec."Shortcut Dimension 2 Code");
                TransRcptHeader_lRec.Modify;
                TransRcptLine_lRec.SetRange("Document No.", TransRcptHeader_lRec."No.");
                if TransRcptLine_lRec.FindSet then begin
                    repeat
                        UpdDim_lFnc(TransRcptLine_lRec."Dimension Set ID", TransRcptLine_lRec."Shortcut Dimension 1 Code", TransRcptLine_lRec."Shortcut Dimension 2 Code");
                        TransRcptLine_lRec.Modify;
                    until TransRcptLine_lRec.Next = 0;
                end;
            until TransRcptHeader_lRec.Next = 0;
        end;

        Window_gDlg.Close;
    end;


    procedure UpdDim_lFnc(var OldDimSetID_vInt: Integer; var FieldGD1_vCod: Code[20]; var FieldGD2_vCod: Code[20])
    var
        DimChngMgt_lCdu: Codeunit "INTGEN_Dimension Changes Mgt";
        TmpDimSetID_lRecTmp: Record "Dimension Set Entry" temporary;
    begin
        TmpDimSetID_lRecTmp.Reset;
        TmpDimSetID_lRecTmp.DeleteAll;

        Clear(DimChngMgt_lCdu);
        DimChngMgt_lCdu.FillDimSetEntry_gFnc(OldDimSetID_vInt, TmpDimSetID_lRecTmp);

        if NewShortcutDimension1Code_gCod <> '' then
            DimChngMgt_lCdu.UpdateDimSetEntry_gFnc(TmpDimSetID_lRecTmp, GenLedSetup_gRec."Global Dimension 1 Code", NewShortcutDimension1Code_gCod);

        if NewShortcutDimension2Code_gCod <> '' then
            DimChngMgt_lCdu.UpdateDimSetEntry_gFnc(TmpDimSetID_lRecTmp, GenLedSetup_gRec."Global Dimension 2 Code", NewShortcutDimension2Code_gCod);

        if NewShortcutDimension3Code_gCod <> '' then
            DimChngMgt_lCdu.UpdateDimSetEntry_gFnc(TmpDimSetID_lRecTmp, GenLedSetup_gRec."Shortcut Dimension 3 Code", NewShortcutDimension3Code_gCod);

        if NewShortcutDimension4Code_gCod <> '' then
            DimChngMgt_lCdu.UpdateDimSetEntry_gFnc(TmpDimSetID_lRecTmp, GenLedSetup_gRec."Shortcut Dimension 4 Code", NewShortcutDimension4Code_gCod);

        if NewShortcutDimension5Code_gCod <> '' then
            DimChngMgt_lCdu.UpdateDimSetEntry_gFnc(TmpDimSetID_lRecTmp, GenLedSetup_gRec."Shortcut Dimension 5 Code", NewShortcutDimension5Code_gCod);

        if NewShortcutDimension6Code_gCod <> '' then
            DimChngMgt_lCdu.UpdateDimSetEntry_gFnc(TmpDimSetID_lRecTmp, GenLedSetup_gRec."Shortcut Dimension 6 Code", NewShortcutDimension6Code_gCod);

        if NewShortcutDimension7Code_gCod <> '' then
            DimChngMgt_lCdu.UpdateDimSetEntry_gFnc(TmpDimSetID_lRecTmp, GenLedSetup_gRec."Shortcut Dimension 7 Code", NewShortcutDimension7Code_gCod);

        if NewShortcutDimension8Code_gCod <> '' then
            DimChngMgt_lCdu.UpdateDimSetEntry_gFnc(TmpDimSetID_lRecTmp, GenLedSetup_gRec."Shortcut Dimension 8 Code", NewShortcutDimension8Code_gCod);

        OldDimSetID_vInt := DimChngMgt_lCdu.GetDimensionSetID_gFnc(TmpDimSetID_lRecTmp);
        DimChngMgt_lCdu.UpdGlobalDimFromSetID_gFnc(OldDimSetID_vInt, FieldGD1_vCod, FieldGD2_vCod);
    end;
}

