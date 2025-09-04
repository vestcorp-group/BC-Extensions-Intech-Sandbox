report 50510 "Certificate of Analysis New"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Certificate of Analysis';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Report/Layout/CertificateOfAnalysis.rdl';

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            RequestFilterFields = "No.";
            column(Company_Image; CompInfoG.Picture) { }
            column(Image; CompInfoG.Picture) { }
            column(FooterText; FooterTextG) { }
            column(Compnay_Name; CompInfoG.name) { }//T45559-N
            column(Compy_Address_1; CompInfoG.Address) { }
            column(Compy_Address_2; CompInfoG."Address 2") { }
            column(Comp_Tel_No; 'Tel No.: ' + CompInfoG."Phone No.") { }
            column(Comp_TRN; 'GST No.: ' + CompInfoG."VAT Registration No.") { }
            column(CompCity; CompInfoG.City) { }
            column(CompCountry; CountryRegionRec.Name) { }
            column(LCNo; "LC No. 2") { }
            column(LCDate; Format("LC Date 2", 0, '<day,2>/<Month,2>/<year4>')) { }

            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document Line No.") where("Document Type" = filter("Sales Shipment"), Quantity = filter(< 0));
                column(Document_No_; "Document No.") { }
                column(Document_Line_No_; "Document Line No.") { }
                column(ShowExpiry; ShowExpiry) { }
                column(HideTestMethod; HideTestMethod)
                {

                }
                column(Description; ItemDesc) { }
                column(CustomLotNumber; CustomLotNumber) { }
                column(CustomBOENumber; CustomBOENumber) { }
                column(Lot_No_; "Lot No.") { }
                // column(Analysis_date; Format("Analysis Date", 0, '<day,2>-<Month Text>-<year4>')) { } //T13004-O 03-02-2025
                column(Expiration_Date; Format(ExpirationDateG, 0, '<Month Text> <year4>')) { }
                column(Manufacturing_Date; Format("Manufacturing Date 2", 0, '<Month Text> <year4>')) { }
                dataitem("Posted QC Rcpt. Header"; "Posted QC Rcpt. Header")
                {
                    DataItemLink = "No." = field("Posted QC No."), "Item No." = field("Item No."), "Variant Code" = field("Variant Code");
                    DataItemTableView = sorting("No.");
                    column(Analysis_date; Format("QC Date", 0, '<day,2>-<Month Text>-<year4>')) { } //T13004-N 03-02-2025

                    dataitem("Posted QC Rcpt. Line"; "Posted QC Rcpt. Line")
                    {
                        DataItemLink = "No." = field("No.");
                        column(Type; Type) { }
                        column(Testing_Parameter; Description) { }
                        column(Test_Method; "Method Description") { }
                        // column(Minmum_gDec; Minmum_gDec) { }
                        // column(Maximum_gDec; Maximum_gDec) { }
                        // column(ActualText_gTxt; ActualText_gTxt) { }
                        column(Minimum; Minmum_gDec) { }
                        column(Maximum; Maximum_gDec) { }
                        column(Value; Text_gTxt) { }
                        column(Actual_Value; ActualText_gTxt) { }
                        //     column(Test_Method; TestingParameterG."Testing Parameter Code") { }
                        column(Sl_No; SlNoG) { }
                        //     column(Priority; ItemTestingParameterG.Priority) { }
                        //     column(Symbol; Symbol) { }
                        //     column(Lot_No_; "Lot No.") { }

                        trigger OnPreDataItem()
                        var
                            myInt: Integer;
                        begin

                        end;

                        trigger OnAfterGetRecord()
                        var
                            myInt: Integer;
                        begin
                            ActualText_gTxt := '';
                            Text_gTxt := '';
                            Minmum_gDec := 0;
                            Maximum_gDec := 0;

                            if Type = Type::Range then begin
                                Minmum_gDec := "Min.Value";
                                Maximum_gDec := "Max.Value";
                                if "Actual Value" <> 0 then
                                    ActualText_gTxt := Format("Actual Value")
                                else
                                    ActualText_gTxt := Format("Vendor COA Value Result");
                            end;
                            if Type = Type::Minimum then begin
                                Minmum_gDec := "Min.Value";
                                Maximum_gDec := "Max.Value";
                                if "Actual Value" <> 0 then
                                    ActualText_gTxt := Format("Actual Value")
                                else
                                    ActualText_gTxt := Format("Vendor COA Value Result");
                            end;
                            if Type = Type::Maximum then begin
                                Minmum_gDec := "Min.Value";
                                Maximum_gDec := "Max.Value";
                                if "Actual Value" <> 0 then
                                    ActualText_gTxt := Format("Actual Value")
                                else
                                    ActualText_gTxt := Format("Vendor COA Value Result");
                            end;
                            if Type = Type::Text then begin
                                Text_gTxt := "Text Value";
                                if "Actual Text" <> '' then
                                    ActualText_gTxt := "Actual Text"
                                else
                                    ActualText_gTxt := "Vendor COA Text Result";
                            end;

                            SlNoG += 1;

                            if ("Posted QC Rcpt. Line".Print = false) OR ("Posted QC Rcpt. Line".Required = false) then
                                CurrReport.Skip();

                        end;


                    }
                }


                // dataitem("Post Lot Var Testing Parameter"; "Post Lot Var Testing Parameter")
                // {
                //     DataItemLink = "Source ID" = field("Document No."), "Source Ref. No." = field("Document Line No."), "Item No." = field("Item No."), "Variant Code" = field("Variant Code"), "Lot No." = field(CustomLotNumber), "BOE No." = field(CustomBOENumber);
                //     DataItemTableView = sorting(Priority) where("Show in COA" = const(true));
                //     //DataItemTableView = sorting(Priority) where("Actual Value" = filter(<> ''));
                //     column(Testing_Parameter; "Testing Parameter") { }
                //     column(Code; Code) { }
                //     column(Minimum; Minimum) { }
                //     column(Maximum; Maximum) { }
                //     column(Value; Value2) { }
                //     column(Actual_Value; ItemTestingParameterValue) { }
                //     column(Test_Method; TestingParameterG."Testing Parameter Code") { }
                //     column(Sl_No; SlNoG) { }
                //     column(Priority; ItemTestingParameterG.Priority) { }
                //     column(Symbol; Symbol) { }
                //     column(Lot_No_; "Lot No.") { }

                //     trigger OnAfterGetRecord()
                //     var
                //         myInt: Integer;
                //     begin
                //         Clear(ItemTestingParameterValue);
                //         TestingParameterG.Get(Code);

                //         if not ItemTestingParameterG.Get("Item No.", code) then
                //             if "Testing Parameter" = '' then
                //                 CurrReport.Skip();

                //         // if "Actual Value" = '' then
                //         //     CurrReport.Skip();

                //         if not "Show in COA" then
                //             CurrReport.Skip();

                //         if "Actual Value" <> '' then
                //             ItemTestingParameterValue := "Actual Value"
                //         else
                //             if "Default Value" AND "Show in COA" then
                //                 ItemTestingParameterValue := 'Pass'
                //             else
                //                 if ("Actual Value" = '') AND ("Default Value" = false) then
                //                     CurrReport.Skip();
                //       
                //     end;
                // }
                trigger OnAfterGetRecord()
                var
                    RecSalesLine: Record "Sales Shipment Line";
                begin
                    SlNoG := 0;
                    ItemG.Get("Item No.");
                    Clear(SalesShipmentLineG);
                    SalesShipmentLineG.Get("Document No.", "Document Line No.");
                    Clear(ExpirationDateG);
                    if "Expiration Date" > 0D then
                        ExpirationDateG := "Expiration Date"
                    else
                        if ("Manufacturing Date 2" > 0D) and (Format("Expiry Period 2") > '') then
                            ExpirationDateG := CalcDate("Expiry Period 2", "Manufacturing Date 2");//, 0, '<Month Text> <year4>');

                    Clear(ItemDesc);
                    clear(RecSalesLine);
                    RecSalesLine.SetRange("Document No.", "Sales Shipment Header"."No.");
                    RecSalesLine.SetRange("Line No.", "Item Ledger Entry"."Document Line No.");
                    if RecSalesLine.FindFirst() then
                        ItemDesc := RecSalesLine.Description;
                end;
            }
            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");

                trigger OnPreDataItem()
                var
                    Ile: Record "Item Ledger Entry";
                begin
                    if "QC Created" then
                        DocNo_gCod := "Sales Shipment Line"."Document No."
                    else begin
                        ile.Reset();
                        ile.SetRange("Document No.", "Sales Shipment Header"."No.");
                        ile.SetRange("Item No.", "Sales Shipment Line"."No.");
                        ile.SetFilter("Posted QC No.", '<>%1', '');
                        if Ile.FindFirst() then
                            DocNo_gCod := Ile."Posted QC No.";

                    end;

                end;

                // end;

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
        DocNo_gCod: Code[50];
        Minmum_gDec: Decimal;
        Maximum_gDec: Decimal;
        ActualText_gTxt: Text;
        Text_gTxt: Text;
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