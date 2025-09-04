report 50505 "Certificate of Analysis_SOR"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Certificate of Analysis';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/Layout/CertificateOfAnalysis_SO.rdl';

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Header")
        {
            RequestFilterFields = "No.";
            column(Company_Image; CompInfoG.Picture) { }
            column(Image; CompInfoG.Picture) { }
            column(FooterText; FooterTextG) { }
            column(Compnay_Name; CompInfoG.name) { }//T45559-N
            column(Compy_Address_1; CompInfoG.Address) { }
            column(Compy_Address_2; CompInfoG."Address 2") { }
            column(Comp_Tel_No; 'Tel No.: ' + CompInfoG."Phone No.") { }
            column(Comp_TRN; 'TRN: ' + CompInfoG."VAT Registration No.") { }
            column(CompCity; CompInfoG.City) { }
            column(CompCountry; CountryRegionRec.Name) { }
            column(LCNo; "LC No. 2") { }
            column(LCDate; Format("LC Date 2", 0, '<day,2>/<Month,2>/<year4>')) { }

            dataitem("Item Ledger Entry"; "Reservation Entry")
            {
                DataItemLink = "Source ID" = field("No.");
                DataItemTableView = sorting("Source Ref. No.") where("Source Type" = const(37), "Quantity (Base)" = filter(< 0), "Source Subtype" = const(1));
                column(Document_No_; "Source ID") { }
                column(Document_Line_No_; "Source Ref. No.") { }
                column(HideTestMethod; HideTestMethod) { }
                column(ShowExpiry; ShowExpiry) { }
                column(Description; ItemDesc) { }
                column(CustomLotNumber; CustomLotNumber) { }
                column(CustomBOENumber; CustomBOENumber) { }
                column(Analysis_date; Format("Analysis Date", 0, '<day,2>-<Month Text>-<year4>')) { }
                column(Expiration_Date; Format(ExpirationDateG, 0, '<Month Text> <year4>')) { }
                column(Manufacturing_Date; Format("Manufacturing Date 2", 0, '<Month Text> <year4>')) { }
                dataitem("Lot Testing Parameter"; "Lot Testing Parameter")
                {
                    DataItemLink = "Source ID" = field("Source ID"), "Source Ref. No." = field("Source Ref. No."), "Item No." = field("Item No."), "Lot No." = field(CustomLotNumber), "BOE No." = field(CustomBOENumber);
                    DataItemTableView = sorting(Priority) where("Show in COA" = const(true));

                    column(Testing_Parameter; "Testing Parameter") { }
                    column(Code; Code) { }
                    column(Minimum; Minimum) { }
                    column(Maximum; Maximum) { }
                    column(Value; Value2) { }
                    column(Actual_Value; ItemTestingParameterValue) { }
                    column(Test_Method; TestingParameterG."Testing Parameter Code") { }
                    column(Sl_No; SlNoG) { }
                    column(Priority; ItemTestingParameterG.Priority) { }
                    column(Symbol; Symbol) { }

                    trigger OnAfterGetRecord()
                    var
                        myInt: Integer;
                    begin
                        TestingParameterG.Get(Code);
                        if not ItemTestingParameterG.Get("Item No.", code) then
                            if "Testing Parameter" = '' then
                                CurrReport.Skip();

                        // if "Actual Value" = '' then
                        //     CurrReport.Skip();

                        if not "Show in COA" then
                            CurrReport.Skip();

                        if "Actual Value" <> '' then
                            ItemTestingParameterValue := "Actual Value"
                        else
                            if "Default Value" AND "Show in COA" then
                                ItemTestingParameterValue := 'Pass'
                            else
                                if ("Actual Value" = '') AND ("Default Value" = false) then
                                    CurrReport.Skip();

                        SlNoG += 1;
                    end;
                }
                trigger OnAfterGetRecord()
                var
                    RecSalesLine: Record "Sales Line";
                begin
                    SlNoG := 0;
                    ItemG.Get("Item No.");
                    // Clear(SalesShipmentLineG);
                    // SalesShipmentLineG.Get("Document No.", "Document Line No.");
                    Clear(ExpirationDateG);
                    if "Expiration Date" > 0D then
                        ExpirationDateG := "Expiration Date"
                    else
                        if ("Manufacturing Date 2" > 0D) and (Format("Expiry Period 2") > '') then
                            ExpirationDateG := CalcDate("Expiry Period 2", "Manufacturing Date 2");//, 0, '<Month Text> <year4>');

                    Clear(ItemDesc);
                    clear(RecSalesLine);
                    RecSalesLine.SetRange("Document Type", "Sales Shipment Header"."Document Type");
                    RecSalesLine.SetRange("Document No.", "Sales Shipment Header"."No.");
                    RecSalesLine.SetRange("Line No.", "Item Ledger Entry"."Source Ref. No.");
                    if RecSalesLine.FindFirst() then
                        ItemDesc := RecSalesLine.Description;
                end;
            }
            trigger OnPreDataItem()
            var
                myInt: Integer;
            begin
                CompInfoG.get();
                CompInfoG.CalcFields(Picture);
                FooterTextG := CompanyName + ', ' + CompInfoG.Address + ', ' + CompInfoG."Address 2" + ' Tel:' + CompInfoG."Phone No." + ' Fax:' + CompInfoG."Fax No.";
                CountryRegionRec.Get(CompInfoG."Country/Region Code");
            end;
        }
    }


    requestpage
    {
        layout
        {

            area(Content)
            {
                field(ShowExpiry; ShowExpiry)
                {
                    ApplicationArea = all;
                    Caption = 'Show Expiry';

                }
                field(HideTestMethod; HideTestMethod)
                {
                    ApplicationArea = All;
                    Caption = 'Hide Test Method Column';
                }
            }
        }
        trigger OnOpenPage()
        begin
            ShowExpiry := false;
        end;
    }

    labels
    {
        LCNo_Lbl = 'LC No.: ';
        LCDate_Lbl = 'LC Date: ';
    }

    var
        TestingParameterG: Record "Testing Parameter";
        ItemTestingParameterG: Record "Item Testing Parameter";
        SalesShipmentLineG: Record "Sales Shipment Line";
        CompInfoG: Record "Company Information";
        ItemG: Record Item;
        SlNoG: Integer;
        FooterTextG: Text;
        ExpirationDateG: Date;
        ShowExpiry: Boolean;
        CountryRegionRec: Record "Country/Region";
        ItemTestingParameterValue: Text;
        ItemDesc: Text;
        HideTestMethod: Boolean;
}