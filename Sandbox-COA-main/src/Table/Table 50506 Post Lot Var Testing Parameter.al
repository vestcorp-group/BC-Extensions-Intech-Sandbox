table 50506 "Post Lot Var Testing Parameter"
{
    DataClassification = CustomerContent;
    Caption = 'Posted Lot Variant Testing Parameter';
    Permissions = TableData "Item Ledger Entry" = rm;
    fields
    {
        field(1; "Source ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Source ID';

        }
        field(2; "Source Ref. No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Source Ref. No.';
        }
        field(3; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(4; "Lot No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Lot No.';
        }
        field(5; "BOE No."; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'BOE No.';
        }
        field(6; Code; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Testing Parameter';
            // TableRelation = "Item Variant Testing Parameter"."Code" where("Item No." = field("Item No."), "Variant Code" = field("Variant Code")); //HyperCare-27-03-2025-O
            //TableRelation = "Testing Parameter";
            //TableRelation = "Item Testing Parameter"."Code" where("Item No." = field("Item No."));
            //HyperCare-27-03-2025-OS
            // trigger OnValidate()
            // var
            //     //ItemTestingParameterL: Record "Item Testing Parameter";
            //     ItemVariantTestingParameter: Record "Item Variant Testing Parameter";
            // begin
            //     IF ItemVariantTestingParameter.GET("Item No.", "Variant Code", Code) THEN begin
            //         "Testing Parameter" := ItemVariantTestingParameter."Testing Parameter";
            //         Minimum := ItemVariantTestingParameter.Minimum;
            //         Maximum := ItemVariantTestingParameter.Maximum;
            //         Value2 := ItemVariantTestingParameter.Value2;
            //         "Data Type" := ItemVariantTestingParameter."Data Type";
            //         Priority := ItemVariantTestingParameter.Priority;
            //         "Show in COA" := ItemVariantTestingParameter."Show in COA";
            //         "Default Value" := ItemVariantTestingParameter."Default Value";
            //     end;
            // end;
            //HyperCare-27-03-2025-OE

            //HyperCare-27-03-2025-NS
            trigger OnLookup()
            var
                QCSpecificationline_lRec: Record "QC Specification Line";
                myInt: Integer;
                Item_lRec: Record Item;
            begin
                If Item_lRec.get("Item No.") then begin
                    if Item_lRec."Item Specification Code" <> '' then begin
                        Item_lRec.TestField("COA Applicable");
                        QCSpecificationline_lRec.Reset();
                        QCSpecificationline_lRec.SetRange("Item Specifiction Code", Item_lRec."Item Specification Code");
                        if QCSpecificationline_lRec.FindSet() then begin
                            if Page.RunModal(Page::"QCSpecificationLine List", QCSpecificationline_lRec) = Action::LookupOK then begin
                                validate(code, QCSpecificationLine_lRec."Quality Parameter Code");
                            end;
                        end;
                    end;
                end;

            end;

            trigger OnValidate()
            var
                QCSpecificationline_lRec: Record "QC Specification Line";
                myInt: Integer;
                Item_lRec: Record Item;
            begin
                If Item_lRec.get("Item No.") then begin
                    if Item_lRec."Item Specification Code" <> '' then begin
                        Item_lRec.TestField("COA Applicable");
                        QCSpecificationline_lRec.Reset();
                        QCSpecificationline_lRec.SetRange("Item Specifiction Code", Item_lRec."Item Specification Code");
                        QCSpecificationline_lRec.SetRange("Quality Parameter Code", Code);
                        QCSpecificationline_lRec.FindFirst();
                        "Testing Parameter" := QCSpecificationLine_lRec.Description;
                        "Testing Parameter Code" := QCSpecificationLine_lRec."Method Description";
                        Minimum := QCSpecificationLine_lRec."Min.Value";
                        Maximum := QCSpecificationLine_lRec."Max.Value";
                        Value2 := QCSpecificationLine_lRec."Text Value";
                        "Show in COA" := QCSpecificationLine_lRec."Show in COA";
                        "Default Value" := QCSpecificationLine_lRec."Default Value";
                        Type := QCSpecificationLine_lRec.Type;
                        "Rounding Precision" := QCSpecificationLine_lRec."Rounding Precision";
                        "Decimal Places" := QCSpecificationLine_lRec."Decimal Places";//T52614-N
                    end;
                end;

            end;
            //HyperCare-27-03-2025-NE
        }
        field(21; "Testing Parameter"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Testing Parameter description';
        }
        field(22; Minimum; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Minimum';
            DecimalPlaces = 0 : 5; // B
        }
        field(23; Maximum; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum';
            DecimalPlaces = 0 : 5; //B
        }
        field(24; Value; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Alternate';
            ObsoleteState = Pending;
            ObsoleteReason = 'length is not sufficent';
        }
        field(25; "Actual Value"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Actual Value';
            trigger OnValidate()
            var
                IntValL: Integer;
                DecValL: Decimal;
                ExceedingValueMsg: Label 'The actual value is exceeding the maximum value';
                LesserValueMsg: Label 'The actual value is lesser than the minimum value';
                ItemLedgerEntry: Record "Item Ledger Entry"; //New code Added
            begin  //AJAY >>
                IF "Actual Value" <> '' THEN BEGIN
                    case "Data Type" of
                        "Data Type"::Decimal:
                            Evaluate(DecValL, "Actual Value");
                        "Data Type"::Integer:
                            Evaluate(IntValL, "Actual Value");
                    end;
                    "Of Spec" := false;
                END;
                if "Data Type" <> "Data Type"::Alphanumeric then
                    case Symbol of
                        Symbol::"<":
                            case "Data Type" of
                                "Data Type"::Decimal:
                                    begin
                                        IF (Minimum <> 0) AND (Maximum <> 0) THEN BEGIN
                                            IF (DecValL < Minimum) OR (DecValL > Maximum) THEN begin
                                                ItemLedgerEntry.reset;
                                                ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                                ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                                ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                                ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                                //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                                //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                                IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                    ItemLedgerEntry."Of Spec" := TRUE;
                                                    ItemLedgerEntry.Modify;
                                                END;
                                            end else begin
                                                ItemLedgerEntry.reset;
                                                ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                                ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                                ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                                ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                                //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                                //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                                IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                    ItemLedgerEntry."Of Spec" := FALSE;
                                                    ItemLedgerEntry.Modify;
                                                END;
                                            end;
                                        END;

                                        IF (DecValL < Minimum) AND (maximum = 0) THEN BEGIN
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := TRUE;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;

                                        IF (DecValL > Minimum) AND (Maximum = 0) THEN BEGIN
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := false;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;

                                        IF (DecValL < Maximum) AND (Minimum = 0) THEN BEGIN
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := FALSE;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;

                                        IF (DecValL > Maximum) AND (Minimum = 0) THEN BEGIN
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := TRUE;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;
                                    end;
                                "Data Type"::Integer:
                                    begin
                                        IF (Minimum <> 0) AND (Maximum <> 0) THEN BEGIN
                                            IF (IntValL < Minimum) OR (IntValL > Maximum) THEN BEGIN
                                                ItemLedgerEntry.reset;
                                                ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                                ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                                ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                                ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                                //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                                //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                                IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                    ItemLedgerEntry."Of Spec" := TRUE;
                                                    ItemLedgerEntry.Modify;
                                                END;
                                            END else BEGIN
                                                ItemLedgerEntry.reset;
                                                ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                                ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                                ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                                ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                                //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                                //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                                IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                    ItemLedgerEntry."Of Spec" := TRUE;
                                                    ItemLedgerEntry.Modify;
                                                END;
                                            END;
                                        END;

                                        IF (IntValL < Minimum) AND (maximum = 0) THEN BEGIN
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := TRUE;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;

                                        IF (IntValL > Minimum) AND (Maximum = 0) THEN BEGIN
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := FALSE;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;

                                        IF (IntValL < Maximum) AND (Minimum = 0) THEN BEGIN
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := FALSE;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;

                                        IF (IntValL > Maximum) AND (Minimum = 0) THEN BEGIN
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := TRUE;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;
                                    end;
                            end;
                        Symbol::">":
                            case "Data Type" of
                                "Data Type"::Decimal:
                                    begin
                                        IF (Minimum <> 0) AND (Maximum <> 0) THEN BEGIN
                                            IF (DecValL < Minimum) OR (DecValL > Maximum) THEN BEGIN
                                                ItemLedgerEntry.reset;
                                                ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                                ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                                ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                                ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                                //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                                //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                                IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                    ItemLedgerEntry."Of Spec" := TRUE;
                                                    ItemLedgerEntry.Modify;
                                                END;
                                            END else BEGIN
                                                ItemLedgerEntry.reset;
                                                ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                                ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                                ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                                ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                                //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                                //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                                IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                    ItemLedgerEntry."Of Spec" := TRUE;
                                                    ItemLedgerEntry.Modify;
                                                END;
                                            END;
                                        END;

                                        IF (DecValL < Minimum) AND (maximum = 0) THEN BEGIN
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := TRUE;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;

                                        IF (DecValL > Minimum) AND (Maximum = 0) THEN BEGIN
                                            Validate("Of Spec", false);
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := FALSE;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;

                                        IF (DecValL < Maximum) AND (Minimum = 0) THEN BEGIN
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := FALSE;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;

                                        IF (DecValL > Maximum) AND (Minimum = 0) THEN BEGIN
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := TRUE;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;
                                    end;
                                "Data Type"::Integer:
                                    begin
                                        IF (Minimum <> 0) AND (Maximum <> 0) THEN BEGIN
                                            IF (IntValL < Minimum) OR (IntValL > Maximum) THEN BEGIN
                                                ItemLedgerEntry.reset;
                                                ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                                ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                                ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                                ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                                //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                                //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                                IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                    ItemLedgerEntry."Of Spec" := TRUE;
                                                    ItemLedgerEntry.Modify;
                                                END;
                                            END else BEGIN
                                                ItemLedgerEntry.reset;
                                                ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                                ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                                ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                                ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                                //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                                //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                                IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                    ItemLedgerEntry."Of Spec" := FALSE;
                                                    ItemLedgerEntry.Modify;
                                                END;
                                            END;
                                        END;

                                        IF (IntValL < Minimum) AND (maximum = 0) THEN BEGIN
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := TRUE;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;

                                        IF (IntValL > Minimum) AND (Maximum = 0) THEN BEGIN
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := false;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;

                                        IF (IntValL < Maximum) AND (Minimum = 0) THEN BEGIN
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := false;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;

                                        IF (IntValL > Maximum) AND (Minimum = 0) THEN BEGIN
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := TRUE;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;
                                    end;
                            end;
                        Symbol::" ":
                            case "Data Type" of
                                "Data Type"::Decimal:
                                    begin
                                        IF (Minimum <> 0) AND (Maximum <> 0) THEN BEGIN
                                            IF (DecValL < Minimum) OR (DecValL > Maximum) THEN BEGIN
                                                ItemLedgerEntry.reset;
                                                ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                                ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                                ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                                ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                                //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                                //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                                IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                    ItemLedgerEntry."Of Spec" := TRUE;
                                                    ItemLedgerEntry.Modify;
                                                END;
                                            END else BEGIN
                                                ItemLedgerEntry.reset;
                                                ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                                ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                                ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                                ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                                //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                                //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                                IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                    ItemLedgerEntry."Of Spec" := FALSE;
                                                    ItemLedgerEntry.Modify;
                                                END;
                                            END;
                                        END;

                                        IF (DecValL < Minimum) AND (maximum = 0) THEN BEGIN
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := TRUE;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;

                                        IF (DecValL > Minimum) AND (Maximum = 0) THEN BEGIN
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := FALSE;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;

                                        IF (DecValL < Maximum) AND (Minimum = 0) THEN BEGIN
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := FALSE;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;

                                        IF (DecValL > Maximum) AND (Minimum = 0) THEN BEGIN
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := TRUE;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;
                                    end;
                                "Data Type"::Integer:
                                    begin
                                        IF (Minimum <> 0) AND (Maximum <> 0) THEN BEGIN
                                            IF (IntValL < Minimum) OR (IntValL > Maximum) THEN BEGIN
                                                ItemLedgerEntry.reset;
                                                ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                                ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                                ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                                ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                                //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                                //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                                IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                    ItemLedgerEntry."Of Spec" := TRUE;
                                                    ItemLedgerEntry.Modify;
                                                END;
                                            END else BEGIN
                                                ItemLedgerEntry.reset;
                                                ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                                ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                                ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                                ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                                //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                                //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                                IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                    ItemLedgerEntry."Of Spec" := false;
                                                    ItemLedgerEntry.Modify;
                                                END;
                                            END;
                                        END;

                                        IF (IntValL < Minimum) AND (maximum = 0) THEN BEGIN
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := TRUE;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;

                                        IF (IntValL > Minimum) AND (Maximum = 0) THEN BEGIN
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := FALSE;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;

                                        IF (IntValL < Maximum) AND (Minimum = 0) THEN BEGIN
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := FALSE;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;

                                        IF (IntValL > Maximum) AND (Minimum = 0) THEN BEGIN
                                            ItemLedgerEntry.reset;
                                            ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                                            ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                                            ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                                            ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                                            //ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                                            //ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                                            IF ItemLedgerEntry.FindFirst THEN BEGIN
                                                ItemLedgerEntry."Of Spec" := TRUE;
                                                ItemLedgerEntry.Modify;
                                            END;
                                        END;
                                    end;
                            end;
                    end; //AJAY <<
            END;
        }
        field(26; "Data Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Data Type';
            OptionMembers = Alphanumeric,Decimal,Integer;
            OptionCaption = 'Alphanumeric,Decimal,Integer';
        }
        field(28; "Symbol"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Symbol';
            OptionMembers = " ",">","<";
        }
        field(29; "Of Spec"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Off-Spec';
            trigger OnValidate()
            var
                ItemLedgerEntry: Record "Item Ledger Entry"; //AJAY                          
            begin //AJAY >>
                ItemLedgerEntry.reset;
                ItemLedgerEntry.SetRange("Document No.", Rec."Source ID");
                ItemLedgerEntry.SetRange("Document Line No.", "Source Ref. No.");
                ItemLedgerEntry.SetRange("Item No.", Rec."Item No.");
                ItemLedgerEntry.SetRange("Variant Code", Rec."Variant Code");
                ItemLedgerEntry.SetRange(CustomLotNumber, Rec."Lot No.");
                ItemLedgerEntry.SetRange(CustomBOENumber, Rec."BOE No.");
                IF ItemLedgerEntry.FindFirst THEN
                    repeat
                        ItemLedgerEntry."Of Spec" := REC."Of Spec";
                        ItemLedgerEntry.Modify;
                    until ItemLedgerEntry.Next = 0;  //AJAY <<
            end;
        }
        field(30; Value2; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Alternate';
        }
        field(31; Priority; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Priority';
            MinValue = 0;
            trigger OnValidate()
            var
                ItemTestingParameterL: Record "Item Testing Parameter";
                PriorityDuplicateErr: Label 'Priority can''t be duplicated.';
            begin
                ItemTestingParameterL.SetRange("Item No.", "Item No.");
                ItemTestingParameterL.SetRange(Priority, Priority);
                ItemTestingParameterL.SetFilter(Code, '<>%1', Code);
                if not ItemTestingParameterL.IsEmpty then
                    Error(PriorityDuplicateErr);
            end;
        }
        field(32; "Show in COA"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Show in COA';
        }
        field(33; "Default Value"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Testing Parameter Code"; Text[100])//Datatype change Code[20] to Text[100]
        {
            FieldClass = FlowField;
            // CalcFormula = lookup("Testing Parameter"."Testing Parameter Code" where(Code = field(code)));
            CalcFormula = lookup("QC Parameters"."Method Description" where(Code = field(Code)));
            Editable = false;

        }
        field(35; "Variant Code"; Code[10]) //AJAY
        {
            DataClassification = CustomerContent;
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."));
        }

        //T51170-NS

        field(200; Type; Option)
        {
            OptionCaption = 'Text,Range,Minimum,Maximum';
            OptionMembers = Text,Range,Minimum,Maximum;
            Description = 'T51170';
            Editable = false;
        }
        field(201; Result; Option)
        {

            //16042025-OS
            // OptionCaption = ' ,Pass,Fail';
            // OptionMembers = " ",Pass,Fail;
            //16042025-OE

            //16042025-NS
            OptionCaption = 'NA,Pass,Fail';
            OptionMembers = "NA",Pass,Fail;
            //16042025-NE
            Description = 'T51170';
            //Editable = false;
        }
        field(202; "Vendor COA Value Result"; Decimal)
        {
            DataClassification = ToBeClassified;
            //DecimalPlaces = 3 : 3; //T51170-O
            DecimalPlaces = 0 : 5;   //T51170-N
            Description = 'T51170';
            //Editable = false;
            trigger OnValidate()
            begin

                if Type = Type::Range then begin
                    if ("Vendor COA Value Result" <> 0) then begin
                        if ("Vendor COA Value Result" < "Minimum") or ("Vendor COA Value Result" > "Maximum") then begin
                            if not Confirm(Text50003_gCtx, false) then begin
                                Error(Text50000_gCtx, "Minimum", "Maximum")
                            end else begin

                                Validate(Result, Result::Fail);
                            end;
                        end else begin

                            Validate(Result, Result::Pass);
                        end;
                    end;
                end else
                    if (Type = Type::Maximum) then begin
                        if ("Vendor COA Value Result" <> 0) then begin
                            if ("Vendor COA Value Result" > "Maximum") then begin
                                if not Confirm(Text50003_gCtx, false) then begin
                                    Error(Text50001_gCtx, "Maximum")
                                end else begin

                                    Validate(Result, Result::Fail);
                                end;
                            end else begin
                                //VALIDATE(Rejection,FALSE);
                                Validate(Result, Result::Pass);
                            end;
                        end;
                    end else
                        if (Type = Type::Minimum) then begin
                            if ("Vendor COA Value Result" <> 0) then begin
                                if ("Vendor COA Value Result" < "Minimum") then begin
                                    if not Confirm(Text50003_gCtx, false) then begin
                                        Error(Text50002_gCtx, "Minimum")
                                    end else begin
                                        //VALIDATE(Rejection,TRUE);
                                        Validate(Result, Result::Fail);
                                    end;
                                end else begin

                                    Validate(Result, Result::Pass);
                                end;
                            end;
                        end;
                //Hypercare-18-03-25-NE
                //T51170-NS               
                if "Rounding Precision" > 0 then
                    "Vendor COA Value Result" := QCGeneral_gCdu.RoundQCParameterPrecision(Code, "Vendor COA Value Result", "Rounding Precision");
                //T51170-NE

                Validate("Actual Value", format("Vendor COA Value Result"));//T51170-N

            end;

        }
        field(203; "Vendor COA Text Result"; Text[100])
        {
            DataClassification = ToBeClassified;
            Description = 'T51170';
            //Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Validate("Actual Value", "Vendor COA Text Result");//T51170-N
            end;
        }
        field(204; "Rounding Precision"; Decimal)
        {
            Caption = 'Rounding Precision';
            DecimalPlaces = 0 : 5;
            Description = 'T51170';
            Editable = false;

        }
        field(50002; "Decimal Places"; Integer)
        {
            DataClassification = ToBeClassified;
            MinValue = 0;
            Description = 'T52614';
            Editable = false;
        }

        //T51170-NE

    }

    keys
    {
        key(PK; "Source ID", "Source Ref. No.", "Item No.", "Variant Code", "Lot No.", "BOE No.", Code)
        {
            Clustered = true;
        }
        key(key2; Priority)
        {

        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure ILEUpdateOffSpec(ILE: Record "Item Ledger Entry"; OffSpec: Boolean)
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin  //AJAY >>
        ItemLedgerEntry.reset;
        ItemLedgerEntry.SetRange("Entry No.", ILE."Entry No.");
        IF ItemLedgerEntry.FindFirst THEN BEGIN
            ItemLedgerEntry."Of Spec" := OffSpec;
            ItemLedgerEntry.Modify;
        END;
    END; //AJAY <<

    procedure ILEUpdateOffSpec2(ILE: Record "Item Ledger Entry"; OffSpec: Boolean)
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin  //AJAY >>
        ItemLedgerEntry.reset;
        ItemLedgerEntry.SetRange("Entry No.", ILE."Entry No.");
        IF ItemLedgerEntry.FindFirst THEN BEGIN
            ItemLedgerEntry."Of Spec" := OffSpec;
            ItemLedgerEntry.Modify;
        END;
    END; //AJAY <<

    //T51170-NS

    var
        Text50000_gCtx: label 'Vendor COA Value must be in range of %1 to %2';
        Text50001_gCtx: label 'Vendor COA Value must be less than %1';
        Text50002_gCtx: label 'Vendor COA Value Result must be greater than %1';
        Text50003_gCtx: label 'Vendor COA Value is not within the defined parameters. \Do you still want to proceed?';
        QCGeneral_gCdu: Codeunit "Quality Control - General";
    //T51170-NE
}