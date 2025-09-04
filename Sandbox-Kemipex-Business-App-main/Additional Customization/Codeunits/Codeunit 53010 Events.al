/// <summary>
/// This is codeunit object and we can check in kemipex Base App
/// </summary>
codeunit 53010 Events//T12370-Full Comment //T12574-N
{
    Permissions = tabledata "Sales Shipment Header" = RIMD, tabledata "Approval Entry" = RIMD;
    /*[EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeReleaseSalesDocument', '', false, false)]
    local procedure OnBeforeReleaseSalesDocument(SalesHeader: Record "Sales Header"; PreviewMode: Boolean);
    var
        RecLines: Record "Sales Line";
        SalesSetup: Record "Sales & Receivables Setup";
        a: record 36;
    begin
        SalesSetup.GET;
        If not SalesSetup."Validate Shipped Qty. DropShip" then exit;
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then begin
            if SalesHeader.Invoice then begin
                Clear(RecLines);
                RecLines.SetRange("Document Type", SalesHeader."Document Type");
                RecLines.SetRange("Document No.", SalesHeader."No.");
                RecLines.SetRange("Drop Shipment", true);
                RecLines.SetFilter(Type, '<>%1', RecLines.Type::" ");
                if RecLines.FindFirst() then begin
                    Clear(RecLines);
                    RecLines.SetRange("Document Type", SalesHeader."Document Type");
                    RecLines.SetRange("Document No.", SalesHeader."No.");
                    RecLines.SetFilter(Type, '<>%1', RecLines.Type::" ");
                    if RecLines.FindFirst() then begin
                        repeat
                            if RecLines.Type <> RecLines.Type::Item then begin
                                RecLines.TestField("Quantity Shipped", RecLines.Quantity);
                            end;
                        until RecLines.Next() = 0;
                    end;
                end;
            end;
        end;
    end;*/




    //Workflow
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Unit Price Base UOM 2', false, false)]
    local procedure StoreUnitPrice(var Rec: Record "Sales Line"; var xRec: Record "Sales Line")
    var
        RecShdr: Record "Sales Header";
        UserSetup: Record "User Setup";
    begin
        Clear(UserSetup);
        if UserSetup.GET(UserId) then;
        if not UserSetup."Allow to update SO Unit Price" then
            if Rec."Document Type" = Rec."Document Type"::Order then begin
                if Rec."Blanket Order No." <> '' then begin
                    If Rec."Unit Price Base UOM 2" <> xRec."Unit Price Base UOM 2" then
                        Error('Blaket order needs to be revised in order to change Unit Price.');
                end;
            end;
        if NOT (Rec."Document Type" IN [Rec."Document Type"::"Blanket Order", Rec."Document Type"::Order, Rec."Document Type"::Quote]) then exit;
        if Rec.Type <> Rec.Type::Item then exit;

        if Rec."Initial Price" = 0 then
            Rec."Initial Price" := Rec."Unit Price Base UOM 2";

        if Rec."Initial Price" = 0 then begin
            Rec."Price Change %" := 0;
            Rec."Price Changed" := false;
            exit;
        end;

        if (Rec."Initial Price" > Rec."Unit Price Base UOM 2") AND (Rec."Initial Price" <> 0) then begin
            Rec."Price Changed" := true;
            Rec."Price Change %" := ((Rec."Unit Price Base UOM 2" - Rec."Initial Price") / Rec."Initial Price") * 100;

        end
        else begin
            if Rec."Initial Price" <> 0 then
                Rec."Price Changed" := false;
            Rec."Price Change %" := ((Rec."Unit Price Base UOM 2" - Rec."Initial Price") / Rec."Initial Price") * 100;
        end;
        Rec."Unit Price Difference" := Rec."Unit Price Base UOM 2" - Rec."Selling Price";
        Clear(RecShdr);
        RecShdr.SetRange("Document Type", Rec."Document Type");
        RecShdr.SetRange("No.", Rec."Document No.");
        if RecShdr.FindFirst() then begin
            RecShdr.UpdatePriceChangeRange();
            RecShdr.Modify(False);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Payment Terms Code', false, false)]
    local procedure StorePaymentTerms(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var
        PaymentTerms: Record "Payment Terms";
        Days: Integer;
    begin
        if NOT (Rec."Document Type" IN [Rec."Document Type"::"Blanket Order", Rec."Document Type"::Order, Rec."Document Type"::Quote]) then exit;
        if Rec."Payment Terms Code" <> '' then begin
            Clear(PaymentTerms);
            PaymentTerms.GET(Rec."Payment Terms Code");
            if FORMAT(Rec."Initial Payment Period") = '' then
                Rec."Initial Payment Period" := PaymentTerms."Due Date Calculation";
            if Rec."Initial Payment Period" <> PaymentTerms."Due Date Calculation" then begin
                Days := CalcDate(PaymentTerms."Due Date Calculation", WorkDate()) - CalcDate(Rec."Initial Payment Period", WorkDate());
                EVALUATE(Rec."Excess Payment Terms Days", '<' + FORMAT(Days) + 'D>');
                if Days > 0 then
                    Rec."Payment Terms Changed" := true
                else
                    Rec."Payment Terms Changed" := false;
            end
            else begin
                Rec."Payment Terms Changed" := false;
                EVALUATE(Rec."Excess Payment Terms Days", '<0D>');
            end;

        end; //else begin
        //     if FORMAT(Rec."Initial Payment Period") <> '' then
        //         Rec."Payment Terms Changed" := true;
        // end;
    end;



    //20-07-2022-start
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnValidateOfStatusChange(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; RunTrigger: Boolean)
    var
        RecLine: Record "Sales Line";
        ApprovalEntry: Record "Approval Entry";
    begin
        if not RunTrigger then exit;
        if Rec."Document Type" IN [Rec."Document Type"::"Blanket Order", Rec."Document Type"::Order, Rec."Document Type"::Quote] then begin
            Clear(RecLine);
            RecLine.SetRange("Document Type", Rec."Document Type");
            RecLine.SetRange("Document No.", Rec."No.");
            if RecLine.FindSet() then begin
                RecLine.ModifyAll("Header Status", Rec.Status, false);
            end;
        end;


        Rec.CalcFields("Salesperson Name");

        case Rec."Document Type" of
            Rec."Document Type"::"Blanket Order":
                begin
                    case Rec.Status of
                        Rec.Status::Open:
                            begin
                                Rec.Validate("Sub Status", StrSubstNo('PI Pending @ %1', Rec."Salesperson Name"))
                            end;

                        Rec.Status::"Pending Approval":
                            begin
                                Clear(ApprovalEntry);
                                ApprovalEntry.SetRange("Record ID to Approve", Rec.RecordId);
                                ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                                if ApprovalEntry.FindFirst() then
                                    Rec.Validate("Sub Status", StrSubstNo('Pending Approval- %1', ApprovalEntry."Approver ID"))
                            end;
                        Rec.Status::Released:
                            begin
                                Rec.Validate("Sub Status", 'PI Approved');
                            end;
                    end;
                end;

            Rec."Document Type"::Order:
                begin
                    case Rec.Status of
                        Rec.Status::Open:
                            begin
                                Rec.Validate("Sub Status", StrSubstNo('PI Pending @ %1', Rec."Salesperson Name"))
                            end;
                        Rec.Status::"Pending Approval":
                            begin
                                Clear(ApprovalEntry);
                                ApprovalEntry.SetRange("Record ID to Approve", Rec.RecordId);
                                ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                                if ApprovalEntry.FindFirst() then
                                    Rec.Validate("Sub Status", StrSubstNo('Pending Approval- %1', ApprovalEntry."Approver ID"))
                            end;
                        Rec.Status::Released:
                            begin
                                Rec.CalcFields(Shipped);
                                Clear(RecLine);
                                RecLine.SetRange("Document Type", Rec."Document Type");
                                RecLine.SetRange("Document No.", Rec."No.");
                                RecLine.SetFilter("Quantity Shipped", '<>0');
                                if RecLine.FindSet() then begin
                                    Rec.Validate("Sub Status", 'Dispatched');
                                end else
                                    if rec.Shipped then
                                        Rec.Validate("Sub Status", 'Dispatched')
                                    else
                                        if Rec."Sub Status" <> 'Dispatched' then
                                            Rec.Validate("Sub Status", 'Pending Shipment');
                            end;
                    end;
                end;

        end;
        Rec.UpdatePriceChangeRange();
        Rec.Modify(false);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnSalesShipped(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; RunTrigger: Boolean)
    var
        RecHdr: Record "Sales Header";
    begin
        //if not RunTrigger then exit;
        if Rec."Document Type" <> Rec."Document Type"::Order then exit;
        if Rec."Quantity Shipped" <> 0 then begin
            Clear(RecHdr);
            RecHdr.SetRange("Document Type", Rec."Document Type");
            RecHdr.SetRange("No.", Rec."Document No.");
            if RecHdr.FindFirst() then begin
                RecHdr.Validate("Sub Status", 'Dispatched');
                RecHdr.UpdatePriceChangeRange();//price change % and Range Boolean
                RecHdr.Modify(false);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Quantity Shipped', false, false)]
    local procedure OnModifySalesShipped(var Rec: Record "Sales Line"; var xRec: Record "Sales Line")
    var
        RecHdr: Record "Sales Header";
    begin
        if Rec."Document Type" <> Rec."Document Type"::Order then exit;
        if Rec."Quantity Shipped" <> 0 then begin
            Clear(RecHdr);
            RecHdr.SetRange("Document Type", Rec."Document Type");
            RecHdr.SetRange("No.", Rec."Document No.");
            if RecHdr.FindFirst() then begin
                RecHdr.Validate("Sub Status", 'Dispatched');
                RecHdr.UpdatePriceChangeRange();//price change % and Range Boolean
                RecHdr.Modify(false);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnPostSalesLineOnBeforeInsertShipmentLine', '', false, false)]
    local procedure OnPostSalesLineOnBeforeInsertShipmentLine(SalesHeader: Record "Sales Header"; SalesLine: Record "Sales Line"; var IsHandled: Boolean; SalesLineACY: Record "Sales Line"; DocType: Option; DocNo: Code[20]; ExtDocNo: Code[35]);
    begin
        if NOT (SalesHeader."Document Type" IN [SalesHeader."Document Type"::"Blanket Order", SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Quote]) Then exit;
        SalesHeader.Validate("Sub Status", 'Dispatched');
        SalesHeader.Modify(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnInsertShipmentLineOnAfterInitQuantityFields', '', false, false)]
    local procedure OnInsertShipmentLineOnAfterInitQuantityFields(var SalesLine: Record "Sales Line"; var xSalesLine: Record "Sales Line"; var SalesShptLine: Record "Sales Shipment Line");
    var
        SHeader: Record "Sales Header";
    begin
        if NOT (SalesLine."Document Type" IN [SalesLine."Document Type"::Order, SalesLine."Document Type"::"Blanket Order", SalesLine."Document Type"::Quote]) then exit;
        Clear(SHeader);
        SHeader.SetRange("Document Type", SalesLine."Document Type");
        SHeader.SetRange("No.", SalesLine."Document No.");
        if SHeader.FindFirst() then begin
            SHeader.Validate("Sub Status", 'Dispatched');
            SHeader.Modify(false);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterSalesShptHeaderInsert', '', false, false)]
    local procedure OnAfterSalesShptHeaderInsert(var SalesShipmentHeader: Record "Sales Shipment Header"; SalesOrderHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PurchHeader: Record "Purchase Header");
    begin
        if NOT (SalesOrderHeader."Document Type" IN [SalesOrderHeader."Document Type"::"Blanket Order", SalesOrderHeader."Document Type"::Order]) Then exit;
        SalesOrderHeader.Validate("Sub Status", 'Dispatched');
        SalesOrderHeader.Modify(false);
    end;



    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Document-Print", 'OnBeforeDoPrintSalesHeader', '', false, false)]
    // local procedure OnBeforeDoPrintSalesHeader(var SalesHeader: Record "Sales Header"; ReportUsage: Integer; SendAsEmail: Boolean; var IsPrinted: Boolean);
    // begin
    //     if SalesHeader."Document Type" = SalesHeader."Document Type"::"Blanket Order" then begin
    //         if SalesHeader.Status = SalesHeader.Status::Released then begin
    //             SalesHeader.Validate("Sub Status", 'PI Released');
    //             SalesHeader.Modify(false);
    //         end;
    //     end;
    // end;

    [EventSubscriber(ObjectType::Table, Database::"Report Selections", 'OnAfterPrintDocument', '', false, false)]
    local procedure OnAfterPrintDocument(TempReportSelections: Record "Report Selections"; IsGUI: Boolean; RecVarToPrint: Variant);
    var
        RecRef: RecordRef;
        RecSheader: Record "Sales Header";
    begin
        RecRef.GetTable(RecVarToPrint);
        case RecRef.Number of
            DATABASE::"Sales Header":
                begin
                    RecRef.SetTable(RecSheader);
                    if (RecSheader."Document Type" = RecSheader."Document Type"::"Blanket Order") AND (RecSheader.Status = RecSheader.Status::Released) then begin
                        RecSheader.Validate("Sub Status", 'PI Released');
                        RecSheader.Modify(false);
                        RecVarToPrint := RecSheader;
                    end;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnReopenOnBeforeSalesHeaderModify', '', false, false)]
    local procedure OnReopenOnBeforeSalesHeaderModify(var SalesHeader: Record "Sales Header");
    var
        RecLine: Record "Sales Line";
    begin
        if SalesHeader."Document Type" IN [SalesHeader."Document Type"::"Blanket Order", SalesHeader."Document Type"::Order] then begin
            Clear(RecLine);
            RecLine.SetRange("Document Type", SalesHeader."Document Type");
            RecLine.SetRange("Document No.", SalesHeader."No.");
            if RecLine.FindSet() then begin
                RecLine.ModifyAll("Header Status", SalesHeader.Status, false);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterManualReleaseSalesDoc', '', false, false)]
    local procedure OnAfterManualReleaseSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean);
    var
        RecLine: Record "Sales Line";
    begin
        if SalesHeader."Document Type" IN [SalesHeader."Document Type"::"Blanket Order", SalesHeader."Document Type"::Order] then begin
            Clear(RecLine);
            RecLine.SetRange("Document Type", SalesHeader."Document Type");
            RecLine.SetRange("Document No.", SalesHeader."No.");
            if RecLine.FindSet() then begin
                RecLine.ModifyAll("Header Status", SalesHeader.Status, false);
            end;
        end;
    end;



    [EventSubscriber(ObjectType::Table, Database::"Approval Entry", 'OnAfterModifyEvent', '', false, false)]
    local procedure OnStatusChangeOfApprovalEntry(var Rec: Record "Approval Entry"; var xRec: Record "Approval Entry")
    var
        RecHdr: Record "Sales Header";
        ApprovalEntry: Record "Approval Entry";
        RecItem: Record Item;
        RecRef: RecordRef;
        RecCustomer: Record Customer;
        RecVendor: Record Vendor;
    //T12574-O ReleaseToCompany: Codeunit "Release to Company";
    begin
        if Rec."Document Type" IN [Rec."Document Type"::Order, Rec."Document Type"::"Blanket Order"] then begin
            Clear(RecHdr);
            RecHdr.SetRange("Document Type", Rec."Document Type");
            RecHdr.SetRange("No.", Rec."Document No.");
            if RecHdr.FindFirst() then begin
                if Rec.Status = Rec.Status::Open then begin
                    RecHdr.Validate("Sub Status", StrSubstNo('Pending Approval- %1', Rec."Approver ID"))
                end;

                RecHdr.CalcFields("Salesperson Name");

                case RecHdr."Document Type" of
                    RecHdr."Document Type"::"Blanket Order":
                        begin
                            case RecHdr.Status of
                                RecHdr.Status::Open:
                                    begin
                                        RecHdr.Validate("Sub Status", StrSubstNo('PI Pending @ %1', RecHdr."Salesperson Name"))
                                    end;

                                RecHdr.Status::"Pending Approval":
                                    begin
                                        Clear(ApprovalEntry);
                                        ApprovalEntry.SetRange("Record ID to Approve", RecHdr.RecordId);
                                        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                                        if ApprovalEntry.FindFirst() then
                                            RecHdr.Validate("Sub Status", StrSubstNo('Pending Approval- %1', ApprovalEntry."Approver ID"))
                                    end;
                                RecHdr.Status::Released:
                                    begin
                                        RecHdr.Validate("Sub Status", 'PI Approved');
                                    end;
                            end;
                        end;

                    RecHdr."Document Type"::Order:
                        begin
                            case RecHdr.Status of
                                RecHdr.Status::Open:
                                    begin
                                        RecHdr.Validate("Sub Status", StrSubstNo('PI Pending @ %1', RecHdr."Salesperson Name"))
                                    end;
                                RecHdr.Status::"Pending Approval":
                                    begin
                                        Clear(ApprovalEntry);
                                        ApprovalEntry.SetRange("Record ID to Approve", Rec.RecordId);
                                        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                                        if ApprovalEntry.FindFirst() then
                                            RecHdr.Validate("Sub Status", StrSubstNo('Pending Approval- %1', ApprovalEntry."Approver ID"))
                                    end;
                                RecHdr.Status::Released:
                                    begin
                                        RecHdr.Validate("Sub Status", 'Pending Shipment');
                                    end;
                            end;
                        end;
                end;
                RecHdr.Modify(false);
            end;
        end else begin
            if Rec.Status = Rec.Status::Approved then begin
                case Rec."Table ID" of
                    Database::Item:
                        begin
                            Clear(ApprovalEntry);
                            ApprovalEntry.SetRange("Table ID", Rec."Table ID");
                            ApprovalEntry.SetRange("Record ID to Approve", Rec."Record ID to Approve");
                            ApprovalEntry.SetFilter(Status, '=%1|%2', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created);
                            if not ApprovalEntry.FindFirst() then begin
                                Clear(RecItem);
                                RecRef := Rec."Record ID to Approve".GetRecord();
                                RecRef.SetTable(RecItem);
                                RecItem.GET(RecItem."No.");
                                //T12574-O RecItem.companytransfer2(RecItem, false);
                            end;
                        end;

                    Database::Customer:
                        begin
                            Clear(ApprovalEntry);
                            ApprovalEntry.SetRange("Table ID", Rec."Table ID");
                            ApprovalEntry.SetRange("Record ID to Approve", Rec."Record ID to Approve");
                            ApprovalEntry.SetFilter(Status, '=%1|%2', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created);
                            if not ApprovalEntry.FindFirst() then begin
                                Clear(RecCustomer);
                                RecRef := Rec."Record ID to Approve".GetRecord();
                                RecRef.SetTable(RecCustomer);
                                RecCustomer.GET(RecCustomer."No.");
                                //T12574-O RecCustomer.companytransfer2(RecCustomer, false);
                            end;
                        end;

                    Database::Vendor:
                        begin
                            Clear(ApprovalEntry);
                            ApprovalEntry.SetRange("Table ID", Rec."Table ID");
                            ApprovalEntry.SetRange("Record ID to Approve", Rec."Record ID to Approve");
                            ApprovalEntry.SetFilter(Status, '=%1|%2', ApprovalEntry.Status::Open, ApprovalEntry.Status::Created);
                            if not ApprovalEntry.FindFirst() then begin
                                Clear(RecVendor);
                                RecRef := Rec."Record ID to Approve".GetRecord();
                                RecRef.SetTable(RecVendor);
                                RecVendor.GET(RecVendor."No.");
                                //T12574-O ReleaseToCompany.ReleaseVendorMaster(RecVendor); //, false); hide by B
                            end;
                        end;
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Approval Entry", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnInsterChangeOfApprovalEntry(var Rec: Record "Approval Entry"; RunTrigger: Boolean)
    var
        RecHdr: Record "Sales Header";
        ApprovalEntry: Record "Approval Entry";
    begin
        if Rec."Document Type" IN [Rec."Document Type"::Order, Rec."Document Type"::"Blanket Order"] then begin
            Clear(RecHdr);
            RecHdr.SetRange("Document Type", Rec."Document Type");
            RecHdr.SetRange("No.", Rec."Document No.");
            if RecHdr.FindFirst() then begin
                if Rec.Status = Rec.Status::Open then begin

                    RecHdr.Validate("Sub Status", StrSubstNo('Pending Approval- %1', Rec."Approver ID"))

                end;

                RecHdr.CalcFields("Salesperson Name");

                case RecHdr."Document Type" of
                    RecHdr."Document Type"::"Blanket Order":
                        begin
                            case RecHdr.Status of
                                RecHdr.Status::Open:
                                    begin
                                        RecHdr.Validate("Sub Status", StrSubstNo('PI Pending @ %1', RecHdr."Salesperson Name"))
                                    end;

                                RecHdr.Status::"Pending Approval":
                                    begin
                                        Clear(ApprovalEntry);
                                        ApprovalEntry.SetRange("Record ID to Approve", RecHdr.RecordId);
                                        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                                        if ApprovalEntry.FindFirst() then
                                            RecHdr.Validate("Sub Status", StrSubstNo('Pending Approval- %1', ApprovalEntry."Approver ID"))
                                    end;
                                RecHdr.Status::Released:
                                    begin
                                        RecHdr.Validate("Sub Status", 'PI Approved');
                                    end;
                            end;
                        end;

                    RecHdr."Document Type"::Order:
                        begin
                            case RecHdr.Status of
                                RecHdr.Status::Open:
                                    begin
                                        RecHdr.Validate("Sub Status", StrSubstNo('PI Pending @ %1', RecHdr."Salesperson Name"))
                                    end;
                                RecHdr.Status::"Pending Approval":
                                    begin
                                        Clear(ApprovalEntry);
                                        ApprovalEntry.SetRange("Record ID to Approve", Rec.RecordId);
                                        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
                                        if ApprovalEntry.FindFirst() then
                                            RecHdr.Validate("Sub Status", StrSubstNo('Pending Approval- %1', ApprovalEntry."Approver ID"))
                                    end;
                                RecHdr.Status::Released:
                                    begin
                                        RecHdr.Validate("Sub Status", 'Pending Shipment');
                                    end;
                            end;
                        end;
                end;
                RecHdr.Modify(false);
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeGetTotalAmountLCYCommon', '', false, false)]
    local procedure OnBeforeGetTotalAmountLCYCommon(var Customer: Record Customer; var AdditionalAmountLCY: Decimal; var IsHandled: Boolean);
    var
        [SecurityFiltering(SecurityFilter::Filtered)]
        SalesLine: Record "Sales Line";
        [SecurityFiltering(SecurityFilter::Filtered)]
        ServiceLine: Record "Service Line";
        SalesOutstandingAmountFromShipment: Decimal;
        ServOutstandingAmountFromShipment: Decimal;
        InvoicedPrepmtAmountLCY: Decimal;
        RetRcdNotInvAmountLCY: Decimal;
    begin
        IsHandled := true;

        SalesOutstandingAmountFromShipment := SalesLine.OutstandingInvoiceAmountFromShipment(Customer."No.");
        ServOutstandingAmountFromShipment := ServiceLine.OutstandingInvoiceAmountFromShipment(Customer."No.");
        InvoicedPrepmtAmountLCY := Customer.GetInvoicedPrepmtAmountLCY;
        RetRcdNotInvAmountLCY := Customer.GetReturnRcdNotInvAmountLCY;
        Customer.CalcFields("Orders (LCY)-InProcess");
        AdditionalAmountLCY := Customer."Balance (LCY)" + Customer."Orders (LCY)-InProcess" + Customer."Shipped Not Invoiced (LCY)" + Customer."Outstanding Invoices (LCY)" +
          Customer."Outstanding Serv. Orders (LCY)" + Customer."Serv Shipped Not Invoiced(LCY)" + Customer."Outstanding Serv.Invoices(LCY)" -
          SalesOutstandingAmountFromShipment - ServOutstandingAmountFromShipment - InvoicedPrepmtAmountLCY - RetRcdNotInvAmountLCY +
          AdditionalAmountLCY;
    end;



    [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnBeforeActionEvent', 'SendApprovalRequest', false, false)]
    procedure OnBeforeSendApprovalRequest(var Rec: Record "Sales Header")
    var
        Customer: Record Customer;
        AvailableCrLimit: Decimal;
    begin
        if NOT (Rec."Document Type" IN [Rec."Document Type"::Order, Rec."Document Type"::Quote, Rec."Document Type"::"Blanket Order"]) then exit;
        Clear(Customer);
        Clear(AvailableCrLimit);
        Customer.GET(Rec."Sell-to Customer No.");
        Customer.CalcFields("Balance (LCY)", "Orders (LCY)-InProcess", "Shipped Not Invoiced (LCY)");
        //AvailableCrLimit := Customer.CalcAvailableCredit;
        Rec.CalcFields("Amount Including VAT");
        if Rec."Currency Factor" <> 0 then
            AvailableCrLimit := Customer."Credit Limit (LCY)" - Customer."Balance (LCY)" - Customer."Orders (LCY)-InProcess" - Customer."Shipped Not Invoiced (LCY)" - (Rec."Amount Including VAT" / Rec."Currency Factor")
        else
            AvailableCrLimit := Customer."Credit Limit (LCY)" - Customer."Balance (LCY)" - Customer."Orders (LCY)-InProcess" - Customer."Shipped Not Invoiced (LCY)" - Rec."Amount Including VAT";
        Rec."Available Credit Limit" := AvailableCrLimit;
        Rec.validate("Credit Limit Percentage", ((AvailableCrLimit / Customer."Credit Limit (LCY)") * 100));
        // if AvailableCrLimit < 0 then
        //     Rec.validate("Credit Limit Percentage",
        //     ((Customer."Credit Limit (LCY)" + AvailableCrLimit) / Customer."Credit Limit (LCY)") * 100)
        // else
        //     Rec.validate("Credit Limit Percentage",
        //      ((Customer."Credit Limit (LCY)" - AvailableCrLimit) / Customer."Credit Limit (LCY)") * 100);

        //Message('Credit Limit %1 \Balance LCY %2 \Order LCY In Process %3\Shipped Not Invoiced %4\Available Cr Limit %5\Current Order %6\Percentage %7', Customer."Credit Limit (LCY)", Customer."Balance (LCY)", Customer."Orders (LCY)-InProcess", Customer."Shipped Not Invoiced (LCY)", AvailableCrLimit, Rec."Amount Including VAT", Rec."Credit Limit Percentage");

        Rec.UpdatePriceChangeRange();

        //To update Amount LCY field
        if Rec."Currency Factor" <> 0 then
            Rec."Amount LCY" := Rec."Amount Including VAT" / Rec."Currency Factor"
        else
            Rec."Amount LCY" := Rec."Amount Including VAT";

        Rec.Modify(false);
        //Commit();
    end;
    //20-07-2022-end

    [EventSubscriber(ObjectType::Page, Page::"Blanket Sales Order", 'OnBeforeActionEvent', 'SendApprovalRequest', false, false)]
    local procedure UpdateLCYAmountForBSO(var Rec: Record "Sales Header")
    begin
        //To update Amount LCY field
        if Rec."Currency Factor" <> 0 then
            Rec."Amount LCY" := Rec."Amount Including VAT" / Rec."Currency Factor"
        else
            Rec."Amount LCY" := Rec."Amount Including VAT";

        Rec.Modify(false);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Quote", 'OnBeforeActionEvent', 'SendApprovalRequest', false, false)]
    procedure OnBeforeSendApprovalRequestSalesQuote(var Rec: Record "Sales Header")
    var
        Customer: Record Customer;
        AvailableCrLimit: Decimal;
    begin
        if NOT (Rec."Document Type" IN [Rec."Document Type"::Order, Rec."Document Type"::Quote, rec."Document Type"::"Blanket Order"]) then exit;
        Clear(Customer);
        Clear(AvailableCrLimit);
        Customer.GET(Rec."Sell-to Customer No.");
        Customer.CalcFields("Balance (LCY)", "Orders (LCY)-InProcess", "Shipped Not Invoiced (LCY)");
        //AvailableCrLimit := Customer.CalcAvailableCredit;
        Rec.CalcFields("Amount Including VAT");
        if Rec."Currency Factor" <> 0 then
            AvailableCrLimit := Customer."Credit Limit (LCY)" - Customer."Balance (LCY)" - Customer."Orders (LCY)-InProcess" - Customer."Shipped Not Invoiced (LCY)" - (Rec."Amount Including VAT" / Rec."Currency Factor")
        else
            AvailableCrLimit := Customer."Credit Limit (LCY)" - Customer."Balance (LCY)" - Customer."Orders (LCY)-InProcess" - Customer."Shipped Not Invoiced (LCY)" - Rec."Amount Including VAT";
        Rec."Available Credit Limit" := AvailableCrLimit;

        IF Customer."Credit Limit (LCY)" <> 0 Then
            Rec.validate("Credit Limit Percentage", ((AvailableCrLimit / Customer."Credit Limit (LCY)") * 100))
        Else begin
            IF Rec."Credit Limit Percentage" <> 0 Then
                Rec.validate("Credit Limit Percentage", 0);
        End;

        // if AvailableCrLimit < 0 then
        //     Rec.validate("Credit Limit Percentage",
        //     ((Customer."Credit Limit (LCY)" + AvailableCrLimit) / Customer."Credit Limit (LCY)") * 100)
        // else
        //     Rec.validate("Credit Limit Percentage",
        //      ((Customer."Credit Limit (LCY)" - AvailableCrLimit) / Customer."Credit Limit (LCY)") * 100);

        //Message('Credit Limit %1 \Balance LCY %2 \Order LCY In Process %3\Shipped Not Invoiced %4\Available Cr Limit %5\Current Order %6\Percentage %7', Customer."Credit Limit (LCY)", Customer."Balance (LCY)", Customer."Orders (LCY)-InProcess", Customer."Shipped Not Invoiced (LCY)", AvailableCrLimit, Rec."Amount Including VAT", Rec."Credit Limit Percentage");

        Rec.UpdatePriceChangeRange();

        //To update Amount LCY field
        if Rec."Currency Factor" <> 0 then
            Rec."Amount LCY" := Rec."Amount Including VAT" / Rec."Currency Factor"
        else
            Rec."Amount LCY" := Rec."Amount Including VAT";

        Rec.Modify(false);
        //Commit();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Blanket Sales Order", 'OnBeforeActionEvent', 'SendApprovalRequest', false, false)]
    procedure OnBeforeSendApprovalRequestBlanketSalesOrder(var Rec: Record "Sales Header")
    var
        Customer: Record Customer;
        AvailableCrLimit: Decimal;
    begin
        if Rec."Document Type" <> rec."Document Type"::"Blanket Order" then exit;
        Clear(Customer);
        Clear(AvailableCrLimit);
        Customer.GET(Rec."Sell-to Customer No.");
        Customer.CalcFields("Balance (LCY)", "Orders (LCY)-InProcess", "Shipped Not Invoiced (LCY)");
        //AvailableCrLimit := Customer.CalcAvailableCredit;
        Rec.CalcFields("Amount Including VAT");
        if Rec."Currency Factor" <> 0 then
            AvailableCrLimit := Customer."Credit Limit (LCY)" - Customer."Balance (LCY)" - Customer."Orders (LCY)-InProcess" - Customer."Shipped Not Invoiced (LCY)" - (Rec."Amount Including VAT" / Rec."Currency Factor")
        else
            AvailableCrLimit := Customer."Credit Limit (LCY)" - Customer."Balance (LCY)" - Customer."Orders (LCY)-InProcess" - Customer."Shipped Not Invoiced (LCY)" - Rec."Amount Including VAT";
        Rec."Available Credit Limit" := AvailableCrLimit;
        Rec.validate("Credit Limit Percentage", ((AvailableCrLimit / Customer."Credit Limit (LCY)") * 100));
        // if AvailableCrLimit < 0 then
        //     Rec.validate("Credit Limit Percentage",
        //     ((Customer."Credit Limit (LCY)" + AvailableCrLimit) / Customer."Credit Limit (LCY)") * 100)
        // else
        //     Rec.validate("Credit Limit Percentage",
        //      ((Customer."Credit Limit (LCY)" - AvailableCrLimit) / Customer."Credit Limit (LCY)") * 100);

        //Message('Credit Limit %1 \Balance LCY %2 \Order LCY In Process %3\Shipped Not Invoiced %4\Available Cr Limit %5\Current Order %6\Percentage %7', Customer."Credit Limit (LCY)", Customer."Balance (LCY)", Customer."Orders (LCY)-InProcess", Customer."Shipped Not Invoiced (LCY)", AvailableCrLimit, Rec."Amount Including VAT", Rec."Credit Limit Percentage");

        Rec.UpdatePriceChangeRange();

        //To update Amount LCY field
        if Rec."Currency Factor" <> 0 then
            Rec."Amount LCY" := Rec."Amount Including VAT" / Rec."Currency Factor"
        else
            Rec."Amount LCY" := Rec."Amount Including VAT";

        Rec.Modify(false);
        //Commit();
    end;
    //20-07-2022-end

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeDeleteAfterPosting', '', false, false)]
    local procedure OnBeforeDeleteAfterPosting(var SalesHeader: Record "Sales Header"; var SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var SkipDelete: Boolean; CommitIsSuppressed: Boolean; EverythingInvoiced: Boolean; var TempSalesLineGlobal: Record "Sales Line");
    begin
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order Then exit;
        SalesHeader."Sub Status" := 'Invoiced';
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnBeforeSalesHeaderArchiveInsert', '', false, false)]
    local procedure OnBeforeSalesHeaderArchiveInsert(var SalesHeaderArchive: Record "Sales Header Archive"; SalesHeader: Record "Sales Header");
    begin
        if SalesHeader."Document Type" <> SalesHeader."Document Type"::Order Then exit;
        SalesHeaderArchive."Sub Status" := 'Invoiced';
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeCheckAvailableCreditLimit', '', false, false)]
    local procedure OnBeforeCheckAvailableCreditLimit(var SalesHeader: Record "Sales Header"; var ReturnValue: Decimal; var IsHandled: Boolean);
    var
        Customer: Record Customer;
        AvailableCreditLimit: Decimal;
    begin
        IsHandled := true;
        if (SalesHeader."Bill-to Customer No." = '') and (SalesHeader."Sell-to Customer No." = '') then begin
            ReturnValue := 0;
            exit;
        end;

        if not Customer.Get(SalesHeader."Bill-to Customer No.") then
            Customer.Get(SalesHeader."Sell-to Customer No.");
        SalesHeader.CalcFields("Amount Including VAT");
        if SalesHeader."Currency Factor" <> 0 then
            ReturnValue := Customer.CalcAvailableCredit - (SalesHeader."Amount Including VAT" / SalesHeader."Currency Factor")
        else
            ReturnValue := Customer.CalcAvailableCredit - SalesHeader."Amount Including VAT";
        if ReturnValue < 0 then
            SalesHeader.CustomerCreditLimitExceeded()
        else
            SalesHeader.CustomerCreditLimitNotExceeded();

        //OnBeforeSendApprovalRequest(SalesHeader);
    end;



    procedure IsItemApproved(Number: Code[20]): Boolean
    var
        RecItem: Record Item;
        RecApprovalEntry: Record "Approval Entry";
        Company: Record Company;
    begin
        Clear(RecItem);
        if not RecItem.GET(Number) then
            exit(false);

        if Company.FindSet() then begin
            repeat

                Clear(RecApprovalEntry);
                RecApprovalEntry.ChangeCompany(Company.Name);
                RecApprovalEntry.SetRange("Table ID", Database::Item);
                RecApprovalEntry.SetRange("Record ID to Approve", RecItem.RecordId);
                RecApprovalEntry.SetRange(Status, RecApprovalEntry.Status::Open);
                if RecApprovalEntry.FindFirst() then
                    exit(false);

                Clear(RecApprovalEntry);
                RecApprovalEntry.ChangeCompany(Company.Name);
                RecApprovalEntry.SetRange("Table ID", Database::Item);
                RecApprovalEntry.SetRange("Record ID to Approve", RecItem.RecordId);
                RecApprovalEntry.SetRange(Status, RecApprovalEntry.Status::Approved);
                if RecApprovalEntry.FindFirst() then
                    exit(true);
            until Company.Next() = 0;
        end;
        exit(false);
    end;

    procedure IsTransactionAvailableForItem(Number: code[20]; var commentText: Text): Boolean
    var
        RecItem: Record Item;
        RecILE: Record "Item Ledger Entry";
        RecCompanies: Record Company;
        RecSalesLine: Record "Sales Line";
        RecPurchLine: Record "Purchase Line";
    //masterconfig: Record "Release to Company Setup";
    begin

        if RecCompanies.FindSet() then begin
            repeat
                Clear(RecILE);
                RecILE.ChangeCompany(RecCompanies.Name);
                RecILE.SetRange("Item No.", Number);
                if RecILE.FindFirst() then begin
                    commentText := StrSubstNo('Company Name: %1, Item Ledger Entry No. %2', RecCompanies.Name, RecILE."Entry No.");
                    exit(true);
                end;


                Clear(RecSalesLine);
                RecSalesLine.ChangeCompany(RecCompanies.Name);
                RecSalesLine.SetFilter("Document Type", '%1|%2', RecSalesLine."Document Type"::Order, RecSalesLine."Document Type"::"Blanket Order");
                RecSalesLine.SetRange(Type, RecSalesLine.Type::Item);
                RecSalesLine.SetRange("No.", Number);
                if RecSalesLine.FindFirst() then begin
                    commentText := StrSubstNo('Company Name: %1, Sales Header No. %2, Document Type %3, Line No. %4', RecCompanies.Name, RecSalesLine."Document No.", RecSalesLine."Document Type", RecSalesLine."Line No.");
                    exit(true);
                end;

                Clear(RecPurchLine);
                RecPurchLine.ChangeCompany(RecCompanies.Name);
                RecPurchLine.SetFilter("Document Type", '%1|%2', RecPurchLine."Document Type"::Order, RecPurchLine."Document Type"::"Blanket Order");
                RecPurchLine.SetRange(Type, RecPurchLine.Type::Item);
                RecPurchLine.SetRange("No.", Number);
                if RecPurchLine.FindFirst() then begin
                    commentText := StrSubstNo('Company Name: %1, Purchase Header No. %2, Document Type %3, Line No. %4', RecCompanies.Name, RecPurchLine."Document No.", RecPurchLine."Document Type", RecPurchLine."Line No.");
                    exit(true);
                end;

            until RecCompanies.Next() = 0;
        end;

        exit(false);
    end;

    /*[EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnBeforeDeleteSalesDocument(var Rec: Record "Sales Header"; RunTrigger: Boolean)
    var
        RecApprovalEntry: Record "Approval Entry";
        ArchiveMgmt: Codeunit ArchiveManagement;
    begin
        if Rec."Document Type" in [Rec."Document Type"::Order, Rec."Document Type"::"Blanket Order"] then begin
            //StoreSalesDocument
            Clear(RecApprovalEntry);
            if Rec."Document Type" = Rec."Document Type"::"Blanket Order" then
                RecApprovalEntry.SetRange("Document Type", RecApprovalEntry."Document Type"::"Blanket Order")
            else
                RecApprovalEntry.SetRange("Document Type", RecApprovalEntry."Document Type"::Order);
            RecApprovalEntry.SetRange("Document No.", Rec."No.");
            RecApprovalEntry.SetRange("Table ID", Database::"Sales Header");
            if RecApprovalEntry.FindFirst() then begin
                ArchiveMgmt.StoreSalesDocument(Rec, false);
            end;
        end;
    end;*/

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCheckSellToCust', '', false, false)]
    local procedure OnAfterCheckSellToCust(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; Customer: Record Customer; CurrentFieldNo: Integer);
    begin
        SalesHeader."Customer Final Destination" := Customer."Customer Final Destination";
        SalesHeader."Customer Incentive Point (CIP)" := Customer."Customer Incentive Ratio (CIR)"; //Kemipex Base App
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnCopyFromItemOnAfterCheck', '', false, false)]
    local procedure OnCopyFromItemOnAfterCheck(var SalesLine: Record "Sales Line"; Item: Record Item);
    begin
        SalesLine."Item Incentive Point (IIP)" := Item."Item Incentive Ratio (IIR)";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnCopyFromItemOnAfterCheck', '', false, false)]
    local procedure OnCopyFromItemOnAfterCheck_Purch(var PurchaseLine: Record "Purchase Line"; Item: Record Item; CallingFieldNo: Integer);
    begin
        PurchaseLine."Item Incentive Point (IIP)" := Item."Item Incentive Ratio (IIR)";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnRunOnBeforeResetQuantityFields', '', false, false)]
    local procedure OnRunOnBeforeResetQuantityFields(var BlanketOrderSalesLine: Record "Sales Line"; var SalesOrderLine: Record "Sales Line");
    begin
        SalesOrderLine."Header Status" := SalesOrderLine."Header Status"::Open;
    end;

    procedure UpdatePriceChangeRange(var RecSHeader: Record "Sales Header")
    var
        SalesSetup: Record "Sales & Receivables Setup";
    begin
        SalesSetup.GET;
        RecSHeader."Price Change % 1st Range" := false;
        RecSHeader."Price Change % 2nd Range" := false;
        RecSHeader."Price Change % 3rd Range" := false;
        RecSHeader.CalcFields("Price Change %");
        if RecSHeader."Price Change %" < 0 then begin
            if (ABS(RecSHeader."Price Change %") >= SalesSetup."Price Change % 1st From Range") AND (ABS(RecSHeader."Price Change %") <= SalesSetup."Price Change % 1st To Range") then begin
                RecSHeader.Validate("Price Change % 1st Range", true);
            end else
                if (ABS(RecSHeader."Price Change %") >= SalesSetup."Price Change % 2nd From Range") AND (ABS(RecSHeader."Price Change %") <= SalesSetup."Price Change % 2nd To Range") then begin
                    RecSHeader.Validate("Price Change % 2nd Range", true);
                end
                else
                    if (ABS(RecSHeader."Price Change %") >= SalesSetup."Price Change % 3rd From Range") AND (ABS(RecSHeader."Price Change %") <= SalesSetup."Price Change % 3rd To Range") then begin
                        RecSHeader.Validate("Price Change % 3rd Range", true);
                    end else
                        if (ABS(RecSHeader."Price Change %") >= SalesSetup."Price Change % 3rd To Range") then
                            RecSHeader.Validate("Price Change % 3rd Range", true);
        end;

        RecSHeader."Credit Limit 1st Range" := false;
        RecSHeader."Credit Limit 2nd Range" := false;
        RecSHeader."Credit Limit 3rd Range" := false;
        if RecSHeader."Credit Limit Percentage" < 0 then begin
            if (ABS(RecSHeader."Credit Limit Percentage") >= SalesSetup."Credit Limit 1st From Range") AND (ABS(RecSHeader."Credit Limit Percentage") <= SalesSetup."Credit Limit 1st To Range") then begin
                RecSHeader.Validate("Credit Limit 1st Range", true);
            end else
                if (ABS(RecSHeader."Credit Limit Percentage") >= SalesSetup."Credit Limit 2nd From Range") AND (ABS(RecSHeader."Credit Limit Percentage") <= SalesSetup."Credit Limit 2nd To Range") then begin
                    RecSHeader.Validate("Credit Limit 2nd Range", true);
                end
                else
                    if (ABS(RecSHeader."Credit Limit Percentage") >= SalesSetup."Credit Limit 3rd From Range") AND (ABS(RecSHeader."Credit Limit Percentage") <= SalesSetup."Credit Limit 3rd To Range") then begin
                        RecSHeader.Validate("Credit Limit 3rd Range", true);
                    end else
                        if (ABS(RecSHeader."Credit Limit Percentage") >= SalesSetup."Credit Limit 3rd To Range") then
                            RecSHeader.Validate("Credit Limit 3rd Range", true);
        end;
        RecSHeader.Modify(false);
    end;


    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnBeforeSalesdelete(var Rec: Record "Sales Header"; RunTrigger: Boolean)
    var
        RecApprovalEntry: Record "Approval Entry";
        RecUserSetup: Record "User Setup";
    begin
        if NOT (Rec."Document Type" IN [Rec."Document Type"::Order, Rec."Document Type"::"Blanket Order", Rec."Document Type"::Quote]) then exit;
        If Rec."Short Close" then exit;

        Clear(RecUserSetup);
        if RecUserSetup.GET(UserId) then begin
            if RecUserSetup."Allow Short Close" then begin //Kemipex Base App
                exit;
            end;
        end;

        Clear(RecApprovalEntry);
        RecApprovalEntry.SetRange("Table ID", Database::"Sales Header");
        RecApprovalEntry.SetRange("Record ID to Approve", Rec.RecordId);
        RecApprovalEntry.SetRange(Status, RecApprovalEntry.Status::Approved);
        if RecApprovalEntry.FindFirst() then
            Error('Selected Order is already Approved. You cannot delete it. %1 No. %2', Rec."Document Type", Rec."No.");
    end;

    //to show all approval entries
    [EventSubscriber(ObjectType::Table, Database::"Approval Entry", 'OnBeforeMarkAllWhereUserisApproverOrSender', '', false, false)]
    local procedure OnBeforeMarkAllWhereUserisApproverOrSender(var ApprovalEntry: Record "Approval Entry"; var IsHandled: Boolean);
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Units of Measure", 'OnQueryClosePageEvent', '', false, false)]
    local procedure ItemUOM_OnClose(var Rec: Record "Item Unit of Measure"; var AllowClose: Boolean)
    var
        ItemUOM: Record "Item Unit of Measure";
    begin
        ItemUOM.SetRange("Item No.", Rec."Item No.");
        ItemUOM.SetRange("Net Weight", 0);
        if ItemUOM.FindFirst() then begin
            AllowClose := false;
            ItemUOM.TestField("Net Weight");
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Inv. Header - Edit", 'OnRunOnBeforeAssignValues', '', false, false)]
    local procedure OnRunOnBeforeAssignValues(var SalesInvoiceHeader: Record "Sales Invoice Header"; SalesInvoiceHeaderRec: Record "Sales Invoice Header");
    var
        TempSalesShptLine: Record "Sales Shipment Line" temporary;
        ShipmentHdr: Record "Sales Shipment Header";
        RecInvLines: Record "Sales Invoice Line";
        checkList: List of [Text];
    begin
        SalesInvoiceHeader."Customer Final Destination" := SalesInvoiceHeaderRec."Customer Final Destination";
        SalesInvoiceHeader."Transport Method" := SalesInvoiceHeaderRec."Transport Method";
        //ship-To
        SalesInvoiceHeader."Ship-to Code" := SalesInvoiceHeaderRec."Ship-to Code";
        SalesInvoiceHeader."Ship-to Name" := SalesInvoiceHeaderRec."Ship-to Name";
        SalesInvoiceHeader."Ship-to Address" := SalesInvoiceHeaderRec."Ship-to Address";
        SalesInvoiceHeader."Ship-to Address 2" := SalesInvoiceHeaderRec."Ship-to Address 2";
        SalesInvoiceHeader."Ship-to City" := SalesInvoiceHeaderRec."Ship-to City";
        SalesInvoiceHeader."Ship-to County" := SalesInvoiceHeaderRec."Ship-to County";
        SalesInvoiceHeader."Ship-to Post Code" := SalesInvoiceHeaderRec."Ship-to Post Code";
        SalesInvoiceHeader."Ship-to Country/Region Code" := SalesInvoiceHeaderRec."Ship-to Country/Region Code";
        SalesInvoiceHeader."Ship-to Contact" := SalesInvoiceHeaderRec."Ship-to Contact";

        Clear(checkList);
        Clear(RecInvLines);
        RecInvLines.SetRange("Document No.", SalesInvoiceHeaderRec."No.");
        if RecInvLines.FindSet() then begin
            repeat
                RecInvLines.GetSalesShptLines(TempSalesShptLine);
                if TempSalesShptLine.FindSet() then begin
                    repeat
                        if not checkList.Contains(TempSalesShptLine."Document No.") then begin
                            checkList.Add(TempSalesShptLine."Document No.");
                            if ShipmentHdr.GET(TempSalesShptLine."Document No.") then begin
                                ShipmentHdr."Ship-to Code" := SalesInvoiceHeaderRec."Ship-to Code";
                                ShipmentHdr."Ship-to Name" := SalesInvoiceHeaderRec."Ship-to Name";
                                ShipmentHdr."Ship-to Address" := SalesInvoiceHeaderRec."Ship-to Address";
                                ShipmentHdr."Ship-to Address 2" := SalesInvoiceHeaderRec."Ship-to Address 2";
                                ShipmentHdr."Ship-to City" := SalesInvoiceHeaderRec."Ship-to City";
                                ShipmentHdr."Ship-to County" := SalesInvoiceHeaderRec."Ship-to County";
                                ShipmentHdr."Ship-to Post Code" := SalesInvoiceHeaderRec."Ship-to Post Code";
                                ShipmentHdr."Ship-to Country/Region Code" := SalesInvoiceHeaderRec."Ship-to Country/Region Code";
                                ShipmentHdr."Ship-to Contact" := SalesInvoiceHeaderRec."Ship-to Contact";
                                ShipmentHdr.Modify();
                            end;
                        end;
                    until TempSalesShptLine.Next() = 0;
                end;
            until RecInvLines.Next() = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Inv. - Update", 'OnAfterRecordChanged', '', false, false)]
    local procedure OnAfterRecordChanged(var SalesInvoiceHeader: Record "Sales Invoice Header"; xSalesInvoiceHeader: Record "Sales Invoice Header"; var IsChanged: Boolean);
    begin
        IsChanged := true;
    end;


    [EventSubscriber(ObjectType::Table, database::"Item Journal Line", 'OnBeforeDisplayErrorIfItemIsBlocked', '', false, false)] //added by Baya
    local procedure OnBeforeDisplayErrorIfItemIsBlocked(var Item: Record Item; var ItemJournalLine: Record "Item Journal Line"; var IsHandled: Boolean)
    var
        RecCustomer: Record Customer;
        RecVendor: Record Vendor;
    begin
        if RecCustomer.get(ItemJournalLine."Source No.") then;
        if (RecCustomer."IC Partner Code" <> '') OR (RecCustomer."IC Company Code" <> '') then
            IsHandled := true;

        if RecVendor.get(ItemJournalLine."Source No.") then;
        if (RecVendor."IC Partner Code" <> '') OR (RecVendor."IC Company Code" <> '') then
            IsHandled := true;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeCopyFromItem', '', false, false)]
    local procedure OnBeforeCopyFromItem(var PurchaseLine: Record "Purchase Line"; var Item: Record Item);
    var
        RecVendor: Record Vendor;
    begin
        // If item blocked is no and purchase blocked is yes, then allowed to create IC PO 
        if PurchaseLine."Document Type" = PurchaseLine."Document Type"::Order then begin
            if Item."Purchasing Blocked" then begin
                Clear(RecVendor);
                RecVendor.GET(PurchaseLine."Buy-from Vendor No.");
                if (RecVendor."IC Partner Code" <> '') OR (RecVendor."IC Company Code" <> '') then begin
                    Item."Purchasing Blocked" := false;
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeCopyFromItem', '', false, false)]
    local procedure OnBeforeCopyFromItem_SO(var SalesLine: Record "Sales Line"; Item: Record Item; var IsHandled: Boolean);
    var
        RecCustomer: Record Customer;
        SalesBlockedErr: Label 'You cannot sell this item because the Sales Blocked check box is selected on the item card.';
    begin
        // If item blocked is no and Sales blocked is yes, then allowed to create IC SO 

        if SalesLine."Document Type" = SalesLine."Document Type"::Order then begin
            Item.TestField(Blocked, false);
            Item.TestField("Gen. Prod. Posting Group");
            if Item."Sales Blocked" then begin
                Clear(RecCustomer);
                RecCustomer.GET(SalesLine."Sell-to Customer No.");
                if (RecCustomer."IC Partner Code" = '') AND (RecCustomer."IC Company Code" = '') then begin
                    Error(SalesBlockedErr);
                end;
            end;
            if Item.Type = Item.Type::Inventory then begin
                Item.TestField("Inventory Posting Group");
                SalesLine."Posting Group" := Item."Inventory Posting Group";
            end;
            IsHandled := true;
        end;
    end;


    procedure UpdateCreditLimitFields(var Rec: Record "Sales Header")
    var
        Customer: Record Customer;
        AvailableCrLimit: Decimal;
    begin
        if NOT (Rec."Document Type" IN [Rec."Document Type"::Order, Rec."Document Type"::Quote]) then exit;
        Clear(Customer);
        Clear(AvailableCrLimit);
        Customer.GET(Rec."Sell-to Customer No.");
        Customer.CalcFields("Balance (LCY)", "Orders (LCY)-InProcess", "Shipped Not Invoiced (LCY)");
        //AvailableCrLimit := Customer.CalcAvailableCredit;
        Rec.CalcFields("Amount Including VAT");
        if Rec."Currency Factor" <> 0 then
            AvailableCrLimit := Customer."Credit Limit (LCY)" - Customer."Balance (LCY)" - Customer."Orders (LCY)-InProcess" - Customer."Shipped Not Invoiced (LCY)" - (Rec."Amount Including VAT" / Rec."Currency Factor")
        else
            AvailableCrLimit := Customer."Credit Limit (LCY)" - Customer."Balance (LCY)" - Customer."Orders (LCY)-InProcess" - Customer."Shipped Not Invoiced (LCY)" - Rec."Amount Including VAT";

        Rec."Available Credit Limit" := AvailableCrLimit;
        Rec.validate("Credit Limit Percentage", ((AvailableCrLimit / Customer."Credit Limit (LCY)") * 100));
        // if AvailableCrLimit < 0 then
        //     Rec.validate("Credit Limit Percentage",
        //     ((Customer."Credit Limit (LCY)" + AvailableCrLimit) / Customer."Credit Limit (LCY)") * 100)
        // else
        //     Rec.validate("Credit Limit Percentage",
        //      ((Customer."Credit Limit (LCY)" - AvailableCrLimit) / Customer."Credit Limit (LCY)") * 100);

        //Message('Credit Limit %1 \Balance LCY %2 \Order LCY In Process %3\Shipped Not Invoiced %4\Available Cr Limit %5\Current Order %6\Percentage %7', Customer."Credit Limit (LCY)", Customer."Balance (LCY)", Customer."Orders (LCY)-InProcess", Customer."Shipped Not Invoiced (LCY)", AvailableCrLimit, Rec."Amount Including VAT", Rec."Credit Limit Percentage");

        Rec.UpdatePriceChangeRange();

        //To update Amount LCY field
        if Rec."Currency Factor" <> 0 then
            Rec."Amount LCY" := Rec."Amount Including VAT" / Rec."Currency Factor"
        else
            Rec."Amount LCY" := Rec."Amount Including VAT";
        //Commit();
    end;

    procedure UpdateManagerCode(Teamcode: code[20]; ManagerCode: code[20])
    var
        RecTeamSales: Record "Team Salesperson";
    begin
        Clear(RecTeamSales);
        RecTeamSales.SetRange("Team Code", Teamcode);
        if RecTeamSales.FindSet() then begin
            repeat
                if RecTeamSales."Salesperson Code" = ManagerCode then begin
                    RecTeamSales.Manager := true;
                end else
                    RecTeamSales.Manager := false;

                RecTeamSales."Manager Code" := ManagerCode;
                RecTeamSales.Modify();
            until RecTeamSales.Next() = 0;
        end;
    end;


    /*T12574-N Need to check [EventSubscriber(ObjectType::Page, Page::"Item Units of Measure", 'OnBeforeValidateEvent', 'Qty. per Unit of Measure', false, false)]
    local procedure ItemUOM_OnValidateQtyPerunit(var Rec: Record "Item Unit of Measure"; var xRec: Record "Item Unit of Measure")
    var
        ItemUOM: Record "Item Unit of Measure";
        Companies: Record company;
        SalesLine: Record "Sales Line";
        Saleshdr: Record "Sales Header";
        Purchaseline: Record "Purchase Line";
        PurchaseHdr: Record "Purchase Header";
    begin
        if Companies.FindSet() then begin
            repeat
                Clear(SalesLine);
                SalesLine.ChangeCompany(Companies.Name);
                SalesLine.SetRange(Type, SalesLine.Type::Item);
                SalesLine.SetRange("No.", Rec."Item No.");
                SalesLine.SetRange("Variant Code", Rec."Variant Code"); //added by bayas
                if SalesLine.FindFirst() then begin
                    Clear(Saleshdr);
                    Saleshdr.SetRange("No.", SalesLine."Document No.");
                    Saleshdr.SetRange(Status, Saleshdr.Status::Open);
                    if Saleshdr.FindFirst() then
                        Error('You cannot modify Sales UOM as Item No. %1 - %2 is being used in Open Sales Order %3 in company %4', Rec."Item No.", Rec."Variant Code", Saleshdr."No.", Companies.Name);
                end;

                Clear(Purchaseline);
                Purchaseline.ChangeCompany(Companies.Name);
                Purchaseline.SetRange(Type, Purchaseline.Type::Item);
                Purchaseline.SetRange("No.", Rec."Item No.");
                Purchaseline.SetRange("Variant Code", Rec."Variant Code"); //added by bayas
                if Purchaseline.FindFirst() then begin
                    Clear(PurchaseHdr);
                    PurchaseHdr.SetRange("No.", Purchaseline."Document No.");
                    PurchaseHdr.SetRange(Status, PurchaseHdr.Status::Open);
                    if PurchaseHdr.FindFirst() then
                        Error('You cannot modify Sales UOM as Item No. %1 - %2 is being used in Open Purchase Order %3 in company %4', Rec."Item No.", Rec."Variant Code", PurchaseHdr."No.", Companies.Name);
                end;
            until Companies.Next() = 0;
        end;
    end; */

    //26-09-2022-start
#pragma warning disable AL0432 // TODO: - Will removed once it will be removed from base app 26-09-2022
    //31-12-2024-NS
    /* [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Price Calc. Mgt.", 'OnAfterFindSalesLinePrice', '', false, false)]
   local procedure OnAfterFindSalesLinePrice(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; var SalesPrice: Record "Price List Line"; var ResourcePrice: Record "Resource Price"; CalledByFieldNo: Integer; FoundSalesPrice: Boolean);
   var
       CurrExchRate: Record "Currency Exchange Rate";
       GLSetup: Record "General Ledger Setup";
   begin
       if not (SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::"Blanket Order"]) then exit;
       GLSetup.GET;
       if SalesPrice."Minimum Selling Price" <> 0 then begin
           if SalesHeader."Currency Code" = '' then
               SalesLine."Initial Price" := CurrExchRate.ExchangeAmount(SalesPrice."Minimum Selling Price", SalesPrice."Currency 2", '', SalesHeader."Posting Date")
           else
               SalesLine."Initial Price" := CurrExchRate.ExchangeAmount(SalesPrice."Minimum Selling Price", SalesPrice."Currency 2", SalesHeader."Currency Code", SalesHeader."Posting Date");
       end
       else begin
           if SalesHeader."Currency Code" = '' then
               SalesLine."Initial Price" := CurrExchRate.ExchangeAmount(SalesPrice."Unit Price 2", SalesPrice."Currency 2", '', SalesHeader."Posting Date")
           else
               SalesLine."Initial Price" := CurrExchRate.ExchangeAmount(SalesPrice."Unit Price 2", SalesPrice."Currency 2", SalesHeader."Currency Code", SalesHeader."Posting Date");
       end;

       if SalesHeader."Currency Code" = '' then
           SalesLine.Validate("Selling Price", CurrExchRate.ExchangeAmount(SalesPrice."Unit Price 2", SalesPrice."Currency 2", '', SalesHeader."Posting Date"))
       else
           SalesLine.Validate("Selling Price", CurrExchRate.ExchangeAmount(SalesPrice."Unit Price 2", SalesPrice."Currency 2", SalesHeader."Currency Code", SalesHeader."Posting Date"));
       SalesLine."Unit Price Difference" := SalesLine."Unit Price Base UOM 2" - SalesLine."Selling Price";
       UpdateSalesPricePriceChangePercentage(SalesLine, SalesPrice);
   end; */
    //31-12-2024-NE T12937
    //T12937-NS 31-12-2024
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Line - Price", OnAfterSetPrice, '', false, false)]
    local procedure "Sales Line - Price_OnAfterSetPrice"(var SalesLine: Record "Sales Line"; PriceListLine: Record "Price List Line"; AmountType: Enum "Price Amount Type"; var SalesHeader: Record "Sales Header")
    Var
        CurrExchRate: Record "Currency Exchange Rate";
        GLSetup: Record "General Ledger Setup";
    begin
        // if not (SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::"Blanket Order"]) then exit;//AS- 31-12-24
        GLSetup.GET;
        if PriceListLine."Minimum Selling Price" <> 0 then begin
            if SalesHeader."Currency Code" = '' then
                SalesLine."Initial Price" := CurrExchRate.ExchangeAmount(PriceListLine."Minimum Selling Price", PriceListLine."Currency 2", '', SalesHeader."Posting Date")//AS- 07-01-25 Hyper care Support
            else
                SalesLine."Initial Price" := CurrExchRate.ExchangeAmount(PriceListLine."Minimum Selling Price", PriceListLine."Currency 2", SalesHeader."Currency Code", SalesHeader."Posting Date");
        end
        else begin
            if SalesHeader."Currency Code" = '' then
                SalesLine."Initial Price" := CurrExchRate.ExchangeAmount(PriceListLine."Unit Price 2", PriceListLine."Currency 2", '', SalesHeader."Posting Date")
            else
                SalesLine."Initial Price" := CurrExchRate.ExchangeAmount(PriceListLine."Unit Price 2", PriceListLine."Currency 2", SalesHeader."Currency Code", SalesHeader."Posting Date");
        end;

        if SalesHeader."Currency Code" = '' then
            SalesLine.Validate("Selling Price", CurrExchRate.ExchangeAmount(PriceListLine."Unit Price 2", PriceListLine."Currency 2", '', SalesHeader."Posting Date"))
        else
            SalesLine.Validate("Selling Price", CurrExchRate.ExchangeAmount(PriceListLine."Unit Price 2", PriceListLine."Currency 2", SalesHeader."Currency Code", SalesHeader."Posting Date"));
        SalesLine."Unit Price Difference" := SalesLine."Unit Price Base UOM 2" - SalesLine."Selling Price";
        UpdateSalesPricePriceChangePercentage(SalesLine, PriceListLine);
    end;
    //T12937-NE 31-12-2024


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", 'OnBeforeInsertSalesOrderLine', '', false, false)]
    local procedure OnBeforeInsertSalesOrderLine(var SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; BlanketOrderSalesLine: Record "Sales Line"; BlanketOrderSalesHeader: Record "Sales Header");
    var
        Recitem: Record Item;
        RecSalesPrice: Record "Price List Line";//31-12-2024
        CurrExchRate: Record "Currency Exchange Rate";
        GLSetup: Record "General Ledger Setup";
    begin
        if SalesOrderLine.Type = SalesOrderLine.Type::Item then begin
            if SalesOrderLine."No." <> '' then begin
                GLSetup.GET;
                Clear(Recitem);
                Recitem.GET(SalesOrderLine."No.");
                SalesOrderLine."Item Incentive Point (IIP)" := Recitem."Item Incentive Ratio (IIR)";
                Clear(RecSalesPrice);
                RecSalesPrice.SetRange("Asset No.", SalesOrderLine."No.");
                if RecSalesPrice.FindFirst() then begin
                    if RecSalesPrice."Minimum Selling Price" <> 0 then begin
                        if SalesOrderHeader."Currency Code" = '' then
                            SalesOrderLine."Initial Price" := CurrExchRate.ExchangeAmount(RecSalesPrice."Minimum Selling Price", RecSalesPrice."Currency 2", '', SalesOrderHeader."Posting Date")
                        else
                            SalesOrderLine."Initial Price" := CurrExchRate.ExchangeAmount(RecSalesPrice."Minimum Selling Price", RecSalesPrice."Currency 2", SalesOrderHeader."Currency Code", SalesOrderHeader."Posting Date");
                    end else begin
                        if SalesOrderHeader."Currency Code" = '' then
                            SalesOrderLine."Initial Price" := CurrExchRate.ExchangeAmount(RecSalesPrice."Unit Price 2", RecSalesPrice."Currency 2", '', SalesOrderHeader."Posting Date")
                        else
                            SalesOrderLine."Initial Price" := CurrExchRate.ExchangeAmount(RecSalesPrice."Unit Price 2", RecSalesPrice."Currency 2", SalesOrderHeader."Currency Code", SalesOrderHeader."Posting Date");
                    end;

                    if SalesOrderHeader."Currency Code" = '' then
                        SalesOrderLine.Validate("Selling Price", CurrExchRate.ExchangeAmount(RecSalesPrice."Unit Price 2", RecSalesPrice."Currency 2", '', SalesOrderHeader."Posting Date"))
                    else
                        SalesOrderLine.Validate("Selling Price", CurrExchRate.ExchangeAmount(RecSalesPrice."Unit Price 2", RecSalesPrice."Currency 2", SalesOrderHeader."Currency Code", SalesOrderHeader."Posting Date"));

                    SalesOrderLine."Unit Price Difference" := SalesOrderLine."Unit Price Base UOM 2" - SalesOrderLine."Selling Price";

                    UpdateSalesLinePriceChangePercentage(SalesOrderLine);
                end;
            end;
        end;
        // Evaluate(SalesOrderHeader."Excess Payment Terms Days", '0D');
    end;


    local procedure UpdateSalesLinePriceChangePercentage(var RecSline: Record "Sales Line")
    var
        myInt: Integer;
    begin
        if NOT (RecSline."Document Type" IN [RecSline."Document Type"::"Blanket Order", RecSline."Document Type"::Order, RecSline."Document Type"::Quote]) then exit;
        if RecSline.Type <> RecSline.Type::Item then exit;

        if RecSline."Initial Price" = 0 then begin
            RecSline."Price Change %" := 0;
            RecSline."Price Changed" := false;
            exit;
        end;

        if (RecSline."Initial Price" > RecSline."Unit Price Base UOM 2") AND (RecSline."Initial Price" <> 0) then begin
            RecSline."Price Changed" := true;
            RecSline."Price Change %" := ((RecSline."Unit Price Base UOM 2" - RecSline."Initial Price") / RecSline."Initial Price") * 100;

        end
        else begin
            if RecSline."Initial Price" <> 0 then
                RecSline."Price Changed" := false;
            RecSline."Price Change %" := ((RecSline."Unit Price Base UOM 2" - RecSline."Initial Price") / RecSline."Initial Price") * 100;
        end;
    end;

    local procedure UpdateSalesPricePriceChangePercentage(var RecSline: Record "Sales Line"; var SalesPrice: Record "Price List Line")//31-12-2024-Sales Price
    var
        myInt: Integer;
    begin
        if NOT (RecSline."Document Type" IN [RecSline."Document Type"::"Blanket Order", RecSline."Document Type"::Order, RecSline."Document Type"::Quote]) then exit;
        if RecSline.Type <> RecSline.Type::Item then exit;

        if RecSline."Initial Price" = 0 then begin
            RecSline."Price Change %" := 0;
            RecSline."Price Changed" := false;
            exit;
        end;

        if (RecSline."Initial Price" > SalesPrice."Unit Price 2") AND (RecSline."Initial Price" <> 0) then begin
            RecSline."Price Changed" := true;
            RecSline."Price Change %" := ((SalesPrice."Unit Price 2" - RecSline."Initial Price") / RecSline."Initial Price") * 100;

        end
        else begin
            if RecSline."Initial Price" <> 0 then
                RecSline."Price Changed" := false;
            RecSline."Price Change %" := ((SalesPrice."Unit Price 2" - RecSline."Initial Price") / RecSline."Initial Price") * 100;
        end;
    end;
#pragma warning restore AL0432 // TODO: - Will removed once it will be removed from base app 26-09-2022
    //26-09-2022-end

    /*[EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnModifyItems(var Rec: Record Item; var xRec: Record Item; RunTrigger: Boolean)
    var
        Companies: Record company;
        Recitem: Record Item;
    begin
        Rec.Blocked := true;
        Companies.SetFilter(Name, '<>%1', Rec.CurrentCompany);
        if Companies.FindSet() then begin
            repeat
                Clear(Recitem);
                Recitem.ChangeCompany(Companies.Name);
                if Recitem.GET(Rec."No.") then begin
                    Recitem.Blocked := true;
                    Recitem.Modify();
                end;
            until Companies.Next() = 0;
        end;
    end;*/

    [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnBeforeActionEvent', 'Approve', false, false)]
    local procedure OnBeforeAprove(var Rec: Record "Sales Header")
    var
        ApprovalEntry: Record "Approval Entry";
        ApproverRemarks: Page "Approver Remarks";
    begin
        if not Confirm('Do you want to add Approver Remarks?', false) then exit;
        clear(ApprovalEntry);
        ApprovalEntry.SetRange("Table ID", Rec.RecordId.TableNo);
        ApprovalEntry.SetRange("Record ID to Approve", Rec.RecordID);
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SetRange("Approver ID", UserId);
        if ApprovalEntry.FindFirst() then begin
            clear(ApproverRemarks);
            ApproverRemarks.LookupMode(true);
            ApproverRemarks.Editable := true;
            if ApproverRemarks.RunModal() IN [Action::OK, Action::LookupOK] then begin
                ApprovalEntry."Approver Remarks" := ApproverRemarks.GetRemarks();
                ApprovalEntry.Modify();
            end else
                Error('');
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Quote", 'OnBeforeActionEvent', 'Approve', false, false)]
    local procedure OnBeforeAproveSalesQuote(var Rec: Record "Sales Header")
    var
        ApprovalEntry: Record "Approval Entry";
        ApproverRemarks: Page "Approver Remarks";
    begin
        if not Confirm('Do you want to add Approver Remarks?', false) then exit;
        clear(ApprovalEntry);
        ApprovalEntry.SetRange("Table ID", Rec.RecordId.TableNo);
        ApprovalEntry.SetRange("Record ID to Approve", Rec.RecordID);
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SetRange("Approver ID", UserId);
        if ApprovalEntry.FindFirst() then begin
            clear(ApproverRemarks);
            ApproverRemarks.LookupMode(true);
            ApproverRemarks.Editable := true;
            if ApproverRemarks.RunModal() IN [Action::OK, Action::LookupOK] then begin
                ApprovalEntry."Approver Remarks" := ApproverRemarks.GetRemarks();
                ApprovalEntry.Modify();
            end else
                Error('');
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnBeforeActionEvent', 'Reject', false, false)]
    local procedure OnBeforeReject(var Rec: Record "Sales Header")
    var
        ApprovalEntry: Record "Approval Entry";
        ApproverRemarks: Page "Approver Remarks";
    begin
        if not Confirm('Do you want to add Approver Remarks?', false) then exit;
        clear(ApprovalEntry);
        ApprovalEntry.SetRange("Table ID", Rec.RecordId.TableNo);
        ApprovalEntry.SetRange("Record ID to Approve", Rec.RecordID);
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SetRange("Approver ID", UserId);
        if ApprovalEntry.FindFirst() then begin
            clear(ApproverRemarks);
            ApproverRemarks.LookupMode(true);
            ApproverRemarks.Editable := true;
            if ApproverRemarks.RunModal() IN [Action::OK, Action::LookupOK] then begin
                ApprovalEntry."Approver Remarks" := ApproverRemarks.GetRemarks();
                ApprovalEntry.Modify();
            end else
                Error('');
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Quote", 'OnBeforeActionEvent', 'Reject', false, false)]
    local procedure OnBeforeRejectSalesQuote(var Rec: Record "Sales Header")
    var
        ApprovalEntry: Record "Approval Entry";
        ApproverRemarks: Page "Approver Remarks";
    begin
        if not Confirm('Do you want to add Approver Remarks?', false) then exit;
        clear(ApprovalEntry);
        ApprovalEntry.SetRange("Table ID", Rec.RecordId.TableNo);
        ApprovalEntry.SetRange("Record ID to Approve", Rec.RecordID);
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SetRange("Approver ID", UserId);
        if ApprovalEntry.FindFirst() then begin
            clear(ApproverRemarks);
            ApproverRemarks.LookupMode(true);
            ApproverRemarks.Editable := true;
            if ApproverRemarks.RunModal() IN [Action::OK, Action::LookupOK] then begin
                ApprovalEntry."Approver Remarks" := ApproverRemarks.GetRemarks();
                ApprovalEntry.Modify();
            end else
                Error('');
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Requests to Approve", 'OnBeforeActionEvent', 'Approve', false, false)]
    local procedure OnBeforeApprove_ReqToApprove(var Rec: Record "Approval Entry")
    var
        ApprovalEntry: Record "Approval Entry";
        ApproverRemarks: Page "Approver Remarks";
    begin
        if Rec."Table ID" <> Database::"Sales Header" then exit;
        if not Confirm('Do you want to add Approver Remarks?', false) then exit;
        Clear(ApprovalEntry);
        ApprovalEntry.SetRange("Entry No.", Rec."Entry No.");
        If ApprovalEntry.FindFirst() then begin
            clear(ApproverRemarks);
            ApproverRemarks.LookupMode(true);
            ApproverRemarks.Editable := true;
            if ApproverRemarks.RunModal() IN [Action::OK, Action::LookupOK] then begin
                ApprovalEntry."Approver Remarks" := ApproverRemarks.GetRemarks();
                ApprovalEntry.Modify();
            end else
                Error('');
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Requests to Approve", 'OnBeforeActionEvent', 'Reject', false, false)]
    local procedure OnBeforeReject_ReqToApprove(var Rec: Record "Approval Entry")
    var
        ApprovalEntry: Record "Approval Entry";
        ApproverRemarks: Page "Approver Remarks";
    begin
        if Rec."Table ID" <> Database::"Sales Header" then exit;
        if not Confirm('Do you want to add Approver Remarks?', false) then exit;
        Clear(ApprovalEntry);
        ApprovalEntry.SetRange("Entry No.", Rec."Entry No.");
        If ApprovalEntry.FindFirst() then begin
            clear(ApproverRemarks);
            ApproverRemarks.LookupMode(true);
            ApproverRemarks.Editable := true;
            if ApproverRemarks.RunModal() IN [Action::OK, Action::LookupOK] then begin
                ApprovalEntry."Approver Remarks" := ApproverRemarks.GetRemarks();
                ApprovalEntry.Modify();
            end else
                Error('');
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeValidateEvent', 'Salesperson Code', false, false)]
    local procedure ValidateStatusBeforeChanging(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    begin
        if not (Rec."Document Type" IN [Rec."Document Type"::"Blanket Order", Rec."Document Type"::Order]) then exit;
        Rec.TestField(Status, Rec.Status::Open);
    end;

    //22-10-2022-start
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeValidateBuyFromVendorNo', '', false, false)]
    local procedure OnBeforeValidateBuyFromVendorNo(var PurchaseHeader: Record "Purchase Header"; xPurchaseHeader: Record "Purchase Header"; CallingFieldNo: Integer; var SkipBuyFromContact: Boolean);
    var
        RecVendor: Record Vendor;
        SnRSetup: Record "Sales & Receivables Setup";
    begin
        // If item blocked is no and purchase blocked is yes, then allowed to create IC PO 
        SnRSetup.GET;
        If not SnRSetup."Block Non IC Vendor in PO" then exit;
        If PurchaseHeader.GetHideValidationDialog() then exit;
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
            if PurchaseHeader."Buy-from Vendor No." <> '' then begin
                Clear(RecVendor);
                RecVendor.GET(PurchaseHeader."Buy-from Vendor No.");
                if (RecVendor."IC Partner Code" = '') AND (RecVendor."IC Company Code" = '') then begin
                    Error('You cannot create Purchase Order for non IC vendors. Vendor No. %1', RecVendor."No.");
                end;
            end;
        end;
    end;
    //22-10-22-end

    //26-10-2022-start
    [EventSubscriber(ObjectType::Page, Page::"Blanket Sales Order", 'OnBeforeActionEvent', 'Approve', false, false)]
    local procedure OnBeforeAprove_BSO(var Rec: Record "Sales Header")
    var
        ApprovalEntry: Record "Approval Entry";
        ApproverRemarks: Page "Approver Remarks";
    begin
        if not Confirm('Do you want to add Approver Remarks?', false) then exit;
        clear(ApprovalEntry);
        ApprovalEntry.SetRange("Table ID", Rec.RecordId.TableNo);
        ApprovalEntry.SetRange("Record ID to Approve", Rec.RecordID);
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SetRange("Approver ID", UserId);
        if ApprovalEntry.FindFirst() then begin
            clear(ApproverRemarks);
            ApproverRemarks.LookupMode(true);
            ApproverRemarks.Editable := true;
            if ApproverRemarks.RunModal() IN [Action::OK, Action::LookupOK] then begin
                ApprovalEntry."Approver Remarks" := ApproverRemarks.GetRemarks();
                ApprovalEntry.Modify();
            end else
                Error('');
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Blanket Sales Order", 'OnBeforeActionEvent', 'Reject', false, false)]
    local procedure OnBeforeReject_BSO(var Rec: Record "Sales Header")
    var
        ApprovalEntry: Record "Approval Entry";
        ApproverRemarks: Page "Approver Remarks";
    begin
        if not Confirm('Do you want to add Approver Remarks?', false) then exit;
        clear(ApprovalEntry);
        ApprovalEntry.SetRange("Table ID", Rec.RecordId.TableNo);
        ApprovalEntry.SetRange("Record ID to Approve", Rec.RecordID);
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SetRange("Approver ID", UserId);
        if ApprovalEntry.FindFirst() then begin
            clear(ApproverRemarks);
            ApproverRemarks.LookupMode(true);
            ApproverRemarks.Editable := true;
            if ApproverRemarks.RunModal() IN [Action::OK, Action::LookupOK] then begin
                ApprovalEntry."Approver Remarks" := ApproverRemarks.GetRemarks();
                ApprovalEntry.Modify();
            end else
                Error('');
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Blanket Sales Order", 'OnAfterActionEvent', 'CancelApprovalRequest', false, false)]
    local procedure CancelBSOApproval(var Rec: Record "Sales Header")
    begin
        ResetStatus(Rec);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnAfterActionEvent', 'CancelApprovalRequest', false, false)]
    local procedure CancelSOApproval(var Rec: Record "Sales Header")
    begin
        ResetStatus(Rec);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Quote", 'OnAfterActionEvent', 'CancelApprovalRequest', false, false)]
    local procedure CancelSOApprovalSQ(var Rec: Record "Sales Header")
    begin
        ResetStatus(Rec);
    end;

    //T50307-NS
    [EventSubscriber(ObjectType::Page, Page::"Sales Return Order", 'OnAfterActionEvent', 'CancelApprovalRequest', false, false)]
    local procedure CancelApprovalSRO(var Rec: Record "Sales Header")
    begin
        ResetStatus(Rec);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Return Order", 'OnBeforeActionEvent', 'Approve', false, false)]
    local procedure OnBeforeAprove_SRP(var Rec: Record "Sales Header")
    var
        ApprovalEntry: Record "Approval Entry";
        ApproverRemarks: Page "Approver Remarks";
    begin
        if not Confirm('Do you want to add Approver Remarks?', false) then exit;
        clear(ApprovalEntry);
        ApprovalEntry.SetRange("Table ID", Rec.RecordId.TableNo);
        ApprovalEntry.SetRange("Record ID to Approve", Rec.RecordID);
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SetRange("Approver ID", UserId);
        if ApprovalEntry.FindFirst() then begin
            clear(ApproverRemarks);
            ApproverRemarks.LookupMode(true);
            ApproverRemarks.Editable := true;
            if ApproverRemarks.RunModal() IN [Action::OK, Action::LookupOK] then begin
                ApprovalEntry."Approver Remarks" := ApproverRemarks.GetRemarks();
                ApprovalEntry.Modify();
            end else
                Error('');
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Return Order", 'OnBeforeActionEvent', 'Reject', false, false)]
    local procedure OnBeforeRejectSRO(var Rec: Record "Sales Header")
    var
        ApprovalEntry: Record "Approval Entry";
        ApproverRemarks: Page "Approver Remarks";
    begin
        if not Confirm('Do you want to add Approver Remarks?', false) then exit;
        clear(ApprovalEntry);
        ApprovalEntry.SetRange("Table ID", Rec.RecordId.TableNo);
        ApprovalEntry.SetRange("Record ID to Approve", Rec.RecordID);
        ApprovalEntry.SetRange(Status, ApprovalEntry.Status::Open);
        ApprovalEntry.SetRange("Approver ID", UserId);
        if ApprovalEntry.FindFirst() then begin
            clear(ApproverRemarks);
            ApproverRemarks.LookupMode(true);
            ApproverRemarks.Editable := true;
            if ApproverRemarks.RunModal() IN [Action::OK, Action::LookupOK] then begin
                ApprovalEntry."Approver Remarks" := ApproverRemarks.GetRemarks();
                ApprovalEntry.Modify();
            end else
                Error('');
        end;
    end;
    //T50307-NE

    procedure ResetStatus(var Rec: Record "Sales Header")
    var
        RecApprovalEntry: Record "Approval Entry";
        RecHDr: Record "Sales Header";
    begin
        Clear(RecApprovalEntry);
        RecApprovalEntry.SetCurrentKey("Entry No.");
        RecApprovalEntry.SetAscending("Entry No.", false);
        RecApprovalEntry.SetRange("Table ID", Database::"Sales Header");
        RecApprovalEntry.SetRange("Document Type", Rec."Document Type");
        RecApprovalEntry.SetRange("Document No.", Rec."No.");
        RecApprovalEntry.SetRange("Record ID to Approve", Rec.RecordId);
        RecApprovalEntry.SetFilter(Status, '%1|%2', RecApprovalEntry.Status::Created, RecApprovalEntry.Status::Open);
        if RecApprovalEntry.FindSet() then begin
            repeat
                RecApprovalEntry.Status := RecApprovalEntry.Status::Canceled;
                RecApprovalEntry.Modify();
            until RecApprovalEntry.Next() = 0;

            IF RecHDr."Document Type" = RecHDr."Document Type"::Quote THen begin
                Clear(RecHDr);
                RecHDr.SetRange("Document Type", Rec."Document Type");
                RecHDr.SetRange("No.", Rec."No.");
                if RecHDr.FindFirst() then begin
                    RecHDr.Status := RecHDr.Status::Open;
                    RecHDr.Modify();
                end;
            End;
        end;
    end;
    //26-10-2022-end
}