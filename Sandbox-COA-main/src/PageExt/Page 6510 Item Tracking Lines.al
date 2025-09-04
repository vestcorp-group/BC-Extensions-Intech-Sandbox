pageextension 50509 "Item Tracking Lines Ext" extends "Item Tracking Lines"//T12370-Full Comment  T13935-N
{
    layout
    {
        addafter("Expiration Date")
        {
            field("Analysis Date"; rec."Analysis Date")
            {
                ApplicationArea = all;
                StyleExpr = HighlightRow;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    UpdateCOAFieldsOnReservationEntry(rec);
                end;
            }
            field("Of Spec"; rec."Of Spec")
            {
                ApplicationArea = all;
                Editable = false;
                StyleExpr = HighlightRow;
            }
        }
        /* 
       modify(AvailabilitySerialNo)
       {
           StyleExpr = HighlightRow;
       }
       modify(AvailabilityLotNo)
       {
           StyleExpr = HighlightRow;
       }
       modify("Lot No.")
       {
           StyleExpr = HighlightRow;
       }
       modify(CustomBOENumber)
       {
           StyleExpr = HighlightRow;
       }
       modify(CustomLotNumber)
       {
           StyleExpr = HighlightRow;
       }
       modify("New Custom Lot No.")
       {
           StyleExpr = HighlightRow;
       }
       modify("Manufacturing Date 2")
       {
           StyleExpr = HighlightRow;
       }
       modify("Expiration Date")
       {
           StyleExpr = HighlightRow;
       }
       modify("Expiry Period 2")
       {
           StyleExpr = HighlightRow;
       }
       modify("Gross Weight 2")
       {
           StyleExpr = HighlightRow;
       }
       modify("Quantity (Base)")
       {
           StyleExpr = HighlightRow;
       }
       modify("Qty. to Handle (Base)")
       {
           StyleExpr = HighlightRow;
       }
       modify("Qty. to Invoice (Base)")
       {
           StyleExpr = HighlightRow;
       }
       modify("Appl.-from Item Entry")
       {
           StyleExpr = HighlightRow;
       }
       modify("Appl.-to Item Entry")
       {
           StyleExpr = HighlightRow;
       }
       modify("Supplier Batch No. 2")
       {
           StyleExpr = HighlightRow;
       }
       modify("Net Weight 2")
       {
           StyleExpr = HighlightRow;
       } */

    }
    actions
    {
        addafter(Line_LotNoInfoCard)
        {
            action("Testing Parameters")
            {
                ApplicationArea = all;
                Caption = 'Testing Parameters';
                ToolTip = 'View or edit the item testing parameters for the lot number.';
                Promoted = true;
                PromotedCategory = Category4;
                Image = AnalysisView;
                trigger OnAction()
                var
                    RecSLines: Record "Sales Line";
                    LotVariantTestingParameter: Record "Lot Variant Testing Parameter";  //AJAY
                    PageLotVariantTestingParameter: Page "Lot Variant Testing Parameters";  //AJAY
                    ItemVariantTestingParameter: Record "Item Variant Testing Parameter";  //AJAY
                begin
                    LotVariantTestingParameter.SetRange("Source ID", rec."Source ID");
                    LotVariantTestingParameter.SetRange("Source Ref. No.", rec."Source Ref. No.");
                    LotVariantTestingParameter.SetRange("Item No.", rec."Item No.");
                    LotVariantTestingParameter.SetRange("Variant Code", Rec."Variant Code");
                    LotVariantTestingParameter.SetRange("Lot No.", rec.CustomLotNumber);
                    LotVariantTestingParameter.SetRange("BOE No.", rec.CustomBOENumber);
                    LotVariantTestingParameter.SetRange("Variant Code", rec."Variant Code");
                    PageLotVariantTestingParameter.SetTableView(LotVariantTestingParameter);
                    PageLotVariantTestingParameter.Editable := (Rec."Source Type" = Database::"Purchase Line") OR
                        (Rec."Source Type" = Database::"Item Journal Line") or
                        (Rec."Source Type" = Database::"Assembly Header");

                    if Rec."Source Type" = Database::"Item Journal Line" then begin
                        if Rec."Source ID" = 'TRANSFER' then
                            PageLotVariantTestingParameter.DisableActualValueControl();
                    end;

                    PageLotVariantTestingParameter.RunModal();
                    Commit();

                    LotVariantTestingParameter.Reset();
                    LotVariantTestingParameter.SetRange("Source ID", rec."Source ID");
                    LotVariantTestingParameter.SetRange("Source Ref. No.", rec."Source Ref. No.");
                    LotVariantTestingParameter.SetRange("Item No.", rec."Item No.");
                    LotVariantTestingParameter.SetRange("Variant Code", rec."Variant Code");
                    LotVariantTestingParameter.SetRange("Lot No.", rec.CustomLotNumber);
                    LotVariantTestingParameter.SetRange("BOE No.", rec.CustomBOENumber);
                    LotVariantTestingParameter.SetRange("Of Spec", true);
                    rec."Of Spec" := not LotVariantTestingParameter.IsEmpty;
                    if rec.Modify() then;
                    UpdateCOAFieldsOnReservationEntry(Rec);
                    CurrPage.Update();
                END;
            }
            action("New Testing Parameters")
            {
                ApplicationArea = all;
                Caption = 'New Testing Parameters';
                ToolTip = 'View or edit the item testing parameters for the lot number.';
                Promoted = true;
                PromotedCategory = Category4;
                Image = AnalysisView;
                Visible = NewParameterVisibilityG;
                trigger OnAction()
                var
                    LotVariantTestingParametere: Record "Lot Variant Testing Parameter";  //AJAY
                    PageLotVariantTestingParameter: Page "Lot Variant Testing Parameters"; //AJAY
                begin  //AJAY 
                    LotVariantTestingParametere.SetRange("Source ID", rec."Source ID");
                    LotVariantTestingParametere.SetRange("Source Ref. No.", rec."Source Ref. No.");
                    LotVariantTestingParametere.SetRange("Item No.", rec."Item No.");
                    LotVariantTestingParametere.SetRange("Variant Code", Rec."Variant Code");
                    LotVariantTestingParametere.SetRange("Lot No.", rec."New Custom Lot No.");
                    LotVariantTestingParametere.SetRange("BOE No.", rec."New Custom BOE No.");
                    PageLotVariantTestingParameter.SetTableView(LotVariantTestingParametere);
                    PageLotVariantTestingParameter.Editable := (Rec."Source Type" = Database::"Purchase Line") OR
                        (Rec."Source Type" = Database::"Assembly Line") OR
                        (Rec."Source Type" = Database::"Item Journal Line") or
                        (Rec."Source Type" = Database::"Assembly Header");
                    PageLotVariantTestingParameter.Run();
                end;  //AJAY
            }
            action("Download Template")
            {
                ApplicationArea = All;
                Caption = 'Testing Parameter Template';
                Image = ExportToExcel;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = ShowDownloadUploadActionG;
                trigger OnAction()
                var
                    ExcelBufferL: Record "Excel Buffer" temporary;
                    ItemTestingParameterL: Record "Item Testing Parameter";
                    TrackingSpecificationL: Record "Tracking Specification";
                    SheetName: Text;
                    QCSpecificationLine_lRec: Record "QC Specification Line";//T13935-N
                    Item_lRec: Record Item;//T13935-N
                    QCSpecificationHeader_lRec: Record "QC Specification Header";//T13935-N
                begin
                    TrackingSpecificationL.Copy(Rec);
                    Rec.SetFilter("Qty. to Handle (Base)", '>%1', 0);
                    SheetName := 'Sheet 1';
                    ExcelBufferL.DeleteAll();
                    ExcelBufferL.NewRow();
                    ExcelBufferL.AddColumn('Item Code', false, '', false, false, false, '', ExcelBufferL."Cell Type"::Text);
                    //ExcelBufferL.AddColumn('Variant Code', false, '', false, false, false, '', ExcelBufferL."Cell Type"::Text); //AJAY
                    ExcelBufferL.AddColumn('Lot No.', false, '', false, false, false, '', ExcelBufferL."Cell Type"::Text);
                    ExcelBufferL.AddColumn('Testing Code', false, '', false, false, false, '', ExcelBufferL."Cell Type"::Text);
                    ExcelBufferL.AddColumn('Testing Parameter', false, '', false, false, false, '', ExcelBufferL."Cell Type"::Text);
                    ExcelBufferL.AddColumn('Minimum', false, '', false, false, false, '', ExcelBufferL."Cell Type"::Number);
                    ExcelBufferL.AddColumn('Maximum', false, '', false, false, false, '', ExcelBufferL."Cell Type"::Number);
                    ExcelBufferL.AddColumn('Alternate', false, '', false, false, false, '', ExcelBufferL."Cell Type"::Text);
                    ExcelBufferL.AddColumn('Type', false, '', false, false, false, '', ExcelBufferL."Cell Type"::Text); //Symbol-Type
                    ExcelBufferL.AddColumn('Actual Value', false, '', false, false, false, '', ExcelBufferL."Cell Type"::Text);
                    Rec.FindSet();
                    repeat

                        if Not Item_lRec.Get(Rec."Item No.") then
                            exit;
                        // if not Item_lRec."COA Applicable" then
                        //     exit;
                        if Item_lRec."COA Applicable" then begin//T51170-N
                            QCSpecificationHeader_lRec.Reset();
                            QCSpecificationHeader_lRec.SetRange("No.", Item_lRec."Item Specification Code");
                            QCSpecificationHeader_lRec.SetRange(Status, QCSpecificationHeader_lRec.Status::Certified);
                            if QCSpecificationHeader_lRec.FindFirst() then begin
                                QCSpecificationLine_lRec.Reset();
                                QCSpecificationLine_lRec.SetRange("Item Specifiction Code", QCSpecificationHeader_lRec."No.");
                                if QCSpecificationLine_lRec.FindSet() then begin
                                    repeat
                                        //ItemTestingParameterL.SetRange("Item No.", Rec."Item No.");
                                        //if ItemTestingParameterL.FindSet() then
                                        //  repeat
                                        ExcelBufferL.NewRow();
                                        ExcelBufferL.AddColumn(Rec."Item No.", false, '', false, false, false, '', ExcelBufferL."Cell Type"::Text);
                                        ExcelBufferL.AddColumn(Rec.CustomLotNumber, false, '', false, false, false, '', ExcelBufferL."Cell Type"::Text);
                                        ExcelBufferL.AddColumn(QCSpecificationLine_lRec."Quality Parameter Code", false, '', false, false, false, '', ExcelBufferL."Cell Type"::Text);
                                        ExcelBufferL.AddColumn(QCSpecificationLine_lRec.Description, false, '', false, false, false, '', ExcelBufferL."Cell Type"::Text);
                                        ExcelBufferL.AddColumn(QCSpecificationLine_lRec."Min.Value", false, '', false, false, false, '', ExcelBufferL."Cell Type"::Number);
                                        ExcelBufferL.AddColumn(QCSpecificationLine_lRec."Max.Value", false, '', false, false, false, '', ExcelBufferL."Cell Type"::Number);
                                        ExcelBufferL.AddColumn(QCSpecificationLine_lRec."Text Value", false, '', false, false, false, '', ExcelBufferL."Cell Type"::Text);
                                        ExcelBufferL.AddColumn(QCSpecificationLine_lRec.Type, false, '', false, false, false, '', ExcelBufferL."Cell Type"::Text);
                                        ExcelBufferL.AddColumn('', false, '', false, false, false, '', ExcelBufferL."Cell Type"::Text);
                                    //  until ItemTestingParameterL.Next() = 0;
                                    until QCSpecificationLine_lRec.Next() = 0;
                                end;
                            end;
                        end;//T51170-N
                    until Rec.Next() = 0;
                    ExcelBufferL.CreateNewBook(SheetName);
                    ExcelBufferL.WriteSheet('Testing Parameters - Batch wise', CompanyName, UserId);
                    ExcelBufferL.CloseBook;
                    Rec.Copy(TrackingSpecificationL);
                    ExcelBufferL.OpenExcel;
                end;
            }
            action("Upload Testing Parameter")
            {
                ApplicationArea = All;
                Caption = 'Upload Testing Parameter';
                Image = ImportExcel;
                Promoted = true;

                PromotedCategory = Category4;
                Visible = ShowDownloadUploadActionG;
                trigger OnAction()
                var
                    ExcelBufferL: Record "Excel Buffer";
                    LotTestingParameterL: Record "Lot Testing Parameter";
                    TrackingSpecificationL: Record "Tracking Specification";
                    LastRowL: Integer;
                    CurrentRowL: Integer;
                    FileNameL: Text;
                    cal: Decimal;
                    DecValL: Decimal;
                    IntValL: Integer;
                    Msg: Text;
                    OfSpecLotL: Text;
                    ShowWarningMsgL: Boolean;
                    InStreamL: InStream;
                    FileExtensionFilterTxt: Label 'Excel Files (*.xlsx)|*.xlsx|All Files (*.*)|*.*';
                    txt: Label 'The parameters below did not meet predicted values';
                    txt1: Label 'Parameter          Min     Max     Actual';
                begin
                    Msg := '';
                    TrackingSpecificationL.Copy(Rec);
                    Rec.SetFilter("Qty. to Handle (Base)", '>%1', 0);
                    Rec.FindSet();
                    ExcelBufferL.DeleteAll();
                    if not UPLOADINTOSTREAM('Select Excel File', '', FileExtensionFilterTxt, FileNameL, InStreamL) then
                        exit;
                    ExcelBufferL.OpenBookStream(InStreamL, ExcelBufferL.SelectSheetsNameStream(InStreamL));
                    ExcelBufferL.ReadSheet;
                    ExcelBufferL.Reset();
                    ExcelBufferL.FindLast();
                    LastRowL := ExcelBufferL."Row No.";
                    for CurrentRowL := 2 to LastRowL do begin
                        ExcelBufferL.Reset();
                        ExcelBufferL.SetRange("Row No.", CurrentRowL);
                        ExcelBufferL.Findset();
                        LotTestingParameterL.Init();
                        LotTestingParameterL."Source ID" := Rec."Source ID";
                        LotTestingParameterL."Source Ref. No." := Rec."Source Ref. No.";
                        LotTestingParameterL."BOE No." := Rec.CustomBOENumber;
                        repeat
                            Case ExcelBufferL."Column No." of
                                1:
                                    LotTestingParameterL."Item No." := ExcelBufferL."Cell Value as Text";
                                2:
                                    LotTestingParameterL."Lot No." := ExcelBufferL."Cell Value as Text";
                                3:
                                    LotTestingParameterL.Validate(Code, ExcelBufferL."Cell Value as Text");
                                9:
                                    begin
                                        LotTestingParameterL."Actual Value" := ExcelBufferL."Cell Value as Text";
                                        case LotTestingParameterL."Data Type" of
                                            LotTestingParameterL."Data Type"::Decimal:
                                                Evaluate(DecValL, LotTestingParameterL."Actual Value");
                                            LotTestingParameterL."Data Type"::Integer:
                                                Evaluate(IntValL, LotTestingParameterL."Actual Value");
                                        end;
                                        if LotTestingParameterL."Data Type" <> LotTestingParameterL."Data Type"::Alphanumeric then
                                            case LotTestingParameterL.Symbol of
                                                LotTestingParameterL.Symbol::"<":
                                                    case LotTestingParameterL."Data Type" of
                                                        LotTestingParameterL."Data Type"::Decimal:
                                                            if (DecValL > LotTestingParameterL.Maximum) and (LotTestingParameterL.Maximum <> 0) then begin
                                                                LotTestingParameterL."Of Spec" := true;
                                                                ShowWarningMsgL := true;
                                                            end;
                                                        LotTestingParameterL."Data Type"::Integer:
                                                            if (IntValL > LotTestingParameterL.Maximum) and (LotTestingParameterL.Maximum <> 0) then begin
                                                                LotTestingParameterL."Of Spec" := true;
                                                                ShowWarningMsgL := true;
                                                            end;
                                                    end;
                                                LotTestingParameterL.Symbol::">":
                                                    case LotTestingParameterL."Data Type" of
                                                        LotTestingParameterL."Data Type"::Decimal:
                                                            if (DecValL < LotTestingParameterL.Minimum) and (LotTestingParameterL.Minimum <> 0) then begin
                                                                LotTestingParameterL."Of Spec" := true;
                                                                ShowWarningMsgL := true;
                                                            end;
                                                        LotTestingParameterL."Data Type"::Integer:
                                                            if (IntValL < LotTestingParameterL.Minimum) and (LotTestingParameterL.Minimum <> 0) then begin
                                                                LotTestingParameterL."Of Spec" := true;
                                                                ShowWarningMsgL := true;
                                                            end;
                                                    end;
                                                LotTestingParameterL.Symbol::" ":
                                                    case LotTestingParameterL."Data Type" of
                                                        LotTestingParameterL."Data Type"::Decimal:
                                                            begin
                                                                if (DecValL < LotTestingParameterL.Minimum) and (LotTestingParameterL.Minimum <> 0) then begin
                                                                    LotTestingParameterL."Of Spec" := true;
                                                                    ShowWarningMsgL := true;
                                                                end;
                                                                if (DecValL > LotTestingParameterL.Maximum) and (LotTestingParameterL.Maximum <> 0) then begin
                                                                    LotTestingParameterL."Of Spec" := true;
                                                                    ShowWarningMsgL := true;
                                                                end;
                                                            end;
                                                        LotTestingParameterL."Data Type"::Integer:
                                                            begin
                                                                if (IntValL < LotTestingParameterL.Minimum) and (LotTestingParameterL.Minimum <> 0) then begin
                                                                    LotTestingParameterL."Of Spec" := true;
                                                                    ShowWarningMsgL := true;
                                                                end;
                                                                if (IntValL > LotTestingParameterL.Maximum) and (LotTestingParameterL.Maximum <> 0) then begin
                                                                    LotTestingParameterL."Of Spec" := true;
                                                                    ShowWarningMsgL := true;
                                                                end;
                                                            end;
                                                    end;
                                            end;
                                    end;
                            // 9:
                            //     Evaluate(LotTestingParameterL.Symbol, ExcelBufferL."Cell Value as Text");
                            end;
                        until ExcelBufferL.Next() = 0;

                        LotTestingParameterL.SetRecFilter();
                        if LotTestingParameterL.IsEmpty() then
                            LotTestingParameterL.Insert()
                        else
                            LotTestingParameterL.Modify();
                    end;
                    if ShowWarningMsgL then begin
                        repeat
                            LotTestingParameterL.Reset();
                            LotTestingParameterL.SetRange("Source ID", Rec."Source ID");
                            LotTestingParameterL.SetRange("Source Ref. No.", Rec."Source Ref. No.");
                            LotTestingParameterL.SetRange("Item No.", Rec."Item No.");
                            LotTestingParameterL.SetRange("Lot No.", Rec.CustomLotNumber);
                            LotTestingParameterL.SetRange("BOE No.", Rec.CustomBOENumber);
                            LotTestingParameterL.SetRange("Of Spec", true);
                            Rec."Of Spec" := not LotTestingParameterL.IsEmpty;
                            Rec.Modify();
                            if Rec."Of Spec" then
                                OfSpecLotL := OfSpecLotL + Rec.CustomLotNumber + ' ' + Rec.CustomBOENumber + '\';
                            UpdateCOAFieldsOnReservationEntry(Rec);
                        until Rec.Next() = 0;
                        Message(StrSubstNo('The below Lot and BOE is(are) off spec!\ %1', OfSpecLotL));
                    end;
                    Rec.Copy(TrackingSpecificationL);
                    CurrPage.Update();
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        ShowDownloadUploadActionG := (Rec."Source Type" = Database::"Purchase Line") OR
            (Rec."Source Type" = Database::"Assembly Line") OR
            (Rec."Source Type" = Database::"Item Journal Line") or
            (Rec."Source Type" = Database::"Assembly Header");
        NewParameterVisibilityG := Rec.IsReclass();

        if Rec."Of Spec" then
            HighlightRow := 'Unfavorable'//'Ambiguous'
        else
            HighlightRow := 'None';
    end;

    local procedure UpdateCOAFieldsOnReservationEntry(TrackingSpecP: Record "Tracking Specification")
    var
        ReservationEntryL: Record "Reservation Entry";
    begin
        ReservationEntryL.SetSourceFilter(TrackingSpecP."Source Type", TrackingSpecP."Source Subtype", TrackingSpecP."Source ID", TrackingSpecP."Source Ref. No.", true);
        //ReservationEntryL.SetTrackingFilter(TrackingSpecP."Serial No.", TrackingSpecP."Lot No.");//30-04-2022
        ReservationEntryL.SetTrackingFilterFromSpec(TrackingSpecP);//30-04-2022
        if ReservationEntryL.FindFirst() then begin
            ReservationEntryL."Analysis Date" := TrackingSpecP."Analysis Date";
            ReservationEntryL."Of Spec" := TrackingSpecP."Of Spec";
            ReservationEntryL.Modify();
        end;

    end;


    var
        //[InDataSet]
        ShowDownloadUploadActionG: Boolean;
        //[InDataSet]
        NewParameterVisibilityG: Boolean;
        HighlightRow: Text;
}