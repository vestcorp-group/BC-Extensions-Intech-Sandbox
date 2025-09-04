table 50502 "Lot Testing Parameter"
{
    DataClassification = CustomerContent;

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
            //  TableRelation = "Item Testing Parameter"."Code" where("Item No." = field("Item No."));
            // trigger OnValidate()
            // var
            //     ItemTestingParameterL: Record "Item Testing Parameter";
            // begin
            //     if ItemTestingParameterL.Get("Item No.", Code) then begin
            //         "Testing Parameter" := ItemTestingParameterL."Testing Parameter";
            //         Minimum := ItemTestingParameterL.Minimum;
            //         Maximum := ItemTestingParameterL.Maximum;
            //         Value2 := ItemTestingParameterL.Value2;
            //         "Data Type" := ItemTestingParameterL."Data Type";
            //         Symbol := ItemTestingParameterL.Symbol;
            //     end;
            // end;
        }
        field(21; "Testing Parameter"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Testing Parameter';
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
            DecimalPlaces = 0 : 5; // B
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
            Editable = false;
            trigger OnValidate()
            var
                IntValL: Integer;
                DecValL: Decimal;
                ExceedingValueMsg: Label 'The actual value is exceeding the maximum value';
                LesserValueMsg: Label 'The actual value is lesser than the minimum value';
            begin
                case "Data Type" of
                    "Data Type"::Decimal:
                        Evaluate(DecValL, "Actual Value");
                    "Data Type"::Integer:
                        Evaluate(IntValL, "Actual Value");
                end;
                "Of Spec" := false;
                if "Data Type" <> "Data Type"::Alphanumeric then
                    case Symbol of
                        Symbol::"<":
                            case "Data Type" of
                                "Data Type"::Decimal:
                                    if (DecValL > Maximum) and (Minimum <> 0) then begin
                                        Validate("Of Spec", true);
                                        // "Of Spec" := true;
                                        // Message(ExceedingValueMsg);
                                    end;
                                "Data Type"::Integer:
                                    if (IntValL > Maximum) and (Minimum <> 0) then begin
                                        Validate("Of Spec", true);
                                        // Message(ExceedingValueMsg);
                                    end;
                            end;
                        Symbol::">":
                            case "Data Type" of
                                "Data Type"::Decimal:
                                    if (DecValL < Minimum) and (Minimum <> 0) then begin
                                        Validate("Of Spec", true);
                                        // Message(LesserValueMsg);
                                    end;
                                "Data Type"::Integer:
                                    if (IntValL < Minimum) and (Minimum <> 0) then begin
                                        Validate("Of Spec", true);
                                        // Message(LesserValueMsg);
                                    end;
                            end;
                        Symbol::" ":
                            case "Data Type" of
                                "Data Type"::Decimal:
                                    begin
                                        if (DecValL < Minimum) and (Maximum <> 0) then begin
                                            Validate("Of Spec", true);
                                            // Message(LesserValueMsg);
                                        end;
                                        if (DecValL > Maximum) and (Maximum <> 0) then begin
                                            Validate("Of Spec", true);
                                            // Message(ExceedingValueMsg);
                                        end;
                                    end;
                                "Data Type"::Integer:
                                    begin
                                        if (IntValL < Minimum) and (Minimum <> 0) then begin
                                            Validate("Of Spec", true);
                                            // Message(LesserValueMsg);
                                        end;
                                        if (IntValL > Maximum) and (Maximum <> 0) then begin
                                            Validate("Of Spec", true);
                                            // Message(ExceedingValueMsg);
                                        end;
                                    end;
                            end;
                    end;
            end;
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
                ReservationentryRec: Record "Reservation Entry";
            begin
                // ReservationentryRec.SetRange("Source ID", "Source ID");
                // ReservationentryRec.SetRange("Source Ref. No.", "Source Ref. No.");
                // ReservationentryRec.SetRange(CustomLotNumber, "Lot No.");
                // ReservationentryRec.SetRange(CustomBOENumber, "BOE No.");
                // ReservationentryRec.SetRange("Item No.", "Item No.");
                // if ReservationentryRec.FindFirst() then begin
                //     ReservationentryRec."Of Spec" := "Of Spec";
                //     if ReservationentryRec.Modify() then;
                // end;

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
        field(34; "Testing Parameter Code"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("QC Parameters"."Method Description" where(Code = field(code))); //T51170-N
            Editable = false;

        }
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
    }

    keys
    {
        key(PK; "Source ID", "Source Ref. No.", "Item No.", "Lot No.", "BOE No.", Code)
        {
            Clustered = true;
        }
        key(key2; Priority)
        {

        }
    }

    //T51170-NS
    var
        Text50000_gCtx: label 'Vendor COA Value must be in range of %1 to %2';
        Text50001_gCtx: label 'Vendor COA Value must be less than %1';
        Text50002_gCtx: label 'Vendor COA Value Result must be greater than %1';
        Text50003_gCtx: label 'Vendor COA Value is not within the defined parameters. \Do you still want to proceed?';
        QCGeneral_gCdu: Codeunit "Quality Control - General";
    //T51170-NE

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

}



//  field(25; "Actual Value"; Text[100])
//         {
//             DataClassification = CustomerContent;
//             Caption = 'Actual Value';
//             trigger OnValidate()
//             var
//                 IntValL: Integer;
//                 DecValL: Decimal;
//                 ExceedingValueMsg: Label 'The actual value is exceeding the maximum value';
//                 LesserValueMsg: Label 'The actual value is lesser than the minimum value';
//             begin
//                 case "Data Type" of
//                     "Data Type"::Decimal:
//                         Evaluate(DecValL, "Actual Value");
//                     "Data Type"::Integer:
//                         Evaluate(IntValL, "Actual Value");
//                 end;
//                 "Of Spec" := false;
//                 if "Data Type" <> "Data Type"::Alphanumeric then
//                     case Symbol of
//                         Symbol::"<":
//                             case "Data Type" of
//                                 "Data Type"::Decimal:
//                                     if (DecValL > Maximum) and (Maximum <> 0) then begin
//                                         Validate("Of Spec", true);
//                                         // "Of Spec" := true;
//                                         // Message(ExceedingValueMsg);
//                                     end;
//                                 "Data Type"::Integer:
//                                     if (IntValL > Maximum) and (Maximum <> 0) then begin
//                                         Validate("Of Spec", true);
//                                         // Message(ExceedingValueMsg);
//                                     end;
//                             end;
//                         Symbol::">":
//                             case "Data Type" of
//                                 "Data Type"::Decimal:
//                                     if (DecValL < Minimum) and (Minimum <> 0) then begin
//                                         Validate("Of Spec", true);
//                                         // Message(LesserValueMsg);
//                                     end;
//                                 "Data Type"::Integer:
//                                     if (IntValL < Minimum) and (Minimum <> 0) then begin
//                                         Validate("Of Spec", true);
//                                         // Message(LesserValueMsg);
//                                     end;
//                             end;
//                         Symbol::" ":
//                             case "Data Type" of
//                                 "Data Type"::Decimal:
//                                     begin
//                                         if (DecValL < Minimum) and (Minimum <> 0) then begin
//                                             Validate("Of Spec", true);
//                                             Message(LesserValueMsg);
//                                         end;
//                                         if (DecValL > Maximum) and (Maximum <> 0) then begin
//                                             Validate("Of Spec", true);
//                                             // Message(ExceedingValueMsg);
//                                         end;
//                                     end;
//                                 "Data Type"::Integer:
//                                     begin
//                                         if (IntValL < Minimum) and (Minimum <> 0) then begin
//                                             Validate("Of Spec", true);
//                                             Message(LesserValueMsg);
//                                         end;
//                                         if (IntValL > Maximum) and (Maximum <> 0) then begin
//                                             Validate("Of Spec", true);
//                                             // Message(ExceedingValueMsg);
//                                         end;
//                                     end;
//                             end;
//                     end;
//             end;
//         }