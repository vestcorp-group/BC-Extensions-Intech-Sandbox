tableextension 50249 KMP_TblExtAssemblyHeader extends "Assembly Header"//T12370-Full Comment
{
    fields
    {
        // Add changes to table fields here
        field(50100; CustomBOENumber; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Custom BOE No.';
            trigger OnValidate()
            var
                ReservationEntryL: Record "Reservation Entry";
                CustomBOEFormatErr: Label 'Format of Custom BOE is xxx-xxxxxxxx-xx.\Max. allowed characters are 15 with "-" otherwise 13.';
            begin
                if (CustomBOENumber <> xRec.CustomBOENumber) then begin
                    IF (COPYSTR(CustomBOENumber, 4, 1) = '-') and (StrLen(CustomBOENumber) <> 15) THEN
                        Error(CustomBOEFormatErr);
                    if (COPYSTR(CustomBOENumber, 4, 1) <> '-') and (StrLen(CustomBOENumber) <> 13) THEN
                        error(CustomBOEFormatErr);
                    CustomBOENumber := FormatText(CustomBOENumber);
                    ReservationEntryL.SetRange("Source Type", Database::"Assembly Header");
                    ReservationEntryL.SetRange("Source ID", Rec."No.");
                    ReservationEntryL.ModifyAll(CustomBOENumber, CustomBOENumber);
                    // if ReservationEntryL.FindSet() then begin
                    //     repeat
                    //         if ReservationEntryL.CustomLotNumber > '' then begin
                    //             ReservationEntryL."Lot No." := ReservationEntryL.CustomLotNumber + '@' + ReservationEntryL.CustomBOENumber;
                    //             ReservationEntryL.Modify();
                    //         end;
                    //     until ReservationEntryL.Next() = 0;
                    // end;
                end;
            end;
        }
        field(50101; "Quantity to Order"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity to Order';
            DecimalPlaces = 0 : 5;
            trigger OnValidate()
            var
                VesselL: Record Vessel;
            begin
                TestField(Vessel);
                VesselL.Get(Vessel);
                //CalcFields("Quantity Ordered")PSP_02-01-2020;
                if "Quantity to Order" > VesselL.Quantity then
                    Error('The Quantity to Order can''t be greater then Vessel quantity.');
                if xRec."Quantity to Order" <> "Quantity to Order" then
                    if "Quantity to Order" > Quantity then
                        Error(QtyToOrderGrtErr, FieldCaption("Quantity to Order"), Quantity)
                    else
                        if ("Quantity to Order" > (Quantity - "Quantity Ordered")) then
                            Error(QtyToOrderGrtErr, FieldCaption("Quantity to Order"), (Quantity - "Quantity Ordered"));
            end;
        }
        field(50102; "Quantity Ordered"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity Ordered';
            DecimalPlaces = 0 : 5;
        }
        field(50103; "Blanket Assembly Order No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Blanket Assembly Order No.';
        }
        field(50104; Vessel; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vessel';
            TableRelation = Vessel;
            trigger OnValidate()
            var
                VesselL: Record Vessel;
            begin
                if VesselL.Get(Vessel) then
                    case "Document Type" of
                        "Document Type"::"Blanket Order":
                            begin
                                //CalcFields("Quantity Ordered")PSP_02-01-2020;
                                if VesselL.Quantity > (Quantity - "Quantity Ordered") then
                                    Validate("Quantity to Order", Quantity - "Quantity Ordered")
                                else
                                    Validate("Quantity to Order", VesselL.Quantity);
                            end;
                        "Document Type"::Order:
                            Validate(Quantity, VesselL.Quantity);
                    end
                else
                    Validate(Quantity, 0);
            end;
        }
        modify(Quantity)
        {
            trigger OnBeforeValidate()
            var
                VesselL: Record Vessel;
                AssemblyHeaderRec: Record "Assembly Header";
                NotSufficientQtyErr: Label 'There is no sufficient quantity left in blanket assembly order %2. Please increase the quantity in blanket assembly order and try again!!';
            begin
                if "Document Type" = "Document Type"::Order then
                    if Quantity > 0 then begin
                        TestField(Vessel);
                        VesselL.Get(Vessel);
                        if Quantity > VesselL.Quantity then
                            Error('The Quantity can''t be greater then Vessel quantity.');
                        if AssemblyHeaderRec.Get(Rec."Document Type"::"Blanket Order", Rec."Blanket Assembly Order No.") then begin
                            AssemblyHeaderRec."Quantity Ordered" += (Rec.Quantity - xRec.Quantity);
                            if AssemblyHeaderRec."Quantity Ordered" > AssemblyHeaderRec.Quantity then
                                Error(NotSufficientQtyErr, (AssemblyHeaderRec.Quantity - AssemblyHeaderRec."Quantity Ordered"), AssemblyHeaderRec."No.");
                            AssemblyHeaderRec.Modify();
                            Commit();
                        end;
                    end;

            end;
        }
        modify("Item No.")
        {
            trigger OnBeforeValidate()
            var
                myInt: Integer;
            begin
                If ("Document Type" = "Document Type"::"Blanket Order") and ("No." = '') then
                    InitRecord();
            end;
        }
        modify("Starting Date")
        {
            trigger OnBeforeValidate()
            begin
                PostingDate := "Posting Date";
                DueDate := "Due Date";
                EndingDate := "Ending Date";
            end;

            trigger OnAfterValidate()
            begin
                "Posting Date" := PostingDate;
                "Due Date" := DueDate;
                "Ending Date" := EndingDate;
            end;
        }
        modify("Ending Date")
        {
            trigger OnBeforeValidate()
            begin
                PostingDate := "Posting Date";
                DueDate := "Due Date";
                StartingDate := "Starting Date";
            end;

            trigger OnAfterValidate()
            begin
                "Posting Date" := PostingDate;
                "Due Date" := DueDate;
                "Starting Date" := StartingDate;
            end;
        }
        modify("Due Date")
        {
            trigger OnBeforeValidate()
            begin
                PostingDate := "Posting Date";
                StartingDate := "Starting Date";
                EndingDate := "Ending Date";
            end;

            trigger OnAfterValidate()
            begin
                "Posting Date" := PostingDate;
                "Starting Date" := StartingDate;
                "Ending Date" := EndingDate;
            end;
        }

    }

    trigger OnInsert()
    begin
        "Starting Date" := "Posting Date";
        "Ending Date" := "Posting Date";
    end;


    procedure FormatText(TextP: Text[20]): Text
    var
        NewTextL: Text[20];
    begin
        IF COPYSTR(TextP, 4, 1) <> '-' THEN BEGIN
            NewTextL := COPYSTR(TextP, 1, 3);
            NewTextL += '-';
            NewTextL += COPYSTR(TextP, 4, 8);
            NewTextL += '-';
            NewTextL += COPYSTR(TextP, 12, MaxStrLen(TextP) - 13);
            EXIT(NewTextL);
        END ELSE
            NewTextL := TextP;
    end;

    [Scope('Cloud')]
    procedure ShowDimensionsDuplicate()
    var
        OldDimSetId: Integer;
        DimMgt: Codeunit DimensionManagement;
    begin
        OldDimSetId := "Dimension Set ID";
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
            "Dimension Set ID", STRSUBSTNO('%1 %2', "Document Type", "No."),
            "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
        IF OldDimSetId <> "Dimension Set ID" THEN BEGIN
            // SetCurrentFieldNum(FIELDNO("Dimension Set ID"));
            AssemblyLineMgt.UpdateAssemblyLines(Rec, xRec, FIELDNO("Dimension Set ID"), FALSE, CurrFieldNo, FIELDNO("Dimension Set ID"));
            // ClearCurrentFieldNum(FIELDNO("Dimension Set ID"));
            MODIFY(TRUE);
        END;
    end;

    [Scope('Cloud')]
    procedure RefreshBOMDuplicate()
    var
        myInt: Integer;
    begin
        AssemblyLineMgt.UpdateAssemblyLines(Rec, xRec, 0, TRUE, CurrFieldNo, 0);
    end;

    [Scope('Cloud')]
    procedure ShowAvailabilityDuplicate()
    var
        TempAssemblyHeader: Record "Assembly Header";
        TempAssemblyLine: Record "Assembly Line";
    begin
        AssemblyLineMgt.CopyAssemblyData(Rec, TempAssemblyHeader, TempAssemblyLine);
        AssemblyLineMgt.ShowAvailability(TRUE, TempAssemblyHeader, TempAssemblyLine);

    end;

    var
        AssemblyLineMgt: Codeunit "Assembly Line Management";
        QtyToOrderGrtErr: Label 'You can''t enter %1 more than %2';
        PostingDate: Date;
        DueDate: Date;
        StartingDate: Date;
        EndingDate: Date;
}