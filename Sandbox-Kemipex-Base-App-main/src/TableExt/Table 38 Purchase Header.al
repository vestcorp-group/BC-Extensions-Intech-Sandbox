tableextension 50101 KMP_TblExtPurchaseOrder extends "Purchase Header"
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
                PurchaseLineL: Record "Purchase Line";
                ReservationEntryL: Record "Reservation Entry";
                CustomBOEFormatErr: Label 'Format of Custom BOE is xxx-xxxxxxxx-xx.\Max. allowed characters are 15 with "-" otherwise 13.';
            begin

                if (CustomBOENumber <> xRec.CustomBOENumber) then begin
                    if ("Purchase Type" = "Purchase Type"::BOE) and (CustomBOENumber > '') then begin
                        IF (COPYSTR(CustomBOENumber, 4, 1) = '-') and (StrLen(CustomBOENumber) <> 15) THEN
                            Error(CustomBOEFormatErr);
                        if (COPYSTR(CustomBOENumber, 4, 1) <> '-') and (StrLen(CustomBOENumber) <> 13) THEN
                            error(CustomBOEFormatErr);
                        CustomBOENumber := FormatText(CustomBOENumber);
                    end;
                    PurchaseLineL.SetRange("Document Type", "Document Type");
                    PurchaseLineL.SetRange("Document No.", "No.");
                    PurchaseLineL.ModifyAll(CustomBOENumber, CustomBOENumber);
                    ReservationEntryL.SetSourceFilter(PurchaseLineL.RecordId().TableNo(), Rec."Document Type".AsInteger(), Rec."No.", -1, false);//30-04-2022-added asinteger with enum
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
            end;
        }
        field(50101; "Short Close"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Short Close';
        }
        field(50102; "Purchase Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Type';
            // OptionMembers = BOE,LGP,LOCAL;
            // OptionCaption = 'BOE,LGP,LOCAL';
            OptionMembers = BOE,LGP,DIRECT; // 12-12-2024 UAT Changes YT
            OptionCaption = 'BOE,LGP,DIRECT';//12-12-2024 UAT Changes YT
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                case "Purchase Type" of
                    "Purchase Type"::BOE:
                        Validate(CustomBOENumber, '');
                    "Purchase Type"::LGP:
                        Validate(CustomBOENumber, 'LGP');
                    // "Purchase Type"::LOCAL:
                    //     Validate(CustomBOENumber, 'LOCAL');
                    "Purchase Type"::DIRECT://12-12-2024 UAT Changes YT
                        Validate(CustomBOENumber, 'DIRECT');//12-12-2024 UAT Changes YT
                end;
            end;
        }
        // Start Issue - 59
        field(50103; "Supplier Invoice Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Supplier Invoice Date';
        }
        // Stop Issue - 59

        //ISPl-IC-Dev-RM&MC
        //T13919-NS
        field(50110; "IC Transaction No."; Integer)
        {

        }
        //T13919-NE
        //ISPl-IC-Dev-RM&MC
    }

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
        END ELSE
            NewTextL := TextP;
        EXIT(NewTextL);
    end;

    var
        myInt: Integer;



}