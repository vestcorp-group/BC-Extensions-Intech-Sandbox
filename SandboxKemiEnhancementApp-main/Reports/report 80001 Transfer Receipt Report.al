report 80001 "Transfer Receipt Report"//T12370-N
{
    // version Task4

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Transfer Receipt Layout.rdl';

    dataset
    {
        dataitem("Transfer Receipt Header"; "Transfer Receipt Header")
        {
            DataItemTableView = SORTING("No.")
                                ORDER(Ascending);
            RequestFilterFields = "No.", "Posting Date";
            column(No_TH; "No.") { }
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

            dataitem("Transfer Receipt Line"; "Transfer Receipt Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Line No.")
                                    ORDER(Ascending);
                column(LineNo_TransferLine; "Line No.") { }
                column(SerialNo; SerialNo) { }
                column(ItemNo_TL; "Item No.") { }
                column(UnitofMeasure_TL; BaseUOMVar) { }
                column(Description_TL; Description) { }
                column(Quantity_TL; "Quantity (Base)") { }
                column(QuantityBase_TL; "Quantity (Base)") { }
                column(AlterNateUOMCode; UOMCode) { }
                column(DecimalAllowed; DecimalAllowed) { }
                column(AlternateUOMQty; "Quantity (Base)" / AlternateQtyUOM) { }
                column(HSCode; HSCodeVar) { }
                column(Origin; OriginVar) { }
                column(Generic_Name; GenericNameVar) { }
                column(TotalAltQty; ("Quantity (Base)" / AlternateQtyUOM)) { }

                column(AltQtytransferline; "Quantity (Base)" / AlternateQtyUOM) { }
                column(LotExist; LotExist) { }

                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemLink = "Document No." = FIELD("Document No."),
                                   "Item No." = FIELD("Item No."),
                                   "Location Code" = FIELD("Transfer-to Code");
                    DataItemTableView = WHERE("Document Type" = FILTER("Transfer Receipt"));
                    column(LotNo_R; CustomLotNumber) { }
                    column(Quantity_Base_R; "Quantity") { }
                    column(AltQtyreservation; "Quantity" / AlternateQtyUOM) { }
                    column(AltQty1; "Quantity" / AlternateQtyUOM) { }
                    column(BOE_No; CustomBOENumber) { }
                }
                dataitem(Integer; Integer)
                {
                    DataItemTableView = SORTING(Number)
                                        ORDER(Ascending)
                                        WHERE(Number = const(1));

                    column(AlternateUOMQty11; "Transfer Receipt Line"."Quantity (Base)" / AlternateQtyUOM) { }
                }

                trigger OnAfterGetRecord()
                var
                    Item: Record Item;
                    Generic: Record KMP_TblGenericName;
                    CountryOrRegion: Record "Country/Region";
                    ILE_Rec: Record "Item Ledger Entry";
                    UnitofMeasure: Record "Unit of Measure";
                begin
                    //Serial No. Auto Increament
                    SerialNo := SerialNo + 1;
                    Clear(GenericNameVar);
                    Clear(OriginVar);
                    Clear(HSCodeVar);
                    Clear(BaseUOMVar);

                    if Item.Get("Transfer Receipt Line"."Item No.") then begin
                        if Generic.Get(Item.GenericName) then
                            GenericNameVar := Generic.Description;
                        if CountryOrRegion.Get(Item."Country/Region of Origin Code") then
                            OriginVar := CountryOrRegion.Name;
                        HSCodeVar := Item."Tariff No.";
                        BaseUOMVar := Item."Base Unit of Measure";
                    end;

                    //Getting the Minimum Alternate UOM Qty. and its code
                    CLEAR(DecimalAllowed);
                    AlternateQtyUOM := 0;
                    UOMCode := '';
                    ItemUnitMeasure.SETRANGE("Item No.", "Item No.");
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

                    LotExist := false;
                    ILE_Rec.Reset();
                    ILE_Rec.SetRange("Document No.", "Document No.");
                    ILE_Rec.SetRange("Document Line No.", "Line No.");
                    ILE_Rec.SetRange("Item No.", "Item No.");
                    ILE_Rec.SetRange("Location Code", "Transfer-to Code");
                    ILE_Rec.SetFilter("Lot No.", '<>%1', '');
                    if ILE_Rec.FindFirst() then
                        LotExist := true;
                end;
            }
            dataitem("Posted Transfer Txn. Comments"; "Posted Transfer Txn. Comments")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE("Document Type" = FILTER("Transfer Receipt"));
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
                transferline: Record "Transfer Receipt Line";
            begin
                CLEAR(TotalAltQty);
                CLEAR(TotalQty);
                if LocationFrom.Get("Transfer-from Code") then;
                if LocationTo.Get("Transfer-to Code") then;

                // Getting Country Name for Transfer from and to Addresses.
                IF FromAddressToggle THEN BEGIN
                    CountryRegion.GET(companyInfo."Country/Region Code");
                    FromCountryName := CountryRegion.Name
                END ELSE BEGIN
                    CountryRegion.GET(LocationFrom."Country/Region Code");
                    FromCountryName := CountryRegion.Name
                END;

                IF ToAddressToggle THEN BEGIN
                    CountryRegion.GET(companyInfo."Country/Region Code");
                    ToCountryName := CountryRegion.Name
                END ELSE BEGIN
                    CountryRegion.GET(LocationTo."Country/Region Code");
                    ToCountryName := CountryRegion.Name
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
                field("Hide From Warehouse"; FromAddressToggle)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF ToAddressToggle THEN BEGIN
                            ERROR('Only One Toggle can be selected');
                            FromAddressToggle := FALSE
                        END;
                    end;
                }
                field("Hide To Warehouse"; ToAddressToggle)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        IF FromAddressToggle THEN BEGIN
                            ERROR('Only One Toggle can be selected');
                            ToAddressToggle := FALSE
                        END;
                    end;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        Report_Lbl = 'Transfer';
        Report_Lbl1 = ' Receipt';
        Report_Lbl2 = ' (Warehouse to Warehouse)';
        Authority_Lbl = 'Authorized Signatory:';
        Stamp_Lbl = 'Stamp:';
        Date_Lbl = 'Date:';
        Remarks_Lbl = 'Both parties confirm with their signature that all the products are Delivered/Received in perfect condition. Please explain here if any discrepancy exists.';
        TrFrom_Lbl = 'Transfer From:';
        TrTo_Lbl = 'Transfer To:';
        SerialNo_Lbl = 'SN';
        ItemNo_Lbl = 'Item No.';
        Desc_Lbl = 'Description';
        LotNo_Lbl = 'Lot Number';
        Boe_Lbl = 'BOE Number';
        BaseUOM_Lbl = 'Base UOM';
        BUOMQ_Lbl = 'Base UOM Qty';
        AlUOM_Lbl = 'Alternate UOM';
        AlUOMQ_Lbl = 'Alternate UOM Qty';
        Total_Lbl = 'Total';
        PosDate_Lbl = 'Posting Date:';
        OrderNo_Lbl = 'Transfer Receipt No.:';
        RemarkHead_Lbl = 'Remarks:';
    }

    trigger OnInitReport()
    begin
        SerialNo := 0;
        RemarksSerial := 1;
    end;

    trigger OnPreReport()
    begin
        companyInfo.GET;
    end;

    var
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
}

