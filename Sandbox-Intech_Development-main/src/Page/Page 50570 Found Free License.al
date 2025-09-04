page 50148 "Found Free License"
{
    ApplicationArea = All;
    Caption = 'Found Free License Object (Danger - Intech Use Only)';
    PageType = List;
    SourceTable = "License Permission";
    UsageCategory = Lists;
    Editable = false;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Object Type"; Rec."Object Type")
                {
                    ToolTip = 'Specifies the value of the Object Type field.';
                    StyleExpr = StyleExp;
                    ApplicationArea = All;
                }
                field("Object Number"; Rec."Object Number")
                {
                    ToolTip = 'Specifies the value of the Object Number field.';
                    StyleExpr = StyleExp;
                    ApplicationArea = All;
                }

                field(AvialableText; AvialableText)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleExp;
                    Caption = 'Available Text';
                }

            }
        }
    }

    var
        StyleExp: Text;
        AvialableText: Text;

    trigger OnAfterGetRecord()
    begin

        // Standard   --> Black
        // StandardAccent  --> Light Blue
        // Strong  --> Bold Black
        // StrongAccent  --> Bold Blue
        // Attention  --> Italic Red
        // AttentionAccent  --> Italic Blue
        // Favorable --> Bold Green
        // Unfavorable  --> Bold Red
        // Ambiguous  --> Yellow
        // Subordinate  --> Gray


        StyleExp := '';
        IF Rec."Object Type" = Rec."Object Type"::Table Then begin
            StyleExp := 'Strong'
        end;

        IF Rec."Object Type" = Rec."Object Type"::Report Then begin
            StyleExp := 'Favorable'
        end;

        IF Rec."Object Type" = Rec."Object Type"::Codeunit Then begin
            StyleExp := 'StrongAccent'
        end;

        IF Rec."Object Type" = Rec."Object Type"::Page Then begin
            StyleExp := 'Attention';
        end;

        IF Rec."Object Type" = Rec."Object Type"::XMLport Then begin
            StyleExp := 'Ambiguous';
        end;

        IF Rec."Object Type" = Rec."Object Type"::Query Then begin
            StyleExp := 'Subordinate';
        end;

        AvialableText := 'Available Free ' + Format(Rec."Object Type");
    end;


    trigger OnOpenPage()
    var
        AllObjWithCaption: Record AllObjWithCaption;
        LP_lRec: Record "License Permission";
        TempLP_lRecTMp: Record "License Permission" temporary;
        i: Integer;
        Win: Dialog;
        Curr: Integer;
    begin
        // Object Type                   Quantity       Range From     Range To       Permission
        // -----------------------------------------------------------------------------------------
        // TableData                     114            50000          50113          RIMDX
        // TableData                     65             50117          50181          RIMDX
        // TableData                     36             50184          50219          RIMDX
        // TableData                     5              80000          80004          RIMDX
        // Report                        681            50000          50681          RIMDX
        // Report                        19             80000          80018          RIMDX
        // Codeunit                      400            50000          50399          RIMDX
        // Codeunit                      20             80000          80019          RIMDX
        // Page                          681            50000          50680          RIMDX
        // Page                          19             80000          80018          RIMDX
        // XMLPort                       100            50000          50099          RIMDX
        // Query                         100            50000          50099          RIMDX

        Win.Open('Founding #1##########\Process Record #2###########');

        //Table
        Win.Update(1, 'Table');
        for i := 50000 to 50113 DO begin
            Curr += 1;
            Win.Update(2, Curr);
            Clear(AllObjWithCaption);
            IF NOT AllObjWithCaption.GET(AllObjWithCaption."Object Type"::Table, i) Then begin
                Clear(Rec);
                Rec."Object Type" := Rec."Object Type"::Table;
                Rec."Object Number" := i;
                Rec.Insert()
            End;
        end;

        Win.Update(1, 'Table');
        for i := 50117 to 50181 DO begin
            Curr += 1;
            Win.Update(2, Curr);
            Clear(AllObjWithCaption);
            IF NOT AllObjWithCaption.GET(AllObjWithCaption."Object Type"::Table, i) Then begin
                Clear(Rec);
                Rec."Object Type" := Rec."Object Type"::Table;
                Rec."Object Number" := i;
                Rec.Insert()
            End;
        end;


        Win.Update(1, 'Table');
        for i := 50184 to 50219 DO begin
            Curr += 1;
            Win.Update(2, Curr);
            Clear(AllObjWithCaption);
            IF NOT AllObjWithCaption.GET(AllObjWithCaption."Object Type"::Table, i) Then begin
                Clear(Rec);
                Rec."Object Type" := Rec."Object Type"::Table;
                Rec."Object Number" := i;
                Rec.Insert()
            End;
        end;

        Win.Update(1, 'Table');
        for i := 80000 to 80004 DO begin
            Curr += 1;
            Win.Update(2, Curr);
            Clear(AllObjWithCaption);
            IF NOT AllObjWithCaption.GET(AllObjWithCaption."Object Type"::Table, i) Then begin
                Clear(Rec);
                Rec."Object Type" := Rec."Object Type"::Table;
                Rec."Object Number" := i;
                Rec.Insert()
            End;
        end;


        //Report
        Win.Update(1, 'Report');
        for i := 50000 to 50680 DO begin
            Curr += 1;
            Win.Update(2, Curr);
            Clear(AllObjWithCaption);
            IF NOT AllObjWithCaption.GET(AllObjWithCaption."Object Type"::Report, i) Then begin
                Clear(Rec);
                Rec."Object Type" := Rec."Object Type"::Report;
                Rec."Object Number" := i;
                Rec.Insert()
            End;
        end;


        Win.Update(1, 'Report');
        for i := 80000 to 80018 DO begin
            Curr += 1;
            Win.Update(2, Curr);
            Clear(AllObjWithCaption);
            IF NOT AllObjWithCaption.GET(AllObjWithCaption."Object Type"::Report, i) Then begin
                Clear(Rec);
                Rec."Object Type" := Rec."Object Type"::Report;
                Rec."Object Number" := i;
                Rec.Insert()
            End;
        end;

        //Codeunit
        Win.Update(1, 'Codeunit');
        for i := 50000 to 50399 DO begin
            Curr += 1;
            Win.Update(2, Curr);
            Clear(AllObjWithCaption);
            IF NOT AllObjWithCaption.GET(AllObjWithCaption."Object Type"::Codeunit, i) Then begin
                Clear(Rec);
                Rec."Object Type" := Rec."Object Type"::Codeunit;
                Rec."Object Number" := i;
                Rec.Insert()
            End;
        end;


        Win.Update(1, 'Codeunit');
        for i := 80000 to 80019 DO begin
            Curr += 1;
            Win.Update(2, Curr);
            Clear(AllObjWithCaption);
            IF NOT AllObjWithCaption.GET(AllObjWithCaption."Object Type"::Codeunit, i) Then begin
                Clear(Rec);
                Rec."Object Type" := Rec."Object Type"::Codeunit;
                Rec."Object Number" := i;
                Rec.Insert()
            End;
        end;


        //Page
        Win.Update(1, 'Page');
        for i := 50000 to 50680 DO begin
            Curr += 1;
            Win.Update(2, Curr);
            Clear(AllObjWithCaption);
            IF NOT AllObjWithCaption.GET(AllObjWithCaption."Object Type"::Page, i) Then begin
                Clear(Rec);
                Rec."Object Type" := Rec."Object Type"::Page;
                Rec."Object Number" := i;
                Rec.Insert()
            End;
        end;

        Win.Update(1, 'Page');
        for i := 80000 to 80018 DO begin
            Curr += 1;
            Win.Update(2, Curr);
            Clear(AllObjWithCaption);
            IF NOT AllObjWithCaption.GET(AllObjWithCaption."Object Type"::Page, i) Then begin
                Clear(Rec);
                Rec."Object Type" := Rec."Object Type"::Page;
                Rec."Object Number" := i;
                Rec.Insert()
            End;
        end;


        //Xmlport
        Win.Update(1, 'Xmlport');
        for i := 50000 to 50099 DO begin
            Curr += 1;
            Win.Update(2, Curr);
            Clear(AllObjWithCaption);
            IF NOT AllObjWithCaption.GET(AllObjWithCaption."Object Type"::XMLport, i) Then begin
                Clear(Rec);
                Rec."Object Type" := Rec."Object Type"::XMLport;
                Rec."Object Number" := i;
                Rec.Insert()
            End;
        end;


        // //Query
        // for i := 50000 to 50099 DO begin
        //     Clear(AllObjWithCaption);
        //     IF NOT AllObjWithCaption.GET(AllObjWithCaption."Object Type"::Query, i) Then begin
        //         Clear(Rec);
        //         Rec."Object Type" := Rec."Object Type"::Query;
        //         Rec."Object Number" := i;
        //         Rec.Insert()
        //     End;
        // end;

        Win.Close();

        Rec.Reset();
        Rec.FindFirst();

    end;
}
