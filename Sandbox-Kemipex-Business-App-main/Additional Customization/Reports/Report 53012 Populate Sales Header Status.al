// report 53012 "Populate Sales Header Status"//T12370-Full Comment
// {
//     ApplicationArea = All;
//     Caption = 'Populate Sales Header Status';
//     UsageCategory = ReportsAndAnalysis;
//     ProcessingOnly = true;
//     UseRequestPage = false;


//     trigger OnPostReport()
//     var
//         RecHeader: Record "Sales Header";
//         Reclines: Record "Sales Line";
//     begin
//         Clear(RecHeader);
//         RecHeader.SetFilter("No.", '<>%1', '');
//         if RecHeader.FindSet() then begin
//             repeat

//                 Clear(Reclines);
//                 Reclines.SetRange("Document Type", RecHeader."Document Type");
//                 Reclines.SetFilter(Type, '<>%1', Reclines.Type::" ");
//                 Reclines.SetRange("Document No.", RecHeader."No.");
//                 if Reclines.FindSet() then begin
//                     Reclines.ModifyAll("Header Status", RecHeader.Status);
//                 end
//             until RecHeader.Next() = 0;
//         end
//     end;
// }
