// report 53011 "Custom Notification Dispatcher"//T12370-Full Comment
// {
//     Caption = 'Custom Notification Dispatcher';
//     UseRequestPage = false;
//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem(CustomNotificationSetup; "Custom Notification Setup")
//         {
//             DataItemTableView = sorting(Code) where(Enabled = const(true));

//             trigger OnAfterGetRecord()
//             var
//                 RecLine: Record "Notification Setup Lines";
//                 NotificationEntry: Record "Custom Notification Entries";
//                 RecRef: RecordRef;
//                 FldRef: FieldRef;
//             begin

//                 Clear(RecRef);
//                 case Table of
//                     Table::"Sales Header":
//                         RecRef.OPEN(36);
//                     Table::Item:
//                         RecRef.OPEN(27);
//                     Table::"Reservation Entry":
//                         RecRef.OPEN(337);
//                 end;

//                 FldRef := RecRef.FIELD("Field Id");
//                 FldRef.SetFilter("Filter Text");
//                 IF RecRef.FIND('-') THEN BEGIN
//                     repeat
//                         Clear(RecLine);
//                         RecLine.SetRange("Notification Code", Code);
//                         if RecLine.FindSet() then begin
//                             repeat
//                                 Clear(NotificationEntry);
//                                 NotificationEntry.Init();
//                                 NotificationEntry."Entry No." := 0;
//                                 NotificationEntry.Insert(true);
//                                 NotificationEntry."Notification Date" := WorkDate();
//                                 NotificationEntry."User Id" := RecLine."User Id";
//                                 NotificationEntry.Notification := "Notification Text" + ' ' + FORMAT(RecRef.RecordId);
//                                 NotificationEntry.Modify(true);
//                             until RecLine.Next() = 0;
//                         end;
//                     until RecRef.Next() = 0;
//                     RecRef.CLOSE;
//                 END;
//             end;
//         }
//     }

//     trigger OnPreReport()
//     var
//         NotificationEntry: Record "Custom Notification Entries";
//     begin
//         NotificationEntry.DeleteAll(true);
//     end;
// }
