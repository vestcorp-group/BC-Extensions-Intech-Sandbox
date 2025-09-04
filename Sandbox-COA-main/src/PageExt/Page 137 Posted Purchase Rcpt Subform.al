PageExtension 50504 Posted_Purch_Rcpt_Subfrm_50504 extends "Posted Purchase Rcpt. Subform"//T51170-N from QC Extension
{

    layout
    {
        addafter(Quantity)
        {
            field("Under Inspection Quantity"; Rec."Under Inspection Quantity")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Accepted Quantity"; Rec."Accepted Quantity")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Accepted with Deviation Qty"; Rec."Accepted with Deviation Qty")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("Rejected Quantity"; Rec."Rejected Quantity")
            {
                ApplicationArea = Basic;
                Editable = false;
            }
            field("QC Required"; Rec."QC Required")
            {
                ApplicationArea = Basic;
            }
            field("QC Pending"; Rec."QC Pending")
            {
                ApplicationArea = Basic;
            }
            field("TC Received"; Rec."TC Received")
            {
                ApplicationArea = Basic;
            }
            field("TC Remarks"; Rec."TC Remarks")
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {
        addafter(ItemInvoiceLines)
        {
            action("&Create QC Receipt")
            {
                ApplicationArea = Basic;
                Image = CalculateLines;

                trigger OnAction()
                var
                    QCPurchase_lCdu: Codeunit "Quality Control - Purchase";
                    QCCOAPurchase_lCdu: Codeunit "Quality Control - COA";
                    Item_lRec: Record Item;
                    QCSetup_lRec: Record "Quality Control Setup";
                begin
                    QCSetup_lRec.Reset();
                    if QCSetup_lRec.get then begin
                        Item_lRec.get(rec."No.");
                        if (Item_lRec."COA Applicable") and (not Item_lRec."Allow QC in GRN") then begin
                            if (QCSetup_lRec."QC Block without Location") then
                                QCCOAPurchase_lCdu.CreateQCRcpt_gFnc(Rec, true);
                        end else if Item_lRec."Allow QC in GRN" then begin
                            Clear(QCPurchase_lCdu);
                            QCPurchase_lCdu.CreateQCRcpt_gFnc(Rec, true); //I-C0009-1001310-04-N
                        end;
                    end;
                end;
            }
            action("QC &Receipt")
            {
                ApplicationArea = Basic;
                Image = Questionaire;

                trigger OnAction()
                var
                    QCPurchase_lCdu: Codeunit "Quality Control - Purchase";
                begin
                    Clear(QCPurchase_lCdu);
                    QCPurchase_lCdu.ShowQCRcpt_gFnc(Rec); //I-C0009-1001310-04-N
                end;
            }
            action("&Post QC Receipt")
            {
                ApplicationArea = Basic;
                Caption = 'Posted QC Receipt';
                Image = PersonInCharge;

                trigger OnAction()
                var
                    QCPurchase_lCdu: Codeunit "Quality Control - Purchase";
                begin
                    Clear(QCPurchase_lCdu);
                    QCPurchase_lCdu.ShowPostedQCRcpt_gFnc(Rec); //I-C0009-1001310-04-N
                end;
            }
        }
    }
}

