report 53014 "TransferOfOwnership Clearance"//T12370-Full Comment T13538 53009 changed to 53014
{
    //Stamp
    Caption = 'Transfer Of Ownership Certificate Clr.';
    DefaultLayout = RDLC;
    RDLCLayout = 'Sales Print Layout/RDL/53009 TransferOfOwnership Clearance.rdl';
    UsageCategory = Administration;
    // ApplicationArea = all;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            column(Posting_Date; Format("Posting Date", 0, '<Day,2>-<Month Text,3>-<year4>')) { }
            column(Bill_to_Name; "Bill-to Name") { }
            column(InvoiceNo; "No.") { }
            column(Bill_to_Address; "Bill-to Address") { }
            column(Bill_to_Address_2; "Bill-to Address 2") { }
            column(Bill_to_City; "Bill-to City") { }
            column(Bill_to_County; "Bill-to County") { }

            column(Sell_to_Customer_Name; "Sell-to Customer Name") { }
            column(Sell_to_Address; "Sell-to Address") { }
            column(Sell_to_Address_2; "Sell-to Address 2") { }
            column(Sell_to_City; "Sell-to City") { }
            column(Sell_to_County; "Sell-to County") { }

            column(Ship_to_Name; CustAddrShipto_Arr[1]) { }
            column(Ship_to_Address; CustAddrShipto_Arr[2]) { }
            column(Ship_to_Address_2; CustAddrShipto_Arr[3]) { }
            column(Ship_to_City; CustAddrShipto_Arr[4]) { }
            column(Ship_to_County; CustAddrShipto_Arr[5]) { }


            column(CompanyName; Companyinformation.Name) { }
            column(CompanyAddress1; Companyinformation.Address) { }
            column(CompanyAddress2; Companyinformation."Address 2") { }

            column(CompanyCity; Companyinformation.City) { }
            column(CompanyCountry; CountryregionCode.name) { }
            column(CompanyLogo; Companyinformation.Picture) { }
            column(Companyinfo_logo; Companyinformation.Logo) { }
            //Stamp
            column(CompanyInfo_Stamp; Companyinformation.Stamp)
            {

            }
            column(ICStamp; ICCompany.Stamp)
            {

            }
            column(PrintStamp; PrintStamp)
            {

            }
            column(IsIntercompany; IsIntercompany)
            {

            }
            //Stamp-End

            column(CompanyPhoneNo; Companyinformation."Phone No.") { }
            column(Web; Companyinformation."Home Page") { }

            column(CompanyTRN; Companyinformation."VAT Registration No.") { }

            column(HeaderStmtText; HeaderStmtText) { }
            column(TransfererCompanyNameSignText; TransfererCompanyNameSignText) { }
            column(FooterStmtText; FooterStmtText) { }
            column(TransfereeCompanyNameSignText; TransfereeCompanyNameSignText) { }

            dataitem("Sales Invoice Line"; "Sales Invoice Line")
            {
                DataItemLink = "Document No." = field("No.");

                column(No_; "No.") { }
                column(Description; Description) { }
                column(Description_2; "Description 2") { }
                column(CountryOfOrigin; CountryOfOrigin) { }
                column(HSNCode; HSNCode) { }
                // column(Net_Weight; "Net Weight") { }
                // column(Gross_Weight; "Gross Weight") { }
                column(Packing; Packing) { }
                column(Net_Weight; NetWeightG) { }
                column(Gross_Weight; GrossWeightG) { }
                column(Item_Generic_Name; "Item Generic Name") { }
                column(SN1; SN1) { }

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                    item: Record item;
                    ItemUOM: Record "Item Unit of Measure";
                    UOM: Record "Unit of Measure";
                    LowestQty: Decimal;
                    StringProper: Codeunit "String Proper";
                    SalesInvoiceLine2: Record "Sales Invoice Line";
                    ItemUOMVariant: Record "Item Unit of Measure";
                    SalesLine2L: Record "Sales Invoice Line";
                    UOMDesc: Text;
                    ItemVariant_lRec: Record "Item Variant";//T13802-N
                begin
                    if SalesLineMerge then
                        if Quantity = 0 then
                            CurrReport.Skip();

                    Clear(Packing);
                    Clear(LowestQty);
                    Clear(UOMDesc);

                    if "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then begin
                        item.Get("Sales Invoice Line"."No.");
                        ItemUOM.Reset();
                        // if "Sales Invoice Line"."Unit of Measure Code" <> '' then
                        //     ItemUOM.Get("No.", "Sales Invoice Line"."Unit of Measure Code");
                        ItemUOM.SetRange("Item No.", "Sales Invoice Line"."No.");
                        //T13802-NS
                        // if "Variant Code" <> '' then begin
                        //     If ItemUOM."Variant Code" = "Variant Code" then begin
                        //         ItemUOM.SetRange("Variant Code", "Variant Code");
                        //     end else begin
                        //         ItemUOM.SetRange("Variant Code", '');
                        //     end;
                        // end else begin
                        //     if "Unit of Measure Code" <> '' then
                        //         ItemUOMVariant.Get("No.", "Unit of Measure Code");
                        //     if ItemUOMVariant."Variant Code" <> '' then begin
                        //         ItemUOM.SetRange("Variant Code", ItemUOMVariant."Variant Code");
                        //     end else begin
                        //         ItemUOM.SetRange("Variant Code", '');
                        //     end;
                        // end;
                        //T13802-NE
                        if ItemVariant_lRec.Get("No.", "Sales Invoice Line"."Variant Code") AND (ItemVariant_lRec."Packing Code" <> '') then Begin
                            // ItemUOM.SetRange("Item No.", "Sales Invoice Line"."No.");//Anoop
                            ItemUOM.SetRange(Code, ItemVariant_lRec."Packing Code");//T13802-N
                            ItemUOM.Ascending(true);
                            if itemuom.FindFirst() then begin
                                UOM.Get(ItemUOM.Code);
                                //if uom."Decimal Allowed" then begin
                                LowestQty := ROUND("Sales Invoice Line"."Quantity (Base)" / ItemUOM."Qty. per Unit of Measure", 0.01, '=');
                                packing := Format(LowestQty) + ' ' + uom.Description;
                                UOMDesc := uom.Description;
                                // end else begin
                                //     LowestQty := ROUND("Sales Invoice Line"."Quantity (Base)" / ItemUOM."Qty. per Unit of Measure", 1, '>');
                                //     packing := Format(LowestQty) + ' ' + ItemVariant_lRec.Description;
                                //     UOMDesc := ItemVariant_lRec.Description;
                            end;
                        end else begin
                            // Packing := Format("Sales Invoice Line"."Quantity (Base)") + ' ' + StringProper.ConvertString(ItemUOM.Code);
                            Packing := Format("Sales Invoice Line"."Quantity (Base)") + ' ' + "Sales Invoice Line"."Base UOM 2";
                            UOMDesc := "Sales Invoice Line"."Base UOM 2";
                        end;

                    end else
                        CurrReport.Skip();

                    //Supriya
                    Clear(QuantityG);
                    Clear(NetWeightG);
                    Clear(GrossWeightG);
                    Clear(SalesLine2L);
                    if not SalesLineMerge then begin
                        SalesLine2L.SetRange("Document No.", "Document No.");
                        SalesLine2L.SetRange("No.", "No.");
                        SalesLine2L.SetRange("Unit of Measure Code", "Unit of Measure Code");
                        SalesLine2L.SetFilter("Quantity (Base)", '>0');
                        if SalesLine2L.FindSet() then
                            repeat
                                NetWeightG += SalesLine2L."Net Weight";
                                GrossWeightG += SalesLine2L."Gross Weight";

                                if uom."Decimal Allowed" = false then
                                    QuantityG += Round(SalesLine2L."Quantity (Base)" / ItemUOM."Qty. per Unit of Measure", 1, '>')
                                else
                                    QuantityG += SalesLine2L."Quantity (Base)" / ItemUOM."Qty. per Unit of Measure";
                            until SalesLine2L.Next() = 0;
                        Packing := Format(QuantityG) + ' ' + UOMDesc;
                    end else begin
                        NetWeightG := "Net Weight";
                        GrossWeightG := "Gross Weight";
                    end;

                    if not SalesLineMerge then begin
                        SalesInvoiceLine2.Reset();
                        SalesInvoiceLine2.SetRange("Document No.", "Document No.");
                        SalesInvoiceLine2.SetRange(Type, Type::Item);
                        SalesInvoiceLine2.SetFilter("Line No.", '<%1', "Line No.");
                        SalesInvoiceLine2.SetRange("No.", "No.");
                        SalesInvoiceLine2.SetRange("Unit of Measure Code", "Unit of Measure Code");
                        //SalesInvoiceLine2.SetRange("Unit Price", "Unit Price");

                        // "Net Weight" := 0;
                        // "Gross Weight" := 0;

                        if SalesInvoiceLine2.FindFirst() then
                            CurrReport.Skip();
                        SalesInvoiceLine2.Reset();
                        SalesInvoiceLine2.SetRange("Document No.", "Document No.");
                        SalesInvoiceLine2.SetFilter("Line No.", '>%1', "Line No.");
                        SalesInvoiceLine2.SetRange("No.", "No.");
                        SalesInvoiceLine2.SetFilter(Quantity, '>0');//sup
                        if SalesInvoiceLine2.FindSet() then begin

                            repeat
                                if ("Unit Price" = SalesInvoiceLine2."Unit Price") and ("Unit of Measure Code" = SalesInvoiceLine2."Unit of Measure Code") then begin
                                    "Quantity (Base)" += SalesInvoiceLine2."Quantity (Base)";
                                    "Net Weight" += SalesInvoiceLine2."Net Weight";
                                    "Gross Weight" += SalesInvoiceLine2."Gross Weight";
                                end;
                            until SalesInvoiceLine2.Next() = 0;
                        end;
                    end;
                    if "Sales Invoice Line".Type = "Sales Invoice Line".Type::Item then
                        SN1 += 1;


                end;

            }
            trigger OnAfterGetRecord()
            var
                CompanyAddressString: Text;
                CustomerAddressString: Text;
                CustomerCountryRegionCode: Record "Country/Region";
                // ShipCustomerCountryRegionCode: Record "Country/Region";
                RecCustomer: Record Customer;
                AgentRepRec: Record "Agent Representative";
                CountryRegionL: Record "Country/Region";
                CountryRegionLName: Text[100];
                ICPartner: Record "IC Partner";
            begin
                clear(CustomerCountryRegionCode);
                Companyinformation.get();
                Companyinformation.CalcFields(Picture, Stamp, Logo);
                CountryregionCode.Get(Companyinformation."Country/Region Code");
                // if IsShipToAddress then begin
                //     if CustomerCountryRegionCode.Get("Ship-to Country/Region Code") then;
                // end else
                //     if CustomerCountryRegionCode.Get("Bill-to Country/Region Code") then;
                // // ShipCustomerCountryRegionCode.Get("Ship-to Country/Region Code");

                CompanyAddressString := Companyinformation.Address + ', ' + Companyinformation."Address 2" + ', ' + Companyinformation.City + ', ' + CountryregionCode.Name;

                if IsShipToAddress then begin
                    if CustomerCountryRegionCode.Get("Ship-to Country/Region Code") then
                        CustomerAddressString := "Ship-to Address" + ', ' + "Ship-to Address 2" + ', ' + "Ship-to City" + ', ' + CustomerCountryRegionCode.Name
                    else
                        CustomerAddressString := "Ship-to Address" + ', ' + "Ship-to Address 2" + ', ' + "Ship-to City";


                    if CompanyAddressString.Contains(', ,') then CompanyAddressString := CompanyAddressString.Replace(', ,', ',');
                    if CustomerAddressString.Contains(', ,') then CustomerAddressString := CustomerAddressString.Replace(', ,', ',');
                    HeaderStmtText := StrSubstNo(HeaderStmtLbl, Companyinformation.Name, CompanyAddressString, "Ship-to Name", CustomerAddressString);
                    FooterStmtText := StrSubstNo(FooterStmtLbl, "Ship-to Name", CustomerAddressString);
                    TransfereeCompanyNameSignText := StrSubstNo(TransfereeCompanyNameSignLbl, "Ship-to Name");

                end else begin
                    if PrintAgentRepAddress then begin
                        //>>SK 10-08-22
                        if PrintAgentRepAddress then begin
                            if CustomerCountryRegionCode.Get("Agent Rep. Country/Region Code") then
                                CustomerAddressString := "Agent Rep. Address" + ', ' + "Agent Rep. Address 2" + ', ' + "Agent Rep. City" + ', ' + CustomerCountryRegionCode.Name
                            else
                                CustomerAddressString := "Agent Rep. Address" + ', ' + "Agent Rep. Address 2" + ', ' + "Agent Rep. City";

                            if CompanyAddressString.Contains(', ,') then CompanyAddressString := CompanyAddressString.Replace(', ,', ',');
                            if CustomerAddressString.Contains(', ,') then CustomerAddressString := CustomerAddressString.Replace(', ,', ',');
                            HeaderStmtText := StrSubstNo(HeaderStmtLbl, Companyinformation.Name, CompanyAddressString, "Agent Rep. Name", CustomerAddressString);
                            FooterStmtText := StrSubstNo(FooterStmtLbl, "Agent Rep. Name", CustomerAddressString);
                            TransfereeCompanyNameSignText := StrSubstNo(TransfereeCompanyNameSignLbl, "Agent Rep. Name");
                        end;
                        //<<SK 10-08-22
                    end else begin
                        if CustomerCountryRegionCode.Get("Bill-to Country/Region Code") then
                            CustomerAddressString := "Bill-to Address" + ', ' + "Bill-to Address 2" + ', ' + "Bill-to City" + ', ' + CustomerCountryRegionCode.Name
                        else
                            CustomerAddressString := "Bill-to Address" + ', ' + "Bill-to Address 2" + ', ' + "Bill-to City";

                        if CompanyAddressString.Contains(', ,') then CompanyAddressString := CompanyAddressString.Replace(', ,', ',');
                        if CustomerAddressString.Contains(', ,') then CustomerAddressString := CustomerAddressString.Replace(', ,', ',');
                        HeaderStmtText := StrSubstNo(HeaderStmtLbl, Companyinformation.Name, CompanyAddressString, "Bill-to Name", CustomerAddressString);
                        FooterStmtText := StrSubstNo(FooterStmtLbl, "Bill-to Name", CustomerAddressString);
                        TransfereeCompanyNameSignText := StrSubstNo(TransfereeCompanyNameSignLbl, "Bill-to Name");
                    end;
                end;

                TransfererCompanyNameSignText := StrSubstNo(TransfererCompanyNameSignLbl, Companyinformation.Name);


                if blnClrAddress then begin
                    CustAddrShipto_Arr[1] := "Clearance Ship-to Name";
                    CustAddrShipto_Arr[2] := "Clearance Ship-to Address";
                    CustAddrShipto_Arr[3] := "Clearance Ship-to Address 2";
                    CustAddrShipto_Arr[4] := "Clearance Ship-to City";
                    CustAddrShipto_Arr[5] := "Clearance Ship-to County";
                end else begin
                    CustAddrShipto_Arr[1] := "Ship-to Name";
                    CustAddrShipto_Arr[2] := "Ship-to Address";
                    CustAddrShipto_Arr[3] := "Ship-to Address 2";
                    CustAddrShipto_Arr[4] := "Ship-to City";
                    CustAddrShipto_Arr[5] := "Ship-to County";
                end;
                //Stamp
                Clear(IsIntercompany);
                Clear(ICCompany);
                Clear(RecCustomer);
                RecCustomer.GET("Sell-to Customer No.");
                If RecCustomer."IC Partner Code" <> '' then begin
                    clear(ICPartner);
                    ICPartner.GET(RecCustomer."IC Partner Code");
                    //if ICPartner."Inbox Type" = ICPartner."Inbox Type"::Database then begin
                    // if (ICPartner."Inbox Type" = ICPartner."Inbox Type"::Database) and (ICPartner."Data Exchange Type" = ICPartner."Data Exchange Type"::Database) then begin//Hypercare 03-02-2025//T14179-O
                        if ICPartner."Inbox Details" <> '' then begin
                            /* ICCompany.ChangeCompany(ICPartner."Inbox Details");
                            ICCompany.GET; *///T14179-O
                            ICCompany.Get(ICPartner."Inbox Details");//T14179-N
                            ICCompany.CalcFields(Stamp);
                            IsIntercompany := true;
                        end;
                    // end;//T14179-O
                end;
                //-end

            end;
        }


    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field("SalesLine Merge"; SalesLineMerge)
                    {
                        ApplicationArea = All;
                        Caption = 'SalesLine UnMerge';
                    }
                    field("Print Clearance Ship-To Address"; blnClrAddress)
                    {
                        ApplicationArea = all;
                        Caption = 'Print Clearance Ship-To Address';
                    }
                    field(IsShipToAddress; IsShipToAddress)
                    {
                        ApplicationArea = All;
                        Caption = 'Print Ship To Address';
                    }
                    field(PrintStamp; PrintStamp)
                    {
                        ApplicationArea = all;
                        Caption = 'Print Digital Stamp';
                    }
                    field("Print Agent Representative Address"; PrintAgentRepAddress)
                    {
                        ApplicationArea = all;
                        Caption = 'Print Agent Representative Address';
                    }
                }
            }
        }


    }
    labels
    {
        DateLbl = 'Date: ';
        InvoiceNoLbl = 'Invoice No.: ';
        // HeaderStmtLbl = 'Please note that we, %1, have on this day transferred the ownership of the below mentioned goods to %2 .';
        ProductNameLbl = 'Product Name: ';
        DescriptionLbl = 'Description: ';
        CountryofOriginLbl = 'Origin: ';
        HSCodeLbl = 'HS Code: ';
        NetWeightLbl = 'Net Weight: ';
        GrossWeightLbl = 'Gross Weight: ';
        PackingLbl = 'Packing: ';
        PageNoLbl = 'Page ';
        CompTelNoLbl = 'Tel: ';
        Web_Lbl = 'Web: ';
        CompTRNNoLbl = 'TRN: ';
        //TransfererCompanyNameSignLbl = '%1 Authorized Signatory';
        //FooterStmtLbl = 'We, %1, hereby certify that as of this date we are the owner of the above-mentioned goods and we undertake to pay, when called upon to do so, all port storage and other charges that are and accruing thereon.';
        //TransfereeCompanyNameSignLbl = '%1 Authorized Signatory';


    }

    var
        Packing: Text;
        Companyinformation: Record "Company Information";
        // ICCompany: Record "Company Information";//T14179-O
        ICCompany: Record "Staging Company Information";//T14179-N
        IsIntercompany: Boolean;
        CountryregionCode: Record "Country/Region";
        HeaderStmtText: Text;
        TransfererCompanyNameSignText: Text;
        FooterStmtText: Text;
        TransfereeCompanyNameSignText: Text;
        HeaderStmtLbl: TextConst ENU = 'Please note that we, %1, %2 have on this day transferred the ownership of the below mentioned goods to %3, %4.';
        TransfererCompanyNameSignLbl: TextConst ENU = '%1 Authorized Signatory';
        FooterStmtLbl: TextConst ENU = 'We, %1, %2 hereby certify that as of this date we are the owner of the above-mentioned goods and we undertake to pay, when called upon to do so, all port storage and other charges that are and accruing thereon.';
        TransfereeCompanyNameSignLbl: TextConst ENU = '%1 Authorized Signatory';
        SN1: Integer;

        Packing_txt: Text;
        blnClrAddress: Boolean;
        CustAddrShipto_Arr: array[5] of Text[100];
        IsShipToAddress: Boolean;
        PrintStamp: Boolean;
        PrintAgentRepAddress: Boolean;
        SalesLineMerge: Boolean;
        NetWeightG: Decimal;
        GrossWeightG: Decimal;
        QuantityG: Decimal;
}