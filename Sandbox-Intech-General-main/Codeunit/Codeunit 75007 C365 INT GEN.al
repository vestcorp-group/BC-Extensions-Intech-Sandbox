Codeunit 75007 "C365_INT_GEN"
{
    //Format_Address

    trigger OnRun()
    begin
    end;

    var
        Vendor_gRec: Record Vendor;
        State_gRec: Record State;
        StateName_gTxt: Text[50];
        Location_gRec: Record Location;
        FormatAddr_gCdu: Codeunit "Format Address";


    procedure Location_gFnc(var AddrArray_iTxtArr: array[8] of Text[50]; var Location_iRec: Record Location)
    begin
        //I-C0059-1005708-01-NS
        if State_gRec.Get(Location_iRec."State Code") then
            StateName_gTxt := State_gRec.Description;
        FormatAddr_gCdu.FormatAddr(
  AddrArray_iTxtArr, Location_iRec.Name, Location_iRec."Name 2", '', Location_iRec.Address, Location_iRec."Address 2",
  Location_iRec.City, Location_iRec."Post Code", StateName_gTxt, Location_iRec."Country/Region Code");
        StateName_gTxt := '';
        //I-C0059-1005708-01-NE
    end;


    procedure OrderAddress_gFnc(var AddrArray: array[8] of Text[50]; var OrderAddress: Record "Order Address")
    begin
        //T23019-NS
        FormatAddr_gCdu.FormatAddr(
  AddrArray, OrderAddress.Name, OrderAddress."Name 2", '', OrderAddress.Address, OrderAddress."Address 2",
  OrderAddress.City, OrderAddress."Post Code", '', OrderAddress."Country/Region Code");
        //T23019-NE
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeCompany', '', false, false)]
    local procedure OnBeforeCompany(var AddrArray: array[8] of Text[100]; var CompanyInfo: Record "Company Information"; var IsHandled: Boolean);
    begin
        // IF CompanyInfo.County = '' Then begin
        //     IF State_gRec.GET(CompanyInfo."State Code") THEN
        //         CompanyInfo.County := State_gRec.Description;
        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeCustomer', '', false, false)]
    local procedure OnBeforeCustomer(var AddrArray: array[8] of Text[100]; var Cust: Record Customer; var Handled: Boolean);
    begin
        IF Cust.County = '' Then begin
            IF State_gRec.GET(Cust."State Code") THEN
                Cust.County := State_gRec.Description;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeVendor', '', false, false)]
    local procedure OnBeforeVendor(var AddrArray: array[8] of Text[100]; var Vendor: Record Vendor; var Handled: Boolean);
    begin
        IF Vendor.County = '' Then begin
            IF State_gRec.GET(Vendor."State Code") THEN
                Vendor.County := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeBankAcc', '', false, false)]
    local procedure OnBeforeBankAcc(var AddrArray: array[8] of Text[100]; var BankAccount: Record "Bank Account"; var IsHandled: Boolean);
    begin
        IF BankAccount.County = '' Then begin
            IF State_gRec.GET(BankAccount."State Code") THEN
                BankAccount.County := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesHeaderSellTo', '', false, false)]
    local procedure OnBeforeSalesHeaderSellTo(var AddrArray: array[8] of Text[100]; var SalesHeader: Record "Sales Header"; var Handled: Boolean);
    begin
        IF SalesHeader."Sell-to County" = '' Then begin
            IF State_gRec.GET(SalesHeader."State") THEN
                SalesHeader."Sell-to County" := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesHeaderBillTo', '', false, false)]
    local procedure OnBeforeSalesHeaderBillTo(var AddrArray: array[8] of Text[100]; var SalesHeader: Record "Sales Header"; var Handled: Boolean);
    begin
        IF SalesHeader."Bill-to County" = '' Then begin
            IF State_gRec.GET(SalesHeader."State") THEN
                SalesHeader."Bill-to County" := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesHeaderShipTo', '', false, false)]
    local procedure OnBeforeSalesHeaderShipTo(var AddrArray: array[8] of Text[100]; var CustAddr: array[8] of Text[100]; var SalesHeader: Record "Sales Header"; var Handled: Boolean; var Result: Boolean);
    begin
        IF SalesHeader."Ship-to County" = '' Then begin
            IF State_gRec.GET(SalesHeader."State") THEN
                SalesHeader."Ship-to County" := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchHeaderBuyFrom', '', false, false)]
    local procedure OnBeforePurchHeaderBuyFrom(var AddrArray: array[8] of Text[100]; var PurchaseHeader: Record "Purchase Header"; var Handled: Boolean);
    begin
        // IF PurchaseHeader."Buy-from County" = '' Then begin
        //     IF State_gRec.GET(PurchaseHeader."State") THEN
        //         PurchaseHeader."Buy-from County" := State_gRec.Description;
        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchHeaderPayTo', '', false, false)]
    local procedure OnBeforePurchHeaderPayTo(var AddrArray: array[8] of Text[100]; var PurchaseHeader: Record "Purchase Header"; var Handled: Boolean);
    begin
        // IF PurchaseHeader."Pay-to County" = '' Then begin
        //     IF State_gRec.GET(PurchaseHeader."State") THEN
        //         PurchaseHeader."Pay-to County" := State_gRec.Description;
        // end;
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchHeaderShipTo', '', false, false)]
    // local procedure OnBeforePurchHeaderShipTo(var AddrArray: array[8] of Text[100]; var PurchaseHeader: Record "Purchase Header"; var IsHandled: Boolean);
    // begin
    //     IF PurchaseHeader."Ship-to County" = '' Then begin
    //         IF State_gRec.GET(PurchaseHeader."State") THEN
    //             PurchaseHeader."Ship-to County" := State_gRec.Description;
    //     end;
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesShptSellTo', '', false, false)]
    local procedure OnBeforeSalesShptSellTo(var AddrArray: array[8] of Text[100]; var SalesShipmentHeader: Record "Sales Shipment Header"; var Handled: Boolean);
    begin
        IF SalesShipmentHeader."Sell-to County" = '' Then begin
            IF State_gRec.GET(SalesShipmentHeader."State") THEN
                SalesShipmentHeader."Sell-to County" := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesShptBillTo', '', false, false)]
    local procedure OnBeforeSalesShptBillTo(var AddrArray: array[8] of Text[100]; var ShipToAddr: array[8] of Text[100]; var SalesShipmentHeader: Record "Sales Shipment Header"; var Handled: Boolean; var Result: Boolean);
    begin
        IF SalesShipmentHeader."Bill-to County" = '' Then begin
            IF State_gRec.GET(SalesShipmentHeader."State") THEN
                SalesShipmentHeader."Bill-to County" := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesShptShipTo', '', false, false)]
    local procedure OnBeforeSalesShptShipTo(var AddrArray: array[8] of Text[100]; var SalesShipmentHeader: Record "Sales Shipment Header"; var Handled: Boolean);
    begin
        IF SalesShipmentHeader."Ship-to County" = '' Then begin
            IF State_gRec.GET(SalesShipmentHeader."State") THEN
                SalesShipmentHeader."Ship-to County" := State_gRec.Description;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesInvSellTo', '', false, false)]
    local procedure OnBeforeSalesInvSellTo(var AddrArray: array[8] of Text[100]; var SalesInvoiceHeader: Record "Sales Invoice Header"; var Handled: Boolean);
    begin
        IF SalesInvoiceHeader."Sell-to County" = '' Then begin
            IF State_gRec.GET(SalesInvoiceHeader."State") THEN
                SalesInvoiceHeader."Sell-to County" := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesInvBillTo', '', false, false)]
    local procedure OnBeforeSalesInvBillTo(var AddrArray: array[8] of Text[100]; var SalesInvHeader: Record "Sales Invoice Header"; var Handled: Boolean);
    begin
        // IF SalesInvHeader."Bill-to County" = '' Then begin
        //     IF State_gRec.GET(SalesInvHeader."State") THEN
        //         SalesInvHeader."Bill-to County" := State_gRec.Description;
        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesInvShipTo', '', false, false)]
    local procedure OnBeforeSalesInvShipTo(var AddrArray: array[8] of Text[100]; var SalesInvHeader: Record "Sales Invoice Header"; var Handled: Boolean; var Result: Boolean; var CustAddr: array[8] of Text[100]);
    begin
        // IF SalesInvHeader."Ship-to County" = '' Then begin
        //     IF State_gRec.GET(SalesInvHeader."State") THEN
        //         SalesInvHeader."Ship-to County" := State_gRec.Description;
        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesCrMemoSellTo', '', false, false)]
    local procedure OnBeforeSalesCrMemoSellTo(var AddrArray: array[8] of Text[100]; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var Handled: Boolean);
    begin
        IF SalesCrMemoHeader."Sell-to County" = '' Then begin
            IF State_gRec.GET(SalesCrMemoHeader."State") THEN
                SalesCrMemoHeader."Sell-to County" := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesCrMemoBillTo', '', false, false)]
    local procedure OnBeforeSalesCrMemoBillTo(var AddrArray: array[8] of Text[100]; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var Handled: Boolean);
    begin
        // IF SalesCrMemoHeader."Bill-to County" = '' Then begin
        //     IF State_gRec.GET(SalesCrMemoHeader."State") THEN
        //         SalesCrMemoHeader."Bill-to County" := State_gRec.Description;

        if SalesCrMemoHeader."GST Bill-to State Code" <> '' then begin
            if State_gRec.Get(SalesCrMemoHeader."GST Bill-to State Code") then
                SalesCrMemoHeader."Bill-to County" := State_gRec.Description;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesCrMemoShipTo', '', false, false)]
    local procedure OnBeforeSalesCrMemoShipTo(var AddrArray: array[8] of Text[100]; var CustAddr: array[8] of Text[100]; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var Handled: Boolean; var Result: Boolean);
    begin
        // IF SalesCrMemoHeader."Ship-to County" = '' Then begin
        //     IF State_gRec.GET(SalesCrMemoHeader."State") THEN
        //         SalesCrMemoHeader."Ship-to County" := State_gRec.Description;
        // end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesRcptSellTo', '', false, false)]
    local procedure OnBeforeSalesRcptSellTo(var AddrArray: array[8] of Text[100]; var ReturnRcptHeader: Record "Return Receipt Header"; var IsHandled: Boolean);
    var
        Customer: Record Customer;
    begin
        IF ReturnRcptHeader."Sell-to County" = '' Then begin
            If Customer.GET(ReturnRcptHeader."Sell-to Customer No.") then
                If State_gRec.GET(Customer."State Code") then
                    ReturnRcptHeader."Sell-to County" := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesRcptBillTo', '', false, false)]
    local procedure OnBeforeSalesRcptBillTo(var AddrArray: array[8] of Text[100]; var ShipToAddr: array[8] of Text[100]; var ReturnRcptHeader: Record "Return Receipt Header"; var IsHandled: Boolean; var Result: Boolean);
    var
        Customer: Record Customer;
    begin
        IF ReturnRcptHeader."Bill-to County" = '' Then begin
            If Customer.GET(ReturnRcptHeader."Bill-to Customer No.") then
                If State_gRec.GET(Customer."State Code") then
                    ReturnRcptHeader."Bill-to County" := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesRcptShipTo', '', false, false)]
    local procedure OnBeforeSalesRcptShipTo(var AddrArray: array[8] of Text[100]; var ReturnRcptHeader: Record "Return Receipt Header"; var IsHandled: Boolean);
    var
        Customer: Record Customer;
    begin
        IF ReturnRcptHeader."Ship-to County" = '' Then begin
            If Customer.GET(ReturnRcptHeader."Sell-to Customer No.") then
                If State_gRec.GET(Customer."State Code") then
                    ReturnRcptHeader."Ship-to County" := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchRcptBuyFrom', '', false, false)]
    local procedure OnBeforePurchRcptBuyFrom(var AddrArray: array[8] of Text[100]; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var IsHandled: Boolean);
    begin
        IF PurchRcptHeader."Buy-from County" = '' Then begin
            If State_gRec.GET(PurchRcptHeader."Location State Code") then
                PurchRcptHeader."Buy-from County" := State_gRec.Description;
        end;
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchRcptPayTo', '', false, false)]
    // local procedure OnBeforePurchRcptPayTo(var AddrArray: array[8] of Text[100]; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var IsHandled: Boolean);
    // begin
    //     IF PurchRcptHeader."Pay-to County" = '' Then begin
    //         If State_gRec.GET(PurchRcptHeader."Location State Code") then
    //             PurchRcptHeader."Pay-to County" := State_gRec.Description;
    //     end;
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchRcptShipTo', '', false, false)]
    local procedure OnBeforePurchRcptShipTo(var AddrArray: array[8] of Text[100]; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var IsHandled: Boolean);
    begin
        IF PurchRcptHeader."Ship-to County" = '' Then begin
            If State_gRec.GET(PurchRcptHeader."Location State Code") then
                PurchRcptHeader."Ship-to County" := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchInvBuyFrom', '', false, false)]
    local procedure OnBeforePurchInvBuyFrom(var AddrArray: array[8] of Text[100]; var PurchInvHeader: Record "Purch. Inv. Header"; var IsHandled: Boolean);
    begin
        // IF PurchInvHeader."Buy-from County" = '' Then begin
        //     If State_gRec.GET(PurchInvHeader."Location State Code") then
        //         PurchInvHeader."Buy-from County" := State_gRec.Description;
        // end;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchInvPayTo', '', false, false)]
    local procedure OnBeforePurchInvPayTo(var AddrArray: array[8] of Text[100]; var PurchInvHeader: Record "Purch. Inv. Header"; var IsHandled: Boolean);
    begin
        // IF PurchInvHeader."Pay-to County" = '' Then begin
        //     If State_gRec.GET(PurchInvHeader."Location State Code") then
        //         PurchInvHeader."Pay-to County" := State_gRec.Description;
        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchInvShipTo', '', false, false)]
    local procedure OnBeforePurchInvShipTo(var AddrArray: array[8] of Text[100]; var PurchInvHeader: Record "Purch. Inv. Header"; var IsHandled: Boolean);
    begin
        // IF PurchInvHeader."Ship-to County" = '' Then begin
        //     If State_gRec.GET(PurchInvHeader."Location State Code") then
        //         PurchInvHeader."Ship-to County" := State_gRec.Description;
        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchCrMemoBuyFrom', '', false, false)]
    local procedure OnBeforePurchCrMemoBuyFrom(var AddrArray: array[8] of Text[100]; var PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr."; var IsHandled: Boolean);
    begin
        // IF PurchCrMemoHeader."Buy-from County" = '' Then begin
        //     If State_gRec.GET(PurchCrMemoHeader."Location State Code") then
        //         PurchCrMemoHeader."Buy-from County" := State_gRec.Description;
        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchCrMemoPayTo', '', false, false)]
    local procedure OnBeforePurchCrMemoPayTo(var AddrArray: array[8] of Text[100]; var PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr."; var IsHandled: Boolean);
    begin
        // IF PurchCrMemoHeader."Pay-to County" = '' Then begin
        //     If State_gRec.GET(PurchCrMemoHeader."Location State Code") then
        //         PurchCrMemoHeader."Pay-to County" := State_gRec.Description;
        // end;
        // Vendor_gRec.Reset;
        // if Vendor_gRec.Get(PurchCrMemoHeader."Sell-to Customer No.") then begin
        //     IF PurchCrMemoHeader."Pay-to County" = '' Then begin
        //         if Vendor_gRec."State Code" <> '' then begin
        //             if State_gRec.Get(Vendor_gRec."State Code") then
        //                 PurchCrMemoHeader."Pay-to County" := State_gRec.Description;
        //         end;
        //     end;
        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchCrMemoShipTo', '', false, false)]
    local procedure OnBeforePurchCrMemoShipTo(var AddrArray: array[8] of Text[100]; var PurchCrMemoHeader: Record "Purch. Cr. Memo Hdr."; var IsHandled: Boolean);
    begin
        // IF PurchCrMemoHeader."Ship-to County" = '' Then begin
        //     If State_gRec.GET(PurchCrMemoHeader."Location State Code") then
        //         PurchCrMemoHeader."Ship-to County" := State_gRec.Description;
        // end;
        // Vendor_gRec.Reset;
        // if Vendor_gRec.Get(PurchCrMemoHeader."Sell-to Customer No.") then begin
        //     IF PurchCrMemoHeader."Ship-to County" = '' Then begin
        //         if Vendor_gRec."State Code" <> '' then begin
        //             if State_gRec.Get(Vendor_gRec."State Code") then
        //                 PurchCrMemoHeader."Ship-to County" := State_gRec.Description;
        //         end;
        //     end;
        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchShptBuyFrom', '', false, false)]
    local procedure OnBeforePurchShptBuyFrom(var AddrArray: array[8] of Text[100]; var ReturnShptHeader: Record "Return Shipment Header"; var IsHandled: Boolean);
    var
        Customer: Record Customer;
    begin
        IF ReturnShptHeader."Buy-from County" = '' Then begin
            If Customer.GET(ReturnShptHeader."Sell-to Customer No.") then
                If State_gRec.GET(Customer."State Code") then
                    ReturnShptHeader."Buy-from County" := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchShptPayTo', '', false, false)]
    local procedure OnBeforePurchShptPayTo(var AddrArray: array[8] of Text[100]; var ReturnShptHeader: Record "Return Shipment Header"; var IsHandled: Boolean);
    var
        Customer: Record Customer;
    begin
        IF ReturnShptHeader."Pay-to County" = '' Then begin
            If Customer.GET(ReturnShptHeader."Sell-to Customer No.") then
                If State_gRec.GET(Customer."State Code") then
                    ReturnShptHeader."Pay-to County" := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchShptShipTo', '', false, false)]
    local procedure OnBeforePurchShptShipTo(var AddrArray: array[8] of Text[100]; var ReturnShptHeader: Record "Return Shipment Header"; var IsHandled: Boolean);
    var
        Customer: Record Customer;
    begin
        IF ReturnShptHeader."Ship-to County" = '' Then begin
            If Customer.GET(ReturnShptHeader."Sell-to Customer No.") then
                If State_gRec.GET(Customer."State Code") then
                    ReturnShptHeader."Ship-to County" := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeTransferShptTransferFrom', '', false, false)]
    local procedure OnBeforeTransferShptTransferFrom(var AddrArray: array[8] of Text[100]; var TransferShipmentHeader: Record "Transfer Shipment Header"; var IsHandled: Boolean);
    var
        Vendor: Record Vendor;
    begin
        IF TransferShipmentHeader."Transfer-from County" = '' Then begin
            If Vendor.GET(TransferShipmentHeader."Vendor No.") then
                If State_gRec.GET(Vendor."State Code") then
                    TransferShipmentHeader."Transfer-from County" := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeTransferShptTransferTo', '', false, false)]
    local procedure OnBeforeTransferShptTransferTo(var AddrArray: array[8] of Text[100]; var TransferShipmentHeader: Record "Transfer Shipment Header"; var IsHandled: Boolean);
    var
        Vendor: Record Vendor;
    begin
        IF TransferShipmentHeader."Transfer-to County" = '' Then begin
            If Vendor.GET(TransferShipmentHeader."Vendor No.") then
                If State_gRec.GET(Vendor."State Code") then
                    TransferShipmentHeader."Transfer-to County" := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeTransferRcptTransferFrom', '', false, false)]
    local procedure OnBeforeTransferRcptTransferFrom(var AddrArray: array[8] of Text[100]; var TransferReceiptHeader: Record "Transfer Receipt Header"; var IsHandled: Boolean);
    var
        Vendor: Record Vendor;
    begin
        IF TransferReceiptHeader."Transfer-from County" = '' Then begin
            If Vendor.GET(TransferReceiptHeader."Vendor No.") then
                If State_gRec.GET(Vendor."State Code") then
                    TransferReceiptHeader."Transfer-from County" := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeTransferHeaderTransferFrom', '', false, false)]
    local procedure OnBeforeTransferHeaderTransferFrom(var AddrArray: array[8] of Text[100]; var TransferHeader: Record "Transfer Header"; var IsHandled: Boolean);
    var
        Vendor: Record Vendor;
    begin
        IF TransferHeader."Transfer-from County" = '' Then begin
            If Vendor.GET(TransferHeader."Vendor No.") then
                If State_gRec.GET(Vendor."State Code") then
                    TransferHeader."Transfer-from County" := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeTransferHeaderTransferTo', '', false, false)]
    local procedure OnBeforeTransferHeaderTransferTo(var AddrArray: array[8] of Text[100]; var TransferHeader: Record "Transfer Header"; var IsHandled: Boolean);
    var
        Vendor: Record Vendor;
    begin
        IF TransferHeader."Transfer-To County" = '' Then begin
            If Vendor.GET(TransferHeader."Vendor No.") then
                If State_gRec.GET(Vendor."State Code") then
                    TransferHeader."Transfer-To County" := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesHeaderArchBillTo', '', false, false)]
    local procedure OnBeforeSalesHeaderArchBillTo(var AddrArray: array[8] of Text[100]; var SalesHeaderArch: Record "Sales Header Archive"; var Handled: Boolean);
    begin
        IF SalesHeaderArch."Bill-to County" = '' Then begin
            If State_gRec.GET(SalesHeaderArch."GST Bill-to State Code") then
                SalesHeaderArch."Bill-to County" := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforeSalesHeaderArchShipTo', '', false, false)]
    local procedure OnBeforeSalesHeaderArchShipTo(var AddrArray: array[8] of Text[100]; CustAddr: array[8] of Text[100]; var SalesHeaderArch: Record "Sales Header Archive"; var Handled: Boolean; var Result: Boolean);
    begin
        IF SalesHeaderArch."Ship-to County" = '' Then begin
            If State_gRec.GET(SalesHeaderArch."GST Ship-to State Code") then
                SalesHeaderArch."Ship-to County" := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchHeaderBuyFromArch', '', false, false)]
    local procedure OnBeforePurchHeaderBuyFromArch(var AddrArray: array[8] of Text[100]; var PurchHeaderArch: Record "Purchase Header Archive"; var Handled: Boolean);
    begin
        IF PurchHeaderArch."Buy-from County" = '' Then begin
            If State_gRec.GET(PurchHeaderArch."Location State Code") then
                PurchHeaderArch."Buy-from County" := State_gRec.Description;
        end;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchHeaderPayToArch', '', false, false)]
    local procedure OnBeforePurchHeaderPayToArch(var AddrArray: array[8] of Text[100]; var PurchHeaderArch: Record "Purchase Header Archive"; var Handled: Boolean);
    begin
        IF PurchHeaderArch."Pay-to County" = '' Then begin
            If State_gRec.GET(PurchHeaderArch."Location State Code") then
                PurchHeaderArch."Pay-to County" := State_gRec.Description;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Format Address", 'OnBeforePurchHeaderShipToArch', '', false, false)]
    local procedure OnBeforePurchHeaderShipToArch(var AddrArray: array[8] of Text[100]; var PurchHeaderArch: Record "Purchase Header Archive"; var Handled: Boolean);
    begin
        IF PurchHeaderArch."Ship-to County" = '' Then begin
            If State_gRec.GET(PurchHeaderArch."Location State Code") then
                PurchHeaderArch."Ship-to County" := State_gRec.Description;
        end;
    end;







}


