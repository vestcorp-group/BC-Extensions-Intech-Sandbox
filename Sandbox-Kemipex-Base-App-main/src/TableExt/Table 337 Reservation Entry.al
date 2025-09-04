tableextension 50311 KMP_TabExtReservationEntry extends "Reservation Entry"
{
    fields
    {
        field(50100; CustomBOENumber; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Custom BOE No.';
        }
        field(50102; CustomLotNumber; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Lot No.';
        }
        field(50103; "New Custom BOE No."; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'New BOE No.';
        }
        field(50104; "New Custom Lot No."; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'New Lot No.';
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
        }
        field(50109; "Expiry Period 2"; DateFormula)
        {
            DataClassification = ToBeClassified;
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

    }
}