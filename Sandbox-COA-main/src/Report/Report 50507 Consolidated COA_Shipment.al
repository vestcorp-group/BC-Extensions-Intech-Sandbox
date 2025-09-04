report 50507 "Consolidated COA_Shipment"
{
    ApplicationArea = All;
    Caption = 'Consolidated COA_Ship';
    UsageCategory = ReportsAndAnalysis;
    UseRequestPage = true;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Header"; "Sales Shipment Header")
        {

            RequestFilterFields = "No.";

            dataitem("Sales Line"; "Sales Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Line No.") order(ascending) where(Type = const(Item));

                trigger OnAfterGetRecord()
                var
                    PostedQcRcptline_lRec: Record "Posted QC Rcpt. Line";
                    PostQCRcpthdr_lRec: Record "Posted QC Rcpt. Header";
                    RecILE: Record "Item Ledger Entry";
                    RecCountry: Record "Country/Region";
                // ItemTestingParameter: Record "Item Testing Parameter";
                begin

                    SheetNumber += 1;

                    if not SheetCreated then
                        ExcelBuf.Reset();

                    ExcelBuf.DeleteAll();

                    Clear(RecILE);
                    RecILE.SetRange("Document No.", "Sales Line"."Document No.");
                    RecILE.SetRange("Document Line No.", "Sales Line"."Line No.");
                    //RecILE.SetRange("Source Type", Database::"Sales Line");
                    RecILE.SetRange("Item No.", "Sales Line"."No.");
                    RecILE.SetFilter(Quantity, '<0');
                    //RecILE.SetRange("Source Subtype", 1);
                    if RecILE.FindSet() then begin
                        if SheetCreated then begin
                            ExcelBuf.SetCurrent(0, 0);
                            ExcelBuf.SelectOrAddSheet(StrSubstNo("Sales Line"."No." + '_%1', SheetNumber));
                        end;
                    end;


                    Clear(RecILE);
                    RecILE.SetRange("Document No.", "Sales Line"."Document No.");
                    // RecILE.SetRange("Posted QC No.",);
                    RecILE.SetRange("Document Line No.", "Sales Line"."Line No.");
                    //RecILE.SetRange("Source Type", Database::"Sales Line");
                    RecILE.SetRange("Item No.", "Sales Line"."No.");
                    RecILE.SetFilter(Quantity, '<0');
                    //RecILE.SetRange("Source Subtype", 1);
                    if RecILE.FindSet() then begin
                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('Certificate of Analysis', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        //ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.AddColumn(RecCompanyInfo.Name, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        //ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.AddColumn(RecCompanyInfo.Address + ', ' + RecCompanyInfo.City, FALSE, '', false, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        //ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        Clear(RecCountry);
                        if RecCompanyInfo."Country/Region Code" <> '' then begin
                            RecCountry.GET(RecCompanyInfo."Country/Region Code");
                            ExcelBuf.AddColumn(RecCountry.Name, FALSE, '', false, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        end;

                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        //ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.AddColumn('Tel: ' + RecCompanyInfo."Phone No.", FALSE, '', false, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        //ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.AddColumn('Web: ' + RecCompanyInfo."Home Page", FALSE, '', false, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        //ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.AddColumn('TRN: ' + RecCompanyInfo."VAT Registration No.", FALSE, '', false, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('Product Description', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn(Description, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        //ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.AddColumn('#Container', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn("Sales Line"."Container No. 2", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                        MakeExcelDataHeader("Line No.", RecILE.CustomLotNumber, RecILE.CustomBOENumber);
                        // repeat
                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn(RecILE.CustomLotNumber, FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        PostQCRcpthdr_lRec.reset;
                        PostQCRcpthdr_lRec.SetRange("No.", RecILE."Posted QC No.");
                        if PostQCRcpthdr_lRec.FindFirst() then begin
                            Clear(PostedQcRcptline_lRec);
                            PostedQcRcptline_lRec.SetRange("No.", PostQCRcpthdr_lRec."No.");
                            if PostedQcRcptline_lRec.FindSet() then begin
                                repeat
                                    if (PostedQcRcptline_lRec.Required = true) AND (PostedQcRcptline_lRec.Print = true) then
                                        if PostedQcRcptline_lRec.Type = PostedQcRcptline_lRec.Type::Text then begin
                                            if PostedQcRcptline_lRec."Text Value" <> '' then
                                                ExcelBuf.AddColumn(PostedQcRcptline_lRec."Text Value", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                            if PostedQcRcptline_lRec."Actual Text" <> '' then
                                                ExcelBuf.AddColumn(PostedQcRcptline_lRec."Actual Text", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                            else
                                                if PostedQcRcptline_lRec."Vendor COA Text Result" <> '' then
                                                    ExcelBuf.AddColumn(PostedQcRcptline_lRec."Vendor COA Text Result", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                                else
                                                    ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                        end else begin
                                            if PostedQcRcptline_lRec."Min.Value" <> 0 then
                                                ExcelBuf.AddColumn(PostedQcRcptline_lRec."Min.Value", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                            else
                                                ExcelBuf.AddColumn('-', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                            if PostedQcRcptline_lRec."Actual Value" <> 0 then
                                                ExcelBuf.AddColumn(PostedQcRcptline_lRec."Actual Value", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                            else
                                                if PostedQcRcptline_lRec."Vendor COA Value Result" <> 0 then
                                                    ExcelBuf.AddColumn(PostedQcRcptline_lRec."Vendor COA Value Result", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                                else
                                                    ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                            if PostedQcRcptline_lRec."Max.Value" <> 0 then
                                                ExcelBuf.AddColumn(PostedQcRcptline_lRec."Max.Value", FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
                                            else
                                                ExcelBuf.AddColumn('-', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                            // end;
                                        end;
                                until PostedQcRcptline_lRec.Next() = 0;

                                if RecILE."Manufacturing Date 2" <> 0D then begin
                                    ExcelBuf.AddColumn(GetMonthName(Date2DMY(RecILE."Manufacturing Date 2", 2)), FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                    ExcelBuf.AddColumn(Date2DMY(RecILE."Manufacturing Date 2", 3), FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                    ExcelBuf.AddColumn(GetMonthName(Date2DMY(CalcDate(RecILE."Expiry Period 2", RecILE."Manufacturing Date 2"), 2)), FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                    ExcelBuf.AddColumn(Date2DMY(CalcDate(RecILE."Expiry Period 2", RecILE."Manufacturing Date 2"), 3), FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                end else begin
                                    ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                    ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                                    ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                    ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                end;

                                if PostQCRcpthdr_lRec."QC Date" <> 0D then begin
                                    ExcelBuf.AddColumn(GetMonthName(Date2DMY(PostQCRcpthdr_lRec."QC Date", 2)), FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                    ExcelBuf.AddColumn(Date2DMY(PostQCRcpthdr_lRec."QC Date", 3), FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                end else begin
                                    ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                    ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                                end;
                            end;
                        end;

                        // until RecILE.Next() = 0;
                        ExcelBuf.NewRow;
                        ExcelBuf.NewRow;
                        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('', FALSE, '', false, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);

                        ExcelBuf.AddColumn('Electronically', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn(' generated document', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('signature ', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);
                        ExcelBuf.AddColumn('not required', FALSE, '', TRUE, FALSE, false, '', ExcelBuf."Cell Type"::Text);

                        if not SheetCreated then begin
                            SheetCreated := true;
                            ExcelBuf.CreateNewBook(StrSubstNo(RecILE."Item No." + '_%1', SheetNumber));
                        end;
                        ExcelBuf.WriteSheet(Text102, COMPANYNAME, USERID);
                    end else
                        CurrReport.Skip();


                    // CurrReport.Skip();
                end;

            }
            trigger OnPreDataItem()
            begin

            end;
        }

    }

    trigger OnPreReport()
    begin
        Clear(RowNumber);
        SheetCreated := false;
        SheetNumber := 0;
        RecCompanyInfo.GET;
    end;


    trigger OnPostReport()
    var
        FileName: Text;
    begin
        FileName := 'COA_' + "Sales Header"."No." + DelChr(Format(CurrentDateTime), '=', ':AMPM\/ ');// + '.xlsx';
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(FileName);
        ExcelBuf.OpenExcel();
    end;




    local procedure MakeExcelDataHeader(LineNumber: Integer; LotNumber: Code[50]; BOE: Text[20])
    var
        RecLine: Record "Sales Shipment Line";
        PostedQCRcptline_lRec: Record "Posted QC Rcpt. Line";
        RecILE: Record "Item Ledger Entry";
        ParameterCount, i, J : Integer;
        char1, char2 : char;
        // ItemTestingParameter: Record "Item Testing Parameter";
        RowNumber: List of [Integer];
    begin
        char1 := 13;
        char2 := 10;
        Clear(RowNumber);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Batch / Pallet', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        Clear(RecLine);
        RecLine.SetRange("Document No.", "Sales Header"."No.");
        RecLine.SetRange(Type, RecLine.Type::Item);
        RecLine.SetRange("Line No.", LineNumber);
        if RecLine.FindSet() then begin
            repeat
                Clear(RecILE);
                RecILE.SetRange("Document No.", RecLine."Document No.");
                RecILE.SetRange("Document Line No.", LineNumber);
                //RecILE.SetRange("Source Type", Database::"Sales Line");
                RecILE.SetRange("Item No.", RecLine."No.");
                RecILE.SetFilter(Quantity, '<0');
                //RecILE.SetRange("Source Subtype", 1);
                RecILE.SetRange(CustomLotNumber, LotNumber);
                RecILE.SetRange(CustomBOENumber, BOE);
                RecILE.FindFirst();

                ParameterCount := 0;
                Clear(PostedQCRcptline_lRec);
                //   PostedQCRcptline_lRec.SetRange("Item No.", RecLine."No.");
                PostedQCRcptline_lRec.SetRange("No.", RecILE."Posted QC No.");
                if PostedQCRcptline_lRec.FindSet() then begin
                    repeat
                        ParameterCount += 1;
                        //  RecLotTestingParameter.CalcFields("Testing Parameter Code");
                        // if PostedQCRcptline_lRec.Type = PostedQCRcptline_lRec.Type::Text then
                        if (PostedQcRcptline_lRec.Required = true) AND (PostedQcRcptline_lRec.Print = true) then begin
                            ExcelBuf.AddColumn(PostedQCRcptline_lRec.Description, FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                            // ExcelBuf.AddColumn(RecLotTestingParameter."Testing Parameter" + Format(char1) + Format(char2) + RecLotTestingParameter."Testing Parameter Code", FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                            // Clear(ItemTestingParameter);
                            // ItemTestingParameter.SetRange("Item No.", RecLotTestingParameter."Item No.");
                            // ItemTestingParameter.SetRange(Code, RecLotTestingParameter.Code);
                            // if ItemTestingParameter.FindFirst() then begin
                            if PostedQCRcptline_lRec.Type = PostedQCRcptline_lRec.Type::Text then begin
                                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                                RowNumber.Add(ParameterCount);
                            end else begin
                                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                                ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                                // end;
                            end;

                        end;
                    until PostedQCRcptline_lRec.Next() = 0;
                    ExcelBuf.AddColumn('Manufacturing', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                    ExcelBuf.AddColumn('Expiry', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                    ExcelBuf.AddColumn('Analysis', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                    //next row  
                    ExcelBuf.NewRow;
                    ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    //for i := 1 to ParameterCount do begin

                    Clear(PostedQCRcptline_lRec);
                    PostedQCRcptline_lRec.SetRange("No.", RecILE."Posted QC No.");
                    if PostedQCRcptline_lRec.FindSet() then begin
                        repeat
                            if (PostedQcRcptline_lRec.Required = true) AND (PostedQcRcptline_lRec.Print = true) then begin
                                if PostedQCRcptline_lRec.Type = PostedQCRcptline_lRec.Type::Text then begin
                                    ExcelBuf.AddColumn('Spec', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                                    ExcelBuf.AddColumn('Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                                end else begin
                                    ExcelBuf.AddColumn('Min', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                                    ExcelBuf.AddColumn('Value', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                                    ExcelBuf.AddColumn('Max', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                                end;
                            end;
                        until PostedQCRcptline_lRec.Next() = 0;
                    end;

                    ExcelBuf.AddColumn('Month', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Year', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                    ExcelBuf.AddColumn('Month', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Year', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                    ExcelBuf.AddColumn('Month', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
                    ExcelBuf.AddColumn('Year', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);

                end;
            until RecLine.Next() = 0;
        end;
    END;

    local procedure GetMonthName(Number: Integer): Text
    begin
        case Number of
            1:
                exit('January');
            2:
                exit('February');
            3:
                exit('March');
            4:
                exit('April');
            5:
                exit('May');
            6:
                exit('June');
            7:
                exit('July');
            8:
                exit('August');
            9:
                exit('September');
            10:
                exit('october');
            11:
                exit('November');
            12:
                exit('December');

        end;
    end;

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        ReportName: Label 'Certificate of Analysis';
        TenantMedia: Record "Tenant Media";
        OutStr: OutStream;
        Text101: Label 'Data';
        Text103: Label 'Certificate of';
        Text102: Label 'Certificate of Analysis';
        Text104: Label 'Report No.';
        Text105: Label 'Report Name';
        Text106: Label 'User ID';
        Text107: Label 'Date / Time';
        //Text108: Label 'Filter';
        //VATFilters: Text;
        RowNumber: Integer;
        SheetCreated: Boolean;
        SheetNumber: Integer;
        RecCompanyInfo: Record "Company Information";
}
