Codeunit 75015 "Sales/Purchase GST Mgt."
{
    //UpdateGSTDetail
    trigger OnRun()
    begin
    end;

    var
        Cust_gRec: Record Customer;
        Vendor_gRec: Record Vendor;
        GLAcc_gRec: Record "G/L Account";
        Item_gRec: Record Item;
        Resource_gRec: Record Resource;
        SalesSetup_gRec: Record "Sales & Receivables Setup";
        GSTGroup_gRec: Record "GST Group";
        FA_gRec: Record "Fixed Asset";
        ItemCharge_gRec: Record "Item Charge";
        Location_gRec: Record Location;
        PurchHeader_gRec: Record "Purchase Header";
        AssociatedEntErr: label 'You must select services only for Associated Enterprises.';
        TypeISDErr: label 'You must select %1 whose %2 is %3 when GST Input Service Distribution is checked.', Comment = '%1 = Type, %2 = Field Name, %3 = GST Group Type';
        Currency_gRec: Record Currency;
        ServHeader_gRec: Record "Service Header";
        ServiceMgtSetup: Record "Service Mgt. Setup";
        ServiceCost_gRec: Record "Service Cost";
        VendorISDErr: label 'You cannot select Input Service Distribution Location %1 for Vendor Types %2, %3, %4.', Comment = '%1 = Location Code, %2 = GST Vendor Type, %3 = GST Vendor Type, %4 = GST Vendor Type';


    procedure UpdateSalesDocument_gFnc(var SalesHeader_vRec: Record "Sales Header")
    var
        SalesLine_lRec: Record "Sales Line";
        Location_lRec: Record Location;
        ShipToAddr_lRec: Record "Ship-to Address";
    begin
        //Sell-to Customer No
        //IF "Sell-to Customer No." <> '' THEN BEGIN
        //  GSTManagement_gCdu.UpdateInvoiceType(SalesHeader_vRec);
        //END;
        //Bill-to Customer No
        if SalesHeader_vRec."Bill-to Customer No." <> '' then begin
            SalesGetCust_gFnc(SalesHeader_vRec, SalesHeader_vRec."Bill-to Customer No.");
            SalesHeader_vRec."GST Customer Type" := Cust_gRec."GST Customer Type";
            SalesHeader_vRec."GST Bill-to State Code" := '';
            SalesHeader_vRec."Customer GST Reg. No." := '';
            //  if SalesHeader_vRec."GST Customer Type" <> SalesHeader_vRec."gst customer type"::"0" then
            //    Cust_gRec.TestField(Address);

            if not (SalesHeader_vRec."GST Customer Type" in [SalesHeader_vRec."gst customer type"::Export, SalesHeader_vRec."gst customer type"::"Deemed Export",
                                            SalesHeader_vRec."gst customer type"::"SEZ Development", SalesHeader_vRec."gst customer type"::"SEZ Unit"])
            then
                SalesHeader_vRec."GST Bill-to State Code" := Cust_gRec."State Code";


            if not (SalesHeader_vRec."GST Customer Type" in [SalesHeader_vRec."gst customer type"::Export]) then
                SalesHeader_vRec."Customer GST Reg. No." := Cust_gRec."GST Registration No.";


            if SalesHeader_vRec."GST Customer Type" = SalesHeader_vRec."gst customer type"::Unregistered then
                SalesHeader_vRec."Nature of Supply" := SalesHeader_vRec."nature of supply"::B2C
            else
                SalesHeader_vRec."Nature of Supply" := SalesHeader_vRec."nature of supply"::B2B;
        end;

        //Ship-to Code
        SalesHeader_vRec."Ship-to GST Reg. No." := '';
        SalesHeader_vRec."GST Ship-to State Code" := '';

        if SalesHeader_vRec."GST Customer Type" <> SalesHeader_vRec."gst customer type"::" " then
            if not (SalesHeader_vRec."GST Customer Type" in [SalesHeader_vRec."gst customer type"::Export, SalesHeader_vRec."gst customer type"::"Deemed Export",
                                            SalesHeader_vRec."gst customer type"::"SEZ Development", SalesHeader_vRec."gst customer type"::"SEZ Unit",
                                            SalesHeader_vRec."gst customer type"::Unregistered])
            then begin
                if ShipToAddr_lRec.Get(SalesHeader_vRec."Sell-to Customer No.", SalesHeader_vRec."Ship-to Code") then begin
                    //if ShipToAddr_lRec."State Code(Export/SEZ)" = '' then  //ShipTOGST-N 123017
                    ShipToAddr_lRec.TestField(State);
                    ShipToAddr_lRec.TestField("GST Registration No.");
                    //if ShipToAddr_lRec."State Code(Export/SEZ)" = '' then  //ShipTOGST-N 123017
                    SalesHeader_vRec."GST Ship-to State Code" := ShipToAddr_lRec.State;
                    //else
                    //  SalesHeader_vRec."GST Ship-to State Code" := ShipToAddr_lRec."State Code(Export/SEZ)";
                    //ShipTOGST-NE 123017
                    SalesHeader_vRec."Ship-to GST Reg. No." := ShipToAddr_lRec."GST Registration No.";
                end;
            end;

        if SalesHeader_vRec."Document Type" in [SalesHeader_vRec."document type"::"Credit Memo", SalesHeader_vRec."document type"::"Return Order"] then begin
            if ShipToAddr_lRec.Get(SalesHeader_vRec."Sell-to Customer No.", SalesHeader_vRec."Ship-to Code") then
                if not (SalesHeader_vRec."GST Customer Type" in [SalesHeader_vRec."gst customer type"::Export, SalesHeader_vRec."gst customer type"::"Deemed Export",
                                                SalesHeader_vRec."gst customer type"::"SEZ Development", SalesHeader_vRec."gst customer type"::"SEZ Unit"])
                then begin
                    ShipToAddr_lRec.TestField(State);
                    SalesHeader_vRec."GST Ship-to State Code" := ShipToAddr_lRec.State;
                    SalesHeader_vRec."Ship-to GST Reg. No." := ShipToAddr_lRec."GST Registration No.";
                end;
        end;


        //Structure
        //IF Structure <> '' THEN BEGIN
        //  GSTManagement_gCdu.UpdateInvoiceType(SalesHeader_vRec);
        //END;
        SalesHeader_vRec.TestField("Location Code");
        if SalesHeader_vRec."Location Code" <> '' then begin
            Location_lRec.Get(SalesHeader_vRec."Location Code");
            SalesHeader_vRec."Location State Code" := Location_lRec."State Code";
            SalesHeader_vRec."Location GST Reg. No." := Location_lRec."GST Registration No.";
        end;


        SalesLine_lRec.Reset();
        SalesLine_lRec.SetRange("Document Type", SalesHeader_vRec."Document Type");
        SalesLine_lRec.SetRange("Document No.", SalesHeader_vRec."No.");
        SalesLine_lRec.SetFilter(SalesLine_lRec.Type, '<>%1', SalesLine_lRec.Type::" ");
        if SalesLine_lRec.FindFirst then begin
            if SalesLine_lRec."GST Place Of Supply" = SalesLine_lRec."GST Place Of Supply"::"Bill-to Address" then begin
                SalesHeader_vRec."GST-Ship to Customer Type" := SalesHeader_vRec."GST Customer Type";
                SalesHeader_vRec."Ship-to GST Customer Type" := SalesHeader_vRec."Ship-to GST Customer Type"::" ";
            End else
                if SalesLine_lRec."GST Place Of Supply" = SalesLine_lRec."GST Place Of Supply"::"Ship-to Address" then begin
                    if ShipToAddr_lRec.Get(SalesHeader_vRec."Sell-to Customer No.", SalesHeader_vRec."Ship-to Code") then begin
                        SalesHeader_vRec."GST-Ship to Customer Type" := ShipToAddr_lRec."Ship-to GST Customer Type";
                        SalesHeader_vRec."Ship-to GST Customer Type" := ShipToAddr_lRec."Ship-to GST Customer Type";
                    end;
                end;
        end;

        SalesHeader_vRec.Modify(true);

        //Respective Lines of the Document
        SalesLine_lRec.Reset;
        SalesLine_lRec.SetRange("Document Type", SalesHeader_vRec."Document Type");
        SalesLine_lRec.SetRange("Document No.", SalesHeader_vRec."No.");
        if SalesLine_lRec.FindSet then begin
            repeat
                //Item No.
                if SalesLine_lRec."No." <> '' then begin
                    case SalesLine_lRec.Type of
                        SalesLine_lRec.Type::"G/L Account":
                            begin
                                GLAcc_gRec.Get(SalesLine_lRec."No.");
                                SalesUpdateGSTPlaceOfSupply_gFnc(SalesLine_lRec, GLAcc_gRec."HSN/SAC Code", GLAcc_gRec."GST Group Code", GLAcc_gRec.Exempted);
                            end;
                        SalesLine_lRec.Type::Item:
                            begin
                                Item_gRec.Get(SalesLine_lRec."No.");
                                SalesUpdateGSTPlaceOfSupply_gFnc(SalesLine_lRec, Item_gRec."HSN/SAC Code", Item_gRec."GST Group Code", Item_gRec.Exempted);
                            end;
                        SalesLine_lRec.Type::Resource:
                            begin
                                Resource_gRec.Get(SalesLine_lRec."No.");
                                SalesUpdateGSTPlaceOfSupply_gFnc(SalesLine_lRec, Resource_gRec."HSN/SAC Code", Resource_gRec."GST Group Code", Resource_gRec.Exempted);
                            end;
                        SalesLine_lRec.Type::"Fixed Asset":
                            begin
                                FA_gRec.Get(SalesLine_lRec."No.");
                                SalesUpdateGSTPlaceOfSupply_gFnc(SalesLine_lRec, FA_gRec."HSN/SAC Code", FA_gRec."GST Group Code", FA_gRec.Exempted);
                            end;
                        SalesLine_lRec.Type::"Charge (Item)":
                            begin
                                ItemCharge_gRec.Get(SalesLine_lRec."No.");
                                SalesUpdateGSTPlaceOfSupply_gFnc(SalesLine_lRec, ItemCharge_gRec."HSN/SAC Code", ItemCharge_gRec."GST Group Code", ItemCharge_gRec.Exempted);
                            end;
                    end;
                end;
                SalesLine_lRec.Modify(true);
            until SalesLine_lRec.Next = 0;
        end;



        Message('Data Updated');
    end;


    procedure UpdatePurchaseDocument_gFnc(var PurchaseHeader_vRec: Record "Purchase Header")
    var
        PurchLines_lRec: Record "Purchase Line";
        GSTGroup_lRec: Record "GST Group";
        OrderAddr: Record "Order Address";
    begin
        //Buy-from Vendor No.
        if PurchaseHeader_vRec."Buy-from Vendor No." <> '' then begin
            Vendor_gRec.Get(PurchaseHeader_vRec."Buy-from Vendor No.");
            PurchaseHeader_vRec."GST Vendor Type" := Vendor_gRec."GST Vendor Type";
            PurchaseHeader_vRec."Vendor GST Reg. No." := Vendor_gRec."GST Registration No.";
            PurchaseHeader_vRec.State := Vendor_gRec."State Code";

            if PurchaseHeader_vRec."Order Address Code" <> '' then begin
                OrderAddr.Get(PurchaseHeader_vRec."Buy-from Vendor No.", PurchaseHeader_vRec."Order Address Code");
                PurchaseHeader_vRec."GST Order Address State" := OrderAddr.State;
                PurchaseHeader_vRec."Order Address GST Reg. No." := OrderAddr."GST Registration No.";

                if PurchaseHeader_vRec."GST Vendor Type" = PurchaseHeader_vRec."gst vendor type"::Unregistered then
                    PurchaseHeader_vRec.TestField("GST Order Address State")
            end else begin
                PurchaseHeader_vRec."GST Order Address State" := '';
                PurchaseHeader_vRec."Order Address GST Reg. No." := '';
            end;

            if PurchaseHeader_vRec."GST Vendor Type" in [PurchaseHeader_vRec."gst vendor type"::Registered, PurchaseHeader_vRec."gst vendor type"::Composite, PurchaseHeader_vRec."gst vendor type"::SEZ] then
                PurchaseHeader_vRec.TestField("Vendor GST Reg. No.");

            if not (Vendor_gRec."GST Vendor Type" in [Vendor_gRec."gst vendor type"::Import, Vendor_gRec."gst vendor type"::Registered,
                                                Vendor_gRec."gst vendor type"::Unregistered]) and (PurchaseHeader_vRec."GST Input Service Distribution") then
                Error(VendorISDErr, PurchaseHeader_vRec."Location Code", Vendor_gRec."gst vendor type"::" ",
                  Vendor_gRec."gst vendor type"::Composite, Vendor_gRec."gst vendor type"::Exempted);

            PurchaseHeader_vRec."Associated Enterprises" := Vendor_gRec."Associated Enterprises";

            if PurchaseHeader_vRec."Location Code" = '' then begin
                PurchaseHeader_vRec."GST Input Service Distribution" := false;
            end else begin
                Location_gRec.Get(PurchaseHeader_vRec."Location Code");
                PurchaseHeader_vRec."GST Input Service Distribution" := Location_gRec."GST Input Service Distributor";
                PurchaseHeader_vRec."Location GST Reg. No." := Location_gRec."GST Registration No.";
                PurchaseHeader_vRec."Location State Code" := Location_gRec."State Code";

                if PurchaseHeader_vRec."Bill to-Location(POS)" <> '' then begin
                    Location_gRec.Get(PurchaseHeader_vRec."Bill to-Location(POS)");
                    PurchaseHeader_vRec."Location State Code" := Location_gRec."State Code";
                    PurchaseHeader_vRec."Location GST Reg. No." := Location_gRec."GST Registration No.";
                    PurchaseHeader_vRec."GST Input Service Distribution" := Location_gRec."GST Input Service Distributor";
                end;
            end;

            if CheckRCMExemptDate(PurchaseHeader_vRec) then
                PurchaseHeader_vRec."RCM Exempt" := true
            else
                PurchaseHeader_vRec."RCM Exempt" := false;
        end;
        PurchaseHeader_vRec.Modify(true);

        //Respective Lines of the Document
        PurchLines_lRec.Reset;
        PurchLines_lRec.SetRange("Document Type", PurchaseHeader_vRec."Document Type");
        PurchLines_lRec.SetRange("Document No.", PurchaseHeader_vRec."No.");
        if PurchLines_lRec.FindSet then begin
            repeat
                PurchLines_lRec."Buy-From GST Registration No" := PurchaseHeader_vRec."Vendor GST Reg. No.";

                //Item No.
                if PurchLines_lRec."No." <> '' then begin

                    PurchLines_lRec."GST Reverse Charge" :=
                      PurchaseHeader_vRec."GST Vendor Type" in [PurchaseHeader_vRec."gst vendor type"::Import, PurchaseHeader_vRec."gst vendor type"::Unregistered, PurchaseHeader_vRec."gst vendor type"::SEZ];
                    if GSTGroup_lRec.Get(PurchLines_lRec."GST Group Code") and (PurchaseHeader_vRec."GST Vendor Type" = PurchaseHeader_vRec."gst vendor type"::Registered) then
                        PurchLines_lRec."GST Reverse Charge" := GSTGroup_lRec."Reverse Charge";

                    if PurchaseHeader_vRec."GST Vendor Type" = PurchaseHeader_vRec."gst vendor type"::Exempted then
                        PurchLines_lRec.Exempted := true;
                    case PurchLines_lRec.Type of
                        PurchLines_lRec.Type::"G/L Account":
                            begin
                                GLAcc_gRec.Get(PurchLines_lRec."No.");
                                Purchase_UpdatePurchLineForGST_gFnc(PurchLines_lRec, GLAcc_gRec."GST Credit", GLAcc_gRec."GST Group Code", PurchLines_lRec."gst group type"::Service, GLAcc_gRec."HSN/SAC Code", GLAcc_gRec.Exempted)
                            end;
                        PurchLines_lRec.Type::Item:
                            begin
                                Item_gRec.Get(PurchLines_lRec."No.");
                                if not PurchaseHeader_vRec.Subcontracting then
                                    Purchase_UpdatePurchLineForGST_gFnc(PurchLines_lRec, Item_gRec."GST Credit", Item_gRec."GST Group Code", PurchLines_lRec."gst group type"::Goods, Item_gRec."HSN/SAC Code", Item_gRec.Exempted)
                            end;
                        PurchLines_lRec.Type::"Fixed Asset":
                            begin
                                FA_gRec.Get(PurchLines_lRec."No.");
                                Purchase_UpdatePurchLineForGST_gFnc(PurchLines_lRec, FA_gRec."GST Credit", FA_gRec."GST Group Code", PurchLines_lRec."gst group type"::Goods, FA_gRec."HSN/SAC Code", FA_gRec.Exempted)
                            end;
                        PurchLines_lRec.Type::"Charge (Item)":
                            begin
                                ItemCharge_gRec.Get(PurchLines_lRec."No.");
                                if GSTGroup_gRec.Get(ItemCharge_gRec."GST Group Code") then;
                                Purchase_UpdatePurchLineForGST_gFnc(PurchLines_lRec, ItemCharge_gRec."GST Credit", ItemCharge_gRec."GST Group Code", PurchLines_lRec."GST Group Type", ItemCharge_gRec."HSN/SAC Code", ItemCharge_gRec.Exempted)
                            end;
                    end;
                end;
                PurchLines_lRec.Modify(true);
            until PurchLines_lRec.Next = 0;
        end;

        Message('Data Updated');
    end;


    procedure UpdateServiceDocument_gFnc(var ServiceHeader_vRec: Record "Service Header")
    var
        ShiptoAddress_lRec: Record "Ship-to Address";
        ServiceLine_lRec: Record "Service Line";
        Location_lRec: Record Location;
    begin
        //Customer No.
        if ServiceHeader_vRec."Customer No." <> '' then begin
            ServiceGetCust_gFnc(ServiceHeader_vRec, ServiceHeader_vRec."Customer No.");
            ServiceHeader_vRec."GST Customer Type" := Cust_gRec."GST Customer Type";
            if ServiceHeader_vRec."GST Customer Type" = ServiceHeader_vRec."gst customer type"::Unregistered then
                ServiceHeader_vRec."Nature of Supply" := ServiceHeader_vRec."nature of supply"::B2C
            else
                ServiceHeader_vRec."Nature of Supply" := ServiceHeader_vRec."nature of supply"::B2B;
            if ServiceHeader_vRec."GST Customer Type" = ServiceHeader_vRec."gst customer type"::Exempted then
                ServiceHeader_vRec."Invoice Type" := ServiceHeader_vRec."invoice type"::"Bill of Supply";
            if ServiceHeader_vRec."GST Customer Type" in [ServiceHeader_vRec."gst customer type"::Export, ServiceHeader_vRec."gst customer type"::"Deemed Export"] then
                ServiceHeader_vRec."Invoice Type" := ServiceHeader_vRec."invoice type"::Export;
            if ServiceHeader_vRec."GST Customer Type" in [ServiceHeader_vRec."gst customer type"::Registered, ServiceHeader_vRec."gst customer type"::Unregistered] then
                ServiceHeader_vRec."Invoice Type" := ServiceHeader_vRec."invoice type"::" ";
        end;

        //Bill-to Customer No.
        if ServiceHeader_vRec."Bill-to Customer No." <> '' then begin
            ServiceHeader_vRec."GST Bill-to State Code" := '';
            ServiceGetCust_gFnc(ServiceHeader_vRec, ServiceHeader_vRec."Bill-to Customer No.");
            if not (ServiceHeader_vRec."GST Customer Type" in [ServiceHeader_vRec."gst customer type"::"Deemed Export", ServiceHeader_vRec."gst customer type"::Export]) then begin
                ServiceHeader_vRec."GST Bill-to State Code" := Cust_gRec."State Code";
                ServiceHeader_vRec."Customer GST Reg. No." := Cust_gRec."GST Registration No.";
            end;
        end;

        if Location_lRec.Get(ServiceHeader_vRec."Location Code") then begin
            ServiceHeader_vRec."Location GST Reg. No." := Location_lRec."GST Registration No.";
            ServiceHeader_vRec."Location State Code" := Location_lRec."State Code";
        end;

        //Ship-to Code
        if ServiceHeader_vRec."Ship-to Code" <> '' then begin
            ServiceHeader_vRec."GST Ship-to State Code" := '';
            if ShiptoAddress_lRec.Get(ServiceHeader_vRec."Customer No.", ServiceHeader_vRec."Ship-to Code") then
                if not (ServiceHeader_vRec."GST Customer Type" in [ServiceHeader_vRec."gst customer type"::"Deemed Export", ServiceHeader_vRec."gst customer type"::Export]) then
                    ServiceHeader_vRec."GST Ship-to State Code" := ShiptoAddress_lRec.State;
        end;
        ServiceHeader_vRec.Modify(true);

        //Respective Service Lines
        ServiceLine_lRec.Reset;
        ServiceLine_lRec.SetRange("Document Type", ServiceHeader_vRec."Document Type");
        ServiceLine_lRec.SetRange("Document No.", ServiceHeader_vRec."No.");
        if ServiceLine_lRec.FindSet then begin
            repeat
                GetServHeader_gFnc(ServiceLine_lRec);
                //Item No.
                if ServiceLine_lRec."No." <> '' then begin
                    ServiceLine_lRec."Invoice Type" := ServHeader_gRec."Invoice Type";
                    case ServiceLine_lRec.Type of
                        ServiceLine_lRec.Type::"G/L Account":
                            begin
                                GLAcc_gRec.Get(ServiceLine_lRec."No.");
                                ServiceUpdateGSTPlaceOfSupply_gFnc(ServiceLine_lRec, GLAcc_gRec."HSN/SAC Code", GLAcc_gRec."GST Group Code", GLAcc_gRec.Exempted);
                            end;
                        ServiceLine_lRec.Type::Cost:
                            begin
                                ServiceCost_gRec.Get(ServiceLine_lRec."No.");
                                ServiceUpdateGSTPlaceOfSupply_gFnc(ServiceLine_lRec, ServiceCost_gRec."HSN/SAC Code", ServiceCost_gRec."GST Group Code", ServiceCost_gRec.Exempted);
                            end;
                        ServiceLine_lRec.Type::Item:
                            begin
                                Item_gRec.Get(ServiceLine_lRec."No.");
                                ServiceUpdateGSTPlaceOfSupply_gFnc(ServiceLine_lRec, Item_gRec."HSN/SAC Code", Item_gRec."GST Group Code", Item_gRec.Exempted);
                            end;
                        ServiceLine_lRec.Type::Resource:
                            begin
                                Resource_gRec.Get(ServiceLine_lRec."No.");
                                ServiceUpdateGSTPlaceOfSupply_gFnc(ServiceLine_lRec, Resource_gRec."HSN/SAC Code", Resource_gRec."GST Group Code", Resource_gRec.Exempted);
                            end;
                    end;
                end;
                ServiceLine_lRec.Modify(true);
            until ServiceLine_lRec.Next = 0;
        end;

        Message('Data Updated');
    end;


    procedure UpdateTransferDocument_gFnc(var TransferHeader_vRec: Record "Transfer Header")
    var
        TransferLine_lRec: Record "Transfer Line";
        Item_lRec: Record Item;
    begin
        TransferLine_lRec.Reset;
        TransferLine_lRec.SetRange("Document No.", TransferHeader_vRec."No.");
        if TransferLine_lRec.FindSet then begin
            repeat
                if TransferLine_lRec."Item No." <> '' then begin
                    Item_gRec.Get(TransferLine_lRec."Item No.");
                    TransferLine_lRec."GST Credit" := Item_gRec."GST Credit";
                    TransferLine_lRec."GST Group Code" := Item_gRec."GST Group Code";
                    TransferLine_lRec."HSN/SAC Code" := Item_gRec."HSN/SAC Code";
                    TransferLine_lRec.Modify(true);
                end;
            until TransferLine_lRec.Next = 0;
        end;

        Message('Data Updated');
    end;

    local procedure SalesGetCust_gFnc(var SalesHeader_vRec: Record "Sales Header"; CustNo: Code[20])
    begin
        if not ((SalesHeader_vRec."Document Type" = SalesHeader_vRec."document type"::Quote) and (CustNo = '')) then begin
            if CustNo <> Cust_gRec."No." then
                Cust_gRec.Get(CustNo);
        end else
            Clear(Cust_gRec);
    end;

    local procedure ServiceGetCust_gFnc(var ServiceHeader_vRec: Record "Service Header"; CustNo: Code[20])
    begin
        if not ((ServiceHeader_vRec."Document Type" = ServiceHeader_vRec."document type"::Quote) and (CustNo = '')) then begin
            if CustNo <> Cust_gRec."No." then
                Cust_gRec.Get(CustNo);
        end else
            Clear(Cust_gRec);
    end;

    local procedure SalesUpdateGSTPlaceOfSupply_gFnc(var SalesLine_vRec: Record "Sales Line"; HSNSACCode: Code[8]; GSTGroupCode: Code[20]; GSTExempted: Boolean)
    begin
        if (HSNSACCode <> '') and (SalesLine_vRec."HSN/SAC Code" = '') then
            SalesLine_vRec."HSN/SAC Code" := HSNSACCode;

        if (GSTGroupCode <> '') and (SalesLine_vRec."GST Group Code" = '') then
            SalesLine_vRec."GST Group Code" := GSTGroupCode;

        SalesLine_vRec.Exempted := GSTExempted;
        SalesSetup_gRec.Get;
        SalesLine_vRec."GST Place Of Supply" := SalesSetup_gRec."GST Dependency Type";
        if GSTGroup_gRec.Get(SalesLine_vRec."GST Group Code") then begin
            SalesLine_vRec."GST Group Type" := GSTGroup_gRec."GST Group Type";
            if GSTGroup_gRec."GST Place Of Supply" <> GSTGroup_gRec."gst place of supply"::" " then
                SalesLine_vRec."GST Place Of Supply" := GSTGroup_gRec."GST Place Of Supply";
        end;
    end;

    local procedure Purchase_UpdatePurchLineForGST_gFnc(var PurchLine_vRec: Record "Purchase Line"; GSTCredit: Enum "GST Credit"; GSTGrpCode: Code[20]; GSTGrpType: Enum "GST Group Type"; HSNSACCode: Code[8]; GSTExempted: Boolean)
    begin
        PurchLine_vRec."GST Credit" := GSTCredit;
        if (GSTGrpCode <> '') and (PurchLine_vRec."GST Group Code" = '') then
            PurchLine_vRec."GST Group Code" := GSTGrpCode;

        PurchLine_vRec."GST Group Type" := GSTGrpType;
        if (HSNSACCode <> '') and (PurchLine_vRec."HSN/SAC Code" = '') then
            PurchLine_vRec."HSN/SAC Code" := HSNSACCode;

        PurchLine_vRec.Exempted := GSTExempted;
        GetPurchHeader_gFnc(PurchLine_vRec);
        if (PurchLine_vRec."GST Group Type" = PurchLine_vRec."gst group type"::Goods) and (PurchHeader_gRec."Associated Enterprises") then
            Error(AssociatedEntErr);
        //IF (GSTManagement_gCdu.IsGSTApplicable(PurchHeader_gRec.Structure)) AND (PurchHeader_gRec."GST Input Service Distribution") AND
        //  (PurchLine_vRec."GST Group Type" = PurchLine_vRec."GST Group Type"::"0")
        //THEN
        //  ERROR(TypeISDErr,PurchLine_vRec.Type,PurchLine_vRec.FIELDNAME("GST Group Type"),PurchLine_vRec."GST Group Type"::"1");
    end;

    local procedure ServiceUpdateGSTPlaceOfSupply_gFnc(var ServiceLine_vRec: Record "Service Line"; HSNSACCode: Code[8]; GSTGroupCode: Code[20]; GSTExempted: Boolean)
    begin
        if (HSNSACCode <> '') and (ServiceLine_vRec."HSN/SAC Code" = '') then
            ServiceLine_vRec."HSN/SAC Code" := HSNSACCode;

        if (GSTGroupCode <> '') and (ServiceLine_vRec."GST Group Code" = '') then
            ServiceLine_vRec."GST Group Code" := GSTGroupCode;

        ServiceLine_vRec.Exempted := GSTExempted;
        ServiceMgtSetup.Get;
        ServiceLine_vRec."GST Place Of Supply" := ServiceMgtSetup."GST Dependency Type";
        if GSTGroup_gRec.Get(GSTGroupCode) then begin
            ServiceLine_vRec."GST Group Type" := GSTGroup_gRec."GST Group Type";
            if GSTGroup_gRec."GST Place Of Supply" <> GSTGroup_gRec."gst place of supply"::" " then
                ServiceLine_vRec."GST Place Of Supply" := GSTGroup_gRec."GST Place Of Supply";
        end;
    end;

    local procedure GetPurchHeader_gFnc(var PurchLines_vRec: Record "Purchase Line")
    begin
        PurchLines_vRec.TestField("Document No.");
        if (PurchLines_vRec."Document Type" <> PurchHeader_gRec."Document Type") or (PurchLines_vRec."Document No." <> PurchHeader_gRec."No.") then begin
            PurchHeader_gRec.Get(PurchLines_vRec."Document Type", PurchLines_vRec."Document No.");
            if PurchHeader_gRec."Currency Code" = '' then
                Currency_gRec.InitRoundingPrecision
            else begin
                PurchHeader_gRec.TestField("Currency Factor");
                Currency_gRec.Get(PurchHeader_gRec."Currency Code");
                Currency_gRec.TestField("Amount Rounding Precision");
            end;
        end;
    end;

    local procedure GetServHeader_gFnc(var ServiceLine_vRec: Record "Service Line")
    begin
        ServiceLine_vRec.TestField("Document No.");
        if (ServiceLine_vRec."Document Type" <> ServHeader_gRec."Document Type") or (ServiceLine_vRec."Document No." <> ServHeader_gRec."No.") then begin
            ServHeader_gRec.Get(ServiceLine_vRec."Document Type", ServiceLine_vRec."Document No.");
            if ServHeader_gRec."Currency Code" = '' then
                Currency_gRec.InitRoundingPrecision
            else begin
                ServHeader_gRec.TestField("Currency Factor");
                Currency_gRec.Get(ServHeader_gRec."Currency Code");
                Currency_gRec.TestField("Amount Rounding Precision");
            end;
        end;
    end;


    procedure CheckRCMExemptDate(PH_iRec: Record "Purchase Header"): Boolean
    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
    begin
        if PH_iRec."GST Vendor Type" <> PH_iRec."gst vendor type"::Unregistered then
            exit(false);
        if (PH_iRec."Document Type" in [PH_iRec."document type"::Order,
                                PH_iRec."document type"::Invoice]) then begin
            PH_iRec.TestField("Posting Date");
            PurchasesPayablesSetup.Get;
            PurchasesPayablesSetup.TestField("RCM Exempt Start Date (Unreg)");
            PurchasesPayablesSetup.TestField("RCM Exempt Start Date (Unreg)");
            if (PH_iRec."Posting Date" >= PurchasesPayablesSetup."RCM Exempt Start Date (Unreg)") and
               (PH_iRec."Posting Date" <= PurchasesPayablesSetup."RCM Exempt End Date (Unreg)")
            then
                exit(true);
        end else
            if (PH_iRec."Document Type" in [PH_iRec."document type"::"Credit Memo",
                                    PH_iRec."document type"::"Return Order"])
            then begin
                if PH_iRec."Applies-to Doc. No." <> '' then begin
                    VendorLedgerEntry.Reset;
                    VendorLedgerEntry.SetCurrentkey("Document No.", "Document Type", "Vendor No.");
                    VendorLedgerEntry.SetRange("Document No.", PH_iRec."Applies-to Doc. No.");
                    if PH_iRec."Applies-to Doc. Type".AsInteger() <> 0 then
                        VendorLedgerEntry.SetRange("Document Type", PH_iRec."Applies-to Doc. Type");
                    VendorLedgerEntry.SetRange("Vendor No.", PH_iRec."Buy-from Vendor No.");
                    if VendorLedgerEntry.FindFirst then
                        if VendorLedgerEntry."RCM Exempt" then
                            exit(true);
                end;
                if PH_iRec."Applies-to ID" <> '' then begin
                    VendorLedgerEntry.Reset;
                    VendorLedgerEntry.SetCurrentkey("Vendor No.", "Applies-to ID", "Document No.");
                    VendorLedgerEntry.SetRange("Vendor No.", PH_iRec."Buy-from Vendor No.");
                    VendorLedgerEntry.SetRange("Applies-to ID", PH_iRec."Applies-to ID");
                    VendorLedgerEntry.SetFilter("Amount to Apply", '<>0');
                    if VendorLedgerEntry.FindFirst then
                        if VendorLedgerEntry."RCM Exempt" then
                            exit(true);
                end;
                if (PH_iRec."Applies-to Doc. No." = '') and (PH_iRec."Applies-to ID" = '') then begin
                    PH_iRec.TestField("Posting Date");
                    PurchasesPayablesSetup.Get;
                    PurchasesPayablesSetup.TestField("RCM Exempt Start Date (Unreg)");
                    PurchasesPayablesSetup.TestField("RCM Exempt Start Date (Unreg)");
                    if (PH_iRec."Posting Date" >= PurchasesPayablesSetup."RCM Exempt Start Date (Unreg)") and
                       (PH_iRec."Posting Date" <= PurchasesPayablesSetup."RCM Exempt End Date (Unreg)")
                    then
                        exit(true);
                end;
            end;
        exit(false);
    end;


    procedure UpdateDeliveryChallan_gFnc(DeliveryChallanHdr_vRec: Record "Delivery Challan Header")
    var
        DeliveryChallanLine_lRec: Record "Delivery Challan Line";
        Item_gRec: Record Item;
    begin
        DeliveryChallanLine_lRec.Reset;
        DeliveryChallanLine_lRec.SetRange("Delivery Challan No.", DeliveryChallanHdr_vRec."No.");
        if DeliveryChallanLine_lRec.FindSet then begin
            repeat
                if DeliveryChallanLine_lRec."Item No." <> '' then begin
                    Item_gRec.Get(DeliveryChallanLine_lRec."Item No.");
                    DeliveryChallanLine_lRec."GST Credit" := Item_gRec."GST Credit";
                    DeliveryChallanLine_lRec."GST Group Code" := Item_gRec."GST Group Code";
                    DeliveryChallanLine_lRec."HSN/SAC Code" := Item_gRec."HSN/SAC Code";
                    DeliveryChallanLine_lRec.Modify(true);
                end;
            until DeliveryChallanLine_lRec.Next = 0;
        end;

        Message('Data Updated');
    end;
}

