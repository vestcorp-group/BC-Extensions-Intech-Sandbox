// report 50480 "Sale Doc Approved Notification"//T12370-Full Comment
// {
//     DefaultLayout = Word;
//     WordLayout = './Layouts/Sales Document Approved Notification.docx';

//     dataset
//     {
//         dataitem("Kemipex Approval Entry"; "Kemipex Approval Entry")
//         {
//             column(Sender_ID; Sendername) { }
//             column(Document_No_; "Document No.") { }
//             column(Approval_Note; "Approval Note") { }
//             column(Approval_Type; "Approval Type") { }
//             column(ApprovalReason; ApprovalReason) { }
//             column(Document_Type; "Document Type") { }
//             column(Documentlink; Documentlink) { }
//             column(Approvername; Approvername) { }
//             dataitem("Sales Header"; "Sales Header")
//             {
//                 DataItemLink = "No." = field("Document No.");
//                 column(Bill_to_Customer_No_; "Bill-to Customer No.") { }
//                 column(Bill_to_Name; "Bill-to Name") { }
//                 column(Salesperson; SalespersonRec.Name) { }

//                 trigger OnAfterGetRecord()
//                 var
//                     myInt: Integer;
//                 begin
//                     if SalespersonRec.Get("Sales Header"."Salesperson Code") then;
//                 end;
//             }
//             trigger OnAfterGetRecord()
//             var
//                 Pagemanagement: Codeunit "Page Management";
//                 Recref: RecordRef;
//                 FRef1: FieldRef;
//                 FRef2: FieldRef;
//                 Ins: InStream;
//                 StringProper: Codeunit "String Proper";
//             begin
//                 Clear(Sendername);
//                 Clear(Approvername);
//                 SenderUserRec.SetRange("User Name", "Sender ID");
//                 if SenderUserRec.FindFirst() then
//                     Sendername := SenderUserRec."Full Name";
//                 approverUserRec.SetRange("User Name", "Last Modified By User ID");
//                 if approverUserRec.FindFirst() then Approvername := approverUserRec."Full Name";
//                 Clear(ApprovalReason);
//                 CalcFields("Approval Note");
//                 "Approval Note".CreateinStream(Ins, TextEncoding::UTF8);
//                 Ins.ReadText(ApprovalReason);


//             end;
//         }
//     }
//     var
//         Documentlink: Text;
//         SOpage: page "Sales Order";
//         Notificatioman: Codeunit "Notification Management";
//         SalespersonRec: Record "Salesperson/Purchaser";
//         ApprovalReason: Text;
//         Text2: Text;
//         NotificationEmail: Report "Notification Email";
//         //SMTP: Codeunit "SMTP Mail";//30-04-2022
//         approverUserRec: Record User;
//         SenderUserRec: Record User;
//         Approvername: Text;
//         Sendername: Text;
// }