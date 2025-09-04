// report 50513 "Certificate of Analysis ILE N"
// {
//     UsageCategory = Administration;
//     ApplicationArea = All;
//     Caption = 'Certificate of Analysis ILE';
//     DefaultLayout = RDLC;
//     RDLCLayout = './src/Report/Layout/CertificateOfAnalysisILE.rdl';

//     dataset
//     {
//         dataitem("Item Ledger Entry"; "Item Ledger Entry")
//         {
//             // DataItemLink = "Document No." = field("No.");
//             DataItemTableView = sorting("Document Line No.");
//             //  where("Document Type" = filter("Sales Shipment"), Quantity = filter(< 0))
//             column(Document_No_; "Document No.") { }
//             column(Document_Line_No_; "Document Line No.") { }
//             column(ShowExpiry; ShowExpiry) { }
//             column(HideTestMethod; HideTestMethod)
//             {

//             }
//             column(Description; ItemDescription) { }
//             column(CustomLotNumber; CustomLotNumber) { }
//             column(CustomBOENumber; CustomBOENumber) { }
//             column(Analysis_date; Format("Analysis Date", 0, '<day,2>-<Month Text>-<year4>')) { }
//             column(Expiration_Date; Format(ExpirationDateG, 0, '<Month Text> <year4>')) { }
//             column(Manufacturing_Date; Format("Manufacturing Date 2", 0, '<Month Text> <year4>')) { }
//             column(Image; CompInfoG.Picture) { }
//             column(Compnay_Name; CompInfoG.name) { }
//             column(Compy_Address_1; CompInfoG.Address) { }
//             column(Compy_Address_2; CompInfoG."Address 2") { }
//             column(CompCity; CompInfoG.City) { }
//             column(CompCountry; CountryRegionRec.Name) { }

//             column(Comp_Tel_No; 'Tel No.: ' + CompInfoG."Phone No.") { }
//             column(Comp_TRN; 'TRN: ' + CompInfoG."VAT Registration No.") { }
//             column(FooterText; FooterTextG) { }
//             column(Company_Image; CompInfoG.Picture) { }
//             dataitem("Post Lot Var Testing Parameter"; "Post Lot Var Testing Parameter")
//             {
//                 DataItemLink = "Source ID" = field("Document No."), "Source Ref. No." = field("Document Line No."), "Item No." = field("Item No."), "Variant Code" = field("Variant Code"), "Lot No." = field(CustomLotNumber), "BOE No." = field(CustomBOENumber);
//                 DataItemTableView = sorting(Priority) where("Show in COA" = const(true));
//                 // DataItemTableView = sorting(Priority) where("Actual Value" = filter(<> ''));
//                 column(Testing_Parameter; "Testing Parameter") { }
//                 column(Code; Code) { }
//                 column(Minimum; Minimum) { DecimalPlaces = 0 : 5; }
//                 column(Maximum; Maximum) { DecimalPlaces = 0 : 5; }
//                 column(Value; Value2) { }
//                 column(Actual_Value; ItemTestingParameterValue) { }
//                 column(Test_Method; TestingParameterG."Testing Parameter Code") { }
//                 column(Sl_No; SlNoG) { }
//                 column(Priority; ItemTestingParameterG.Priority) { }
//                 column(Symbol; Symbol) { }

//                 trigger OnAfterGetRecord()
//                 var
//                     myInt: Integer;
//                 begin
//                     TestingParameterG.Get(Code);
//                     if not ItemTestingParameterG.Get("Item No.", code) then
//                         if "Testing Parameter" = '' then
//                             CurrReport.Skip();

//                     // if "Actual Value" = '' then
//                     //     CurrReport.Skip();

//                     if not "Show in COA" then
//                         CurrReport.Skip();

//                     if "Actual Value" <> '' then
//                         ItemTestingParameterValue := "Actual Value"
//                     else
//                         if "Default Value" AND "Show in COA" then
//                             ItemTestingParameterValue := 'Pass'
//                         else
//                             if ("Actual Value" = '') AND ("Default Value" = false) then
//                                 CurrReport.Skip();

//                     SlNoG += 1;
//                 end;
//             }
//             // dataitem("Company Information"; "Company Information")
//             // {
//             //     // RequestFilterFields = "No.";
//             //     // column(Company_Image; CompInfoG.Picture) { }

//             //     // column(FooterText; FooterTextG) { }
//             //     // column(Compnay_Name; CompanyName) { }
//             //     // column(Compy_Address_1; Address) { }
//             //     // column(Compy_Address_2; "Address 2") { }
//             //     // column(Comp_Tel_No; 'Tel No.: ' + "Phone No.") { }
//             //     // column(Comp_TRN; 'TRN: ' + "VAT Registration No.") { }


//             //     trigger OnPreDataItem()
//             //     var
//             //         myInt: Integer;
//             //     begin
//             //         // CompInfoG.get();
//             //         // CompInfoG.CalcFields(Picture);
//             //         // FooterTextG := CompanyName + ', ' + Address + ', ' + "Address 2" + ' Tel:' + "Phone No." + ' Fax:' + "Fax No.";
//             //     end;
//             // }
//             trigger OnAfterGetRecord()
//             var
//                 VariantRec: Record "Item Variant";
//             begin
//                 SlNoG := 0;
//                 ItemG.Get("Item No.");
//                 // Clear(SalesShipmentLineG);
//                 // SalesShipmentLineG.Get("Document No.", "Document Line No.");
//                 ItemDescription := ItemG.Description;
//                 if "Variant Code" <> '' then begin
//                     VariantRec.Get("Item No.", "Variant Code");
//                     if VariantRec.Description <> '' then begin
//                         ItemDescription := VariantRec.Description
//                     end else begin
//                         ItemDescription := ItemG.Description;
//                     end;
//                 end;

//                 Clear(ExpirationDateG);
//                 if "Expiration Date" > 0D then
//                     ExpirationDateG := "Expiration Date"
//                 else
//                     if ("Manufacturing Date 2" > 0D) and (Format("Expiry Period 2") > '') then
//                         ExpirationDateG := CalcDate("Expiry Period 2", "Manufacturing Date 2");//, 0, '<Month Text> <year4>');
//             end;

//             trigger OnPreDataItem()
//             var
//                 myInt: Integer;

//             begin
//                 Clear(CompInfoG);
//                 if CompanyFilter <> '' then begin
//                     CompInfoG.ChangeCompany(CompanyFilter);
//                 end;
//                 CompInfoG.get();
//                 CompInfoG.CalcFields(Picture);
//                 FooterTextG := CompanyName + ', ' + CompInfoG.Address + ', ' + CompInfoG."Address 2" + ' Tel:' + CompInfoG."Phone No." + ' Fax:' + CompInfoG."Fax No.";
//                 CountryRegionRec.Get(CompInfoG."Country/Region Code");
//             end;
//         }


//     }


//     requestpage
//     {
//         layout
//         {

//             area(Content)
//             {
//                 field(ShowExpiry; ShowExpiry)
//                 {
//                     ApplicationArea = all;
//                     Caption = 'Show Expiry';

//                 }
//                 field(CompanyFilter; CompanyFilter)
//                 {
//                     ApplicationArea = All;
//                     TableRelation = Company;
//                     Caption = 'Company Name';
//                 }
//                 field(HideTestMethod; HideTestMethod)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Hide Test Method Column';
//                 }
//             }
//         }
//         trigger OnOpenPage()
//         begin
//             ShowExpiry := false;
//         end;
//     }
//     var
//         TestingParameterG: Record "Testing Parameter";
//         ItemTestingParameterG: Record "Item Testing Parameter";
//         SalesShipmentLineG: Record "Sales Shipment Line";
//         CompInfoG: Record "Company Information";
//         ItemG: Record Item;
//         SlNoG: Integer;
//         FooterTextG: Text;
//         ExpirationDateG: Date;
//         ShowExpiry: Boolean;

//         CountryRegionRec: Record "Country/Region";
//         ItemTestingParameterValue: Text;
//         CompanyFilter: Text;
//         HideTestMethod: Boolean;
//         ItemDescription: Text;
// }