report 50127 "Packing List_Copy"
{

    Caption = 'Packing List';
    DefaultLayout = RDLC;
    RDLCLayout = 'Layouts/Packing List.rdl';
    UsageCategory = Administration;
    //ApplicationArea = all;

    dataset
    {
        dataitem("Transfer Header"; "Transfer Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Posting Date";
            column(No_TH; "No.") { }
            column(CountryCode; CountryCode) { }
            column(PostingDate_TH; "Posting Date") { }
            column(TransferfromName_TH; LocationFrom.Name) { }
            column(TransferfromAddress_TH; LocationFrom.Address) { }
            column(TransferfromAddress2_TH; LocationFrom."Address 2") { }
            column(TransferfromCity_TH; LocationFrom.City) { }
            column(Transfer_from_Post_Code; LocationFrom."Post Code") { }
            column(Transfer_to_Post_Code; LocationTo."Post Code") { }
            column(TrsffromCountryRegionCode_TH; LocationFrom."Country/Region Code") { }
            column(TrFromCountryName; FromCountryName) { }
            column(TransfertoName_TH; LocationTo.Name) { }
            column(TransfertoAddress_TH; LocationTo.Address) { }
            column(TransfertoAddress2_TH; LocationTo."Address 2") { }
            column(TransfertoCity_TH; LocationTo.City) { }
            column(TrsftoCountryRegionCode_TH; LocationTo."Country/Region Code") { }
            column(TrToCountryName; ToCountryName) { }
            column(FromAddressToggle; FromAddressToggle) { }
            column(ToAddressToggle; ToAddressToggle) { }
            column(Name_CI; companyInfo.Name) { }
            column(Address_CI; companyInfo.Address) { }
            column(Address2_CI; companyInfo."Address 2") { }
            column(PostCode_CI; companyInfo."Post Code") { }
            column(City_CI; companyInfo.City) { }
            column(CountryRegion_CI; companyInfo."Country/Region Code") { }
            column(TotalQty; TotalQty) { }
            column(LineUnMerge; LineUnMerge) { }
            column(CompanyInfo_Exporter; CompanyInfo."E-Mirsal Code") { }
            column(CompanyInfo_Picture; CompanyInfo.Picture) { }
            column(CompanyInfo_Stamp; CompanyInfo.Stamp) { }
            column(CompanyInfo_Name; CompanyInfo.Name) { }
            column(CompanyInfo_Address; CompanyInfo.Address) { }
            column(CompanyInfo_Address2; CompanyInfo."Address 2") { }
            column(CompanyInfo_City; CompanyInfo.City) { }
            column(CompanyInfo_Phoneno; CompanyInfo."Phone No.") { }
            column(CompanyInfo_Email; CompanyInfo."E-Mail") { }
            column(CompanyInfo_HomePage; CompanyInfo."Home Page") { }
            column(TRNNo; CompanyInfo."VAT Registration No.") { }

            dataitem("Transfer Line"; "Transfer Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE("Derived From Line No." = CONST(0));
                column(LineNo_TransferLine; "Line No.") { }
                column(Net_Weight; "Net Weight") { }
                column(Gross_Weight; "Gross Weight") { }
                column(SerialNo; SerialNo) { }
                column(ItemNo_TL; "Item No.") { }
                column(UnitofMeasure_TL; BaseUOMVar) { }
                column(Description_TL; Description) { }
                column(Variant_Code; "Variant Code") { }
                column(Quantity_TL; "Quantity (Base)") { }
                column(QuantityBase_TL; "Quantity (Base)") { }
                column(AlterNateUOMCode; UOMDesc) { }
                column(DecimalAllowed; DecimalAllowed) { }
                column(AlternateUOMQty; "Quantity (Base)" / AlternateQtyUOM) { }
                column(HSCode; HSCodeVar) { }
                column(Origin; OriginVar) { }

                column(Generic_Name; GenericNameVar) { }
                column(TotalAltQty; ("Quantity (Base)" / AlternateQtyUOM)) { }

                column(AltQtytransferline; "Quantity (Base)" / AlternateQtyUOM) { }
                column(LotExist; LotExist) { }

                dataitem("Reservation Entry"; "Reservation Entry")
                {
                    DataItemLink = "Source ID" = FIELD("Document No."),
                                   "Source Ref. No." = FIELD("Line No."),
                                   "Item No." = FIELD("Item No."),
                                   "Location Code" = FIELD("Transfer-to Code");
                    DataItemTableView = SORTING("Entry No.", Positive)
                                        ORDER(Ascending)
                                        WHERE("Source Type" = FILTER(5741));
                    //WHERE("Source Type" = FILTER(5741), "Lot No." = FILTER(<> ''));

                    column(LotNo_R; CustomLotNumber) { }
                    column(Quantity_Base_R; "Quantity (Base)") { }
                    column(AltQtyreservation; "Quantity (Base)" / AlternateQtyUOM) { }
                    column(AltQty1; "Quantity (Base)" / AlternateQtyUOM) { }
                    column(BOE_No; CustomBOENumber) { }
                }
                dataitem(Integer; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        ORDER(Ascending)
                                        WHERE(Number = const(1));

                    column(AlternateUOMQty11; "Transfer Line"."Quantity (Base)" / AlternateQtyUOM) { }
                    column(QuantityBase_TL1; "Transfer Line"."Quantity (Base)") { }
                }

                trigger OnAfterGetRecord()
                var
                    Item: Record Item;
                    Generic: Record KMP_TblGenericName;
                    CountryOrRegion: Record "Country/Region";
                    UnitofMeasure: Record "Unit of Measure";
                    RecVariant: Record "Item Variant";
                begin
                    //Serial No. Auto Increament
                    SerialNo := SerialNo + 1;
                    Clear(GenericNameVar);
                    Clear(OriginVar);
                    Clear(HSCodeVar);
                    Clear(BaseUOMVar);
                    if Item.Get("Transfer Line"."Item No.") then begin
                        if Generic.Get(Item.GenericName) then
                            GenericNameVar := Generic.Description;
                        if CountryOrRegion.Get(Item."Country/Region of Origin Code") then
                            OriginVar := CountryOrRegion.Name;
                        HSCodeVar := Item."Tariff No.";
                        BaseUOMVar := Item."Base Unit of Measure";
                        if "Transfer Line"."Variant Code" <> '' then begin
                            RecVariant.Get("Transfer Line"."Item No.", "Transfer Line"."Variant Code");
                            if RecVariant.HSNCode <> '' then begin
                                HSCodeVar := RecVariant.HSNCode;
                            end else begin
                                HSCodeVar := Item."Tariff No.";
                            end;
                            if RecVariant.CountryOfOrigin <> '' then begin
                                OriginVar := RecVariant.CountryOfOrigin;
                            end else begin
                                OriginVar := CountryOrRegion.Name;
                            end;
                        end;
                    end;

                    //Getting the Minimum Alternate UOM Qty. and its code
                    DecimalAllowed := false;
                    AlternateQtyUOM := 0;
                    UOMCode := '';
                    UOMDesc := '';
                    ItemUnitMeasure.SETRANGE("Item No.", "Item No.");
                    /* if "Variant Code" <> '' then
                        ItemUnitMeasure.SetRange("Variant Code", "Variant Code")
                    else
                        ItemUnitMeasure.SetRange("Variant Code", ''); */

                    if "Variant Code" <> '' then begin
                        If ItemUnitMeasure."Variant Code" = "Variant Code" then begin
                            ItemUnitMeasure.SetRange("Variant Code", "Variant Code");
                        end else begin
                            ItemUnitMeasure.SetRange("Variant Code", '');
                        end
                    end else begin
                        ItemUnitMeasure.SetRange("Variant Code", '');
                    end;

                    IF ItemUnitMeasure.FINDFIRST THEN BEGIN
                        AlternateQtyUOM := ItemUnitMeasure."Qty. per Unit of Measure";
                        UOMCode := ItemUnitMeasure.Code;
                        IF (UnitofMeasure.GET(UOMCode)) and (UnitofMeasure."Decimal Allowed") then
                            DecimalAllowed := true;
                        REPEAT
                            IF AlternateQtyUOM > ItemUnitMeasure."Qty. per Unit of Measure" THEN BEGIN
                                AlternateQtyUOM := ItemUnitMeasure."Qty. per Unit of Measure";
                                UOMCode := ItemUnitMeasure.Code;
                                IF (UnitofMeasure.GET(UOMCode)) and (UnitofMeasure."Decimal Allowed") then
                                    DecimalAllowed := true;
                            END;
                        UNTIL ItemUnitMeasure.NEXT = 0;
                    END;
                    UOMDesc := UnitofMeasure.Description;
                    LotExist := false;
                    ReservationEntryRec.Reset();
                    ReservationEntryRec.SetRange("Source ID", "Document No.");
                    ReservationEntryRec.SetRange("Source Ref. No.", "Line No.");
                    ReservationEntryRec.SetRange("Item No.", "Item No.");
                    ReservationEntryRec.SetRange("Location Code", "Transfer-to Code");
                    if ReservationEntryRec.FindFirst() then
                        LotExist := true;

                end;
            }
            dataitem("Transfer Transaction Comments"; "Transfer Transaction Comments")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                    ORDER(Ascending)
                                    WHERE("Document Type" = FILTER("Transfer Order"));
                column(RemarksSerial; RemarksSerial) { }
                column(LineNo_TCL; "Line No.") { }
                column(No_TCL; "Document No.") { }
                column(Comment; Comments) { }

                trigger OnAfterGetRecord()
                begin
                    // Assigning Serial No. to Remarks.
                    RemarksSerial := RemarksSerial + 1;
                end;
            }

            trigger OnAfterGetRecord()
            var
                transferline: Record "Transfer Line";
            begin
                CLEAR(TotalAltQty);
                CLEAR(TotalQty);
                if LocationFrom.Get("Transfer-from Code") then;
                if LocationTo.Get("Transfer-to Code") then;

                // Getting Country Name for Transfer from and to Addresses.
                IF FromAddressToggle THEN BEGIN
                    CountryRegion.GET(companyInfo."Country/Region Code");
                    FromCountryName := CountryRegion.Name;
                END ELSE BEGIN
                    CountryRegion.GET(LocationFrom."Country/Region Code");
                    FromCountryName := CountryRegion.Name;
                END;

                IF ToAddressToggle THEN BEGIN
                    CountryRegion.GET(companyInfo."Country/Region Code");
                    ToCountryName := CountryRegion.Name;
                END ELSE BEGIN
                    CountryRegion.GET(LocationTo."Country/Region Code");
                    ToCountryName := CountryRegion.Name;
                END;

                transferline.Reset();
                transferline.SETRANGE("Document No.", "No.");
                IF transferline.FindSet() then begin
                    transferline.CalcSums("Quantity (Base)");
                    TotalQty := transferline."Quantity (Base)";
                end;


            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                //     field("Hide From Warehouse"; FromAddressToggle)
                //     {
                //         ApplicationArea = All;

                //         trigger OnValidate()
                //         begin
                //             IF ToAddressToggle THEN BEGIN
                //                 ERROR('Only One Toggle can be selected');
                //                 FromAddressToggle := FALSE
                //             END;
                //         end;
                //     }
                //     field("Hide To Warehouse"; ToAddressToggle)
                //     {
                //         ApplicationArea = All;

                //         trigger OnValidate()
                //         begin
                //             IF FromAddressToggle THEN BEGIN
                //                 ERROR('Only One Toggle can be selected');
                //                 ToAddressToggle := FALSE
                //             END;
                //         end;
                //     }
                //     field("Line Merge"; LineUnMerge)
                //     {
                //         ApplicationArea = All;
                //         Caption = 'Line UnMerge';
                //     }
            }
        }

        actions
        {
        }
    }

    labels
    {
        Tel_Lbl = 'Tel:';
        Web_Lbl = 'Web:';
        TRN_Lbl = 'TRN:';
        Report_Lbl = 'PACKING LIST';
        Report_Lbl1 = ' Order';
        Report_Lbl2 = ' (Warehouse to Warehouse)';
        Authority_Lbl = 'Authorized Signatory:';
        Stamp_Lbl = 'Stamp:';
        Date_Lbl = 'Date:';
        Remarks_Lbl = 'Both parties confirm with their signature that all the products are Delivered/Received in perfect condition. Please explain here if any discrepancy exists.';
        TrFrom_Lbl = 'Bill To';
        TrTo_Lbl = 'Transfer To:';
        SerialNo_Lbl = 'No.';
        ItemNo_Lbl = 'Item No.';
        Desc_Lbl = 'Description';
        LotNo_Lbl = 'Lot Number';
        Boe_Lbl = 'BOE Number';
        BaseUOM_Lbl = 'UOM';
        BUOMQ_Lbl = 'Quantity';
        AlUOM_Lbl = 'Package Qty.';
        AlUOMQ_Lbl = 'Package Type';
        Total_Lbl = 'Total';
        PosDate_Lbl = 'Date:';
        OrderNo_Lbl = 'Packing Ref.:';
        RemarkHead_Lbl = 'Remarks:';
    }

    trigger OnInitReport()
    begin
        SerialNo := 0;
        RemarksSerial := 1;
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture, Stamp);
        GLSetup.Get();
        if CountryRegion.Get(CompanyInfo."Country/Region Code") then CountryCode := CountryRegion.Name;
    end;

    trigger OnPreReport()
    begin
        companyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture, Stamp);
    end;

    var
        CountryCode: Text[50];
        GLSetup: Record "General Ledger Setup";
        SerialNo: Integer;
        CountryRegion: Record "Country/Region";
        FromCountryName: Text[50];
        ToCountryName: Text[50];
        FromAddressToggle: Boolean;
        ToAddressToggle: Boolean;
        companyInfo: Record "Company Information";
        ItemUnitMeasure: Record "Item Unit of Measure";
        AlternateQtyUOM: Decimal;
        UOMCode: Code[20];
        UOMDesc: Text;
        OriginVar: Text;
        HSCodeVar: Text;
        BaseUOMVar: Text;
        Item: Record "Item";
        ReservationEntryRec: Record "Reservation Entry";
        RemarksSerial: Integer;
        TotalQty: Decimal;
        TotalAltQty: Decimal;
        AltQty: Decimal;
        TotalUOMQty: Decimal;
        AltQty1: Decimal;
        GenericNameVar: Text;
        LocationFrom: Record Location;
        LocationTo: Record Location;
        LotExist: Boolean;
        DecimalAllowed: Boolean;
        LineUnMerge: Boolean;
}

