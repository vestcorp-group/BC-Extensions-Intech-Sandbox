// codeunit 60015 "E-Invoice Events"//T12370-Full Comment
// {

//     Permissions = tabledata "Sales Invoice Header" = RIMD;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeReleaseSalesDocument', '', false, false)]
//     local procedure OnBeforeReleaseSalesDocument(SalesHeader: Record "Sales Header"; PreviewMode: Boolean);
//     begin
//         if SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice] then begin
//             ValidateSalesHeader(SalesHeader);
//             RemoveValuesFromEnVoiceFields(SalesHeader);
//         end;
//     end;

//     [EventSubscriber(ObjectType::Page, Page::"Sales Order", 'OnBeforeActionEvent', 'SendApprovalRequest', false, false)]
//     local procedure EInvoiceValidation_SO(var Rec: Record "Sales Header")
//     begin
//         ValidateSalesHeader(Rec);
//     end;

//     [EventSubscriber(ObjectType::Page, Page::"Sales Invoice", 'OnBeforeActionEvent', 'SendApprovalRequest', false, false)]
//     local procedure EInvoiceValidation_SI(var Rec: Record "Sales Header")
//     begin
//         ValidateSalesHeader(Rec);
//     end;


//     local procedure ValidateSalesHeader(var SalesHeader: Record "Sales Header")
//     var
//         RecCountry: Record "Country/Region";
//         RecTransportMethod: Record "Transport Method";
//         companyInfo: Record "Company Information";
//         RecLines: Record "Sales Line";
//         RecIUOM: Record "Unit of Measure";
//         Vehicleformat: Label '^[A-Z]{2}[0-9]{2}[A-Z]{2}[0-9]{4}$';
//         CheckvehicleNumber: Codeunit Regex;
//         RecEntry: Record "Entry/Exit Point";
//         SLine: Record "Sales Line";
//         RecLocation: Record Location;
//     begin
//         if SalesHeader."Document Type" IN [SalesHeader."Document Type"::Order, SalesHeader."Document Type"::Invoice] then begin
//             if SalesHeader."Sell-to Country/Region Code" = 'IND' then begin
//                 SalesHeader.TestField("Customer GST Reg. No.");
//                 SalesHeader.TestField("GST Bill-to State Code");
//                 SalesHeader.TestField("Sell-to Post Code");
//             end else begin
//                 SalesHeader.TestField("Exit Point");
//                 RecEntry.GET(SalesHeader."Exit Point");
//                 RecEntry.TestField("State Code");
//                 RecEntry.TestField("Post code");
//             end;
//             companyInfo.GET;
//             companyInfo.TestField("GST Registration No.");
//             companyInfo.TestField("State Code");
//             SalesHeader.TestField("Location State Code");
//             if SalesHeader."Sell-to Country/Region Code" <> '' then begin
//                 Clear(RecCountry);
//                 RecCountry.GET(SalesHeader."Sell-to Country/Region Code");
//                 RecCountry.TestField("E-Invoice Code");
//             end;
//             SalesHeader.TestField("Transport Method");

//             /*if SalesHeader."Transport Method" <> '' then begin
//                 Clear(RecTransportMethod);
//                 RecTransportMethod.GET(SalesHeader."Transport Method");
//                 RecTransportMethod.TestField("E-Invoice Code");
//                 if RecTransportMethod."E-Invoice Code" = 'ROAD' then begin
//                     SalesHeader.TestField("Vehicle Type");
//                     SalesHeader.TestField("Vehicle No.");
//                     if SalesHeader."Vehicle No." <> '' then begin
//                         if not CheckvehicleNumber.IsMatch(SalesHeader."Vehicle No.", Vehicleformat, 0) then
//                             Error('Vehicle No. is not valid. It must be in %1 format.', 'KA12KA1234');
//                     end
//                 end else begin
//                     SalesHeader.TestField("Transport Doc No.");
//                     SalesHeader.TestField("Transport Doc Date");
//                 end;
//             end;*/

//             Clear(RecLines);
//             RecLines.SetRange("Document Type", SalesHeader."Document Type");
//             RecLines.SetRange("Document No.", SalesHeader."No.");
//             if RecLines.FindSet() then
//             //comment
//             begin
//                 repeat
//                     if RecLines."Base UOM 2" <> '' then begin
//                         Clear(RecIUOM);
//                         if RecIUOM.GET(RecLines."Base UOM 2") then begin
//                             RecIUOM.TestField("E-Invoice Code");
//                         end;
//                     end;

//                     if RecLines.LineCountryOfOrigin <> '' then begin
//                         Clear(RecCountry);
//                         RecCountry.Get(RecLines.LineCountryOfOrigin);
//                         RecCountry.TestField("E-Invoice Code");
//                     end;
//                 until RecLines.Next() = 0;
//             end;

//             Clear(SLine);
//             SLine.SetRange("Document Type", SalesHeader."Document Type"::Order);
//             SLine.SetRange("Document No.", SalesHeader."No.");
//             SLine.SetRange(Type, SLine.Type::Item);
//             SLine.SetFilter("Location Code", '<>%1', '');
//             if SLine.FindFirst() then begin
//                 Clear(RecLocation);
//                 RecLocation.SetRange(Code, SLine."Location Code");
//                 if RecLocation.FindFirst() then begin
//                     SalesHeader."Dispatch From GSTIN" := RecLocation."GST Registration No.";
//                     SalesHeader."Dispatch From Legal Name" := RecLocation.Name;
//                     SalesHeader."Dispatch From Trade Name" := RecLocation.Name;
//                     SalesHeader."Dispatch From Address 1" := RecLocation.Address;
//                     SalesHeader."Dispatch From Address 2" := RecLocation."Address 2";
//                     SalesHeader."Dispatch From Location" := RecLocation.City;
//                     SalesHeader."Dispatch From State Code" := RecLocation."State Code";
//                     SalesHeader."Dispatch From Pincode" := RecLocation."Post Code";
//                     SalesHeader.Modify();
//                 end;
//             end;
//         end;
//     end;

//     procedure UpdateGSTIN(Number: Text)
//     var
//         RecCustomer: Record Customer;
//         RecHdr: Record "Sales Invoice Header";
//     begin
//         RecHdr.GET(Number);
//         Clear(RecCustomer);
//         RecCustomer.GET(RecHdr."Sell-to Customer No.");
//         RecHdr."Customer GST Reg. No." := RecCustomer."GST Registration No.";
//         RecHdr.Modify();
//     end;

//     local procedure RemoveValuesFromEnVoiceFields(var SalesHeader: Record "Sales Header")
//     begin
//         SalesHeader."E-Invoice Ack Date" := 0DT;
//         SalesHeader."E-Invoice ACK No." := '';
//         SalesHeader."E-Invoice API Response" := '';
//         SalesHeader."E-Invoice API Status" := SalesHeader."E-Invoice API Status"::" ";
//         SalesHeader."E-Invoice EWB Date" := 0DT;
//         SalesHeader."E-Invoice EWB No." := '';
//         SalesHeader."E-Invoice EWB Valid Till" := 0DT;
//         SalesHeader."E-Invoice GenBy" := '';
//         SalesHeader."E-Invoice GenBy Name" := '';
//         SalesHeader."E-Invoice Generated At" := 0DT;
//         SalesHeader."E-Invoice Id" := '';
//         SalesHeader."E-Invoice IRN" := '';
//         SalesHeader."E-Invoice Message" := '';
//         SalesHeader."E-Invoice No." := '';
//         SalesHeader."E-Invoice Status" := '';
//         SalesHeader."Transport Doc Date" := 0D;
//         SalesHeader."Transport Doc No." := '';
//         SalesHeader."Transporter ID" := '';
//         SalesHeader."Transporter Name" := '';
//         SalesHeader.Modify();

//     end;
// }
