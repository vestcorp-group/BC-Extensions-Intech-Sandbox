pageextension 50503 "COA Item Ledger Entries" extends "Item Ledger Entries"//T12370-Full Comment Code Uncommented 25-12-24
{
    layout
    {
        addafter("Expiration Date")
        {
            field("Analysis Date"; rec."Analysis Date")
            {
                ApplicationArea = all;
            }
            // field("Of Spec"; rec."Of Spec")
            // {
            //     ApplicationArea = all;
            //     Editable = true; //AJAY
            // }
        }
    }

    actions
    {
        addafter(Dimensions)
        {
            action("Testing Parameter")  //T13935-N
            {
                ApplicationArea = all;
                Caption = 'Testing Parameters';
                //RunObject = Page "Posted Lot Testing Parameters";
                ToolTip = 'View or edit the item testing parameters for the lot number.';
                Promoted = true;
                PromotedCategory = Category4;
                Image = AnalysisView;
                //RunPageLink = "Source ID" = field("Document No."),
                //"Source Ref. No." = field("Document Line No."),
                // Item No." = field("Item No."),
                //"Lot No." = field(CustomLotNumber),
                // "BOE No." = field(CustomBOENumber);

                trigger OnAction()
                var
                    LotPostedTestParameter: Record "Posted Lot Testing Parameter";  //AJAY
                    LotPostedTestParameter2: Record "Posted Lot Testing Parameter";  //AJAY
                    LotPostedVarintTestParameter: Record "Post Lot Var Testing Parameter"; //AJAY
                    LotPostedVarintTestParameter2: Record "Post Lot Var Testing Parameter"; //AJAY
                begin //AJAY >>
                    LotPostedVarintTestParameter2.RESET;
                    LotPostedVarintTestParameter2.SetRange("Source ID", REC."Document No.");
                    IF LotPostedVarintTestParameter2.FindFirst THEN begin
                        LotPostedVarintTestParameter.FilterGroup(2);
                        LotPostedVarintTestParameter.SetRange("Source ID", REC."Document No.");
                        LotPostedVarintTestParameter.SetRange("Source Ref. No.", Rec."Document Line No.");
                        LotPostedVarintTestParameter.SetRange("Item No.", rec."Item No.");
                        LotPostedVarintTestParameter.SetRange("Variant Code", Rec."Variant Code");
                        LotPostedVarintTestParameter.SetRange("Lot No.", Rec.CustomLotNumber);
                        LotPostedVarintTestParameter.SetRange("BOE No.", rec.CustomBOENumber);
                        IF PAGE.RUNMODAL(PAGE::"Post Lot Var Testing Parameter", LotPostedVarintTestParameter) = ACTION::LookupOK THEN;
                        ILEUpdateOffSpec(LotPostedVarintTestParameter);
                    end ELSE BEGIN
                        LotPostedTestParameter2.RESET;
                        LotPostedTestParameter2.SetRange("Source ID", REC."Document No.");
                        IF LotPostedTestParameter2.FindFirst THEN begin
                            LotPostedTestParameter.FilterGroup(2);
                            LotPostedTestParameter.SetRange("Source ID", REC."Document No.");
                            LotPostedTestParameter.SetRange("Source Ref. No.", Rec."Document Line No.");
                            LotPostedTestParameter.SetRange("Item No.", rec."Item No.");
                            LotPostedTestParameter.SetRange("Lot No.", Rec.CustomLotNumber);
                            LotPostedTestParameter.SetRange("BOE No.", rec.CustomBOENumber);
                            IF PAGE.RUNMODAL(PAGE::"Posted Lot Testing Parameters", LotPostedTestParameter) = ACTION::LookupOK THEN;
                        END else begin
                            LotPostedVarintTestParameter.FilterGroup(2);
                            LotPostedVarintTestParameter.SetRange("Source ID", REC."Document No.");
                            LotPostedVarintTestParameter.SetRange("Source Ref. No.", Rec."Document Line No.");
                            LotPostedVarintTestParameter.SetRange("Item No.", rec."Item No.");
                            LotPostedVarintTestParameter.SetRange("Variant Code", Rec."Variant Code");
                            LotPostedVarintTestParameter.SetRange("Lot No.", Rec.CustomLotNumber);
                            LotPostedVarintTestParameter.SetRange("BOE No.", rec.CustomBOENumber);
                            IF PAGE.RUNMODAL(PAGE::"Post Lot Var Testing Parameter", LotPostedVarintTestParameter) = ACTION::LookupOK THEN;
                            ILEUpdateOffSpec(LotPostedVarintTestParameter);
                        end;
                    end;
                end; //AJAY <<
            }
            action(PrintCOA)
            {
                ApplicationArea = all;
                Image = PrintVoucher;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Caption = 'Print Certifcate of Analysis';
                trigger OnAction()
                var
                    COAReport: Report "Certificate of Analysis ILE";
                    ILE: Record "Item Ledger Entry";
                    LotPostedTestParameter: Record "Posted Lot Testing Parameter";  //AJAY
                    LotPostedVarintTestParameter: Record "Post Lot Var Testing Parameter"; //AJAY
                    PostedQCReceipt_lRec: Record "Posted QC Rcpt. Header";
                begin  //AJAY >>
                       /*  LotPostedVarintTestParameter.RESET;
                        LotPostedVarintTestParameter.SetRange("Source ID", REC."Document No.");
                        IF LotPostedVarintTestParameter.FindFirst THEN BEGIN
                            ILE.SetRange("Entry No.", rec."Entry No.");
                            Report.Run(Report::"Certificate of Analysis ILE N", true, true, ILE);
                        END ELSE begin
                            LotPostedTestParameter.RESET;
                            LotPostedTestParameter.SetRange("Source ID", REC."Document No.");
                            IF LotPostedTestParameter.FindFirst THEN BEGIN
                                ILE.SetRange("Entry No.", rec."Entry No.");
                                Report.Run(Report::"Certificate of Analysis ILE", true, true, ILE);
                            end;
                        end; */
                    if rec."Posted QC No." <> '' then begin//Alok need to check
                        ILE.RESET;
                        ILE.SetRange("Entry No.", Rec."Entry No.");
                        IF ILE.FindFirst THEN BEGIN
                            Report.Run(Report::"CertificateofAnalysisILENEW", true, true, ILE);
                        end;
                    end else
                        Error('Posted QC No. not found against ILE Entry No: %1', Rec."Entry No.");
                end;
                //AJAY <<
            }
        }
    }
    local procedure ILEUpdateOffSpec(PostedLotVariantTestingParameter2: Record "Post Lot Var Testing Parameter") //T13935-N
    var
        IntValL: Integer;
        DecValL: Decimal;
        PostedLotVariantTestingParameter: Record "Post Lot Var Testing Parameter";
        ExceedingValueMsg: Label 'The actual value is exceeding the maximum value';
        LesserValueMsg: Label 'The actual value is lesser than the minimum value';
    begin  //AJAY >>
        PostedLotVariantTestingParameter.RESET;
        PostedLotVariantTestingParameter.SetRange("Source ID", PostedLotVariantTestingParameter2."Source ID");
        PostedLotVariantTestingParameter.SetRange("Source Ref. No.", PostedLotVariantTestingParameter2."Source Ref. No.");
        PostedLotVariantTestingParameter.SetRange("Item No.", PostedLotVariantTestingParameter2."Item No.");
        PostedLotVariantTestingParameter.SetRange("Variant Code", PostedLotVariantTestingParameter2."Variant Code");
        PostedLotVariantTestingParameter.SetRange("Lot No.", PostedLotVariantTestingParameter2."Lot No.");
        PostedLotVariantTestingParameter.SetRange("BOE No.", PostedLotVariantTestingParameter2."BOE No.");
        PostedLotVariantTestingParameter.SetFilter("Actual Value", '<>%1', '');
        IF PostedLotVariantTestingParameter.FindFirst THEN
            repeat
                //IF PostedLotVariantTestingParameter."Actual Value" <> '' THEN BEGIN
                case PostedLotVariantTestingParameter."Data Type" of
                    PostedLotVariantTestingParameter."Data Type"::Decimal:
                        Evaluate(DecValL, PostedLotVariantTestingParameter."Actual Value");
                    PostedLotVariantTestingParameter."Data Type"::Integer:
                        Evaluate(IntValL, PostedLotVariantTestingParameter."Actual Value");
                end;
                //PostedLotVariantTestingParameter."Of Spec" := false;
                //END;
                if PostedLotVariantTestingParameter."Data Type" <> PostedLotVariantTestingParameter."Data Type"::Alphanumeric then
                    case PostedLotVariantTestingParameter.Symbol of
                        PostedLotVariantTestingParameter.Symbol::"<":
                            case PostedLotVariantTestingParameter."Data Type" of
                                PostedLotVariantTestingParameter."Data Type"::Decimal:
                                    begin
                                        IF (PostedLotVariantTestingParameter.Minimum <> 0) AND (PostedLotVariantTestingParameter.Maximum <> 0) THEN BEGIN
                                            IF (DecValL < PostedLotVariantTestingParameter.Minimum) OR (DecValL > PostedLotVariantTestingParameter.Maximum) THEN
                                                PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, true)
                                            else
                                                PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, false);
                                        END;

                                        IF (DecValL < PostedLotVariantTestingParameter.Minimum) AND (PostedLotVariantTestingParameter.maximum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, true);

                                        IF (DecValL > PostedLotVariantTestingParameter.Minimum) AND (PostedLotVariantTestingParameter.Maximum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, false);

                                        IF (DecValL < PostedLotVariantTestingParameter.Maximum) AND (PostedLotVariantTestingParameter.Minimum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, false);

                                        IF (DecValL > PostedLotVariantTestingParameter.Maximum) AND (PostedLotVariantTestingParameter.Minimum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, true);
                                    end;
                                PostedLotVariantTestingParameter."Data Type"::Integer:
                                    begin
                                        IF (PostedLotVariantTestingParameter.Minimum <> 0) AND (PostedLotVariantTestingParameter.Maximum <> 0) THEN BEGIN
                                            IF (IntValL < PostedLotVariantTestingParameter.Minimum) OR (IntValL > PostedLotVariantTestingParameter.Maximum) THEN
                                                PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, true)
                                            else
                                                PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, false);
                                        END;

                                        IF (IntValL < PostedLotVariantTestingParameter.Minimum) AND (PostedLotVariantTestingParameter.maximum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, true);

                                        IF (IntValL > PostedLotVariantTestingParameter.Minimum) AND (PostedLotVariantTestingParameter.Maximum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, false);

                                        IF (IntValL < PostedLotVariantTestingParameter.Maximum) AND (PostedLotVariantTestingParameter.Minimum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, false);

                                        IF (IntValL > PostedLotVariantTestingParameter.Maximum) AND (PostedLotVariantTestingParameter.Minimum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, true);
                                    end;
                            end;
                        PostedLotVariantTestingParameter.Symbol::">":
                            case PostedLotVariantTestingParameter."Data Type" of
                                PostedLotVariantTestingParameter."Data Type"::Decimal:
                                    begin
                                        IF (PostedLotVariantTestingParameter.Minimum <> 0) AND (PostedLotVariantTestingParameter.Maximum <> 0) THEN BEGIN
                                            IF (DecValL < PostedLotVariantTestingParameter.Minimum) OR (DecValL > PostedLotVariantTestingParameter.Maximum) THEN
                                                PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, true)
                                            else
                                                Rec.Validate("Of Spec", false);
                                        END;

                                        IF (DecValL < PostedLotVariantTestingParameter.Minimum) AND (PostedLotVariantTestingParameter.maximum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, true);

                                        IF (DecValL > PostedLotVariantTestingParameter.Minimum) AND (PostedLotVariantTestingParameter.Maximum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, false);

                                        IF (DecValL < PostedLotVariantTestingParameter.Maximum) AND (PostedLotVariantTestingParameter.Minimum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, false);

                                        IF (DecValL > PostedLotVariantTestingParameter.Maximum) AND (PostedLotVariantTestingParameter.Minimum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, true);
                                    end;
                                PostedLotVariantTestingParameter."Data Type"::Integer:
                                    begin
                                        IF (PostedLotVariantTestingParameter.Minimum <> 0) AND (PostedLotVariantTestingParameter.Maximum <> 0) THEN BEGIN
                                            IF (IntValL < PostedLotVariantTestingParameter.Minimum) OR (IntValL > PostedLotVariantTestingParameter.Maximum) THEN
                                                PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, true)
                                            else
                                                PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, false);
                                        END;

                                        IF (IntValL < PostedLotVariantTestingParameter.Minimum) AND (PostedLotVariantTestingParameter.maximum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, true);

                                        IF (IntValL > PostedLotVariantTestingParameter.Minimum) AND (PostedLotVariantTestingParameter.Maximum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, false);

                                        IF (IntValL < PostedLotVariantTestingParameter.Maximum) AND (PostedLotVariantTestingParameter.Minimum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, false);

                                        IF (IntValL > PostedLotVariantTestingParameter.Maximum) AND (PostedLotVariantTestingParameter.Minimum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, true);
                                    end;
                            end;
                        PostedLotVariantTestingParameter.Symbol::" ":
                            case PostedLotVariantTestingParameter."Data Type" of
                                PostedLotVariantTestingParameter."Data Type"::Decimal:
                                    begin
                                        IF (PostedLotVariantTestingParameter.Minimum <> 0) AND (PostedLotVariantTestingParameter.Maximum <> 0) THEN BEGIN
                                            IF (DecValL < PostedLotVariantTestingParameter.Minimum) OR (DecValL > PostedLotVariantTestingParameter.Maximum) THEN
                                                PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, true)
                                            else
                                                PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, false);
                                        END;

                                        IF (DecValL < PostedLotVariantTestingParameter.Minimum) AND (PostedLotVariantTestingParameter.maximum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, true);

                                        IF (DecValL > PostedLotVariantTestingParameter.Minimum) AND (PostedLotVariantTestingParameter.Maximum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, false);

                                        IF (DecValL < PostedLotVariantTestingParameter.Maximum) AND (PostedLotVariantTestingParameter.Minimum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, false);

                                        IF (DecValL > PostedLotVariantTestingParameter.Maximum) AND (PostedLotVariantTestingParameter.Minimum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, true);
                                    end;
                                PostedLotVariantTestingParameter."Data Type"::Integer:
                                    begin
                                        IF (PostedLotVariantTestingParameter.Minimum <> 0) AND (PostedLotVariantTestingParameter.Maximum <> 0) THEN BEGIN
                                            IF (IntValL < PostedLotVariantTestingParameter.Minimum) OR (IntValL > PostedLotVariantTestingParameter.Maximum) THEN
                                                PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, true)
                                            else
                                                PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, false);
                                        END;

                                        IF (IntValL < PostedLotVariantTestingParameter.Minimum) AND (PostedLotVariantTestingParameter.maximum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, true);

                                        IF (IntValL > PostedLotVariantTestingParameter.Minimum) AND (PostedLotVariantTestingParameter.Maximum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, false);

                                        IF (IntValL < PostedLotVariantTestingParameter.Maximum) AND (PostedLotVariantTestingParameter.Minimum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, false);

                                        IF (IntValL > PostedLotVariantTestingParameter.Maximum) AND (PostedLotVariantTestingParameter.Minimum = 0) THEN
                                            PostedLotVariantTestingParameter.ILEUpdateOffSpec(Rec, true);
                                    end;
                            end;
                    end; //AJAY <<
            UNTIL PostedLotVariantTestingParameter.Next = 0;
    END;

    var
        myInt: Integer;
}