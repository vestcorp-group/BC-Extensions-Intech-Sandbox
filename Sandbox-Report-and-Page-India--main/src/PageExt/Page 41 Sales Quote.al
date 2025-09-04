pageextension 64103 SalesQuote_64103 extends "Sales Quote"
{
    actions
    {
        addafter(Print)
        {
            action("Proforma Invoice")
            {
                ApplicationArea = All;
                Image = Invoice;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category10;
                Visible = false;// AS-25-03-25
                trigger OnAction()
                var
                    SalesHdr_lRec: Record "Sales Header";
                    BlanketSalesOrder_lRpt: Report "Blanket Sales Order New";
                begin
                    SalesHdr_lRec.RESET;
                    SalesHdr_lRec.SetRange("No.", Rec."No.");
                    if SalesHdr_lRec.FindFirst() then begin
                        BlanketSalesOrder_lRpt.SetTableView(SalesHdr_lRec);
                        BlanketSalesOrder_lRpt.RunModal();
                    end;


                end;
            }
            action("Proforma Invoice Local UAE")
            {
                ApplicationArea = all;
                Caption = 'Proforma Invoice Local';
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category9;
                trigger OnAction()
                var
                    CompanyInfo_lRec: Record "Company Information";
                    SalesHdr_lRec: Record "Sales Header";
                    BlanketSalesOrder_lRpt: Report "Blanket Sales Order New";
                    ProformaInv_lRpt: Report "Proforma Invoice_Local UAE";
                begin
                    CompanyInfo_lRec.GET;
                    if (CompanyName <> 'Alyachem_1') AND (CompanyName <> 'Chemidea_1') then begin
                        SalesHdr_lRec.Reset();
                        SalesHdr_lRec.SetRange("No.", Rec."No.");
                        if SalesHdr_lRec.FindFirst() then
                            if CompanyInfo_lRec."Enable GST caption" then begin
                                BlanketSalesOrder_lRpt.SetTableView(SalesHdr_lRec);
                                BlanketSalesOrder_lRpt.RunModal();
                            end else begin
                                ProformaInv_lRpt.SetTableView(SalesHdr_lRec);
                                ProformaInv_lRpt.RunModal();
                            end;
                    end;
                    if (CompanyName = 'Alyachem_1') or (CompanyName = 'Chemidea_1') then begin//T
                        SalesHdr_lRec.Reset();
                        SalesHdr_lRec.SetRange("No.", Rec."No.");
                        if SalesHdr_lRec.FindSet() then
                            Report.RunModal(Report::"Sales Quotation Proforma", true, true, SalesHdr_lRec);
                    end;
                end;
            }
        }
        //T52854-NS
        modify("Sales Quotation Local UAE")
        {
            trigger OnBeforeAction()
            var
                SalesHeader_lRec: Record "Sales Header";
            begin
                if (CompanyName = 'Alyachem_1') or (CompanyName = 'Chemidea_1') then begin//T
                    salesHeader_lRec.Reset();
                    salesHeader_lRec.SetRange("No.", Rec."No.");
                    if salesHeader_lRec.FindSet() then
                        Report.RunModal(Report::"Sales Quotation Proforma", true, true, salesHeader_lRec);
                end;
            end;
        }
        //T52854-NE
        // modify("Proforma Invoice Local UAE")
        // {
        //     trigger OnBeforeAction()
        //     var
        //         CompanyInfo_lRec: Record "Company Information";
        //         SalesHdr_lRec: Record "Sales Header";
        //         BlanketSalesOrder_lRpt: Report "Blanket Sales Order New";
        //         ProformaInv_lRpt: Report "Proforma Invoice_Local UAE";
        //     begin

        //         Clear(CompanyInfo_lRec);
        //         clear(BlanketSalesOrder_lRpt);
        //         clear(ProformaInv_lRpt);

        //         CompanyInfo_lRec.GET;
        //         SalesHdr_lRec.Reset();
        //         SalesHdr_lRec.SetRange("No.", Rec."No.");
        //         if SalesHdr_lRec.FindFirst() then
        //             if CompanyInfo_lRec."Enable GST caption" then begin
        //                 BlanketSalesOrder_lRpt.SetTableView(SalesHdr_lRec);
        //                 BlanketSalesOrder_lRpt.RunModal();
        //             end else begin
        //                 ProformaInv_lRpt.SetTableView(SalesHdr_lRec);
        //                 ProformaInv_lRpt.RunModal();
        //             end;

        //     end;

        //T53930-NS
        modify(Print)
        {
            Visible = false;
        }
        modify(AttachAsPDF)
        {
            Visible = false;
        }
        modify(Email)
        {
            Visible = false;
        }
        //T53930-NE

    }
}

