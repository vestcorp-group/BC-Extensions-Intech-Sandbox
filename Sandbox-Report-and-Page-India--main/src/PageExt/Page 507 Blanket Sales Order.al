pageextension 64102 "BSOExt" extends "Blanket Sales Order"//T12370-Full Comment
{
    // layout
    // {
    //     // Add changes to page layout here
    //     addafter(ShippingOptions)
    //     { }
    //     modify(ShippingOptions)
    //     {
    //         trigger OnAfterValidate()
    //         begin
    //             if ShipToOptions = ShipToOptions::"Custom Address" then
    //                 rec.Shipping := true
    //             else
    //                 rec.Shipping := false;

    //         end;
    //     }
    //     modify(BillToOptions)
    //     {
    //         trigger OnAfterValidate()
    //         begin
    //             if BillToOptions = BillToOptions::"Custom Address" then
    //                 rec.Billing := true
    //             else
    //                 rec.Billing := false;
    //         end;
    //     }
    // }

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
                PromotedCategory = Category6;
                Visible = false;
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


                // action("Print Preview CPI")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Print Preview CPI';
                //     Promoted = true;
                //     PromotedIsBig = true;
                //     PromotedCategory = Category6;
                //     trigger OnAction()
                //     var
                //         salesHeader: Record "Sales Header";
                //     begin
                //         salesHeader.Reset();
                //         salesHeader.SetRange("No.", Rec."No.");
                //         if salesHeader.FindSet() then
                //             Report.RunModal(54790, true, true, salesHeader);
                //     end;
                // }
            }
            action("Proforma Invoice Local UAE")
            {
                ApplicationArea = all;
                Caption = 'Proforma Invoice Local';
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category6;
                Visible = false;  //T53930-N
                trigger OnAction()
                var
                    CompanyInfo_lRec: Record "Company Information";
                    SalesHdr_lRec: Record "Sales Header";
                    BlanketSalesOrder_lRpt: Report "Blanket Sales Order New";
                    ProformaInv_lRpt: Report "Proforma Invoice_Local UAE";
                begin
                    CompanyInfo_lRec.GET;
                    //T52854-NS
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
                    end else begin
                        SalesHdr_lRec.Reset();
                        SalesHdr_lRec.SetRange("No.", Rec."No.");
                        if SalesHdr_lRec.FindFirst() then
                            Report.runmodal(Report::"Blanket Sales Order - Proforma", true, true, SalesHdr_lRec);
                    end;
                    //T52854-NE
                end;
            }
        }
        //T53930-NS
        modify("Print Preview1")
        {
            Visible = false;
        }
        modify(AttachAsPDF)
        {
            Visible = false;
        }
        //T53930-NE

    }

    var
        myInt: Integer;
}