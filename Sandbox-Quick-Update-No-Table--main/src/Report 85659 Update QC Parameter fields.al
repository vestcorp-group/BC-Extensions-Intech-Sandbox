report 85659 "Update QC Parameter fields"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("QC Specification Header"; "QC Specification Header")
        {
            DataItemTableView = where(Status = filter(Certified));
            trigger OnPreDataItem()
            begin
                CurrQcSpecLine_gInt := 0;
                Window_gDlg.Update(1, "QC Specification Header".Count);
            end;

            trigger OnAfterGetRecord()
            var
                QCSpecificationHdr_lRec: Record "QC Specification Header";
                QCSpecificationLine_lRec: Record "QC Specification Line";
                QCParameters_lRec: Record "QC Parameters";
                QCSpecificationHdr2_lRec: Record "QC Specification Header";
            begin
                Clear(QCSpecificationHdr_lRec);
                if QCSpecificationHdr_lRec.Get("QC Specification Header"."No.") then begin
                    QCSpecificationHdr_lRec.Status := QCSpecificationHdr_lRec.Status::"Under Development";
                    QCSpecificationHdr_lRec.Modify();

                    QCSpecificationLine_lRec.Reset();
                    QCSpecificationLine_lRec.SetRange("Item Specifiction Code", QCSpecificationHdr_lRec."No.");
                    QCSpecificationLine_lRec.SetFilter("Quality Parameter Code", '<> %1', '');
                    if QCSpecificationLine_lRec.FindSet() then begin
                        repeat
                            Clear(QCParameters_lRec);
                            if QCParameters_lRec.Get(QCSpecificationLine_lRec."Quality Parameter Code") then begin
                                QCSpecificationLine_lRec."Rounding Precision" := QCParameters_lRec."Rounding Precision";
                                QCSpecificationLine_lRec."Decimal Places" := QCParameters_lRec."Decimal Places";

                                CurrQcSpecLine_gInt += 1;
                                Window_gDlg.Update(2, CurrQcSpecLine_gInt);
                                QCSpecificationLine_lRec.Modify();
                            end;
                        until QCSpecificationLine_lRec.Next() = 0;
                    end;

                    Clear(QCSpecificationHdr2_lRec);
                    if QCSpecificationHdr2_lRec.Get(QCSpecificationHdr_lRec."No.") then begin
                        if QCSpecificationHdr2_lRec.Status = QCSpecificationHdr2_lRec.Status::"Under Development" then begin
                            QCSpecificationHdr2_lRec.Status := QCSpecificationHdr2_lRec.Status::Certified;
                            QCSpecificationHdr2_lRec.Modify();
                        end;
                    end;
                end;
            end;
        }
        dataitem("QC Rcpt. Line"; "QC Rcpt. Line")
        {
            DataItemTableView = where("Quality Parameter Code" = filter(<> ''));
            trigger OnPreDataItem()
            begin
                CurrQcRcpt_gInt := 0;
                Window_gDlg.Update(3, "QC Rcpt. Line".Count);
            end;

            trigger OnAfterGetRecord()
            var
                QCRcptLine_lRec: Record "QC Rcpt. Line";
                QCParameters_lRec: Record "QC Parameters";
            begin
                Clear(QCRcptLine_lRec);
                if QCRcptLine_lRec.Get("QC Rcpt. Line"."No.", "QC Rcpt. Line"."Line No.") then begin
                    Clear(QCParameters_lRec);
                    if QCParameters_lRec.Get(QCRcptLine_lRec."Quality Parameter Code") then begin
                        QCRcptLine_lRec."Rounding Precision" := QCParameters_lRec."Rounding Precision";
                        QCRcptLine_lRec."Decimal Places" := QCParameters_lRec."Decimal Places";
                        CurrQcRcpt_gInt += 1;
                        Window_gDlg.Update(4, CurrQcRcpt_gInt);
                        QCRcptLine_lRec.Modify();
                    end;
                end;
            end;
        }
        dataitem("Posted QC Rcpt. Line"; "Posted QC Rcpt. Line")
        {
            DataItemTableView = where("Quality Parameter Code" = filter(<> ''));
            trigger OnPreDataItem()
            begin
                CurrPosQcRcpt_gInt := 0;
                Window_gDlg.Update(5, "Posted QC Rcpt. Line".Count);
            end;

            trigger OnAfterGetRecord()
            var
                PostedQCRcptLine_lRec: Record "Posted QC Rcpt. Line";
                QCParameters_lRec: Record "QC Parameters";
            begin
                Clear(PostedQCRcptLine_lRec);
                if PostedQCRcptLine_lRec.Get("Posted QC Rcpt. Line"."No.", "Posted QC Rcpt. Line"."Line No.") then begin
                    Clear(QCParameters_lRec);
                    if QCParameters_lRec.Get(PostedQCRcptLine_lRec."Quality Parameter Code") then begin
                        PostedQCRcptLine_lRec."Rounding Precision" := QCParameters_lRec."Rounding Precision";
                        PostedQCRcptLine_lRec."Decimal Places" := QCParameters_lRec."Decimal Places";
                        CurrPosQcRcpt_gInt += 1;
                        Window_gDlg.Update(6, CurrPosQcRcpt_gInt);
                        PostedQCRcptLine_lRec.Modify();
                    end;
                end;
            end;
        }
    }
    trigger OnPreReport()
    begin
        Window_gDlg.Open('Updating Data .....\Total QC Specification : #1###############\Current : #2###############\Total QC Rcpt Lines : #3###############\Current : #4###############\Total Posted QC Rcpt Lines : #5###############\Current : #6###############');
    end;

    trigger OnPostReport()
    begin
        Window_gDlg.Close();
    end;

    var
        Window_gDlg: Dialog;
        CurrQcRcpt_gInt: Integer;
        CurrPosQcRcpt_gInt: Integer;
        CurrQcSpecLine_gInt: Integer;
}