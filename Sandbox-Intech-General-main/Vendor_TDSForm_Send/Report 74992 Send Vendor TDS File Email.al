//T36936-NS  VendorTDSFormEmail
Report 74992 "Send Vendor TDS File Email"
{
    //ApplicationArea = Basic;
    UsageCategory = Tasks;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Vendor TDS File Header"; "Vendor TDS File Header")
        {

            dataitem("Vendor TDS Files Lines"; "Vendor TDS Files Lines")
            {
                DataItemLinkReference = "Vendor TDS File Header";
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = where("Email Sent" = const(false));

                trigger OnAfterGetRecord()
                var
                    Vendor_lRec: Record Vendor;
                begin
                    if "Vendor TDS Files Lines"."Vendor No." = '' then
                        CurrReport.Skip();

                    Vendor_lRec.Reset();
                    Vendor_lRec.GET("Vendor TDS Files Lines"."Vendor No.");
                    if Vendor_lRec."E-Mail" = '' then
                        CurrReport.Skip();
                    "Vendor TDS Files Lines".SendVendorTDSFile("Vendor TDS Files Lines");
                end;
            }

            //   RequestFilterFields = "Prod. Order No.";
            trigger OnAfterGetRecord()
            var
                PL_lRec: Record "Purchase Line";
            begin
                CurrentRec_gDec += 1;
                Windows_gDlg.Update(2, CurrentRec_gDec);
            end;

            trigger OnPostDataItem()
            begin
                Windows_gDlg.Close;
            end;

            trigger OnPreDataItem()
            begin
                Windows_gDlg.Open('Total Record : #1#########\' + 'Current Record : #2##########\');
                Windows_gDlg.Update(1, Count);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Windows_gDlg: Dialog;
        CurrentRec_gDec: Decimal;
}
//T36936-NE