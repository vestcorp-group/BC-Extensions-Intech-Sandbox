
tableextension 50305 "KMP_TabExtSalesHeader" extends "Sales Header"//T12370-N //T-12855
{
    fields
    {
        field(50100; CustomBOENumber; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Custom BOE No.';
            trigger OnValidate()
            var
                SalesLineL: Record "Sales Line";
                //Hypercare 26-02-2025-NS
                ReservationEntryL: Record "Reservation Entry";
                CustomBOEFormatErr: Label 'Format of Custom BOE is xxx-xxxxxxxx-xx.\Max. allowed characters are 15 with "-" otherwise 13.';
            //Hypercare 26-02-2025-NE
            begin
                /* SalesLineL.SetRange("Document Type", "Document Type");
                SalesLineL.SetRange("Document No.", "No.");
                SalesLineL.ModifyAll(CustomBOENumber, CustomBOENumber); */
                //Hypercare 26-02-2025-NS
                if (CustomBOENumber <> xRec.CustomBOENumber) and ("Document Type" = "Document Type"::"Return Order") then begin
                    if ("Sales Type" = "Sales Type"::BOE) and (CustomBOENumber > '') then begin
                        IF (COPYSTR(CustomBOENumber, 4, 1) = '-') and (StrLen(CustomBOENumber) <> 15) THEN
                            Error(CustomBOEFormatErr);
                        if (COPYSTR(CustomBOENumber, 4, 1) <> '-') and (StrLen(CustomBOENumber) <> 13) THEN
                            error(CustomBOEFormatErr);
                        CustomBOENumber := FormatText(CustomBOENumber);
                    end;
                    SalesLineL.SetRange("Document Type", "Document Type");
                    SalesLineL.SetRange("Document No.", "No.");
                    SalesLineL.ModifyAll(CustomBOENumber, CustomBOENumber);
                    ReservationEntryL.SetSourceFilter(SalesLineL.RecordId().TableNo(), Rec."Document Type".AsInteger(), Rec."No.", -1, false);//added asinteger with enum
                    if ReservationEntryL.FindSet() then
                        repeat
                            ReservationEntryL.CustomBOENumber := CustomBOENumber;
                            if (ReservationEntryL.CustomBOENumber > '') and (ReservationEntryL.CustomLotNumber > '') then
                                ReservationEntryL."Lot No." := ReservationEntryL.CustomLotNumber + '@' + ReservationEntryL.CustomBOENumber
                            else
                                ReservationEntryL."Lot No." := ReservationEntryL.CustomLotNumber;
                            ReservationEntryL.Modify();
                        until ReservationEntryL.Next() = 0;
                end;
                //Hypercare 26-02-2025-NE
            end;
        }

        field(50103; BillOfExit; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill Of Exit';
            trigger OnValidate()
            var
                CustomBOEFormatErr: Label 'Format of Bill of Exit is xxx-xxxxxxxx-xx.\Max. allowed characters are 15 with "-" otherwise 13.';
            begin
                IF (COPYSTR(BillOfExit, 4, 1) = '-') and (StrLen(BillOfExit) <> 15) THEN
                    Error(CustomBOEFormatErr);
                if (COPYSTR(BillOfExit, 4, 1) <> '-') and (StrLen(BillOfExit) <> 13) THEN
                    error(CustomBOEFormatErr);
                BillOfExit := FormatText(BillOfExit);
            end;
        }

        field(50104; CountryOfLoading; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
            Caption = 'Country Of Loading';
        }
        field(50105; "Short Close"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Short Close';
        }
        field(50101; "Blanket Sales order No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Blanket Sales Order No.';
        }
        // field(50102; "Skip payment term validation"; Boolean)
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Skip payment term validation';
        // }
        field(50106; "Maximum Allowed Due days"; DateFormula)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Maximum Allowed Due Days';
        }
        field(50011; "Seller/Buyer 2"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        // Moved from Packing list Extension 
        field(50012; "Bank on Invoice 2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Account"; //T-12855
        }
        field(50013; "Inspection Required 2"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Legalization Required 2"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "LC No. 2"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "LC Date 2"; Date)
        {
            DataClassification = ToBeClassified;
        }
        //T12370-Full Comment-NS
        // field(50017; "Customer Group Code"; Code[20])
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = lookup(Customer."Customer Group Code" where("No." = field("Bill-to Customer No.")));
        // }
        // field(50018; "Customer Group Code 2"; Code[200])
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = lookup(Customer."Customer Group Code 2" where("No." = field("Bill-to Customer No.")));
        // }
        // field(50019; "Reopen Status"; Enum SalesReopenStatus)
        // {
        //     DataClassification = ToBeClassified;
        // }
        //T12370-Full Comment-NE

        //T13919-NS
        field(50017; "IC Transaction No."; Integer)
        {

        }
        //T13919-NE
        //Hypercare 26-02-2025-NS
        field(50210; "Sales Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Type';
            OptionMembers = BOE,LGP,DIRECT;
            OptionCaption = 'BOE,LGP,DIRECT';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                case "Sales Type" of
                    "Sales Type"::BOE:
                        Validate(CustomBOENumber, '');
                    "Sales Type"::LGP:
                        Validate(CustomBOENumber, 'LGP');
                    "Sales Type"::DIRECT:
                        Validate(CustomBOENumber, 'DIRECT');
                end;
            end;
        }
        //Hypercare 26-02-2025-NE
    }

    //T13876-OS
    // local procedure FormatText(TextP: Text[30]): Text
    // var
    //     NewTextL: Text[30];
    // begin
    //     IF COPYSTR(TextP, 4, 1) <> '-' THEN BEGIN
    //         NewTextL := COPYSTR(TextP, 1, 3);
    //         NewTextL += '-';
    //         NewTextL += COPYSTR(TextP, 4, 8);
    //         NewTextL += '-';
    //         NewTextL += COPYSTR(TextP, 12, MaxStrLen(TextP));
    //         EXIT(NewTextL);
    //     END ELSE
    //         NewTextL := TextP;
    // end;
    //T13876-OE

    //T13876-NS
    local procedure FormatText(TextP: Text[20]): Text
    var
        NewTextL: Text[20];
    begin
        IF COPYSTR(TextP, 4, 1) <> '-' THEN BEGIN
            NewTextL := COPYSTR(TextP, 1, 3);
            NewTextL += '-';
            NewTextL += COPYSTR(TextP, 4, 8);
            NewTextL += '-';
            NewTextL += COPYSTR(TextP, 12, MaxStrLen(TextP) - 13);
        END ELSE
            NewTextL := TextP;
        EXIT(NewTextL);
    end;
    //T13876-NE
}