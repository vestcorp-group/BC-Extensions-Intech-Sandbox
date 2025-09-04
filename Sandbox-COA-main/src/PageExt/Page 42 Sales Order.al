pageextension 50508 "Sales Order Card PExt" extends "Sales Order"//T12370-Full Comment
{
    actions
    {
        addfirst(Reporting)
        {
            //             action("Certificate of Analysis")
            //             {
            //                 ApplicationArea = All;
            //                 Caption = 'Certificate of Analysis';
            //                 Image = PrintChecklistReport;
            //                 ToolTip = 'Print or preview the certificate of analysis.';
            //                 trigger OnAction()
            //                 var
            //                     RecSalesHdr: Record "Sales Header";
            //                     ReservationEntry: Record "Reservation Entry"; //AJAY
            //                     LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
            //                 begin   //AJAY >> 
            //                     RecSalesHdr.SetRange("Document Type", RecSalesHdr."Document Type"::Order);
            //                     RecSalesHdr.SetRange("No.", rec."No.");
            //                     if RecSalesHdr.FindFirst() then begin
            //                         if RecSalesHdr.Status <> RecSalesHdr.Status::Released then
            //                             Report.Run(Report::"Certificate of Analysis_SO New", true, true, RecSalesHdr)
            //                         else
            //                             Report.Run(Report::"Certificate of Analysis_SOR N", true, true, RecSalesHdr)
            //                     end;
            //                 end;  //AJAY <<
            //             }
            action("Consolidated COA")
            {
                ApplicationArea = All;
                Caption = 'Consolidated COA';
                Image = PrintChecklistReport;
                ToolTip = 'Generate consolidated certificate of analysis.';
                trigger OnAction()
                var
                    RecSalesHdr: Record "Sales Header";
                    ReservationEntry: Record "Reservation Entry"; //AJAY
                    LotVariantTestingParameter: Record "Lot Variant Testing Parameter"; //AJAY
                begin  //AJAY >>
                    RecSalesHdr.SetRange("Document Type", RecSalesHdr."Document Type"::Order);
                    RecSalesHdr.SetRange("No.", rec."No.");
                    if RecSalesHdr.FindFirst() then begin
                        if RecSalesHdr.Status <> RecSalesHdr.Status::Released then
                            Report.Run(Report::"Consolidated COA New", true, true, RecSalesHdr)
                        else
                            Report.Run(Report::"Consolidated COA_Release N", true, true, RecSalesHdr)
                    end;
                end;  //AJAY <<
            }
        }
    }
}
