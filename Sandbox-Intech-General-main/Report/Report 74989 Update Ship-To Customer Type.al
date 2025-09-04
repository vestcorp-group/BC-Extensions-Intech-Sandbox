report 74989 "Update Ship-To Customer Type"
{
    Caption = 'Update Ship-To Customer Type';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Permissions = tabledata "Sales Header" = rm;
    ProcessingOnly = true;
    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.") order(ascending);
            RequestFilterFields = "No.", "Sell-to Customer No.";

            trigger OnAfterGetRecord()
            var
                SalesLine_lRec: Record "Sales Line";
                ShipToAddress_lRec: Record "Ship-to Address";
            begin
                CurrentRec_gDec += 1;
                Windows_gDlg.Update(2, CurrentRec_gDec);

                SalesLine_lRec.Reset();
                SalesLine_lRec.SetRange("Document Type", "Document Type");
                SalesLine_lRec.SetRange("Document No.", "No.");
                SalesLine_lRec.SetFilter(SalesLine_lRec.Type, '<>%1', SalesLine_lRec.Type::" ");
                if SalesLine_lRec.FindFirst then begin
                    if SalesLine_lRec."GST Place Of Supply" = SalesLine_lRec."GST Place Of Supply"::"Bill-to Address" then begin
                        "GST-Ship to Customer Type" := "GST Customer Type";
                        "Ship-to GST Customer Type" := "Ship-to GST Customer Type"::" ";
                    End else
                        if SalesLine_lRec."GST Place Of Supply" = SalesLine_lRec."GST Place Of Supply"::"Ship-to Address" then begin
                            if ShipToAddress_lRec.Get("Bill-to Customer No.", "Ship-to Code") then begin
                                "GST-Ship to Customer Type" := ShipToAddress_lRec."Ship-to GST Customer Type";
                                "Ship-to GST Customer Type" := ShipToAddress_lRec."Ship-to GST Customer Type";
                            end;
                        end;
                    Modify(true);
                end;
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
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        Windows_gDlg: Dialog;
        CurrentRec_gDec: Decimal;

}
