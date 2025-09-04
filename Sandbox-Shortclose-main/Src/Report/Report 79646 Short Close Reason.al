report 79646 "Short Close Reason RP"
{
    Caption = 'Short Close Reason';
    ProcessingOnly = true;
    Description = 'T12084';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = ALL;

    dataset
    {

    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(ShortCloseReasonCode_gCod; ShortCloseReasonCode_gCod)
                {
                    ApplicationArea = Basic;
                    Caption = 'Short Close Reason';
                    TableRelation = "Short Close Reason".Code;
                    ShowMandatory = true;
                }
            }
        }
    }

    var
        ShortCloseReasonCode_gCod: Code[20];
        ReportRun_gBln: Boolean;

    trigger OnPostReport()
    begin

        ReportRun_gBln := True;

    end;

    procedure GetReasonCode_gFnc(): Text
    begin
        exit(ShortCloseReasonCode_gCod);
    end;

    procedure IsReportRun(): Boolean
    begin
        exit(ReportRun_gBln);
    end;
}
