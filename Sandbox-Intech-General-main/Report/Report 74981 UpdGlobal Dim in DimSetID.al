report 74981 "UpdGlobal Dim in DimSetID"
{
    Caption = 'Update Global Dimension No. in Dimension Set ID';
    ProcessingOnly = true;
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Permissions = tabledata 480 = rm;

    dataset
    {
        dataitem("Dimension Set Entry"; "Dimension Set Entry")
        {

            trigger OnAfterGetRecord()
            begin
                Cnt += 1;
                Win.Update(2, Cnt);

                IF "Global Dimension No." <> 0 then
                    CurrReport.Skip();

                Case "Dimension Code" of
                    GLSetup_gRec."Shortcut Dimension 1 Code":
                        begin
                            "Global Dimension No." := 1;
                        end;
                    GLSetup_gRec."Shortcut Dimension 2 Code":
                        begin
                            "Global Dimension No." := 2;
                        end;

                    GLSetup_gRec."Shortcut Dimension 3 Code":
                        begin
                            "Global Dimension No." := 3;
                        end;

                    GLSetup_gRec."Shortcut Dimension 4 Code":
                        begin
                            "Global Dimension No." := 4;
                        end;

                    GLSetup_gRec."Shortcut Dimension 5 Code":
                        begin
                            "Global Dimension No." := 5;
                        end;

                    GLSetup_gRec."Shortcut Dimension 6 Code":
                        begin
                            "Global Dimension No." := 6;
                        end;

                    GLSetup_gRec."Shortcut Dimension 7 Code":
                        begin
                            "Global Dimension No." := 7;
                        end;

                    GLSetup_gRec."Shortcut Dimension 8 Code":
                        begin
                            "Global Dimension No." := 8;
                        end;
                End;

                Modify();

                IF Cnt Mod 1000 = 0 then
                    Commit();
            end;

            trigger OnPreDataItem()
            begin
                Error('Please use the standard system batch process - Update Global Dimension No. for Dimension Set Entries');
                Win.Open('Total #1###################\Current #2#############\Table #3###########\Start At  #4############');
                Win.Update(3, TableCaption);
                Win.Update(4, CurrentDateTime);
                Win.Update(1, Count);
                GLSetup_gRec.gET;
            end;

            trigger OnPostDataItem()
            begin
                Win.Close;
            end;

        }
    }

    var
        Win: Dialog;
        Cnt: Integer;
        GLSetup_gRec: Record "General Ledger Setup";

}