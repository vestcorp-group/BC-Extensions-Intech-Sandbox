// codeunit 58158 "KM Attachment Management"//T12370-Full Comment
// {
//     trigger OnRun()
//     begin

//     end;

//     var
//         myInt: Integer;

//     [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterInsertEvent', '', true, true)]
//     local procedure AttMngmt(var Rec: Record "Purchase Line")
//     var
//         PurchHeader: Record "Purchase Header";
//         Doc_att_from: Record "Document Attachment";
//         Doc_att_to: Record "Document Attachment";
//         Tenent_media: Record "Tenant Media";
//         purchline: Record "Purchase Line";
//         PurchRcptLine: Record "Purch. Rcpt. Line";
//     begin

//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Get Receipt", 'OnAfterInsertLines', '', true, true)]
//     local procedure PurchaseInvoiceAttachementManagement(var PurchHeader: Record "Purchase Header")

//     var
//         //  PurchHeader: Record "Purchase Header";
//         Doc_att_from: Record "Document Attachment";
//         Doc_att_to: Record "Document Attachment";
//         Tenent_media: Record "Tenant Media";
//         purchline: Record "Purchase Line";
//         PurchRcptLine: Record "Purch. Rcpt. Line";
//     begin
//         purchline.SetRange("Document No.", PurchHeader."No.");
//         // purchline.SetRange("Document Type", PurchHeader."Document Type"::Invoice);

//         purchline.SetRange(Type, purchline.Type::Item);
//         if purchline.FindSet() then begin
//             repeat
//                 if (purchline."Receipt No." <> '') and (purchline."Document Type" = purchline."Document Type"::Invoice) and (purchline.Type <> purchline.Type::" ") then begin
//                     PurchRcptLine.SetRange("Document No.", purchline."Receipt No.");
//                     if PurchRcptLine.FindFirst() then begin
//                         Doc_att_from.SetRange("No.", PurchRcptLine."Order No.");
//                     end;
//                     if Doc_att_from.FindSet() then
//                         repeat
//                             //  if (Doc_att_to."Document Type" = purchline."Document Type") and (Doc_att_to."No." = purchline."Document No.") /*and (Format(Doc_att_from."Document Reference ID") = Format(Doc_att_to."Document Reference ID"))  then begin
//                             Doc_att_to.Init();
//                             Doc_att_to.ID := Doc_att_from.ID;
//                             Doc_att_to."Table ID" := Doc_att_from."Table ID";
//                             Doc_att_to."No." := purchline."Document No.";
//                             Doc_att_to."Attached Date" := Doc_att_from."Attached Date";
//                             Doc_att_to."File Name" := Doc_att_from."File Name";
//                             Doc_att_to."File Type" := Doc_att_from."File Type";
//                             Doc_att_to."File Extension" := Doc_att_from."File Extension";
//                             Doc_att_to."Document Reference ID" := Doc_att_from."Document Reference ID";
//                             Doc_att_to."Attached By" := Doc_att_from."Attached By";
//                             Doc_att_to.User := Doc_att_from.User;
//                             Doc_att_to."Document Flow Purchase" := Doc_att_from."Document Flow Purchase";
//                             Doc_att_to."Document Flow Sales" := Doc_att_from."Document Flow Sales";
//                             Doc_att_to."Document Type" := purchline."Document Type";
//                             if Doc_att_to.Insert() then;
//                         until Doc_att_from.Next() = 0;
//                 end;
//             until purchline.Next() = 0;
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Get Shipment", 'OnAfterInsertLines', '', true, true)]
//     local procedure SalesInvoiceAttachementmanagement(var SalesHeader: Record "Sales Header")
//     var
//         Doc_att_from: Record "Document Attachment";
//         Doc_att_to: Record "Document Attachment";
//         Tenent_media: Record "Tenant Media";
//         SalesLine: Record "Sales Line";
//         SalesShipmentLine: Record "Sales Shipment Line";
//     begin
//         SalesLine.SetRange("Document No.", SalesHeader."No.");
//         SalesLine.SetRange(Type, SalesLine.Type::Item);
//         if SalesLine.FindSet() then begin
//             repeat
//                 if (SalesLine."Shipment No." <> '') and (SalesLine."Document Type" = SalesLine."Document Type"::Invoice) and (SalesLine.Type <> SalesLine.Type::" ") then begin
//                     SalesShipmentLine.SetRange("Document No.", SalesLine."Shipment No.");
//                     if SalesShipmentLine.FindFirst() then begin
//                         Doc_att_from.SetRange("No.", SalesShipmentLine."Order No.");
//                     end;
//                     if Doc_att_from.FindSet() then
//                         repeat
//                             Doc_att_to.Init();
//                             Doc_att_to.ID := Doc_att_from.ID;
//                             Doc_att_to."Table ID" := Doc_att_from."Table ID";
//                             Doc_att_to."No." := SalesLine."Document No.";
//                             Doc_att_to."Attached Date" := Doc_att_from."Attached Date";
//                             Doc_att_to."File Name" := Doc_att_from."File Name";
//                             Doc_att_to."File Type" := Doc_att_from."File Type";
//                             Doc_att_to."File Extension" := Doc_att_from."File Extension";
//                             Doc_att_to."Document Reference ID" := Doc_att_from."Document Reference ID";
//                             Doc_att_to."Attached By" := Doc_att_from."Attached By";
//                             Doc_att_to.User := Doc_att_from.User;
//                             Doc_att_to."Document Flow Purchase" := Doc_att_from."Document Flow Purchase";
//                             Doc_att_to."Document Flow Sales" := Doc_att_from."Document Flow Sales";
//                             Doc_att_to."Document Type" := SalesLine."Document Type";
//                             if Doc_att_to.Insert() then;
//                         until Doc_att_from.Next() = 0;
//                 end;
//             until SalesLine.Next() = 0;
//         end;
//     end;


// }