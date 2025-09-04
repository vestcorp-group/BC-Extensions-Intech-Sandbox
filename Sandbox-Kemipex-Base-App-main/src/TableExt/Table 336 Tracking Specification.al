tableextension 50103 KMP_TblExtItemTrackingLine extends "Tracking Specification"//T12370-N
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
                myInt: Integer;
            begin
                if (CustomBOENumber <> xRec.CustomBOENumber) and (CustomBOENumber <> '') then begin
                    IF (COPYSTR(CustomBOENumber, 4, 1) = '-') and (StrLen(CustomBOENumber) <> 15) THEN
                        Error(CustomBOEFormatErr);
                    if (COPYSTR(CustomBOENumber, 4, 1) <> '-') and (StrLen(CustomBOENumber) <> 13) THEN
                        error(CustomBOEFormatErr);
                    CustomBOENumber := FormatBOEText(CustomBOENumber);
                    "Lot No." := CustomLotNumber + '@' + CustomBOENumber;
                end;
            end;
        }
        field(50101; CustomBOENumber2; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Custom BOE No. 2';
        }
        field(50102; CustomLotNumber; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Lot No.';
            trigger OnValidate()
            var
                PurchaseHdrL: Record "Purchase Header";
                TransferHdrL: Record "Transfer Header";
                ItemJournalL: Record "Item Journal Line";
                SalesHdrL: Record "Sales Header";
                ItemLedgEntryL: Record "Item Ledger Entry";
                TransferLineL: Record "Transfer Line";
            begin
                if (CustomLotNumber <> xRec.CustomLotNumber) and (xRec.CustomLotNumber > '') then begin  //T12370_MIG
                    case true of
                        PurchaseHdrL.Get(PurchaseHdrL."Document Type"::Order, "Source ID"):
                            CustomBOENumber := PurchaseHdrL.CustomBOENumber;
                        SalesHdrL.Get(SalesHdrL."Document Type"::"Return Order", "Source ID"):
                            CustomBOENumber := SalesHdrL.CustomBOENumber;
                        TransferHdrL.Get("Source ID"),
                        PurchaseHdrL.Get(PurchaseHdrL."Document Type"::"Return Order", "Source ID"),
                        SalesHdrL.Get(SalesHdrL."Document Type"::Order, "Source ID"):
                            begin
                                ItemLedgEntryL.RESET;
                                ItemLedgEntryL.SETCURRENTKEY("Item No.", Open, "Variant Code", "Location Code", "Item Tracking", "Lot No.", "Serial No.");
                                ItemLedgEntryL.SETRANGE("Item No.", "Item No.");
                                ItemLedgEntryL.SETRANGE("Variant Code", "Variant Code");
                                ItemLedgEntryL.SETRANGE(Open, true);
                                ItemLedgEntryL.SETRANGE("Location Code", "Location Code");
                                ItemLedgEntryL.SETRANGE("Lot No.", "Lot No.");
                                if ItemLedgEntryL.FindFirst() then
                                    CustomBOENumber := ItemLedgEntryL.CustomBOENumber;
                            end;
                        (StrLen(Rec."Source ID") <= 10):
                            If ItemJournalL.Get("Source ID", "Source Batch Name", "Source Ref. No.") then begin
                                if ItemJournalL.IsReclass(ItemJournalL) then begin
                                    CustomBOENumber := ItemJournalL.CustomBOENumber;
                                    "New Custom Lot No." := CustomLotNumber;
                                    "New Custom BOE No." := CustomBOENumber;
                                end;
                            end;
                    end;
                    if CustomLotNumber = '' then
                        CustomLotNumber := "Lot No.";
                    if ("Lot No." <> (CustomLotNumber + '@' + CustomBOENumber)) and (CustomBOENumber > '') then
                        "Lot No." := CustomLotNumber + '@' + CustomBOENumber;
                end else
                    Validate("Lot No.", CustomLotNumber);
            end;
        }
        field(50103; "New Custom BOE No."; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'New BOE No.';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "New Custom BOE No." > '' then begin
                    IF (COPYSTR("New Custom BOE No.", 4, 1) = '-') and (StrLen("New Custom BOE No.") <> 15) THEN
                        Error(CustomBOEFormatErr);
                    if (COPYSTR("New Custom BOE No.", 4, 1) <> '-') and (StrLen("New Custom BOE No.") <> 13) THEN
                        error(CustomBOEFormatErr);
                    "New Custom BOE No." := FormatBOEText("New Custom BOE No.");
                    validate("New Lot No.", "New Custom Lot No." + '@' + "New Custom BOE No.");
                end else
                    validate("New Lot No.", "New Custom Lot No.");
            end;
        }
        field(50104; "New Custom Lot No."; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'New Lot No.';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "New Custom BOE No." > '' then  //T12370_MIG
                    validate("New Lot No.", "New Custom Lot No." + '@' + "New Custom BOE No.")
                else
                    validate("New Lot No.", "New Custom Lot No.");
            end;
        }
        field(50105; "Of Spec"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Off-Spec';
            Description = 'Created for COA Process';
        }
        field(50106; "Analysis Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Analysis Date';
            Description = 'Created for COA Process';
        }

        //Moved from PDCnOthers Extension
        field(50107; "Supplier Batch No. 2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "Manufacturing Date 2"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                //T12968-NS
                if "Manufacturing Date 2" <> 0D then
                    "Warranty Date" := "Manufacturing Date 2";
                //T12968-NE
                //Moved from Kemipex Business App
                if FORMAT("Expiry Period 2") = '' then  //T12370_MIG
                    exit
                else
                    "Expiration Date" := CalcDate("Expiry Period 2", "Manufacturing Date 2");

            end;
        }
        field(50109; "Expiry Period 2"; DateFormula)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
                TempDT: Date;
                DF: Text[10];
            begin
                //Moved from Kemipex Business App
                DF := '-1D';  //T12370_MIG
                              //DF := DF - 1D;
                if "Manufacturing Date 2" = 0D then
                    Error('Manufacturing Date Required')
                else
                    TempDT := CalcDate("Expiry Period 2", "Manufacturing Date 2");
                "Expiration Date" := CalcDate(DF, TempDT);
            end;
        }
        field(50110; "Gross Weight 2"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50111; "Net Weight 2"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50125; "Group GRN Date"; Date)
        {
            DataClassification = ToBeClassified;
            Description = 'Hypercare 06-03-2025';
        }

        //Moved from Kemipex Business App
        modify("Expiration Date")  //T12370_MIG
        {
            trigger OnAfterValidate()
            var
                expD: date;
            begin
                if "Manufacturing Date 2" = 0D then Error('Manufacturing Date Required');
                if FORMAT("Expiry Period 2") = '' then Error('Expiry Period Required');
                expD := CalcDate("Expiry Period 2", "Manufacturing Date 2");
                if expD <> "Expiration Date" then Error('Expiry Calculation does not match with Expiry date');
            end;
        }

    }
    procedure FormatBOEText(TextP: Text[20]): Text
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
        CustomBOEFormatErr: Label 'Format of Custom BOE is xxx-xxxxxxxx-xx.\Max. allowed characters are 15 with "-" otherwise 13.';
}