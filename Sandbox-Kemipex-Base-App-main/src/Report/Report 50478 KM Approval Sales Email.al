// report 50478 "KM Approval Sales Email"//T12370-Full Comment
// {
//     DefaultLayout = Word;
//     WordLayout = './Layouts/KM Approval Sales Email.docx';

//     dataset
//     {
//         dataitem("Kemipex Notification Entry"; "Kemipex Notification Entry")
//         {
//             column(Recipient_User_ID; Approvername) { }
//             dataitem("Kemipex Approval Entry"; "Kemipex Approval Entry")
//             {
//                 DataItemLink = "Entry No." = field("Approval Entry No.");
//                 column(Sender_ID; Sendername) { }
//                 column(Document_No_; "Document No.") { }
//                 column(Approval_Note; "Approval Note") { }
//                 column(Approval_Type; "Approval Type") { }
//                 column(ApprovalReason; ApprovalReason) { }
//                 column(Document_Type; "Document Type") { }
//                 column(Documentlink; Documentlink) { }
//                 dataitem("Sales Header"; "Sales Header")
//                 {
//                     DataItemLink = "No." = field("Document No.");
//                     column(Bill_to_Customer_No_; "Bill-to Customer No.") { }
//                     column(Bill_to_Name; "Bill-to Name") { }
//                     column(Salesperson; SalespersonRec.Name) { }

//                     trigger OnAfterGetRecord()
//                     var
//                         myInt: Integer;
//                     begin
//                         if SalespersonRec.Get("Sales Header"."Salesperson Code") then;
//                     end;
//                 }
//                 trigger OnAfterGetRecord()
//                 var
//                     Pagemanagement: Codeunit "Page Management";
//                     Recref: RecordRef;
//                     FRef1: FieldRef;
//                     FRef2: FieldRef;
//                     Ins: InStream;
//                     StringProper: Codeunit "String Proper";

//                 begin
//                     // Recref.Open(Database::"Sales Header");
//                     // FRef1 := Recref.Field(1);
//                     // FRef2 := Recref.Field(3);
//                     // FRef1.SetRange("Kemipex Approval Entry"."Document Type");
//                     // FRef2.SetRange("Kemipex Approval Entry"."Document No.");
//                     // Documentlink := Pagemanagement.GetWebUrl(Recref, 42);

//                     Clear(Sendername);
//                     SenderUserRec.SetRange("User Name", "Sender ID");
//                     if SenderUserRec.FindFirst() then
//                         Sendername := SenderUserRec."Full Name";
//                     Clear(ApprovalReason);
//                     CalcFields("Approval Note");
//                     "Approval Note".CreateinStream(Ins, TextEncoding::UTF8);
//                     Ins.ReadText(ApprovalReason);
//                 end;
//             }
//             trigger OnAfterGetRecord()
//             var
//                 myInt: Integer;
//             begin
//                 Clear(Approvername);
//                 approverUserRec.SetRange("User Name", "Recipient User ID");
//                 if approverUserRec.FindFirst() then Approvername := approverUserRec."Full Name";
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
//         //SMTP: Codeunit "SMTP Mail";//30-04-2022-commented
//         approverUserRec: Record User;
//         SenderUserRec: Record User;
//         Approvername: Text;
//         Sendername: Text;
// }